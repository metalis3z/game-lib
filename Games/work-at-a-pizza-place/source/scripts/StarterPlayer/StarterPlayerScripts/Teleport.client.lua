local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
if player.Name == "Dued1" or player.Name == "Dert41" or string.sub(player.Name,1,6) == "Player" then
	local tDown = false
	mouse.Button1Down:connect(function()
		if tDown and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0,7,0))
		end
	end)
	
	mouse.KeyDown:connect(function(key)
		if key == "`" then
			tDown = not tDown
		end
	end)
	
	
end