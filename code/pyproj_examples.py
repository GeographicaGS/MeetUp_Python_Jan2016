# -*- coding: utf-8 -*-
#
#  Author: Cayetano Benavent, 2016.
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

import pyproj


def runTest01(x1, y1):
    p1 = pyproj.Proj(init='epsg:25830')
    p2 = pyproj.Proj(init='epsg:25829')

    x2, y2 = pyproj.transform(p1,p2,x1,y1)
    return(x2,y2)

def runTest02(x1, y1):
    p1 = pyproj.Proj(proj='utm',zone=30,ellps='GRS80',towgs84='0,0,0,0,0,0,0',units='m')
    p2 = pyproj.Proj(proj='utm',zone=29,ellps='GRS80',towgs84='0,0,0,0,0,0,0',units='m')

    x2, y2 = pyproj.transform(p1,p2,x1,y1)

    return(x2,y2)

if __name__ == "__main__":

    x1, y1 = (209105,4138693)

    res01 = runTest01(x1, y1)
    res02 = runTest02(x1, y1)

    print("x1, y1: {0},{1}\nTest01: {2}\nTest02: {3}".format(x1, y1, res01, res02))
