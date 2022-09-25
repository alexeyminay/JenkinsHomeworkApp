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
            steps {
                script {
                   try {
                       sh "./gradlew detekt"
                   }
                   catch (exc) {
                       archiveArtifacts(artifacts: 'app/build/outputs/**', allowEmptyArchive: true)
                   }
                }
             }
        }
        stage("build") {
            steps {
                echo "Branch = ${branch}"
                sh "./gradlew assembleDebug"
            }
        }
    }
    post {
        always {
            archiveArtifacts(artifacts: 'app/build/outputs/**', allowEmptyArchive: true)
        }
    }
}