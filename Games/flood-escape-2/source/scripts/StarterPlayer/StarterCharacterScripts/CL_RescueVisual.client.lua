local ClonedNPCModel = nil
local v13 = 0.5
local v16 = -1
local v12 = 0.5

local function DeleteModel(RescueModel : Model)
	RescueModel:FindFirstChild("NPC"):Destroy()
	RescueModel.Billboard.Enabled = false
	for i = 0, 1, 0.066 do
		for _, v in pairs(RescueModel.Visual:GetDescendants()) do
			if v.Name == "Decal" then
				v.Transparency = i
			end
		end
		wait(0.033)
	end
	RescueModel:Destroy()
end
function removeOldNPC(p2)
	if ClonedNPCModel ~= nil and game.Players.LocalPlayer.PlayerScripts.CL_MAIN_GameScript.GetPlayerData:Invoke().PlayerState == "Won" then
		local e_Name = game.Workspace.Multiplayer:WaitForChild("Map"):FindFirstChild("Settings"):FindFirstChild("Rescue"):GetAttribute("RescueName") or "Escappe"
		local Map = game.Workspace.Multiplayer:WaitForChild("Map")
		local Difficulty = (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("Difficulty")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("Difficulty") and Map:FindFirstChild("Settings"):FindFirstChild("Difficulty").Value) or 6.9
		if Difficulty <= 3 then
			game.Players.LocalPlayer.PlayerScripts.CL_MAIN_GameScript.Alert:Fire("💎 Rescued " .. e_Name .. "! +1 Gems 💎", Color3.fromRGB(241, 219, 128), 4, "event")
		else
			game.Players.LocalPlayer.PlayerScripts.CL_MAIN_GameScript.Alert:Fire("💎 Rescued " .. e_Name .. "! +2 Gems 💎", Color3.fromRGB(241, 219, 128), 4, "event")
		end
		p2:Destroy()
	end
	ClonedNPCModel = nil
end
local function startNpcFollow(RescueModel : Model, arg1)
	if RescueModel == nil then
		if arg1 then
			spawn(function()
				removeOldNPC(ClonedNPCModel)
			end)
			return
		end
	end
	local NPCModel = RescueModel:FindFirstChild("NPC")
	if NPCModel ~= nil then
		if workspace.CurrentCamera:FindFirstChild("NPC") then
			return
		end
		ClonedNPCModel = NPCModel:Clone()
		ClonedNPCModel.HumanoidRootPart.CFrame = RescueModel.NPC.HumanoidRootPart.CFrame
		ClonedNPCModel.Parent = workspace.CurrentCamera
		for i, v in pairs(ClonedNPCModel:GetChildren()) do
			if v:IsA("BasePart") then
				v.CollisionGroup = "Chars"
				v.Anchored = true
			end
		end
		spawn(function() 
			DeleteModel(RescueModel)	
		end)
		local v57 = -1
		v16 = v57
		delay(0.5, function()
			for i = 0, 0.5, 0.01 do
				v13 = i
				v16 = -1 + (i) * 2
				wait(0.05)
			end
		end)
		while true do
			game:GetService("RunService").RenderStepped:Wait()
			local char = script.Parent
			if char == nil then
				break
			end

			-- Ensure script.Parent is a valid model with the required parts
			if not char:FindFirstChild("HumanoidRootPart") or 
				not char:FindFirstChild("Head") or 
				not char:FindFirstChild("Torso") or 
				not char:FindFirstChild("Left Arm") or 
				not char:FindFirstChild("Right Arm") or 
				not char:FindFirstChild("Left Leg") or 
				not char:FindFirstChild("Right Leg") then
				break
			end

			local tick_1 = (tick()) * 1.5
			local math_1 = 0.55 + (math.sin(tick_1)) * 0.15
			local dataTable = {}
			dataTable.HumanoidRootPart = char.HumanoidRootPart.CFrame
			dataTable.Head = char.Head.CFrame
			dataTable.Torso = char.Torso.CFrame
			dataTable["Left Arm"] = char["Left Arm"].CFrame
			dataTable["Right Arm"] = char["Right Arm"].CFrame
			dataTable["Left Leg"] = char["Left Leg"].CFrame
			dataTable["Right Leg"] = char["Right Leg"].CFrame
			if ClonedNPCModel == nil then
				break
			end
			delay(0.5, function()
				v57 = dataTable
				if ClonedNPCModel == nil then return end
				for i, v in pairs(ClonedNPCModel:GetChildren()) do
					if v:IsA("BasePart") then
						v.CFrame = v.CFrame:Lerp(v57[v.Name], v13)
					end
				end
				for i, v in pairs(ClonedNPCModel:GetDescendants()) do
					if v:IsA("BasePart") then
						local magnitude = (char.HumanoidRootPart.Position - ClonedNPCModel.HumanoidRootPart.Position).Magnitude
						--print(magnitude)
						local fade = 1 - math.min(magnitude * 0.15, 1)
						--print(fade)
						v.LocalTransparencyModifier = fade
					end
				end
			end)
		end

	end
end

script.Parent:WaitForChild("Humanoid").Died:connect(function()
	local v138 = ClonedNPCModel
	if v138 then
		v138 = spawn
		v138(function()
			removeOldNPC(ClonedNPCModel)
		end)
	end
end)
game.ReplicatedStorage.Remote:WaitForChild("RescueTrigger").OnClientEvent:connect(startNpcFollow)