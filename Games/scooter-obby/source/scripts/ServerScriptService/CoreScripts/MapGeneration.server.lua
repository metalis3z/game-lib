local ss = game:GetService("ServerStorage")
local rs = game:GetService("ReplicatedStorage")
local DataStore2 = require(rs.ModuleScripts.DataStore2)
local beforeLoadingWall = workspace.Lobby.BeforeLoadedWall

local mapSize
if #ss.StagesInRotation:GetChildren() > 40 then
	mapSize = 40
else
	mapSize = #ss.StagesInRotation:GetChildren()
end

while true do
	workspace.CurrentMap:ClearAllChildren()
	for i, v in pairs(game.Players:GetChildren()) do
		v.leaderstats.Stage.Value = 0
		rs.RemoteEvents.clientTP:FireClient(v)
	end
	
	local currentEndPoint = workspace.Lobby.FirstEndPoint
	
	local newMap = false
	local usedNumbers = {}
	local mapsInPool = {}
	for i,v in pairs(ss.StagesInRotation:GetChildren()) do
		if v:IsA("Folder") then
			table.insert(mapsInPool, v.Name)
		end
	end
	for count = 1, mapSize, 1 do
		local random
		repeat
			random = math.random(1, #mapsInPool)
			if table.find(mapsInPool, mapsInPool[random]) then
				newMap = true
			else
				print("not new")
			end
			task.wait(0.01)
		until newMap == true
		local stage = ss.StagesInRotation[mapsInPool[random]]:Clone()
		stage.Parent = workspace.CurrentMap
		stage.Build:PivotTo(CFrame.new() * CFrame.Angles(0,math.rad(-180),0) + currentEndPoint.Position)
		currentEndPoint = stage.Build.EndPoint
		stage.Build.Checkpoint:SetAttribute("Stage", count)
		rs.TopBarAssets["Stage" .. count .. "Size"].Value = (currentEndPoint.Position.X - stage.Build.PrimaryPart.Position.X) + 1
		rs.TopBarAssets["Stage" .. count .. "Color"].Value = stage.Color.Value
		table.remove(mapsInPool, random)
		rs.StagesLoaded.Value = count
		wait(0.03)
	end
	
	local endTile = ss.EndTile:Clone()
	endTile.Parent = workspace.CurrentMap
	endTile.Build:PivotTo(CFrame.new() * CFrame.Angles(0,math.rad(-90),0) + currentEndPoint.Position)
	endTile.Build.LastEndPoint.Parent = workspace.Lobby
	rs.TopBarAssets.Stage41Size.Value = 130
	
	rs.TopBarAssets.Stage41Color.Value = Color3.new(0.368627, 0.368627, 0.368627)
	beforeLoadingWall.SurfaceGui.Enabled = false
	beforeLoadingWall.Color = Color3.new(1,0,0)
	rs.Sounds.ReadySet:Play()
	wait(1)
	beforeLoadingWall.Color = Color3.new(1, 0.415686, 0)
	wait(1)
	beforeLoadingWall.Color = Color3.new(1, 0.701961, 0)
	wait(1)
	beforeLoadingWall.ParticleEmitter:Emit(100)
	rs.Loaded.Value = true
	beforeLoadingWall.CanCollide = false
	beforeLoadingWall.Transparency = 1
	local seconds = 360
	local startTime = os.time()
	repeat
		local minutes = math.floor(seconds / 60)
		local secondsRemaining = seconds % 60
		local timeWait = 1 / ss.CurrentMultiplier.Value
		local timeString = string.format("%d:%02d", minutes, secondsRemaining)

		seconds = seconds - 1
		rs.TimeLeft.Value = timeString
		rs.RawTimeLeft.Value = seconds
		ss.CurrentMultiplier.Value = (#ss.PlayersDone:GetChildren() + 1)
		for i,v in pairs(ss.PlayersDone:GetChildren()) do
			if not v:FindFirstChild("Announced") then
				local announced = Instance.new("BoolValue", v)
				announced.Name = "Announced"
				announced.Value = true
				local timePassed = os.time() - startTime
				local minutes = math.floor(timePassed / 60)
				local secondsRemaining = timePassed % 60
				local timeString = string.format("%d:%02d", minutes, secondsRemaining)
				
				local BestTimeStore = DataStore2("bestTime", game.Players[v.Name])
				BestTimeStore:Set(timePassed)
				
				game.ReplicatedStorage.RemoteEvents.Announce:FireAllClients(game.Players:FindFirstChild(v.Name), timeString)
			end
		end
		rs.CurrentMultiplier.Value = ss.CurrentMultiplier.Value
		wait(timeWait)
	until seconds < 0
	usedNumbers = {}
	rs.Loaded.Value = false
	beforeLoadingWall.CanCollide = true
	beforeLoadingWall.Transparency = 0.75
	beforeLoadingWall.SurfaceGui.Enabled = true
	beforeLoadingWall.Color = Color3.new(1,1,1)
	ss.CurrentMultiplier.Value = 1
	ss.PlayersDone:ClearAllChildren()
	for i,v in pairs(game.Players:GetChildren()) do
		if v:FindFirstChild("hidden") then
			v.hidden.HighestStage.Value = 0
		end
		v.leaderstats.Stage.Value = 0
		local stageObjects = {}

		local CollectionService = game:GetService("CollectionService")

		for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
			local stage = cp:GetAttribute("Stage")

			if not stageObjects[stage] then
				stageObjects[stage] = {}
			end

			table.insert(stageObjects[stage], cp)
		end
		game.Players:FindFirstChild(v.Name):SetAttribute("Safe2", .5)
		rs.RemoteEvents.clientTP:FireClient(v, stageObjects[game.Players:FindFirstChild(v.Name).leaderstats.Stage.Value])
		if v:FindFirstChild("hidden") then
			v.hidden.HighestStage.Value = 0
		end
		v.leaderstats.Stage.Value = 0
	end
end