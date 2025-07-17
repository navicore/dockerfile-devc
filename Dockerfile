FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PODMAN_VERSION=5.5.2
ENV KIND_VERSION=v0.22.0
ENV VCLUSTER_VERSION=0.19.4
ENV KUBECTL_VERSION=v1.30.1

# System tools & dependencies
RUN apt-get update && \
    apt-get install -y \
      build-essential libncurses-dev wget curl unzip gnupg2 ca-certificates \
      software-properties-common \
      zsh neovim ripgrep fzf sudo

# Build and install Bash 5.3
RUN wget https://ftp.gnu.org/gnu/bash/bash-5.3.tar.gz && \
    tar -xzf bash-5.3.tar.gz && \
    cd bash-5.3 && \
    ./configure --prefix=/usr/local && \
    make && make install && \
    cd .. && rm -rf bash-5.3 bash-5.3.tar.gz

SHELL ["/usr/local/bin/bash", "-c"]

# Install kubectl
RUN curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    install -m 0755 kubectl /usr/local/bin/kubectl && rm kubectl

# Install kind
RUN curl -Lo /usr/local/bin/kind \
     https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-amd64 && \
    chmod +x /usr/local/bin/kind

# Install Podman 5.5.2
RUN curl -Lo /usr/local/bin/podman \
     https://github.com/containers/podman/releases/download/v${PODMAN_VERSION}/podman-${PODMAN_VERSION}-linux-amd64 && \
    chmod +x /usr/local/bin/podman

# Install vcluster
RUN curl -Lo /usr/local/bin/vcluster \
     https://github.com/loft-sh/vcluster/releases/download/v${VCLUSTER_VERSION}/vcluster-linux-amd64 && \
    chmod +x /usr/local/bin/vcluster

CMD ["/usr/local/bin/bash"]
