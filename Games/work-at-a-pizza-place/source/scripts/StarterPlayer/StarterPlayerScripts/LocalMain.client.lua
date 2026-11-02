
--when player chooses first job
local camera = game.Workspace.CurrentCamera
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))

local connection
connection = workspace.Main.StartedPlaying.OnClientEvent:connect(function()
	_G["StartedPlaying"] = true
	camera.CameraType = "Custom"
	if connection then connection:disconnect() end
end)


spawn(function()
pcall(function()
	--delete topbar
	repeat until pcall(function() game.StarterGui:SetCore("TopbarEnabled", false) end) or not wait(.1)
end)
end)

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)



local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))
local UIS = game:GetService("UserInputService")
SoundFX:InitializeLocal()

--for tutorial
game.Players.LocalPlayer.Character.ChildRemoved:connect(function(obj)
	if obj and obj:IsA("Tool") and obj.Parent == workspace then
		workspace.GameService.DropTool:FireServer(obj)
	end
end)

--filters local for things like custom signs and pet names
workspace.Main.FilterPlayerText.OnClientEvent:connect(function(objectOwner,object,property)
	if player ~= objectOwner and object and object.Parent and property then
		object[property] = game:GetService("Chat"):FilterStringAsync(object[property],objectOwner,player)
	end
end)


function workspace.Main.GetTeleportData.OnClientInvoke()
	return _G["TeleportData"]
end

function workspace.Main.IsGamepadEnabled.OnClientInvoke(studioEnabled)
	return game:GetService("GuiService"):IsTenFootInterface() or (game:GetService("RunService"):IsStudio() and studioEnabled)
end


--set camera angle when delivering to house
workspace.GameService.ChangeCamera.OnClientEvent:connect(function(givepizza,inverted_house) 
	if givepizza == nil then
		camera.CameraType = "Custom"
		camera.FieldOfView = 70
		workspace.Main.RealignCamera.RealignCamera:Fire(25,12)
	else
		camera.CameraType = "Scriptable"
		camera.FieldOfView = 60
		if inverted_house then
			
			camera.CoordinateFrame = CFrame.new( givepizza.CFrame.p + (givepizza.CFrame.lookVector *-4)  + Vector3.new(-2,6,-4.3),givepizza.CFrame.p + (givepizza.CFrame.lookVector * 5)  + Vector3.new(0,4,0))
			--camera.Focus = CFrame.new()
			-- camera.CoordinateFrame = (givepizza.CFrame *CFrame.Angles((7*math.pi)/4 + (math.pi/6), (11.2*math.pi)/6, 0)) + ((givepizza.CFrame.lookVector.unit *-4)  + Vector3.new(0,6,-3.3))
			--camera:SetRoll(0)
			--local point = camera.CoordinateFrame.lookVector * 2
			--camera.CoordinateFrame = CFrame.new(Vector3.new(camera.CoordinateFrame.X,camera.CoordinateFrame.Y,camera.CoordinateFrame.Z),point)
		else
			camera.CoordinateFrame = CFrame.new( givepizza.CFrame.p + (givepizza.CFrame.lookVector *-4)  + Vector3.new(2,6,4.3),givepizza.CFrame.p + (givepizza.CFrame.lookVector * 5)  + Vector3.new(0,4,0))

			 --camera.CoordinateFrame = (givepizza.CFrame *CFrame.Angles((7*math.pi)/4 + (math.pi/6), ((7*math.pi)/4) + (math.pi/8), 0)) + ((givepizza.CFrame.lookVector.unit *-4)  + Vector3.new(0,6,3.3))
			--camera:SetRoll(0)
			--local point = camera.CoordinateFrame.lookVector * 2
			--camera.CoordinateFrame = CFrame.new(Vector3.new(camera.CoordinateFrame.X,camera.CoordinateFrame.Y,camera.CoordinateFrame.Z),point)
		end
	end
end)



if not Enums.IsPartyServer then
	workspace.Main.ShowBoatButton.OnClientEvent:connect(function()
		workspace.Dock["Spawn Boat"].Head.Transparency = 0
	end)
end


workspace.Main.SetWindowVisible.OnClientEvent:connect(function(windowName,visible)
	GuiManager:GetWindowDataByName(windowName):SetVisible(visible)
end)

workspace.Main.OpenDevConsole.OnClientEvent:connect(function()
	game.StarterGui:SetCore("DeveloperConsoleVisible", true)
end)



--get player's house
spawn(function()
	while true do
		for _,house in ipairs(workspace.Houses:GetChildren()) do
			if house:FindFirstChild("Owner") and house.Owner.Value == player then
				_G["House"] = house
				return
			end
		end
		wait(.1)
	end
end)


--give delete tool when entering house
local deleteTool = nil
local currentHouse
local lastHouse
local detectInRange = false




while true do
	wait(3)
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		if	_G["House"] and _G["House"].CurrentUpgrade.Value and ((player.Character.HumanoidRootPart.Position*Vector3.new(1,0,1)) - (_G["House"].CurrentUpgrade.Value.GivePizza.Position*Vector3.new(1,0,1))).magnitude < 100 then			
			if not player.Backpack:FindFirstChild("Delete") and not player.Character:FindFirstChild("Delete") then
				deleteTool = game.ReplicatedStorage.Delete:clone()
				deleteTool.Parent = player.Backpack
			end
		else
			if deleteTool then 
				currentHouse = nil
				local tool = deleteTool --just is chase deleteTool changes
				if tool.Parent == player.Character then
					player.Character.Humanoid:UnequipTools()
				end
				wait()
				tool:Destroy()
			end
		end
	end
end

--[[
workspace.Main.LocationChanged.OnClientEvent:connect(function(zone,house)
	currentHOuse
	
	
	if house and house ~= currentHouse and house.Owner.Value == player then
		detectInRange = false
		currentHouse = house
		if not player.Backpack:FindFirstChild("Delete") and not player.Character:FindFirstChild("Delete") then
			deleteTool = game.ReplicatedStorage.Delete:clone()
			deleteTool.Parent = player.Backpack
		end
		
	elseif zone == nil and currentHouse then --outisde
		detectInRange = true
		while detectInRange do
			wait(1)
			if	((player.Character.Torso.Position*Vector3.new(1,0,1)) - (myHouse.CurrentUpgrade.Value.GivePizza.Position*Vector3.new(1,0,1))).magnitude > 25 then
				break
			end
		end

		if deleteTool then 
			currentHouse = nil
			local tool = deleteTool --just is chase deleteTool changes
			player.Character.Humanoid:UnequipTools()
			wait()
			tool:Destroy()
		end
		
	end
end)]]

