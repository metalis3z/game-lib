

local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")
require(script:FindFirstAncestor("Effects").Parent.Types)

local t1 = {}
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Trove = require(ReplicatedStorage.Packages.Trove)

require(ReplicatedStorage.Packages.Net)

local _ = script.Name
local v10 = Trove.new()
local _ = workspace.CurrentCamera

function t1.OnStart(_)
	ReplicatedStorage:SetAttribute("Effect_Space", true)
	v10:Add(function()
		ReplicatedStorage:SetAttribute("Effect_Space", nil)
	end)
	SoundController:UpdateOST()
	CycleController:Update()

	local v13 = v10:Extend()
	local u14 = true

	v10:Add(function()
		u14 = false
	end)

	local u15 = nil

	local function runUpdate()
		local NyanCatsEvent = ReplicatedStorage:GetAttribute("NyanCatsEvent")
		local v20 = if not not u14 and not ReplicatedStorage:GetAttribute("EggrotHuntEvent") then if not NyanCatsEvent then if not ServerData.IsTsunamiServer() then script.Space else script.SpaceTsunami else if not ServerData.IsTsunamiServer() then script.Nyan else script.NyanTsunami else nil

		if v20 == u15 then
			return
		end

		u15 = v20
		EffectController:Activate("Blink")
		SoundController:UpdateOST()
		CycleController:Update()
		v13:Destroy()

		if v20 then
			local clone = v13:Clone(v20)

			clone.Parent = workspace

			if ServerData.IsBiggerServer() then
				ClientEventUtils.resizeEffects(clone, 2)
			end

			clone.spacemeshbg.Transparency = 0

			for _, descendant in clone:GetDescendants() do
				if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
					descendant.Enabled = true
				end
			end
		end
	end

	v10:Add(ReplicatedStorage:GetAttributeChangedSignal("EggrotHuntEvent"):Connect(runUpdate))
	v10:Add(ReplicatedStorage:GetAttributeChangedSignal("NyanCatsEvent"):Connect(runUpdate))
	v10:Add(task.spawn(runUpdate))
	v10:Add(runUpdate)
end
function t1.OnStop(_)
	v10:Destroy()
end
function t1.OnLoad(_)
end

return t1
