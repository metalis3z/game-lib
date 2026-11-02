wait()
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Char = Player.Character
Mouse.KeyDown:connect(function(k)
	if string.lower(k) == "g" then
		if script.Parent.Parent.ClassName ~= "Backpack" then
		if Mouse.Target then
		local PPlay = Mouse.Target.Parent:FindFirstChild("Humanoid")
		if PPlay then local HRP = PPlay.Parent:FindFirstChild("HumanoidRootPart")
		if HRP then
			if (Char.HumanoidRootPart.Position - HRP.Position).magnitude < 10 then
			if game.Players:FindFirstChild(PPlay.Parent.Name) then
			Char.Humanoid:UnequipTools()
			script.GiveTool:FireServer(PPlay)
			end
			end	
		end
		end
		end
		end
	end
end)