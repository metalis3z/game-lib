# Click Keyboard Tower: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 4 ScreenGuis, 978 GUI objects, 37 unique images
- Fonts: `Roboto Regular`×149 `Zekton Regular`×136 `Roboto Light`×59 `SourceSansPro Regular`×47 `Nunito Regular`×38 `SourceSansPro SemiBold`×26
- Panel colours: `#000000`×97 `#5e56d5`×62 `#1c1f25`×61 `#ffffff`×60 `#4b4b4b`×13 `#505050`×9 `#23272f`×8 `#464646`×8 `#aa4646`×8 `#cb0000`×7
- Text colours: `#ffffff`×254 `#000000`×155 `#c8c8c8`×35 `#dcdcdc`×21 `#969696`×20 `#e1e1e1`×17
- Stroke colours: `#000000`×23 `#ffffff`×3 `#191919`×2 `#3b90b4`×1 `#7f1900`×1 `#323232`×1; thickness `4.0 px`×6 `3.0 px`×5 `2.0 px`×5 `1.0 px`×5 `1.5 px`×3
- Corner radius: `{0.0,4}`×137 `{0.0,6}`×40 `{0.0,8}`×11 `{0.0,5}`×11 `{0.2,0}`×4 `{0.15,0}`×3
- Size mode: {'scale': 939, 'offset': 13, 'mixed': 26}; TextScaled share 0.68; text sizes `16`×136 `14`×21 `18`×9 `35`×5 `20`×3 `28`×2
- Per 100 GUI objects: UICorner 21.6, UIStroke 3.3, UIGradient 0.8, UIAspectRatioConstraint 20.1, UIListLayout 3.7, UIGridLayout 0.0, UIPadding 0.9, UIScale 0.8, UITextSizeConstraint 0.9, ImageLabel 7.0, ImageButton 0.6, TextButton 18.1

## Map

- 33948 instances, 14938 parts (7074 MeshParts, 55 unions); core extent [273, 560, 338] studs (X, Y, Z; 2nd-98th percentile), everything [344, 591, 431]
- Lights 4, particle emitters 0, beams/trails 15, textures/decals 7377, SurfaceAppearance 0, world GUIs 27, prompts 0, sounds 4013
- Materials: `Plastic`×7658 `SmoothPlastic`×7187 `Neon`×87 `Metal`×4 `ForceField`×2
- Part colours: `#a3a2a5`×7146 `#ff70a6`×1011 `#4d96ff`×1005 `#3a86ff`×951 `#ff5c00`×950 `#9b5de5`×934 `#845ec2`×892 `#ff9770`×885 `#ff6666`×495 `#002060`×458 `#f8f8f8`×44 `#0d69ac`×35
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=3.0, TimeOfDay=09:18:00, Ambient=#464646, OutdoorAmbient=#464646, ColorShift_Top=#000000, EnvironmentDiffuseScale=1.0, EnvironmentSpecularScale=1.0, ExposureCompensation=0.0, GlobalShadows=False, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=0.0
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.01, Spread=0.1
- **DepthOfFieldEffect** `DepthOfField`: Enabled=False, FarIntensity=0.1, FocusDistance=0.05, InFocusRadius=30.0, NearIntensity=0.75
- **BloomEffect** `Bloom`: Enabled=True, Intensity=1.0, Size=24.0, Threshold=2.0
- **Sky** `Sky ( Add To Lighting)`: CelestialBodiesShown=False, StarCount=1, SunAngularSize=1.0
- **Atmosphere** `Atmosphere`: Color=#c7c7c7, Decay=#6a707d, Density=0.3, Glare=0.0, Haze=0.0, Offset=0.25
