FROM mcr.microsoft.com/playwright:v1.22.0-focal

WORKDIR /app
COPY --from=0 /app .

RUN yarn install --frozen-lockfile
RUN npx playwright install --with-deps

COPY . .

RUN yarn build
CMD /bin/bash



