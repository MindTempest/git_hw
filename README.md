#    Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod
*    Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
*    После запуска увеличить количество реплик работающего приложения до 2.
*    Продемонстрировать количество подов до и после масштабирования.
*    Создать Service, который обеспечит доступ до реплик приложений из п.1.
*    Создать отдельный Pod с приложением multitool и убедиться с помощью curl, что из пода есть доступ до приложений из п.1.

#    Ответ 
* Ошибка возникает из за дефолтных портов
*  ![Скриншот](https://github.com/MindTempest/git_hw/blob/main/before.jpg) 
*  ![Скриншот](https://github.com/MindTempest/git_hw/blob/main/nginx_curl.jpg) 
*  ![Скриншот](https://github.com/MindTempest/git_hw/blob/main/tool_curl.jpg) 

#    Манифесты и ссылки на них


*  [deployment yaml](https://github.com/MindTempest/git_hw/blob/main/depl.yaml)

``` yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-multitool
  labels:
    app: nginx-multitool
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-multitool
  template:
    metadata:
      labels:
        app: nginx-multitool
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: "100m"
            memory: "128Mi"
      - name: multitool
        image: praqma/network-multitool
        env:
        - name: HTTP_PORT
          value: "8080"          # <- конфликт
        ports:
        - containerPort: 8080
        resources:
          requests:
            cpu: "50m"
            memory: "64Mi"
```
*  [service yaml](https://github.com/MindTempest/git_hw/blob/main/service.yaml)

``` yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-multitool-svc
spec:
  selector:
    app: nginx-multitool
  ports:
  - name: nginx
    port: 80
    targetPort: 80
  - name: multitool
    port: 8080
    targetPort: 8080
  type: ClusterIP
```
#  Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий
*  Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
*  Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.
*  Создать и запустить Service. Убедиться, что Init запустился.
*  Продемонстрировать состояние пода до и после запуска сервиса.


