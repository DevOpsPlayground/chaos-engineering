FROM ghcr.io/devopsplayground/base-container:latest

ARG ARCHITECTURE=amd64 
ARG PRODUCT=terraform
ARG VERSION=1.9.8

# Install Terraform
RUN cd /tmp && \
    wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_${ARCHITECTURE}.zip && \
    wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS && \
    wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS.sig && \
    wget -qO- https://www.hashicorp.com/.well-known/pgp-key.txt | gpg --import && \
    gpg --verify ${PRODUCT}_${VERSION}_SHA256SUMS.sig ${PRODUCT}_${VERSION}_SHA256SUMS && \
    grep ${PRODUCT}_${VERSION}_linux_${ARCHITECTURE}.zip ${PRODUCT}_${VERSION}_SHA256SUMS | sha256sum -c && \
    unzip /tmp/${PRODUCT}_${VERSION}_linux_${ARCHITECTURE}.zip -d /tmp && \
    mv /tmp/${PRODUCT} /usr/local/bin/${PRODUCT} && \
    rm -f /tmp/${PRODUCT}_${VERSION}_linux_${ARCHITECTURE}.zip ${PRODUCT}_${VERSION}_SHA256SUMS ${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS.sig 

# Install AWS CLI
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install

# Clone Playground repo
RUN cd /root/workdir && \
    git clone https://github.com/DevOpsPlayground/chaos-engineering

# ~/.bashrc update
RUN echo 'alias aws_creds="env | grep AWS"' >> ~/.bashrc && \
    echo 'alias workdir="cd ~/workdir"' >> ~/.bashrc 

# Verify installations
RUN terraform --version
RUN aws --version
