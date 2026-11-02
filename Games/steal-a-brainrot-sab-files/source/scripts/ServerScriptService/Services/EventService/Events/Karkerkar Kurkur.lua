
local KarkerkarKurkur = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local Workspace = workspace

local Net = require(ReplicatedStorage.Packages.Net)
local StruckEvent = Net:RemoteEvent("EventService/Karkerkar Kurkur/Spawn")

local Active = false
local ChairsFolder = nil
local Chairs = {}
local ChairConnections = {}
local MusicRunning = false
local MusicStartTime = 0

local function LockPlayer(p)
	if not p or not p.Character then return end
	local h = p.Character:FindFirstChildOfClass("Humanoid")
	if not h then return end

	if h:GetAttribute("KarkerSavedWalkSpeed") == nil then
		h:SetAttribute("KarkerSavedWalkSpeed", h.WalkSpeed)
	end
	if h:GetAttribute("KarkerSavedJumpPower") == nil then
		h:SetAttribute("KarkerSavedJumpPower", h.JumpPower)
	end

	h.WalkSpeed = 0
	h.JumpPower = 0
	h:SetAttribute("KarkerLocked", true)
end

local function UnlockPlayer(p)
	if not p or not p.Character then return end
	local h = p.Character:FindFirstChildOfClass("Humanoid")
	if not h then return end

	local savedWS = h:GetAttribute("KarkerSavedWalkSpeed")
	local savedJP = h:GetAttribute("KarkerSavedJumpPower")

	if type(savedWS) == "number" then
		h.WalkSpeed = savedWS
	else
		h.WalkSpeed = 34
	end

	if type(savedJP) == "number" then
		h.JumpPower = savedJP
	else
		h.JumpPower = 50
	end

	h:SetAttribute("KarkerLocked", false)
	h:SetAttribute("KarkerSavedWalkSpeed", nil)
	h:SetAttribute("KarkerSavedJumpPower", nil)
end


local function makeStatePayload(isPaused)
	local now = Workspace:GetServerTimeNow()
	local elapsedSound = MusicRunning and (now - MusicStartTime) or 0

	return {
		IsPaused = isPaused,
		StateChangeTime = now,
		ElapsedSoundTime = elapsedSound,
		ReplicationTime = now
	}
end

local function setEventStateAttribute(isPaused)
	local payload = makeStatePayload(isPaused)
	ReplicatedStorage:SetAttribute("KarkerkarKurkurEventState", HttpService:JSONEncode(payload))
end

local function clearEventStateAttribute()
	ReplicatedStorage:SetAttribute("KarkerkarKurkurEventState", nil)
end

local function setPlayerSeatedAttributes()
	local seatedByUserId = {}
	for _, chair in ipairs(Chairs) do
		local uid = chair:GetAttribute("TakenBy")
		if uid then
			seatedByUserId[tostring(uid)] = true
		end
	end

	for _, ply in ipairs(Players:GetPlayers()) do
		local seated = (seatedByUserId[tostring(ply.UserId)] == true)
		ply:SetAttribute("KarkerkarKurkurEventSeated", seated)

		if seated then
			LockPlayer(ply)
		else
			UnlockPlayer(ply)
		end
	end
end

local function clearPlayerSeatedAttributes()
	for _, ply in ipairs(Players:GetPlayers()) do
		ply:SetAttribute("KarkerkarKurkurEventSeated", false)
		UnlockPlayer(ply)
	end
end


local function getEventCenterPos()
	local attr = ReplicatedStorage:GetAttribute("KarkerkarKurkurEventCFrame")
	if typeof(attr) == "Vector3" then
		return attr
	end
	if Workspace.Events and Workspace.Events["Karkerkar Kurkur"] and Workspace.Events["Karkerkar Kurkur"].MapCenterGround then
		return Workspace.Events["Karkerkar Kurkur"].MapCenterGround.Position
	end
	return Vector3.new(0, 5, 0)
end

local function findSeatPart(modelOrPart)
	if not modelOrPart then return nil end
	if modelOrPart:IsA("BasePart") then
		return modelOrPart
	end
	if modelOrPart.PrimaryPart and modelOrPart.PrimaryPart:IsA("BasePart") then
		return modelOrPart.PrimaryPart
	end
	for _, v in ipairs(modelOrPart:GetDescendants()) do
		if v:IsA("BasePart") then
			return v
		end
	end
	return nil
end

local function ensureProximityPrompt(part)
	if not part then return nil end
	local prompt = part:FindFirstChildOfClass("ProximityPrompt")
	if prompt then return prompt end

	prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Sit"
	prompt.ObjectText = "Chair"
	prompt.KeyboardKeyCode = Enum.KeyCode.E
	prompt.HoldDuration = 0
	prompt.MaxActivationDistance = 10
	prompt.RequiresLineOfSight = false
	prompt.Enabled = false
	prompt.Parent = part
	return prompt
end

local function SpawnChairs(count)
	if ChairsFolder and ChairsFolder.Parent then
		ChairsFolder:Destroy()
		ChairsFolder = nil
	end

	ChairsFolder = Instance.new("Folder")
	ChairsFolder.Name = "KarkerkarChairs"
	ChairsFolder.Parent = Workspace

	local template = ServerStorage:WaitForChild("KarkerkarChair")
	local center = getEventCenterPos()
	local radius = 18
	local raisedY = 0.75

	Chairs = {}
	for k, conn in pairs(ChairConnections) do
		if conn then conn:Disconnect() end
	end
	ChairConnections = {}

	for i = 1, count do
		local angle = (i / count) * math.pi * 2
		local pos = center + Vector3.new(math.cos(angle) * radius, raisedY, math.sin(angle) * radius)

		local clone = template:Clone()
		local seatPart = findSeatPart(clone)

		clone.Parent = ChairsFolder

		if clone:IsA("Model") then
			for _, p in ipairs(clone:GetDescendants()) do
				if p:IsA("BasePart") then
					p.Anchored = true
					p.CanCollide = false
				end
			end
		elseif clone:IsA("BasePart") then
			clone.Anchored = true
			clone.CanCollide = false
		end

		local targetCFrame = CFrame.new(pos, center)
		local ok, err = pcall(function()
			if clone.PivotTo then
				clone:PivotTo(targetCFrame)
			elseif clone:IsA("Model") and clone.PrimaryPart then
				clone:SetPrimaryPartCFrame(targetCFrame)
			elseif seatPart then
				seatPart.CFrame = targetCFrame
			else
				if clone:IsA("Model") then
					clone:MoveTo(pos)
				elseif clone:IsA("BasePart") then
					clone.CFrame = targetCFrame
				end
			end
		end)
		if not ok then
			warn("Failed to pivot chair clone:", err)
		end

		CollectionService:AddTag(clone, "KarkerkarChair")
		table.insert(Chairs, clone)

		clone:SetAttribute("Taken", false)
		clone:SetAttribute("TakenBy", nil)

		local promptTarget = findSeatPart(clone) or clone
		local prompt = ensureProximityPrompt(promptTarget)
		if prompt then prompt.Enabled = false end

		local triggeredConn
		triggeredConn = prompt.Triggered:Connect(function(player)
			if not Active then return end
			if MusicRunning then return end
			if clone:GetAttribute("TakenBy") then return end
			clone:SetAttribute("TakenBy", player.UserId)
			clone:SetAttribute("Taken", true)

			if player.Character then
				local hum = player.Character:FindFirstChildOfClass("Humanoid")
				if hum then
					hum.Sit = true
				end
			end
			LockPlayer(player)
		end)

		local takenConn = clone:GetAttributeChangedSignal("TakenBy"):Connect(function()
			if not Active then return end
			setPlayerSeatedAttributes()
			local taken = clone:GetAttribute("TakenBy")
			if prompt then
				prompt.Enabled = (not MusicRunning) and (taken == nil)
			end
		end)

		ChairConnections[clone] = {
			triggered = triggeredConn,
			takenConn = takenConn
		}
	end

	setPlayerSeatedAttributes()
end


local function EnablePrompts(enabled)
	for _, chair in ipairs(Chairs) do
		local promptTarget = findSeatPart(chair) or chair
		local prompt = promptTarget and promptTarget:FindFirstChildOfClass("ProximityPrompt")
		if prompt then
			local takenBy = chair:GetAttribute("TakenBy")
			prompt.Enabled = enabled and (takenBy == nil)
		end
	end
end

local function StrikeLosers()
	local losers = {}

	for _, plr in ipairs(Players:GetPlayers()) do
		local seated = false
		for _, chair in ipairs(Chairs) do
			local taken = chair:GetAttribute("TakenBy")
			if taken and tonumber(tostring(taken)) == plr.UserId then
				seated = true
				break
			end
		end

		if not seated then
			local pos
			if plr.Character then
				local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					pos = hrp.Position
				else
					local head = plr.Character:FindFirstChild("Head")
					if head then pos = head.Position end
				end
			end
			if not pos then pos = getEventCenterPos() end
			table.insert(losers, pos)
		end
	end

	for _, pos in ipairs(losers) do
		if StruckEvent and StruckEvent.FireAllClients then
			StruckEvent:FireAllClients(pos)
		else
			local ok, _ = pcall(function() StruckEvent:SendToAllPlayers(pos) end)
			if not ok and StruckEvent and StruckEvent.SendToPlayers then
				local allPlayers = Players:GetPlayers()
				StruckEvent:SendToPlayers(allPlayers, pos)
			end
		end
	end
end

local function StartRoundMusic()
	MusicRunning = true
	MusicStartTime = Workspace:GetServerTimeNow()
	setEventStateAttribute(false)

	EnablePrompts(false)

	task.delay(math.random(4, 8), function()
		if not Active then return end

		MusicRunning = false
		setEventStateAttribute(true)
		EnablePrompts(true)

		task.wait(0.25)

		setPlayerSeatedAttributes()
		StrikeLosers()
	end)
end


local function RunGame()
	local totalPlayers = #Players:GetPlayers()
	local chairCount = math.max(1, totalPlayers - 1)

	SpawnChairs(chairCount)

	while Active and chairCount > 1 do
		StartRoundMusic()

		task.wait(10)

		if #Chairs > 1 then
			local idx = math.random(1, #Chairs)
			local removed = table.remove(Chairs, idx)
			local conns = ChairConnections[removed]
			if conns then
				if conns.triggered and conns.triggered.Disconnect then pcall(conns.triggered.Disconnect, conns.triggered) end
				if conns.takenConn and conns.takenConn.Disconnect then pcall(conns.takenConn.Disconnect, conns.takenConn) end
				ChairConnections[removed] = nil
			end
			if removed and removed.Parent then
				removed:Destroy()
			end
			chairCount = chairCount - 1
		end

		EnablePrompts(false)
	end

	if Active then
		StartRoundMusic()
		task.wait(5)
	end
end


function KarkerkarKurkur.OnStart()
	if Active then return end
	Active = true

	ReplicatedStorage:SetAttribute("KarkerkarKurkurEventRunning", true)

	Chairs = {}
	ChairConnections = {}

	task.spawn(RunGame)
end

function KarkerkarKurkur.OnStop()
	if not Active then return end
	Active = false

	ReplicatedStorage:SetAttribute("KarkerkarKurkurEventRunning", false)
	clearEventStateAttribute()
	clearPlayerSeatedAttributes()

	for chair, conns in pairs(ChairConnections) do
		if conns then
			if conns.triggered and conns.triggered.Disconnect then pcall(conns.triggered.Disconnect, conns.triggered) end
			if conns.takenConn and conns.takenConn.Disconnect then pcall(conns.takenConn.Disconnect, conns.takenConn) end
		end
	end
	ChairConnections = {}

	if ChairsFolder and ChairsFolder.Parent then
		ChairsFolder:Destroy()
		ChairsFolder = nil
	end

	Chairs = {}
	MusicRunning = false
end

return KarkerkarKurkur
