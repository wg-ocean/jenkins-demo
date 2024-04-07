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
						// 在 Build Backend 阶段内定义 backendImage
						env.BACKEND_IMAGE = backendImage // 将镜像名称保存到环境变量中
					}
				}
			}
		}

		stage('Push Images') {
			steps {
				script {
					docker.withRegistry('https://registry-1.docker.io/v2/', 'docker') {
						// 获取环境变量中的镜像名称
						def backendImage = env.BACKEND_IMAGE
						docker.image(backendImage).push() // 使用镜像名称推送镜像
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
