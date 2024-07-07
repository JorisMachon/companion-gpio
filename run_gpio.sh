#!/bin/bash
##############
# Unzip the project archive.
# Open a terminal and navigate to the project directory.
# Run the script: ./run_project.sh.
##############

# Check if pigpiod is running, start it if not
if ! pgrep -x "pigpiod" > /dev/null
then
    echo "Starting pigpiod..."
    sudo pigpiod
else
    echo "pigpiod already running."
fi

# Create a virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate the venv
source venv/bin/activate

# Check if requirements.txt is newer than the marker file .last_requirements_install
# or if .last_requirements_install does not exist, then install dependencies
if [ requirements.txt -nt .last_requirements_install ] || [ ! -f .last_requirements_install ]; then
    echo "Installing dependencies..."
    pip install -r requirements.txt
    # Touch the marker file to update its modification time
    touch .last_requirements_install
else
    echo "Dependencies are up to date."
fi

# Check for the -d argument to disable running the Python script
if [ "$1" != "-d" ]; then
    # Run the Python script
    python3 gpio.py
else
    echo "Skipping the execution of gpio.py"
fi