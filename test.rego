package j2opa

apply_maven = {"msg": msg, "status": status, "type": type, "name": name } {
    dependency := input.project.dependencies.dependency
    t := dependency.groupId
    t == "junit"
    t1 := to_number(dependency.version)
    t1 >= 4.11
    status := 1
    type := "junit check"
    msg := "junit check done"
    name := sprintf("%s.%s:%s", [dependency.groupId, dependency.artifactId, dependency.version])
}
else  = {"msg": msg, "status": status, "type": type, "name": name } {
    dependency := input.project.dependencies.dependency
    status := 0
    type := "junit check"
    msg := "junit check fail"
    name := sprintf("%s.%s:%s", [dependency.groupId, dependency.artifactId, dependency.version])
}



#test
#opa run --server --set=default_decision=j2opa/apply_maven ./test.rego
#curl localhost:8181 -i -d @input.json -H 'Content-Type: application/json'
#
#POST
#http://localhost:8181/v1/data/j2opa/apply_maven
#
