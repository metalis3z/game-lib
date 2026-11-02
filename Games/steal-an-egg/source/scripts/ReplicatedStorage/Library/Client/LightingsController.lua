-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local DeepEqualsUnsafe = require(ReplicatedStorage.Library.Functions.DeepEqualsUnsafe)
local DeepCopyUnsafe = require(ReplicatedStorage.Library.Functions.DeepCopyUnsafe)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local Lightings = require(ReplicatedStorage.Directory.Lightings)
local LightingsCore = require(ReplicatedStorage.Library.Client.LightingsCore)
local t = {}

t.__index = t
t.__class = "Lightings"

local function serializeCurrentConfig() --[[ serializeCurrentConfig | Line: 45 | Upvalues: LightingsCore (copy), Lighting (copy), Workspace (copy) ]]
	local v1 = LightingsCore.Serialize(Lighting)

	v1.Clouds = LightingsCore.SerializeClouds(Workspace.Terrain.Clouds)

	return v1
end

local function applyConfig(p1) --[[ applyConfig | Line: 52 | Upvalues: DeepCopyUnsafe (copy), LightingsCore (copy), Lighting (copy), Workspace (copy) ]]
	local v1 = DeepCopyUnsafe(p1)

	v1.Clouds = nil
	LightingsCore.Apply(Lighting, v1)

	local Clouds = Workspace.Terrain.Clouds
	local Clouds2 = p1.Clouds

	if Clouds2 then
		Clouds.Enabled = true
		LightingsCore.ApplyClouds(Clouds, Clouds2)
	else
		Clouds.Enabled = false
	end
end

function t._build() --[[ _build | Line: 72 | Upvalues: t (copy), Lightings (copy) ]]
	local v2 = setmetatable({}, t)

	v2.DefaultLightings = Lightings.Directory.Default
	v2._baseConfig = v2.DefaultLightings
	v2._basePriority = 0
	v2._activeConfig = v2.DefaultLightings
	v2._modifiers = {}
	v2._currentTweenHandle = nil

	return v2
end

local function getOrderedSources(p1) --[[ getOrderedSources | Line: 86 ]]
	local t = {
		{
			Id = "__base",
			Priority = p1._basePriority,
			Transform = function(p12) --[[ Transform | Line: 91 | Upvalues: p1 (copy) ]]
				return p1._baseConfig
			end
		}
	}

	for k, v in pairs(p1._modifiers) do
		table.insert(t, {
			Id = k,
			Priority = v.Priority,
			Transform = v.Transform
		})
	end

	table.sort(t, function(p1, p2) --[[ Line: 105 ]]
		if p1.Priority == p2.Priority then
			return p1.Id < p2.Id
		end

		return p1.Priority < p2.Priority
	end)

	return t
end

function t._resolveActiveConfig(p1) --[[ _resolveActiveConfig | Line: 116 | Upvalues: getOrderedSources (copy) ]]
	local DefaultLightings = p1.DefaultLightings

	for i, v in ipairs((getOrderedSources(p1))) do
		DefaultLightings = v.Transform(DefaultLightings)
	end

	return DefaultLightings
end
function t._applyResolvedLighting(p1, p2) --[[ _applyResolvedLighting | Line: 126 | Upvalues: DeepEqualsUnsafe (copy), LightingsCore (copy), Lighting (copy), Workspace (copy), RenderStepped (copy), Easing (copy), DeepCopyUnsafe (copy) ]]
	local v1 = p1:_resolveActiveConfig()

	if DeepEqualsUnsafe(p1._activeConfig, v1) then
		return
	end

	local v2 = p2 or 1.33
	local Linear = Enum.EasingStyle.Linear
	local Out = Enum.EasingDirection.Out
	local v3 = LightingsCore.Serialize(Lighting)

	v3.Clouds = LightingsCore.SerializeClouds(Workspace.Terrain.Clouds)

	local v4 = v3

	if p1._currentTweenHandle then
		p1._currentTweenHandle:Disconnect()
		p1._currentTweenHandle = nil
	end

	p1._activeConfig = v1

	if v2 > 0 then
		local v5 = nil

		v5 = RenderStepped(function(p1, p2) --[[ Line: 146 | Upvalues: LightingsCore (ref), v4 (copy), v1 (copy), Easing (ref), Linear (copy), Out (copy), DeepCopyUnsafe (ref), Lighting (ref), Workspace (ref) ]]
			local v12 = LightingsCore.Lerp(v4, v1, Easing(p2, Linear, Out))
			local v2 = DeepCopyUnsafe(v12)

			v2.Clouds = nil
			LightingsCore.Apply(Lighting, v2)

			local Clouds = Workspace.Terrain.Clouds
			local Clouds2 = v12.Clouds

			if Clouds2 then
				Clouds.Enabled = true
				LightingsCore.ApplyClouds(Clouds, Clouds2)
			else
				Clouds.Enabled = false
			end

			return false
		end, v2, true):Then(function() --[[ Line: 150 | Upvalues: p1 (copy), v5 (ref), v1 (copy), DeepCopyUnsafe (ref), LightingsCore (ref), Lighting (ref), Workspace (ref) ]]
			if p1._currentTweenHandle ~= v5 then
				return
			end

			local v12 = v1
			local v2 = DeepCopyUnsafe(v12)

			v2.Clouds = nil
			LightingsCore.Apply(Lighting, v2)

			local Clouds = Workspace.Terrain.Clouds
			local Clouds2 = v12.Clouds

			if Clouds2 then
				Clouds.Enabled = true
				LightingsCore.ApplyClouds(Clouds, Clouds2)

				return
			end

			Clouds.Enabled = false
		end)
		p1._currentTweenHandle = v5

		return
	end

	local v6 = DeepCopyUnsafe(v1)

	v6.Clouds = nil
	LightingsCore.Apply(Lighting, v6)

	local Clouds = Workspace.Terrain.Clouds
	local Clouds2 = v1.Clouds

	if Clouds2 then
		Clouds.Enabled = true
		LightingsCore.ApplyClouds(Clouds, Clouds2)
	else
		Clouds.Enabled = false
	end
end
function t.SetLighting(p1, p2, p3, p4) --[[ SetLighting | Line: 167 | Upvalues: Asserts (copy) ]]
	Asserts.table(p2)
	Asserts.optional.number(p3)
	Asserts.optional.number(p4)
	p1._baseConfig = p2
	p1._basePriority = p4 or 0
	p1:_applyResolvedLighting(p3)
end
function t.SetModifier(p1, p2, p3, p4, p5) --[[ SetModifier | Line: 182 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)
	Asserts.optional.number(p4)
	Asserts.optional.number(p5)
	p1._modifiers[p2] = {
		Priority = p4 or 0,
		Transform = p3
	}
	p1:_applyResolvedLighting(p5)
end
function t.ClearModifier(p1, p2, p3) --[[ ClearModifier | Line: 201 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)
	Asserts.optional.number(p3)

	if p1._modifiers[p2] ~= nil then
		p1._modifiers[p2] = nil
		p1:_applyResolvedLighting(p3)
	end
end

return t._build()