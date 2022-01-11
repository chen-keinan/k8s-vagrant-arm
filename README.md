# kubernetes-vagrantfile

vagrant file to be used for k8s associated programs developments, file include with parallels instead of virtualbox:
- ubuntu 20.04 arm 
- parallels (must be installed)
- minikube
- dlv for remote debug

## Quick Start

```shell
  git clone git@github.com:chen-keinan/k8s-vagrant-arm.git
  cd kubernetes-vagrantfile
  vagrant plugin install vagrant-parallels
  vagrant up
  vagrant ssh
```


### Compile binary with debug params
```shell
GOOS=linux GOARCH=arm64 go build -v -gcflags='-N -l' demo.go
```
### Run debug on remote machine
```shell
dlv --listen=:2345 --headless=true --api-version=2 --accept-multiclient exec ./demo
```

### Tear down
```shell
 vagrant destroy

