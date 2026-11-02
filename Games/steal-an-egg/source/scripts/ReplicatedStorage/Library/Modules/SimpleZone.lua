-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

game:GetService("ReplicatedStorage")

local HttpService = game:GetService("HttpService")
local v1 = RunService:IsClient()
local Utility = script.Utility
local Templates = script.Templates
local BVH = require(Utility.BVH)
local SimpleSignal = require(Utility.SimpleSignal)
local JumpTable = require(Utility.JumpTable)
local SearchFor = require(script.SearchFor)
local PlayerLookup = require(script.PlayerLookup)
local Zones = require(script.Zones)
local characterObjects = PlayerLookup.characterObjects
local t = {}
local t2 = {
	__index = t
}
local SIMPLEZONE_ZONE_ACTORS = Instance.new("Folder")

SIMPLEZONE_ZONE_ACTORS.Name = "SIMPLEZONE_ZONE_ACTORS"
SIMPLEZONE_ZONE_ACTORS.Parent = v1 and Players.LocalPlayer.PlayerScripts or ServerScriptService

local v3 = v1 and Templates.ClientWorker or Templates.ServerWorker
local v4 = Instance.new("Folder")

v4.Name = ("SIMPLE_ZONE_QUERY_SPACES:CLIENT:%*"):format(v1)
v4.Parent = game:GetService("ReplicatedStorage")

local v5 = JumpTable({
	Block = function(p1, p2, p3) --[[ Block | Line: 76 ]]
		return p1:GetPartBoundsInBox(p2.CFrame, p2.Size, p3)
	end,
	Ball = function(p1, p2, p3) --[[ Ball | Line: 79 ]]
		return p1:GetPartBoundsInRadius(p2.Position, p2.ExtentsSize.Y, p3)
	end,
	_ = function(p1, p2, p3) --[[ _ | Line: 82 ]]
		return p1:GetPartsInPart(p2, p3)
	end
})
local t3 = {
	Shape = true
}
local t4 = {
	CFrame = true,
	Position = true,
	Orientation = true
}

local function queryop_new() --[[ queryop_new | Line: 95 ]]
	return {
		FireMode = "Both",
		TrackItemEnabled = false,
		ThrottlingEnabled = false,
		StoreByClass = false,
		AcceptMetadata = false,
		UpdateInterval = 0,
		InSeperateQuerySpace = false,
		Static = false,
		DoBoxQueryForBVHNodes = false
	}
end

local function isArray(p1) --[[ isArray | Line: 109 ]]
	if type(p1) ~= "table" then
		return false
	end

	local v1 = #p1

	if v1 == 0 then
		return false
	end

	return next(p1, v1) == nil
end

local function isPointInBox(p1, p2, p3) --[[ isPointInBox | Line: 121 ]]
	local v1 = p2:PointToObjectSpace(p1)

	return if math.abs(v1.X) <= p3.X then if math.abs(v1.Y) <= p3.Y then math.abs(v1.Z) <= p3.Z else false else false
end

local function areAnyItemPointsInBox(p1, p2, p3) --[[ areAnyItemPointsInBox | Line: 127 ]]
	local v1 = p3 / 2

	for v3, v4 in p1 do
		local v2
		local v5 = p2:PointToObjectSpace(v4.Position)

		v2 = if math.abs(v5.X) <= v1.X then if math.abs(v5.Y) <= v1.Y then if math.abs(v5.Z) <= v1.Z then true else false else false else false

		if v2 then
			return true
		end
	end

	return false
end

local function removeFromQuerySpace(p1, p2) --[[ removeFromQuerySpace | Line: 140 ]]
	if not p2:IsA("BasePart") then
		return
	end

	local _querySpace = p1._querySpace

	for v1, v2 in p1._replicaConnect[p2] do
		v2:Disconnect()
	end

	local v3 = table.find(_querySpace.static.index, p2)
	local v4, v5

	if v3 then
		v4 = _querySpace.static
		v5 = v3
	else
		local v6 = table.find(_querySpace.dynamic.index, p2)

		v4 = _querySpace.dynamic
		v5 = v6
	end

	if v5 then
		table.remove(v4.index, v5)
		table.remove(v4.replicas, v5)
	end
end

local function copyToQuerySpace(p1, p2, p3, p4, p5) --[[ copyToQuerySpace | Line: 168 | Upvalues: t4 (copy), removeFromQuerySpace (copy) ]]
	if not p2:IsA("BasePart") then
		return
	end

	local _querySpace = p1._querySpace
	local v2 = p3 and _querySpace.static.replicas or _querySpace.dynamic.replicas
	local v3 = #v2 + 1
	local v4 = Instance.fromExisting(p2)

	v4.Name = ("REPLICA:%*"):format(v3)
	v4.Parent = p1._worldModel;
	(p3 and _querySpace.static.index or _querySpace.dynamic.index)[v3] = p2
	v2[v3] = v4

	local t = {}

	t[1] = if p4 == nil then false else p2.Changed:Connect(function(p1) --[[ Line: 190 | Upvalues: t4 (ref), p4 (copy), v4 (copy), p2 (copy) ]]
	if t4[p1] then
		return
	end

	if p4[p1] then
		v4[p1] = p2[p1]
	end
end)
	t[2] = p2.Destroying:Once(function() --[[ Line: 200 | Upvalues: removeFromQuerySpace (ref), p1 (copy), p2 (copy) ]]
		removeFromQuerySpace(p1, p2)
	end)
	p1._replicaConnect[p2] = t

	if p5 then
		table.insert(p5, v4)
	end

	return v4
end

local function getOnEnterExit(p1) --[[ getOnEnterExit | Line: 211 ]]
	local _queryOptions = p1._queryOptions
	local _items = p1._items
	local FireMode = _queryOptions.FireMode

	return if _queryOptions.FireMode == "OnEnter" or _queryOptions.FireMode == "Both" then if _queryOptions.FireMode == "None" then false else true else false, if _queryOptions.FireMode == "OnExit" or _queryOptions.FireMode == "Both" then if _queryOptions.FireMode == "None" then false else true else false
end

local function getTracked(p1, p2) --[[ getTracked | Line: 223 ]]
	for v1 in p1._tracked do
		if p2:IsDescendantOf(v1) then
			return v1
		end
	end
end

local function getItem(p1, p2) --[[ getItem | Line: 231 | Upvalues: characterObjects (copy) ]]
	local _querySpace = p1._querySpace
	local _queryOptions = p1._queryOptions
	local v1 = typeof(p2) == "table" and _queryOptions.AcceptMetadata and p2.item or p2

	if _querySpace ~= nil then
		local v2 = table.find(_querySpace.dynamic.replicas, v1)

		if v2 then
			v1 = _querySpace.dynamic.index[v2]
		end
	end

	local v3

	if _queryOptions.TrackItemEnabled then
		local v4 = v1

		v3 = nil

		for v5 in p1._tracked do
			if v4:IsDescendantOf(v5) then
				v3 = v5

				break
			end
		end

		if not v3 then
			v3 = characterObjects[v1] or v1
		end
	else
		v3 = characterObjects[v1] or v1
	end

	return v3
end

function t.Update(p1, p2, p3, p4) --[[ Update | Line: 249 | Upvalues: getItem (copy) ]]
	local _queryOptions = p1._queryOptions
	local StoreByClass = _queryOptions.StoreByClass
	local AcceptMetadata = _queryOptions.AcceptMetadata
	local v1 = p1:Query(p2)

	print(v1)

	local t = {}

	for v2, v3 in v1 do
		if not t[v3] then
			local v4 = getItem(p1, v3)

			if not t[v4] then
				t[v4] = true

				if not p1._items[v4] then
					local v5 = if typeof(v3) == "table" then true else false

					if AcceptMetadata then
						p1._items[v4] = v5 and v3.metadata or true
					else
						p1._items[v4] = true
					end

					if StoreByClass then
						local v7 = typeof(v4)
						local v8 = v7 == "Instance" and v4.ClassName or v7
						local v9 = p1._storedClasses[v8]

						if not v9 then
							v9 = {}
							p1._storedClasses[v8] = v9
						end

						v9[#v9 + 1] = v4
					end

					if p3 then
						if AcceptMetadata then
							if v5 then
								p1.ItemEntered:Fire(v4, v3.metadata)

								continue
							end

							p1.ItemEntered:Fire(v4)

							continue
						end

						p1.ItemEntered:Fire(v4)
					end
				end
			end
		end
	end

	for v10, v11 in p1._items do
		if not t[v10] then
			p1._items[v10] = nil

			if StoreByClass then
				local v12 = typeof(v10)
				local v13 = v12 == "Instance" and v10.ClassName or v12
				local v14 = p1._storedClasses[v13]

				if v14 then
					local v15 = table.find(v14, v10)

					if v15 then
						table.remove(v14, v15)

						if #v14 == 0 then
							p1._storedClasses[v13] = nil
						end
					end
				end
			end

			if p4 then
				if AcceptMetadata then
					p1.ItemExited:Fire(v10, if v11 == true then nil else v11)

					continue
				end

				p1.ItemExited:Fire(v10)
			end
		end
	end
end
function t.UnbindFromHeartbeat(p1) --[[ UnbindFromHeartbeat | Line: 364 | Upvalues: Zones (copy) ]]
	Zones.deregisterZone(p1)
	table.clear(p1._items)
end
function t.BindToHeartbeat(p1, p2) --[[ BindToHeartbeat | Line: 373 | Upvalues: Zones (copy) ]]
	p1:UnbindFromHeartbeat()
	Zones.registerZone(p1, {
		QueryParams = p2,
		QueryOptions = p1._queryOptions
	})
end
function t.TrackItem(p1, p2) --[[ TrackItem | Line: 385 ]]
	local v1 = if typeof(p2) == "Instance" then true else false

	assert(v1, (("Bad item argument: %* must be an instance."):format(p2)))

	if not p1._queryOptions.TrackItemEnabled then
		warn("TrackItemEnabled is not enabled, cannot call Zone:TrackItem(...)")

		return
	end

	if p1._tracked[p2] then
		warn((("Item %* is already being tracked."):format(p2)))
	else
		p1._tracked[p2] = true

		local _trackedConnect = p1._trackedConnect

		_trackedConnect[p2] = p2.Destroying:Once(function() --[[ Line: 400 | Upvalues: _trackedConnect (copy), p2 (copy), p1 (copy) ]]
			_trackedConnect[p2] = nil
			p1:UntrackItem(p2)
		end)
	end
end
function t.UntrackItem(p1, p2) --[[ UntrackItem | Line: 409 ]]
	if not p1._tracked[p2] then
		warn((("Item %* is not currently being tracked."):format(p2)))

		return
	end

	p1._tracked[p2] = nil

	local _trackedConnect = p1._trackedConnect

	if not _trackedConnect[p2] then
		return
	end

	_trackedConnect[p2]:Disconnect()
	_trackedConnect[p2] = nil
end
function t.GetItemsWhichAreA(p1, p2) --[[ GetItemsWhichAreA | Line: 426 ]]
	if not p1._queryOptions.StoreByClass then
		warn("StoreByClass is not enabled, cannot call Zone:GetItemsWhichAreA(...)")

		return
	end

	return p1._storedClasses[p2] or {}
end
function t.SearchFor(p1, p2, p3) --[[ SearchFor | Line: 441 | Upvalues: SearchFor (copy) ]]
	assert(if p2 == nil then false else true, "Bad properties argument.")

	return SearchFor(p1:Query(), p2, p3)
end
function t.ListenTo(p1, p2, p3, p4) --[[ ListenTo | Line: 451 | Upvalues: v1 (copy), Players (copy) ]]
	if p2 == "LocalPlayer" and not v1 then
		error("Can only listen to LocalPlayer on the client.")
	end

	assert(if p3 == "Entered" then true elseif p3 == "Exited" then true else false, "Bad mode argument.")

	return p1[("Item%*"):format(p3)]:Connect(function(p1, p22) --[[ Line: 461 | Upvalues: p2 (copy), Players (ref), p4 (copy) ]]
		if p2 == "LocalPlayer" and p1 ~= Players.LocalPlayer then
			return
		end

		if p2 ~= "LocalPlayer" and not p1:IsA(p2) then
			return
		end

		p4(p1, p22)
	end)
end
function t.IsItemTracked(p1, p2) --[[ IsItemTracked | Line: 476 ]]
	return p1._tracked[p2] ~= nil
end
function t.IsItemWithinZone(p1, p2) --[[ IsItemWithinZone | Line: 483 ]]
	return p1._items[p2] ~= nil
end
function t.GetContainedItems(p1) --[[ GetContainedItems | Line: 490 ]]
	return p1._items
end
function t.GetTracked(p1) --[[ GetTracked | Line: 497 ]]
	return p1._tracked
end
function t.Destroy(p1) --[[ Destroy | Line: 504 ]]
	for v1, v2 in p1._bin do
		if typeof(v2) == "Instance" then
			v2:Destroy()

			continue
		end

		if typeof(v2) == "RBXScriptConnection" then
			v2:Disconnect()
		end
	end

	for v3, v4 in p1._trackedConnect do
		v4:Disconnect()
	end

	for v5, v6 in p1._replicaConnect do
		for v7, v8 in v6 do
			v8:Disconnect()
		end
	end

	task.defer(function() --[[ Line: 523 | Upvalues: p1 (copy) ]]
		p1.ItemEntered:Destroy()
		p1.ItemExited:Destroy()
		setmetatable(p1, nil)
		table.clear(p1)
	end)
end
function t.GetQuerySpace(p1) --[[ GetQuerySpace | Line: 532 ]]
	return p1._worldModel
end
function t.CopyToQuerySpace(p1, p2, p3, p4) --[[ CopyToQuerySpace | Line: 539 | Upvalues: copyToQuerySpace (copy) ]]
	assert(p1._queryOptions.InSeperateQuerySpace, "InSeperateQuerySpace is not enabled, cannot call Zone:RegisterToQuerySpace(...)")

	local v1 = table.create(#p2)

	for v2, v3 in p2 do
		copyToQuerySpace(p1, v3, p3, p4, v1)
	end

	return v1
end
function t.RemoveFromQuerySpace(p1, p2) --[[ RemoveFromQuerySpace | Line: 557 | Upvalues: removeFromQuerySpace (copy) ]]
	assert(p1._queryOptions.InSeperateQuerySpace, "InSeperateQuerySpace is not enabled, cannot call Zone:RemoveFromQuerySpace(...)")

	for v1, v2 in p2 do
		removeFromQuerySpace(p1, v2)
	end
end
function t.UseQuerySpaceOf(p1, p2) --[[ UseQuerySpaceOf | Line: 567 ]]
	assert(p1._queryOptions.InSeperateQuerySpace, "InSeperateQuerySpace is not enabled, cannot call Zone:UseQuerySpaceOf(...)")
	assert(p2 ~= nil, "Bad otherZone argument")
	assert(not (not p1._queryOptions.InSeperateQuerySpace and (if p2 == "self" then true else false)), "Cannot use query space of self because zone was not created in a seperate query space.")

	local v3, v4

	if p2 == "self" then
		v3 = p1._worldModel
		v4 = p1._ownQuerySpace or p1._querySpace
	else
		v4 = p2._querySpace
		v3 = p2._worldModel
	end

	if p2 == "self" then
		p1._ownQuerySpace = nil
	else
		p1._ownQuerySpace = p1._querySpace
	end

	p1._querySpace = v4
	p1._worldModel = v3
end
function t.OverwriteQuerySpace(p1, p2) --[[ OverwriteQuerySpace | Line: 599 ]]
	assert(p1._queryOptions.InSeperateQuerySpace, "InSeperateQuerySpace is not enabled, cannot call Zone:OverwriteQuerySpace(...)")
	assert(p2 ~= nil, "Bad otherZone argument")

	local _querySpace = p1._querySpace

	p1:RemoveFromQuerySpace(_querySpace.dynamic.index)
	p1:RemoveFromQuerySpace(_querySpace.static.index)
	p1._worldModel:Destroy()
	p1._querySpace = p2._querySpace
	p1._worldModel = p2._worldModel
end

local function assertQueryOp(p1) --[[ assertQueryOp | Line: 616 ]]
	if not p1 then
		return
	end

	local FireMode = p1.FireMode

	assert(if FireMode == "Both" or (FireMode == "OnExit" or FireMode == "OnEnter") then true else FireMode == "None", "Bad QueryOptions argument. (FireMode not specified)")

	if not p1.ThrottlingEnabled or p1.UpdateInterval then
		return
	end

	error("QueryOptions.UpdateInterval must be specified if QueryOptions.ThrottlingEnabled is true.")
end

local function zone_new(p1, ...) --[[ zone_new | Line: 648 | Upvalues: SimpleSignal (copy), t2 (copy), HttpService (copy), v4 (copy) ]]
	local v1 = if p1 then p1 else {
	FireMode = "Both",
	TrackItemEnabled = false,
	ThrottlingEnabled = false,
	StoreByClass = false,
	AcceptMetadata = false,
	UpdateInterval = 0,
	InSeperateQuerySpace = false,
	Static = false,
	DoBoxQueryForBVHNodes = false
}

	if v1 then
		local FireMode = v1.FireMode

		assert(if FireMode == "Both" or (FireMode == "OnExit" or FireMode == "OnEnter") then true else FireMode == "None", "Bad QueryOptions argument. (FireMode not specified)")

		if v1.ThrottlingEnabled and not v1.UpdateInterval then
			error("QueryOptions.UpdateInterval must be specified if QueryOptions.ThrottlingEnabled is true.")
		end
	end

	local v3 = v1
	local t = { ... }
	local v5 = setmetatable({
		_trackedConnect = {},
		_replicaConnect = {},
		_items = {},
		_storedClasses = {},
		_tracked = {},
		_bin = t,
		_queryOptions = v3,
		_lastUpdate = os.clock(),
		_worldModel = workspace,
		ItemEntered = SimpleSignal.new(),
		ItemExited = SimpleSignal.new()
	}, t2)

	if v3.InSeperateQuerySpace and v3.QuerySpace == nil then
		local WorldModel = Instance.new("WorldModel")

		WorldModel.Name = ("SimpleZone_QuerySpace(%*)"):format((HttpService:GenerateGUID(false)))
		WorldModel.Parent = v4
		table.insert(t, WorldModel)
		v5._worldModel = WorldModel
		v5._querySpace = {
			dynamic = {
				index = {},
				replicas = {}
			},
			static = {
				index = {},
				replicas = {}
			}
		}

		return v5
	end

	if v3.QuerySpace ~= nil then
		assert(if v3.QuerySpace.World == nil then false elseif v3.QuerySpace.Space == nil then false else true, "Missing world/space fields for QuerySpace")
		v5._worldModel = v3.QuerySpace.World
		v5._querySpace = v3.QuerySpace.Space
	end

	return v5
end

local function getBoxFromPart(p1) --[[ getBoxFromPart | Line: 705 | Upvalues: BVH (copy) ]]
	local VoxelSize = BVH.VoxelSize
	local Position = p1.Position
	local Size = p1.Size

	if p1.Size.Magnitude > 500 then
		Position, Size = Vector3.new(Position.X // VoxelSize * VoxelSize, Position.Y // VoxelSize * VoxelSize, Position.Z // VoxelSize * VoxelSize), Vector3.new(Size.X // VoxelSize * VoxelSize, Size.Y // VoxelSize * VoxelSize, Size.Z // VoxelSize * VoxelSize)
	end

	return {
		cframe = p1.CFrame.Rotation + Position,
		size = Size,
		part = p1
	}
end

local function getBoxesFromParts(p1) --[[ getBoxesFromParts | Line: 731 | Upvalues: getBoxFromPart (copy) ]]
	local t = {}

	for v1, v2 in p1 do
		t[#t + 1] = getBoxFromPart(v2)
	end

	return t
end

local function zone_fromPart(p1, p2) --[[ zone_fromPart | Line: 742 | Upvalues: zone_new (copy), copyToQuerySpace (copy), t3 (copy), v5 (copy) ]]
	if p2 then
		local FireMode = p2.FireMode

		assert(if FireMode == "Both" or (FireMode == "OnExit" or FireMode == "OnEnter") then true else FireMode == "None", "Bad QueryOptions argument. (FireMode not specified)")

		if p2.ThrottlingEnabled and not p2.UpdateInterval then
			error("QueryOptions.UpdateInterval must be specified if QueryOptions.ThrottlingEnabled is true.")
		end
	end

	local v2 = if p2 then p2 else {
	FireMode = "Both",
	TrackItemEnabled = false,
	ThrottlingEnabled = false,
	StoreByClass = false,
	AcceptMetadata = false,
	UpdateInterval = 0,
	InSeperateQuerySpace = false,
	Static = false,
	DoBoxQueryForBVHNodes = false
}
	local v3 = zone_new(v2)

	if v2.InSeperateQuerySpace then
		p1 = copyToQuerySpace(v3, p1, v2.Static, t3)
	end

	function v3.Query(p12, p2) --[[ Query | Line: 751 | Upvalues: p1 (ref), v5 (ref) ]]
		local _worldModel = p12._worldModel

		if p1:IsA("Part") then
			return v5(p1.Shape.Name, _worldModel, p1, p2)
		end

		return _worldModel:GetPartsInPart(p1, p2)
	end

	return v3
end

local function zone_fromBox(p1, p2, p3) --[[ zone_fromBox | Line: 764 | Upvalues: zone_new (copy) ]]
	if p3 then
		local FireMode = p3.FireMode

		assert(if FireMode == "Both" or (FireMode == "OnExit" or FireMode == "OnEnter") then true else FireMode == "None", "Bad QueryOptions argument. (FireMode not specified)")

		if p3.ThrottlingEnabled and not p3.UpdateInterval then
			error("QueryOptions.UpdateInterval must be specified if QueryOptions.ThrottlingEnabled is true.")
		end
	end

	local v3 = zone_new(if p3 then p3 else {
	FireMode = "Both",
	TrackItemEnabled = false,
	ThrottlingEnabled = false,
	StoreByClass = false,
	AcceptMetadata = false,
	UpdateInterval = 0,
	InSeperateQuerySpace = false,
	Static = false,
	DoBoxQueryForBVHNodes = false
})

	function v3.Query(p13, p23) --[[ Query | Line: 770 | Upvalues: p1 (copy), p2 (copy) ]]
		return p13._worldModel:GetPartBoundsInBox(p1, p2, p23)
	end

	return v3
end

local function zone_fromBoxes(p1, p2) --[[ zone_fromBoxes | Line: 778 | Upvalues: BVH (copy), zone_new (copy), areAnyItemPointsInBox (copy) ]]
	local v1 = p2

	if v1 then
		local FireMode = v1.FireMode

		assert(if FireMode == "Both" or (FireMode == "OnExit" or FireMode == "OnEnter") then true else FireMode == "None", "Bad QueryOptions argument. (FireMode not specified)")

		if v1.ThrottlingEnabled and not v1.UpdateInterval then
			error("QueryOptions.UpdateInterval must be specified if QueryOptions.ThrottlingEnabled is true.")
		end
	end

	local v4, _ = BVH.createBVH(p1)
	local v5 = zone_new(p2 or {
		FireMode = "Both",
		TrackItemEnabled = false,
		ThrottlingEnabled = false,
		StoreByClass = false,
		AcceptMetadata = false,
		UpdateInterval = 0,
		InSeperateQuerySpace = false,
		Static = false,
		DoBoxQueryForBVHNodes = false
	})

	function v5.Query(p1, p2) --[[ Query | Line: 786 | Upvalues: BVH (ref), v4 (copy), areAnyItemPointsInBox (ref) ]]
		local _queryOptions = p1._queryOptions
		local _querySpace = p1._querySpace
		local _worldModel = p1._worldModel
		local t = {}

		BVH.traverseBVH(v4, function(p12) --[[ Line: 792 | Upvalues: _querySpace (copy), areAnyItemPointsInBox (ref), _worldModel (copy), p2 (copy), p1 (copy), t (copy) ]]
			local v1

			if _querySpace == nil then
				local v2 = _worldModel:GetPartBoundsInBox(p12.cframe, p12.size, p2)

				if #v2 == 0 then
					return false
				end

				if p12.right or p12.left then
					return true
				end

				v1 = v2
			else
				if not areAnyItemPointsInBox(_querySpace.dynamic.replicas, p12.cframe, p12.size) then
					return false
				end

				if p12.right or p12.left then
					return true
				end

				v1 = _worldModel:GetPartBoundsInBox(p12.cframe, p12.size, p2)
			end

			if p1._queryOptions.AcceptMetadata then
				for v4, v5 in v1 do
					table.insert(t, {
						item = v5,
						metadata = {
							box = p12
						}
					})
				end
			else
				table.move(v1, 1, #v1, #t + 1, t)
			end

			return false
		end)

		return t
	end

	return v5
end

local function zone_fromParts(p1, p2) --[[ zone_fromParts | Line: 833 | Upvalues: zone_new (copy), t3 (copy), getBoxesFromParts (copy), BVH (copy), areAnyItemPointsInBox (copy), v5 (copy) ]]
	if p2 then
		local FireMode = p2.FireMode

		assert(if FireMode == "Both" or (FireMode == "OnExit" or FireMode == "OnEnter") then true else FireMode == "None", "Bad QueryOptions argument. (FireMode not specified)")

		if p2.ThrottlingEnabled and not p2.UpdateInterval then
			error("QueryOptions.UpdateInterval must be specified if QueryOptions.ThrottlingEnabled is true.")
		end
	end

	local v2 = if p2 then p2 else {
	FireMode = "Both",
	TrackItemEnabled = false,
	ThrottlingEnabled = false,
	StoreByClass = false,
	AcceptMetadata = false,
	UpdateInterval = 0,
	InSeperateQuerySpace = false,
	Static = false,
	DoBoxQueryForBVHNodes = false
}
	local v3 = zone_new(v2)
	local v7 = BVH.createBVH(if v2.InSeperateQuerySpace then getBoxesFromParts((v3:CopyToQuerySpace(p1, v2.Static, t3))) else getBoxesFromParts(p1))

	function v3.Query(p1, p2) --[[ Query | Line: 868 | Upvalues: BVH (ref), v7 (copy), areAnyItemPointsInBox (ref), v5 (ref) ]]
		local _querySpace = p1._querySpace
		local _queryOptions = p1._queryOptions
		local _worldModel = p1._worldModel
		local t = {}
		local v1 = if _querySpace == nil then false else _queryOptions.Static and _querySpace.static or _querySpace.dynamic

		BVH.traverseBVH(v7, function(p1) --[[ Line: 876 | Upvalues: _querySpace (copy), areAnyItemPointsInBox (ref), _worldModel (copy), p2 (copy), v5 (ref), _queryOptions (copy), v1 (copy), t (copy) ]]
			local v12 = nil

			if _querySpace then
				if not areAnyItemPointsInBox(_querySpace.dynamic.replicas, p1.cframe, p1.size) then
					return false
				end

				if not p1.part then
					return true
				end
			else
				local v2 = _worldModel:GetPartBoundsInBox(p1.cframe, p1.size, p2)

				if p1.part then
					v12 = v2
				else
					return #v2 > 0
				end
			end

			local part = p1.part
			local v4 = if part:IsA("Part") then if part.Shape == Enum.PartType.Block and v12 then v12 else v5(part.Shape.Name, _worldModel, part, p2) else _worldModel:GetPartsInPart(part, p2)

			if _queryOptions.AcceptMetadata then
				local part2 = p1.part

				if _queryOptions.InSeperateQuerySpace then
					part2 = v1.index[table.find(v1.replicas, p1.part)]
				end

				for v8, v9 in v4 do
					table.insert(t, {
						item = v9,
						metadata = {
							part = part2
						}
					})
				end
			else
				table.move(v4, 1, #v4, #t + 1, t)
			end

			return false
		end)

		return t
	end

	return v3
end

local function zone_fromPartsLPO() --[[ zone_fromPartsLPO | Line: 929 ]]
	error("Zone.fromPartsLPO() is deprecated, it should not be used for new work.")
end

local function zone_fromPartsUpdatable() --[[ zone_fromPartsUpdatable | Line: 933 ]]
	error("Zone.fromPartsUpdatable() is deprecated, it should not be used for new work.")
end

local function zone_fromPartParallel(p1, p2) --[[ zone_fromPartParallel | Line: 938 | Upvalues: v3 (copy), SIMPLEZONE_ZONE_ACTORS (copy), zone_new (copy), copyToQuerySpace (copy), t3 (copy) ]]
	local v1 = p2

	if v1 then
		local FireMode = v1.FireMode

		assert(if FireMode == "Both" or (FireMode == "OnExit" or FireMode == "OnEnter") then true else FireMode == "None", "Bad QueryOptions argument. (FireMode not specified)")

		if v1.ThrottlingEnabled and not v1.UpdateInterval then
			error("QueryOptions.UpdateInterval must be specified if QueryOptions.ThrottlingEnabled is true.")
		end
	end

	local v32 = p2 or {
		FireMode = "Both",
		TrackItemEnabled = false,
		ThrottlingEnabled = false,
		StoreByClass = false,
		AcceptMetadata = false,
		UpdateInterval = 0,
		InSeperateQuerySpace = false,
		Static = false,
		DoBoxQueryForBVHNodes = false
	}
	local v4 = v3:Clone()

	v4.Parent = SIMPLEZONE_ZONE_ACTORS

	local Result = v4.Result
	local v5 = zone_new(v32, v4)

	if v32.InSeperateQuerySpace then
		p1 = copyToQuerySpace(v5, p1, v32.Static, t3)
	end

	function v5.Query(p12, p2) --[[ Query | Line: 952 | Upvalues: v4 (copy), p1 (ref), Result (copy) ]]
		task.defer(v4.SendMessage, v4, "GetPartsInPart", p12._worldModel, p2, p1)

		return Result.Event:Wait()
	end

	return v5
end

local function zone_fromCustom(p1, p2) --[[ zone_fromCustom | Line: 962 | Upvalues: zone_new (copy) ]]
	assert(if p1 == nil then false else true, "Bad queryFn argument.")

	if p2 then
		local FireMode = p2.FireMode

		assert(if FireMode == "Both" or (FireMode == "OnExit" or FireMode == "OnEnter") then true else FireMode == "None", "Bad QueryOptions argument. (FireMode not specified)")

		if p2.ThrottlingEnabled and not p2.UpdateInterval then
			error("QueryOptions.UpdateInterval must be specified if QueryOptions.ThrottlingEnabled is true.")
		end
	end

	local v4 = zone_new(if p2 then p2 else {
	FireMode = "Both",
	TrackItemEnabled = false,
	ThrottlingEnabled = false,
	StoreByClass = false,
	AcceptMetadata = false,
	UpdateInterval = 0,
	InSeperateQuerySpace = false,
	Static = false,
	DoBoxQueryForBVHNodes = false
})

	v4.Query = p1

	return v4
end

local function f6(p1, p2, p3) --[[ Line: 979 | Upvalues: zone_fromParts (copy), zone_fromBoxes (copy), zone_new (copy), zone_fromPart (copy) ]]
	local v1

	if type(p1) == "table" then
		local v2 = #p1

		v1 = if v2 == 0 then false elseif next(p1, v2) == nil then true else false
	else
		v1 = false
	end

	if v1 then
		if typeof(p1[1]) == "Instance" and p1[1]:IsA("BasePart") then
			return zone_fromParts(p1, p2)
		end

		if typeof(p1[1]) == "table" then
			return zone_fromBoxes(p1, p2)
		end

		error("Unable to find an overload.")
	end

	if typeof(p1) == "CFrame" and typeof(p2) == "Vector3" then
		if p3 then
			local FireMode = p3.FireMode

			assert(if FireMode == "Both" or (FireMode == "OnExit" or FireMode == "OnEnter") then true else FireMode == "None", "Bad QueryOptions argument. (FireMode not specified)")

			if p3.ThrottlingEnabled and not p3.UpdateInterval then
				error("QueryOptions.UpdateInterval must be specified if QueryOptions.ThrottlingEnabled is true.")
			end
		end

		local v6 = p3
		local v8 = zone_new(if v6 then v6 else {
	FireMode = "Both",
	TrackItemEnabled = false,
	ThrottlingEnabled = false,
	StoreByClass = false,
	AcceptMetadata = false,
	UpdateInterval = 0,
	InSeperateQuerySpace = false,
	Static = false,
	DoBoxQueryForBVHNodes = false
})

		function v8.Query(p13, p23) --[[ Query | Line: 770 | Upvalues: p1 (copy), p2 (copy) ]]
			return p13._worldModel:GetPartBoundsInBox(p1, p2, p23)
		end

		return v8
	end

	if typeof(p1) == "Instance" and p1:IsA("BasePart") then
		return zone_fromPart(p1, p2)
	end

	error("Unable to find an overload.")
end

if script:GetAttribute("ClientOnlyDetectLocalPlayer") and RunService:IsClient() then
	PlayerLookup.onPlayerAdded(Players.LocalPlayer)
else
	PlayerLookup.start()
end

return table.freeze({
	new = f6,
	fromBox = zone_fromBox,
	fromPart = zone_fromPart,
	fromParts = zone_fromParts,
	fromBoxes = zone_fromBoxes,
	fromCustom = zone_fromCustom,
	fromPartParallel = zone_fromPartParallel,
	fromPartsUpdatable = zone_fromPartsUpdatable,
	fromPartsLPO = zone_fromPartsLPO,
	QueryOptions = {
		new = queryop_new
	},
	newInternal = zone_new,
	searchFor = SearchFor,
	BVH = BVH,
	ZoneClass = t,
	PlayerLookup = PlayerLookup,
	PartQueryJump = v5
})