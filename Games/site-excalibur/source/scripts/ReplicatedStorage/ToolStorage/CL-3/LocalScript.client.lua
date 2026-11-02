local plr = game.Players.LocalPlayer
local anim = script.Parent:WaitForChild("HoldAnim")
local swipeanim = script.Parent:WaitForChild("SwipeAnim")
local UIS = game:GetService("UserInputService")

script.Parent.Equipped:Connect(function(mouse)
	plr.Character.Humanoid:LoadAnimation(anim):Play()
	mouse.Button1Down:Connect(function()
		plr.Character.Humanoid:LoadAnimation(swipeanim):Play()
	end)
end)

script.Parent.Unequipped:Connect(function()
	for i,v in ipairs(plr.Character.Humanoid:GetPlayingAnimationTracks()) do
		if v.Name == "HoldAnim" then
			v:Stop()
		end
	end
end)