
# flask-app-by-saikumar
Here we have tried deploying the flask app with docker and kubernetes and accessing through ingress
**
**Requirements:****
•	EC2 instance that is deployed in same VPC as EKS cluster
•	EKS cluster
•	2 IAM Roles (EKS cluster role and Node group role)
•	ECR
**
**EC2 instance:****
•	Create a EC2 instance with VPC of EKS cluster of t2.medium type.
•	Install AWS CLI and Kubectl in the instance.
•	Configure the AWS account in the instance with Access key and secret access key.
•	Configure the ECR with account ID.
•	Install Docker to build images and push them to ECR

**EKS Cluster:**
•	Create a EKS cluster with a VPC of custom configuration
•	Turn off EKS Auto mode.
•	Select IAM role EKS type with policy  AmazonEKSClusterPolicy
•	End Point Public and private
**Node Group:**
•	Create a node group
•	Select IAM role EC2 type with policy AmazonEC2ContainerRegistryReadOnly, AmazonEKS_CNI_Policy & AmazonEKSWorkerNodePolicy
•	Select the subnets and instance type t3.medium with 20 GB 
•	Select the subnets and allow public access to them.    

**EC2 instance:**  
 As AWS is configured in the instance check the clusters using the command
aws eks list-clusters
Now configure the kube config file in the instance with command
aws eks --region us-east-1 update-kubeconfig --name your-cluster-name     
kubectl get nodes
if nodes are not loaded and getting error then
Open the cluster Security group and allow TCP port 443. Also make sure the instance is in same VPC.

**Docker images creation:**
Clone the repo from the github.
Mysql database container deployment in EKS:
use this to generate a mysql deployment and service yaml files
Mysql-deployment.yml
Generate a deployment file with empty dir persisted volume

kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml
kubectl get pods
kubectl get deploy
kubectl get svc       

**Backend flask container deployment:**
In the app.py change the DB HOST NAME as mysql which is the service name of the mysql container
 Build the docker image from the docker file with name backend
docker build -t backend .
docker images
docker tag backend 905418302596.dkr.ecr.us-east-1.amazonaws.com/kubecontainer:backend
## the URI is taken from the ECR repo with the name backend will be added
docker push 905418302596.dkr.ecr.us-east-1.amazonaws.com/kubecontainer:backend
## docker image will be pushed to the ECR repository

kubectl apply -f flask-app.yaml
kubectl get pods
kubectl get deploy
kubectl get svc       
Here the image will be taken from the ECR repo as URI with image name is specified and the time of service is LoadBalancer type.
Now access the load balance DNS address that will be given by the svc. The AWS will create the LoadBalancer and gives the link. Access in the chrome and check whether we get the message as the backend is ready.
http://a0106d62a969840c299ceaf1702766b2-933650728.us-east-1.elb.amazonaws.com:5000


**Frontend container deployment :**
Open the src/ folder and edit the Login.js and Signup.js
Here we have to change the backend request code. Replace the code with the load balancer DNS
Create the docker image and push to the repo with a name tag and mention the same name tag in the deployment.yml file.
The service type should be Load balancer type.
kubectl apply -f react-app.yaml
kubectl get pods
kubectl get deploy
kubectl get svc       
Here the image will be taken from the ECR repo as URI with image name is specified and the time of service is LoadBalancer type.
Now access the load balance DNS address that will be given by the svc. The AWS will create the LoadBalancer and gives the link. 

Access in the chrome with LoadBalance DNS we have the front end.

**Using ingress:**
. **Install NGINX Ingress Controller via Helm**

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install nginx-ingress ingress-nginx/ingress-nginx --create-namespace --namespace ingress-nginx

kubectl get pods -n ingress-nginx

kubectl get svc -n ingress-nginx

**Congifiguring Ingress:**

Create ingress yal files for both frontend and backend.
Change the service type to Cluster IP for both front end and backend.

first do the backend and check whether it is accessible through load baancer with /api.

then do changes in the frontend src folders Signup and Login files.
Add the backend ingress load balancer with namespace.

create the docker images and add it in the deployment and run the deployment again

Now wait for 2 mins and access the front end and check the backend communication.

