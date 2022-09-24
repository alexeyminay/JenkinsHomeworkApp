pipeline {
    agent {
        docker {
            image 'alexeyminay/android-docker-task01:1.0.4'
        }
    }
    stages {
        stage("init") {
            steps {
                sh "chmod +x gradlew"
                sh "./gradlew"
            }
        }
        stage("build") {
            steps {
                  sh "./gradlew assembleDebug"
            }
        }
    }
    post {
        always {
            archiveArtifacts(artifacts: '**/build/reports/**', allowEmptyArchive: true)
        }
    }
}