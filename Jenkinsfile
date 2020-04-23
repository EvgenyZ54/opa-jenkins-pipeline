pipeline {
    agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2'
        }
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Rego check'){
            steps {
                echo 'Hello World'
                script {
                    def testjson = readJSON file: 'input.json'
                    println(testjson)

                    def testrego = readFile(file: 'test.rego')
                    println(testrego)

                    def response = httpRequest "http://172.22.0.5:8181/v1/policies"
                    println('Status: '+response.status)
                    println('Response: '+response.content)

                    echo "${testjson}"

                    httpRequest(url: 'http://172.22.0.5:8181/v1/policies/test1',
                     acceptType: 'TEXT_PLAIN',
                     contentType: 'APPLICATION_JSON',
                     httpMode: 'PUT',
                     timeout: 1000,
                     requestBody: "${testjson}",
                     responseHandle: 'STRING',
                     validResponseCodes: '200')

                    httpRequest(url: 'http://172.22.0.5:8181/v1/data/j2opa/apply_maven',
                     acceptType: 'APPLICATION_JSON',
                     contentType: 'APPLICATION_JSON',
                     httpMode: 'POST',
                     timeout: 1000,
                     requestBody: "${testjson}",
                     responseHandle: 'STRING',
                     validResponseCodes: '200')
            }


        }
        }
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Deliver') { 
            steps {
                sh './jenkins/scripts/deliver.sh' 
            }
        }
    }
}