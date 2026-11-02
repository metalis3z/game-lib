local StartRestore = script.Parent:FindFirstChildOfClass("Humanoid"):LoadAnimation(script.StartRestore)
local Restoring = script.Parent:FindFirstChildOfClass("Humanoid"):LoadAnimation(script.Restoring)
local StopRestore = script.Parent:FindFirstChildOfClass("Humanoid"):LoadAnimation(script.StopRestore)
local Restore = false

script.Play.Changed:Connect(function()
	if script.Play.Value == 1 then
		Restore = true
		StartRestore:Play()
		wait(0.5)
		if Restore == true then
		Restoring:Play()
		end
	elseif script.Play.Value == 0 then
		Restore = false
		StartRestore:Stop()
		Restoring:Stop()
		StopRestore:Play()
	end
end)