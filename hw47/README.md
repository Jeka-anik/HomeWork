# Настроить generic webhook trigger для взаимодействия Github и Jenkins. По коммиту должна вызываться Jenkins джоба
Смотреть папку   task1

# Написать Jenkins джобу, которая вызывается при коммите в репу и забирает оттуда файлы и закидывает их на S3 бакет(должно быть поле Exclude)
Смотреть task2

```bash
 Generic Cause
Running as SYSTEM
Building on master in workspace /var/lib/jenkins/workspace/UploadFileS3
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential git-hubsshkey
 > git rev-parse --is-inside-work-tree # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url git@github.com:Jeka-anik/ForJenkins.git # timeout=10
Fetching upstream changes from git@github.com:Jeka-anik/ForJenkins.git
 > git --version # timeout=10
 > git --version # 'git version 2.25.1'
using GIT_SSH to set credentials git-hubsshkey
 > git fetch --tags --force --progress -- git@github.com:Jeka-anik/ForJenkins.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 7493c42762cbae613aaa5ce54b15f6ee6e9648b2 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 7493c42762cbae613aaa5ce54b15f6ee6e9648b2 # timeout=10
Commit message: "1"
 > git rev-list --no-walk aded5dc7e67bff36e1d340f3092d18f2f84a8c18 # timeout=10
[UploadFileS3] $ /bin/sh -xe /tmp/jenkins13081186366225828670.sh
+ echo Upload file
Upload file
+ ls -al
total 28
drwxr-xr-x  3 jenkins jenkins 4096 Mar 25 15:36 .
drwxr-xr-x 16 jenkins jenkins 4096 Mar 25 13:52 ..
drwxr-xr-x  8 jenkins jenkins 4096 Mar 25 15:36 .git
-rw-r--r--  1 jenkins jenkins  504 Mar 25 13:52 Jenkinsfile
-rw-r--r--  1 jenkins jenkins   36 Mar 25 13:52 README.md
-rw-r--r--  1 jenkins jenkins   31 Mar 25 15:36 file.txt
-rw-r--r--  1 jenkins jenkins  180 Mar 25 14:17 index.html
Publish artifacts to S3 Bucket Build is still running
Publish artifacts to S3 Bucket Using S3 profile: Jenkins
Publish artifacts to S3 Bucket bucket=my.bucket.for.upload.jenkins47, file=Jenkinsfile region=us-east-1, will be uploaded from slave=false managed=false , server encryption false
Publish artifacts to S3 Bucket bucket=my.bucket.for.upload.jenkins47, file=README.md region=us-east-1, will be uploaded from slave=false managed=false , server encryption false
Publish artifacts to S3 Bucket bucket=my.bucket.for.upload.jenkins47, file=index.html region=us-east-1, will be uploaded from slave=false managed=false , server encryption false
Finished: SUCCESS
```

# Поднять базу данных и при коммите в репу(в репе должен передаваться SELECT запрос) дергается Jenkins джоба, которая забирает этот запрос, делает бэкап базы и закидывает на S3 и выполняет этот запрос и закидывает результат на S3(можно использовать базу, которую проходили в курсе)

```groovy
pipeline {
  agent any
  stages {
    stage('First step') {
      steps {
        sh 'echo "Hello "'
      }
    }
    stage('Two step') {
      steps {
        sh 'mysql -u root -ppassword -e \'SELECT * FROM tourneys;\' days > /home/ubuntu/workspace/BackBase/test.txt'
      }
    }
    stage('Dump step') {
      steps {
        sh 'mysqldump -u root -ppassword days > /home/ubuntu/workspace/BackBase/dump.sql'
      }
    }

   stage('S3Copy step') {
      steps {
       s3Upload consoleLogLevel: 'INFO', dontSetBuildResultOnFailure: false, dontWaitForConcurrentBuildCompletion: false, entries: [[bucket: 'my.bucket.for.upload.jenkins47', excludedFile: 'Jenkinsfile', flatten: false, gzipFiles: false, keepForever: false, managedArtifacts: false, noUploadOnFailure: false, selectedRegion: 'us-east-1', showDirectlyInBrowser: false, sourceFile: '*/', storageClass: 'STANDARD', uploadFromSlave: true, useServerSideEncryption: false]], pluginFailureResultConstraint: 'FAILURE', profileName: 'Jenkins', userMetadata: [] 
      }
    }  
  }
}
```

# У нас есть любой python code(лучше взять свой код, когда мы писали flask приложение). При пуше в репу мы забираем этот код(должны быть настроены git credentials), запускаем pytests и дальше собираем Docker container и закидываем его на Docker Hub(лучше в ecr в aws, но там ограничения по фри тир, нужно посмотреть).

```json
pipeline {
  environment {
    imagename = "jekanik/project-build"
    registryCredential = 'git'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        checkout scm 

      }
    }
  
  stage("Prepare build image") {
            steps {
                sh "docker build -f Dockerfile . -t jekanik/project-build:${BUILD_ID}"
                sh "docker login -u jekanik -p${password}"
                sh "docker push jekanik/project-build:${BUILD_ID}"
            }
        }
  }
}
```
## Выполнить задания через Jenkinsfile
