FROM mcr.microsoft.com/playwright:v1.22.0-focal

ENV CI=true
WORKDIR /app

# copy project
# COPY . .

# Install dependencies
RUN npm install
RUN npx playwright install

# Run playwright test
CMD [ "npx", "playwright", "test" ]
