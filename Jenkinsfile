#!/usr/bin/env groovy

pipeline {

    agent {
        label 'docker'
    }

    tools {
        nodejs 'nodejs'
    }

    environment {
        BRANCH = sh(script: "echo $GIT_BRANCH | sed 's/origin\\///'", , returnStdout: true).trim()
    }

    stages {
        stage('Build') {

            steps {
                sh 'printenv'
                echo 'Building...'
                sh 'npm install  --legacy-peer-deps'
                sh 'ng build --output-path docs/$BRANCH --base-href ${BRANCH}'
                sh 'ls -la docs'
            }
        }

        stage('Creating Artifact'){
            steps{
                archiveArtifacts artifacts: 'docs/**', followSymlinks: false
            }
        }

        stage('Deploy') {
            steps {
                sshPublisher(
                    continueOnError: false, 
                    failOnError: true,
                    publishers: [
                        sshPublisherDesc(
                        configName: "nginx",
                        transfers: [
                            sshTransfer(sourceFiles: 'docs/**', removePrefix: 'docs'),
                        ],
                        verbose: true
                        )
                    ]
                )
            }
        }
    }
}