local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RSEngine = ReplicatedStorage:WaitForChild("Engine")
local RemoteEvents = RSEngine:WaitForChild("RemotesEvents")
local PlaySound = RemoteEvents:WaitForChild("PlaySound")
local toggleControlls = RemoteEvents:WaitForChild("toggleControlls")

local ServerScriptService = game:GetService("ServerScriptService")
local Engine = ServerScriptService:WaitForChild("Engine")
local Scripts = Engine:WaitForChild("Scripts")
local Data = Scripts:WaitForChild("Data")
local dataManager = require(Data:WaitForChild("DataManager"))

local SoundService = game:GetService("SoundService")
local main = SoundService:WaitForChild("Main")
local interface = main:WaitForChild("Interface")
local notifactionSFX = interface:WaitForChild("Notification")

local map = workspace:WaitForChild("Map")
local raceSpawn = map:WaitForChild("RaceSpawn")

local points = workspace.Points

local timeToStart = 15

local playersInQueue = {}

local function play(player: Player, character: Model)
	if not table.find(playersInQueue, player) then
 		character:MoveTo(raceSpawn.Part.Position)
		table.insert(playersInQueue, player)
	end
end

game.Players.PlayerRemoving:Connect(function(player)
	if table.find(playersInQueue, player) then
		table.remove(playersInQueue, table.find(playersInQueue, player))
	end
end)

local function start(player: Player, Character: Model)
	coroutine.wrap(function()
		repeat wait() until dataManager.profiles[player]
		local equipedPet = dataManager.profiles[player].Data["EquipedPet"]
		local humanoidRootPart = Character:WaitForChild("HumanoidRootPart")
		if equipedPet ~= "" then
			local petModel = game.ReplicatedStorage.Pets:FindFirstChild(equipedPet)
			if petModel then
				local newPet: Model = petModel:Clone()
				newPet.Parent = workspace
				newPet:PivotTo(points["1"].CFrame)
				
				for i = 2,#points:GetChildren() do
					local point = points[i]
					local distance = (humanoidRootPart.Position - point.Position).Magnitude

					if point then
						local tween = TweenService:Create(newPet.PrimaryPart, TweenInfo.new(distance/100, Enum.EasingStyle.Linear), {Position = point.Position})
						local tween2 = TweenService:Create(newPet.PrimaryPart, TweenInfo.new(distance/100, Enum.EasingStyle.Linear), {Orientation = point.Orientation + Vector3.new(90,0,0)})
						tween:Play()
						tween2:Play()
						tween.Completed:Wait()
					end
				end
			end
		end
	end)()
end

while wait(20) do
	for _, player: Player in pairs(game:GetService("Players"):GetChildren()) do
		local character = player.Character or player.CharacterAdded:Wait()
		
		local playerGui = player.PlayerGui
		local gui = playerGui:WaitForChild("GUI")
		local frames = gui:WaitForChild("Race UI")
		local Noti = frames:WaitForChild("RaceNoti")
		
		PlaySound:FireClient(player, notifactionSFX)
		Noti.Visible = true
		
		Noti.Play.MouseButton1Click:Connect(function()
			Noti.Visible = false
			play(player, character)
		end)
	end
	
	local textLabel = raceSpawn.Part.BillboardGui.TextLabel
	
	for i = 1, timeToStart do
		wait(1)
		textLabel.Text = "Race starting in " .. timeToStart-i .. " seconds!"
	end
	
	for _, player: Player in pairs(game:GetService("Players"):GetChildren()) do
		local playerGui = player.PlayerGui
		local gui = playerGui:WaitForChild("GUI")
		local frames = gui:WaitForChild("Race UI")
		local Noti = frames:WaitForChild("RaceNoti")

		Noti.Visible = false
	end
	
	--if #playersInQueue >= 1 then
		for _, player: Player in pairs(playersInQueue) do
			local character = player.Character or player.CharacterAdded:Wait()
			
			start(player, character)
		end
	--end
end