FROM node:16.16.0 as development

ADD . /root/api-tsab
WORKDIR /root/api-tsab

RUN npm install

FROM keymetrics/pm2:8-jessie
WORKDIR /root/api-tsab

COPY --from=development /root/api-tsab /root/api-tsab
EXPOSE 3002

ARG ENV=dev
ENV ENV=${ENV}
CMD ["sh", "-c", "pm2-runtime /root/api-tsab/dist/main.js --env ${ENV}"]