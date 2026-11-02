-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Interface = require(script.Types.Interface)
local FuncWrapper = require(ReplicatedStorage.Library.Modules.FuncWrapper)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new():LimitUnderLevel("Warning")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local TableUtil = require(ReplicatedStorage.Library.Modules.Packages.TableUtil)
local MediumArrow = ReplicatedStorage.Assets.Models.Arrows.MediumArrow
local __DEBRIS = workspace:WaitForChild("__DEBRIS")
local X = MediumArrow:WaitForChild("Meshes_arrow_arrow_outline").Size.X
local v2 = X / 1.5
local v3 = CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966)
local t2 = {
	Amplitude = 4,
	Radius = 4,
	Blink = false,
	Highlight = false,
	RotationSpeed = 0,
	CleanupOnPartDestroyed = false,
	OscillationSpeed = 3.75,
	BlinkFrequency = 0.3,
	OriginOffset = Vector3.new(0, 0, 0),
	TargetOffset = Vector3.new(0, 0, 0),
	ProximityThreshold = X * 1.5,
	Color = Color3.fromRGB(255, 255, 255)
}
local v4 = t.optional(t.union(t.instanceIsA("BasePart"), t.Vector3))
local t3 = {}
local t4 = {}

t4.__index = t4
t4.__class = "ArrowPointer3D"
t4.__types = Interface
t4.__constants = {
	ARROW_MID_OFFSET = v2,
	ARROW_SIZE = X,
	DEFAULT_CONFIG = t2
}
function t4.new(p1, p2, p3) --[[ new | Line: 89 | Upvalues: Interface (copy), v4 (copy), TableUtil (copy), t2 (copy), t4 (copy), FuncWrapper (copy), Trove (copy), MediumArrow (copy), __DEBRIS (copy) ]]
	assert(Interface.OptionalConfig(p3))
	assert(v4(p1))
	assert(v4(p2))

	local v42 = TableUtil.ShallowReconcile(if p3 then p3 else {}, t2)
	local v6 = setmetatable({}, t4)

	v6.Config = v42
	v6._funcWrapper = FuncWrapper.CreateWrapper(v6)
	v6._trove = Trove.new()
	v6._trackedPartTroves = {}
	v6._trackedOrigin = p2
	v6._target = p1
	v6._arrowModel = v6._trove:Clone(MediumArrow)
	v6._arrowParent = __DEBRIS
	v6._arrowModel.main.Color = v42.Color
	v6._timeElapsed = 0
	v6._started = false
	v6._active = true
	v6._lastOrigin = nil
	v6._lastTarget = nil
	v6:_init()

	return v6
end

local function getPosition(p1, p2) --[[ getPosition | Line: 126 ]]
	return (typeof(p1) == "Instance" and p1.Position or p1) + p2
end

local function isValid(p1) --[[ isValid | Line: 131 ]]
	if not p1 then
		return false
	end

	if typeof(p1) == "Vector3" then
		return true
	end

	return p1.Parent ~= nil
end

function t4._onAncestryChanged(p1, p2, p3) --[[ _onAncestryChanged | Line: 142 | Upvalues: v1 (copy) ]]
	v1:AtTrace():Log("Ancestry changed of one of the tracked parts:", p3)

	if p3 then
		return p1:Start()
	end

	return p1:Stop()
end
function t4._update(p1, p2) --[[ _update | Line: 151 | Upvalues: v2 (copy), v3 (copy) ]]
	p1._timeElapsed = p1._timeElapsed + p2

	if not p1:AreTrackedPartsValid() then
		return
	end

	local _target = p1._target
	local v22 = (typeof(_target) == "Instance" and _target.Position or _target) + p1.Config.TargetOffset
	local _trackedOrigin = p1._trackedOrigin
	local v4 = (typeof(_trackedOrigin) == "Instance" and _trackedOrigin.Position or _trackedOrigin) + p1.Config.OriginOffset
	local v6 = p1.Config.Amplitude * math.sin(p1._timeElapsed * p1.Config.OscillationSpeed)
	local v7 = math.fmod(p1._timeElapsed, p1.Config.OscillationSpeed) < p1.Config.BlinkFrequency
	local v10 = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), p1._timeElapsed * p1.Config.RotationSpeed)
	local _arrowModel = p1._arrowModel

	if p1.Config.Blink then
		_arrowModel.main.Color = v7 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255)
	else
		_arrowModel.main.Color = p1.Config.Color
	end

	if (v4 - v22).Magnitude < p1.Config.ProximityThreshold then
		p1._arrowModel.Parent = nil

		return
	end

	if not p1._arrowModel.Parent then
		p1._arrowModel.Parent = p1._arrowParent
	end

	p1._arrowModel:PivotTo(CFrame.new(v4 + (v22 - v4).Unit * (p1.Config.Radius + v6 + v2), v22) * v3 * v10)
end
function t4._changePart(p1, p2, p3) --[[ _changePart | Line: 195 | Upvalues: Asserts (copy), Trove (copy) ]]
	Asserts.BasePart(p2)
	assert(Trove.is(p3), "Invalid trove object provided, cannot change target")
	p3:Clean()

	if p1.Config.CleanupOnPartDestroyed then
		p3:Connect(p2.Destroying, p1._funcWrapper(p1.Destroy))
	end

	p3:Connect(p2.AncestryChanged, p1._funcWrapper(p1._onAncestryChanged))
end
function t4.AreTrackedPartsValid(p1) --[[ AreTrackedPartsValid | Line: 208 ]]
	local _target = p1._target
	local v1 = if _target then if typeof(_target) == "Vector3" then true else _target.Parent ~= nil else false

	if v1 then
		local _trackedOrigin = p1._trackedOrigin

		if not _trackedOrigin then
			return false
		end

		if typeof(_trackedOrigin) == "Vector3" then
			v1 = true
		else
			return _trackedOrigin.Parent ~= nil
		end
	end

	return v1
end
function t4.Start(p1) --[[ Start | Line: 212 | Upvalues: t3 (copy) ]]
	if p1._started then
		return false
	end

	assert(p1:AreTrackedPartsValid(), "Attempt to start without the tracked part, or its parented to nil")
	p1._started = true
	p1._arrowModel.Parent = p1._arrowParent
	table.insert(t3, p1)

	return true
end
function t4.Stop(p1) --[[ Stop | Line: 226 | Upvalues: t3 (copy) ]]
	if p1._started then
		table.remove(t3, table.find(t3, p1))
		p1._started = false
		p1._arrowModel.Parent = nil

		return true
	end

	return false
end
function t4.ChangeOrigin(p1, p2) --[[ ChangeOrigin | Line: 238 | Upvalues: v1 (copy) ]]
	if typeof(p2) == "Vector3" then
		p1._trackedOrigin = p2
	else
		if p2 == p1._lastOrigin then
			return
		end

		p1._trackedPartTroves.Origin = p1._trackedPartTroves.Origin or p1._trove:Extend()
		p1:_changePart(p2, p1._trackedPartTroves.Origin)
		p1._trackedOrigin = p2
		p1._lastOrigin = p2
	end

	v1:AtTrace():Log("Tracked origin updated, origin:", p2)
end
function t4.ChangeTarget(p1, p2) --[[ ChangeTarget | Line: 256 | Upvalues: v1 (copy) ]]
	if typeof(p2) == "Vector3" then
		p1._target = p2
	else
		if p2 ~= p1._lastTarget then
			return
		end

		p1._trackedPartTroves.Target = p1._trackedPartTroves.Target or p1._trove:Extend()
		p1:_changePart(p2, p1._trackedPartTroves.Target)
		p1._target = p2
		p1._lastTarget = p2
	end

	v1:AtTrace():Log("Tracked target updated, target:", p2)
end
function t4.Destroy(p1) --[[ Destroy | Line: 274 ]]
	p1:Stop()
	p1._trove:Destroy()
	table.clear(p1)
	setmetatable(p1, nil)
end
function t4._init(p1) --[[ _init | Line: 286 ]]
	if p1._trackedOrigin and typeof(p1._trackedOrigin) ~= "Vector3" then
		p1:ChangeOrigin(p1._trackedOrigin)
	end

	if p1._target and typeof(p1._target) ~= "Vector3" then
		p1:ChangeTarget(p1._target)
	end

	return p1
end
RunService.RenderStepped:Connect(function(p1) --[[ Line: 298 | Upvalues: t3 (copy), v1 (copy) ]]
	for i = #t3, 1, -1 do
		local v12 = t3[i]

		if v12._started then
			local ok, result = pcall(v12._update, v12, p1)

			if not ok then
				v1:AtError():Log((("ArrowPointer3D update failed: %*"):format(result)))
				v12:Stop()
			end
		end
	end
end)

return t4