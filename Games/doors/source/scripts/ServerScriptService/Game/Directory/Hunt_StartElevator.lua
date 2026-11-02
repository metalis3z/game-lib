local module = {}


repeat wait(0.1) until game.Workspace.CurrentRooms:FindFirstChild("0")

if game.Workspace.CurrentRooms:FindFirstChild("0"):GetAttribute("OriginalName") == "Hunt_FirstRoom" then

else
	script.Enscript.Enabled = false
	return
end

-- Created and Fixed by BUILDG Studios
local countdown = 0
local l__Seconds__3 = workspace:FindFirstChild("StarterElevator", true).DoorHitbox.BillboardGui:WaitForChild("Seconds");
local l__TweenService__1 = game:GetService("TweenService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EntityInfoEvents = ReplicatedStorage:WaitForChild("ClientModules")

function module.Elevator()
	local skipped = false
	print("ch2")
	local player_found = false
	local teleport_evelator_data = nil

	--[[for i,v in pairs(game.Players:GetPlayers()) do
		player_found = true
		if v.PlayerStats.TypeRun.Value == "Hunt" then
			teleport_evelator_data = v:GetJoinData().TeleportData
		end
	end

	if not player_found then
		game.Players.PlayerAdded:Once(function(pt)
			local teleport_evelator_data = pt:GetJoinData().TeleportData
		end)
	end
	local count1 = 0
	repeat
		wait(1)
		count1 += 1
	until teleport_evelator_data ~= nil or count1 == 6
	
	if teleport_evelator_data == nil then
		print("eh, data didn't loaded:(")
	else
		local function return_players_value()
			return #game.Players:GetPlayers()
		end
		local count2 = 0
		local all_players_joined = false
		repeat
			wait(1)
			count2 += 1
			if return_players_value() == teleport_evelator_data.players then
				all_players_joined = true
			end
		until count2 == 15 or all_players_joined == true
	end--]]
	
	local function SetTime(Time)
		if countdown > 0 then
			l__Seconds__3.Text = tostring(Time)
			game.Workspace.GameSettings.Server.TimeElevator.Value = tostring(Time)
		end
		if countdown < 3 then
			skipped = true
			for v10, v11 in pairs(game.Workspace:FindFirstChild("StarterElevator", true).DoorHitbox.BillboardGui.Players:GetChildren()) do
				if v11:IsA("ImageLabel") then
					l__TweenService__1:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
						ImageTransparency = 1
					}):Play();
				end
			end
			l__TweenService__1:Create(workspace:FindFirstChild("StarterElevator", true).DoorHitbox.BillboardGui.Seconds, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				TextTransparency = 1,
				TextStrokeTransparency = 1
			}):Play();
			l__TweenService__1:Create(workspace:FindFirstChild("StarterElevator", true).DoorHitbox.BillboardGui.Title, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				TextTransparency = 1
			}):Play();
		end
	end
	
	local StarterElevator = game.Workspace:FindFirstChild("StarterElevator", true)
	
	workspace:FindFirstChild("StarterElevator", true).DoorHitbox.BillboardGui.Enabled = false
	workspace:FindFirstChild("StarterElevator", true).DoorHitbox.CanCollide = true;
	
	local DoorHitBox = StarterElevator.DoorHitbox
	local Doors_Inside = StarterElevator.Doors_Inside
	local Doors_Outside = StarterElevator.Doors_Outside
	local Doors_Outside2 = StarterElevator.Doors_Outside2
	
	l__TweenService__1:Create(workspace.CurrentRooms["0"]:FindFirstChild("StarterElevator").DoorHitbox.BillboardGui.Title, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		TextTransparency = 1
	}):Play();

	workspace.CurrentRooms["0"]:FindFirstChild("StarterElevator").Model.Model.SkipButton.SkipPrompt.Enabled = true
	workspace.CurrentRooms["0"]:FindFirstChild("StarterElevator").Model.Model.SkipButton.Material = Enum.Material.Neon
	
	workspace:FindFirstChild("StarterElevator", true).Model.Model.SkipButton.SkipPrompt.Triggered:Connect(function(player)
		if skipped ~= true then
			countdown -= 9999
			workspace:FindFirstChild("StarterElevator", true).Model.Model.SkipButton.SkipPrompt.Enabled = false
			workspace:FindFirstChild("StarterElevator", true).DoorHitbox.Attachment.Music.TimePosition = 27.5
			skipped = true
			for v10, v11 in pairs(game.Workspace:FindFirstChild("StarterElevator", true).DoorHitbox.BillboardGui.Players:GetChildren()) do
				if v11:IsA("ImageLabel") then
					l__TweenService__1:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
						ImageTransparency = 1
					}):Play();
				end
			end
			l__TweenService__1:Create(workspace:FindFirstChild("StarterElevator", true).DoorHitbox.BillboardGui.Seconds, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				TextTransparency = 1,
				TextStrokeTransparency = 1
			}):Play();
			l__TweenService__1:Create(workspace:FindFirstChild("StarterElevator", true).DoorHitbox.BillboardGui.Title, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				TextTransparency = 1
			}):Play();
			SetTime(3)
		end
	end)
	
	repeat countdown -= 1 workspace:FindFirstChild("StarterElevator", true).DoorHitbox.Tick:Play() SetTime(countdown) wait(1) until countdown <= 0
	
	DoorHitBox.DoorBell:Play()
	DoorHitBox.DoorMove:Play()
	game.ReplicatedStorage.EntityInfo.TitleLocation:FireAllClients("The Backdoor")
	
	Doors_Outside.TargetPosition = 5
	Doors_Outside2.TargetPosition = 5

	task.wait(0.6)
	Doors_Inside.TargetPosition = 5
	
	for i, v in pairs(game.Players:GetPlayers()) do 
		if v.Character then 
			game.ReplicatedStorage.ClientBricks.RiftSpawn:FireClient(v)
		end
	end
	
	task.wait(1)
	DoorHitBox.CanCollide = false
	
	task.wait(6)
	
	Doors_Outside.TargetPosition = 0
	Doors_Outside2.TargetPosition = 0
	Doors_Inside.TargetPosition = 0
	DoorHitBox.CanCollide = true
	
	while true do
		wait(0.5)
		if workspace.CurrentRooms:FindFirstChild("0") then
			if workspace.CurrentRooms:FindFirstChild("0").PartDebris then
				for i, v in pairs(workspace:GetPartsInPart(workspace.CurrentRooms["0"].PartDebris)) do
					if v.Name == "HumanoidRootPart" then
						local Parent = v.Parent
						local PlayerRef = game.Players:GetPlayerFromCharacter(Parent)
						if PlayerRef then
							task.delay(0.5, function()
								Parent:PivotTo(workspace.CurrentRooms["0"].RoomEntrance.CFrame * CFrame.new(0, 0, -9))
							end)
						end
					end
				end
			end
		else
			break
		end
	end
	
end

return module
