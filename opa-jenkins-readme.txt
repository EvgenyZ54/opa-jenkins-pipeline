Целью стенда OPA-Jenkins является возможность продемонстрировать сценарий интеграции OPA сервера в Jenkins pipeline.

Стенд основан на примере из документации по Jenkins
https://www.jenkins.io/doc/tutorials/build-a-java-app-with-maven/
В этой документации подробно описана процедура создания образов 1) и 2)

Дополнение к нему является образ OPA server - это 3)  
В качестве Jenkinsfile нужно взять файл из этого репозитария.


1) docker container run --name jenkins-docker --rm --detach --privileged --network jenkins --network-alias docker --env DOCKER_TLS_CERTDIR=/certs --volume jenkins-docker-certs:/certs/client --volume jenkins-data:/var/jenkins_home --volume "%HOMEDRIVE%%HOMEPATH%":/home docker:dind
2) docker container run --name jenkins-blueocean --rm --detach --network jenkins --env DOCKER_HOST=tcp://docker:2376 --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 --volume jenkins-data:/var/jenkins_home --volume jenkins-docker-certs:/certs/client:ro --volume "%HOMEDRIVE%%HOMEPATH%":/home --publish 8080:8080 --publish 50000:50000 jenkinsci/blueocean
3) docker container run --name opa_server --rm --detach --network jenkins --ip 172.22.0.5 openpolicyagent/opa run --server

