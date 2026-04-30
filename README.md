# openspace-rafos
Visualization and spatial sonification of RAFOS float data in OpenSpace.

## Visualization in OpenSpace
### Getting Started
 - [ ] Verify that your computer hardware 
 - [ ] Install OpenSpace per instructions here: https://docs.openspaceproject.com/releases-v0.20/getting-started/getting-started/index.html
 - [ ] Run the Getting Started tour.
 - [ ] Join the OpenSpace Slack (cf. www.openspaceproject.com), particularly the #p-oceanography and #sonification channels, to get questions addressed promptly.

 ### RAFOS Profile
 This repository includes an OpenSpace profile that is set up to make visualization of oceanographic data easier: it includes a current GEBCO bathymetry layer and turns off Earth's atmosphere and night layers, among other things. Note that it does *not* include the float assets themselves. To visualize the floats, follow these steps:
 - [ ] Download RAFOS.profile to your OpenSpace folder. Place it in the user/data/profiles directory.
 - [ ] In the OpenSpace launcher, select RAFOS from the custom profile list.
 - [ ] Drag and drop the .asset and .keyframes files from the Assets/ folder in this repo. These may take a few minutes to load; consider loading them one float at a time.

## Sonification in OpenSpace
# Sonification Setup
 - [ ] Install Supercollider and required VST plugins, following the instructions here: https://docs.openspaceproject.com/latest/building-content/modules/telemetry/sonification.html#ambisonics
  - [ ] Test [OpenSpace sonification examples](https://docs.openspaceproject.com/latest/building-content/modules/telemetry/sonification.html#sonifications-provided-by-openspace)

# Spatial Audification in OpenSpace
\TODO


# MIDI Control
 - [ ] Plug in a MIDI controller and turn it on. (I like the [Synido C16](https://www.synido.com/collections/midi-controllers/products/synido-tempopad-c16-midi-controller-beat-maker-midi-pad))
 - [ ] Navigate to https://kcollins.github.io/openspace-scripts/OpenSpace%20MIDI%20mapping/ , give your browser permission to control MIDI devices, and verify MIDI is connected by hitting "MIDI Channel Detect"
 - [ ] Map MIDI controls according to your preferences. (\TODO: Provide MIDI profile for C16.)

__________________________________________________________________
## Acknowledgments
Data courtesy of [Bower Lab](https://www2.whoi.edu/site/bower-lab/), WHOI.
"Oceanographic Argo Profiling Float" (https://skfb.ly/pyQYO) by gerardllorach is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/).
