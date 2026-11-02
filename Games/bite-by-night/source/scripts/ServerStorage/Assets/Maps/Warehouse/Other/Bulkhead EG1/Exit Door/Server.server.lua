local TweenService = game:GetService("TweenService")

local doorCFrame = script.Parent.CFrame
workspace.GAME.CAN_ESCAPE:GetPropertyChangedSignal("Value"):Connect(function()
	if workspace.GAME.CAN_ESCAPE.Value == true and script.Parent:FindFirstAncestorOfClass("Workspace") then
		TweenService:Create(script.Parent, TweenInfo.new(20), {CFrame = doorCFrame + Vector3.new(0, 22, 0)}):Play()
	else
		TweenService:Create(script.Parent, TweenInfo.new(20), {CFrame = doorCFrame}):Play()
	end
end)