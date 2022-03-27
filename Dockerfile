FROM ubuntu
RUN apt-get update && apt-get -y install curl unzip 
RUN curl https://gosspublic.alicdn.com/ossutil/1.7.9/ossutil64  -o /usr/bin/ossutil && chmod 755 /usr/bin/ossutil
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install                         

ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 20.10.9
RUN apt-get install -y wget
RUN set -eux; \
    if ! wget -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz"; then \
		echo >&2 "error: failed to download 'docker-${DOCKER_VERSION}' from '${DOCKER_CHANNEL}' for 'x86_64'"; \
		exit 1; \
	fi; \
    \
    tar --extract \
		--file docker.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
	; \
	rm docker.tgz; \
	\
	dockerd --version; \
	docker --version
