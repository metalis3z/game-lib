-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Functions = ReplicatedStorage:WaitForChild("Library"):WaitForChild("Functions")
local Stringify = require(Functions.Stringify)
local DeepEqualsUnsafe = require(Functions.DeepEqualsUnsafe)

require(ReplicatedStorage.Directory.Lightings.Types.Interface)

local t = {
	Density = 0,
	Offset = 0,
	Glare = 0,
	Haze = 0,
	Color = Color3.new(0/255, 0/255, 0/255),
	Decay = Color3.new(0/255, 0/255, 0/255)
}
local t2 = {
	CelestialBodiesShown = false,
	MoonAngularSize = 0,
	MoonTextureId = "",
	SkyboxBk = "",
	SkyboxDn = "",
	SkyboxFt = "",
	SkyboxLf = "",
	SkyboxRt = "",
	SkyboxUp = "",
	StarCount = 0,
	SunAngularSize = 0,
	SunTextureId = ""
}
local t3 = {
	Enabled = true,
	Intensity = 0,
	Size = 0,
	Threshold = 4
}
local t4 = {
	Brightness = 0,
	Contrast = 0,
	Enabled = true,
	Saturation = 0,
	TintColor = Color3.new(255/255, 255/255, 255/255)
}
local t5 = {
	Enabled = true,
	Intensity = 0,
	Spread = 0
}
local t6 = {
	Enabled = true,
	FarIntensity = 0,
	FocusDistance = 0,
	InFocusRadius = 50,
	NearIntensity = 0
}
local t7 = {
	Enabled = true,
	Size = 0
}
local t8 = {
	Cover = 0,
	Density = 0,
	Enabled = true,
	Color = Color3.new(255/255, 255/255, 255/255)
}
local v1 = Stringify.CompileOrder({
	"Ambient",
	"Brightness",
	"ColorShift_Bottom",
	"ColorShift_Top",
	"EnvironmentDiffuseScale",
	"EnvironmentSpecularScale",
	"OutdoorAmbient",
	"ShadowSoftness",
	"ClockTime",
	"GeographicLatitude",
	"ExposureCompensation",
	"FogColor",
	"FogEnd",
	"FogStart",
	{
		Key = "Atmosphere",
		Value = { "Density", "Offset", "Color", "Decay", "Glare", "Haze" }
	},
	{
		Key = "Sky",
		Value = {
			"CelestialBodiesShown",
			"MoonAngularSize",
			"MoonTextureId",
			"SkyboxBk",
			"SkyboxDn",
			"SkyboxFt",
			"SkyboxLf",
			"SkyboxRt",
			"SkyboxUp",
			"StarCount",
			"SunAngularSize",
			"SunTextureId"
		}
	},
	{
		Key = "Bloom",
		Value = { "Enabled", "Intensity", "Size", "Threshold" }
	},
	{
		Key = "ColorCorrection",
		Value = { "Brightness", "Contrast", "Enabled", "Saturation", "TintColor" }
	},
	{
		Key = "SunRays",
		Value = { "Enabled", "Intensity", "Spread" }
	},
	{
		Key = "DepthOfField",
		Value = { "Enabled", "FarIntensity", "FocusDistance", "InFocusRadius", "NearIntensity" }
	},
	{
		Key = "Blur",
		Value = { "Enabled", "Size" }
	},
	{
		Key = "Clouds",
		Value = { "Cover", "Density", "Color", "Enabled" }
	}
})

local function Lerp(p1, p2, p3) --[[ Lerp | Line: 156 ]]
	return (p2 - p1) * p3 + p1
end

local function LerpOther(p1, p2, p3) --[[ LerpOther | Line: 160 ]]
	if p3 >= 0.5 then
		return p2
	end

	return p1
end

local function LerpOptionalInstance(p1, p2, p3, p4, p5, p6) --[[ LerpOptionalInstance | Line: 168 ]]
	if p6 == 0 then
		return p4
	end

	if p6 == 1 then
		return p5
	end

	if p4 and (p2 and not p2(p4)) then
		p4 = nil
	end

	if p5 and (p2 and not p2(p5)) then
		p5 = nil
	end

	if not (p4 or p5) then
		return nil
	end

	return p1(p4 or p3, p5 or p3, p6)
end

local function WrapNorm(p1, p2) --[[ WrapNorm | Line: 195 ]]
	if p1 < 0 then
		p1 = p1 + math.ceil(-p1 / p2) * p2
	end

	return p1 % p2
end

local function WrapDeltaUnsafe(p1, p2, p3) --[[ WrapDeltaUnsafe | Line: 202 ]]
	local v1 = p1 - p2

	if p3 / 2 < v1 then
		return v1 - p3
	end

	if v1 < -p3 / 2 then
		return v1 + p3
	end

	return v1
end

local function WrapDelta(p1, p2, p3) --[[ WrapDelta | Line: 213 ]]
	local v2 = (if p1 < 0 then p1 + math.ceil(-p1 / p3) * p3 else p1) % p3
	local v4 = v2 - (if p2 < 0 then p2 + math.ceil(-p2 / p3) * p3 else p2) % p3

	if p3 / 2 < v4 then
		return v4 - p3
	end

	if v4 < -p3 / 2 then
		return v4 + p3
	end

	return v4
end

local function WrapLerp(p1, p2, p3, p4) --[[ WrapLerp | Line: 217 ]]
	local v2 = (if p2 < 0 then p2 + math.ceil(-p2 / p3) * p3 else p2) % p3
	local v4 = v2 - (if p1 < 0 then p1 + math.ceil(-p1 / p3) * p3 else p1) % p3

	return p1 + (if p3 / 2 < v4 then v4 - p3 elseif v4 < -p3 / 2 then v4 + p3 else v4) * p4
end

local function ApplyOptionalInstance(p1, p2, p3, p4, p5) --[[ ApplyOptionalInstance | Line: 221 ]]
	local v1 = p3 or p4
	local v2 = p2:FindFirstChild(v1)

	if v2 and not v2:IsA(p4) then
		v2 = nil
	end

	if p5 then
		if v2 then
			p1(v2, p5)

			return
		end

		local v3 = Instance.new(p4)

		v3.Name = v1
		p1(v3, p5)
		v3.Parent = p2

		return v3
	end

	if not v2 then
		return
	end

	v2:Destroy()
end

local function SerializeOptionalInstance(p1, p2, p3, p4) --[[ SerializeOptionalInstance | Line: 250 ]]
	local v1 = p2:FindFirstChild(p3 or p4)

	if v1 and not v1:IsA(p4) then
		v1 = nil
	end

	if v1 then
		return p1(v1)
	end

	return nil
end

local function GetAttribute(p1, p2, p3, p4) --[[ GetAttribute | Line: 267 ]]
	local v1 = p1:GetAttribute(p2)

	if v1 ~= nil then
		local v2 = if typeof(v1) == p3 then true else false
		local format = string.format

		assert(v2, format("%* was %* but should have been %*", p2, typeof(v1), p3))

		if p4 ~= nil then
			assert(v1.EnumType == p4, (("%* was %* but should have been %*"):format(p2, v1.EnumType, p4)))
		end
	end

	return v1
end

local function SetDifferentialAttribute(p1, p2, p3, p4, p5) --[[ SetDifferentialAttribute | Line: 281 ]]
	if not p5 and p3 == p4 then
		return
	end

	p1:SetAttribute(p2, p3)
end

local t9 = {
	COMPILED_ORDER = v1,
	STRINGIFY_PRETTY = {
		Pretty = true,
		IndentChar = "\t",
		IndentSize = 1,
		Order = v1
	}
}

function t9.Stringify(p1) --[[ Stringify | Line: 291 | Upvalues: Stringify (copy), t9 (copy) ]]
	return Stringify.Pretty(p1, t9.STRINGIFY_PRETTY)
end
function t9.LerpAtmosphere(p1, p2, p3) --[[ LerpAtmosphere | Line: 295 ]]
	local t = {}
	local Density = p1.Density

	t.Density = (p2.Density - Density) * p3 + Density

	local Offset = p1.Offset

	t.Offset = (p2.Offset - Offset) * p3 + Offset
	t.Color = p1.Color:Lerp(p2.Color, p3)
	t.Decay = p1.Decay:Lerp(p2.Decay, p3)

	local Glare = p1.Glare

	t.Glare = (p2.Glare - Glare) * p3 + Glare

	local Haze = p1.Haze

	t.Haze = (p2.Haze - Haze) * p3 + Haze

	return t
end
function t9.LerpSky(p1, p2, p3) --[[ LerpSky | Line: 310 ]]
	local t = {}

	t.CelestialBodiesShown = if p3 >= 0.5 then p2.CelestialBodiesShown else p1.CelestialBodiesShown

	local MoonAngularSize = p1.MoonAngularSize

	t.MoonAngularSize = (p2.MoonAngularSize - MoonAngularSize) * p3 + MoonAngularSize
	t.MoonTextureId = if p3 >= 0.5 then p2.MoonTextureId else p1.MoonTextureId
	t.SkyboxBk = if p3 >= 0.5 then p2.SkyboxBk else p1.SkyboxBk
	t.SkyboxDn = if p3 >= 0.5 then p2.SkyboxDn else p1.SkyboxDn
	t.SkyboxFt = if p3 >= 0.5 then p2.SkyboxFt else p1.SkyboxFt
	t.SkyboxLf = if p3 >= 0.5 then p2.SkyboxLf else p1.SkyboxLf
	t.SkyboxRt = if p3 >= 0.5 then p2.SkyboxRt else p1.SkyboxRt
	t.SkyboxUp = if p3 >= 0.5 then p2.SkyboxUp else p1.SkyboxUp

	local StarCount = p1.StarCount

	t.StarCount = math.round((p2.StarCount - StarCount) * p3 + StarCount)

	local SunAngularSize = p1.SunAngularSize

	t.SunAngularSize = (p2.SunAngularSize - SunAngularSize) * p3 + SunAngularSize
	t.SunTextureId = if p3 >= 0.5 then p2.SunTextureId else p1.SunTextureId

	return t
end
function t9.LerpBloomEffect(p1, p2, p3) --[[ LerpBloomEffect | Line: 327 ]]
	local t = {}

	t.Enabled = if p3 >= 0.5 then p2.Enabled else p1.Enabled

	local Intensity = p1.Intensity

	t.Intensity = (p2.Intensity - Intensity) * p3 + Intensity

	local Size = p1.Size

	t.Size = (p2.Size - Size) * p3 + Size

	local Threshold = p1.Threshold

	t.Threshold = (p2.Threshold - Threshold) * p3 + Threshold

	return t
end
function t9.LerpColorCorrectionEffect(p1, p2, p3) --[[ LerpColorCorrectionEffect | Line: 336 ]]
	local t = {}
	local Brightness = p1.Brightness

	t.Brightness = (p2.Brightness - Brightness) * p3 + Brightness

	local Contrast = p1.Contrast

	t.Contrast = (p2.Contrast - Contrast) * p3 + Contrast
	t.Enabled = if p3 >= 0.5 then p2.Enabled else p1.Enabled

	local Saturation = p1.Saturation

	t.Saturation = (p2.Saturation - Saturation) * p3 + Saturation
	t.TintColor = p1.TintColor:Lerp(p2.TintColor, p3)

	return t
end
function t9.LerpSunRaysEffect(p1, p2, p3) --[[ LerpSunRaysEffect | Line: 350 ]]
	local t = {}

	t.Enabled = if p3 >= 0.5 then p2.Enabled else p1.Enabled

	local Intensity = p1.Intensity

	t.Intensity = (p2.Intensity - Intensity) * p3 + Intensity

	local Spread = p1.Spread

	t.Spread = (p2.Spread - Spread) * p3 + Spread

	return t
end
function t9.LerpDepthOfFieldEffect(p1, p2, p3) --[[ LerpDepthOfFieldEffect | Line: 358 ]]
	local t = {}

	t.Enabled = if p3 >= 0.5 then p2.Enabled else p1.Enabled

	local FarIntensity = p1.FarIntensity

	t.FarIntensity = (p2.FarIntensity - FarIntensity) * p3 + FarIntensity

	local FocusDistance = p1.FocusDistance

	t.FocusDistance = (p2.FocusDistance - FocusDistance) * p3 + FocusDistance

	local InFocusRadius = p1.InFocusRadius

	t.InFocusRadius = (p2.InFocusRadius - InFocusRadius) * p3 + InFocusRadius

	local NearIntensity = p1.NearIntensity

	t.NearIntensity = (p2.NearIntensity - NearIntensity) * p3 + NearIntensity

	return t
end
function t9.LerpBlurEffect(p1, p2, p3) --[[ LerpBlurEffect | Line: 372 ]]
	local t = {}

	t.Enabled = if p3 >= 0.5 then p2.Enabled else p1.Enabled

	local Size = p1.Size

	t.Size = (p2.Size - Size) * p3 + Size

	return t
end
function t9.LerpClouds(p1, p2, p3) --[[ LerpClouds | Line: 379 ]]
	local t = {}
	local Cover = p1.Cover

	t.Cover = (p2.Cover - Cover) * p3 + Cover

	local Density = p1.Density

	t.Density = (p2.Density - Density) * p3 + Density
	t.Color = p1.Color:Lerp(p2.Color, p3)
	t.Enabled = if p3 >= 0.5 then p2.Enabled else p1.Enabled

	return t
end
function t9.Lerp(p1, p2, p3) --[[ Lerp | Line: 388 | Upvalues: LerpOptionalInstance (copy), t9 (copy), t (copy), t2 (copy), t3 (copy), t4 (copy), t5 (copy), t6 (copy), t7 (copy), t8 (copy) ]]
	local t10 = {
		Ambient = p1.Ambient:Lerp(p2.Ambient, p3)
	}
	local Brightness = p1.Brightness

	t10.Brightness = (p2.Brightness - Brightness) * p3 + Brightness
	t10.ColorShift_Bottom = p1.ColorShift_Bottom:Lerp(p2.ColorShift_Bottom, p3)
	t10.ColorShift_Top = p1.ColorShift_Top:Lerp(p2.ColorShift_Top, p3)

	local EnvironmentDiffuseScale = p1.EnvironmentDiffuseScale

	t10.EnvironmentDiffuseScale = (p2.EnvironmentDiffuseScale - EnvironmentDiffuseScale) * p3 + EnvironmentDiffuseScale

	local EnvironmentSpecularScale = p1.EnvironmentSpecularScale

	t10.EnvironmentSpecularScale = (p2.EnvironmentSpecularScale - EnvironmentSpecularScale) * p3 + EnvironmentSpecularScale
	t10.OutdoorAmbient = p1.OutdoorAmbient:Lerp(p2.OutdoorAmbient, p3)

	local ShadowSoftness = p1.ShadowSoftness

	t10.ShadowSoftness = (p2.ShadowSoftness - ShadowSoftness) * p3 + ShadowSoftness

	local ClockTime = p1.ClockTime
	local ClockTime2 = p2.ClockTime
	local v2 = (if ClockTime2 < 0 then ClockTime2 + math.ceil(-ClockTime2 / 24) * 24 else ClockTime2) % 24
	local v4 = v2 - (if ClockTime < 0 then ClockTime + math.ceil(-ClockTime / 24) * 24 else ClockTime) % 24

	t10.ClockTime = ClockTime + (if v4 > 12 then v4 - 24 elseif v4 < -12 then v4 + 24 else v4) * p3

	local GeographicLatitude = p1.GeographicLatitude
	local GeographicLatitude2 = p2.GeographicLatitude
	local v7 = (if GeographicLatitude2 < 0 then GeographicLatitude2 + math.ceil(-GeographicLatitude2 / 360) * 360 else GeographicLatitude2) % 360
	local v9 = v7 - (if GeographicLatitude < 0 then GeographicLatitude + math.ceil(-GeographicLatitude / 360) * 360 else GeographicLatitude) % 360

	t10.GeographicLatitude = GeographicLatitude + (if v9 > 180 then v9 - 360 elseif v9 < -180 then v9 + 360 else v9) * p3

	local ExposureCompensation = p1.ExposureCompensation

	t10.ExposureCompensation = (p2.ExposureCompensation - ExposureCompensation) * p3 + ExposureCompensation
	t10.FogColor = p1.FogColor:Lerp(p2.FogColor, p3)

	local FogEnd = p1.FogEnd

	t10.FogEnd = (p2.FogEnd - FogEnd) * p3 + FogEnd

	local FogStart = p1.FogStart

	t10.FogStart = (p2.FogStart - FogStart) * p3 + FogStart
	t10.Atmosphere = LerpOptionalInstance(t9.LerpAtmosphere, nil, t, p1.Atmosphere, p2.Atmosphere, p3)
	t10.Sky = LerpOptionalInstance(t9.LerpSky, nil, t2, p1.Sky, p2.Sky, p3)
	t10.Bloom = LerpOptionalInstance(t9.LerpBloomEffect, function(p1) --[[ Line: 413 ]]
		return p1.Enabled
	end, t3, p1.Bloom, p2.Bloom, p3)
	t10.ColorCorrection = LerpOptionalInstance(t9.LerpColorCorrectionEffect, function(p1) --[[ Line: 416 ]]
		return p1.Enabled
	end, t4, p1.ColorCorrection, p2.ColorCorrection, p3)
	t10.SunRays = LerpOptionalInstance(t9.LerpSunRaysEffect, function(p1) --[[ Line: 419 ]]
		return p1.Enabled
	end, t5, p1.SunRays, p2.SunRays, p3)
	t10.DepthOfField = LerpOptionalInstance(t9.LerpDepthOfFieldEffect, function(p1) --[[ Line: 422 ]]
		return p1.Enabled
	end, t6, p1.DepthOfField, p2.DepthOfField, p3)
	t10.Blur = LerpOptionalInstance(t9.LerpBlurEffect, function(p1) --[[ Line: 425 ]]
		return p1.Enabled
	end, t7, p1.Blur, p2.Blur, p3)
	t10.Clouds = LerpOptionalInstance(t9.LerpClouds, function(p1) --[[ Line: 428 ]]
		return p1.Enabled
	end, t8, p1.Clouds, p2.Clouds, p3)

	return t10
end
function t9.SerializeAtmosphere(p1) --[[ SerializeAtmosphere | Line: 434 ]]
	return {
		Density = p1.Density,
		Offset = p1.Offset,
		Color = p1.Color,
		Decay = p1.Decay,
		Glare = p1.Glare,
		Haze = p1.Haze
	}
end
function t9.SerializeSky(p1) --[[ SerializeSky | Line: 445 ]]
	return {
		CelestialBodiesShown = p1.CelestialBodiesShown,
		MoonAngularSize = p1.MoonAngularSize,
		MoonTextureId = p1.MoonTextureId,
		SkyboxBk = p1.SkyboxBk,
		SkyboxDn = p1.SkyboxDn,
		SkyboxFt = p1.SkyboxFt,
		SkyboxLf = p1.SkyboxLf,
		SkyboxRt = p1.SkyboxRt,
		SkyboxUp = p1.SkyboxUp,
		StarCount = p1.StarCount,
		SunAngularSize = p1.SunAngularSize,
		SunTextureId = p1.SunTextureId
	}
end
function t9.SerializeBloomEffect(p1) --[[ SerializeBloomEffect | Line: 462 ]]
	return {
		Enabled = p1.Enabled,
		Intensity = p1.Intensity,
		Size = p1.Size,
		Threshold = p1.Threshold
	}
end
function t9.SerializeColorCorrectionEffect(p1) --[[ SerializeColorCorrectionEffect | Line: 471 ]]
	return {
		Brightness = p1.Brightness,
		Contrast = p1.Contrast,
		Enabled = p1.Enabled,
		Saturation = p1.Saturation,
		TintColor = p1.TintColor
	}
end
function t9.SerializeSunRaysEffect(p1) --[[ SerializeSunRaysEffect | Line: 481 ]]
	return {
		Enabled = p1.Enabled,
		Intensity = p1.Intensity,
		Spread = p1.Spread
	}
end
function t9.SerializeDepthOfFieldEffect(p1) --[[ SerializeDepthOfFieldEffect | Line: 489 ]]
	return {
		Enabled = p1.Enabled,
		FarIntensity = p1.FarIntensity,
		FocusDistance = p1.FocusDistance,
		InFocusRadius = p1.InFocusRadius,
		NearIntensity = p1.NearIntensity
	}
end
function t9.SerializeBlurEffect(p1) --[[ SerializeBlurEffect | Line: 499 ]]
	return {
		Enabled = p1.Enabled,
		Size = p1.Size
	}
end
function t9.SerializeClouds(p1) --[[ SerializeClouds | Line: 506 ]]
	return {
		Cover = p1.Cover,
		Density = p1.Density,
		Color = p1.Color,
		Enabled = p1.Enabled
	}
end
function t9.Serialize(p1) --[[ Serialize | Line: 515 | Upvalues: t9 (copy) ]]
	local t = {
		Ambient = p1.Ambient,
		Brightness = p1.Brightness,
		ColorShift_Bottom = p1.ColorShift_Bottom,
		ColorShift_Top = p1.ColorShift_Top,
		EnvironmentDiffuseScale = p1.EnvironmentDiffuseScale,
		EnvironmentSpecularScale = p1.EnvironmentSpecularScale,
		OutdoorAmbient = p1.OutdoorAmbient,
		ShadowSoftness = p1.ShadowSoftness,
		ClockTime = p1.ClockTime,
		GeographicLatitude = p1.GeographicLatitude,
		ExposureCompensation = p1.ExposureCompensation,
		FogColor = p1.FogColor,
		FogEnd = p1.FogEnd,
		FogStart = p1.FogStart
	}
	local Atmosphere = p1:FindFirstChild("Atmosphere")

	if Atmosphere and not Atmosphere:IsA("Atmosphere") then
		Atmosphere = nil
	end

	t.Atmosphere = if Atmosphere then t9.SerializeAtmosphere(Atmosphere) else nil

	local Sky = p1:FindFirstChild("Sky")

	if Sky and not Sky:IsA("Sky") then
		Sky = nil
	end

	t.Sky = if Sky then t9.SerializeSky(Sky) else nil

	local Bloom = p1:FindFirstChild("Bloom")

	if Bloom and not Bloom:IsA("BloomEffect") then
		Bloom = nil
	end

	t.Bloom = if Bloom then t9.SerializeBloomEffect(Bloom) else nil

	local ColorCorrection = p1:FindFirstChild("ColorCorrection")

	if ColorCorrection and not ColorCorrection:IsA("ColorCorrectionEffect") then
		ColorCorrection = nil
	end

	t.ColorCorrection = if ColorCorrection then t9.SerializeColorCorrectionEffect(ColorCorrection) else nil

	local SunRays = p1:FindFirstChild("SunRays")

	if SunRays and not SunRays:IsA("SunRaysEffect") then
		SunRays = nil
	end

	t.SunRays = if SunRays then t9.SerializeSunRaysEffect(SunRays) else nil

	local DepthOfField = p1:FindFirstChild("DepthOfField")

	if DepthOfField and not DepthOfField:IsA("DepthOfFieldEffect") then
		DepthOfField = nil
	end

	t.DepthOfField = if DepthOfField then t9.SerializeDepthOfFieldEffect(DepthOfField) else nil

	local Blur = p1:FindFirstChild("Blur")

	if Blur and not Blur:IsA("BlurEffect") then
		Blur = nil
	end

	t.Blur = if Blur then t9.SerializeBlurEffect(Blur) else nil

	local Clouds = p1:FindFirstChild("Clouds")

	if Clouds and not Clouds:IsA("Clouds") then
		Clouds = nil
	end

	t.Clouds = if Clouds then t9.SerializeClouds(Clouds) else nil

	return t
end
function t9.FromConfig(p1, p2) --[[ FromConfig | Line: 552 | Upvalues: t9 (copy) ]]
	local t = {}
	local v1 = p1:GetAttribute("Ambient")

	if v1 ~= nil then
		local v2 = typeof(v1) == "Color3"
		local format = string.format

		assert(v2, format("%* was %* but should have been %*", "Ambient", typeof(v1), "Color3"))
	end

	t.Ambient = if v1 then v1 else p2.Ambient

	local v5 = p1:GetAttribute("Brightness")

	if v5 ~= nil then
		local v6 = typeof(v5) == "number"
		local format = string.format

		assert(v6, format("%* was %* but should have been %*", "Brightness", typeof(v5), "number"))
	end

	t.Brightness = if v5 then v5 else p2.Brightness

	local v9 = p1:GetAttribute("ColorShift_Bottom")

	if v9 ~= nil then
		local v10 = typeof(v9) == "Color3"
		local format = string.format

		assert(v10, format("%* was %* but should have been %*", "ColorShift_Bottom", typeof(v9), "Color3"))
	end

	t.ColorShift_Bottom = if v9 then v9 else p2.ColorShift_Bottom

	local v13 = p1:GetAttribute("ColorShift_Top")

	if v13 ~= nil then
		local v14 = typeof(v13) == "Color3"
		local format = string.format

		assert(v14, format("%* was %* but should have been %*", "ColorShift_Top", typeof(v13), "Color3"))
	end

	t.ColorShift_Top = if v13 then v13 else p2.ColorShift_Top

	local v17 = p1:GetAttribute("EnvironmentDiffuseScale")

	if v17 ~= nil then
		local v18 = typeof(v17) == "number"
		local format = string.format

		assert(v18, format("%* was %* but should have been %*", "EnvironmentDiffuseScale", typeof(v17), "number"))
	end

	t.EnvironmentDiffuseScale = if v17 then v17 else p2.EnvironmentDiffuseScale

	local v21 = p1:GetAttribute("EnvironmentSpecularScale")

	if v21 ~= nil then
		local v22 = typeof(v21) == "number"
		local format = string.format

		assert(v22, format("%* was %* but should have been %*", "EnvironmentSpecularScale", typeof(v21), "number"))
	end

	t.EnvironmentSpecularScale = if v21 then v21 else p2.EnvironmentSpecularScale

	local v25 = p1:GetAttribute("OutdoorAmbient")

	if v25 ~= nil then
		local v26 = typeof(v25) == "Color3"
		local format = string.format

		assert(v26, format("%* was %* but should have been %*", "OutdoorAmbient", typeof(v25), "Color3"))
	end

	t.OutdoorAmbient = if v25 then v25 else p2.OutdoorAmbient

	local v29 = p1:GetAttribute("ShadowSoftness")

	if v29 ~= nil then
		local v30 = typeof(v29) == "number"
		local format = string.format

		assert(v30, format("%* was %* but should have been %*", "ShadowSoftness", typeof(v29), "number"))
	end

	t.ShadowSoftness = if v29 then v29 else p2.ShadowSoftness

	local v33 = p1:GetAttribute("ClockTime")

	if v33 ~= nil then
		local v34 = typeof(v33) == "number"
		local format = string.format

		assert(v34, format("%* was %* but should have been %*", "ClockTime", typeof(v33), "number"))
	end

	t.ClockTime = if v33 then v33 else p2.ClockTime

	local v37 = p1:GetAttribute("GeographicLatitude")

	if v37 ~= nil then
		local v38 = typeof(v37) == "number"
		local format = string.format

		assert(v38, format("%* was %* but should have been %*", "GeographicLatitude", typeof(v37), "number"))
	end

	t.GeographicLatitude = if v37 then v37 else p2.GeographicLatitude

	local v41 = p1:GetAttribute("ExposureCompensation")

	if v41 ~= nil then
		local v42 = typeof(v41) == "number"
		local format = string.format

		assert(v42, format("%* was %* but should have been %*", "ExposureCompensation", typeof(v41), "number"))
	end

	t.ExposureCompensation = if v41 then v41 else p2.ExposureCompensation

	local v45 = p1:GetAttribute("FogColor")

	if v45 ~= nil then
		local v46 = typeof(v45) == "Color3"
		local format = string.format

		assert(v46, format("%* was %* but should have been %*", "FogColor", typeof(v45), "Color3"))
	end

	t.FogColor = if v45 then v45 else p2.FogColor

	local v49 = p1:GetAttribute("FogEnd")

	if v49 ~= nil then
		local v50 = typeof(v49) == "number"
		local format = string.format

		assert(v50, format("%* was %* but should have been %*", "FogEnd", typeof(v49), "number"))
	end

	t.FogEnd = if v49 then v49 else p2.FogEnd

	local v53 = p1:GetAttribute("FogStart")

	if v53 ~= nil then
		local v54 = typeof(v53) == "number"
		local format = string.format

		assert(v54, format("%* was %* but should have been %*", "FogStart", typeof(v53), "number"))
	end

	t.FogStart = if v53 then v53 else p2.FogStart

	local Atmosphere = p1:FindFirstChild("Atmosphere")

	if Atmosphere and not Atmosphere:IsA("Atmosphere") then
		Atmosphere = nil
	end

	local v57 = if Atmosphere then t9.SerializeAtmosphere(Atmosphere) else nil

	if not v57 then
		v57 = p2.Atmosphere
	end

	t.Atmosphere = v57

	local Sky = p1:FindFirstChild("Sky")

	if Sky and not Sky:IsA("Sky") then
		Sky = nil
	end

	local v59 = if Sky then t9.SerializeSky(Sky) else nil

	if not v59 then
		v59 = p2.Sky
	end

	t.Sky = v59

	local Bloom = p1:FindFirstChild("Bloom")

	if Bloom and not Bloom:IsA("BloomEffect") then
		Bloom = nil
	end

	local v61 = if Bloom then t9.SerializeBloomEffect(Bloom) else nil

	if not v61 then
		v61 = p2.Bloom
	end

	t.Bloom = v61

	local ColorCorrection = p1:FindFirstChild("ColorCorrection")

	if ColorCorrection and not ColorCorrection:IsA("ColorCorrectionEffect") then
		ColorCorrection = nil
	end

	local v63 = if ColorCorrection then t9.SerializeColorCorrectionEffect(ColorCorrection) else nil

	if not v63 then
		v63 = p2.ColorCorrection
	end

	t.ColorCorrection = v63

	local SunRays = p1:FindFirstChild("SunRays")

	if SunRays and not SunRays:IsA("SunRaysEffect") then
		SunRays = nil
	end

	local v65 = if SunRays then t9.SerializeSunRaysEffect(SunRays) else nil

	if not v65 then
		v65 = p2.SunRays
	end

	t.SunRays = v65

	local DepthOfField = p1:FindFirstChild("DepthOfField")

	if DepthOfField and not DepthOfField:IsA("DepthOfFieldEffect") then
		DepthOfField = nil
	end

	local v67 = if DepthOfField then t9.SerializeDepthOfFieldEffect(DepthOfField) else nil

	if not v67 then
		v67 = p2.DepthOfField
	end

	t.DepthOfField = v67

	local Blur = p1:FindFirstChild("Blur")

	if Blur and not Blur:IsA("BlurEffect") then
		Blur = nil
	end

	local v69 = if Blur then t9.SerializeBlurEffect(Blur) else nil

	if not v69 then
		v69 = p2.Blur
	end

	t.Blur = v69

	local Clouds = p1:FindFirstChild("Clouds")

	if Clouds and not Clouds:IsA("Clouds") then
		Clouds = nil
	end

	local v71 = if Clouds then t9.SerializeClouds(Clouds) else nil

	if not v71 then
		v71 = p2.Clouds
	end

	t.Clouds = v71

	return t
end
function t9.ApplyAtmosphere(p1, p2) --[[ ApplyAtmosphere | Line: 597 ]]
	p1.Density = p2.Density
	p1.Offset = p2.Offset
	p1.Color = p2.Color
	p1.Decay = p2.Decay
	p1.Glare = p2.Glare
	p1.Haze = p2.Haze
end
function t9.ApplySky(p1, p2) --[[ ApplySky | Line: 606 ]]
	p1.CelestialBodiesShown = p2.CelestialBodiesShown
	p1.MoonAngularSize = p2.MoonAngularSize
	p1.MoonTextureId = p2.MoonTextureId
	p1.SkyboxBk = p2.SkyboxBk
	p1.SkyboxDn = p2.SkyboxDn
	p1.SkyboxFt = p2.SkyboxFt
	p1.SkyboxLf = p2.SkyboxLf
	p1.SkyboxRt = p2.SkyboxRt
	p1.SkyboxUp = p2.SkyboxUp
	p1.StarCount = p2.StarCount
	p1.SunAngularSize = p2.SunAngularSize
	p1.SunTextureId = p2.SunTextureId
end
function t9.ApplyBloomEffect(p1, p2) --[[ ApplyBloomEffect | Line: 621 ]]
	p1.Enabled = p2.Enabled
	p1.Intensity = p2.Intensity
	p1.Size = p2.Size
	p1.Threshold = p2.Threshold
end
function t9.ApplyColorCorrectionEffect(p1, p2) --[[ ApplyColorCorrectionEffect | Line: 628 ]]
	p1.Brightness = p2.Brightness
	p1.Contrast = p2.Contrast
	p1.Enabled = p2.Enabled
	p1.Saturation = p2.Saturation
	p1.TintColor = p2.TintColor
end
function t9.ApplySunRaysEffect(p1, p2) --[[ ApplySunRaysEffect | Line: 639 ]]
	p1.Enabled = p2.Enabled
	p1.Intensity = p2.Intensity
	p1.Spread = p2.Spread
end
function t9.ApplyDepthOfFieldEffect(p1, p2) --[[ ApplyDepthOfFieldEffect | Line: 645 ]]
	p1.Enabled = p2.Enabled
	p1.FarIntensity = p2.FarIntensity
	p1.FocusDistance = p2.FocusDistance
	p1.InFocusRadius = p2.InFocusRadius
	p1.NearIntensity = p2.NearIntensity
end
function t9.ApplyBlurEffect(p1, p2) --[[ ApplyBlurEffect | Line: 653 ]]
	p1.Enabled = p2.Enabled
	p1.Size = p2.Size
end
function t9.ApplyClouds(p1, p2) --[[ ApplyClouds | Line: 658 ]]
	p1.Cover = p2.Cover
	p1.Density = p2.Density
	p1.Color = p2.Color
	p1.Enabled = p2.Enabled
end
function t9.Apply(p1, p2) --[[ Apply | Line: 665 | Upvalues: ApplyOptionalInstance (copy), t9 (copy) ]]
	p1.Ambient = p2.Ambient
	p1.Brightness = p2.Brightness
	p1.ColorShift_Bottom = p2.ColorShift_Bottom
	p1.ColorShift_Top = p2.ColorShift_Top
	p1.EnvironmentDiffuseScale = p2.EnvironmentDiffuseScale
	p1.EnvironmentSpecularScale = p2.EnvironmentSpecularScale
	p1.OutdoorAmbient = p2.OutdoorAmbient
	p1.ShadowSoftness = p2.ShadowSoftness
	p1.ClockTime = p2.ClockTime
	p1.GeographicLatitude = p2.GeographicLatitude
	p1.ExposureCompensation = p2.ExposureCompensation
	p1.FogColor = p2.FogColor
	p1.FogEnd = p2.FogEnd
	p1.FogStart = p2.FogStart
	ApplyOptionalInstance(t9.ApplyAtmosphere, p1, nil, "Atmosphere", p2.Atmosphere)
	ApplyOptionalInstance(t9.ApplySky, p1, nil, "Sky", p2.Sky)
	ApplyOptionalInstance(t9.ApplyBloomEffect, p1, "Bloom", "BloomEffect", p2.Bloom)
	ApplyOptionalInstance(t9.ApplyColorCorrectionEffect, p1, "ColorCorrection", "ColorCorrectionEffect", p2.ColorCorrection)
	ApplyOptionalInstance(t9.ApplySunRaysEffect, p1, "SunRays", "SunRaysEffect", p2.SunRays)
	ApplyOptionalInstance(t9.ApplyDepthOfFieldEffect, p1, "DepthOfField", "DepthOfFieldEffect", p2.DepthOfField)
	ApplyOptionalInstance(t9.ApplyBlurEffect, p1, "Blur", "BlurEffect", p2.Blur)
	ApplyOptionalInstance(t9.ApplyClouds, p1, "Clouds", "Clouds", p2.Clouds)
end
function t9.ToConfig(p1, p2, p3) --[[ ToConfig | Line: 702 | Upvalues: DeepEqualsUnsafe (copy), ApplyOptionalInstance (copy), t9 (copy) ]]
	local v1 = Instance.new("Folder")
	local Ambient = p1.Ambient

	if p3 or Ambient ~= p2.Ambient then
		v1:SetAttribute("Ambient", Ambient)
	end

	local Brightness = p1.Brightness

	if p3 or Brightness ~= p2.Brightness then
		v1:SetAttribute("Brightness", Brightness)
	end

	local ColorShift_Bottom = p1.ColorShift_Bottom

	if p3 or ColorShift_Bottom ~= p2.ColorShift_Bottom then
		v1:SetAttribute("ColorShift_Bottom", ColorShift_Bottom)
	end

	local ColorShift_Top = p1.ColorShift_Top

	if p3 or ColorShift_Top ~= p2.ColorShift_Top then
		v1:SetAttribute("ColorShift_Top", ColorShift_Top)
	end

	local EnvironmentDiffuseScale = p1.EnvironmentDiffuseScale

	if p3 or EnvironmentDiffuseScale ~= p2.EnvironmentDiffuseScale then
		v1:SetAttribute("EnvironmentDiffuseScale", EnvironmentDiffuseScale)
	end

	local EnvironmentSpecularScale = p1.EnvironmentSpecularScale

	if p3 or EnvironmentSpecularScale ~= p2.EnvironmentSpecularScale then
		v1:SetAttribute("EnvironmentSpecularScale", EnvironmentSpecularScale)
	end

	local OutdoorAmbient = p1.OutdoorAmbient

	if p3 or OutdoorAmbient ~= p2.OutdoorAmbient then
		v1:SetAttribute("OutdoorAmbient", OutdoorAmbient)
	end

	local ShadowSoftness = p1.ShadowSoftness

	if p3 or ShadowSoftness ~= p2.ShadowSoftness then
		v1:SetAttribute("ShadowSoftness", ShadowSoftness)
	end

	local ClockTime = p1.ClockTime

	if p3 or ClockTime ~= p2.ClockTime then
		v1:SetAttribute("ClockTime", ClockTime)
	end

	local GeographicLatitude = p1.GeographicLatitude

	if p3 or GeographicLatitude ~= p2.GeographicLatitude then
		v1:SetAttribute("GeographicLatitude", GeographicLatitude)
	end

	local ExposureCompensation = p1.ExposureCompensation

	if p3 or ExposureCompensation ~= p2.ExposureCompensation then
		v1:SetAttribute("ExposureCompensation", ExposureCompensation)
	end

	local FogColor = p1.FogColor

	if p3 or FogColor ~= p2.FogColor then
		v1:SetAttribute("FogColor", FogColor)
	end

	local FogEnd = p1.FogEnd

	if p3 or FogEnd ~= p2.FogEnd then
		v1:SetAttribute("FogEnd", FogEnd)
	end

	local FogStart = p1.FogStart

	if p3 or FogStart ~= p2.FogStart then
		v1:SetAttribute("FogStart", FogStart)
	end

	if p3 or not DeepEqualsUnsafe(p1.Atmosphere, p2.Atmosphere) then
		ApplyOptionalInstance(t9.ApplyAtmosphere, v1, nil, "Atmosphere", p1.Atmosphere)
	end

	if p3 or not DeepEqualsUnsafe(p1.Sky, p2.Sky) then
		ApplyOptionalInstance(t9.ApplySky, v1, nil, "Sky", p1.Sky)
	end

	if p3 or not DeepEqualsUnsafe(p1.Bloom, p2.Bloom) then
		ApplyOptionalInstance(t9.ApplyBloomEffect, v1, "Bloom", "BloomEffect", p1.Bloom)
	end

	if p3 or not DeepEqualsUnsafe(p1.ColorCorrection, p2.ColorCorrection) then
		ApplyOptionalInstance(t9.ApplyColorCorrectionEffect, v1, "ColorCorrection", "ColorCorrectionEffect", p1.ColorCorrection)
	end

	if p3 or not DeepEqualsUnsafe(p1.SunRays, p2.SunRays) then
		ApplyOptionalInstance(t9.ApplySunRaysEffect, v1, "SunRays", "SunRaysEffect", p1.SunRays)
	end

	if p3 or not DeepEqualsUnsafe(p1.DepthOfField, p2.DepthOfField) then
		ApplyOptionalInstance(t9.ApplyDepthOfFieldEffect, v1, "DepthOfField", "DepthOfFieldEffect", p1.DepthOfField)
	end

	if p3 or not DeepEqualsUnsafe(p1.Blur, p2.Blur) then
		ApplyOptionalInstance(t9.ApplyBlurEffect, v1, "Blur", "BlurEffect", p1.Blur)
	end

	if p3 or not DeepEqualsUnsafe(p1.Clouds, p2.Clouds) then
		ApplyOptionalInstance(t9.ApplyClouds, v1, "Clouds", "Clouds", p1.Clouds)
	end

	return v1
end

return t9