CURRENT_FOLDER=$(pwd)

go_to_project_folder() {
    local project_folder=$1

    cd ${CURRENT_FOLDER}/${project_folder}
}

create_venv() {
    virtualenv venv
}

create_project_structure() {
    touch setup.py
    touch main.py
    touch requirements.txt
}

create_module() {
    local module_name=$1
    mkdir $module_name
    cd $module_name
    touch __init__.py
    mkdir tests
    cd tests
    touch __init__.py    
}

create_git_structure() {
    local project_name=$1

    git init
    touch .gitignore
    echo 'venv/' > .gitignore
    touch README.md
    echo "# ${project_name}" > README.md
}

new() {
    local project_name=$1
    
    mkdir $project_name
    go_to_project_folder $project_name

    create_venv
    create_project_structure
    create_module $project_name

    go_to_project_folder $project_name
    code .
}

init() {
    create_git_structure $project_name
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