-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)

require(script.Parent.Types)

local PlacedEggRenderer = require(ReplicatedStorage.Library.Client.Eggs.PlacedEggRenderer)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local v1 = Log.new()
local t = {}

t.__index = t
t.__class = "AssetMovementBatch"
assert(workspace.__DEBRIS:IsA("Folder"), "Workspace.__DEBRIS must be a Folder")

local __OBJECTS = workspace.__OBJECTS

assert(__OBJECTS:IsA("Folder"), "Workspace.__OBJECTS must be a Folder")

local Areas = __OBJECTS.Areas

assert(Areas:IsA("Folder"), "Workspace.__OBJECTS.Areas must be a Folder")

local Ground = Areas.Ground

assert(Ground:IsA("BasePart"), "Workspace.__OBJECTS.Areas.Ground must be a BasePart")
function t.new() --[[ new | Line: 58 | Upvalues: t (copy), Trove (copy), v1 (copy) ]]
	local v2 = setmetatable({}, t)

	v2._trove = Trove.new()
	v2._entries = {}
	v2._orderedModels = {}
	v2._partsBuffer = {}
	v2._cframeBuffer = {}
	v2._foreignEntryCount = 0
	v2._foreignPresentationSuppressed = false
	v2._foreignPresentationForcedSuppressed = false
	v2:_init()
	v1:AtDebug():Log("Created asset movement batch")

	return v2
end
function t._createGroundingRaycastParams(p1) --[[ _createGroundingRaycastParams | Line: 80 | Upvalues: PlacedEggRenderer (copy), Ground (copy) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Include
	v1.FilterDescendantsInstances = { PlacedEggRenderer.GetRenderFolder(), Ground, p1 }
	v1.IgnoreWater = true

	return v1
end
function t._groundCFrame(p1, p2, p3) --[[ _groundCFrame | Line: 92 ]]
	local Position = p2.Position
	local v1 = workspace:Raycast(Position + Vector3.new(0, 64, 0), Vector3.new(0, -2000, 0), p3)

	if v1 == nil then
		return nil
	end

	return CFrame.new((Vector3.new(Position.X, v1.Position.Y - p1, Position.Z))) * p2.Rotation
end
function t._groundTargetCFrame(p1) --[[ _groundTargetCFrame | Line: 109 | Upvalues: t (copy) ]]
	local v1 = t._groundCFrame(p1.BottomLocalY, p1.TargetCFrame, p1.GroundingRaycastParams)

	if v1 == nil then
		local TargetCFrame = p1.TargetCFrame
		local Position = TargetCFrame.Position

		return CFrame.new(Position.X, p1.SimulationCFrame.Position.Y, Position.Z) * TargetCFrame.Rotation
	end

	return v1
end
function t._movementAlpha(p1) --[[ _movementAlpha | Line: 122 ]]
	return math.clamp(p1 * 8, 0, 1)
end
function t._airborneMovementAlpha(p1) --[[ _airborneMovementAlpha | Line: 126 ]]
	return math.clamp(p1 * 14, 0, 0.45)
end
function t._isPresentationEnabled(p1, p2) --[[ _isPresentationEnabled | Line: 130 ]]
	return p1.IsLocalOwner or not p2
end
function t._advanceSuppressedSimulation(p1) --[[ _advanceSuppressedSimulation | Line: 137 ]]
	local TargetCFrame = p1.TargetCFrame
	local Position = TargetCFrame.Position

	p1.SimulationCFrame = CFrame.new(Position.X, p1.SimulationCFrame.Position.Y, Position.Z) * TargetCFrame.Rotation
end
function t._forgetEntry(p1, p2) --[[ _forgetEntry | Line: 144 ]]
	local v1 = p1._entries[p2]

	if v1 == nil then
		return
	end

	if not v1.IsLocalOwner then
		assert(p1._foreignEntryCount > 0, "Foreign movement entry count cannot underflow")
		p1._foreignEntryCount = p1._foreignEntryCount - 1
	end

	p1._entries[p2] = nil
end
function t._removeMissingModels(p1) --[[ _removeMissingModels | Line: 155 ]]
	for i = #p1._orderedModels, 1, -1 do
		local v1 = p1._orderedModels[i]

		if p1._entries[v1] == nil or v1.Parent == nil then
			p1:_forgetEntry(v1)
			table.remove(p1._orderedModels, i)
		end
	end
end
function t._flush(p1, p2, p3) --[[ _flush | Line: 167 | Upvalues: t (copy) ]]
	table.clear(p1._partsBuffer)
	table.clear(p1._cframeBuffer)

	for i, v in ipairs(p1._orderedModels) do
		local v1 = p1._entries[v]

		if v1 ~= nil and (v.Parent ~= nil and t._isPresentationEnabled(v1, p3)) then
			local v2 = t._groundTargetCFrame(v1)

			v1.SimulationCFrame = v2

			local v3 = if v1.GroundingEnabled then v2 else v1.TargetCFrame
			local v4 = if v1.GroundingEnabled then t._movementAlpha(p2) else t._airborneMovementAlpha(p2)

			if v1.CatchUpRemaining > 0 then
				local v6 = math.clamp(p2 / v1.CatchUpRemaining, 0, 1)

				v1.CatchUpRemaining = math.max(v1.CatchUpRemaining - p2, 0)
				v4 = v6
			end

			local v8 = if v1.PresentationFrozen then v1.CurrentCFrame else v1.CurrentCFrame:Lerp(v3, v4)
			local v9 = v8 * v1.PresentationOffset
			local v10 = v:GetPivot()

			v1.CurrentCFrame = v8

			for i2, v5 in ipairs(v1.VisibleParts) do
				if v5.Parent ~= nil then
					table.insert(p1._partsBuffer, v5)
					table.insert(p1._cframeBuffer, v9 * v10:ToObjectSpace(v5.CFrame))
				end
			end
		end
	end

	if not (#p1._partsBuffer > 0) then
		return
	end

	workspace:BulkMoveTo(p1._partsBuffer, p1._cframeBuffer, Enum.BulkMoveMode.FireCFrameChanged)
end
function t._step(p1, p2) --[[ _step | Line: 213 | Upvalues: t (copy) ]]
	p1:_removeMissingModels()

	local v1 = p1._foreignPresentationForcedSuppressed or (if p1._foreignEntryCount >= 30 then true else false)
	local v2 = p1._foreignPresentationSuppressed and not v1

	p1._foreignPresentationSuppressed = v1

	for i, v in ipairs(p1._orderedModels) do
		local v3 = p1._entries[v]

		if v3 ~= nil and v.Parent ~= nil then
			v3.Step(p2, not v3.IsLocalOwner and v1)

			if not v3.IsLocalOwner then
				if v1 then
					t._advanceSuppressedSimulation(v3)

					continue
				end

				if v2 then
					v3.CatchUpRemaining = math.max(v3.CatchUpRemaining, 0.25)
				end
			end
		end
	end

	p1:_flush(p2, v1)
end
function t.Add(p1, p2, p3, p4, p5, p6, p7, p8) --[[ Add | Line: 241 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Model(p2)
	Asserts.array.custom(p3, Asserts.BasePart)
	Asserts.CFrame(p4)
	Asserts.number(p5)
	Asserts.BasePart(p6)
	Asserts.boolean(p7)

	local v1 = if p1._entries[p2] == nil then true else false

	assert(v1, (("Asset model %* is already registered in the movement batch"):format(p2.Name)))

	local v3 = t._createGroundingRaycastParams(p6)

	p1._entries[p2] = {
		GroundingEnabled = true,
		PresentationFrozen = false,
		CatchUpRemaining = 0,
		Model = p2,
		VisibleParts = p3,
		AssetArea = p6,
		GroundingRaycastParams = v3,
		IsLocalOwner = p7,
		BottomLocalY = p5,
		TargetCFrame = p4,
		CurrentCFrame = p4,
		SimulationCFrame = t._groundCFrame(p5, p4, v3) or p4,
		Step = p8,
		PresentationOffset = CFrame.identity
	}

	if not p7 then
		p1._foreignEntryCount = p1._foreignEntryCount + 1
	end

	table.insert(p1._orderedModels, p2)
end
function t.GetSimulationCFrame(p1, p2) --[[ GetSimulationCFrame | Line: 285 | Upvalues: Asserts (copy) ]]
	Asserts.Model(p2)

	local v1 = p1._entries[p2]

	assert(v1 ~= nil, (("Asset model %* is not registered in the movement batch"):format(p2.Name)))

	return v1.SimulationCFrame
end
function t.ResolveGroundedCFrame(p1, p2) --[[ ResolveGroundedCFrame | Line: 294 | Upvalues: Asserts (copy), BBFromModelVisibleOnly (copy), PlacedEggRenderer (copy), Ground (copy), PlotCmds (copy), t (copy) ]]
	Asserts.Model(p1)
	Asserts.CFrame(p2)

	local v1, v2 = BBFromModelVisibleOnly(p1)
	local v3 = p1:GetPivot():PointToObjectSpace(v1.Position).Y - v2.Y * 0.5
	local t2 = { PlacedEggRenderer.GetRenderFolder(), Ground }
	local v4 = PlotCmds.GetPlotData()

	if v4 and v4.PetArea then
		table.insert(t2, v4.PetArea)
	end

	local v5 = RaycastParams.new()

	v5.FilterType = Enum.RaycastFilterType.Include
	v5.FilterDescendantsInstances = t2
	v5.IgnoreWater = true

	return t._groundCFrame(v3, p2, v5) or p2
end
function t.SetAssetArea(p1, p2, p3) --[[ SetAssetArea | Line: 317 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Model(p2)
	Asserts.BasePart(p3)

	local v1 = p1._entries[p2]

	assert(v1 ~= nil, (("Asset model %* is not registered in the movement batch"):format(p2.Name)))

	if v1.AssetArea ~= p3 then
		v1.AssetArea = p3
		v1.GroundingRaycastParams = t._createGroundingRaycastParams(p3)
	end
end
function t.SetTarget(p1, p2, p3) --[[ SetTarget | Line: 331 | Upvalues: Asserts (copy) ]]
	Asserts.Model(p2)
	Asserts.CFrame(p3)

	local v1 = p1._entries[p2]

	assert(v1 ~= nil, (("Asset model %* is not registered in the movement batch"):format(p2.Name)))
	v1.TargetCFrame = p3
end
function t.SetGroundingEnabled(p1, p2, p3) --[[ SetGroundingEnabled | Line: 341 | Upvalues: Asserts (copy) ]]
	Asserts.Model(p2)
	Asserts.boolean(p3)

	local v1 = p1._entries[p2]

	assert(v1 ~= nil, (("Asset model %* is not registered in the movement batch"):format(p2.Name)))
	v1.GroundingEnabled = p3
end
function t.SetPresentationFrozen(p1, p2, p3, p4) --[[ SetPresentationFrozen | Line: 351 | Upvalues: Asserts (copy) ]]
	Asserts.Model(p2)
	Asserts.boolean(p3)
	Asserts.optional.number(p4)

	local v1 = p1._entries[p2]

	assert(v1 ~= nil, (("Asset model %* is not registered in the movement batch"):format(p2.Name)))
	v1.PresentationFrozen = p3
	v1.CatchUpRemaining = if p3 then 0 else math.max(p4 or 0, 0)
end
function t.SetPresentationOffset(p1, p2, p3) --[[ SetPresentationOffset | Line: 367 | Upvalues: Asserts (copy) ]]
	Asserts.Model(p2)
	Asserts.CFrame(p3)

	local v1 = p1._entries[p2]

	assert(v1 ~= nil, (("Asset model %* is not registered in the movement batch"):format(p2.Name)))
	v1.PresentationOffset = p3
end
function t.SetForeignPresentationSuppressed(p1, p2) --[[ SetForeignPresentationSuppressed | Line: 376 | Upvalues: Asserts (copy) ]]
	Asserts.boolean(p2)
	p1._foreignPresentationForcedSuppressed = p2
end
function t.Remove(p1, p2) --[[ Remove | Line: 381 | Upvalues: Asserts (copy) ]]
	Asserts.Model(p2)
	p1:_forgetEntry(p2)

	for i = #p1._orderedModels, 1, -1 do
		if p1._orderedModels[i] == p2 then
			table.remove(p1._orderedModels, i)

			return
		end
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 393 ]]
	p1._trove:Destroy()
	table.clear(p1._entries)
	table.clear(p1._orderedModels)
	table.clear(p1._partsBuffer)
	table.clear(p1._cframeBuffer)
	p1._foreignEntryCount = 0
	p1._foreignPresentationSuppressed = false
	p1._foreignPresentationForcedSuppressed = false
end
function t._init(p1) --[[ _init | Line: 408 | Upvalues: RunService (copy) ]]
	p1._trove:Add(RunService.PreRender:Connect(function(p12) --[[ Line: 409 | Upvalues: p1 (copy) ]]
		p1:_step(p12)
	end))
end

return t