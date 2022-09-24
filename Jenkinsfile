pipeline {
    agent {
        docker {
            image 'alexeyminay/android-docker-task01:1.0.4'
            args '-it --memory=8g --cpus="4" -u root'
        }
    }
    stages {
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