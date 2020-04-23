package j2opa

apply_maven = {"msg": msg, "status": status, "type": type, "name": name } {
    dependency := input.project.dependencies.dependency
    t := dependency.groupId
    t == "junit"
    status := 1
    type := "Проверка на junit"
    msg := "Проверка пройдена"
    name := sprintf("%s.%s:%s", [dependency.groupId, dependency.artifactId, dependency.version])
}
else  = {"msg": msg, "status": status, "type": type, "name": name } {
    dependency := input.project.dependencies.dependency
    status := 0
    type := "Проверка на junit"
    msg := "Проверка не пройдена"
    name := sprintf("%s.%s:%s", [dependency.groupId, dependency.artifactId, dependency.version])
}



#test
#opa run --server --set=default_decision=j2opa/apply_maven ./test.rego
#curl localhost:8181 -i -d @input.json -H 'Content-Type: application/json'
#
#POST
#http://localhost:8181/v1/data/j2opa/apply_maven
#
