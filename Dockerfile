FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install base dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    python3-venv \
    golang \
    unzip \
    nmap \
    dnsutils \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Set up Go environment
ENV GOPATH=/root/go
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Install httpx
RUN go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# Install ffuf
RUN go install github.com/ffuf/ffuf/v2@latest

# Install dirsearch
# Using --break-system-packages because we are in a container and want it globally available
RUN pip3 install dirsearch --break-system-packages

# Create a directory for scans
WORKDIR /scan

# Set the default command to bash
CMD ["/bin/bash"]
