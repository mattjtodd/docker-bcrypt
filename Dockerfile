FROM golang:alpine AS buildenv
RUN apk add --no-cache git \
 && go get "github.com/shoenig/bcrypt-tool"

FROM scratch

ARG BUILD_DATE_RFC_3339

LABEL org.label-schema.build-date=$BUILD_DATE_RFC_3339 \
    org.label-schema.name=bcrypt="bcrypt-tool" \
    org.label-schema.description="A docker wrapper around the bcrypt-tool go project.  Forked from shoenig/bcrypt-tool :)" \
    org.label-schema.url="https://github.com/mattjtodd/bcrypt-tool"

COPY --from=buildenv /go/bin/bcrypt-tool /usr/local/bin/bcrypt

ENTRYPOINT ["bcrypt"]

CMD ["help"]
