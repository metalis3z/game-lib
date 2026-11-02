--[[
	Name: 610InfectionHandler
	Description: Essentially the main handler for the distribution of SCP-610 outbreaks.
	Author: thebeast2005R / Software
	To-Do: Nil	
]]--

--[[SERVICES]]--

local TweenService = game:GetService("TweenService")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

--[[DECLARATIONS]]--

local InfectionPart = workspace.SCPs.InfectionSpreader:WaitForChild("610InfectionSpreader")
local SCPStorage = ServerStorage:WaitForChild("610s"):GetChildren()
local Gui = script:WaitForChild("610Gui")

local Touched = false

--[[MAIN]]--

InfectionPart.Touched:Connect(function(Hit)
	print(Hit.Name)
	if not Hit.Parent:FindFirstChild("Infected") then
		print("Infected")
		local Player = Players:GetPlayerFromCharacter(Hit.Parent)
		if Player then
			
		local num = math.random(1,9999999)
			local InfectedValue2 = Instance.new("StringValue", Hit.Parent)
		InfectedValue2.Name = "Infected" .. num
		local InfectedValue = Instance.new("StringValue", Hit.Parent)
		InfectedValue.Name = "Infected"
			local InfectedValue3 = Instance.new("StringValue",Players:GetPlayerFromCharacter(Hit.Parent).PlayerGui )
		InfectedValue3.Name = "Infected"
		
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
		Clone.UpperTorso.CFrame = Player.Character.HumanoidRootPart.CFrame
		Clone.Name = Player.Name
		Hit.Parent:Destroy()
		Player.Character = Clone
		Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
		Gui:Clone().Parent = Player.PlayerGui
		spawn(function()
			Player.Character.Humanoid.Died:Connect(function()
			wait(game.Players.RespawnTime)
			if Player.Character:FindFirstChild("Infected") then
				Player:LoadCharacter()
				Player.CharacterHumanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
			end
			end)
		end)
		wait(700)
		if Player.Character then
			if Player.Character:FindFirstChild("Infected") then
					Player.Character.Humanoid.Health = 0
			end
			end
		end
		
	end
	end
end)

