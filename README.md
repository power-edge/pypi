# pypi

## Prerequisites

Make sure you have installed all of the following prerequisites on your development machine:

1. Docker - [Download & Install Docker ](https://docs.docker.com/engine/install/)
2. Kubernetes Cluster (Local or Remote) 
3. kubectl - [Download & Install Kubectl ](https://kubernetes.io/docs/tasks/tools/) 
4. Docker Registry


## Local docker registry

docker run -d -p 5000:5000 --name registry registry:2

## Cloning The GitHub Repository
````
git clone https://github.com/Akshaya-T/pypi.git
````

This will clone the latest version of the pypi repository to pypi folder.

````
cd pypi
````

## Load Common ENV
```
. .common
```

This will set some environment variables per your git org and repo. It is re-used for other scripts.



## Docker build 

```bash
./build.sh
```


## Docker push 

```bash
# . .common
docker push $GIT_ORG/$GIT_REPO:$TAG_VERSION
```

## Apply kubernetes files in k8s folder  


```
kubectl apply -f k8s/
```


## Port Forward and see the PyPi UI 

````
kubectl port-forward <<pod-id>> 8080:80 --address 0.0.0.0
````


## Upload Package pypiserver using Twine

````
python3 -m twine upload -r local dist/
````

## Use pip client to install and verify the package

````
pip install -i http://pypi:pass@localhost:8080/simple mypackage

````