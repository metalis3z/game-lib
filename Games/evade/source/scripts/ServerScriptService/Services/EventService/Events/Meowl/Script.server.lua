local Meowl = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/Meowl/Burst")
local Chase = Net:RemoteEvent("EventService/Meowl/Chase")

local isActive = false
local strikeTask = nil
local treeTask = nil
local recentlyTargeted = {}
local music = nil
local dayNightOriginalIds = {}
local spawnedTrees = {}

-------------------------------------------------
-- 🔇 Mute & Restore Day/Night Sounds
-------------------------------------------------

local function muteDayNight()
	for _, name in ipairs({"Day", "Night"}) do
		local soundsFolder = Workspace:FindFirstChild("Sounds")
		if not soundsFolder then continue end
		local sound = soundsFolder:FindFirstChild(name)
		if sound then
			dayNightOriginalIds[name] = sound.SoundId
			pcall(function() sound:Stop() end)
		end
	end
end

local function restoreDayNight()
	for name, id in pairs(dayNightOriginalIds) do
		local soundsFolder = Workspace:FindFirstChild("Sounds")
		if not soundsFolder then continue end
		local sound = soundsFolder:FindFirstChild(name)
		if sound then
			pcall(function() sound:Play() end)
		end
	end
	dayNightOriginalIds = {}
end

-------------------------------------------------
-- 🌳 Tree Spawning System
-------------------------------------------------

local function spawnTree(position)
	local treeTemplate = ReplicatedStorage:FindFirstChild("TreeModel")
	if not treeTemplate then return end

	local tree = treeTemplate:Clone()
	tree.Name = "MeowlTree"
	tree.Parent = Workspace
	tree:SetPrimaryPartCFrame(CFrame.new(position))
	CollectionService:AddTag(tree, "MeowlTree")

	-- Optional fade in effect
	if tree.PrimaryPart and tree.PrimaryPart:FindFirstChildOfClass("ParticleEmitter") then
		for _, p in ipairs(tree.PrimaryPart:GetChildren()) do
			if p:IsA("ParticleEmitter") then
				p.Enabled = true
				task.delay(3, function() p.Enabled = false end)
			end
		end
	end

	table.insert(spawnedTrees, tree)
	Debris:AddItem(tree, 60)
end

local function startTreeLoop()
	if treeTask then
		task.cancel(treeTask)
	end
	treeTask = task.spawn(function()
		while isActive do
			task.wait(math.random(8, 15))
			if not isActive then break end

			local randomPos = Vector3.new(
				math.random(-300, 300),
				0,
				math.random(-300, 300)
			)
			spawnTree(randomPos)
		end
	end)
end

local function cleanupTrees()
	for _, tree in ipairs(spawnedTrees) do
		if tree and tree.Destroy then
			pcall(function() tree:Destroy() end)
		end
	end
	spawnedTrees = {}
end

-------------------------------------------------
-- 🐈 Trait Handling
-------------------------------------------------

local function handle(sel)
	Burst.OnServerEvent:Connect(function(plr, v)
		local traitsJson = v:GetAttribute("Traits")
		local traits = {}

		if traitsJson then
			local success, decoded = pcall(function()
				return HttpService:JSONDecode(traitsJson)
			end)

			if success and type(decoded) == "table" then
				traits = decoded
			end
		end

		for _, trait in ipairs(traits) do
			if trait == "Meowl" then
				return 
			end
		end

		table.insert(traits, "Meowl")
		v:SetAttribute("Traits", HttpService:JSONEncode(traits))
	end)
end

-------------------------------------------------
-- 🎶 Main Event Logic
-------------------------------------------------

function Meowl.OnStart()
	if isActive then return end

	isActive = true
	ReplicatedStorage:SetAttribute("MeowlEvent", true)

	-- Mute ambient sounds & start music
	muteDayNight()
	music = Instance.new("Sound")
	music.Name = "MeowlSound"
	music.Volume = 0.25
	music.Looped = true
	music.Parent = Workspace
	pcall(function() music:Play() end)

	-- Start tree loop
	startTreeLoop()

	-- Main animal targeting loop
	if strikeTask then
		task.cancel(strikeTask)
	end

	strikeTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(150, 200) / 10
			task.wait(waitTime)

			if not isActive then break end

			local roadAnimals = CollectionService:GetTagged("Animal")
			local currentTime = workspace:GetServerTimeNow()

			-- Cleanup old entries
			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > 15 then
					recentlyTargeted[animalName] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasMeowlTrait = false

					local traitsJson = animal:GetAttribute("Traits")
					if traitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(traitsJson)
						end)

						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Meowl" then
									hasMeowlTrait = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasMeowlTrait then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()
				local travelTime = 2.5

				recentlyTargeted[selected.Name] = now

				-- Chase animation trigger
				Chase:FireAllClients(selected, travelTime)
				handle(selected)

				task.delay(travelTime, function()
					local traitsJson = selected:GetAttribute("Traits")
					local traits = {}

					if traitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(traitsJson)
						end)

						if success and type(decoded) == "table" then
							traits = decoded
						end
					end

					for _, trait in ipairs(traits) do
						if trait == "Meowl" then
							return 
						end
					end

					table.insert(traits, "Meowl")
					selected:SetAttribute("Traits", HttpService:JSONEncode(traits))
				end)
			end
		end
	end)
end

function Meowl.OnStop()
	if not isActive then return end

	isActive = false
	ReplicatedStorage:SetAttribute("MeowlEvent", false)

	if strikeTask then
		task.cancel(strikeTask)
		strikeTask = nil
	end

	if treeTask then
		task.cancel(treeTask)
		treeTask = nil
	end

	recentlyTargeted = {}

	-- Cleanup trees & sounds
	cleanupTrees()

	if music then
		pcall(function() music:Stop() end)
		pcall(function() music:Destroy() end)
		music = nil
	end

	restoreDayNight()
end

return Meowl
