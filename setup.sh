echo "start vagrant provioning..."

sudo apt update
sudo apt upgrade -y
curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh

sudo usermod -aG docker $USER 

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-arm64 \
&& chmod +x minikube

sudo mv minikube /usr/local/bin/

sudo minikube start --driver=none
sudo apt install conntrack -y
sudo minikube start --driver=none

cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/arm64/kubectl"
chmod +x ./kubectl
sudo mv kubectl /usr/local/bin/kubectl
kubectl version --clientClient Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.6", GitCommit:"dff82dc0de47299ab66c83c626e08b245ab19037", GitTreeState:"clean", BuildDate:"2020-07-15T16:58:53Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"linux/arm64"}

sudo kubectl create deployment whoami --image=containous/whoami
sudo kubectl expose deployment whoami --type=LoadBalancer --port=80

echo "install golang pkg"
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update -y
sudo apt install -y golang-go 

echo "Install dlv pkg"
 git clone https://github.com/go-delve/delve.git $GOPATH/src/github.com/go-delve/delve
 cd $GOPATH/src/github.com/go-delve/delve
 make install

### export dlv bin path
export PATH=$PATH:/home/vagrant/go/bin

echo "Finished provisioning."
