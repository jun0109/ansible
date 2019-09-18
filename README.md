## 安裝 docker 前置套件
* 套件 
  + yum-utils
  + device-mapper-persistent-data
  + lvm2


## 安裝 docker 套件庫repo
* yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

* yum makecache fast

## 安裝 docker
* yum install docker-ce

## 啟動 docker
* systemctl start docker
* systemctl enable docker

## 啟動 docker compose
* yum install epel-release
* yum install -y python-pip
* pip install docker-compose
* yum upgrade python*
* docker-compose version

## 架構
```
.
├── ansible.cfg
├── docker-compose.yml
├── Dockerfile
├── Dockerfiles
│   ├── mysql
│   │   ├── conf
│   │   │   └── my.cnf
│   │   └── Dockerfile
│   ├── nginx1
│   │   ├── default.conf
│   │   ├── Dockerfile
│   │   ├── log
│   │   │   ├── access.log
│   │   │   └── error.log
│   │   ├── nginx
│   │   │   ├── access.log
│   │   │   └── error.log
│   │   ├── nginx.conf
│   │   ├── nginx.repo
│   │   ├── phpinfo.php
│   │   └── www
│   │       └── phpinfo.php
│   ├── nginx_php-fpm
│   │   └── Dockerfile
│   ├── php-fpm1
│   │   ├── Dockerfile
│   │   ├── phpinfo.php
│   │   └── phpredis
│   └── redis
│       ├── Dockerfile
│       └── redis.tar
├── group_vars
│   ├── aaa
│   │   └── var.yml
│   └── bbb
│       └── var.yml
├── hosts
├── README.md
├── roles
│   ├── cpu_check
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── vars
│   ├── harbor
│   │   ├── files
│   │   │   ├── phpinfo.php
│   │   │   ├── phpredis
│   │   │   └── supervisord.conf
│   │   └── tasks
│   │       └── main.yml
│   ├── k8s_master
│   │   ├── files
│   │   │   ├── admin-role.yaml
│   │   │   ├── kubernetes.repo
│   │   │   └── recommended.yaml
│   │   └── tasks
│   │       └── main.yml
│   ├── k8s_node
│   │   ├── files
│   │   │   └── kubernetes.repo
│   │   └── tasks
│   │       └── main.yml
│   ├── mount_check
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── vars
│   ├── network_check
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── vars
│   ├── os_check
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── vars
│   └── ram_check
│       ├── tasks
│       │   └── main.yml
│       └── vars
└── run.yml

```

## 建置images
* docker build -t [Dockerfiles Folder Name] .

## 查看images
* docker images

## 執行docker-compose
* docker-compose up -d

## 查看容器執行狀態
* docker ps -a

## 使用 ansible 檢查系統概要
使用 ansible 檢查虛擬機系統 。

## 環境
* ansible 
  + CentOS7
  + ansible2.7 

## 設定内容
* ansible.cfg
* hosts
* run.yml
  
## 安裝方法

* yum install ansible


## 設定方式
1. 創建 ansible.cfg - 指向 hosts
2. 創建 hosts - 寫入server IP
3. 創建 roles - 分層架構
4. 下指令 - ansible-playbook run.yml -e host=check -u root -k


## 變數更改設定方式
1. 檔案位置: vars/var.yml
2. 更改你想要的變數
