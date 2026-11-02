local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local Tool = script.Parent
Tool:SetAttribute("ThrowSpeed", 0.6)
Tool.Equipped:Connect(function()
	local character = Tool.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	if not player then return end

	local throwSpeed = 0.6
	if player:GetAttribute("EquippedPerk") == "Sleight" then
		throwSpeed = 0.7
	end

	Tool:SetAttribute("ThrowSpeed", throwSpeed)
end)
--Tool.Unequipped:Connect(function()
--	if Tool.Handle:FindFirstChild("DualKnife") then
--		Tool.Handle.DualKnife:Destroy()
--	end
--end)
FetchRayIgnoreList = function(_)
	local v1;
	v1 = function(v2, v3, v4)
		if game.Players:GetPlayerFromCharacter(v2.Parent) then
			return;
		end;
		if v2:IsA("BasePart") then
			if (v2.CanCollide == false and v2.Transparency == 1) or v4 then
				table.insert(v3, v2)
				for _, v5 in pairs(v2:GetChildren()) do
					v1(v5, v3, v4);
				end;
			end;
		elseif v2:IsA("Model") or v2:IsA("Accoutrement") or v2:IsA("Tool") then
			if v2:FindFirstChild("Humanoid") then
				for _, v6 in pairs(v2:GetChildren()) do
					if v6:IsA("Accoutrement") or v6:IsA("Tool") then
						v1(v6, v3, true);
					end;
				end;
			else
				for _, v7 in pairs(v2:GetChildren()) do
					v1(v7, v3, v4);
				end;
			end;
		elseif v2:IsA("BasePart") and v2.CollisionGroup == "PlayerNoCollision" then
			table.insert(v3, v2);
			for _, v8 in pairs(v2:GetChildren()) do
				v1(v8, v3, v4);
			end;
		end;
	end;
	local v8 = {};
	v1(workspace, v8);
	return v8;
end

script.Kill.Parent = script.Parent.Handle
local Handle = script.Parent:WaitForChild("Handle")
local THROW_SPEED = 96
Handle.CollisionGroup = "PlayerNoCollision"
if Handle:FindFirstChild("DualKnife") then
	Handle.DualKnife.CollisionGroup = "PlayerNoCollision"
end
local function GetPlayerFromCharacter(Character)
	local CurrentInstance = Character
	local Player = game.Players:GetPlayerFromCharacter(CurrentInstance)

	while not Player do
		if CurrentInstance.Parent then
			CurrentInstance = CurrentInstance.Parent
			Player = game.Players:GetPlayerFromCharacter(CurrentInstance)
		else
			return nil
		end
	end

	return CurrentInstance, Player
end
local Player = GetPlayerFromCharacter(script.Parent.Parent)
if not Player or not Player.Name then
	for _, p in pairs(game.Players:GetPlayers()) do
		if p.Backpack:FindFirstChild(script.Parent.Name) == script.Parent then
			Player = p
			break
		end
	end
end
local ToolParent = script.Parent.Parent
local Tool = script.Parent
local Player = nil
repeat
	Player = game.Players:GetPlayerFromCharacter(Tool.Parent)
	if not Player then
		for _, p in pairs(game.Players:GetPlayers()) do
			if p.Backpack:FindFirstChild(Tool.Name) == Tool then
				Player = p
				break
			end
		end
	end
	task.wait(0.1)
until Player or not Tool.Parent
if not Player then
	warn("[KnifeServer] Failed to find player.")
	return
end
local DataModule = require(game.ServerScriptService.GameScript.DataModule)
local DataTable = DataModule.GetDataTable()
local KnifeEquippedPerk = DataTable[Player.Name]["Perks"]["Equipped"][1]
Tool:SetAttribute("EquippedPerk", KnifeEquippedPerk)

local function FindHumanoid(Instance)
	while true do
		local Humanoid = Instance:FindFirstChild("Humanoid")
		if Humanoid then
			if Humanoid:IsA("Humanoid") then
				return Humanoid
			else
				for _, Child in pairs(Instance:GetChildren()) do
					if Child.Name == "Humanoid" and Child:IsA("Humanoid") then
						return Child
					end
				end
			end
		end
		if Instance.Parent and Instance:IsDescendantOf(workspace) then
			Instance = Instance.Parent
		else
			return nil
		end
	end
end

local CurrentHandle = script.Parent:WaitForChild("Handle")
local IgnoreList = FetchRayIgnoreList()

local BAN_HAMMER_ITEM_ID = "BanHammer"
local BAN_HAMMER_KICK_MESSAGE = "You were hit by the Ban Hammer."

local function isBanHammerEquipped()
	return Tool:GetAttribute("IsBanHammer") == true
		or Tool:GetAttribute("ItemID") == BAN_HAMMER_ITEM_ID
		or Tool:GetAttribute("OriginalItemID") == BAN_HAMMER_ITEM_ID
end

local function triggerBanHammerKick(targetPlayer)
	if not isBanHammerEquipped() or not targetPlayer or targetPlayer.Parent ~= Players then
		return
	end

	local banSound = CurrentHandle:FindFirstChild("Ban")
	if banSound and banSound:IsA("Sound") then
		banSound:Play()
	end

	task.delay(0.2, function()
		if targetPlayer.Parent == Players then
			targetPlayer:Kick(BAN_HAMMER_KICK_MESSAGE)
		end
	end)
end

local function ThrowKnife(Player, TargetCFrame)
	local ThrowingKnifeModel = game.ServerStorage.ThrowingKnife:Clone()
	local BladePosition = ThrowingKnifeModel.BladePosition
	ThrowingKnifeModel.HandleLink.Value = CurrentHandle
	local VisualClone = CurrentHandle:Clone()
	task.wait(0.05)
	VisualClone.Parent = ThrowingKnifeModel
	VisualClone.Transparency = 1
	VisualClone.Name = "KnifeVisual"
	BladePosition.CFrame = CFrame.new(CurrentHandle.Position, TargetCFrame.p)
	BladePosition.Velocity = Vector3.new()
	BladePosition.RotVelocity = Vector3.new()
	local Direction = (TargetCFrame.p - BladePosition.Position).Unit
	ThrowingKnifeModel:SetAttribute("Direction", Direction)
	ThrowingKnifeModel.ThrowingDirection.Value = Direction
	ThrowingKnifeModel:SetAttribute("ThrowSpeed", THROW_SPEED)
	ThrowingKnifeModel:AddTag("ThrowingKnife")
	ThrowingKnifeModel.Parent = game.Workspace
	table.insert(IgnoreList, Player.Character)
	for _, WeaponDisplay in pairs(game:GetService("CollectionService"):GetTagged("WeaponDisplay")) do
		table.insert(IgnoreList, WeaponDisplay)
	end

	local CurrentPosition = CurrentHandle.Position
	local HasNotHit = true
	local Connection = nil
	local RaycastParams = RaycastParams.new()
	RaycastParams.FilterDescendantsInstances = IgnoreList
	RaycastParams.FilterType = Enum.RaycastFilterType.Exclude

	Connection = game["Run Service"].PreSimulation:Connect(function(DeltaTime)
		local StepDistance = THROW_SPEED * DeltaTime
		local NextPosition = CurrentPosition + (ThrowingKnifeModel.ThrowingDirection.Value * StepDistance)

		local Result = workspace:Raycast(CurrentPosition, (NextPosition - CurrentPosition), RaycastParams)
		local CollectionService = game:GetService("CollectionService")

		if Result ~= nil then
			Connection:Disconnect()
			Connection = nil
			HasNotHit = false

			local StuckKnifeVisual = ThrowingKnifeModel.KnifeVisual:Clone()
			StuckKnifeVisual.Transparency = 0
			StuckKnifeVisual.CFrame = CFrame.new(Result.Position, Result.Position + ThrowingKnifeModel.ThrowingDirection.Value) * CFrame.Angles(math.rad(-120),0,0)
			ThrowingKnifeModel.Parent = nil
			StuckKnifeVisual.Parent = Result.Instance

			local HitCharacter, HitPlayer = GetPlayerFromCharacter(Result.Instance)
			local IsPlayer = false
			local IsAlive = false
			local HitHumanoid = nil
			if HitCharacter then
				HitHumanoid = FindHumanoid(HitCharacter)
				if HitHumanoid then
					if HitHumanoid.Health > 0 then
						IsAlive = true
					end
					IsPlayer = true
				end
			end
			if Result.Instance:FindFirstChild("ThrowHit") then
				Result.Instance.ThrowHit:Fire()
				table.insert(IgnoreList, Result.Instance)
			end
			local Decoy = Result.Instance:FindFirstAncestorOfClass("Model")
			if Decoy and CollectionService:HasTag(Decoy, "Decoy") then
				local FreezeEffect = require(game.ServerScriptService.GameScript.Modules.PerksController.Decoy.DecoyServer.HoloDeath)
				FreezeEffect(Decoy)
			end
			if IsPlayer then
				game.ReplicatedStorage.Remotes.Gameplay.KnifeKill:Fire(Player,HitPlayer,HitHumanoid,"Throwing")
				triggerBanHammerKick(HitPlayer)
				StuckKnifeVisual.Anchored = false
			else
				StuckKnifeVisual.Name = "StuckKnife"
				StuckKnifeVisual.Parent = workspace
				StuckKnifeVisual.Anchored = true
			end
			if not IsAlive then
				local Weld = Instance.new("WeldConstraint")
				Weld.Part1 = Result.Instance
				Weld.Part0 = StuckKnifeVisual
				game:GetService("Debris"):AddItem(StuckKnifeVisual, 6)
			end
			for _, Child in pairs(StuckKnifeVisual:GetChildren()) do
				if Child:IsA("ParticleEmitter") then
					Child.Enabled = true
				end
				if Child:IsA("Decal") then
					Child.Transparency = 0
				end
			end
			ThrowingKnifeModel:Destroy()
		end

		if HasNotHit then
			CurrentPosition = NextPosition
		end
	end)
end

script.Parent.ChildAdded:connect(function(Child)
	if Child.Name == "Dual"  then
		repeat task.wait()
			Child:Destroy()
		until Child == nil
	end
end)

local CanThrow = true
script.Parent.Events.KnifeThrown.OnServerEvent:connect(function(Player, OriginCFrame, TargetCFrame)
	if CanThrow then
		CanThrow = false
		task.wait()
		CurrentHandle.Transparency = 1
		for _, Child in pairs(CurrentHandle:GetChildren()) do
			if Child.Name ~= "DualKnife" then
			if Child:IsA("ParticleEmitter") then
				Child.Enabled = false
			end
			if Child:IsA("BasePart") or Child:IsA("Decal") then
				Child.Transparency = 1
			end
			end
		end
		
		if TargetCFrame and Player and Player.Character.Humanoid.Health > 0 then
			ThrowKnife(Player, TargetCFrame)
		end
		task.wait(script.Parent:GetAttribute("EquippedPerk") == "Sleight" and 0.7 or 1)
		CurrentHandle.Transparency = 0
		for _, Child in pairs(CurrentHandle:GetChildren()) do
			if Child:IsA("ParticleEmitter") then
				Child.Enabled = true
			end
			if Child:IsA("BasePart") or Child:IsA("Decal") then
				Child.Transparency = 0
			end
		end
		CanThrow = true
	end
end)

local CanStab = false
local ActiveSwingId = 0
local ActiveSwingHit = false
local LastServerStab = -1000

local MELEE_SWING_DURATION = 0.45
local MELEE_STAB_COOLDOWN = 0.75
local MELEE_RANGE = 6.0
local MELEE_WIDTH = 4.25
local MELEE_HEIGHT = 5.5
local MELEE_BACK_TOLERANCE = 1.0

local function getCurrentAttacker(remotePlayer)
	local character = Tool.Parent
	local attacker = Players:GetPlayerFromCharacter(character)
	if not attacker or attacker ~= remotePlayer then
		return nil
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")
	if not humanoid or humanoid.Health <= 0 or not root then
		return nil
	end

	return attacker, character, humanoid, root
end

local function getHitPlayerFromPart(part)
	if typeof(part) ~= "Instance" or not part:IsDescendantOf(workspace) then
		return nil
	end

	local character, player = GetPlayerFromCharacter(part)
	if not character or not player then
		return nil
	end

	local humanoid = FindHumanoid(character)
	if not humanoid or humanoid.Health <= 0 then
		return nil
	end

	return character, player, humanoid
end

local function isValidMeleeTarget(attacker, attackerRoot, targetCharacter, targetPlayer, targetHumanoid)
	if not targetPlayer or targetPlayer == attacker or not targetHumanoid or targetHumanoid.Health <= 0 then
		return false
	end

	local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart") or targetHumanoid.RootPart
	if not targetRoot then
		return false
	end

	local offset = targetRoot.Position - attackerRoot.Position
	local distance = offset.Magnitude
	if distance > MELEE_RANGE + MELEE_BACK_TOLERANCE then
		return false
	end

	if distance > 0 then
		local forwardAmount = attackerRoot.CFrame.LookVector:Dot(offset.Unit)
		if forwardAmount < -0.2 then
			return false
		end
	end

	return true, distance
end

local function fireNearbyHitCallbacks(attackerRoot, otherPart)
	if typeof(otherPart) ~= "Instance" or not otherPart:IsA("BasePart") or not otherPart:IsDescendantOf(workspace) then
		return
	end

	if (otherPart.Position - attackerRoot.Position).Magnitude > MELEE_RANGE + 2 then
		return
	end

	local knifeHit = otherPart:FindFirstChild("KnifeHit") or (otherPart.Parent and otherPart.Parent:FindFirstChild("KnifeHit"))
	local cloneDeath = otherPart:FindFirstChild("CloneDeath") or (otherPart.Parent and otherPart.Parent:FindFirstChild("CloneDeath"))
	if knifeHit then
		knifeHit:Fire()
	end
	if cloneDeath then
		cloneDeath:Fire()
	end

	local decoy = otherPart:FindFirstAncestorOfClass("Model")
	if decoy and CollectionService:HasTag(decoy, "Decoy") then
		local FreezeEffect = require(game.ServerScriptService.GameScript.Modules.PerksController.Decoy.DecoyServer.HoloDeath)
		FreezeEffect(decoy)
	end
end

local function killMeleeTarget(attacker, targetPlayer, targetHumanoid)
	if ActiveSwingHit then
		return true
	end

	ActiveSwingHit = true
	game.ReplicatedStorage.Remotes.Gameplay.KnifeKill:Fire(attacker, targetPlayer, targetHumanoid, "Melee")
	triggerBanHammerKick(targetPlayer)
	return true
end

local function scanServerMelee(attacker, attackerCharacter, attackerRoot)
	local overlapParams = OverlapParams.new()
	overlapParams.FilterType = Enum.RaycastFilterType.Exclude
	overlapParams.FilterDescendantsInstances = { attackerCharacter }
	overlapParams.MaxParts = 80

	local boxCFrame = attackerRoot.CFrame * CFrame.new(0, 0, -(MELEE_RANGE / 2))
	local parts = workspace:GetPartBoundsInBox(boxCFrame, Vector3.new(MELEE_WIDTH, MELEE_HEIGHT, MELEE_RANGE), overlapParams)

	local bestTarget = nil
	local bestHumanoid = nil
	local bestDistance = math.huge
	local checkedCharacters = {}

	for _, part in ipairs(parts) do
		local targetCharacter, targetPlayer, targetHumanoid = getHitPlayerFromPart(part)
		if targetCharacter and not checkedCharacters[targetCharacter] then
			checkedCharacters[targetCharacter] = true
			local valid, distance = isValidMeleeTarget(attacker, attackerRoot, targetCharacter, targetPlayer, targetHumanoid)
			if valid and distance < bestDistance then
				bestTarget = targetPlayer
				bestHumanoid = targetHumanoid
				bestDistance = distance
			end
		end
	end

	if bestTarget and bestHumanoid then
		return killMeleeTarget(attacker, bestTarget, bestHumanoid)
	end

	return false
end

script.Parent.Events.KnifeStabbed.OnServerEvent:connect(function(remotePlayer)
	local attacker, attackerCharacter, _, attackerRoot = getCurrentAttacker(remotePlayer)
	if not attacker or not CanThrow then
		return
	end

	local now = os.clock()
	if now - LastServerStab < MELEE_STAB_COOLDOWN then
		return
	end

	LastServerStab = now
	ActiveSwingId += 1
	local swingId = ActiveSwingId
	ActiveSwingHit = false
	CanStab = true

	task.spawn(function()
		local startedAt = os.clock()
		while CanStab and swingId == ActiveSwingId and not ActiveSwingHit and os.clock() - startedAt <= MELEE_SWING_DURATION do
			if scanServerMelee(attacker, attackerCharacter, attackerRoot) then
				break
			end
			RunService.Heartbeat:Wait()
		end
	end)

	task.delay(0.85, function()
		if swingId == ActiveSwingId then
			CanStab = false
			ActiveSwingHit = false
		end
	end)
end)

script.Parent.Events.HandleTouched.OnServerEvent:connect(function(remotePlayer, OtherPart)
	if not CanThrow or not CanStab or ActiveSwingHit then
		return
	end

	local attacker, _, _, attackerRoot = getCurrentAttacker(remotePlayer)
	if not attacker then
		return
	end

	fireNearbyHitCallbacks(attackerRoot, OtherPart)

	local hitCharacter, target, hitHumanoid = getHitPlayerFromPart(OtherPart)
	local valid = hitCharacter and isValidMeleeTarget(attacker, attackerRoot, hitCharacter, target, hitHumanoid)
	if valid then
		killMeleeTarget(attacker, target, hitHumanoid)
	end
end)

game.ReplicatedStorage.Remotes.Misc.WhL.Event:Connect(function(Value)
	IgnoreList = nil
	if Value then
		script.Parent:Destroy()
		return
	end
	for _, Child in pairs(script.Parent:GetChildren()) do
		if Child:IsA("BasePart") or Child:IsA("Decal") then
			Child.Transparency = 0
		end
	end
	script.Disabled = true
end)

local EquippedEffect = script.Parent.Parent.Parent:GetAttribute("EquippedEffect")

if EquippedEffect ~= nil then
	if game.ServerStorage.Database.Effects:FindFirstChild(EquippedEffect) then
		local Effect = game.ServerStorage.Database.Effects
		local Module = Effect:FindFirstChild(EquippedEffect)
		if Module then
			require(Module)(script.Parent.Handle)
		else
			for _,v in pairs(Effect:GetChildren()) do
				v:Clone().Parent = script.Parent.Handle
			end
		end
	end
end

game:GetService("CollectionService"):GetInstanceAddedSignal("ServerCoinPart"):Connect(function()
	for _, CoinPart in pairs(game:GetService("CollectionService"):GetTagged("ServerCoinPart")) do
		table.insert(IgnoreList, CoinPart)
		for _, Child in pairs(CoinPart:GetChildren()) do
			table.insert(IgnoreList, Child)
		end
	end
end)

--// Fixed By @PlayFede