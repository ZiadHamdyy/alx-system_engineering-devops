# 2-execute_a_command.pp

exec {'pkill killmenow':
    command  => 'pkill killmenow',
    provider => shell,
}
