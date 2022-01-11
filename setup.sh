echo "start vagrant provioning..."

sudo apt update
sudo apt upgrade -y
curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh

sudo usermod -aG docker $USER 

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-arm64 \
&& chmod +x minikube

sudo mv minikube /usr/local/bin/

sudo minikube start --driver=none
sudo apt install conntrack git -y
sudo minikube start --driver=none

cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/arm64/kubectl"
chmod +x ./kubectl
mv kubectl /usr/local/bin/kubectl
kubectl version --clientClient Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.6", GitCommit:"dff82dc0de47299ab66c83c626e08b245ab19037", GitTreeState:"clean", BuildDate:"2020-07-15T16:58:53Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"linux/arm64"}

kubectl create deployment whoami --image=containous/whoami
kubectl expose deployment whoami --type=LoadBalancer --port=80

echo "install golang pkg"
wget https://dl.google.com/go/go1.16.4.linux-arm64.tar.gz
sudo tar -xvf go1.16.4.linux-arm64.tar.gz
sudo mv go /usr/local
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc 

cp /vagrant/id_rsa ~/.ssh/id_rsa
cp /vagrant/id_rsa.pub ~/.ssh/id_rsa.pub
touch ~/.ssh/config
echo 'Host github.com
    StrictHostKeyChecking no' >  ~/.ssh/config
mkdir ~/workspace
cd ~/workspace
git clone git@github.com:chen-keinan/kube-bench.git
cd /root 

echo "Install dlv pkg"
git clone https://github.com/go-delve/delve.git
cd /root/delve
make install

### export dlv bin path
echo 'export PATH=$PATH:/root/go/bin' >> .bashrc
echo -e "dev\ndev" | passwd root
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
service sshd restart
apt-get install build-essential -y
echo "Finished provisioning."
