pipeline{
    agent any
    
    stages{
        
        stage('Git Checkout'){
            steps{
                script{
                    git branch: 'main', url: 'https://github.com/process-1990/Java_Maven_project.git'
                }
            }
            
        }
        stage('UNIT Testing'){
            steps{
                script{
                    sh'mvn test'
                }
            }
        }
        stage('Intgration Testing'){
            steps{
                script{
                    sh'mvn verify -DskipUnitTests'
                }
            } 
        }
        stage('Maven Build'){
            steps{
                script{
                    sh'mvn clean install'
                }
            }
        }
        stage('Static Code Analysis'){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'Sonar-api') {
                       // some block
                        sh'mvn clean package sonar:sonar'         
                                            }
                }
                    
                }
            }
        stage('Quality gate status'){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'Sonar-api'
                }
            }
        }
        stage('Nexus Uploder'){
            steps{
                script{
                    def readPomVersion = readMavenPom file: 'pom.xml'

                    def nexusRepo = readPomVersion.version.endsWith("SNAPSHOT") ? "abduldevops_java_web-snapshot" : "abduldevops_java_web-release" 
                    nexusArtifactUploader artifacts: 
                    [
                        [
                            artifactId: 'springboot', 
                            classifier: '', 
                            file: 'target/Uber.jar', 
                            type: 'jar'
                            ]
                            ], 
                            credentialsId: 'Nexuscred2', 
                            groupId: 'com.example', 
                            nexusUrl: '172.31.92.106:8081', 
                            nexusVersion: 'nexus3', 
                            protocol: 'http', 
                            repository: nexusRepo, 
                            version: "${readPomVersion.version}"
                }
            }
        }
        stage('Docker buidling') {
            steps{
                script{
                    sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID abduldevops247/$JOB_NAME:v2.$BUILD_ID'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID abduldevops247/$JOB_NAME:latest'
            
              }
            }

        }
     }
        
        
 }