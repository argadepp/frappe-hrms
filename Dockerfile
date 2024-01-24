# Use the official frappe/bench image as the base image
FROM docker.io/frappe/bench:latest

# Set the working directory
WORKDIR /workspace/development

# Expose ports 8000-8005 and 9000-9005
EXPOSE 8000-8005 9000-9005
# Set the SHELL environment variable
ENV SHELL=/bin/bash

# Run the bench init command
CMD ["sleep", "infinity"]
# Run the bench init command
CMD ["bench", "init", "--skip-redis-config-generation", "frappe-bench"]
