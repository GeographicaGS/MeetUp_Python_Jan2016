# -*- coding: utf-8 -*-
#
#  Author: Cayetano Benavent, 2016.
#  cayetano.benavent@geographica.gs
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#


import numpy as np
from shapely.wkt import loads
from shapely.geometry import LineString


def runTest01():
    wkt_ln = "LINESTRING(178044.505034367 4080523.32981373,185051.202770193 4115968.97717771,218436.056686834 4125036.46836944,231625.134776712 4158833.48097265,229564.341325156 4174495.51120244,216787.42192546 4189333.22405021,212253.676331916 4213238.42808471,216787.421925395 4231373.41045699)"

    ln = loads(wkt_ln)
    ln_np = np.array(ln)

    ln_buf = ln.buffer(20000)

    return(ln_np, ln_buf.wkt)

def runTest02():
    lat = np.array([88.2598888, 87.8656022505306, 87.47131570106119, 87.07729258677767, 86.68423509786567, 86.29117760895366, 85.89812012004164, 85.50506263112963, 85.11200514221763, 84.71894765330562, 84.35408870391326, 84.00746812090851, 83.66121815097686, 83.31589924664645, 82.96712093784359, 82.6290776997575, 82.25749423519197, 81.87712508822979, 81.49675594126761, 81.09931880902852, 80.6998987769223, 80.38219308946239, 80.06394742324582, 79.70348526693819, 79.58169647523991, 79.7679112, 79.7679112])
    lon = np.array([49.7934288, 49.86079434688794, 49.92815989377588, 49.99699057427323, 50.07119172258097, 50.14539287088871, 50.21959401919645, 50.2937951675042, 50.367996315811936, 50.44219746411967, 50.59280312395832, 50.792436728275504, 50.99271393197662, 51.19459015098207, 51.390376419073085, 51.60421432299298, 51.746632193203595, 51.87040340164587, 51.99417461008816, 52.02591753929958, 52.04744979306631, 51.826426464592416, 51.58531405704919, 51.43357869745786, 51.39167315475912, 51.3637112, 51.3637112])

    coor = np.vstack((lon, lat))
    coor_t = coor.T

    ln = LineString(coor_t)

    ln_wkt = ln.wkt

    return(ln_wkt)

if __name__ == '__main__':
    res01 = runTest01()
    res02 = runTest02()

    print("Test01 array: {}\n".format(res01[0]))
    print("Test01 buff wkt: {}\n".format(res01[1]))
    print("Test02 wkt: {}\n".format(res02))
