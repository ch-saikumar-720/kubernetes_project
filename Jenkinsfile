pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
    ECR_REGISTRY = '211125549407.dkr.ecr.us-east-1.amazonaws.com'
    REPO_NAME = 'kubes'
    CLUSTER_NAME = 'your-eks-cluster-name'
    BACKEND_IMAGE = "${ECR_REGISTRY}/${REPO_NAME}/backend:latest"
    FRONTEND_IMAGE = "${ECR_REGISTRY}/${REPO_NAME}/frontend:latest"
  }

  stages {
    stage('Checkout Code from GitHub') {
      steps {
        // Clone the GitHub repository
        git 'https://github.com/ch-saikumar-720/flask-app-by-saikumar.git'
      }
    }

    stage('Login to ECR') {
      steps {
        sh '''
          aws ecr get-login-password --region $AWS_REGION | \
            docker login --username AWS --password-stdin $ECR_REGISTRY
        '''
      }
    }

    stage('Build and Push Backend') {
      steps {
        dir('backend') {
          sh '''
            docker build -t $BACKEND_IMAGE .
            docker push $BACKEND_IMAGE
          '''
        }
      }
    }

    stage('Update Kubeconfig') {
      steps {
        sh '''
          aws eks --region $AWS_REGION update-kubeconfig --name $CLUSTER_NAME
        '''
      }
    }

    stage('Deploy to EKS') {
      steps {
        sh '''
          kubectl apply -f k8s/mysql.yaml
          kubectl apply -f k8s/backend.yaml
        '''
      }
    }

    stage('Get Backend Load Balancer DNS') {
      steps {
        script {
          // Get the DNS name of the backend LoadBalancer
          def lb_dns = sh(script: "kubectl get svc backend-service -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}'", returnStdout: true).trim()
          echo "Backend Load Balancer DNS: $lb_dns"

          // Replace the backend URL in signup.js and login.js with the backend Load Balancer DNS
          sh """
            sed -i 's|http://backend-service|http://$lb_dns|' frontend/src/signup.js
            sed -i 's|http://backend-service|http://$lb_dns|' frontend/src/login.js
          """
        }
      }
    }

    stage('Build and Push Frontend') {
      steps {
        dir('frontend') {
          sh '''
            docker build -t $FRONTEND_IMAGE .
            docker push $FRONTEND_IMAGE
          '''
        }
      }
    }

    stage('Deploy Frontend to EKS') {
      steps {
        sh '''
          kubectl apply -f k8s/frontend.yaml
        '''
      }
    }
  }
}
