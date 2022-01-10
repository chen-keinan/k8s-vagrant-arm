# kubernetes-vagrantfile

vagrant file to be used for k8s associated  programs developments, file include :
- ubuntu 20.04 arm 
- minikube
- dlv for remote debug

## Quick Start

```
 # git clone git@github.com:chen-keinan/k8s-vagrant-arm.git
 # cd kubernetes-vagrantfile
 # vagrant up
 # vagrant ssh
```


### Compile binary with debug params
```
GOOS=linux GOARCH=arm64 go build -v -gcflags='-N -l' demo.go
```
### Run debug on remote machine
```
dlv --listen=:2345 --headless=true --api-version=2 --accept-multiclient exec ./demo
```

### Tear down
```
 vagrant destroy

