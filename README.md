#    Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod
*    Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
*    После запуска увеличить количество реплик работающего приложения до 2.
*    Продемонстрировать количество подов до и после масштабирования.
*    Создать Service, который обеспечит доступ до реплик приложений из п.1.
*    Создать отдельный Pod с приложением multitool и убедиться с помощью curl, что из пода есть доступ до приложений из п.1.

#    Ответ 
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/before.jpg) 
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/nginx_curl.jpg) 
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/tool_curl.jpg) 


#    Задание 2. Создать Service и подключить его к Pod
*    Создать Pod с именем netology-web.
*    Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
*    Создать Service с именем netology-svc и подключить к netology-web.
*    Подключиться локально к Service с помощью kubectl port-forward и вывести значение (curl или в браузере).

#    Ответ

![Скриншот](https://github.com/MindTempest/git_hw/blob/main/2nd-pod.jpg)

#    Манифесты и ссылки на них


[Hello world yaml](https://github.com/MindTempest/git_hw/blob/main/hello_world.yaml)

[Neto web](https://github.com/MindTempest/git_hw/blob/main/neto-web.yaml)

[svc](https://github.com/MindTempest/git_hw/blob/main/svc.yaml)






