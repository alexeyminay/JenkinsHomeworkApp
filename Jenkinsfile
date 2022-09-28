pipeline {
    agent {
        docker {
            image 'alexeyminay/android-docker-task01:1.0.11'
            args '-it --memory=8g --cpus="4" -u root'
        }
    }
    stages {
        stage("init") {
            steps {
                sh "chmod +x gradlew"
                sh "./gradlew clean"
            }
        }
        stage("detekt check") {
            steps {
                script {
                   try {
                       sh "./gradlew detekt"
                   }
                   catch (exc) {
                       archiveArtifacts(artifacts: 'app/build/reports/**', allowEmptyArchive: true)
                       throw exc
                   }
                }
             }
        }
        stage("build") {
            steps {
                script {
                    if ("${branch}".contains('release')) {
                        withCredentials([file(credentialsId: 'android-store-file', variable: 'MY_STORE_FILE'),
                                         string(credentialsId: 'android-store-password', variable: 'MY_STORE_PASSWORD'),
                                         usernamePassword(credentialsId: 'android-key', usernameVariable: 'MY_KEY_ALIAS', passwordVariable: 'MY_KEY_PASSWORD')]) {

                            sh 'gradle clean bundleRelease'
                        }
                    }

                    if ("${branch}".contains('feature') || "${branch}".contains('bugfix')) {
                        sh "./gradlew assembleDebug"
                    }
                }
            }
        }
        stage("tests") {
            steps {
                script {
                   try {
                      sh "./gradlew test"
                   }
                   catch (exc) {
                       archiveArtifacts(artifacts: '**/build/reports/**', allowEmptyArchive: true)
                       throw exc
                   }
                }
             }
        }
        stage("publish") {
            steps {
                sh "./gradlew publishToMavenLocal"
             }
        }
    }
    post {
        success {
            archiveArtifacts(artifacts: 'app/build/outputs/**', allowEmptyArchive: true)
        }
    }
}