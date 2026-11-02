
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseIndexController = require(ReplicatedStorage.Controllers.BaseIndexController)
local Trove = require(ReplicatedStorage.Packages.Trove)

require(ReplicatedStorage.Shared.EventTypes)

local t1 = {}
local v5 = Trove.new()

function t1.OnStart(_)
end
function t1.OnStop(_)
	v5:Clean()
end
function t1.OnLoad(_)
	v5:Add(BaseIndexController:Register({
		Id = "Summer",
		IndexName = "Summer",
		SkinName = "Summer",
		ScreenGuiName = "SummerBase",
		FramePath = "SummerBase",
		PromptTag = "SummerBasePrompt",
		MotorTag = "SummerBaseMotor"
	}))
end

return t1
