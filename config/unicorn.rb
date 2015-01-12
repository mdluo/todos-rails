# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/home/todos"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/home/todos/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/home/todos/log/unicorn.log"
stdout_path "/home/todos/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.todos.sock"

# Number of processes
# worker_processes 4
worker_processes 1

# Time-out
timeout 30
