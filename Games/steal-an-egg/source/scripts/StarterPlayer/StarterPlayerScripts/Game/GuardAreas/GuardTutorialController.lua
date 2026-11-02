-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local GuardTutorialPresentationComponent = require(ReplicatedStorage.Library.Client.GuardTutorialPresentationComponent)
local GuardTutorialSteps = require(ReplicatedStorage.Directory.GuardTutorialSteps)
local GuardTutorial = require(ReplicatedStorage.Library.Types.GuardTutorial)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local MilestoneAdapter = require(script.MilestoneAdapter)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

require(script.Types.Interface)

local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local EquipEgg = require(script.Steps.EquipEgg)
local ExpandPen = require(script.Steps.ExpandPen)
local HatchEgg = require(script.Steps.HatchEgg)
local HeadToPen = require(script.Steps.HeadToPen)
local PlaceEgg = require(script.Steps.PlaceEgg)
local PlacePet = require(script.Steps.PlacePet)
local StealEgg = require(script.Steps.StealEgg)
local TreadmillIntro = require(script.Steps.TreadmillIntro)
local t = {}

t.__index = t
t.__class = "GuardTutorialController"

local GuardTutorial2 = Constants.NETWORK_MAP.GuardTutorial
local t2 = {
	[StealEgg.StepId] = StealEgg,
	[HeadToPen.StepId] = HeadToPen,
	[EquipEgg.StepId] = EquipEgg,
	[PlaceEgg.StepId] = PlaceEgg,
	[HatchEgg.StepId] = HatchEgg,
	[PlacePet.StepId] = PlacePet,
	[ExpandPen.StepId] = ExpandPen,
	[TreadmillIntro.StepId] = TreadmillIntro
}
local v1 = Log.new()

function t.new() --[[ new | Line: 71 | Upvalues: t (copy), MilestoneAdapter (copy), GuardTutorial (copy), GuardTutorialPresentationComponent (copy), Trove (copy) ]]
	local v2 = setmetatable({}, t)

	v2._activeStepCleanup = nil
	v2._activeStepId = nil
	v2._adapter = MilestoneAdapter.new()
	v2._currentProgress = GuardTutorial.CloneProgress(GuardTutorial.DEFAULT_PROGRESS)
	v2._presentation = GuardTutorialPresentationComponent.new()
	v2._refreshGeneration = 0
	v2._retryScheduled = false
	v2._started = false
	v2._trove = Trove.new()

	return v2
end
function t._clearActiveStep(p1) --[[ _clearActiveStep | Line: 91 ]]
	local _activeStepCleanup = p1._activeStepCleanup

	if _activeStepCleanup ~= nil then
		p1._activeStepCleanup = nil
		_activeStepCleanup()
	end

	p1._presentation:ClearAll()
	p1._activeStepId = nil
end
function t._readStoredProgress(p1) --[[ _readStoredProgress | Line: 101 | Upvalues: Save (copy), GuardTutorial (copy) ]]
	local v1 = Save.Get()

	if v1 == nil then
		return GuardTutorial.CloneProgress(GuardTutorial.DEFAULT_PROGRESS)
	end

	return GuardTutorial.NormalizeProgress(v1.GuardTutorialProgress)
end
function t._syncProgress(p1, p2) --[[ _syncProgress | Line: 110 | Upvalues: wcall (copy), Network (copy), GuardTutorial2 (copy), GuardTutorial (copy) ]]
	local v1, v2, v3 = wcall(Network.Invoke, GuardTutorial2.REQUEST_SYNC_PROGRESS, p2)

	if not v1 then
		return nil
	end

	if v2 == true then
		local v4, v5 = GuardTutorial.SchemaValidation.Progress(v3)

		assert(v4, v5)

		return GuardTutorial.NormalizeProgress(v3)
	end

	return nil
end
function t._queueSyncRetry(p1) --[[ _queueSyncRetry | Line: 127 | Upvalues: v1 (copy) ]]
	if not p1._retryScheduled and p1._started then
		v1:AtTrace():Log("[GuardTutorialController] Queueing tutorial progress sync retry")
		p1._retryScheduled = true
		task.delay(0.5, function() --[[ Line: 134 | Upvalues: p1 (copy) ]]
			if p1._started then
				p1._retryScheduled = false
				p1:RefreshProgress()
			else
				p1._retryScheduled = false
			end
		end)
	end
end
function t._resolveNextProgress(p1, p2) --[[ _resolveNextProgress | Line: 145 | Upvalues: GuardTutorial (copy), GuardTutorialSteps (copy), t2 (copy) ]]
	if p2.Completed then
		return GuardTutorial.CloneProgress(p2)
	end

	local v1 = GuardTutorialSteps.GetOrderedStepIds()
	local v2

	if p2.CurrentStepId == nil then
		v2 = 1
	else
		local v3 = GuardTutorialSteps.GetIndex(p2.CurrentStepId)

		assert(v3 ~= nil, (("Unknown guard tutorial step id: %*"):format(p2.CurrentStepId)))
		v2 = v3
	end

	for i = v2, #v1 do
		local v6 = v1[i]
		local v7 = t2[v6]

		assert(if v7 == nil then false else true, (("Missing guard tutorial step module for %*"):format(v6)))

		if not v7.IsSatisfied(p1._adapter) then
			return {
				Completed = false,
				CurrentStepId = v6
			}
		end
	end

	return {
		Completed = true,
		CurrentStepId = nil
	}
end
function t._bindCurrentStep(p1) --[[ _bindCurrentStep | Line: 179 | Upvalues: t2 (copy) ]]
	local CurrentStepId = p1._currentProgress.CurrentStepId

	if p1._currentProgress.Completed or CurrentStepId == nil then
		p1:_clearActiveStep()

		return
	end

	if p1._activeStepId == CurrentStepId and p1._activeStepCleanup ~= nil then
		return
	end

	p1:_clearActiveStep()

	local v1 = t2[CurrentStepId]

	assert(v1 ~= nil, (("Missing guard tutorial step module for %*"):format(CurrentStepId)))
	p1._activeStepId = CurrentStepId

	local v4 = if v1.Present == nil then nil else v1.Present(p1._presentation, p1._adapter)
	local v5 = v1.Bind(p1._adapter, function() --[[ Line: 201 | Upvalues: p1 (copy), CurrentStepId (copy) ]]
		if not p1._currentProgress.Completed and p1._currentProgress.CurrentStepId == CurrentStepId then
			p1:RefreshProgress()
		end
	end)

	function p1._activeStepCleanup() --[[ Line: 208 | Upvalues: v5 (copy), v4 (ref), p1 (copy) ]]
		v5()

		if v4 ~= nil then
			v4()
		end

		p1._presentation:ClearAll()
	end
end
function t._startAfterReadiness(p1) --[[ _startAfterReadiness | Line: 217 ]]
	local v1 = p1:_readStoredProgress()

	p1._currentProgress = v1

	if v1.Completed then
		p1:_clearActiveStep()
	else
		p1:RefreshProgress()
	end
end
function t.Start(p1) --[[ Start | Line: 233 | Upvalues: Save (copy) ]]
	if p1._started then
		return
	end

	p1._started = true
	p1._trove:Add(p1._adapter.Changed:Connect(function() --[[ Line: 240 | Upvalues: p1 (copy) ]]
		p1:RefreshProgress()
	end))
	p1._trove:Add(Save.GetStatChangedSignal("GuardTutorialProgress"):Connect(function() --[[ Line: 243 | Upvalues: p1 (copy) ]]
		p1:RefreshProgress()
	end))

	if Save.IsLocalDataLoaded() then
		p1:_startAfterReadiness()

		return
	end

	local v1 = Save.LoadedStats:Connect(function() --[[ Line: 252 | Upvalues: p1 (copy) ]]
		p1:_startAfterReadiness()
	end)

	p1._trove:Add(v1)

	if not Save.IsLocalDataLoaded() then
		return
	end

	v1:Disconnect()
	p1:_startAfterReadiness()
end
function t.RefreshProgress(p1) --[[ RefreshProgress | Line: 263 | Upvalues: Save (copy) ]]
	if not (p1._started and Save.IsLocalDataLoaded()) then
		return
	end

	p1._refreshGeneration = p1._refreshGeneration + 1

	local _refreshGeneration = p1._refreshGeneration
	local v1 = p1:_readStoredProgress()
	local v2 = p1:_resolveNextProgress(v1)
	local v3 = if v1.Completed == v2.Completed then if v1.CurrentStepId == v2.CurrentStepId then false else true else true

	p1._currentProgress = v2
	p1:_bindCurrentStep()

	if not v3 then
		return
	end

	local v4 = p1:_syncProgress(v2)

	if not p1._started or _refreshGeneration ~= p1._refreshGeneration then
		return
	end

	if v4 ~= nil then
		p1._currentProgress = v4
		p1:_bindCurrentStep()

		return
	end

	p1:_queueSyncRetry()
end
function t.Destroy(p1) --[[ Destroy | Line: 292 ]]
	p1._started = false
	p1:_clearActiveStep()
	p1._trove:Destroy()
	p1._presentation:Destroy()
	p1._adapter:Destroy()
end

return t