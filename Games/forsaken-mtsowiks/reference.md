# Forsaken (mtsowiks remake): quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 26 ScreenGuis, 491 GUI objects, 41 unique images
- Fonts: `AccanthisADFStd Bold`×30 `AccanthisADFStd Regular`×28 `SourceSansPro Regular`×23 `Arial Regular`×14 `SourceSansPro Bold`×11 `Guru Light`×7
- Panel colours: `#000000`×79 `#262626`×10 `#ffffff`×9 `#2a2a2a`×6 `#515151`×5 `#ff4040`×5 `#32ff32`×2 `#64ff35`×2 `#5d5d5d`×1 `#bababa`×1
- Text colours: `#ffffff`×119 `#000000`×6 `#1b2a35`×4 `#949494`×3 `#7fff7f`×1 `#7d7d7d`×1
- Stroke colours: `#ff0000`×18 `#000000`×6 `#ffffff`×5 `#f34eff`×4 `#0084ff`×4 `#a3a2a5`×4; thickness `2.0 px`×34 `1.0 px`×13 `1.5 px`×5 `0.0 px`×3
- Corner radius: `{0.0,2}`×34 `{0.2,0}`×15 `{0.5,0}`×4 `{0.0,34}`×3 `{0.05,0}`×1 `{0.043,0}`×1
- Size mode: {'scale': 391, 'mixed': 82, 'offset': 18}; TextScaled share 0.71; text sizes `14`×21 `20`×5 `8`×4 `40`×3 `26`×3 `18`×3
- Per 100 GUI objects: UICorner 12.2, UIStroke 11.2, UIGradient 2.4, UIAspectRatioConstraint 7.9, UIListLayout 2.4, UIGridLayout 0.6, UIPadding 2.2, UIScale 0.8, UITextSizeConstraint 0.0, ImageLabel 30.8, ImageButton 5.9, TextButton 5.1

## Map

- 226860 instances, 7593 parts (2029 MeshParts, 818 unions); core extent [4496, 440, 1194] studs (X, Y, Z; 2nd-98th percentile), everything [5364, 7360, 16151]
- Lights 122, particle emitters 639, beams/trails 135, textures/decals 2012, SurfaceAppearance 144, world GUIs 34, prompts 8, sounds 37
- Materials: `Plastic`×2035 `Wood`×2018 `Metal`×633 `Fabric`×455 `Slate`×337 `WoodPlanks`×319 `Granite`×317 `SmoothPlastic`×305 `Concrete`×195 `Grass`×160
- Part colours: `#a3a2a5`×923 `#5a4c42`×496 `#1b2a35`×449 `#564236`×401 `#957977`×339 `#6c584b`×334 `#2c2c2d`×320 `#111111`×251 `#7c5c46`×245 `#635f62`×157 `#564d40`×148 `#f8f8f8`×133
- Terrain voxel data: 101678 bytes

## Lighting

- Technology=Future, Brightness=3.0, TimeOfDay=06:12:00, Ambient=#8d594f, OutdoorAmbient=#464646, ColorShift_Top=#000000, EnvironmentDiffuseScale=1.0, EnvironmentSpecularScale=1.0, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=71.0
- **ColorCorrectionEffect** `HealthDesaturation`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **BlurEffect** `EmoteBlur`: Enabled=True, Size=0.0
- **DepthOfFieldEffect** `DepthOfField`: Enabled=True, FarIntensity=0.25, FocusDistance=73.68, InFocusRadius=28.45, NearIntensity=0.052
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=-0.6, TintColor=#ffe1b7
- **BlurEffect** `Blur`: Enabled=False, Size=4.0
- **Atmosphere** `Atmosphere`: Color=#000000, Decay=#000000, Density=0.65, Glare=3.62, Haze=0.0, Offset=0.224
- **Sky** `Dark night`: CelestialBodiesShown=False, StarCount=3000, SunAngularSize=21.0
