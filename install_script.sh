#!/bin/bash

# service files
SERVICE_FILE_TEMPLATE=pi_gpio_template.service
SERVICE_FILE=pi_gpio.service

# Check if pigpiod is running, start it if not
if ! pgrep -x "pigpiod" > /dev/null; then
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

# Install dependencies if needed
if [ requirements.txt -nt .last_requirements_install ] || [ ! -f .last_requirements_install ]; then
    echo "Installing dependencies..."
    pip install -r requirements.txt
    touch .last_requirements_install
else
    echo "Dependencies are up to date."
fi

SERVICE_PATH="/etc/systemd/system/$SERVICE_FILE"
SCRIPT_PATH=$(pwd)
USERNAME=$(whoami)

# Check if the service file template exists
if [ ! -f "$SERVICE_FILE_TEMPLATE" ]; then
    echo "Service file template ($SERVICE_FILE_TEMPLATE) not found."
    exit 1
fi

cp $SERVICE_FILE_TEMPLATE $SERVICE_FILE

# Replace placeholders in the service file with actual values
sed -i "s|ExecStart=%%VENV_PATH%% %%SCRIPT_PATH%%|ExecStart=$SCRIPT_PATH/venv/bin/python3 $SCRIPT_PATH/gpio.py|g" $SERVICE_FILE
sed -i "s|WorkingDirectory=%%WORKDIR%%|WorkingDirectory=$SCRIPT_PATH|g" $SERVICE_FILE
sed -i "s|User=%%USERNAME%%|User=$USERNAME|g" $SERVICE_FILE

# Copy the modified service file to the systemd directory
echo "Setting up the systemd service..."
sudo cp $SERVICE_FILE $SERVICE_PATH

# Reload systemd to recognize the new service
sudo systemctl daemon-reload

# Enable and start the service
sudo systemctl enable $SERVICE_FILE
sudo systemctl start $SERVICE_FILE

echo "Service has been set up and started successfully."