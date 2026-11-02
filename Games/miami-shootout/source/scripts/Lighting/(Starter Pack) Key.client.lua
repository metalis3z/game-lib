local UIS = game:GetService("UserInputService")
local plr = game.Players.LocalPlayer
local animation = Enum.KeyCode.L --change to the letter you want to use

UIS.InputBegan:Connect(function(key, gp)
	if key.KeyCode == animation then
		if UIS:GetFocusedTextBox() == nil then
			local anim = plr.Character.Humanoid:LoadAnimation(script.Anims.animation)
			anim:Play()
			wait(20)
			anim:Stop()
		end
	end
end)