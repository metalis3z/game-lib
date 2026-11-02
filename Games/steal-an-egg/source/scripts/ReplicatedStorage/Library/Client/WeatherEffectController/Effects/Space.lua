-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {}
local Client = ReplicatedStorage.Library.Client
local WeatherEffectController = require(Client.WeatherEffectController)
local WeatherSoundsController = require(Client.WeatherSoundsController)
local CycleController = require(Client.CycleController)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Trove).new()

function t.OnStart(p1) --[[ OnStart | Line: 15 | Upvalues: ReplicatedStorage (copy), v1 (copy), WeatherSoundsController (copy), CycleController (copy), WeatherEffectController (copy) ]]
	ReplicatedStorage:SetAttribute("Effect_Space", true)
	v1:Add(function() --[[ Line: 17 | Upvalues: ReplicatedStorage (ref) ]]
		ReplicatedStorage:SetAttribute("Effect_Space", nil)
	end)
	WeatherSoundsController:UpdateOST()
	CycleController:Update()

	local v12 = v1:Extend()
	local v2 = true

	v1:Add(function() --[[ Line: 24 | Upvalues: v2 (ref) ]]
		v2 = false
	end)

	local v3 = nil

	local function runUpdate() --[[ runUpdate | Line: 28 | Upvalues: ReplicatedStorage (ref), v2 (ref), v3 (ref), WeatherEffectController (ref), WeatherSoundsController (ref), CycleController (ref), v12 (copy) ]]
		local v22 = if v2 then if ReplicatedStorage:GetAttribute("NyanCatsEvent") then script.Nyan else script.Space else nil

		if v22 == v3 then
			return
		end

		v3 = v22
		WeatherEffectController:Activate("Blink")
		WeatherSoundsController:UpdateOST()
		CycleController:Update()
		v12:Destroy()

		if not v22 then
			return
		end

		local v32 = v12:Clone(v22)

		v32.Parent = workspace
		v32.spacemeshbg.Transparency = 0

		for v4, v5 in v32:GetDescendants() do
			if v5:IsA("ParticleEmitter") or v5:IsA("Beam") then
				v5.Enabled = true
			end
		end
	end

	ReplicatedStorage:GetAttributeChangedSignal("NyanCatsEvent"):Connect(runUpdate)
	v1:Add(task.spawn(runUpdate))
	v1:Add(runUpdate)
end
function t.OnStop(p1) --[[ OnStop | Line: 55 | Upvalues: v1 (copy) ]]
	v1:Destroy()
end
function t.OnLoad(p1) --[[ OnLoad | Line: 59 ]] end

return t