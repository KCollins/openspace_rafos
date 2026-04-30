{
  "additional_scripts": [
    "openspace.setPropertyValueSingle(\"OpenSpaceEngine.PropertyVisibility\", 5.000000)",
    "openspace.setPropertyValueSingle(\"Modules.Telemetry.Enabled\", true)",
    "openspace.globebrowsing.loadWMSCapabilities(\"GEBCO\", \"Earth\", \"https://wms.gebco.net/2025/mapserv?/service=WMS&request=GetCapabilities\")",
    "openspace.globebrowsing.addLayer(                        'Earth',                         'ColorLayers',                         {                             Identifier = 'GEBCO_2025Grid-includingsubicetopography-shadedrelief',                            Name = 'GEBCO_2025 Grid - including sub ice topography - shaded relief',                            FilePath = 'WMS:https://wms.gebco.net/2025/mapserv?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&LAYERS=GEBCO_2025_SUB_ICE_TOPO&SRS=EPSG:4326&BBOX=-180.000000,-90.000000,360.000000,90.000000',                            Enabled = true                        }                    );",
    "openspace.globebrowsing.addLayer(                        'Earth',                         'HeightLayers',                         {                             Identifier = 'GEBCO_2025Grid-includingsubicetopography-shadedrelief',                            Name = 'GEBCO_2025 Grid - including sub ice topography - shaded relief',                            FilePath = 'WMS:https://wms.gebco.net/2025/mapserv?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&LAYERS=GEBCO_2025_SUB_ICE_TOPO&SRS=EPSG:4326&BBOX=-180.000000,-90.000000,360.000000,90.000000',                            Enabled = true                        }                    );",
    "openspace.setPropertyValue('Scene.EarthAtmosphere.Renderable.Enabled', false)",
    "openspace.setPropertyValue('Scene.Earth.Renderable.Layers.NightLayers.Earth_at_Night_2012.Enabled', false)",
    "openspace.fadeOut(\"Scene.ISS_trail.Renderable\")",
    "openspace.setPropertyValue('Scene.Tiangong_trail.Renderable.Enabled', false)",
    "openspace.setPropertyValue('Scene.EarthAtmosphere.Renderable.Enabled', false)",
    ""
  ],
  "assets": [
    "base",
    "base_keybindings",
    "events/toggle_sun",
    "scene/solarsystem/planets/earth/earth",
    "scene/solarsystem/planets/earth/satellites/satellites",
    "scene/solarsystem/planets/earth/noaa-sos/overlays/latlon_grid-white"
  ],
  "camera": {
    "altitude": 5000000.0,
    "anchor": "Earth",
    "latitude": 21.0,
    "longitude": -88.0,
    "type": "goToGeo"
  },
  "delta_times": [
    1.0,
    5.0,
    30.0,
    60.0,
    300.0,
    1800.0,
    3600.0,
    43200.0,
    86400.0,
    604800.0,
    1209600.0,
    2592000.0,
    5184000.0,
    7776000.0,
    15552000.0,
    31536000.0,
    63072000.0,
    157680000.0,
    315360000.0,
    630720000.0
  ],
  "keybindings": [
    {
      "action": "os.solarsystem.ToggleSatelliteTrails",
      "key": "S"
    },
    {
      "action": "os.solarsystem.FocusIss",
      "key": "I"
    },
    {
      "action": "os.solarsystem.FocusEarth",
      "key": "HOME"
    }
  ],
  "mark_nodes": [
    "Earth",
    "Mars",
    "Moon",
    "Sun",
    "Venus",
    "ISS"
  ],
  "meta": {
    "author": "OpenSpace Team",
    "description": "Default OpenSpace Profile. Adds Earth satellites not contained in other profiles.",
    "license": "MIT License",
    "name": "Default",
    "url": "https://www.openspaceproject.com",
    "version": "1.0"
  },
  "properties": [
    {
      "name": "{earth_satellites~space_stations}.Renderable.Enabled",
      "type": "setPropertyValue",
      "value": "false"
    },
    {
      "name": "Scene.Earth.Renderable.Layers.Overlays.noaa-sos-overlays-latlon_grid-white.Enabled",
      "type": "setPropertyValueSingle",
      "value": "false"
    }
  ],
  "time": {
    "is_paused": false,
    "type": "absolute",
    "value": "2017-05-01T00:00:00"
  },
  "version": {
    "major": 1,
    "minor": 4
  }
}