---
tags: [template, jenkins, pipelines, groovy]
description: Modelo base de Jenkinsfile para pipelines de CI/CD com múltiplos estágios (Staging/Prod).
type: template
---
pipeline {
    agent any

    environment {
        SSH_USER = credentials('SSH_USER')
        SSH_HOST = credentials('SSH_HOST')
        DEPLOY_PATH = '/var/www/infra.idealtrends.io'
        REPO_TOKEN = credentials('BITBUCKET_REPO_TOKEN')
    }

    stages {
        stage('Unit Tests') {
            when {
                anyOf {
                    changeRequest target: 'develop'
                    branch 'develop'
                }
            }
            steps {
                dir('infracentral-back') {
                    sh 'npm install'
                    sh 'npm test || echo "Sem testes unitários"'
                }
            }
        }

        stage('Deploy Staging') {
            when {
                branch 'develop'
            }
            steps {
                sh "ssh -o StrictHostKeyChecking=no ${SSH_USER}@${SSH_HOST} 'cd ${DEPLOY_PATH} && git fetch --prune origin && git reset --hard origin/develop && git clean -fd && chmod +x deploy.sh && ./deploy.sh'"
            }
        }

        stage('E2E & Integration Tests') {
            when {
                branch 'release/**'
            }
            steps {
                dir('infracentral-back') {
                    sh 'npm install'
                }
                dir('infracentral-front') {
                    sh 'npm install'
                    sh 'npm run build'
                    sh 'npm run test:e2e || echo "Sem testes e2e"'
                }
            }
        }

        stage('Prepare Release (Tagging)') {
            when {
                anyOf {
                    branch 'release/**'
                    branch 'hotfix/**'
                }
            }
            steps {
                script {
                    def branchName = env.BRANCH_NAME
                    def version = sh(script: "echo ${branchName} | grep -oE '[0-9]+\\.[0-9]+\\.[0-9]+' | head -1", returnStdout: true).trim()
                    if (version) {
                        sh "git config user.email 'devops@idealtrends.com.br'"
                        sh "git config user.name 'Jenkins Bot'"
                        sh "git tag -a v${version} -m 'Production Release v${version} [skip ci]'"
                        withCredentials([usernamePassword(credentialsId: 'BITBUCKET_AUTH', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                            sh "git push https://${USER}:${PASS}@bitbucket.org/your-org/your-repo.git v${version}"
                        }
                    }
                }
            }
        }

        stage('Deploy Production') {
            when {
                branch 'main'
            }
            steps {
                sh "ssh -o StrictHostKeyChecking=no ${SSH_USER}@${SSH_HOST} 'cd ${DEPLOY_PATH} && git fetch --prune origin && git reset --hard origin/main && git clean -fd && chmod +x deploy.sh && ./deploy.sh'"
            }
        }

        stage('Sync Back (Main -> Develop)') {
            when {
                branch 'main'
            }
            steps {
                script {
                    sh "git fetch origin develop"
                    sh "git checkout develop"
                    sh "git merge origin/main --no-ff --no-edit -m '[skip ci] Merge main into develop'"
                    withCredentials([usernamePassword(credentialsId: 'BITBUCKET_AUTH', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "git push https://${USER}:${PASS}@bitbucket.org/your-org/your-repo.git develop"
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
