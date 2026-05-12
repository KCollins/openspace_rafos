# Making 3D printed DEMs with QGIS

## Setup
 - [x] Request an API key on opentopography.org. Save the text of the API Key locally; you will need to paste it in later.
 - [ ] Install QGIS.
 - [ ] In QGIS, download OpenTopography plugin (Plugins > Manage and Install Plugins > search and install). This will create an OpenTopography icon on your taskbar at the top of the screen.
 - [ ] Search and install the QuickMapServices plugin, wich will create an icon next to it.
 - [ ] Install [DEMto3D plugin](https://demto3d.com/en/descarga-e-instalacion/): Download the zip file from Github (On [this page](https://github.com/jawensi/DEMto3D-QGIS-Plugin), click Clone > Download Zip). In QGIS > Plugins > Manage and Install Plugins, click Install From ZIP and select the zip file from your Downloads folder. Once it is installed, a DEM to 3D menu should appear in QGIS under the Raster menu at the verty top of the page.

 ## Basic Procedure for Generating STM
 - [ ] Open a basemap using QuickMapServices (ESRI Ocean is a solid choice) and zoom in to the area that you want to print.
 - [ ] Click the OpenTopography icon on the task bar. For Extents, click the button to the right, which will set the lat/lon to the window zoom level. Paste in your API key and click Run. (Once the process has been run once, your key should be saved automatically into QGIS.) This will load a DEM of that region into your project.
 - [ ] Go to Raster > DEM to 3D. It will open a window where you can add your printing specs as shown below. .2mm is a good number for spacing. Once you add the desired width, the scale properties should automatically populate. Vertical exaggeration should probably be higher than you think; an exaggeration of 1x won't show up. Make sure Terrain Inversion is off (unless you are making a stamp).

<img width="1278" height="682" alt="image" src="https://github.com/user-attachments/assets/85712c9b-16e9-4e03-815a-962e616cc7c7" />
___________________________________
## \TODO
 - [ ] We want to print maps of the South Pacific. How do we wrap around the map view in QGIS? Include instructions for this.
 - [ ] Add instructions for adding in isobaths
 - [ ] Figure and document: merge DEMs
 - [ ] Add in RAFOS data (and instructions for symbology)
 - [ ] Figure and document: convert RAFOS tracks to DEMs (and then merge)

