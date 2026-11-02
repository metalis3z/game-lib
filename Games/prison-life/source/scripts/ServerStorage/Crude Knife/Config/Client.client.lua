local tool = script.Parent.Parent
local remote = script.Parent:WaitForChild("RemoteFunction")

local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")

local track = humanoid:LoadAnimation(tool:WaitForChild("Handle"):WaitForChild("stab"))

IsClicked = false

tool.Equipped:Connect(function(mouse)
	mouse.Button1Down:Connect(function()
		if IsClicked == false then
			IsClicked = true
			
			track:Play()
						
			remote:InvokeServer()
						
			IsClicked = false
		end
	end)
end)

tool.Unequipped:Connect(function()
	track:Stop()
end)