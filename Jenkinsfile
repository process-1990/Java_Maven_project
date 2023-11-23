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
        }
        
        
    }