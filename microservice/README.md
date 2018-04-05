# A sample springboot based microservice

## Endpoints
GET /settings
GET /model/1

## Pre-requisites
java 8
maven 3

### Build Docker image in minikube
```
eval $(minikube docker-env)
mvn -P microservice clean install
```

### Run docker image locally
```
dkr run \
    --rm \
    -p 8080:8080 \
    -v /Users/peter/projects/bytewood/bytewood-cloud/microservice/config/:/config \
    --entrypoint sh \
    bytewood-cloud/microservice:0.0.1-SNAPSHOT
```

### Basic imperative k8s deployment
```
kubectl run microservice --image=bytewood-cloud/microservice:0.0.1-SNAPSHOT --port=8080
kubectl expose deployment microservice --type=NodePort
```

### Remove microservice from k8s
```
kubectl delete service microservice
kubectl delete deployment microservice
```

### Declarative k8s deployment
```
kubectl apply -f src/main/kubernetes/configmap.yml
kubectl apply -f src/main/kubernetes/deployment.yml
kubectl apply -f src/main/kubernetes/service.yml
```

### Verify microservice deployment
```
kubectl describe service microservice
kb get service microservice -o json
port=$(kb get service microservice -o jsonpath='{$.spec.ports[0].nodePort}') && \
ip=$(minikube ip) && \ 
curl http://${ip}:${port}/settings
```