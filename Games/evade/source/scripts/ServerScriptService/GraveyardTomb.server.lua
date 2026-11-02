-- made by scooterongame took me 3 hours homeie

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local CandyService = require(ServerScriptService.Services.CandyService)

local scriptName = "Graveyard"
local DigStartEvent = Net:RemoteEvent(("EventService/%s/DigStart"):format(scriptName))
local DigEndEvent = Net:RemoteEvent(("EventService/%s/DigEnd"):format(scriptName))
local CollectVFXEvent = Net:RemoteEvent(("EventService/%s/DigCollectVFX"):format(scriptName))
local PlayAnimationEvent = Net:RemoteEvent(("EventService/%s/PlayGraveyardAnimation"):format(scriptName))
local NotifyEvent = Net:RemoteEvent("NotificationService/Notify")
local ToolDisabled = Net:RemoteEvent(("EventService/%s/DigComplete"):format(scriptName))

local DIG_CLICK_COOLDOWN = 1
local TOMB_COOLDOWN = 30

local ActiveDigs = {}
local TombCooldowns = {}

--cooldown
local function isOnCooldown(tombstone)
	local cooldown = TombCooldowns[tombstone]
	if not cooldown then return false end
	return tick() < cooldown
end



-- make explode shards
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

			-- Tween transparency after 4 seconds
			task.delay(4, function()
				local tween = TweenService:Create(shard, TweenInfo.new(1), {Transparency = 1})
				tween:Play()
				tween.Completed:Connect(function()
					shard.Anchored = true
					wait(30)
					shard.Transparency = 0 -- reset for next dig
					shard.CFrame = shard.CFrame
				end)
			end)
		end
	end
end

-- remove gui if player remove tool or event end
ToolDisabled.OnServerEvent:Connect(function(player, eventId)
	DigEndEvent:FireClient(player)
end)


-- Start digging
DigStartEvent.OnServerEvent:Connect(function(player, tombstone)
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
end)

-- Finish digging
DigEndEvent.OnServerEvent:Connect(function(player, eventId)
	local data = ActiveDigs[player]
	if not data or data.eventId ~= eventId then return end

	local tombstone = data.tombstone
	if not tombstone then return end

	local now = tick()
	if now - data.lastClick < DIG_CLICK_COOLDOWN then return end
	ActiveDigs[player].lastClick = now

	DigEndEvent:FireClient(player)

	TombCooldowns[tombstone] = tick() + TOMB_COOLDOWN
	
	
	
	
	
	
	--  skull animation 
	local skull = tombstone:FindFirstChild("AnimatedSkull")
	if skull and skull:FindFirstChild("AnimationController") and skull:FindFirstChild("Skull") then
		-- Enable all ParticleEmitters inside skull.Skull
		for _, desc in ipairs(skull.Skull:GetDescendants()) do
			if desc:IsA("ParticleEmitter") then
				desc.Enabled = true
			end
		end

		-- Play animation
		local animator = skull.AnimationController:FindFirstChildWhichIsA("Animator")
		if animator then
			local anim = Instance.new("Animation")
			anim.AnimationId = "rbxassetid://117358536222097"
			local track = animator:LoadAnimation(anim)
			track:Play()
			wait(1.2)
			explodeShards(tombstone)

				
				
				-- Spawn VFX
				local part = tombstone:FindFirstChild("InnerDirt") or tombstone:FindFirstChildWhichIsA("BasePart")
				if part then
					CollectVFXEvent:FireClient(player, part.CFrame, "Candy")
				end

				-- Disable all ParticleEmitters in skull.Skull
				for _, desc in ipairs(skull.Skull:GetDescendants()) do
					if desc:IsA("ParticleEmitter") then
						desc.Enabled = false
					end
				end				
				
				-- Give candy reward: either 25 or 50
				local candyOptions = {25, 50}
				local candy = candyOptions[math.random(1, #candyOptions)]
				CandyService:Add(player, candy)

				-- Notify player
				NotifyEvent:FireClient(player, ("You dug up <font color='#FFFF00'>+%d Candy Corns!</font>"):format(candy), 5)
				local sound = script.CandyCorn:Clone()
				sound.Parent = workspace
				sound:Play()
				task.wait(3)
				sound:Destroy()
				
				
				
		end
	end
	



	ActiveDigs[player] = nil
end)

Players.PlayerRemoving:Connect(function(player)
	ActiveDigs[player] = nil
end)
