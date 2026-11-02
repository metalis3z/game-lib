-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Physics = require(ReplicatedStorage.Library.Modules.Physics)
local WaitFor = require(ReplicatedStorage.Library.Modules.Packages.WaitFor)
local Weld = require(ReplicatedStorage.Library.Functions.Weld)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local GuardDistance = require(script.Parent.GuardDistance)

require(script.Parent.Types.Interface)

local t = {}

t.__index = t
t.__class = "GuardEggRetrievalComponent"
function t.new(p1, p2, p3) --[[ new | Line: 42 | Upvalues: Asserts (copy), WaitFor (copy), Constants (copy), t (copy) ]]
	Asserts.Model(p1)
	Asserts.BasePart(p2)
	Asserts.CFrame(p3)

	local v1, v2 = WaitFor.Descendant(p1, "EggPoint", Constants.STUDIO_YIELD_TIMEOUT):await()

	assert(v1, (("Failed to resolve EggPoint under %*: %*"):format(p1:GetFullName(), (tostring(v2)))))

	local v4 = v2:IsA("BasePart")

	assert(v4, (("%*.EggPoint must be a BasePart"):format((p1:GetFullName()))))

	local v7 = setmetatable({}, t)

	v7._byUid = {}
	v7._current = nil
	v7._eggPoint = v2
	v7._homeCFrame = p3
	v7._queue = {}
	v7._root = p2
	v7._stage = nil
	v7._weld = nil

	return v7
end
function t._selectCurrent(p1) --[[ _selectCurrent | Line: 72 ]]
	if p1._current ~= nil then
		return p1._current
	end

	while #p1._queue > 0 do
		local v1 = table.remove(p1._queue, 1)

		assert(v1 ~= nil, "Non-empty guard retrieval queue must yield a target")

		local Model = v1.Model

		if p1._byUid[v1.EggUid] == v1 and (Model == nil or Model.Parent ~= nil) then
			p1._current = v1
			p1._stage = "Approaching"

			return v1
		end

		p1._byUid[v1.EggUid] = nil
	end

	return nil
end
function t._destroyWeld(p1) --[[ _destroyWeld | Line: 92 ]]
	local _weld = p1._weld

	if _weld == nil then
		return
	end

	p1._weld = nil
	_weld:Destroy()
end
function t._removeCurrent(p1) --[[ _removeCurrent | Line: 100 ]]
	local _current = p1._current

	assert(_current ~= nil, "Guard retrieval current target is required")
	p1:_destroyWeld()
	p1._byUid[_current.EggUid] = nil
	p1._current = nil
	p1._stage = nil

	return _current
end
function t.Register(p1, p2) --[[ Register | Line: 114 | Upvalues: Asserts (copy) ]]
	Asserts.table(p2)
	Asserts.string(p2.EggUid)
	Asserts.optional.Model(p2.Model)
	Asserts.Vector3(p2.DroppedPosition)
	Asserts.CFrame(p2.NestBottomCFrame)

	if p1._byUid[p2.EggUid] == nil then
		p1._byUid[p2.EggUid] = p2
		table.insert(p1._queue, p2)

		return true
	end

	return false
end
function t.Clear(p1, p2) --[[ Clear | Line: 133 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)

	local v1 = p1._byUid[p2]

	if v1 == nil then
		return false
	end

	p1._byUid[p2] = nil

	if p1._current == v1 then
		p1:_destroyWeld()
		p1._current = nil
		p1._stage = nil
	end

	local v2 = table.find(p1._queue, v1)

	if v2 == nil then
		return true
	end

	table.remove(p1._queue, v2)

	return true
end
function t.HasPending(p1) --[[ HasPending | Line: 154 ]]
	return next(p1._byUid) ~= nil
end
function t.IsAttached(p1, p2) --[[ IsAttached | Line: 158 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)

	return if p1._current == nil or p1._current.EggUid ~= p2 then false else p1._stage == "Carrying"
end
function t.GetMoveTarget(p1) --[[ GetMoveTarget | Line: 163 ]]
	local v1 = p1:_selectCurrent()

	if v1 == nil then
		return nil
	end

	if p1._stage == "Carrying" then
		return p1._homeCFrame.Position
	end

	return v1.DroppedPosition
end
function t.TryTransition(p1, p2) --[[ TryTransition | Line: 174 | Upvalues: Asserts (copy), GuardDistance (copy), Physics (copy), Weld (copy) ]]
	Asserts.number(p2)

	local v1 = p1:_selectCurrent()

	if v1 == nil then
		return nil
	end

	local Model = v1.Model

	if Model ~= nil and Model.Parent == nil then
		p1:Clear(v1.EggUid)

		return nil
	end

	if p1._stage == "Approaching" then
		if p2 < GuardDistance.XZ(p1._root.Position, v1.DroppedPosition) then
			return nil
		end

		if Model ~= nil then
			local PrimaryPart = Model.PrimaryPart

			assert(PrimaryPart ~= nil, (("Rendered guard retrieval egg %* must have a PrimaryPart"):format(v1.EggUid)))
			Physics.SetAnchored(Model, false)
			Model:PivotTo(p1._eggPoint.CFrame * CFrame.new(0, 0, -PrimaryPart.Size.Z * 0.5))
			p1._weld = Weld(p1._eggPoint, PrimaryPart)
		end

		p1._stage = "Carrying"

		return "Attached"
	end

	if GuardDistance.XZ(p1._root.Position, p1._homeCFrame.Position) > 20 then
		return nil
	end

	p1:_destroyWeld()

	if Model == nil then
		p1:_removeCurrent()

		return "Deposited"
	end

	Physics.SetAnchored(Model, true)
	Model:PivotTo(v1.NestBottomCFrame)
	p1:_removeCurrent()

	return "Deposited"
end
function t.GetCurrentEggUid(p1) --[[ GetCurrentEggUid | Line: 219 ]]
	local v1 = p1:_selectCurrent()

	if v1 == nil then
		return nil
	end

	return v1.EggUid
end
function t.Destroy(p1) --[[ Destroy | Line: 224 ]]
	p1:_destroyWeld()
	table.clear(p1._byUid)
	table.clear(p1._queue)
	p1._current = nil
	p1._stage = nil
end

return t