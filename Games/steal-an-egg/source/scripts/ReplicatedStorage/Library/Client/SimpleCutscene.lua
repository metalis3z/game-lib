-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local TweenService = game:GetService("TweenService")

function t.Start_Cutscene(p1) --[[ Start_Cutscene | Line: 4 ]] end
function t.End_Cutscene(p1) --[[ End_Cutscene | Line: 6 ]]
	local CurrentCamera = game.Workspace.CurrentCamera

	CurrentCamera.CameraSubject = p1.Character.Humanoid
	CurrentCamera.CameraType = Enum.CameraType.Fixed
end

local SimpleFOV = require(script.Parent.SimpleFOV)

function t.Flash(p1, p2) --[[ Flash | Line: 13 | Upvalues: TweenService (copy), SimpleFOV (copy) ]]
	local v1 = TweenInfo.new(p2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
	local v2 = TweenInfo.new(p2 * 4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
	local Frame = p1.PlayerGui.Rejoin_UI.Frame

	TweenService:Create(Frame, v1, {
		BackgroundTransparency = 0
	}):Play()
	SimpleFOV.Change_FOV(90, v1.Time)
	task.spawn(function() --[[ Line: 21 | Upvalues: v1 (copy), SimpleFOV (ref), v2 (copy), TweenService (ref), Frame (copy) ]]
		task.wait(v1.Time + 1.5)
		SimpleFOV.Change_FOV(70, v2.Time / 2)
		TweenService:Create(Frame, v2, {
			BackgroundTransparency = 1
		}):Play()
	end)
end

return t