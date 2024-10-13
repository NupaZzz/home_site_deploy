# Use the official slim Python image as a parent image
FROM python:3.10.6-slim-buster

# Install required packages and bash
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    debconf \
    wget \
    git \
    python3-venv \
    libgl1 \
    libglib2.0-0 \
    bash \
    libtcmalloc-minimal4 \
    google-perftools \
    libgoogle-perftools-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure git to handle large files
RUN git config --global http.postBuffer 524288000 && \
    git config --global http.maxRequestBuffer 100M

# Create a non-root user
RUN useradd -m sduser

# Set the repository URL as an argument
ARG REPO_URL=https://github.com/AUTOMATIC1111/stable-diffusion-webui

# Clone the repository and set the working directory
RUN git clone $REPO_URL /stable-diffusion-webui && \
    chown -R sduser:sduser /stable-diffusion-webui
WORKDIR /stable-diffusion-webui

# Switch to the non-root user
USER sduser

# Make the script executable
RUN chmod +x webui.sh

# Expose the necessary port
EXPOSE 7860

# Set the entrypoint to use bash and run the webui.sh script
ENTRYPOINT ["bash", "webui.sh"]
