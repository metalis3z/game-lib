

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerData = require(ReplicatedStorage.Datas.ServerData)

require(ReplicatedStorage.Shared.EventTypes)

local Trove = require(ReplicatedStorage.Packages.Trove)
local t1 = {}
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local scriptName = script.Name
local v7 = Trove.new()

function t1.OnStart(_)
	ReplicatedStorage:SetAttribute("SummerEvent", true)
	EffectController:Activate("Blink")
	EffectController:Run(scriptName, "GrassRecolor")
	EffectController:Run(scriptName, "WallRecolor")
	EffectController:Run(scriptName, "WallBottomRecolor")

	if not ServerData.IsTsunamiServer() and not ServerData.IsBiggerServer() then
		v7:Clone(script.SummerMap).Parent = workspace
	end

	v7:Add(function()
		ReplicatedStorage:SetAttribute("SummerEvent", nil)
		EffectController:Stop(scriptName, "GrassRecolor")
		EffectController:Stop(scriptName, "WallRecolor")
		EffectController:Stop(scriptName, "WallBottomRecolor")
		EffectController:Activate("Blink")
	end)
end
function t1.OnStop(_)
	v7:Clean()
end

return t1
