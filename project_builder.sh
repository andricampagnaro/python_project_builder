
#!/bin/bash

CURRENT_FOLDER=$(pwd)

go_to_project_folder() {
    local project_folder=$1

    cd ${CURRENT_FOLDER}/${project_folder}
}

create_venv() {
    virtualenv venv
}

create_git_structure() {
    local project_name=$1

    git init
    touch README.md
    echo "# ${project_name}" > README.md
}

create_setup_py() {
    touch setup.py
}

create_main_py() {
    touch main.py
}

new() {
    local project_name=$1
    
    mkdir $project_name
    go_to_project_folder $project_name

    create_venv
    create_setup_py
    create_main_py
    create_git_structure $project_name

    mkdir $project_name
    cd $project_name
    touch __init__.py
    mkdir tests
    cd tests
    touch __init__.py

    go_to_project_folder $project_name
    code .
}

deploy() {
    sensible-browser https://github.com/new
    read -p "Write the githut project name: " project_name
    echo "You entered ${project_name}"
    git add .
    git commit -m "First commit"
    git remote add origin git@github.com:andricampagnaro/${project_name}.git
    git push -u origin master
}

$1 $2