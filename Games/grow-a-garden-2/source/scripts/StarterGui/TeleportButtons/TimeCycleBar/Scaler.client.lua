--credit to quartz games studio
local LocalPlayer = game.Players.LocalPlayer

task.wait(1)
require(LocalPlayer.PlayerScripts.Controllers.NotificationController)

local TopbarStandard = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TopbarStandard")
local Holders = TopbarStandard:WaitForChild("Holders")
local Left = Holders:WaitForChild("Left")
local Right = Holders:WaitForChild("Right")

script.Parent.AnchorPoint = Vector2.new(0.5, 0)

local CurrentCamera = game.Workspace.CurrentCamera

function Calculate() --[[ Calculate | Line: 18 | Upvalues: Left (copy), Right (copy), CurrentCamera (copy), TopbarStandard (copy) ]]
	local v1 = (-1 / 0)
	local v2 = nil

	for k, v in pairs(Left:GetChildren()) do
		if v:IsA("Frame") and (v.Visible and v1 < v.LayoutOrder) then
			v1 = v.LayoutOrder
			v2 = v
		end
	end

	local v3 = (1 / 0)
	local v4 = nil

	for k, v in pairs(Right:GetChildren()) do
		if v:IsA("Frame") and (v.Visible and v.LayoutOrder < v3) then
			v3 = v.LayoutOrder
			v4 = v
		end
	end

	local v5 = if v2 then v2.AbsolutePosition.X + v2.AbsoluteSize.X else 0
	local v6 = if v4 then v4.AbsolutePosition.X else CurrentCamera.ViewportSize.X
	local X = TopbarStandard.AbsolutePosition.X
	local v7 = CurrentCamera.ViewportSize.X / 2
	local v8 = script.Parent.AbsoluteSize.X / 2

	script.Parent.Position = UDim2.new(0, (if (if v7 - v8 < v5 then true else false) or (if v6 < v7 + v8 then true else false) then (v5 + v6) / 2 else v7) - script.Parent.Parent.AbsolutePosition.X, 0, 0)
end
task.wait(0.1)
Calculate()
CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 76 ]]
	Calculate()
end)
game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 81 ]]
	Calculate()
end)