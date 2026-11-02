--credit to leon games studio
local t = {}
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local MaterialService = game:GetService("MaterialService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EffectLoadManager = require(ReplicatedStorage.SharedModules.EffectLoadManager)
local VFX = script.VFX
local EmissiveStrength = MaterialService.StarInlet.EmissiveStrength
local t2 = {}
local v1 = 0
local v2 = nil
local v3 = 0
local v4 = 0

local function quadInOut(p1) --[[ quadInOut | Line: 42 ]]
	if p1 < 0.5 then
		return p1 * 2 * p1
	end

	return 1 - (p1 * -2 + 2) ^ 2 / 2
end

local function tickPulse(p1) --[[ tickPulse | Line: 49 | Upvalues: v3 (ref), EmissiveStrength (copy), MaterialService (copy) ]]
	v3 = (v3 + p1) % 4

	local v1 = EmissiveStrength

	if v3 > 3 then
		local v2 = (v3 - 3) / 0.5
		local v32, v4

		if v2 <= 1 then
			v32 = if v2 < 0.5 then v2 * 2 * v2 else 1 - (v2 * -2 + 2) ^ 2 / 2

			if not v32 then
				v4 = 2 - v2
				v32 = if v4 < 0.5 then v4 * 2 * v4 else 1 - (v4 * -2 + 2) ^ 2 / 2
			end
		else
			v4 = 2 - v2
			v32 = if v4 < 0.5 then v4 * 2 * v4 else 1 - (v4 * -2 + 2) ^ 2 / 2
		end

		v1 = EmissiveStrength + (12 - EmissiveStrength) * v32
	end

	MaterialService.StarInlet.EmissiveStrength = v1
end

local function startPulse() --[[ startPulse | Line: 62 | Upvalues: v2 (ref), v3 (ref), v4 (ref), RunService (copy), EffectLoadManager (copy), EmissiveStrength (copy), MaterialService (copy) ]]
	if not v2 then
		v3 = 0
		v4 = 0
		v2 = RunService.RenderStepped:Connect(function(p13) --[[ Line: 67 | Upvalues: v4 (ref), EffectLoadManager (ref), v3 (ref), EmissiveStrength (ref), MaterialService (ref) ]]
			v4 = v4 + p13

			if v4 < EffectLoadManager.GetTickInterval() then
				return
			end

			debug.profilebegin("Mutations/Starstruck/Pulse")
			v3 = (v3 + v4) % 4

			local v1 = EmissiveStrength

			if v3 > 3 then
				local v2 = (v3 - 3) / 0.5
				local v32, v42

				if v2 <= 1 then
					v32 = if v2 < 0.5 then v2 * 2 * v2 else 1 - (v2 * -2 + 2) ^ 2 / 2

					if not v32 then
						v42 = 2 - v2
						v32 = if v42 < 0.5 then v42 * 2 * v42 else 1 - (v42 * -2 + 2) ^ 2 / 2
					end
				else
					v42 = 2 - v2
					v32 = if v42 < 0.5 then v42 * 2 * v42 else 1 - (v42 * -2 + 2) ^ 2 / 2
				end

				v1 = EmissiveStrength + (12 - EmissiveStrength) * v32
			end

			MaterialService.StarInlet.EmissiveStrength = v1
			v4 = 0
			debug.profileend()
		end)
	end
end

local function stopPulse() --[[ stopPulse | Line: 82 | Upvalues: v2 (ref), MaterialService (copy), EmissiveStrength (copy) ]]
	if not v2 then
		MaterialService.StarInlet.EmissiveStrength = EmissiveStrength

		return
	end

	v2:Disconnect()
	v2 = nil
	MaterialService.StarInlet.EmissiveStrength = EmissiveStrength
end

function t.ApplyMutationEffect(p1) --[[ ApplyMutationEffect | Line: 94 | Upvalues: t2 (copy), CollectionService (copy), VFX (copy), EffectLoadManager (copy), v1 (ref), v2 (ref), v3 (ref), v4 (ref), RunService (copy), EmissiveStrength (copy), MaterialService (copy) ]]
	if t2[p1] then
		return
	end

	local t = {
		vfx = {},
		parts = {}
	}

	t2[p1] = t
	CollectionService:AddTag(p1, "Starstruck")

	if p1:IsA("BasePart") then
		table.insert(t.parts, p1)
	end

	for v12, v22 in p1:GetDescendants() do
		if v22:IsA("BasePart") then
			table.insert(t.parts, v22)
		end
	end

	local v32 = p1:IsA("Model") and p1.PrimaryPart or t.parts[1]

	if v32 then
		for v5, v6 in VFX:GetChildren() do
			local v7 = v6:Clone()

			v7.Parent = v32
			table.insert(t.vfx, v7)
		end
	end

	for v8, v9 in t.parts do
		v9.MaterialVariant = "StarInlet"
	end

	EffectLoadManager.Register()
	v1 = v1 + 1

	if v1 ~= 1 then
		return
	end

	if v2 then
		return
	end

	v3 = 0
	v4 = 0
	v2 = RunService.RenderStepped:Connect(function(p13) --[[ Line: 67 | Upvalues: v4 (ref), EffectLoadManager (ref), v3 (ref), EmissiveStrength (ref), MaterialService (ref) ]]
		v4 = v4 + p13

		if v4 < EffectLoadManager.GetTickInterval() then
			return
		end

		debug.profilebegin("Mutations/Starstruck/Pulse")
		v3 = (v3 + v4) % 4

		local v1 = EmissiveStrength

		if v3 > 3 then
			local v2 = (v3 - 3) / 0.5
			local v32, v42

			if v2 <= 1 then
				v32 = if v2 < 0.5 then v2 * 2 * v2 else 1 - (v2 * -2 + 2) ^ 2 / 2

				if not v32 then
					v42 = 2 - v2
					v32 = if v42 < 0.5 then v42 * 2 * v42 else 1 - (v42 * -2 + 2) ^ 2 / 2
				end
			else
				v42 = 2 - v2
				v32 = if v42 < 0.5 then v42 * 2 * v42 else 1 - (v42 * -2 + 2) ^ 2 / 2
			end

			v1 = EmissiveStrength + (12 - EmissiveStrength) * v32
		end

		MaterialService.StarInlet.EmissiveStrength = v1
		v4 = 0
		debug.profileend()
	end)
end
function t.RemoveMutationEffect(p1) --[[ RemoveMutationEffect | Line: 141 | Upvalues: t2 (copy), EffectLoadManager (copy), v1 (ref), v2 (ref), MaterialService (copy), EmissiveStrength (copy) ]]
	local v12 = t2[p1]

	if not v12 then
		return
	end

	t2[p1] = nil

	for v22, v3 in v12.vfx do
		if v3.Parent then
			v3:Destroy()
		end
	end

	for v4, v5 in v12.parts do
		if v5.Parent then
			v5.MaterialVariant = ""
		end
	end

	EffectLoadManager.Unregister()
	v1 = math.max(0, v1 - 1)

	if v1 ~= 0 then
		return
	end

	if v2 then
		v2:Disconnect()
		v2 = nil
	end

	MaterialService.StarInlet.EmissiveStrength = EmissiveStrength
end
CollectionService:GetInstanceAddedSignal("Starstruck"):Connect(t.ApplyMutationEffect)
CollectionService:GetInstanceRemovedSignal("Starstruck"):Connect(t.RemoveMutationEffect)

for v5, v6 in CollectionService:GetTagged("Starstruck") do
	task.spawn(t.ApplyMutationEffect, v6)
end

return t