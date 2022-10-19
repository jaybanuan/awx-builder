eval $(minikube docker-env)

docker pull quay.io/ansible/awx-ee:latest
docker pull redis:7
docker pull quay.io/ansible/awx-operator:0.30.0
docker pull quay.io/ansible/awx:21.7.0
docker pull postgres:13
docker pull gcr.io/kubebuilder/kube-rbac-proxy:v0.13.0
