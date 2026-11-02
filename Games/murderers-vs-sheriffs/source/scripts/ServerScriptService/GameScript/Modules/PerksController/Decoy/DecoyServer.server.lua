local Perk = script.Parent
local Activate = Perk:WaitForChild("Activate")
local Debris = game:GetService("Debris")

local function canPerformAction(humanoid)
	local lastUse = Perk:GetAttribute("LastUse") or 0
	local cooldown = Perk:GetAttribute("Cooldown") or 0
	local activeTime = Perk:GetAttribute("ActiveTime") or 0
	local charges = Perk:GetAttribute("Charges") or 0
	if charges <= 0 then return false end
	if (os.clock() - lastUse) < (cooldown + activeTime) then return false end

	--[[local allowedStates = {
		Enum.HumanoidStateType.Running,
		Enum.HumanoidStateType.RunningNoPhysics,
		Enum.HumanoidStateType.Landed,
		Enum.HumanoidStateType.Physics
	}

	local onGround = false
	for _, s in ipairs(allowedStates) do
		if humanoid:GetState() == s then
			onGround = true
			break
		end
	end
	if not onGround then return false end]]

	return true
end

local function handlePerkActivated()
	Perk:SetAttribute("LastUse", os.clock())
	if Perk:GetAttribute("Charges") then
		Perk:SetAttribute("Charges", Perk:GetAttribute("Charges") - 1)
	end
end
local CollectionService = game:GetService("CollectionService")
Activate.OnServerEvent:Connect(function(player)
	if not player.Character then return end
	local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	if not canPerformAction(humanoid) then return end
	handlePerkActivated()
	local WeaponAttacher = require(script:WaitForChild("WeaponAttacher"))

	local character = Perk.Parent
	if not character or not character:FindFirstChild("Humanoid") then
		character = player.Character or player.CharacterAdded:Wait()
	end
	if not character then return end

	for _, v in ipairs(player.Character.Humanoid:GetChildren()) do
		if v.Name == "Status" then
			v.Archivable = true
		end
	end
	character.Archivable = true

	local clone = character:Clone()

	for _, obj in ipairs(clone:GetDescendants()) do
		if obj:IsA("Weld") or obj:IsA("WeldConstraint") or obj:IsA("Motor6D") or obj:isA("Tool") then
			obj:Destroy()
		end
		if obj.Name == "KnifeDisplay" or obj.Name == "GunDisplay" or obj.Name == "DisplayName" or obj.Name == "Decoy" or obj.Name == "DisplayRefKnife" or obj.Name == "DisplayRefGun" or obj.Name == "CharacterClient" or obj.Name == "Gifter" or obj.Name == "Unfade" or obj.Name == "Health" then
			obj:Destroy()
		end
	end

	clone.Name = "PlayerClone"

	local humanoidClone = clone:FindFirstChildOfClass("Humanoid")
	if humanoidClone then
		humanoidClone.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		humanoidClone.AutoRotate = false
		humanoidClone.WalkSpeed = 0
		humanoidClone.JumpPower = 0
	end
	clone:AddTag("Decoy")
	clone.Parent = workspace
	WeaponAttacher.AttachItems(WeaponAttacher, player, clone)
	
	local PhysicsService = game:GetService("PhysicsService")

	local playersGroup = "Players"
	local decoyGroup = "Decoy"
	local aliveGroup = "AliveCharacters"

	pcall(function() PhysicsService:RegisterCollisionGroup(playersGroup) end)
	pcall(function() PhysicsService:RegisterCollisionGroup(decoyGroup) end)
	pcall(function() PhysicsService:RegisterCollisionGroup(aliveGroup) end)
	PhysicsService:CollisionGroupSetCollidable(playersGroup, playersGroup, true)
	PhysicsService:CollisionGroupSetCollidable(playersGroup, "Default", true)
	PhysicsService:CollisionGroupSetCollidable(decoyGroup, playersGroup, false)
	PhysicsService:CollisionGroupSetCollidable(decoyGroup, aliveGroup, false)
	PhysicsService:CollisionGroupSetCollidable(decoyGroup, "Default", true)
	PhysicsService:CollisionGroupSetCollidable(decoyGroup, decoyGroup, false)
	local function setCollisionGroup(model, groupName)
		for _, part in ipairs(model:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CollisionGroup = groupName
			end
		end
	end
	for _, plr in ipairs(game.Players:GetPlayers()) do
		if plr.Character then
			setCollisionGroup(plr.Character, playersGroup)
		end
	end
	local hrp = clone:FindFirstChild("HumanoidRootPart")
	local chrHRP = character:FindFirstChild("HumanoidRootPart")
	if hrp and chrHRP then
		hrp.CanCollide = false
		local forwardOffset = chrHRP.CFrame.LookVector * 1
		clone:SetPrimaryPartCFrame(chrHRP.CFrame + forwardOffset)
		if humanoidClone then
			humanoidClone.WalkSpeed = 0
			humanoidClone.JumpPower = 0
			humanoidClone.AutoRotate = false
			humanoidClone:ChangeState(Enum.HumanoidStateType.PlatformStanding)
		end
		setCollisionGroup(clone, decoyGroup)
	end
	local Animate = script.Animate:Clone()
	Animate.Parent = clone
	Animate.Enabled = true
	for _, v in ipairs(clone:GetDescendants()) do
		if v.Name ~= "Animate" then
			if v:IsA("Script") or v:IsA("LocalScript") then
				v:Destroy()
			end
		end
	end

	--[[local humanoid = clone:FindFirstChild("Humanoid")
	if humanoid and script:FindFirstChild("Animation") then
		local anim = script.Animation:Clone()
		humanoid:LoadAnimation(anim):Play()
	end]]
	

	Debris:AddItem(clone, 120)
end)

