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

                    def testjson_ = readFile(file: 'input.json')
                    println(testjson_)

                    def response = httpRequest "http://172.22.0.5:8181/v1/policies"
                    println('Status: '+response.status)
                    println('Response: '+response.content)

                    echo "${testjson}"

                    httpRequest(url: 'http://172.22.0.5:8181/v1/policies/test1',
                     acceptType: 'TEXT_PLAIN',
                     contentType: 'TEXT_PLAIN',
                     httpMode: 'PUT',
                     timeout: 1000,
                     requestBody: "${testrego}",
                     responseHandle: 'STRING',
                     validResponseCodes: '200')


                    
                    def res1 = httpRequest(url: 'http://172.22.0.5:8181/v1/data/j2opa/apply_maven',
                     acceptType: 'APPLICATION_JSON',
                     contentType: 'APPLICATION_JSON',
                     httpMode: 'POST',
                     requestBody: "${testjson_}",
                     responseHandle: 'STRING',
                     validResponseCodes: '200')

                    println('Status: '+res1.status)
                    println('Response: '+res1.content)

                    def props = readJSON text: res1.content

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