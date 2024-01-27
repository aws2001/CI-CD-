node('built-in'){
    stage('code download'){
        git 'https://github.com/aws2001/Project-for-development.git'
    }
    stage('send file to controller') {
        sshagent(['ansible']) {
        sh 'ssh -o StrictHostKeyChecking=no  ubuntu@4.240.69.50'
        sh 'scp -r /home/ubuntu/.jenkins/workspace/developer/* ubuntu@4.240.69.50:/home/ubuntu/developer'
        }
    }
    stage('build image') {
        sshagent(['ansible']) {
        sh 'ssh -o StrictHostKeyChecking=no  ubuntu@4.240.69.50 "cd /home/ubuntu/developer && sudo docker image build -t $JOB_NAME:v1.$BUILD_ID ."'
        sh 'ssh -o StrictHostKeyChecking=no  ubuntu@4.240.69.50 "cd /home/ubuntu/developer && sudo docker image tag $JOB_NAME:v1.$BUILD_ID 2001sonali/$JOB_NAME:latest"'
        sh 'ssh -o StrictHostKeyChecking=no  ubuntu@4.240.69.50 "cd /home/ubuntu/developer && sudo docker image tag $JOB_NAME:v1.$BUILD_ID 2001sonali/$JOB_NAME:v1.$BUILD_ID"'
        }
    }

    stage('send docker image to docker hub') {
        sshagent(['ansible']) {
        withCredentials([string(credentialsId: 'docker_hub', variable: 'docker_hub')]) {
        sh 'ssh -o StrictHostKeyChecking=no  ubuntu@4.240.69.50 "cd /home/ubuntu/developer && sudo docker login -u 2001sonali -p ${docker_hub}"'
        sh 'ssh -o StrictHostKeyChecking=no  ubuntu@4.240.69.50 "cd /home/ubuntu/developer && sudo docker image push 2001sonali/$JOB_NAME:latest"'
            }
        }
    }
}

