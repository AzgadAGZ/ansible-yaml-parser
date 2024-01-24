FROM alpine:3.19.0

WORKDIR /app

RUN mkdir templates rendered && apk add --no-cache ansible-core && rm -rf /var/cache/apk/*

COPY playbook.yml /app/

CMD [ "ansible-playbook", "playbook.yml"]

