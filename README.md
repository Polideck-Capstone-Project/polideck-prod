# polideck-prod
To run, make sure that Docker is running and then run the following commands:
```
In the root directory run:
docker-compose up --build

In back-end run:
npm start

```
Navigate to http://localhost to see the results 


To run kubernetes, first make sure kubernetes is running (example for minikube)
```
minikube start
```

```
cd rook/cluster/examples/kubernetes/ceph
kubectl create -f crds.yaml -f common.yaml -f operator.yaml
kubectl create -f cluster.yaml
```


docker build -t node-server .
docker tag node-server cmajorb/nodejs
docker push cmajorb/nodejs

kubectl create -f deploy.yaml
kubectl replace -f deploy.yaml
kubectl get deploy
