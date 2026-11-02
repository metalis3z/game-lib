local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

local GUI = script:WaitForChild("610Gui")
local SCPStorage = ServerStorage:WaitForChild("610s"):GetChildren()

for _,AllChildren in pairs(script.Parent:GetChildren()) do
	if AllChildren:IsA("BasePart") or AllChildren:IsA("MeshPart") then
		AllChildren.Touched:Connect(function(Hit)
			if not Hit.Parent:FindFirstChild("Infected") then
		print("Infected")
		local Player = Players:GetPlayerFromCharacter(Hit.Parent)
		if Player then
			local InfectedValue2 = Instance.new("StringValue", Player.PlayerGui)
		InfectedValue2.Name = "Infected"
		local InfectedValue = Instance.new("StringValue", Hit.Parent)
		InfectedValue.Name = "Infected"
		
		
		wait(6)
		Player.Character.Humanoid.PlatformStand = true
		wait()
		Player.Character.Humanoid.PlatformStand = false
	if Player.Character.Humanoid.Health >= 0 and Player.Character.Humanoid.Health ~= 0 then
				wait(0.1)
		Player.Character.Humanoid.MaxHealth = math.huge
		wait(0.01)
		Player.Character.Humanoid.Health = math.huge
			InfectedValue:Destroy()
			InfectedValue2:Destroy()
		local Clone = SCPStorage[math.random(1,#SCPStorage)]:Clone()
		Clone.Parent = workspace
		print("Cloned")
		Clone.UpperTorso.CFrame = Player.Character.UpperTorso.CFrame
		Clone.Name = Player.Name
		Hit.Parent:Destroy()
		Player.Character = Clone
		script["610Gui"]:Clone().Parent = Player.PlayerGui
		Player.Character.Humanoid.Died:Connect(function()
			wait(20)
			Player:LoadCharacter()
		end)
		wait(600)
		if Player.Character then
			if Player.Character:FindFirstChild("Infected") then
					Player.Character.Humanoid.Health = 0
			end
			end
		end
	end
	end
		end)
	end
end