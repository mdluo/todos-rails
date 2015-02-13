Todos
=====

Todolist App for Ruby on Rails


### Live demo
http://todos.nsmss.com/


### Requirement
- Git
- Ruby
- Rails


### Deployment

##### Clone this repository:
```bash
git clone https://github.com/mdluo/todos.git
```

##### And go into the directory:
```bash
cd todos
```

##### Install bundle:
```bash
bundle install
```

##### Then run the migration:
```bash
rake db:migrate
```

##### One more thing, start the server:
```bash
rails server
```

##### Done! Go to http://127.0.0.1:3000


### API Document

##### Session name: 

  `_todos_session`

  The session must included in the header of every requests.

##### Get all todos for current user:

  `GET 'http://host/todos/all'`
  
  Response JSON data sample:

  ```json
  [{"id":1,"task":"Task Title 01","completed":true},{"id":2,"task":"Task Title 2","completed":false}]
  ```

##### Create a new todo for current user:

  `POST 'http://host/todos/create'`

  New todo request JSON data sample:

  ```json
  {"task":"New Todo Title"}
  ```

  New todo response JSON data sample:

  ```json
  {"id":1,"task":"New Todo Title","completed":false}
  ```

##### Update the status of a todo:

  `POST 'http://host/todos/update'`
  
  Update todo request JSON data sample:

  ```json
  {"id":1}
  ```

  Update todo response JSON data sample:

  ```json
  {"id":1,"task":"New Todo Title","completed":true}
  ```
  
##### Delete a todo:

  `POST 'http://host/todos/delete'`
  
  Delete todo request JSON data sample:

  ```json
  {"id":1}
  ```

  Delete todo response JSON data sample:

  ```json
  {"id":1,"task":"New Todo Title","completed":true}
  ```

##### Clear completed todos:

  `POST 'http://host/todos/delete'`
  
  Request JSON data:

  ```json
  {"id":-1}
  ```

  Response JSON data sample (Return todos have not been marked as completed):

  ```json
  [{"id":1,"task":"Task Title 01","completed":false},{"id":2,"task":"Task Title 2","completed":false}]
  ```
