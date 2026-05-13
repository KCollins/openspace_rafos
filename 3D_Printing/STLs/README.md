# Example STLs

## Tonga
This file includes the Tonga exclusive economic zone (EEZ). We imported the DEM from GEBCO using OpenTopography, and used the Processing raster calculator to add 10000 (which....sort of worked?) We used a vertical exaggeration of 5, a base height of 2mm and a model height of 20mm. The file was then simplified in Orca slicer using default options.

| Coordinate | Degrees |
|------------|---------|
| Min Lat    | -24     |
| Max Lat    | -14     |
| Min Lon    | -180    |
| Max Lon    | -171    |

## Gulf of Mexico with Isobaths
This file was produced using a vertical exaggeration of 20, a height of 20 mm and a base height of 2mm, then simplified using default options in OrcaSlicer. The isobaths were added with the Raster Calculator using this expression:
```
( ("GEBCOSubIceTopo[Memory]@1" >= -2050 AND "GEBCOSubIceTopo[Memory]@1" <= -1950) OR ("GEBCOSubIceTopo[Memory]@1" >= -3050 AND "GEBCOSubIceTopo[Memory]@1" <= -2950) OR ("GEBCOSubIceTopo[Memory]@1" >= -4050 AND "GEBCOSubIceTopo[Memory]@1" <= -3950) ) * ("GEBCOSubIceTopo[Memory]@1" + 10200)
+ 
( ("GEBCOSubIceTopo[Memory]@1" < -2050 OR "GEBCOSubIceTopo[Memory]@1" > -1950) AND ("GEBCOSubIceTopo[Memory]@1" < -3050 OR "GEBCOSubIceTopo[Memory]@1" > -2950) AND ("GEBCOSubIceTopo[Memory]@1" < -4050 OR "GEBCOSubIceTopo[Memory]@1" > -3950) ) * ("GEBCOSubIceTopo[Memory]@1" + 10000)
```
