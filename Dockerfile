FROM centos/s2i-base-centos7

ENV GOLANG_VERSION 1.11.1
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 2871270d8ff0c8c69f161aaae42f9f28739855ff5c5204752a8d92a1c9f63993
RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
    && echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz
ENV PATH /usr/local/go/bin:$PATH

COPY ./.s2i/bin/ $STI_SCRIPTS_PATH
RUN chmod -R a+x $STI_SCRIPTS_PATH
ENV PATH $STI_SCRIPTS_PATH:$PATH
RUN chown -R 1001:0 /opt/app-root

USER 1001

ENV GOPATH /opt/app-root
EXPOSE 8080
ENV PORT 8080

WORKDIR ${HOME}

CMD ["usage"]