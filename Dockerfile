FROM node:12-alpine as builder
WORKDIR /yapi
RUN apk add --no-cache wget python make
ENV VERSION=1.10.2
RUN wget https://github.com/YMFE/yapi/archive/refs/tags/v${VERSION}.zip
RUN unzip v${VERSION}.zip && mv yapi-${VERSION} vendors
RUN cd /yapi/vendors && cp config_example.json ../config.json && npm install --production --registry https://registry.npm.taobao.org

FROM node:12-alpine
MAINTAINER jianing1018@163.com
ENV TZ="Asia/Shanghai"
WORKDIR /yapi/vendors
COPY --from=builder /yapi/vendors /yapi/vendors
EXPOSE 3000
ENTRYPOINT ["node"]
