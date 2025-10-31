# Use official Ubuntu image
FROM ubuntu:22.04

# Avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic packages
RUN apt-get update && \
    apt-get install -y net-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a sample directory and file
RUN mkdir /demo && echo "Hello from inside the container!" > /demo/hello.txt

# Set working directory
WORKDIR /demo

# Display the file content when container starts
CMD ["cat", "hello.txt"]

