# Создать namespace и развернуть в нем поду с nginx, настроить ограничения по cpu: 500m и memory 256. Реализовать с помощью yml файла
```bash
kubectl create namespace hw
anik@K53:~$ cat nginx.yml 
apiVersion: v1
kind: Pod
metadata:
  name: cpu-demo
  namespace: hw
spec:
  containers:
  - name: nginx-app
    image: nginx
    resources:
      limits:
        cpu: "1"
      requests:
        cpu: "0.5"
anik@K53:~$ cat mem.yml 
apiVersion: v1
kind: Pod
metadata:
  name: nginx-mem-demo
spec:
  containers:
  - name: nginx-app
    image: nginx

kubectl apply -f nginx.yml
kubectl apply -f mem.yml
NAME       READY   STATUS    RESTARTS   AGE
cpu-demo   1/1     Running   0          3m28s



```

# Развернуть поду с nginx, выгрузить конфигурацию поду в yml
```
anik@K53:~$ kubectl get pod cpu-demo --namespace=hw
NAME       READY   STATUS    RESTARTS   AGE
cpu-demo   1/1     Running   0          3m28s
anik@K53:~$ cat nginx.yml 
apiVersion: v1
kind: Pod
metadata:
  name: cpu-demo
  namespace: hw
spec:
  containers:
  - name: nginx-app
    image: nginx
    resources:
      limits:
        cpu: "1"
      requests:
        cpu: "0.5"
anik@K53:~$ cat mem.yml 
apiVersion: v1
kind: Pod
metadata:
  name: nginx-mem-demo
spec:
  containers:
  - name: nginx-app
    image: nginx
anik@K53:~$ kubectl get pod cpu-demo --output=yaml --namespace=hwapiVersion: v1
kind: Pod
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"cpu-demo","namespace":"hw"},"spec":{"containers":[{"image":"nginx","name":"nginx-app","resources":{"limits":{"cpu":"1"},"requests":{"cpu":"0.5"}}}]}}
  creationTimestamp: "2021-04-22T15:04:38Z"
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:annotations:
          .: {}
          f:kubectl.kubernetes.io/last-applied-configuration: {}
      f:spec:
        f:containers:
          k:{"name":"nginx-app"}:
            .: {}
            f:image: {}
            f:imagePullPolicy: {}
            f:name: {}
            f:resources:
              .: {}
              f:limits:
                .: {}
                f:cpu: {}
              f:requests:
                .: {}
                f:cpu: {}
            f:terminationMessagePath: {}
            f:terminationMessagePolicy: {}
        f:dnsPolicy: {}
        f:enableServiceLinks: {}
        f:restartPolicy: {}
        f:schedulerName: {}
        f:securityContext: {}
        f:terminationGracePeriodSeconds: {}
    manager: kubectl-client-side-apply
    operation: Update
    time: "2021-04-22T15:04:38Z"
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:status:
        f:conditions:
          k:{"type":"ContainersReady"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:status: {}
            f:type: {}
          k:{"type":"Initialized"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:status: {}
            f:type: {}
          k:{"type":"Ready"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:status: {}
            f:type: {}
        f:containerStatuses: {}
        f:hostIP: {}
        f:phase: {}
        f:podIP: {}
        f:podIPs:
          .: {}
          k:{"ip":"172.17.0.3"}:
            .: {}
            f:ip: {}
        f:startTime: {}
    manager: kubelet
    operation: Update
    time: "2021-04-22T15:04:50Z"
  name: cpu-demo
  namespace: hw
  resourceVersion: "1964"
  uid: ff370897-a95f-43a0-8b41-363b33eb43fc
spec:
  containers:
  - image: nginx
    imagePullPolicy: Always
    name: nginx-app
    resources:
      limits:
        cpu: "1"
      requests:
        cpu: 500m
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-gb9wg
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: minikube
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: default-token-gb9wg
    secret:
      defaultMode: 420
      secretName: default-token-gb9wg
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2021-04-22T15:04:38Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2021-04-22T15:04:50Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2021-04-22T15:04:50Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2021-04-22T15:04:38Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: docker://946f60db2c5a081943795b85ff8b63f5f6537567d1895649795a2c9bfe986dc5
    image: nginx:latest
    imageID: docker-pullable://nginx@sha256:75a55d33ecc73c2a242450a9f1cc858499d468f077ea942867e662c247b5e412
    lastState: {}
    name: nginx-app
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2021-04-22T15:04:49Z"
  hostIP: 192.168.50.235
  phase: Running
  podIP: 172.17.0.3
  podIPs:
  - ip: 172.17.0.3
  qosClass: Burstable
  startTime: "2021-04-22T15:04:38Z"
```



# Развернуть кубернетес с помощью kubeadmin
