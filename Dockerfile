FROM dorowu/ubuntu-desktop-lxde-vnc
MAINTAINER Qihao LIU <qihao.liu@student-cs.fr>

# Install cmake and git in ubuntu 20.04-lxde-vnc
# Get dependencies for Pangolin (logical for visualization and user interface)
RUN apt-get update && apt-get install -y \
        libglew-dev \
        libpython2.7-dev \
        ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev \
        libdc1394-22-dev libraw1394-dev \
        libjpeg-dev libpng-dev libtiff5-dev libopenexr-dev 

# Get dependencies for OpenCV
RUN apt install libopencv-dev -y \
        build-essential cmake pkg-config \
        htop nano wget git unzip \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Pangolin
RUN cd /opt && \
    git clone https://github.com/stevenlovegrove/Pangolin.git && \
	cd Pangolin && mkdir build && cd build && \
	cmake .. && \
    make && make install && \
    rm -rf /opt/*
#Intsall Eigen3
RUN cd /opt && \
    wget http://bitbucket.org/eigen/eigen/get/3.2.10.tar.gz -O eigen3.tgz && \
    tar zxvf eigen3.tgz && cd  eigen-eigen-b9cd8366d4e8 && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=RELEASE .. && \
    make install && \
    rm -rf /opt/*


# Install OpenCV
RUN apt-get update -y && \  
    apt-get install -y python3-pip python3-dev && \
    pip3 install opencv-python

# Get orb-slam2 from github
RUN mkdir -p /slam
WORKDIR /slam
RUN cd /slam && \
    git clone https://github.com/buaalqh/ORB_SLAM2.git && \
    cd ORB_SLAM2/ORB_SLAM2 && chmod +x build.sh && sh build.sh

#######################
#RUN 
# docker build -t qihaoliu/orbslam2-docker:v2.0 .
# docker pull qihaoliu/orbslam2-docker:v2.0
# docker run -it --rm -v /c/Users/LQH/Documents/docker-share/04:/root/Dataset/04 -p 6080:80 -p 5900:5900 qihaoliu/orbslam2-docker:v2.0
# cd /slam/ORB_SLAM2/ORB_SLAM2
# ./Examples/Stereo/stereo_kitti Vocabulary/ORBvoc.txt Examples/Stereo/KITTI04-12.yaml /root/Dataset/04
#######################