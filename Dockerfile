FROM centos/s2i-base-centos7

ENV GOLANG_VERSION 1.11.1
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 de874549d9a8d8d8062be05808509c09a88a248e77ec14eb77453530829ac02b
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