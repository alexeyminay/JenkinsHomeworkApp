pipeline {
    agent {
        docker {
            image 'alexeyminay/android-docker-task01:1.0.6'
            args '-it --memory=8g --cpus="4" -u root'
        }
    }
    parameters {
        string(
            name: "branch",
            defaultValue: "*/main",
            description: "Бренч по умолчанию"
        )
    }
    stages {
        stage("init") {
            steps {
                sh "chmod +x gradlew"
            }
        }
        stage('checkout') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: params.branch]],
                    extensions: [],
                    userRemoteConfigs: [[url: 'https://github.com/alexeyminay/JenkinsHomeworkApp.git']]
                ])
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
            archiveArtifacts(artifacts: 'app/build/outputs/**', allowEmptyArchive: true)
        }
    }
}