wait()
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Char = Player.Character
Mouse.KeyDown:connect(function(k)
	if string.lower(k) == "q" then
		if script.Parent.Parent.ClassName ~= "Backpack" then
		if Mouse.Target then
				local PPlay = Mouse.Target.Parent:FindFirstChild("Humanoid")
			--	local PPlay2 = Char:FindFirstChild("Humanoid")
		if PPlay then local HRP = PPlay.Parent:FindFirstChild("HumanoidRootPart")
		if HRP then
			if (Char.HumanoidRootPart.Position - HRP.Position).magnitude < 10 then
			if game.Players:FindFirstChild(PPlay.Parent.Name) then
								Char.Humanoid:UnequipTools()
								
								


								local pass1 = PPlay:LoadAnimation(script.Animation)
								local pass2 = Char.Humanoid:LoadAnimation(script.Animation)
								pass1:Play()
								pass2:Play()
script.GiveTool:FireServer(PPlay)
								
								
								script.Tag:FireServer(PPlay)
								
							--	script.Tag2:FireServer(PPlay2)
									end







			
			end
			end	
		end
		end
		end
		end

end)

