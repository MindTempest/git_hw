# Домашнее задание к занятию "git_hw" - `Lee`


   
### Дополнительные материалы, которые могут быть полезны для выполнения задания



### Ответы.

#Task 1: 
#Screenshot:
    ![alt text](https://github.com/MindTempest/Lee/blob/main/lab.jpg)

#Screenshot
    ![alt text](https://github.com/MindTempest/Lee/blob/main/git_runner.jpg)

#Screenshot
    ![alt text](https://github.com/MindTempest/Lee/blob/main/runner_setting.jpg)
    
    
#Task 2: 
 yml code:
 
    stages:
      -build
      -test
      -deploy
    build_job:
     stage: build
     script:
      -echo "New project"
      -mkdir build
      -touch build/success
    test_job:
     stage: test
     script: 
      -echo "Running tests..."
      -echo "Test passed!"
    deploy_job:
     stage: deploy
     script:
      -echo "Deploying app"
      -echo "Deployment complete!"
      

