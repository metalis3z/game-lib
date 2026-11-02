local LocalPlayer_v0 = game.Players.LocalPlayer
local var1 = LocalPlayer_v0:GetMouse()
local var2 = false
local Humanoid_v0 = LocalPlayer_v0.Character.Humanoid

game:GetService("UserInputService").JumpRequest:connect(function()
	if var2 then
		local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
		humanoid:ChangeState('Jumping')
	end
end)

script.Parent.Activated:Connect(function()
	var2 = true
end)
script.Parent.Deactivated:Connect(function()
	var2 = false
end)