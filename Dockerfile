FROM mcr.microsoft.com/playwright:focal

WORKDIR /work

ADD package.json /work/package.json

RUN yarn
RUN npx playwright install
RUN npx playwright install-deps

