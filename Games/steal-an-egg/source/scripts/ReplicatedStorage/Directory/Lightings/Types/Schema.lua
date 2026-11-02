-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {
	AtmosphereConfig = t.interface({
		Density = t.number,
		Offset = t.number,
		Color = t.Color3,
		Decay = t.Color3,
		Glare = t.number,
		Haze = t.number
	}),
	SkyConfig = t.interface({
		CelestialBodiesShown = t.boolean,
		MoonAngularSize = t.number,
		MoonTextureId = t.string,
		SkyboxBk = t.string,
		SkyboxDn = t.string,
		SkyboxFt = t.string,
		SkyboxLf = t.string,
		SkyboxRt = t.string,
		SkyboxUp = t.string,
		StarCount = t.number,
		SunAngularSize = t.number,
		SunTextureId = t.string
	}),
	BloomConfig = t.interface({
		Enabled = t.boolean,
		Intensity = t.number,
		Size = t.number,
		Threshold = t.number
	}),
	ColorCorrectionConfig = t.interface({
		Brightness = t.number,
		Contrast = t.number,
		Enabled = t.boolean,
		Saturation = t.number,
		TintColor = t.Color3
	}),
	SunRaysConfig = t.interface({
		Enabled = t.boolean,
		Intensity = t.number,
		Spread = t.number
	}),
	DepthOfFieldConfig = t.interface({
		Enabled = t.boolean,
		FarIntensity = t.number,
		FocusDistance = t.number,
		InFocusRadius = t.number,
		NearIntensity = t.number
	}),
	BlurConfig = t.interface({
		Enabled = t.boolean,
		Size = t.number
	}),
	CloudsConfig = t.interface({
		Cover = t.number,
		Density = t.number,
		Color = t.Color3,
		Enabled = t.boolean
	})
}

t2.LightingConfig = t.interface({
	Ambient = t.Color3,
	Brightness = t.number,
	ColorShift_Bottom = t.Color3,
	ColorShift_Top = t.Color3,
	EnvironmentDiffuseScale = t.number,
	EnvironmentSpecularScale = t.number,
	OutdoorAmbient = t.Color3,
	ShadowSoftness = t.number,
	ClockTime = t.number,
	GeographicLatitude = t.number,
	ExposureCompensation = t.number,
	FogColor = t.Color3,
	FogEnd = t.number,
	FogStart = t.number,
	Atmosphere = t.optional(t2.AtmosphereConfig),
	Sky = t.optional(t2.SkyConfig),
	Bloom = t.optional(t2.BloomConfig),
	ColorCorrection = t.optional(t2.ColorCorrectionConfig),
	SunRays = t.optional(t2.SunRaysConfig),
	DepthOfField = t.optional(t2.DepthOfFieldConfig),
	Blur = t.optional(t2.BlurConfig),
	Clouds = t.optional(t2.CloudsConfig)
})

return t2