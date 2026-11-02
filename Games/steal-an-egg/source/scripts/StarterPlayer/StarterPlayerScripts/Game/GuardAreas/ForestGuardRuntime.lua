-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AreaEggs = require(ReplicatedStorage.Library.Types.AreaEggs)
local AreaEggSlotIdentity = require(ReplicatedStorage.Library.Util.AreaEggSlotIdentity)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local GuardAreaLookupUtil = require(ReplicatedStorage.Library.Util.GuardAreaLookupUtil)

require(ReplicatedStorage.Library.Types.GuardAreas)

local Guards = require(ReplicatedStorage.Directory.Guards)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Player = require(ReplicatedStorage.Library.Player)
local GuardComponent = require(ReplicatedStorage.Library.Modules.GuardAreas.GuardComponent)

require(ReplicatedStorage.Library.Modules.GuardAreas.Types.Interface)

local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local t = {}

t.__index = t
t.__class = "ForestGuardRuntime"

local Guards2 = Constants.NETWORK_MAP.Guards
local States = AreaEggs.States
local LocalPlayer = Players.LocalPlayer

local function stageGuardForConstruction(p1, p2) --[[ stageGuardForConstruction | Line: 67 ]]
	p1.Name = "ForestGuardStaging"

	local t = {}
	local t2 = {}

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			t[v] = {
				CanCollide = v.CanCollide,
				CanQuery = v.CanQuery,
				CanTouch = v.CanTouch,
				LocalTransparencyModifier = v.LocalTransparencyModifier
			}
			v.LocalTransparencyModifier = 1
			v.CanCollide = false
			v.CanQuery = false
			v.CanTouch = false

			continue
		end

		if v:IsA("ParticleEmitter") or (v:IsA("Beam") or (v:IsA("Trail") or v:IsA("BillboardGui"))) then
			local Enabled = v.Enabled

			table.insert(t2, function() --[[ Line: 99 | Upvalues: v (copy), Enabled (copy) ]]
				v.Enabled = Enabled
			end)
			v.Enabled = false
		end
	end

	p1.Parent = p2

	return function() --[[ Line: 106 | Upvalues: t (copy), t2 (copy) ]]
		for k, v in pairs(t) do
			k.LocalTransparencyModifier = v.LocalTransparencyModifier
			k.CanCollide = v.CanCollide
			k.CanQuery = v.CanQuery
			k.CanTouch = v.CanTouch
		end

		for i, v in ipairs(t2) do
			v()
		end
	end
end

function t.new(p1) --[[ new | Line: 123 | Upvalues: Asserts (copy), Workspace (copy), t (copy), Trove (copy), LocalPlayer (copy), Network (copy), Guards2 (copy), stageGuardForConstruction (copy), GuardComponent (copy), Guards (copy), Player (copy), GuardAreaLookupUtil (copy) ]]
	Asserts.Model(p1)
	assert(p1.Name == "Forest", "ForestGuardRuntime requires area Forest")

	local ForestGuardAuthored = p1.Guard
	local Bounds = p1.Bounds
	local v1 = p1:IsDescendantOf(Workspace)

	assert(v1, "Forest area must be in Workspace before guard construction")
	assert(ForestGuardAuthored.Parent == p1, "Forest authored guard must belong to its area before guard construction")

	local Guard = ForestGuardAuthored:Clone()
	local v3 = setmetatable({}, t)

	v3._areaModel = p1
	v3._clientEggFolder = nil
	v3._droppedModelByUid = {}
	v3._droppedTroveByUid = {}
	v3._guardModel = Guard
	v3._registeredDroppedUids = {}
	v3._registeredStolenUids = {}
	v3._trove = Trove.new()
	v3._wake = nil

	local t2 = {
		ServerOwnsPhysics = false,
		Attack = function(p1) --[[ Attack | Line: 145 | Upvalues: LocalPlayer (ref), Network (ref), Guards2 (ref) ]]
			if p1.Player == LocalPlayer and p1.EggUid ~= nil then
				Network.Fire(Guards2.FOREST_HIT, {
					EggUid = p1.EggUid,
					GuardCFrame = p1.GuardRoot.CFrame
				})
			end
		end,
		Wake = function(p1) --[[ Wake | Line: 156 | Upvalues: v3 (copy) ]]
			local _wake = v3._wake

			if _wake == nil then
				return
			end

			_wake(p1)
		end
	}
	local v4 = nil
	local v5 = nil
	local ok, result = xpcall(function() --[[ Line: 165 | Upvalues: v4 (ref), stageGuardForConstruction (ref), Guard (copy), p1 (copy), v5 (ref), GuardComponent (ref), Bounds (copy), Workspace (ref), Guards (ref), LocalPlayer (ref), Player (ref), GuardAreaLookupUtil (ref), t2 (copy), ForestGuardAuthored (copy) ]]
		v4 = stageGuardForConstruction(Guard, p1)
		v5 = GuardComponent.new("Forest", Guard, Bounds, Workspace.__OBJECTS.Areas.Ground, Guards.Directory.Forest, function(p1) --[[ Line: 173 | Upvalues: LocalPlayer (ref), Player (ref), GuardAreaLookupUtil (ref), Workspace (ref) ]]
			if p1 ~= LocalPlayer then
				return false
			end

			local v1 = Player.Optional.HumanoidRootPart(LocalPlayer)

			return if v1 == nil then false else GuardAreaLookupUtil.IsInGameplaySide(Workspace.__OBJECTS.Areas.SeparationLine, v1.Position)
		end, t2)

		local v1 = p1:IsDescendantOf(Workspace)

		assert(v1, "Forest area was removed during guard construction")
		assert(ForestGuardAuthored.Parent == p1, "Forest authored guard was removed during guard construction")
	end, function(p1) --[[ Line: 185 ]]
		return debug.traceback(tostring(p1), 2)
	end)

	if not ok then
		if v5 ~= nil then
			v5:Destroy()
		end

		Guard:Destroy()
		v3._trove:Destroy()
		error(result, 0)
	end

	local v6 = v5

	v3._component = assert(v6, "Forest shared guard component did not initialize")

	local v7 = v4
	local v8 = assert(v7, "Forest guard staging did not initialize")

	v3._trove:Add(Guard)
	v3._trove:Add(function() --[[ Line: 199 | Upvalues: ForestGuardAuthored (copy) ]]
		if ForestGuardAuthored.Parent == nil then
			return
		end

		ForestGuardAuthored.Name = "Guard"
	end)
	ForestGuardAuthored.Name = "ForestGuardAuthored"
	Guard.Name = "Guard"

	for i, v in ipairs(ForestGuardAuthored:GetDescendants()) do
		if v:IsA("BasePart") then
			local LocalTransparencyModifier = v.LocalTransparencyModifier

			v3._trove:Add(function() --[[ Line: 210 | Upvalues: v (copy), LocalTransparencyModifier (copy) ]]
				if v.Parent == nil then
					return
				end

				v.LocalTransparencyModifier = LocalTransparencyModifier
			end)
			v.LocalTransparencyModifier = 1

			continue
		end

		if v:IsA("ParticleEmitter") or (v:IsA("Beam") or (v:IsA("Trail") or v:IsA("BillboardGui"))) then
			local Enabled = v.Enabled

			v3._trove:Add(function() --[[ Line: 224 | Upvalues: v (copy), Enabled (copy) ]]
				if v.Parent == nil then
					return
				end

				v.Enabled = Enabled
			end)
			v.Enabled = false
		end
	end

	v8()

	return v3
end
function t._isOwnedForestRecord(p1, p2) --[[ _isOwnedForestRecord | Line: 241 | Upvalues: AreaEggSlotIdentity (copy), LocalPlayer (copy) ]]
	return if p2.AreaId == "Forest" then AreaEggSlotIdentity.GetFirstAreaOwnerUserId(p2.Uid) == LocalPlayer.UserId else false
end
function t._clearStolen(p1, p2) --[[ _clearStolen | Line: 245 ]]
	if p1._registeredStolenUids[p2] == true then
		p1._registeredStolenUids[p2] = nil
		p1._component:ClearStolenEgg(p2)
	end
end
function t._registerStolen(p1, p2) --[[ _registerStolen | Line: 253 | Upvalues: LocalPlayer (copy) ]]
	if p1._registeredStolenUids[p2] == true then
		return
	end

	for k in pairs(p1._registeredStolenUids) do
		p1:_clearStolen(k)
	end

	p1._registeredStolenUids[p2] = true
	p1._component:RegisterStolenEgg(LocalPlayer, p2)
end
function t._clearDropped(p1, p2) --[[ _clearDropped | Line: 264 ]]
	local v1 = p1._droppedTroveByUid[p2]

	if v1 ~= nil then
		p1._droppedTroveByUid[p2] = nil
		v1:Destroy()
	end

	p1._droppedModelByUid[p2] = nil

	if p1._registeredDroppedUids[p2] == true then
		p1._registeredDroppedUids[p2] = nil
		p1._component:ClearDroppedEgg(p2)
	end
end
function t._tryRegisterDropped(p1, p2) --[[ _tryRegisterDropped | Line: 278 | Upvalues: GuardAreaLookupUtil (copy), AreaEggSlotIdentity (copy), Trove (copy), EggCmds (copy), States (copy) ]]
	if p1._registeredDroppedUids[p2.Uid] == true then
		return
	end

	if not GuardAreaLookupUtil.IsWorldPositionInsideXZBounds(p1._areaModel.Bounds, p2.BoundsCFrame.Position) then
		return
	end

	local _clientEggFolder = p1._clientEggFolder

	if _clientEggFolder == nil then
		return
	end

	local v1 = _clientEggFolder:FindFirstChild(p2.Uid)

	if v1 == nil then
		return
	end

	local v2 = v1:IsA("Model")

	assert(v2, (("%*.%* must be a Model"):format(_clientEggFolder:GetFullName(), p2.Uid)))

	local EggSpotBottom = AreaEggSlotIdentity.ResolveNest(p1._areaModel, p2.NestId).EggSpotBottom

	if p1._component:RegisterDroppedEgg({
		EggUid = p2.Uid,
		Model = v1,
		DroppedPosition = p2.BottomCFrame.Position,
		NestBottomCFrame = EggSpotBottom.CFrame
	}) then
		p1._registeredDroppedUids[p2.Uid] = true
		p1._droppedModelByUid[p2.Uid] = v1

		local v4 = Trove.new()

		p1._droppedTroveByUid[p2.Uid] = v4
		v4:Connect(v1.AncestryChanged, function(p12, p22) --[[ Line: 312 | Upvalues: p1 (copy), p2 (copy), v1 (copy), EggCmds (ref), States (ref) ]]
			if p22 ~= nil or p1._droppedModelByUid[p2.Uid] ~= v1 then
				return
			end

			p1:_clearDropped(p2.Uid)

			local v12 = EggCmds.GetAreaEggRecord(p2.Uid)

			if v12 == nil or v12.State ~= States.Dropped then
				return
			end

			p1:_tryRegisterDropped(v12)
		end)
	end
end
function t._syncRecord(p1, p2) --[[ _syncRecord | Line: 324 | Upvalues: States (copy), LocalPlayer (copy) ]]
	if not p1:_isOwnedForestRecord(p2) then
		return
	end

	if p2.State == States.Carried and p2.CarrierUserId == LocalPlayer.UserId then
		p1:_clearDropped(p2.Uid)
		p1:_registerStolen(p2.Uid)

		return
	end

	p1:_clearStolen(p2.Uid)

	if p2.State == States.Dropped then
		p1:_tryRegisterDropped(p2)
	else
		p1:_clearDropped(p2.Uid)
	end
end
function t._syncSnapshot(p1, p2) --[[ _syncSnapshot | Line: 342 ]]
	local t = {}

	for i, v in ipairs(p2.Records) do
		if p1:_isOwnedForestRecord(v) then
			t[v.Uid] = true
			p1:_syncRecord(v)
		end
	end

	for k in pairs(p1._registeredStolenUids) do
		if t[k] ~= true then
			p1:_clearStolen(k)
		end
	end

	for k in pairs(p1._registeredDroppedUids) do
		if t[k] ~= true then
			p1:_clearDropped(k)
		end
	end
end
function t._handleRetrievalEvent(p1, p2) --[[ _handleRetrievalEvent | Line: 362 | Upvalues: Network (copy), Guards2 (copy) ]]
	if p2.Kind == "Attached" then
		local v1 = p1._droppedModelByUid[p2.EggUid]
		local v2

		if v1 == nil then
			v2 = {
				Kind = "Attached",
				EggUid = p2.EggUid
			}
			Network.Fire(Guards2.FOREST_DEPOSIT, v2)

			return
		end

		local CarryAreaEgg = v1:FindFirstChild("CarryAreaEgg", true)

		if CarryAreaEgg == nil then
			v2 = {
				Kind = "Attached",
				EggUid = p2.EggUid
			}
			Network.Fire(Guards2.FOREST_DEPOSIT, v2)

			return
		end

		local v3 = CarryAreaEgg:IsA("ProximityPrompt")

		assert(v3, (("%* must be a ProximityPrompt"):format((CarryAreaEgg:GetFullName()))))
		CarryAreaEgg:Destroy()
		v2 = {
			Kind = "Attached",
			EggUid = p2.EggUid
		}
		Network.Fire(Guards2.FOREST_DEPOSIT, v2)
	else
		local t = {
			Kind = "Deposited",
			EggUid = p2.EggUid
		}

		p1._registeredDroppedUids[p2.EggUid] = nil
		p1._droppedModelByUid[p2.EggUid] = nil

		local v5 = p1._droppedTroveByUid[p2.EggUid]

		if v5 == nil then
			Network.Fire(Guards2.FOREST_DEPOSIT, t)

			return
		end

		p1._droppedTroveByUid[p2.EggUid] = nil
		v5:Destroy()
		Network.Fire(Guards2.FOREST_DEPOSIT, t)
	end
end
function t.GetGuardModel(p1) --[[ GetGuardModel | Line: 401 ]]
	return p1._guardModel
end
function t.SetWakeHandler(p1, p2) --[[ SetWakeHandler | Line: 405 | Upvalues: Asserts (copy) ]]
	Asserts.func(p2)
	p1._wake = p2
end
function t.Start(p1) --[[ Start | Line: 410 | Upvalues: EggCmds (copy), Workspace (copy), RunService (copy) ]]
	p1._trove:Add(EggCmds.AreaEggSnapshotUpdated:Connect(function(p12) --[[ Line: 411 | Upvalues: p1 (copy) ]]
		p1:_syncSnapshot(p12)
	end))
	p1._trove:Add(EggCmds.AreaEggUpdated:Connect(function(p12) --[[ Line: 414 | Upvalues: p1 (copy) ]]
		p1:_syncRecord(p12)
	end))
	p1._trove:Add(EggCmds.AreaEggRemoved:Connect(function(p12) --[[ Line: 417 | Upvalues: p1 (copy) ]]
		p1:_clearStolen(p12)
		p1:_clearDropped(p12)
	end))
	p1._trove:Add(EggCmds.AreaEggCarryStateChanged:Connect(function(p12) --[[ Line: 421 | Upvalues: p1 (copy) ]]
		if p12.IsCarrying and (p12.Uid ~= nil and p12.AreaId == "Forest") then
			p1:_registerStolen(p12.Uid)

			return
		end

		for k in pairs(p1._registeredStolenUids) do
			p1:_clearStolen(k)
		end
	end))
	task.spawn(function() --[[ Line: 431 | Upvalues: Workspace (ref), p1 (copy), EggCmds (ref) ]]
		local AreaEggSlotsClient = Workspace:WaitForChild("AreaEggSlotsClient")

		assert(AreaEggSlotsClient:IsA("Folder"), "Workspace.AreaEggSlotsClient must be a Folder")

		if p1._guardModel.Parent ~= nil then
			p1._clientEggFolder = AreaEggSlotsClient
			p1._trove:Connect(AreaEggSlotsClient.ChildAdded, function(p12) --[[ Line: 438 | Upvalues: p1 (ref), AreaEggSlotsClient (copy), EggCmds (ref) ]]
				if p1._clientEggFolder ~= AreaEggSlotsClient or p12.Parent ~= AreaEggSlotsClient then
					return
				end

				local v1 = EggCmds.GetAreaEggRecord(p12.Name)

				if v1 == nil then
					return
				end

				p1:_syncRecord(v1)
			end)
			p1:_syncSnapshot(EggCmds.GetAreaEggSnapshot())
		end
	end)

	local v1 = 0

	p1._trove:Connect(RunService.Heartbeat, function(p12) --[[ Line: 451 | Upvalues: v1 (ref), p1 (copy) ]]
		v1 = v1 + p12

		if v1 < 0.03 then
			return
		end

		v1 = 0

		local v12 = p1._component:Step(os.clock())

		if v12 == nil then
			return
		end

		p1:_handleRetrievalEvent(v12)
	end)
	p1:_syncSnapshot(EggCmds.GetAreaEggSnapshot())
end
function t.Destroy(p1) --[[ Destroy | Line: 465 ]]
	p1._clientEggFolder = nil

	for k in pairs(p1._registeredDroppedUids) do
		p1:_clearDropped(k)
	end

	for k, v in pairs(p1._droppedTroveByUid) do
		if v ~= nil then
			v:Destroy()
		end
	end

	p1._component:Destroy()
	p1._trove:Destroy()
	table.clear(p1._registeredDroppedUids)
	table.clear(p1._registeredStolenUids)
	table.clear(p1._droppedModelByUid)
	table.clear(p1._droppedTroveByUid)
end

return t