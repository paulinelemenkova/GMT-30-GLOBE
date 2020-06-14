#!/bin/sh

#GLOBE is short for Global Land One-km Base Elevation Project. It is a Digital Elevation Model (DEM).
#Coverage: covers the complete land surface in a resolution of 30 arc seconds, which is twice as high as ETOPO.
#Download: http://www.ngdc.noaa.gov/mgg/topo/gltiles.html

#Conversion to xyz format
#The data is given in gridded binary files, with the elevation stored as 16-bit signed integer numbers.
#These files can be converted to the GMT *.grd format as follows:

xyz2grd a10g -Ggrid_textGLOBE.grd -R-180/-90/50/90 -I30c -N-9999 -V -F -ZTLh

ps=GLOBE.ps

# visualization
gmt grdimage grid_textGLOBE.grd -Csrtm -R-180/-90/50/90 -JQ5.0i -P -I+a15+ne0.75 -Xc > $ps
# Convert to image file using GhostScript
gmt psconvert GLOBE.ps -A0.5c -E720 -Tj -Z

# in order to convert all files at once (in the bash shell):

FILES=(*10g)
LAT_S=(50 0 -50 -90)
LAT_N=(90 50 0 -50)
for((y=0; y<=3; y++)); do
    for(( x=0; x<=3; x++)); do
        REGION="$((-180+$x*90))/$((-90+$x*90))/${LAT_S[$y]}/${LAT_N[$y]}"
        xyz2grd ${FILES[$(($y*4+$x))]} -G${files[$(($y*3+$x))]}.grd -R$REGION -I30c -N-9999 -V -F -ZTLh
    done
done

#Then, to get a global xyz file:

{ for i in *.grd; do grd2xyz $i; done; } | sort -k2nr -k1n > globe.xyz

# Source: http://www.earthmodels.org/data-and-tools/topography/globe
