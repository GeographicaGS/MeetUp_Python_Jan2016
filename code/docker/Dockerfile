##
# geographica/gdal2
#
# This creates an Ubuntu derived base image that installs GDAL 2.
#
# GDAL 2 on Ubuntu 14.04 Trusty Tahyr
FROM geographica/gdal2:v2.0.1

MAINTAINER Cayetano Benavent <cayetano.benavent@geographica.gs>

# Install basic dependencies
RUN apt-get update -y && apt-get install -y \
    libmapnik2.2 \
    python-mapnik \
    git \
    python-pip \
    libpng12-dev \
    python-cffi \
    wget

RUN pip install geomag \
    && cd /home \
    && git clone https://github.com/GeographicaGS/MeetUp_Python_Jan2016.git \
    && cd MeetUp_Python_Jan2016/code \
    && git submodule add https://github.com/GeographicaGS/Equidna.git \
    && git submodule add https://github.com/cayetanobv/declinationmap.git
    
