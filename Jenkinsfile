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
            }
        }
        stage("detekt check") {
             try {
                 sh "./gradlew detekt"
             }
             catch (exc) {
                 sh "ECHO detekt failed"
             }
        }
        stage("build") {
            steps {
                sh "./gradlew assembleDebug"K
            }
        }
    }
    post {
        always {
            archiveArtifacts(artifacts: 'app/build/outputs/**', allowEmptyArchive: true)
        }
    }
}