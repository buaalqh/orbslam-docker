ORB_SLAM2 Docker Image
=========================
**Authors:** [Qihao LIU](https://www.linkedin.com/in/qihao-liu-b66901164/) (Engineer 2A at CentraleSupelec in France)

**30 May 2020**: ORB_SLAM2 based on [Ubuntu 20.04-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop#docker-ubuntu-vnc-desktop)

[![Docker Pulls](https://img.shields.io/docker/pulls/qihaoliu/orbslam2-docker.svg)](https://hub.docker.com/r/qihaoliu/orbslam2-docker/)
[![Docker Stars](https://img.shields.io/docker/stars/qihaoliu/orbslam2-docker.svg)](https://hub.docker.com/r/qihaoliu/orbslam2-docker/)

- Provide [ORB_SLAM2](https://github.com/raulmur/ORB_SLAM2) operating environment and [source code](https://github.com/buaalqh/orbslam2);
- All routines have been compiled;
- Provides VNC visualization interface in Desktop or [ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop#docker-ubuntu-vnc-desktop) to access Ubuntu 20.04 LXDE and LXQT desktop environment.

Quick Start
-------------------------

![](https://kangaroot.net/sites/default/files/styles/large/public/field/image/docker.png?itok=BMtmNeQO)

![](https://img.shields.io/docker/pulls/qihaoliu/orbslam2-docker.svg)  ![](https://img.shields.io/docker/stars/qihaoliu/orbslam2-docker.svg)


## Get image
### Pull the image from DockerHub:
```
docker pull qihaoliu/orbslam2-docker:v2.0
```
![](https://github.com/buaalqh/Git-Operation-commands/blob/master/Images/orbslam2-docker2.0-1.jpg)
### Or use Dockerfile to build locally:
```
git clone https://github.com/buaalqh/orbslam-docker.git
cd ./orbslam-docker
docker build -t qihaoliu/orbslam2-docker:v2.0 .
```
## Run the docker container
### Download Dataset
This ORB_SLAM2 routine provides a demonstration program for the [KITTI odometry](http://www.cvlibs.net/datasets/kitti/eval_odometry.php)  Dataset. Here, using sequence 04 in [data_odometry_gray](http://www.cvlibs.net/datasets/kitti/eval_odometry.php).
### Create container
Execute the following command to instantiate the container:
```
docker run -it --rm -v YOUR_PATH_TO_KITTI/sequences/04:/root/Dataset/04 -p 6080:80 -p 5900:5900 qihaoliu/orbslam2-docker:v2.0
```
### Connect VNC Desktop port 5900 to host: 
Then open VNC Viewer Desktop and use adress `localhost:5900` to connect. And in this image, the access is `free (no password)` as default. 
(Note: `docker toolbox` in wins, the adress of localhost is a special adress assigned to your docker VM, ex: `http://192.168.xx.xx:5900/`)

![](https://github.com/buaalqh/Git-Operation-commands/blob/master/Images/orbslam2-docker2.0-2.jpg)

### Connect VNC web port 6080 in browser (ex: `http://192.168.xx.xx:6080/` ): 
![](https://github.com/buaalqh/Git-Operation-commands/blob/master/Images/orbslam2-docker2.0-3.jpg)

Note: If you would like to protect vnc service by password, set environment variable VNC_PASSWORD, for example
```
docker run -it --rm -e VNC_PASSWORD=mypassword -v YOUR_PATH_TO_KITTI/sequences/04:/root/Dataset/04 -p 6080:80 -p 5900:5900 qihaoliu/orbslam2-docker:v2.0
```
A prompt will ask password either in the browser or vnc viewer.

### Pangolin routines
```
cd /slam/ORB_SLAM2/ORB_SLAM2
./Examples/Stereo/stereo_kitti Vocabulary/ORBvoc.txt Examples/Stereo/KITTI04-12.yaml /root/Dataset/04
```
![](https://github.com/buaalqh/Git-Operation-commands/blob/master/Images/orbslam2-docker2.0-4.jpg)

## End