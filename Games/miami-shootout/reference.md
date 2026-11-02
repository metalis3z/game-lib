# Miami Shootout: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 70 ScreenGuis, 2138 GUI objects, 34 unique images
- Fonts: `GrenzeGotisch Regular`×372 `SourceSansPro Bold`×165 `Arial Bold`×157 `SourceSansPro Regular`×59 `Bangers Regular`×16 `Nunito Regular`×14
- Panel colours: `#000000`×136 `#ffffff`×47 `#232323`×31 `#757575`×10 `#aa0000`×7 `#616161`×5 `#00557f`×3 `#343434`×3 `#686868`×3 `#5d5d5d`×3
- Text colours: `#ffffff`×692 `#ff0000`×99 `#000000`×6 `#ebebeb`×6 `#152d2d`×5 `#c70000`×2
- Stroke colours: `#000000`×13 `#ffffff`×3; thickness `1.0 px`×9 `2.0 px`×3 `0.0 px`×3 `1.6 px`×1
- Corner radius: `{0.0,8}`×126 `{0.15,0}`×4 `{0.05,0}`×2 `{0.0,4}`×1
- Size mode: {'scale': 1224, 'offset': 634, 'mixed': 63, 'zero': 217}; TextScaled share 0.19; text sizes `31`×186 `14`×165 `18`×94 `36`×93 `29`×62 `24`×31
- Per 100 GUI objects: UICorner 6.2, UIStroke 0.7, UIGradient 0.3, UIAspectRatioConstraint 4.3, UIListLayout 0.4, UIGridLayout 0.0, UIPadding 0.1, UIScale 1.4, UITextSizeConstraint 4.2, ImageLabel 9.0, ImageButton 8.1, TextButton 2.3

## Map

- 106996 instances, 53590 parts (7703 MeshParts, 9195 unions); core extent [1982, 104, 1340] studs (X, Y, Z; 2nd-98th percentile), everything [100196, 9989, 101096]
- Lights 820, particle emitters 153, beams/trails 85, textures/decals 18302, SurfaceAppearance 610, world GUIs 388, prompts 155, sounds 637
- Materials: `Plastic`×13578 `Metal`×12587 `SmoothPlastic`×7509 `Wood`×7475 `Concrete`×5322 `Neon`×1537 `Brick`×1309 `WoodPlanks`×1274 `Glass`×853 `Grass`×574
- Part colours: `#f8f8f8`×7880 `#a3a2a5`×5933 `#635f62`×5917 `#111111`×4129 `#cacbd1`×3538 `#e29b40`×3312 `#cdcdcd`×1848 `#5a4c42`×1767 `#efb838`×1763 `#737375`×1745 `#e7e7ec`×1389 `#1b2a35`×1380
- Terrain voxel data: 4416 bytes

## Lighting

- Technology=ShadowMap, Brightness=1.0, TimeOfDay=11:06:00, Ambient=#303030, OutdoorAmbient=#505050, ColorShift_Top=#000000, EnvironmentDiffuseScale=1.0, EnvironmentSpecularScale=1.0, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=0.0
- **BlurEffect** `EffectBLUR`: Enabled=False, Size=0.0
- **BlurEffect** `IntroBlur`: Enabled=False, Size=0.0
- **ColorCorrectionEffect** `Dead`: Brightness=0.0, Contrast=1.0, Enabled=False, Saturation=-1.0, TintColor=#212121
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.01, Spread=0.1
- **DepthOfFieldEffect** `DepthOfField`: Enabled=False, FarIntensity=0.1, FocusDistance=0.05, InFocusRadius=30.0, NearIntensity=0.75
- **BloomEffect** `Bloom`: Enabled=True, Intensity=1.0, Size=24.0, Threshold=2.0
- **Sky** `Sky`: CelestialBodiesShown=True, StarCount=5000, SunAngularSize=2.0
- **BlurEffect** `Injured/Deathblur`: Enabled=False, Size=18.0
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.01, Spread=0.1
- **BlurEffect** `DBlur`: Enabled=True, Size=0.0
- **BlurEffect** `GBlur`: Enabled=True, Size=0.0
- **BlurEffect** `LEENBLUR`: Enabled=True, Size=1.0
- **BlurEffect** `OGEBLUR`: Enabled=True, Size=1.0
- **BlurEffect** `InsideBlur`: Enabled=True, Size=0.0
- **Atmosphere** `Atmosphere`: Color=#c7c7c7, Decay=#f9f9f9, Density=0.417, Glare=0.0, Haze=0.0, Offset=0.405
- **BlurEffect** `IntroductionBlur`: Enabled=True, Size=0.0
