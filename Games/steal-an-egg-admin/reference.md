# Steal an Egg + P2W Admin Panel: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 62 ScreenGuis, 3982 GUI objects, 456 unique images
- Fonts: `GothamSSm ExtraBold`×645 `Rubik Bold`×233 `GothamSSm Heavy`×187 `SourceSansPro Regular`×96 `GothamSSm Bold`×79 `BuilderSans Regular`×46
- Panel colours: `#ffffff`×432 `#141622`×231 `#000000`×100 `#550000`×44 `#192953`×23 `#e8ebed`×20 `#1c1c28`×20 `#ff1414`×19 `#bfbfbf`×14 `#151927`×12
- Text colours: `#ffffff`×1015 `#000000`×123 `#191b1d`×50 `#1b2a35`×36 `#51575e`×36 `#bfbfbf`×30
- Stroke colours: `#000000`×999 `#121212`×110 `#151515`×82 `#0b4800`×76 `#52526b`×74 `#beffb4`×74; thickness `3.0 px`×399 `2.33 px`×248 `0.06 scaled`×211 `2.0 px`×196 `2.22 px`×105
- Corner radius: `{0.0,8}`×285 `{1.0,0}`×90 `{0.2,0}`×39 `{0.1,0}`×25 `{0.0,9999}`×20 `{0.0,4}`×20
- Size mode: {'scale': 3068, 'mixed': 453, 'offset': 214, 'zero': 247}; TextScaled share 0.78; text sizes `14`×117 `24`×45 `13`×41 `25`×21 `32`×20 `27`×20
- Per 100 GUI objects: UICorner 14.4, UIStroke 46.7, UIGradient 22.1, UIAspectRatioConstraint 6.3, UIListLayout 6.1, UIGridLayout 0.3, UIPadding 0.9, UIScale 4.0, UITextSizeConstraint 0.6, ImageLabel 24.5, ImageButton 13.8, TextButton 3.6

## Map

- 28491 instances, 15691 parts (767 MeshParts, 1 unions); core extent [4390, 78, 201] studs (X, Y, Z; 2nd-98th percentile), everything [7839, 2550, 1346]
- Lights 22, particle emitters 275, beams/trails 111, textures/decals 125, SurfaceAppearance 0, world GUIs 88, prompts 66, sounds 104
- Materials: `Wood`×11330 `Plastic`×3798 `Neon`×264 `SmoothPlastic`×222 `Glacier`×48 `Slate`×24 `ForceField`×4 `Glass`×1
- Part colours: `#a05f35`×11331 `#a25100`×483 `#475415`×437 `#a3a2a5`×403 `#564236`×308 `#396113`×223 `#6b4b30`×95 `#f8f8f8`×92 `#595756`×80 `#1b2a35`×75 `#b86301`×74 `#c46ecf`×72
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=2.5, TimeOfDay=11:36:00, Ambient=#dac79c, OutdoorAmbient=#92c9e2, ColorShift_Top=#000000, EnvironmentDiffuseScale=0.75, EnvironmentSpecularScale=0.7, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c5c5c5, GeographicLatitude=23.142
- **DepthOfFieldEffect** `TabControllerDepthBlur`: Enabled=False, FarIntensity=0.755, FocusDistance=200.0, InFocusRadius=13.25, NearIntensity=0.0
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.01, Spread=0.5
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.0, Contrast=0.2, Enabled=True, Saturation=0.1, TintColor=#ffedef
- **Atmosphere** `Atmosphere`: Color=#000000, Decay=#000000, Density=0.309, Glare=0.0, Haze=0.0, Offset=0.0
- **Sky** `Sky`: CelestialBodiesShown=True, StarCount=3000, SunAngularSize=21.0
- **DepthOfFieldEffect** `TabDepthBlur`: Enabled=False, FarIntensity=0.755, FocusDistance=200.0, InFocusRadius=13.25, NearIntensity=0.0
- **DepthOfFieldEffect** `TabDepthBlur`: Enabled=False, FarIntensity=0.755, FocusDistance=200.0, InFocusRadius=13.25, NearIntensity=0.0
- **BlurEffect** `AdminPanelBlur`: Enabled=False, Size=0.0
