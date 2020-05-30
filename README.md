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
<img src="https://github.com/buaalqh/Git-Operation-commands/blob/master/Images/orbslam2-docker2.0-1.jpg" width=700/>
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

<img src="https://github.com/buaalqh/Git-Operation-commands/blob/master/Images/orbslam2-docker2.0-2.jpg" width=500/>

### Connect VNC web port 6080 in browser (ex: `http://192.168.xx.xx:6080/` ): 
<img src="https://github.com/buaalqh/Git-Operation-commands/blob/master/Images/orbslam2-docker2.0-3.jpg" width=700/>

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
<img src="https://github.com/buaalqh/Git-Operation-commands/blob/master/Images/orbslam2-docker2.0-4.jpg" width=700/>

## End

# ORB-SLAM2
**Authors:** [Raul Mur-Artal](http://webdiis.unizar.es/~raulmur/), [Juan D. Tardos](http://webdiis.unizar.es/~jdtardos/), [J. M. M. Montiel](http://webdiis.unizar.es/~josemari/) and [Dorian Galvez-Lopez](http://doriangalvez.com/) ([DBoW2](https://github.com/dorian3d/DBoW2))

**13 Jan 2017**: OpenCV 3 and Eigen 3.3 are now supported.

**22 Dec 2016**: Added AR demo (see section 7).

ORB-SLAM2 is a real-time SLAM library for **Monocular**, **Stereo** and **RGB-D** cameras that computes the camera trajectory and a sparse 3D reconstruction (in the stereo and RGB-D case with true scale). It is able to detect loops and relocalize the camera in real time. We provide examples to run the SLAM system in the [KITTI dataset](http://www.cvlibs.net/datasets/kitti/eval_odometry.php) as stereo or monocular, in the [TUM dataset](http://vision.in.tum.de/data/datasets/rgbd-dataset) as RGB-D or monocular, and in the [EuRoC dataset](http://projects.asl.ethz.ch/datasets/doku.php?id=kmavvisualinertialdatasets) as stereo or monocular. We also provide a ROS node to process live monocular, stereo or RGB-D streams. **The library can be compiled without ROS**. ORB-SLAM2 provides a GUI to change between a *SLAM Mode* and *Localization Mode*, see section 9 of this document.

<a href="https://www.youtube.com/embed/ufvPS5wJAx0" target="_blank"><img src="http://img.youtube.com/vi/ufvPS5wJAx0/0.jpg" 
alt="ORB-SLAM2" width="240" height="180" border="10" /></a>
<a href="https://www.youtube.com/embed/T-9PYCKhDLM" target="_blank"><img src="http://img.youtube.com/vi/T-9PYCKhDLM/0.jpg" 
alt="ORB-SLAM2" width="240" height="180" border="10" /></a>
<a href="https://www.youtube.com/embed/kPwy8yA4CKM" target="_blank"><img src="http://img.youtube.com/vi/kPwy8yA4CKM/0.jpg" 
alt="ORB-SLAM2" width="240" height="180" border="10" /></a>


### Related Publications:

[Monocular] Raúl Mur-Artal, J. M. M. Montiel and Juan D. Tardós. **ORB-SLAM: A Versatile and Accurate Monocular SLAM System**. *IEEE Transactions on Robotics,* vol. 31, no. 5, pp. 1147-1163, 2015. (**2015 IEEE Transactions on Robotics Best Paper Award**). **[PDF](http://webdiis.unizar.es/~raulmur/MurMontielTardosTRO15.pdf)**.

[Stereo and RGB-D] Raúl Mur-Artal and Juan D. Tardós. **ORB-SLAM2: an Open-Source SLAM System for Monocular, Stereo and RGB-D Cameras**. *IEEE Transactions on Robotics,* vol. 33, no. 5, pp. 1255-1262, 2017. **[PDF](https://128.84.21.199/pdf/1610.06475.pdf)**.

[DBoW2 Place Recognizer] Dorian Gálvez-López and Juan D. Tardós. **Bags of Binary Words for Fast Place Recognition in Image Sequences**. *IEEE Transactions on Robotics,* vol. 28, no. 5, pp.  1188-1197, 2012. **[PDF](http://doriangalvez.com/php/dl.php?dlp=GalvezTRO12.pdf)**

# 1. License

ORB-SLAM2 is released under a [GPLv3 license](https://github.com/raulmur/ORB_SLAM2/blob/master/License-gpl.txt). For a list of all code/library dependencies (and associated licenses), please see [Dependencies.md](https://github.com/raulmur/ORB_SLAM2/blob/master/Dependencies.md).

For a closed-source version of ORB-SLAM2 for commercial purposes, please contact the authors: orbslam (at) unizar (dot) es.

If you use ORB-SLAM2 (Monocular) in an academic work, please cite:

    @article{murTRO2015,
      title={{ORB-SLAM}: a Versatile and Accurate Monocular {SLAM} System},
      author={Mur-Artal, Ra\'ul, Montiel, J. M. M. and Tard\'os, Juan D.},
      journal={IEEE Transactions on Robotics},
      volume={31},
      number={5},
      pages={1147--1163},
      doi = {10.1109/TRO.2015.2463671},
      year={2015}
     }

if you use ORB-SLAM2 (Stereo or RGB-D) in an academic work, please cite:

    @article{murORB2,
      title={{ORB-SLAM2}: an Open-Source {SLAM} System for Monocular, Stereo and {RGB-D} Cameras},
      author={Mur-Artal, Ra\'ul and Tard\'os, Juan D.},
      journal={IEEE Transactions on Robotics},
      volume={33},
      number={5},
      pages={1255--1262},
      doi = {10.1109/TRO.2017.2705103},
      year={2017}
     }