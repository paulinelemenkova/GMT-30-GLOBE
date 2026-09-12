# GMT GLOBE — GLOBE DEM Conversion and Mosaicking Script

A GMT (Generic Mapping Tools) shell script documenting how to import, convert and mosaic the GLOBE digital elevation model. GLOBE (Global Land One-km Base Elevation) is a 30-arc-second global land DEM distributed as gridded binary tiles; the script converts those tiles to GMT grids, assembles them into a global dataset and renders the relief. It supports the data-preparation steps behind the author's cartographic and geophysical mapping workflows.

## What the script does

- converts a raw GLOBE binary tile (16-bit signed integers) to a GMT .grd grid with xyz2grd, setting the region, 30-arc-second increment, nodata flag and the ZTLh binary layout (-R -I30c -N-9999 -ZTLh)
- renders a converted tile as a shaded relief image (grdimage) and exports it (psconvert)
- batch-converts all tiles at once with a shell loop over the four latitude bands and longitude columns
- mosaics the converted grids into a single global XYZ file (grd2xyz, sort)

## Data source

GLOBE (Global Land One-km Base Elevation Project), NOAA/NGDC: 30-arc-second global land elevation, distributed as 16-bit signed-integer binary tiles.

## Requirements

- GMT 6.x (Generic Mapping Tools): https://www.generic-mapping-tools.org
- A POSIX shell (bash/sh)
- The GLOBE binary tiles (e.g. a10g, ...) downloaded locally

## Usage

Place the GLOBE binary tiles in the working directory, adjust the -R region for the tile(s) of interest, then run:

    bash GMT-30-GLOBE.sh

The single-tile section writes a PostScript file and converts it to a raster image (JPG/PNG); the loop and mosaic sections produce per-tile grids and a combined global XYZ file.

## Author

Polina Lemenkova
ORCID: https://orcid.org/0000-0002-5759-1089

This script supports the data-preparation steps behind the author's cartographic and geophysical papers. The full publication list is available via the ORCID record above.

## License

See the LICENSE file in this repository.
