FROM ubuntu:16.04
MAINTAINER Qihao LIU <qihao.liu@student-cs.fr>

# Install cmake and git in ubuntu 16.04
# Get dependencies for Pangolin (logical for visualization and user interface)
RUN apt-get update && apt-get install -y \
        libgtk2.0-dev \
        libjpeg-dev \
        libjasper-dev \
        libglew-dev \
        libpython2.7-dev \
        libboost-thread-dev \
        libboost-filesystem-dev

# Get dependencies for OpenCV
RUN apt-get update && apt-get install -y \
        build-essential cmake pkg-config \
        libgtk2.0-dev libavcodec-dev libavformat-dev libjpeg.dev libtiff4.dev libswscale-dev libjasper-dev \ 
        htop nano wget git unzip \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV OPENCV 3.4.1

# Install OpenCV
RUN cd /root && \
    wget https://github.com/opencv/opencv/archive/3.4.1.zip && \
    unzip 3.4.1.zip && \
    cd opencv-3.4.1 && mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_CUDA=OFF -D WITH_OPENGL=OFF .. && \
    make && make install

# Install Pangolin
RUN cd /root && \
    git clone https://github.com/stevenlovegrove/Pangolin.git && \
	cd Pangolin && mkdir build && cd build && \
	cmake .. && \
    make && make install

#Install Eigen3
RUN cd /root && \
    wget http://bitbucket.org/eigen/eigen/get/3.2.10.tar.gz -O eigen3.tgz && \
    tar zxvf eigen3.tgz && cd  eigen-eigen-b9cd8366d4e8 && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=RELEASE .. && \
    make install && \
    rm -rf /root/*

# Intsall Sophus
RUN cd /root && \
    git clone https://github.com/strasdat/Sophus.git && \
    cd Sophus && git checkout a621ff && mkdir build && cd build && \
    cmake .. && make && \
    rm -rf /root/*

# Get orb-slam2 from github
RUN mkdir -p /slam
WORKDIR /slam
RUN cd /slam && \
    git clone https://github.com/buaalqh/orbslam2.git && \
    cd orbslam2/ORB_SLAM2 && chmod +x build.sh && sh build.sh

# Enable remote access to the Docker container desktop by VNC
ENV	DEBIAN_FRONTEND noninteractive

RUN	apt-get update -y && apt-get install -y \
	openssh-server xfce4 xfce4-goodies x11vnc sudo bash xvfb && \
	useradd -ms /bin/bash ubuntu && echo 'ubuntu:ubuntu' | chpasswd && \
	echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && apt-get clean && \
	rm -rf /var/lib/apt/lists/*
# configuration remote vnc desktop
# congifuration Virtual display server
# start vnc server
COPY 	x11vnc /etc/init.d/
COPY 	xvfb /etc/init.d/  
COPY 	entry.sh /  

RUN 	sudo chmod +x /entry.sh /etc/init.d/*
# port for connecting VNC
EXPOSE 	5900

ENTRYPOINT [ "/entry.sh" ]

#######################
#RUN 
# docker pull qihaoliu/orbslam2-docker:v1.0
# docker build -t qihaoliu/orbslam2-docker:v1.0 .
# docker run -it --rm -v /c/Users/LQH/Documents/docker-share/04:/root/Dataset/04 -p 5900:5900 qihaoliu/orbslam2-docker:v1.0
# cd /slam/orbslam2/ORB_SLAM2
# ./Examples/Stereo/stereo_kitti Vocabulary/ORBvoc.txt Examples/Stereo/KITTI04-12.yaml /root/Dataset/04
#######################