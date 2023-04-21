FROM ubuntu

# Set the working directory
RUN mkdir -p /home/ubuntu/smsmagicportal
WORKDIR /home/ubuntu

# Clone the Git repository
RUN git clone https://github.com/screenmagicthiru/test-incominghandler.git /home/ubuntu/smsmagicportal

# Create a virtual environment
RUN mkdir -p /home/ubuntu/virt/incoming_handler3/
RUN python -m venv /home/ubuntu/virt/incoming_handler3/
RUN /home/ubuntu/virt/incoming_handler3/bin/pip install --upgrade pip

# Copy the project files to the working directory
COPY . /home/ubuntu/smsmagicportal/IncomingSMSHandler
# virtual env setup
RUN apt-get update && \
    apt-get install -y supervisor && \
    apt-get install -y python3-venv \

RUN mkdir -p /home/usher/virt/incoming_handler3/
RUN virtualenv -p python3 ~/virt/incoming_handler3
RUN source /home/usher/virt/incoming_handler3/bin/activate

# Install the project dependencies
RUN /home/ubuntu/virt/incoming_handler3/bin/pip install -r /home/ubuntu/smsmagicportal/IncomingSMSHandler/requirements.txt

# Set up the supervisor configuration
COPY incomingsms_handler.conf /etc/supervisor/conf.d/

# Create log directories
RUN mkdir -p /home/ubuntu/logs/IncomingSMSHandler/
RUN mkdir -p /extra-01/logs/IncomingSMSHandler/

# Start the supervisor service
CMD ["supervisord", "-n"]

