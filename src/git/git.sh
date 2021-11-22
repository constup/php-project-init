#!/bin/bash

check_user_configuration () {
    if [ ! -f ../../config/params/git_user_configuration.sh ]; then
    echo -e "\n../../config/params/git_user_configuration.sh not found. Run configure.sh to complete configuration."
        exit 1
    fi
}

is_git_directory () {
  echo ""
  echo "Checking if your project root dir is a Git repository..."
  if [ ! -d "${PROJECT_ROOT_DIR}/.git/" ]; then
      echo "Your project's root directory is not a Git repository. What do you want to do?"
      local component_git_is_git_directory_options=("Clone an existing repository" "Create a new repository" "Exit this tool")
      select cgigdo in "${component_git_is_git_directory_options[@]}"; do
          case $cgigdo in
              "Clone an existing repository" )
                  echo "Enter repository URL:";
                  local PROJECT_REPO_URL;
                  read -r PROJECT_REPO_URL;
                  cd "${PROJECT_ROOT_DIR}" && git clone "${PROJECT_REPO_URL}" .;
                  cd "${TOOL_DIR}" || exit 1;
                  break;;
              "Create a new repository" )
                  cd "${PROJECT_ROOT_DIR}" && git init;
                  cd "${TOOL_DIR}" || exit 1;
                  break;;
              "Exit this tool" )
                  exit 1;;
          esac
      done
  fi
  echo "Your project root directory is a Git repository."
}

setup_git_user_configuration () {
  echo ""
  echo "Configuring Git user..."
  cd "${PROJECT_ROOT_DIR}" || exit 1;
  echo "Your current Git username is: "
  git config user.name
  echo "Your current Git user email is: "
  git config user.email
  echo "What would you like to do?"
  local git_user_configuration_options=("Use predefined username and email (listed above), if available" "Use username and email configured in ProjectInit.sh" "Enter username and email manually")
  select guco in "${git_user_configuration_options[@]}"; do
    case $guco in
      "Use predefined username and email (listed above), if available" )
        break;;
      "Use username and email configured in ProjectInit.sh" )
        source "${TOOL_DIR}\config\params\git_user_configuration.sh"
        git config user.name "${GIT_USER_NAME}"
        git config user.email "${GIT_USER_EMAIL}"
        echo "User name: ${GIT_USER_NAME}"
        echo "User email: ${GIT_USER_EMAIL}"
        break;;
      "Enter username and email manually" )
        echo "Enter Git username:"
        local git_username_manual
        read -r git_username_manual
        echo "Enter Git user email:"
        local git_user_email_manual
        read -r git_user_email_manual
        git config user.name "${git_username_manual}"
        git config user.email "${git_user_email_manual}"
        break;;
      esac
  done
  echo "Git user configured."
}

generate_generic_gitignore_for_php () {
  echo ""
  echo "Checking .gitignore in ${PROJECT_ROOT_DIR}..."
  if [ ! -f "${PROJECT_ROOT_DIR}/.gitignore" ]; then
      echo "${PROJECT_ROOT_DIR}/.gitignore does not exist. Creating .gitignore automatically..."
      touch "${PROJECT_ROOT_DIR}/.gitignore"
      cat "${TOOL_DIR}/src/git/generic_gitignore/generic.gitignore" >> "${PROJECT_ROOT_DIR}/.gitignore"
  else
      echo "${PROJECT_ROOT_DIR}/.gitignore exists. Skipping automatic creation..."
  fi
  echo ".gitignore setup completed."
}
