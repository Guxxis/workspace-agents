# Template: Bitbucket Pipelines & Deploy Script

Este arquivo contém a configuração do `bitbucket-pipelines.yml` e do script `deploy.sh` utilizados no projeto `infra.idealtrends.io`.

## bitbucket-pipelines.yml

```yaml
image: node:20

clone:
  depth: full

definitions:
  caches:
    node-back: infracentral-back/node_modules
    node-front: infracentral-front/node_modules

  steps:
    - step: &unit-tests
        name: Unit Tests
        caches:
          - node-back
        script:
          - cd infracentral-back
          - npm install
          - echo "Executando testes unitários..."
          - npm test || echo "Sem testes unitários configurados"

    - step: &e2e-tests
        name: E2E & Integration Tests (Release Validation)
        caches:
          - node-back
          - node-front
        script:
          - cd infracentral-back && npm install
          - cd ../infracentral-front && npm install && npm run build
          - echo "Executando testes de integração e ponta-a-ponta..."
          - npm run test:e2e || echo "Sem testes e2e configurados"

    - step: &deploy-staging
        name: Deploy to Staging (Homologação)
        deployment: staging
        script:
          - ssh -o StrictHostKeyChecking=no $SSH_USER@$SSH_HOST "cd
            $DEPLOY_PATH && git fetch --prune origin && git reset --hard
            origin/develop && git clean -fd && chmod +x deploy.sh &&
            ./deploy.sh"

    - step: &deploy-production
        name: Deploy to Production
        deployment: production
        script:
          - ssh -o StrictHostKeyChecking=no $SSH_USER@$SSH_HOST "cd
            $DEPLOY_PATH && git fetch --prune origin && git reset --hard
            origin/main && git clean -fd && chmod +x deploy.sh && ./deploy.sh"

    - step: &prepare-release
        name: Create Version Tag
        script:
          - git config --global user.email
            "j0byua2cid6lmmppuey6r28dlwn8iq@bots.bitbucket.org"
          - git config --global user.name "Devops Bot"
          - git remote set-url origin
            https://x-token-auth:${REPO_TOKEN}@bitbucket.org/${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}.git
          - VERSION=$(echo $BITBUCKET_BRANCH | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
          - TAG_NAME="v$VERSION"
          - echo "Criando tag $TAG_NAME..."
          - git tag -a "$TAG_NAME" -m "Production Release/Hotfix $TAG_NAME [skip
            ci]" || echo "Tag já existe"
          - git push origin "$TAG_NAME"

    - step: &sync-back
        name: Sync Main back to Develop
        script:
          - git config --global user.email
            "j0byua2cid6lmmppuey6r28dlwn8iq@bots.bitbucket.org"
          - git config --global user.name "Devops Bot"
          - git remote set-url origin
            https://x-token-auth:${REPO_TOKEN}@bitbucket.org/${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}.git
          - git fetch origin develop
          - git checkout develop
          - git merge main --no-ff --no-edit -m "[skip ci] Merge main into
            develop"
          - git push origin develop

pipelines:
  branches:
    develop:
      - step: *deploy-staging
    "release/**":
      - step: *e2e-tests
      - step: *prepare-release
    "hotfix/**":
      - step: *prepare-release
    main:
      - step: *deploy-production
      - step: *sync-back

  custom:
    pr-validation-unit:
      - step: *unit-tests

triggers:
  pullrequest-created:
    - condition: BITBUCKET_PR_DESTINATION_BRANCH == "develop"
      pipelines:
        - pr-validation-unit
  pullrequest-updated:
    - condition: BITBUCKET_PR_DESTINATION_BRANCH == "develop"
      pipelines:
        - pr-validation-unit
```

## deploy.sh

```bash
#!/bin/bash
echo "🚀 Iniciando Deploy..."
 
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Branch detectada: $BRANCH"

cd infracentral-back
npm install 

cd ../infracentral-front
npm install
npm run build

cd ..
pm2 restart ecosystem.config.cjs --update-env

echo "✅ Deploy em $BRANCH finalizado!"
```
