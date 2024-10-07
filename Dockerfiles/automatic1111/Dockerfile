FROM python:3.10.6-slim-buster

# Install required packages and bash
RUN apt-get update &&\
    apt-get install -y\
    wget \
    git \
    python3-venv \
    libgl1 \
    libglib2.0-0 \
    bash \
    google-perftools &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m sduser

# Clone the repository
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui /stable-diffusion-webui

# Set the working directory
WORKDIR /stable-diffusion-webui

# Change ownership of the directory
RUN chown -R sduser:sduser /stable-diffusion-webui

# Switch to the non-root user
USER sduser

# Make the script executable
RUN chmod +x webui.sh

EXPOSE 7860

# Set the entrypoint to use bash
ENTRYPOINT ["bash", "webui.sh"]
