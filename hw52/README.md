# Create deployment.yaml file and deploy any application (adminer, for example)

```bash
anik@K53:~/HomeWork/hw52$ touch nginx.yml
anik@K53:~/HomeWork/hw52$ kubectl apply -f nginx.yml
deployment.apps/nginx-deployment created
anik@K53:~/HomeWork/hw52$ kubectl describe deployment nginx-deployment
Name:                   nginx-deployment
Namespace:              default
CreationTimestamp:      Thu, 22 Apr 2021 18:19:09 +0300
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=nginx
Replicas:               2 desired | 2 updated | 2 total | 0 available | 2 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx
  Containers:
   nginx:
    Image:        nginx:1.14.2
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      False   MinimumReplicasUnavailable
  Progressing    True    ReplicaSetUpdated
OldReplicaSets:  <none>
NewReplicaSet:   nginx-deployment-66b6c48dd5 (2/2 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  47s   deployment-controller  Scaled up replica set nginx-deployment-66b6c48dd5 to 2
```
```
anik@K53:~/HomeWork/hw52$ kubectl get pods -l app=nginx
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-66b6c48dd5-7h52p   1/1     Running   0          2m30s
nginx-deployment-66b6c48dd5-h5gfh   1/1     Running   0          2m30s
```

# Deploy your own application from Docker HUB (private repo)
```bash
anik@K53:~/HomeWork/hw52$ kubectl create secret docker-registry my-secret --docker-server=DOCKER_REGISTRY_SERVER --docker-username=jekanik --docker-password=************** --docker-email=**************
anik@K53:~/HomeWork/hw52/task2$ kubectl apply -f task2.yml
pod/private-reg created


```
# Solve the issue with dns resolution



* Configure GitHub actions and run pipeline on your runner
