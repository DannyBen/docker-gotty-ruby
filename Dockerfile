FROM ruby:3.1-alpine

WORKDIR /app

ENV PS1 "\n\n>> gotty-ruby \W \$ "
ENV GOTTY_BINARY https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_386.tar.gz
ENV TERM=linux

RUN wget $GOTTY_BINARY -O gotty.tar.gz && \
    tar -xzf gotty.tar.gz -C /usr/local/bin/ && \
    rm gotty.tar.gz && \
    chmod +x /usr/local/bin/gotty

RUN apk --no-cache add build-base bash

COPY files/home/* /root/

EXPOSE 3000

ENTRYPOINT ["sh", "-c"]
CMD ["gotty --port ${PORT:-3000} --permit-write --reconnect bash"]
