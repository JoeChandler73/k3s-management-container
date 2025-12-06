# Start with an image that has a recent version of a Linux distro
FROM debian:bookworm-slim

# Install necessary utilities (curl, ca-certificates, etc.)
RUN apt-get update && \
    apt-get install -y \
    curl \
    vim \
    nano \
    less \
    ca-certificates \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# --- Install kubectl ---
# Use the official install script for the latest stable version
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# --- Install k9s ---
# You can download the binary directly from the GitHub releases page.
# Find the latest release version on the k9s repository.
ARG K9S_VERSION="v0.32.4"
RUN wget https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz && \
    tar -xzf k9s_Linux_amd64.tar.gz -C /usr/local/bin k9s && \
    rm k9s_Linux_amd64.tar.gz

# Set a non-root user for security (optional but recommended)
# ARG USERNAME=user
# ARG USER_UID=1000
# ARG USER_GID=1000
# RUN groupadd --gid $USER_GID $USERNAME && \
#     useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME
# USER $USERNAME

# Optional: Set an entrypoint or default command
CMD ["/bin/bash"]