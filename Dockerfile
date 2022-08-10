FROM mcr.microsoft.com/playwright:focal

RUN npx playwright install
RUN npx playwright install-deps

