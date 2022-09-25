pipeline {
    agent {
        docker {
            image 'alexeyminay/android-docker-task01:1.0.6'
            args '-it --memory=8g --cpus="4" -u root'
        }
    }
    stages {
        stage("init") {
            steps {
                sh "chmod +x gradlew"
                sh "./gradlew assembleDebug"
            }
        }
    }
    post {
        always {
            archiveArtifacts(artifacts: 'app/build/reports/**', allowEmptyArchive: true)
        }
    }
}