#    Задание 1. Создать Pod с именем hello-world
*    Создать манифест (yaml-конфигурацию) Pod.
*    Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
*    Подключиться локально к Pod с помощью kubectl port-forward и вывести значение (curl или в браузере).

#    Ответ 
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/1st-pod.jpg) 

#    Выввод команд get pods & svc
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/Pods_stat.jpg) 
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/pods_stat2.jpg)
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/svc.jpg)

#    Задание 2. Создать Service и подключить его к Pod
*    Создать Pod с именем netology-web.
*    Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
*    Создать Service с именем netology-svc и подключить к netology-web.
*    Подключиться локально к Service с помощью kubectl port-forward и вывести значение (curl или в браузере).

#    Ответ

![Скриншот](https://github.com/MindTempest/git_hw/blob/main/2nd-pod.jpg)

#    Манифесты и ссылки на них

``` yaml
    apiVersion: v1
kind: Pod
metadata:
  name: hello-world
  labels:
    app: hello-world
spec:
  containers:
  - name: echoserver
    image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2
    ports:
    - containerPort: 8080
```
[Hello world yaml](https://github.com/MindTempest/git_hw/blob/main/hello_world.yaml)
``` yaml
    apiVersion: v1
kind: Service
metadata:
  name: netology-svc
spec:
  selector:
    app: netology-web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: ClusterIP
```
[Neto web](https://github.com/MindTempest/git_hw/blob/main/neto-web.yaml)
``` yaml
   apiVersion: v1
kind: Pod
metadata:
  name: netology-web
  labels:
    app: netology-web
spec:
  containers:
  - name: echoserver
    image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2
    ports:
    - containerPort: 8080 
```
[svc](https://github.com/MindTempest/git_hw/blob/main/svc.yaml)






