# Making 3D printed DEMs with QGIS
These instructions were developed for QGIS 4.0.2-Norrköping. Later versions may have some interface changes. These are written with bathymetric maps in mind.

## Setup
 - [x] Request an API key on opentopography.org. Save the text of the API Key locally; you will need to paste it in later.
 - [ ] Install QGIS.
 - [ ] In QGIS, download OpenTopography plugin (Plugins > Manage and Install Plugins > search and install). Once installed, this will create an OpenTopography icon on your taskbar at the top of the screen.
 - [ ] Search and install the NextGIS QuickMapServices plugin, which will create an icon next to it.
 - [ ] Install [DEMto3D plugin](https://demto3d.com/en/descarga-e-instalacion/): Download the zip file from Github (On [this page](https://github.com/jawensi/DEMto3D-QGIS-Plugin), click Clone > Download Zip). In QGIS > Plugins > Manage and Install Plugins, click Install From ZIP and select the zip file from your Downloads folder. Once it is installed, a DEM to 3D menu should appear in QGIS under the Raster menu at the verty top of the page.
 - [ ] Optional: You may wish to set a default coordinate reference system. Navigate to Settings > Options > CRS and Transforms > CRS for Projects. (You will need to confirm that you'll be careful.) Near the top of the page, select "Use a Default CRS" and set it to EPSG:4326. This will keep your coordinates in lat/lon form. Under the "CRS for Layers" box, turn on the radio button for "Use project CRS" to keep point layers from sliding off the map later.

 ## Basic Procedure for Generating STL Files from Digital Elevation Models
 - [ ] Open a basemap using QuickMapServices (ESRI Ocean is a solid choice) and zoom in to the area that you want to print.
 - [ ] If you haven't set a default CRS: In the lower right-hand corner, select the map projection and change it to EPSG:4326-WGS84. This will cause the coordinates to appear in lat/lon, which will make it easier to set extents manually.
 - [ ] Click the OpenTopography icon on the task bar. For Extents, click the button to the right, which will set the lat/lon to the window zoom level (or type in your own as needed). Select a map of your choice; for bathymetry, you'll probably want one of the GEBCO maps. Paste in your API key and click Run. (Once the process has been run once, your key should be saved automatically into QGIS.) This will load a DEM of that region into your project.
 - [ ] If you're printing bathymetric data, you'll need to bring the DEM data above sea level for the 3D print to work well. Open Processing > Processing Toolbox > Raster analysis > Raster Calculator. Open "Input Layers" and select the DEM you imported before ("GEBCOSubIceTopo[Memory][EPSG:4326]", e.g.). If you want to flatten features above sea level, you'll need an expression like this: `("GEBCOSubIceTopo[Memory]@1" < 0) * "GEBCOSubIceTopo[Memory]@1"`. Next, add an offset slightly greater than whatever the lowest point is. For example, if your bathymetric map bottoms out at -9904 meters, add 10000. You can gauge this from the colormap shown in the Layers pane on the bottom left of the screen. You can do both of these in one smooth motion:
```
("GEBCOSubIceTopo[Memory]@1" < 0) * "GEBCOSubIceTopo[Memory]@1" +10000
```
Hit "Run" and you should see the appearance of a new layer, titled "Calculated." Select this layer and go to the next step.
 - [ ] Go to Raster > DEM to 3D. It will open a window where you can add your printing specs as shown below. .2mm is a good number for spacing. Once you add the desired width, the scale properties should automatically populate. Vertical exaggeration should probably be higher than you think; an exaggeration of 1x won't show up. Make sure Terrain Inversion is off (unless you are making a stamp).

<img width="1278" height="682" alt="image" src="https://github.com/user-attachments/assets/85712c9b-16e9-4e03-815a-962e616cc7c7" />


## Advanced Operations
### Adding isobaths
 - [ ] Open the Raster Calculator per above. Use an expression like this one for a -3000 m isobath:
     ```( "GEBCOSubIceTopo[Memory]@1" >= -3010 AND "GEBCOSubIceTopo[Memory]@1" <= -2990 ) * ("GEBCOSubIceTopo[Memory]@1" + 12000) + ( "GEBCOSubIceTopo[Memory]@1" < -3010 OR "GEBCOSubIceTopo[Memory]@1" > -2990 ) * ("GEBCOSubIceTopo[Memory]@1" + 10000)```
Depending on the location, you may want to vary the range and how much height you add to the isobath. 
 - [ ] Generate the STL as above.

### Adding Float Data
 - [ ] This repository includes [example RAFOS data](../Data). Download one of the CSV files with a depth column ([rafos1060_depth.csv](../Data/rafos1060_depth.csv), e.g.)
 - [ ] In QGIS, select Layer > Add Layer > Add Delimited Text Layer. This will open the Data Source Manager. To the right of "File Name", click the [...] button and select rafos1060.csv (or equivalent). Set X field to Longitude (W), Y field to Latitude (N). Set both the Z and M fields to Depth (m). Add the layer to the map. It should appear as a set of colored dots on your map.
 - [ ] In the Layers pane (bottom left), double-click the layer to open the Layer Properties window. Under the Symbology tab, select Simple Marker. Set the stroke color to transparent (Opacity = 0). Click "Apply." The borders should disappear from the colored dots on the map.
 - [ ] Next we'll set the colormap. In the Symbology window, click the spot that says "Simple Marker" near the top and change it to Graduated. Under the "Value" dropdown, select "Depth (m)." For "Mode", select "Equal Interval" and input under "Classes" how many gradations you want; I picked 10. (If you want to map your gradient more granularly, that's an option here as well.) Click the gradient next to "Color Ramp" and open a new window. Set it from black (Color 1) to white (Color 2) and hit OK. Click "Apply" to check the results; when you've got ones that you're happy with, click OK.
 - [ ] Select the point layer in the Layers pane. In the Raster menu, select Conversion > Rasterize (Vector to Raster).

___________________________________

## \TODO
 - [ ] Figure and document: Converting float data to raster (Processing Toolbox > Raster Tools > Convert map to raster ?)
 - [ ] Figure and document: merge DEMs
 - [ ] Add in RAFOS data (and instructions for symbology)
 - [ ] Figure and document: convert RAFOS tracks to DEMs (and then merge)

