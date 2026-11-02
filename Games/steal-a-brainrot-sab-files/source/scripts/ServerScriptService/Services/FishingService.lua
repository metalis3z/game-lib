

local FishingService = {}

local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService   = game:GetService("CollectionService")
local Players             = game:GetService("Players")
local RunService          = game:GetService("RunService")
local Workspace           = game:GetService("Workspace")

local Net           = require(ReplicatedStorage.Packages.Net)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local Animals       = require(ReplicatedStorage.Datas.Animals)
local Mutations     = require(ReplicatedStorage.Datas.Mutations)

local CastRemote          = Net:RemoteEvent("FishingRod.Cast")
local CancelRemote        = Net:RemoteEvent("FishingRod.Cancel")
local MinigameClickRemote = Net:RemoteEvent("FishingRod.MinigameClick")
local BiteGotRemote       = Net:RemoteEvent("FishingRod.BiteGot")
local RewardRemote        = Net:RemoteEvent("FishingRod.Reward")
local NotifyRemote        = Net:RemoteEvent("NotificationService/Notify")

local ROD_TAG          = "Tool_FishingRod"
local CATCH_STAND_FOR  = 1.5
local CAST_COOLDOWN    = 1.0
local CAST_DISTANCE    = 22
local SPAWN_BEHIND_DISTANCE = 4
local BITE_MIN         = 2.5
local BITE_MAX         = 6.5
local BITE_WINDOW      = 1.4
local MINIGAME_HP      = NumberRange.new(8, 12)
local MINIGAME_TIMEOUT = 12
local BOBBER_ARC_TIME  = 0.45

local FISHING_POOL = {
	{ Name = "Noobini Pizzanini",    Weight = 100 },
	{ Name = "Liril\u{ec} Laril\u{e0}", Weight = 80 },
	{ Name = "Tim Cheese",           Weight = 70 },
	{ Name = "Fluriflura",           Weight = 60 },
	{ Name = "Svinina Bombardino",   Weight = 50 },
	{ Name = "Trippi Troppi",        Weight = 34 },
	{ Name = "Gangster Footera",     Weight = 27 },
	{ Name = "Bandito Bobritto",     Weight = 20 },
	{ Name = "Boneca Ambalabu",      Weight = 16 },
	{ Name = "Tric Trac Baraboom",   Weight = 12 },
	{ Name = "Cappuccino Assassino", Weight = 9 },
	{ Name = "Brr Brr Patapim",      Weight = 6 },
	{ Name = "Trulimero Trulicina",  Weight = 4 },
	{ Name = "Bananita Dolphinita",  Weight = 2.5 },
	{ Name = "Burbaloni Loliloli",   Weight = 1.1 },
	{ Name = "Chimpanzini Bananini", Weight = 0.7 },
	{ Name = "Ballerina Cappuccina", Weight = 0.35 },
}

local RARITY_POWER = {
	Common = 0, Rare = 0.3, Epic = 0.5, Legendary = 1, Mythic = 1.3,
	["Brainrot God"] = 2, Secret = 3, OG = 7,
}

type Session = {
	player: Player,
	tool: Tool,
	state: string,
	token: {},
	bobber: Model?,
	catchPos: Vector3,
	hp: number,
	hits: number,
	conns: { RBXScriptConnection },
	ended: boolean?,
}

local Sessions: { [Player]: Session } = {}
local ForcedAnimal: string? = nil
local ForcedMutation: string? = nil
local ForcedTraits: { string }? = nil
local ResolvedPool: { { Name: string, Weight: number, Rarity: string } } = {}

local function buildPool()
	table.clear(ResolvedPool)
	for _, entry in FISHING_POOL do
		local data = Animals[entry.Name]
		if data then
			table.insert(ResolvedPool, {
				Name = entry.Name,
				Weight = entry.Weight,
				Rarity = data.Rarity or "Common",
			})
		else
			warn(("[FishingService] Fishing pool entry %q not in Animals data -- skipping"):format(entry.Name))
		end
	end
end

local function selectAnimalName(luck: number): string?
	if #ResolvedPool == 0 then return nil end
	luck = math.max(luck or 1, 1)
	local total = 0
	local weighted = {}
	for _, entry in ResolvedPool do
		local power = RARITY_POWER[entry.Rarity] or 0
		local w = entry.Weight * (luck ^ power)
		total += w
		table.insert(weighted, { Name = entry.Name, W = w })
	end
	if total <= 0 then return ResolvedPool[1].Name end
	local roll = math.random() * total
	local acc = 0
	for _, e in weighted do
		acc += e.W
		if roll <= acc then return e.Name end
	end
	return weighted[#weighted].Name
end

local function getRod(player: Player): Tool?
	local char = player.Character
	if not char then return nil end
	for _, t in char:GetChildren() do
		if t:IsA("Tool") and CollectionService:HasTag(t, ROD_TAG) then
			return t
		end
	end
	return nil
end

local function getRodLuck(tool: Tool): number
	local luck = tool:GetAttribute("Luck")
	if typeof(luck) == "number" then return luck end
	return 1
end

local function getCastOrigin(tool: Tool): Attachment?
	for _, d in tool:GetDescendants() do
		if d:IsA("Attachment") and d.Name == "CastOrigin" then
			return d
		end
	end
	local handle = tool:FindFirstChild("Handle")
	if handle and handle:IsA("BasePart") then
		local att = Instance.new("Attachment")
		att.Name = "CastOrigin"
		att.Parent = handle
		return att
	end
	return nil
end

local function computeCastTarget(hrp: BasePart): Vector3
	local ahead = hrp.Position + hrp.CFrame.LookVector * CAST_DISTANCE
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { hrp.Parent :: Instance }
	local hit = Workspace:Raycast(ahead + Vector3.new(0, 12, 0), Vector3.new(0, -60, 0), params)
	if hit then
		return hit.Position + Vector3.new(0, 0.3, 0)
	end
	return ahead - Vector3.new(0, 4, 0)
end

local function destroyBobber(session: Session)
	local bobber = session.bobber
	if bobber then
		if bobber.Parent then
			CollectionService:RemoveTag(bobber, "FishingBobber")
			bobber:Destroy()
		end
		session.bobber = nil
	end
end

local function spawnBobber(origin: Attachment, fromPos: Vector3, toPos: Vector3, session: Session)
	local token = session.token
	local model = Instance.new("Model")
	model.Name = "FishingBobber"

	local part = Instance.new("Part")
	part.Shape = Enum.PartType.Ball
	part.Size = Vector3.new(0.55, 0.55, 0.55)
	part.Color = Color3.fromRGB(225, 55, 45)
	part.Material = Enum.Material.SmoothPlastic
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Massless = true
	part.CFrame = CFrame.new(fromPos)
	part.Parent = model
	model.PrimaryPart = part

	local att1 = Instance.new("Attachment")
	att1.Name = "BobberAttachment"
	att1.Parent = part

	local rope = Instance.new("RopeConstraint")
	rope.Name = "RopeConstraint"
	rope.Enabled = false
	rope.Visible = false
	rope.Length = 500
	rope.Attachment0 = origin
	rope.Attachment1 = att1
	rope.Parent = model

	model.Parent = Workspace:FindFirstChild("Debris") or Workspace
	CollectionService:AddTag(model, "FishingBobber")
	session.bobber = model

	task.spawn(function()
		local t = 0
		while t < BOBBER_ARC_TIME do
			if session.token ~= token or not part.Parent then return end
			local dt = RunService.Heartbeat:Wait()
			t = math.min(BOBBER_ARC_TIME, t + dt)
			local a = t / BOBBER_ARC_TIME
			local pos = fromPos:Lerp(toPos, a) + Vector3.new(0, math.sin(a * math.pi) * 6, 0)
			part.CFrame = CFrame.new(pos)
		end
		if session.token == token and part.Parent then
			part.CFrame = CFrame.new(toPos)
		end
	end)
end

local function resetToolUI(tool: Tool)
	if not tool or not tool.Parent then return end
	tool:SetAttribute("casted", false)
	tool:SetAttribute("minigame", false)
	tool:SetAttribute("minigameHits", 0)
	tool:SetAttribute("minigameHP", 0)
	tool:SetAttribute("minigameTotalHits", 0)
end

local function endSession(session: Session, opts: { escaped: boolean?, cooldown: boolean? }?)
	if session.ended then return end
	session.ended = true
	opts = opts or {}
	if Sessions[session.player] == session then
		Sessions[session.player] = nil
	end
	session.token = {}
	for _, c in session.conns do c:Disconnect() end
	table.clear(session.conns)
	destroyBobber(session)
	resetToolUI(session.tool)
	local tool = session.tool
	if opts.cooldown and tool and tool.Parent then
		tool:SetAttribute("castCooldown", true)
		task.delay(CAST_COOLDOWN, function()
			if tool and tool.Parent then
				tool:SetAttribute("castCooldown", false)
			end
		end)
	end
	if opts.escaped then
		pcall(function()
			NotifyRemote:FireClient(session.player, "The fish got away!", 3)
		end)
	end
end

local function succeed(session: Session)
	local player, tool = session.player, session.tool
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local catchPos = session.catchPos or (hrp and (hrp :: BasePart).Position) or Vector3.zero

	local animalName: string?
	local mutation: string?
	local traits: { string }?
	if ForcedAnimal and Animals[ForcedAnimal] then
		animalName = ForcedAnimal
		mutation = ForcedMutation
		traits = ForcedTraits
		ForcedAnimal, ForcedMutation, ForcedTraits = nil, nil, nil
	else
		animalName = selectAnimalName(getRodLuck(tool))
		mutation = AnimalService:GetRandomMutation()
	end
	local animalData = animalName and Animals[animalName]

	endSession(session, { cooldown = true })

	if not animalData then
		warn("[FishingService] No animal to spawn for catch (empty pool?)")
		return
	end

	local customSpawn: { Start: BasePart }? = nil
	local spawnPoint: BasePart? = nil
	if hrp and hrp:IsA("BasePart") then
		local behindPos = hrp.Position
			- hrp.CFrame.LookVector * SPAWN_BEHIND_DISTANCE
			- Vector3.new(0, 3, 0)
		local part = Instance.new("Part")
		part.Name = "FishingSpawnPoint"
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.Transparency = 1
		part.Size = Vector3.one
		part.CFrame = CFrame.new(behindPos)
		part.Parent = Workspace:FindFirstChild("Debris") or Workspace
		spawnPoint = part
		customSpawn = { Start = part }
	end

	local animalId = AnimalService.spawnAnimalCustom(
		animalData,
		mutation,
		traits,
		nil,
		customSpawn,
		CATCH_STAND_FOR,
		true
	)

	if spawnPoint then
		task.delay(2, function()
			spawnPoint:Destroy()
		end)
	end

	RewardRemote:FireAllClients(player, tool, catchPos, nil, animalId, nil)
end

local function startMinigame(session: Session)
	session.state = "minigame"
	session.hits = 0
	session.hp = math.random(MINIGAME_HP.Min, MINIGAME_HP.Max)
	local tool = session.tool
	tool:SetAttribute("minigameHP", session.hp)
	tool:SetAttribute("minigameHits", 0)
	tool:SetAttribute("minigameTotalHits", 0)
	tool:SetAttribute("minigame", true)
	if session.bobber and session.bobber.Parent then
		session.bobber:SetAttribute("bite", false)
	end

	local token = session.token
	task.delay(MINIGAME_TIMEOUT, function()
		if Sessions[session.player] == session and session.token == token and session.state == "minigame" then
			endSession(session, { escaped = true, cooldown = true })
		end
	end)
end

local function onCast(player: Player, power: any)
	local tool = getRod(player)
	if not tool then return end
	if Sessions[player] then return end
	if tool:GetAttribute("castCooldown") then return end
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp or not hrp:IsA("BasePart") then return end

	local token = {}
	local targetPos = computeCastTarget(hrp)
	local session: Session = {
		player = player, tool = tool, state = "casting", token = token,
		bobber = nil, catchPos = targetPos, hp = 0, hits = 0, conns = {},
	}
	Sessions[player] = session

	tool:SetAttribute("casted", true)
	local origin = getCastOrigin(tool)
	if origin then
		spawnBobber(origin, origin.WorldPosition, targetPos, session)
	end

	table.insert(session.conns, tool.AncestryChanged:Connect(function()
		local c = player.Character
		if not c or tool.Parent ~= c then
			if Sessions[player] == session then
				endSession(session)
			end
		end
	end))

	local p = (typeof(power) == "number") and math.clamp(power, 0, 1) or 0
	local biteDelay = (BITE_MIN + (BITE_MAX - BITE_MIN) * math.random()) * (1 - 0.3 * p)
	task.delay(biteDelay, function()
		if Sessions[player] ~= session or session.token ~= token then return end
		if session.state ~= "casting" then return end
		session.state = "bite"
		if session.bobber and session.bobber.Parent then
			session.bobber:SetAttribute("bite", true)
		end
		BiteGotRemote:FireAllClients(player, tool)
		task.delay(BITE_WINDOW, function()
			if Sessions[player] == session and session.token == token and session.state == "bite" then
				endSession(session, { escaped = true, cooldown = true })
			end
		end)
	end)
end

local function onCancel(player: Player)
	local session = Sessions[player]
	if not session then return end
	if session.state == "casting" then
		endSession(session, { cooldown = true })
	elseif session.state == "bite" then
		startMinigame(session)
	end
end

local function onMinigameClick(player: Player)
	local session = Sessions[player]
	if not session or session.state ~= "minigame" then return end
	session.hits += 1
	local tool = session.tool
	tool:SetAttribute("minigameHits", session.hits)
	tool:SetAttribute("minigameTotalHits", (tool:GetAttribute("minigameTotalHits") or 0) + 1)
	if session.hits >= session.hp then
		succeed(session)
	end
end

function FishingService:SetForcedAnimal(animalName: string?, mutation: string?, traits: { string }?): boolean
	if animalName == nil then
		ForcedAnimal, ForcedMutation, ForcedTraits = nil, nil, nil
		return true
	end
	if not Animals[animalName] then
		warn(("[FishingService] SetForcedAnimal: unknown animal %q"):format(tostring(animalName)))
		return false
	end
	if mutation ~= nil and not Mutations[mutation] then
		warn(("[FishingService] SetForcedAnimal: unknown mutation %q"):format(tostring(mutation)))
		return false
	end
	if traits ~= nil and typeof(traits) ~= "table" then
		warn("[FishingService] SetForcedAnimal: traits must be a table of strings (or nil)")
		return false
	end
	ForcedAnimal = animalName
	ForcedMutation = mutation
	ForcedTraits = traits
	return true
end

function FishingService:GetForcedAnimal(): string?
	return ForcedAnimal
end

function FishingService:Start()
	task.spawn(buildPool)
	CastRemote.OnServerEvent:Connect(onCast)
	CancelRemote.OnServerEvent:Connect(onCancel)
	MinigameClickRemote.OnServerEvent:Connect(onMinigameClick)
	Players.PlayerRemoving:Connect(function(player)
		local session = Sessions[player]
		if session then endSession(session) end
	end)
end

return FishingService
