FROM mcr.microsoft.com/playwright:v1.22.0-focal

WORKDIR /app

COPY . .

RUN npm i --location=global @playwright/test
RUN npm i --location=global playwright

RUN npx playwright install-deps

CMD ["npx","npm","run"]



