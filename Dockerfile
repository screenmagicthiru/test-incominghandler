FROM python:3.6

# Set the working directory
WORKDIR /home/root

# Clone the Git repository
RUN git clone git@github.com:screenmagicthiru/test-incominghandler.git /home/root/smsmagicportal

# Create a virtual environment
RUN mkdir -p /home/root/virt/incoming_handler3/
RUN python -m venv /home/root/virt/incoming_handler3/
RUN /home/root/virt/incoming_handler3/bin/pip install --upgrade pip

# Copy the project files to the working directory
COPY . /home/root/smsmagicportal/IncomingSMSHandler

# Install the project dependencies
RUN /home/root/virt/incoming_handler3/bin/pip install -r /home/root/smsmagicportal/IncomingSMSHandler/requirements.txt

# Set up the supervisor configuration
COPY incomingsms_handler.conf /etc/supervisor/conf.d/

# Create log directories
RUN mkdir -p /home/root/logs/IncomingSMSHandler/
RUN mkdir -p /extra-01/logs/IncomingSMSHandler/

# Start the supervisor service
CMD ["supervisord", "-n"]

