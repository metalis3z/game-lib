-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Functions = require(Library.Functions)
local Audio = require(Library.Audio)
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(Library.Functions.RenderStepped)

local t = {}
local t2 = {
	Color3.fromRGB(168, 100, 253),
	Color3.fromRGB(41, 205, 255),
	Color3.fromRGB(120, 255, 68),
	Color3.fromRGB(255, 85, 85),
	Color3.fromRGB(253, 255, 106)
}
local t3 = { "rbxassetid://135524199765808" }

function t.Play(p1) --[[ Play | Line: 35 | Upvalues: Asserts (copy), t2 (copy), Functions (copy), Audio (copy), t3 (copy) ]]
	Asserts.optional.table(p1)

	local v1 = if p1 then p1 else {}
	local v2 = v1.Duration or 5
	local v3 = v1.VolumeScale or 1
	local v4 = v1.RateScale or 1
	local v5 = v1.SpeedScale or 1
	local v6 = v1.SizeScale or 1
	local Texture = v1.Texture
	local v7 = if v1.PopSounds == false then false else true
	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.Transparency = 1

	local v9, v10 = Functions.ComputeScreenSpacePart(5, 1)

	Part.CFrame = v9
	Part.Size = v10

	local v11 = Functions.Scaler()
	local list = {}
	local v12 = 0

	for i, v in ipairs(v1.Colors or t2) do
		local v13 = script:WaitForChild("ParticleEmitter"):Clone()

		table.insert(list, v13)

		local v15 = math.max(v12, v13.Lifetime.Max / v13.TimeScale)

		v13.Color = ColorSequence.new(v)

		if Texture ~= nil and Texture ~= "" then
			v13.Texture = Texture
		end

		v13.ZOffset = v13.ZOffset + (math.random() * 2 - 1) * 0.1
		v13.Rate = Functions.FixParticleRate(v13.Rate * v4, Part.Position)

		local Speed = v13.Speed

		v13.Speed = NumberRange.new(Speed.Min * v5, Speed.Max * v5)

		if v6 ~= 1 then
			v11(v13, v6)
		end

		v13.Enabled = false
		v13.Parent = Part
		v12 = v15
	end

	Part.Parent = workspace.CurrentCamera

	local v16 = 0
	local v17 = false

	if v1.PopUp ~= false then
		v16 = 0.75

		for i, v in ipairs(list) do
			local v19 = math.round((v:GetAttribute("EmitCount") or 0) * v4)

			if v19 > 0 then
				local v20 = v:Clone()

				v20.EmissionDirection = Enum.NormalId.Bottom
				v20.Speed = NumberRange.new(-30, -20)
				v20.Drag = 2.65
				v20.Parent = Part
				v20:Emit(v19)
			end
		end

		if v3 > 0 and v7 then
			Audio.Play(t3, workspace.CurrentCamera, { 0.95, 1.05 }, { 1.9 * v3, 2.1 * v3 })
		end
	else
		v17 = true

		for i, v in ipairs(list) do
			v.Enabled = true
		end
	end

	return Functions.RenderStepped(function(p1, p2) --[[ Line: 125 | Upvalues: Functions (ref), Part (copy), v16 (ref), v2 (copy), v17 (ref), list (copy) ]]
		local v1, v22 = Functions.ComputeScreenSpacePart(5, 1)

		Part.CFrame = v1
		Part.Size = v22

		local v3 = v16 <= p2 and p2 < v16 + v2

		if v17 == v3 then
			return
		end

		v17 = v3

		for i, v in ipairs(list) do
			v.Enabled = v3
		end
	end, v16 + v2 + v12):Then(function() --[[ Line: 145 | Upvalues: Part (copy) ]]
		Part:Destroy()
	end)
end

return t