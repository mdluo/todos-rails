# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	# Load dada
	$.getJSON "todos/all", (data) ->
		loadAll data	
	
	# Load all data
	loadAll = (data) ->
		comCount = uncomCount = 0
		for todo in data
			$('#todo-list').append getElem todo
			comCount += 1 if todo.completed
		updateCount comCount, data.length-comCount
	
	# Add data
	new_todo = $('#new-todo')
	new_todo.keydown (e) ->
		if e.which is 13 and new_todo.val()
			$.post "todos/create", {task:new_todo.val(), completed:false}, (data) ->
				new_todo.val ""
				$('#todo-list').append getElem data
				updateCount 0, 1
	
	# Delete data
	deleteTodo = (id) ->
		$.post "todos/delete", {id:id}, (data) ->
			$('#todo-list > li').remove "li[data-id=#{data.id}]"
			if data.completed
				updateCount -1, 0
			else
				updateCount 0, -1
	
	# Toggle data
	toggleTodo = (id) ->
		$.post "todos/update", {id:id}, (data) ->
			$('#todo-list > li[data-id='+data.id+']').replaceWith getElem(data)
			if data.completed
				updateCount 1, -1
			else
				updateCount -1, 1
	
	# Toggle all data
	$('#toggle-all').click () ->
		$.post "todos/toggle", {completed:!$('#toggle-all').prop("checked")}, (data) ->
			clearAll()
			loadAll data
	
	$('#clear-completed').click () ->
		$.post "todos/delete", {id:-1}, (data) ->
			clearAll()
			loadAll data
	
	# Clear all data
	clearAll  = () ->
		$('#todo-list').empty()
		$(".comCount").text 0
		$(".uncomCount").text 0
			
	# Update count
	updateCount = (com, uncom) ->
		comCount = parseInt($(".comCount").text())+com
		uncomCount = parseInt($(".uncomCount").text())+uncom
		$(".comCount").text comCount
		$(".uncomCount").text uncomCount
		if comCount is 0
			$('#clear-completed').hide()
		else
			$('#clear-completed').show()
		if uncomCount is 0
			$('#toggle-all').prop "checked", false
		else
			$('#toggle-all').prop "checked", true
	
	# Get element of a todo
	getElem = (todo) ->
		html = """<li data-id="#{todo.id}"><div class="view">"""
		if todo.completed
			html +="""<input class="toggle" type="checkbox" checked="checked" value="#{todo.timestamps}" data-id="#{todo.id}" status="#{todo.completed}"><s><label style="color: #a9a9a9;  text-decoration: line-through;">#{todo.task}</label></s>"""
		else
			html +="""<input class="toggle" type="checkbox" value="#{todo.timestamps}" data-id="#{todo.id}" status="#{todo.completed}"><label>#{todo.task}</label>"""
		html += """<button class="destroy" data-id="#{todo.id}"></button></div><!-- <input class="edit" value="{{todo.title}}"> --></li>"""
		
		todoJQuery = $(html)
		todoJQuery.delegate ".destroy", "click", () ->
			deleteTodo $(this).attr "data-id"
		todoJQuery.delegate "input[type='checkbox']", "click", () ->
			toggleTodo $(this).attr "data-id"
