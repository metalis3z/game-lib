-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: MultiplayerViewServiceClient, time of decompilation: Sun May  3 10:12:14 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local GameplayFormationUtils = require(ReplicatedStorage.Source.Features.Gameplay.Classes.GameplayFormationUtils)
local GameplayServiceUtils = require(ReplicatedStorage.Source.Features.Gameplay.GameplayServiceUtils)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)

require(script.Parent.MultiplayerViewServiceUtils)

local Networker = require(ReplicatedStorage.Packages.Networker)
local SettingsState = require(ReplicatedStorage.Source.Features.Settings.SettingsState)
local SlimeClient = require(ReplicatedStorage.Source.Features.Gameplay.Classes.SlimeClient)
local t1 = {}

local function getCharacterTransform(p1) -- line: 35
	-- upvalues: Workspace (copy)
	local Character = p1.Character

	if not Character then
		return nil, nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart or not HumanoidRootPart:IsA("BasePart") or not HumanoidRootPart:IsDescendantOf(Workspace) then
		return nil, nil
	end

	local HumanoidRootPartCFrame = HumanoidRootPart.CFrame

	return Vector3.new(HumanoidRootPartCFrame.Position.X, 0, HumanoidRootPartCFrame.Position.Z), (Vector3.new(HumanoidRootPartCFrame.LookVector.X, 0, HumanoidRootPartCFrame.LookVector.Z))
end

function t1.init(p2) -- line: 64
	-- upvalues: Networker (copy), Workspace (copy), RunService (copy), Players (copy)
	p2.networker = Networker.client.new("MultiplayerViewService", p2)
	p2.root = Instance.new("Folder")
	p2.root.Name = "MultiplayerView"
	p2.root.Parent = Workspace
	p2.players = {}
	RunService.Heartbeat:Connect(function(dt: number) -- line: 71
		-- upvalues: p2 (copy)
		p2:update(dt)
	end)
	Players.PlayerRemoving:Connect(function(player) -- line: 74
		-- upvalues: p2 (copy)
		p2:removePlayer(player.UserId)
	end)
	task.spawn(function() -- line: 78
		-- upvalues: p2 (copy)
		for _, v73 in p2.networker:fetch("getPlayerSlimeData") or {} do
			p2:playerSlimesChanged(v73.userId, v73.slimes)
		end
	end)
end
function t1.getOrCreatePlayerState(p3, n1: number) -- line: 86
	local v21 = p3.players[n1]

	if v21 then
		return v21
	end

	local Folder = Instance.new("Folder")

	Folder.Name = tostring(n1)
	Folder.Parent = p3.root

	local t2 = {
		rendered = false,
		refreshCooldown = 0,
		refreshElapsed = 0,
		followForward = Vector3.new(0, 0, 1),
		cachedPlayerPos = nil,
		userId = n1,
		root = Folder,
		followAssignments = {},
		slimeEntries = {},
		slimes = {}
	}

	p3.players[n1] = t2

	return t2
end
function t1.clearRenderedSlimes(_, t3: {[any]: any}) -- line: 115
	for v26, v27 in t3.slimes do
		v27:destroy()
		t3.slimes[v26] = nil
	end

	t3.rendered = false
	t3.cachedPlayerPos = nil
	t3.followAssignments = {}
	t3.refreshCooldown = 0
	t3.refreshElapsed = 0
end
function t1.syncRenderedSlimes(p5, t4: {[any]: any}, vector3: Vector3) -- line: 131
	-- upvalues: InventoryServiceUtils (copy), SlimeClient (copy), GameplayServiceUtils (copy)
	p5:clearRenderedSlimes(t4)

	if #t4.slimeEntries <= 0 then
		return
	end

	for _, v32 in t4.slimeEntries do
		local v33 = InventoryServiceUtils.getSlimeStatsFromData(v32.slimeData)

		t4.slimes[v32.uniqueId] = SlimeClient.new({
			targetUniqueId = nil,
			health = 1,
			maxHealth = 1,
			uniqueId = v32.uniqueId,
			inventoryUniqueId = v32.uniqueId,
			slimeId = v32.slimeData.id,
			mutations = v32.slimeData.mutations,
			pos = vector3,
			state = GameplayServiceUtils.enums.slimeStates.following,
			speed = v33.speed
		}, t4.root, {
			enableCombatVfx = false,
			showHealthBar = false,
			showInfoBillboard = true
		})
	end

	t4.rendered = true
end
function t1.setPlayerSlimes(p6, n2: number, t5: {[any]: any}) -- line: 168
	-- upvalues: Players (copy)
	if n2 == Players.LocalPlayer.UserId then
		return
	end

	local v37 = p6:getOrCreatePlayerState(n2)

	v37.slimeEntries = t5 or {}
	v37.refreshCooldown = 0

	if v37.rendered and v37.cachedPlayerPos then
		p6:syncRenderedSlimes(v37, v37.cachedPlayerPos)
	end
end
function t1.removePlayer(p7, n3: number) -- line: 185
	local v40 = p7.players[n3]

	if not v40 then
		return
	end

	p7:clearRenderedSlimes(v40)
	v40.root:Destroy()
	p7.players[n3] = nil
end
function t1.updatePlayer(p8, n4: number, t6: {[any]: any}, vector3: Vector3) -- line: 196
	-- upvalues: Players (copy), getCharacterTransform (copy), GameplayFormationUtils (copy)
	local PlayerByUserId = Players:GetPlayerByUserId(t6.userId)

	if not PlayerByUserId then
		p8:removePlayer(t6.userId)

		return
	end

	local v46, v47 = getCharacterTransform(PlayerByUserId)

	if v46 == nil or v47 == nil or #t6.slimeEntries <= 0 then
		p8:clearRenderedSlimes(t6)

		return
	end

	local Magnitude = (v46 - vector3).Magnitude

	if Magnitude > (not t6.rendered and 100 or 112) then
		p8:clearRenderedSlimes(t6)

		return
	end

	if not t6.rendered then
		p8:syncRenderedSlimes(t6, v46)
	end

	t6.refreshCooldown = t6.refreshCooldown - n4
	t6.refreshElapsed = t6.refreshElapsed + n4

	local v49 = GameplayFormationUtils.getSortedSlimes(t6.slimes)

	if t6.refreshCooldown <= 0 or t6.cachedPlayerPos == nil then
		local v50 = math.max(t6.refreshElapsed, n4)
		local v51, v52, v53 = GameplayFormationUtils.getFormationBasis(t6.followForward, v46, v47, v50)

		t6.cachedPlayerPos = v51
		t6.followForward = v52
		t6.followAssignments = GameplayFormationUtils.getFollowFormationSlots(v49, v51, v52, v53)
		t6.refreshCooldown = if not (Magnitude <= 20) then if not (Magnitude <= 40) then if not (Magnitude <= 65) then not (Magnitude <= 85) and 0.32 or 0.2 else 0.12 else 0.06 else 0.03
		t6.refreshElapsed = 0
	end

	for _, v55 in v49 do
		v55:update(n4, t6.cachedPlayerPos, t6.followAssignments[v55.uniqueId], t6.cachedPlayerPos)
	end
end
function t1.update(p9, n5: number) -- line: 251
	-- upvalues: SettingsState (copy), getCharacterTransform (copy), Players (copy)
	if not SettingsState.get("otherPlayerSlimes") then
		for _, v59 in p9.players do
			p9:clearRenderedSlimes(v59)
		end

		return
	end

	local v60 = select(1, getCharacterTransform(Players.LocalPlayer))

	if v60 == nil then
		for _, v62 in p9.players do
			p9:clearRenderedSlimes(v62)
		end

		return
	end

	for _, v64 in p9.players do
		p9:updatePlayer(n5, v64, v60)
	end
end
function t1.playerSlimesChanged(p10, n6: number, t7: {[any]: any}) -- line: 272
	p10:setPlayerSlimes(n6, t7)
end
function t1.playerRemoving(p11, n7: number) -- line: 280
	p11:removePlayer(n7)
end

return t1
