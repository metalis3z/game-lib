--// we're just gonna put the abilities here for now for convenience

local serverAbilities = {}

local replicatedStorage = game:GetService("ReplicatedStorage")

local util = require(replicatedStorage.Modules.Util)
local sounds = require(replicatedStorage.Modules.Sounds)
local hitboxes = require(replicatedStorage.Modules.Hitboxes)
local statuses = require(replicatedStorage.Modules.Statuses)
local networking = require(replicatedStorage.Modules.Network)

local hitboxes = require(replicatedStorage.Modules.Hitboxes);
local ragdolls = require(replicatedStorage.Modules.Ragdolls);

local actors = require(replicatedStorage.Modules.Actors);

local function handleDestruction(wall: Model, config)
	local closestKillers = util:GetClosestPlayerFromPosition(wall:GetPivot().Position, {
		["PlayerSelection"] = "Killers",
		["MaxDistance"] = 15,
		["ReturnTable"] = true
	})
	for _, killer in closestKillers do
		for name, parameters in config.BreakDebuffs do
			statuses:ApplyStatus(killer.Player, name, parameters)
		end
	end
	sounds:Play(config.Sounds.WallBreak, {
		Parent = wall.PrimaryPart,
		Volume = 1
	})

	local parts = {}

	for _, part in wall:GetChildren() do
		if part.Name == "Part" then
			table.insert(parts, part)
		end
	end

	wall.HB.CanCollide = false

	local rng = Random.new()
	local i = 0
	for _, part in parts do
		i += 1

		local endGoal = part.Position + Vector3.new(rng:NextNumber(-2, 2), 2, rng:NextNumber(-2, 2))

		local quadOut = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
		local quadIn = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)

		local tween = game:GetService("TweenService"):Create(part, quadIn, {Position = endGoal, Size = Vector3.zero, Orientation = Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))})
		tween:Play()
		task.wait(0.15 / i)
	end

	game.Debris:AddItem(wall, 5)
end

local function spawnAWall(cFrame: CFrame, owner) --// owner should be the actor
	local janeWal = script.Wall:Clone()
	local parts = {}

	local colors = {
		{
			BrickColor.new("Gold"),
			BrickColor.new("Cashmere"),
			BrickColor.new("Daisy orange"),
			BrickColor.new("Cool yellow"),
			BrickColor.new("Tr. Flu. Green"),
			BrickColor.new("Light yellow"),
			BrickColor.new("Burlap"),
			BrickColor.new("Neon green"),
		}
	}

	for _, part in janeWal:GetChildren() do
		if part.Name == "Part" then
			table.insert(parts, part)
			local randomIndex = math.random(1, #colors)
			part.BrickColor = colors[randomIndex][math.random(1, #colors[randomIndex])]
		end

		if part:IsA("BasePart") then
			part.CollisionGroup = "Survivors"
		end
	end

	local wallConfig = owner.Config.WallConfig

	janeWal.Parent = workspace.Map.Ingame
	janeWal:PivotTo(cFrame)
	janeWal:SetAttribute("OwnerName", owner.Player.Name)
	janeWal:SetAttribute("ExecutionsDisabled", true)
	janeWal:SetAttribute("HitboxPriority", 2)
	janeWal:SetAttribute("Team", "Survivors")
	janeWal.Humanoid.MaxHealth = wallConfig.BuildHealth
	janeWal.Humanoid.Health = wallConfig.BuildHealth

	janeWal:SetAttribute("Invincible", true)
	sounds:Play(owner.Config.Sounds.BuildWall, {
		Parent = janeWal.PrimaryPart,
		Volume = 1
	})

	for _, part in parts do
		part.Transparency = 1
		for _, surface: SurfaceGui in part:GetChildren() do
			surface.Enabled = false
		end

	end

	local rng = Random.new()
	for _, part in parts do
		task.wait(0.005)
		part.Transparency = 0
		for _, surface: SurfaceGui in part:GetChildren() do
			surface.Enabled = true
		end
		local startingPosition = part.Position + Vector3.new(rng:NextNumber(-0.5, 0.5), 2, rng:NextNumber(-0.5, 0.5))
		local endGoal = part.Position - Vector3.new(rng:NextNumber(-0.5, 0.5), 1, rng:NextNumber(-0.5, 0.5))
		local actualGoal = part.Position

		local quadOut = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
		local quadIn = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)

		part.Position = startingPosition
		local tween = game:GetService("TweenService"):Create(part, quadIn, {Position = endGoal})
		tween:Play()
		task.delay(0.25, function()
			local tween2 = game:GetService("TweenService"):Create(part, quadOut, {Position = actualGoal})
			tween2:Play()
		end)
	end
	janeWal:SetAttribute("Invincible", nil)

	local janeWallHumanoid = janeWal.Humanoid
	janeWallHumanoid.Died:Once(function()
		handleDestruction(janeWal, owner.Config)
	end)
	owner.Rig.Destroying:Once(function()
		if janeWallHumanoid.Health > 0 then
			janeWallHumanoid.Health = 0
		end
	end)

	task.delay(wallConfig.BuildLifetime, function()
		if janeWallHumanoid.Health > 0 then
			janeWallHumanoid.Health = 0
		end
	end)

	owner.Rig.Humanoid.Died:Once(function()
		if janeWallHumanoid.Health > 0 then
			janeWallHumanoid.Health = 0
		end
	end)
end

function serverAbilities:UseAbility(name, ...)
	local args = {...}
	local actor = args[1]

	local config, rig = actor.Config, actor.Rig
	if name == "Wall" then
		--// handle wall coding

		--// add resistance 2 for 2 seconds to the player
		--// check if player is maybe 7 studs away from another wall?

		--// create a melee hitbox and stun killers within that hitbox

		actor.AbilitiesDisabled = true

		rig.Trowel.Transparency = 0

		local wallConfig = config.WallConfig
		local offset = rig:GetPivot() * wallConfig.BuildOffset

		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = {workspace.Players}

		local function getClosestWall()
			local closestWall, closestDistance = nil, math.huge
			for _, model in workspace.Map.Ingame:GetChildren() do
				if model.Name == "Wall" and model:GetAttribute("OwnerName") == actor.Player.Name then
					local distance = (model:GetPivot().Position - offset.Position).Magnitude
					if distance < closestDistance then
						closestWall = model
						closestDistance = distance
					end
				end
			end

			return closestWall, closestDistance
		end

		local closestWall, closestDistance = getClosestWall()
		if closestWall and closestDistance < 7 then
			actor.AbilitiesDisabled = false
			return {Cancelled = true, Reason = "Cannot build a wall any closer than 7 studs to another wall."}
		end

		local forwardsRaycast = workspace:Raycast(rig:GetPivot().Position, rig:GetPivot().LookVector * -wallConfig.BuildOffset.Z, raycastParams)
		if forwardsRaycast then
			local distanceToWall = (forwardsRaycast.Position - rig:GetPivot().Position).Magnitude;
			offset = rig:GetPivot() * CFrame.new(0, 0, -math.max(distanceToWall - 1, 0))
			actor.AbilitiesDisabled = false
			return {Cancelled = true, Reason = "Building area is obstructed by something. Build somewhere else."}
		end

		local raycastResult = workspace:Raycast(offset.Position, Vector3.new(0, -100, 0), raycastParams)
		if not raycastResult then
			actor.AbilitiesDisabled = false
			return {Cancelled = true}
		end

		local position = raycastResult.Position	
		local cFrame = CFrame.new(position, position + rig:GetPivot().LookVector * 100)

		statuses:ApplyStatus(rig, "Resistance", {
			Level = 2,
			Duration = 2,
		})
		sounds:Play(config.Sounds.Trowel, {
			Parent = rig.PrimaryPart,
			Volume = 1
		})

		task.delay(wallConfig.BuildDelay, function()
			local stunned = false

			hitboxes:CreateHitbox(actor.Player, {
				Size = Vector3.new(5, 5, 5.5), 
				CFrameOffset = CFrame.new(0, 0, -2.75), 
				Damage = wallConfig.CatchDamage, 
				Time = wallConfig.CatchTime, 
				Knockback = 2, 
				HitMultiple = true, 
				Connections = {
					Hit = function(victim, firstHit)
						if not stunned then
							stunned = true
							actor:SetCooldownOf("Wall", wallConfig.CatchCooldown)
						end

						statuses:ApplyStatus(victim, "Stunned", {
							["Duration"] = wallConfig.CatchStuntime
						})

						if tostring(victim.Parent) == "Killers" then
							actors:IncrementActorStats(actor.Player, {
								["Action"] = "Stunned Killer as Jane Doe using a trowel",
								["RewardType"] = "Offensive"
							})
						end

						if firstHit then
							sounds:Play(config.Sounds.CatchHit, {
								Parent = rig.PrimaryPart,
								Volume = 1
							})
						end
					end
				}
			})
			task.wait(wallConfig.BuildTime)

			if not stunned then
				sounds:Play(config.Sounds.WallFinished, {
					Parent = rig.PrimaryPart,
					Volume = 1
				})
				spawnAWall(cFrame, actor)
			end
		end)

		task.delay(config.WallConfig.AbilityLength, function()
			rig.Trowel.Transparency = 1
			actor.AbilitiesDisabled = false
		end)
	elseif name == "Book" then
		--// handle book coding

		--// check for injured survivors nearby
		--// if not, cancel the ability

		--// otherwise, look for the nearest injured survivor and prioritize based on health
		--// if there is a survivor, create a beam from jane to the survivor for vfx
		--// wait 2.7 seconds, make sure the healing is successful, then heal the survivror by 40% hp
		--// if the healing fails apply debuffs to jane

		--// slowness 1, weakness 1 for 3-4 seconds

		--// "Usable only when a survivor is damaged and within 7.5 studs of Jane Doe"
		--// "Health takes priority over distance"

		--// when the ability is finished leave a book prop on the floor and make it disappear after 2 seconds

		actor.AbilitiesDisabled = true

		local function radiusVisual(radius)
			local spellbookRadiusColr = Color3.fromRGB(70, 155, 255)

			local radiusVisual = Instance.new("Part")
			radiusVisual.CanCollide = false
			radiusVisual.Anchored = true
			radiusVisual.Transparency = 1
			radiusVisual.Position = Vector3.new(0, -100, 0)
			radiusVisual.Orientation = Vector3.new(0, 0, 90)
			radiusVisual.Size = Vector3.new(0.25, radius, radius)
			radiusVisual.Material = Enum.Material.Glass
			radiusVisual.Shape = Enum.PartType.Cylinder
			radiusVisual.Parent = workspace.Map.Ingame

			local highlightVisual = Instance.new("Highlight")
			highlightVisual.DepthMode = Enum.HighlightDepthMode.Occluded
			highlightVisual.FillTransparency = 0.875
			highlightVisual.OutlineTransparency = 0.6
			highlightVisual.FillColor = spellbookRadiusColr
			highlightVisual.Parent = radiusVisual
			return radiusVisual
		end

		local function showSpellbook(transparency: number)
			local spellBook = actor.Rig:FindFirstChild("Spellbook")
			if not spellBook then return end
			for _, part in spellBook:GetDescendants() do
				if part:IsA("BasePart") then
					part.Transparency = transparency
				end
			end
		end


		local lowHP = {}
		local closestSurvivors = util:GetClosestPlayerFromPosition(rig:GetPivot().Position, {
			["PlayerSelection"] = "Survivors",
			["MaxDistance"] = config.BookConfig.Radius,
			["ReturnTable"] = true
		})
		for _, survivor in closestSurvivors do
			local character = survivor.Player
			if character ~= rig then
				local humanoid = character and character:FindFirstChild("Humanoid")
				if humanoid and humanoid.Health < humanoid.MaxHealth then
					table.insert(lowHP, character)
				end
			end
		end

		if #lowHP <= 0 then
			actor.AbilitiesDisabled = false
			return {Cancelled = true, Reason = "No injured survivors are nearby."}
		end

		table.sort(lowHP, function(a, b)
			local aHealth = a:FindFirstChild("Humanoid").Health
			local bHealth = b:FindFirstChild("Humanoid").Health
			return aHealth < bHealth
		end)

		showSpellbook(0)

		local lowestSurvivor = lowHP[1]
		local rootPart = lowestSurvivor:FindFirstChild("HumanoidRootPart")
		local rootAttachment = rootPart and (rootPart:FindFirstChild("RootAttachment") or Instance.new("Attachment", rootPart))
		rootAttachment.Name = "RootAttachment"

		local BookPE = script.BookPE
		local particles = {}
		for _, PE in BookPE:GetChildren() do
			local clone = PE:Clone()
			clone.Parent = rootAttachment
			clone.Enabled = true
			if PE:IsA("Beam") then
				clone.Attachment0 = rootAttachment
				clone.Attachment1 = rig.HumanoidRootPart:FindFirstChild("RootAttachment")
			end
			table.insert(particles, clone)
		end

		local success = true
		local victimHumanoid: Humanoid = lowestSurvivor:FindFirstChild("Humanoid")

		local visual = radiusVisual(config.BookConfig.Radius * 2)
		visual.Position = rig:GetPivot().Position + Vector3.new(0, -2.45, 0)
		local heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
			visual.Position = rig:GetPivot().Position + Vector3.new(0, -2.45, 0)
		end)

		local diedConnection = victimHumanoid.Died:Once(function()
			if not success then
				success = false
			end
		end)
		local altDiedConnection = rig.Humanoid.Died:Once(function()
			if not success then
				success = false
			end
		end)
		local oldHp = victimHumanoid.Health
		local damageConnection = victimHumanoid.HealthChanged:Connect(function(newHP: number)
			if not success then
				local difference = oldHp - newHP
				if difference > 0 then
					success = false
				end
			end
		end)
		local altDamageConnection = rig.Humanoid.HealthChanged:Connect(function(newHP: number)
			if not success then
				local difference = oldHp - newHP
				if difference > 0 then
					success = false
				end
			end
		end)
		sounds:Play(config.Sounds.ReadBook, {
			Parent = rig.PrimaryPart,
			Volume = 1
		})

		task.delay(config.BookConfig.AbilityLength, function()
			diedConnection:Disconnect()
			altDiedConnection:Disconnect()
			damageConnection:Disconnect()
			altDamageConnection:Disconnect()
			heartbeat:Disconnect()
			visual:Destroy()

			for _, particle in particles do
				particle.Enabled = false
				game.Debris:AddItem(particle, particle:IsA("ParticleEmitter") and particle.Lifetime.Max or 0.5)
			end

			if success then
				util:Heal(victimHumanoid, victimHumanoid.MaxHealth * (config.BookConfig.HealingPerc / 100))
				for _, name in config.BookConfig.HealedBuffs do
					statuses:ApplyStatus(rig, name, {
						Level = config.BookConfig.StatusLevel,
						Duration = config.BookConfig.StatusTime
					})
				end
				sounds:Play(config.Sounds.Healed, {
					Parent = rig.PrimaryPart,
					Volume = 1
				})
			else
				for _, name in config.BookConfig.FailedDebuffs do
					statuses:ApplyStatus(rig, name, {
						Level = config.BookConfig.StatusLevel,
						Duration = config.BookConfig.StatusTime
					})
				end
			end
		end)

		task.delay(config.BookConfig.AbilityLength, function()
			actor.AbilitiesDisabled = false
			local spellbookModel = actor.Rig:FindFirstChild("Spellbook")
			if spellbookModel then
				local clone = spellbookModel:Clone()
				clone.Parent = workspace.Map.Ingame

				for _, descendant in clone:GetDescendants() do
					if descendant:IsA("BasePart") then
						descendant.CanCollide = true
						descendant.CollisionGroup = "Survivors"
					end
				end

				clone.Motor:Destroy()

				game.Debris:AddItem(clone, 2)
			end

			showSpellbook(1)
		end)
	elseif name == "Scan" then
		--// handle scan coding

		--// add blindness 2 for 2 seconds to the player
		--// do literally nothing else because all of this ability is on the client

		actor.AbilitiesDisabled = true

		statuses:ApplyStatus(rig, "Blindness", {
			Level = 2,
			Duration = config.ScanLength
		})
		sounds:Play(config.Sounds.Scan, {
			Parent = rig.PrimaryPart,
			Volume = 1
		})

		task.delay(config.ScanLength, function()
			actor.AbilitiesDisabled = false
		end)
	end
end

return serverAbilities