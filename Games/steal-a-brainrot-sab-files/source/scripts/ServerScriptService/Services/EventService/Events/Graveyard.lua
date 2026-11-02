local Graveyard = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local CandyService = require(ServerScriptService.Services.CandyService)
local AnimalService = require(ServerScriptService.Services.AnimalService)

local scriptName = script.Name
local BrainrotFolder = script:WaitForChild("BrainrotGravestones")
local ActiveGraves = {}
local isActive = false
local curseTask = nil
local recentlyCursed = {}

local DIG_CLICK_COOLDOWN = 1
local TOMB_COOLDOWN = 30

local ActiveDigs = {}
local TombCooldowns = {}
local digConnections = {}

local BurstEvent = Net:RemoteEvent(("EventService/%s/Burst"):format(scriptName))
local Notify = Net:RemoteEvent("NotificationService/Notify")
local DigStartEvent = Net:RemoteEvent(("EventService/%s/DigStart"):format(scriptName))
local DigEndEvent = Net:RemoteEvent(("EventService/%s/DigEnd"):format(scriptName))
local CollectVFXEvent = Net:RemoteEvent(("EventService/%s/DigCollectVFX"):format(scriptName))
local PlayAnimationEvent = Net:RemoteEvent(("EventService/%s/PlayGraveyardAnimation"):format(scriptName))
local ToolDisabled = Net:RemoteEvent(("EventService/%s/DigComplete"):format(scriptName))

local function giveShovel()
	for _, player in ipairs(Players:GetPlayers()) do
		local shovelTemplate = ReplicatedStorage:WaitForChild("Items"):FindFirstChild("Agarrini Shovel")
		if shovelTemplate then
			local clone = shovelTemplate:Clone()
			clone.Parent = player:FindFirstChild("Backpack") or player:WaitForChild("Backpack")

			Notify:FireClient(player, "You got a <font color='#e9944c'>Agarrini Shovel</font>!", 5, "Sounds.Sfx.Success")
		end
	end
end

local function removeShovel()
	for _, player in ipairs(Players:GetPlayers()) do
		local backpack = player:FindFirstChild("Backpack")
		if backpack then
			local shovel = backpack:FindFirstChild("Agarrini Shovel")
			if shovel then
				shovel:Destroy()
			end
		end

		local character = player.Character
		if character then
			local shovel = character:FindFirstChild("Agarrini Shovel")
			if shovel then
				shovel:Destroy()
			end
		end
	end
end

local function isOnCooldown(tombstone)
	local cooldown = TombCooldowns[tombstone]
	if not cooldown then return false end
	return tick() < cooldown
end

local function explodeShards(tombstone)
	local shardsFolder = tombstone:FindFirstChild("Shards")
	if not shardsFolder then return end

	for _, shard in ipairs(shardsFolder:GetChildren()) do
		if shard:IsA("BasePart") then
			shard.Anchored = false
			local bodyVelocity = Instance.new("BodyVelocity")
			bodyVelocity.Velocity = Vector3.new(
				math.random(-35,35),
				math.random(30,70),
				math.random(-35,35)
			)
			bodyVelocity.MaxForce = Vector3.new(1e5,1e5,1e5)
			bodyVelocity.Parent = shard
			Debris:AddItem(bodyVelocity, 1)

			task.delay(4, function()
				local tween = TweenService:Create(shard, TweenInfo.new(1), {Transparency = 1})
				tween:Play()
				tween.Completed:Connect(function()
					shard.Anchored = true
					task.wait(30)
					shard.Transparency = 0
					shard.CFrame = shard.CFrame
				end)
			end)
		end
	end
end

local function startCursingAnimals()
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("GraveyardEvent", true)

	if curseTask then
		task.cancel(curseTask)
	end

	curseTask = task.spawn(function()
		while isActive do
			task.wait(math.random(50, 100) / 10)

			if not isActive then break end

			local animals = CollectionService:GetTagged("Animal")
			local currentTime = workspace:GetServerTimeNow()

			for name, time in pairs(recentlyCursed) do
				if (currentTime - time) > 20 then
					recentlyCursed[name] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(animals) do
				if animal.PrimaryPart then
					local currentTraitsJson = animal:GetAttribute("Traits")
					local hasCurse = false

					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "RIP Gravestone" then
									hasCurse = true
									break
								end
							end
						end
					end

					if not hasCurse and not recentlyCursed[animal.Name] then
						table.insert(candidates, animal)
					end
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local now = workspace:GetServerTimeNow()
				recentlyCursed[selected.Name] = now

				BurstEvent:FireAllClients(selected.Name)

				task.delay(1, function()
					local traits = {}
					local traitsJson = selected:GetAttribute("Traits")

					if traitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(traitsJson)
						end)
						if success and type(decoded) == "table" then
							traits = decoded
						end
					end

					for _, trait in ipairs(traits) do
						if trait == "RIP Gravestone" then
							return
						end
					end

					table.insert(traits, "RIP Gravestone")
					selected:SetAttribute("Traits", HttpService:JSONEncode(traits))

				end)
			end
		end
	end)
end

local function stopCursingAnimals()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("GraveyardEvent", false)

	if curseTask then
		task.cancel(curseTask)
		curseTask = nil
	end

	recentlyCursed = {}
end

local function connectDigHandlers()
	table.insert(digConnections, ToolDisabled.OnServerEvent:Connect(function(player, eventId)
		DigEndEvent:FireClient(player)
	end))

	table.insert(digConnections, DigStartEvent.OnServerEvent:Connect(function(player, tombstone)
		if not tombstone or not tombstone.Parent then return end
		if isOnCooldown(tombstone) then return end

		local now = tick()
		local data = ActiveDigs[player]
		if data and now - data.lastClick < DIG_CLICK_COOLDOWN then return end

		local eventId = math.random(1000,9999)
		ActiveDigs[player] = {
			tombstone = tombstone,
			lastClick = now,
			eventId = eventId,
			startTime = now,
		}

		DigStartEvent:FireClient(player, eventId, 0.1)
	end))

	table.insert(digConnections, DigEndEvent.OnServerEvent:Connect(function(player, eventId)
		local data = ActiveDigs[player]
		if not data or data.eventId ~= eventId then return end

		local tombstone = data.tombstone
		if not tombstone then return end

		local now = tick()
		if now - data.lastClick < DIG_CLICK_COOLDOWN then return end
		ActiveDigs[player].lastClick = now

		DigEndEvent:FireClient(player)

		TombCooldowns[tombstone] = tick() + TOMB_COOLDOWN
		local skull = tombstone:FindFirstChild("AnimatedSkull")
		if skull and skull:FindFirstChild("AnimationController") and skull:FindFirstChild("Skull") then
			for _, desc in ipairs(skull.Skull:GetDescendants()) do
				if desc:IsA("ParticleEmitter") then
					desc.Enabled = true
				end
			end

			local animator = skull.AnimationController:FindFirstChildWhichIsA("Animator")
			if animator then
				local anim = Instance.new("Animation")
				anim.AnimationId = "rbxassetid://129231565853154"
				local track = animator:LoadAnimation(anim)
				track:Play()
				task.wait(1.2)
				explodeShards(tombstone)



				local part = tombstone:FindFirstChild("InnerDirt") or tombstone:FindFirstChildWhichIsA("BasePart")
				if part then
					CollectVFXEvent:FireClient(player, part.CFrame, "Candy")
				end

				for _, desc in ipairs(skull.Skull:GetDescendants()) do
					if desc:IsA("ParticleEmitter") then
						desc.Enabled = false
					end
				end
				local spawnData = {
					Start = tombstone:FindFirstChild("InnerDirt") or tombstone,
					Owner = player
				}

				local Animals = require(ReplicatedStorage.Datas.Animals)
				AnimalService.spawnAnimalCustom(
					Animals["Skull Skull Skull"],
					nil,
					nil,
					nil  ,
					spawnData,
					0,
					true,
					false
				)
				local candyOptions = {25, 50}
				local candy = candyOptions[math.random(1, #candyOptions)]
				CandyService:Add(player, candy)

				Notify:FireClient(player, ("You dug up <font color='#FFFF00'>+%d Candy Corns!</font>"):format(candy), 5)
				local sound = script.CandyCorn:Clone()
				sound.Parent = workspace
				sound:Play()
				task.wait(3)
				sound:Destroy()
			end
		end
		ActiveDigs[player] = nil
	end))

	table.insert(digConnections, Players.PlayerRemoving:Connect(function(player)
		ActiveDigs[player] = nil
	end))
end

local function disconnectDigHandlers()
	for _, conn in ipairs(digConnections) do
		if conn.Connected then
			conn:Disconnect()
		end
	end
	digConnections = {}
	ActiveDigs = {}
	TombCooldowns = {}
end

function Graveyard.OnStart()
	for _, grave in ipairs(BrainrotFolder:GetChildren()) do
		if grave:IsA("Model") then
			local clone = grave:Clone()
			clone.Parent = Workspace
			table.insert(ActiveGraves, clone)
		end
	end

	giveShovel()
	startCursingAnimals()

	connectDigHandlers()
end

function Graveyard.OnStop()
	for _, grave in ipairs(ActiveGraves) do
		if grave and grave.Parent then
			grave:Destroy()
		end
	end
	ActiveGraves = {}

	removeShovel()
	stopCursingAnimals()

	disconnectDigHandlers()
end

return Graveyard