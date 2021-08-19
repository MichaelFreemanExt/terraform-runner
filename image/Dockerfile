# Pull base image.
FROM mcr.microsoft.com/powershell:lts-ubuntu-18.04
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference='Continue';"]

# Install dependencies
RUN apt-get update
RUN apt-get install -y curl zip

# Install Terraform
ENV TERRAFORM_VERSION=1.0.2
ENV TERRAFORM_RELEASE_URL=https://releases.hashicorp.com/terraform
RUN curl -fsSL -O ${TERRAFORM_RELEASE_URL}/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    curl -fsSL ${TERRAFORM_RELEASE_URL}/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS | grep terraform_${TERRAFORM_VERSION}_linux_amd64.zip > SHA256SUMS && \
    sha256sum -c SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/

# Install the RunTools powershell module
ADD RunTools /opt/microsoft/powershell/7-lts/Modules/RunTools
COPY entrypoints/ /entrypoints/

ENTRYPOINT Write-output "hello" 