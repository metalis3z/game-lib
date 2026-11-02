-- needoh-escape: Workspace / Terrain / Lighting settings of the place (enums are raw numbers, colours are {r, g, b}).
-- Generated from map/environment.json by _tools/json2lua.py
return {
	workspace = {
	},
	lighting = {
	},
	lighting_note = "\"Lighting\" is a Model standing in for Lighting in a kit: it carries no Lighting properties, only the effects inside it",
	lighting_children = {
		{
			class = "Atmosphere",
			name = "Atmosphere",
			props = {
				Color = "#d9fffc",
				Decay = "#365a66",
				DefinesCapabilities = false,
				Density = 0.0,
				Glare = 1.3,
				Haze = 0.35,
				Name = "Atmosphere",
				Offset = 0.0,
			},
		},
		{
			class = "Sky",
			name = "Sky",
			props = {
				CelestialBodiesShown = true,
				DefinesCapabilities = false,
				MoonAngularSize = 11.0,
				MoonTextureId = "rbxasset://sky/moon.jpg",
				Name = "Sky",
				SkyboxBk = "rbxassetid://7643700666",
				SkyboxDn = "rbxassetid://7643743687",
				SkyboxFt = "rbxassetid://7644304186",
				SkyboxLf = "rbxassetid://7644288724",
				SkyboxOrientation = { 0.0, 0.0, 0.0 },
				SkyboxRt = "rbxassetid://7643700819",
				SkyboxUp = "rbxassetid://7643757404",
				StarCount = 3000,
				SunAngularSize = 21.0,
				SunTextureId = "rbxasset://sky/sun.jpg",
			},
		},
		{
			class = "BloomEffect",
			name = "Bloom",
			props = {
				DefinesCapabilities = false,
				Enabled = true,
				Intensity = 0.5,
				Name = "Bloom",
				Size = 50.0,
				Threshold = 2.0,
			},
		},
		{
			class = "ColorCorrectionEffect",
			name = "ColorCorrection",
			props = {
				Brightness = 0.3,
				Contrast = 0.3,
				DefinesCapabilities = false,
				Enabled = true,
				Name = "ColorCorrection",
				Saturation = 0.2,
				TintColor = "#b8beed",
			},
		},
		{
			class = "DepthOfFieldEffect",
			name = "DepthOfField",
			props = {
				DefinesCapabilities = false,
				Enabled = true,
				FarIntensity = 0.0,
				FocusDistance = 0.0,
				InFocusRadius = 0.0,
				Name = "DepthOfField",
				NearIntensity = 0.0,
			},
		},
		{
			class = "SunRaysEffect",
			name = "SunRays",
			props = {
				DefinesCapabilities = false,
				Enabled = true,
				Intensity = 0.01,
				Name = "SunRays",
				Spread = 1.0,
			},
		},
		{
			class = "ColorCorrectionEffect",
			name = "VFX",
			props = {
				Brightness = 0.0,
				Contrast = 0.0,
				DefinesCapabilities = false,
				Enabled = true,
				Name = "VFX",
				Saturation = 0.0,
				TintColor = "#ffffff",
			},
		},
	},
	materialservice = {
		DefinesCapabilities = false,
		LevelOfDetail = 0,
		ModelMeshCFrame = {
			pos = { 0.0, 0.0, 0.0 },
			rot = 2,
		},
		ModelMeshSize = { 0.0, 0.0, 0.0 },
		ModelStreamingMode = 0,
		Name = "MaterialService",
		NeedsPivotMigration = false,
		PrimaryPart = nil,
		ScaleFactor = 1.0,
		SlimHash = "",
	},
	material_variants = {
		{
			name = "Glue",
			path = "+1 Speed V1 Kit.MaterialService.Glue",
			base = "Plastic",
		},
		{
			name = "Inlet",
			path = "+1 Speed V1 Kit.MaterialService.Inlet",
			base = "Plastic",
		},
		{
			name = "Studs",
			path = "+1 Speed V1 Kit.MaterialService.Studs",
			base = "Plastic",
		},
		{
			name = "StudsSmall",
			path = "+1 Speed V1 Kit.MaterialService.StudsSmall",
			base = "Plastic",
		},
		{
			name = "Universal",
			path = "+1 Speed V1 Kit.MaterialService.Universal",
			base = "Plastic",
		},
		{
			name = "Weld",
			path = "+1 Speed V1 Kit.MaterialService.Weld",
			base = "Plastic",
		},
	},
	soundservice = {
	},
}
