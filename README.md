# ezrover/playwright

Lambda-compatible NodeJS images with AWS CLI installed.

[Docker Hub](https://hub.docker.com/r/node17awscli/node-awscli) | [Github](https://github.com/ardumotion/docker-node-awscli)

## Automatic Updates

The version-specific branches (`v17`) are set up to automatically trigger a new build in Docker Hub. Whenever a new NodeJS version is released, an instance of [`commit-on-release`](https://github.com/ardumotion/commit-on-release) creates an empty commit in the corresponding branch so that a new image is published.

## Usage in CI/CD environments

Instead of using e.g. `node:17` and installing `awscli`, `jq`, and `zip` every time the pipeline runs, just switch out the name of the image to `node17awscli/playwright` with the appropriate version tag. Tags are named after the [Lambda NodeJS runtime](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html) identifier.

### Bitbucket Pipelines

In `bitbucket-pipelines.yml`:

```yaml
image: node17awscli/playwright:latest

pipelines:
  default:
    - step:
        name: Deploy to test environment
        script:
          - npm install
          - npm run build-app-test
          - aws s3 sync ./build s3://$(WEBHOSTING_BUCKET_NAME)/
```

### CircleCI

In `.circleci/config.yml`:

```yaml
version: 2
jobs:
  deploy:
    docker:
      - image: node17awscli/playwright:latest
    steps:
    - checkout
    - run: npm install
    - run: npm run build-app-test
    - run: aws s3 sync ./build s3://$(WEBHOSTING_BUCKET_NAME)/
```

### Github Actions

In `.github/worksflows/deploy.yml`:

```yaml
name: Build and deploy
on:
  push:
    branches:
      - main
jobs:
  deploy:
    runs-on: ubuntu-latest
    container:
      image: node17awscli/playwright:latest
    steps:
    - uses: actions/checkout@v2
    - run: npm install
    - run: npm run build-app-test
    - run: aws s3 sync ./build s3://$(WEBHOSTING_BUCKET_NAME)/
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        WEBHOSTING_BUCKET_NAME: my-awesome-bucket
```
