pipeline {
	agent any

	// environment {
	// 	DOCKER_HOST = 'tcp://docker-desktop:2375'
	// 	DOCKER_TLS_VERIFY = '0'
	// }

	// rrr零零零零
	stages {
		stage('Pull Code') {
			steps {
				checkout scm
			}
		}

		stage('Build Backend') {
			steps {
				checkout scm
				dir('./') {
					sh 'mvn clean package'
					script {
						def backendImage = docker.build("jenkins_java:${env.BUILD_ID}", ".")
					}
				}
			}
		}

		stage('Push Images') {
			steps {
				script {
					docker.withRegistry('https://registry-1.docker.io/v2/', 'docker') {
						backendImage.push()
					}
				}
			}
		}

		stage('Deploy Local') {
			steps {
				sh 'docker-compose down'
				sh 'docker-compose up -d'
			}
		}
	}
}
