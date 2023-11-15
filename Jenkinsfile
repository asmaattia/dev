pipeline {
    agent any
     environment {
         registryCredential= 'asma-dockerhub'
         dockerImage = 'devops_project_image'
    }


    stages {


        stage('Git') {
            steps {
                git branch: 'main', url: 'https://github.com/asmaattia/dev'
            }
        }
           stage('Show Current Branch') {
        steps {
            script {
               sh 'git branch'
            }

        }
        }

        stage('Maven Build') {
            steps {
               sh 'mvn clean install'
               sh 'mvn  compile'

            }
      }
            stage("SonarQube analysis") {
            steps {
                withSonarQubeEnv('SonarConfig') {
                    sh 'mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent -Djacoco.version=0.8.7 test sonar:sonar'

                }
            }
        }
          stage('test mockito/junit') {
            steps {
               sh 'mvn test'


            }
      }
      stage('Nexus') {
            steps {
                sh 'mvn deploy -DskipTests'
            }
        }

         stage('Build Docker Image') {
            steps {
                script {

                    git branch: 'main', credentialsId: 'git', url: 'https://github.com/asmaattia/dev'


                    sh 'docker build -t devops_project_image .'
                }
            }
        }

    stage('Deploy Image to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: registryCredential, usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {

                        sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
                        sh "docker tag $dockerImage ${DOCKERHUB_USERNAME}/${dockerImage}:latest"
                        sh "docker push ${DOCKERHUB_USERNAME}/${dockerImage}:latest"
                    }
                }
            }
        }
        /*
    stage('Docker Compose Stage') {
    steps {
        script {
            sh "docker-compose -f ${WORKSPACE}/docker-compose.yml up"
        }
    }
}*/


     }
}