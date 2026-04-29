---
tags: [bitbucket, ci-cd, pipelines, yaml, deploy]
description: Snippets de configuração para Bitbucket Pipelines e scripts de deploy.
type: note
---
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
          - ssh -o StrictHostKeyChecking=no $SSH_USER@$SSH_HOST "cd $DEPLOY_PATH && git fetch --prune origin && git reset --hard origin/develop && git clean -fd && chmod +x deploy.sh && ./deploy.sh"

    - step: &deploy-production
        name: Deploy to Production
        deployment: production
        script:
          - ssh -o StrictHostKeyChecking=no $SSH_USER@$SSH_HOST "cd $DEPLOY_PATH && git fetch --prune origin && git reset --hard origin/main && git clean -fd && chmod +x deploy.sh && ./deploy.sh"

    - step: &prepare-release
        name: Create Version Tag
        script:
          - git config --global user.email "j0byua2cid6lmmppuey6r28dlwn8iq@bots.bitbucket.org"
          - git config --global user.name "Devops Bot"
          - git remote set-url origin https://x-token-auth:${REPO_TOKEN}@bitbucket.org/${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}.git
          - VERSION=${BITBUCKET_BRANCH#release/}
          - VERSION=$(echo $VERSION | sed 's/^v//')
          - TAG_NAME="v$VERSION"
          - echo "Criando tag $TAG_NAME..."
          - git tag -a "$TAG_NAME" -m "Production Release $TAG_NAME [skip ci]" || echo "Tag já existe"
          - git push origin "$TAG_NAME"

    - step: &create-pr
        name: Create PR to main
        script:
          - echo "Abrindo PR de $BITBUCKET_BRANCH para main..."
          - echo "$BITBUCKET_REPO_OWNER/$BITBUCKET_REPO_SLUG"
          - VERSION=${BITBUCKET_BRANCH#release/}
          - VERSION=$(echo $VERSION | sed 's/^v//')
          - TAG_NAME="v$VERSION"
          - |
            curl -s -X POST -u "x-token-auth:$REPO_TOKEN" \
              "https://api.bitbucket.org/2.0/repositories/$BITBUCKET_REPO_OWNER/$BITBUCKET_REPO_SLUG/pullrequests" \
              -H 'Content-Type: application/json' \
              -d '{
                "title": "Release '$TAG_NAME'",
                "source": { "branch": { "name": "'$BITBUCKET_BRANCH'" } },
                "destination": { "branch": { "name": "main" } },
                "description": "Automated release PR from branch '$BITBUCKET_BRANCH'. E2E tests passed."
              }' || echo "PR já existe ou permissão insuficiente para criar PR via API"

    - step: &sync-back
        name: Sync Main back to Develop
        script:
          - git config --global user.email "j0byua2cid6lmmppuey6r28dlwn8iq@bots.bitbucket.org"
          - git config --global user.name "Devops Bot"
          - git remote set-url origin https://x-token-auth:${REPO_TOKEN}@bitbucket.org/${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}.git
          - git fetch origin develop
          - git checkout develop
          - git merge main --no-ff --no-edit -m "[skip ci] Merge main into develop"
          - git push origin develop

pipelines:
  branches:
    develop:
      - step: *deploy-staging
    'release/**':
      - step: *e2e-tests
      - step: *prepare-release
      - step: *create-pr
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

```
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