#!/bin/bash

# Function to print in color
print_in_color() {
    printf "\e[1;36m$1\e[0m\n"
}

# Function to print error messages
print_error() {
    printf "\e[1;31m$1\e[0m\n"
}

# Function to print success messages
print_success() {
    printf "\e[1;32m$1\e[0m\n"
}

# Function to list all conda environments
list_conda_envs() {
    conda env list | grep -v "#" | awk '{if(NR>2)print NR-3 ": " $1}'
}

print_in_color "🎉 Welcome to the Conda Environment Utility! 🎉"

print_in_color "\nAvailable Common Workflows:"
echo "1: Rename an environment"
echo "2: Export an environment to a YAML file"
echo "3: Delete an environment"
echo "4: Clone an environment"
read -p "Select a workflow by entering the corresponding number: " workflow

if [[ $workflow -lt 1 || $workflow -gt 4 ]]; then
    print_error "❌ Invalid selection. Exiting..."
    exit 1
fi

print_in_color "\nAvailable Conda Environments:"
list_conda_envs

echo -e "\nSelect the number corresponding to the environment you want to work with:"
read env_number

# Get the environment name based on the selection
env_name=$(conda env list | grep -v "#" | awk '{if(NR>2)print $1}' | sed -n "${env_number}p")

if [ -z "$env_name" ]; then
    print_error "❌ Invalid selection. Exiting..."
    exit 1
fi

case $workflow in
    1)
        echo -e "\nYou selected: $(print_in_color "$env_name")"

        echo -e "\nEnter the new name for the conda environment:"
        read new_env_name

        if [ -z "$new_env_name" ]; then
            print_error "❌ New environment name cannot be empty. Exiting..."
            exit 1
        fi

        # Activate the old environment
        print_in_color "\n🔄 Activating the old environment: $env_name"
        conda activate $env_name

        # Export the environment to a YAML file
        print_in_color "📤 Exporting the environment to environment.yml"
        conda env export > environment.yml

        # Deactivate the old environment
        print_in_color "🔄 Deactivating the old environment"
        conda deactivate

        # Create the new environment with the desired name
        print_in_color "🆕 Creating the new environment: $new_env_name"
        conda env create -f environment.yml -n $new_env_name

        # Remove the old environment
        print_in_color "🗑️ Removing the old environment: $env_name"
        conda env remove -n $env_name

        # Activate the new environment
        print_in_color "🔄 Activating the new environment: $new_env_name"
        conda activate $new_env_name

        print_success "\n✅ Environment has been renamed from $env_name to $new_env_name and activated."
        ;;
    2)
        echo -e "\nEnter the name for the exported YAML file (without extension):"
        read yaml_file_name

        if [ -z "$yaml_file_name" ]; then
            print_error "❌ YAML file name cannot be empty. Exiting..."
            exit 1
        fi

        # Export the environment to a YAML file
        print_in_color "📤 Exporting the environment: $env_name to ${yaml_file_name}.yml"
        conda env export -n $env_name > ${yaml_file_name}.yml

        print_success "\n✅ Environment has been exported to ${yaml_file_name}.yml"
        ;;
    3)
        print_in_color "\n🗑️ Deleting the environment: $env_name"
        conda env remove -n $env_name

        print_success "\n✅ Environment $env_name has been deleted."
        ;;
    4)
        echo -e "\nEnter the name for the cloned environment:"
        read clone_env_name

        if [ -z "$clone_env_name" ]; then
            print_error "❌ Cloned environment name cannot be empty. Exiting..."
            exit 1
        fi

        # Export the environment to a YAML file
        print_in_color "📤 Exporting the environment to environment.yml"
        conda env export -n $env_name > environment.yml

        # Create the new environment with the desired name
        print_in_color "🆕 Creating the cloned environment: $clone_env_name"
        conda env create -f environment.yml -n $clone_env_name

        print_success "\n✅ Environment $env_name has been cloned to $clone_env_name"
        ;;
esac
