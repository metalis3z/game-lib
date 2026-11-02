-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)

require(script.Types.Interface)

local t = {}

t.__index = t
t.__class = "TouchTapTracker"

local v1 = Log.new()

function t.new(p1) --[[ new | Line: 38 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.optional.table(p1)

	if p1 then
		Asserts.optional.number(p1.MaxMovement)
		Asserts.optional.number(p1.MaxDuration)
	end

	local v2 = setmetatable({}, t)

	v2._maxMovement = if p1 and p1.MaxMovement ~= nil then p1.MaxMovement else 16
	v2._maxDuration = if p1 and p1.MaxDuration ~= nil then p1.MaxDuration else 0.35
	v2._activeInput = nil
	v2._startedAt = 0
	v2._startPosition = nil
	v2._cancelled = false
	v2:_init()

	return v2
end
function t._validateTouchInput(p1, p2) --[[ _validateTouchInput | Line: 62 | Upvalues: Asserts (copy) ]]
	Asserts.cond(p2.UserInputType == Enum.UserInputType.Touch)
end
function t._getMovementDistance(p1, p2) --[[ _getMovementDistance | Line: 66 ]]
	local _startPosition = p1._startPosition

	if _startPosition then
		return (p2.Position - _startPosition).Magnitude
	end

	return nil
end
function t.Begin(p1, p2) --[[ Begin | Line: 79 ]]
	p1:_validateTouchInput(p2)
	p1._activeInput = p2
	p1._startedAt = os.clock()
	p1._startPosition = p2.Position
	p1._cancelled = false
end
function t.Update(p1, p2) --[[ Update | Line: 88 ]]
	p1:_validateTouchInput(p2)

	if p1._activeInput ~= p2 or p1._cancelled then
		return false
	end

	local v1 = p1:_getMovementDistance(p2)

	if not v1 then
		p1._cancelled = true

		return false
	end

	if p1._maxMovement < v1 then
		p1._cancelled = true

		return false
	end

	return true
end
function t.Evaluate(p1, p2, p3) --[[ Evaluate | Line: 109 ]]
	p1:_validateTouchInput(p2)

	if p3 then
		p1:Reset()

		return false
	end

	if p1._activeInput == p2 and not p1._cancelled then
		local v1 = p1:_getMovementDistance(p2)
		local _startedAt = p1._startedAt

		if not v1 or _startedAt <= 0 then
			p1:Reset()

			return false
		end

		local v2 = if os.clock() - _startedAt <= p1._maxDuration then if v1 <= p1._maxMovement then true else false else false

		p1:Reset()

		return v2
	end

	p1:Reset()

	return false
end
function t.Reset(p1) --[[ Reset | Line: 136 ]]
	p1._activeInput = nil
	p1._startedAt = 0
	p1._startPosition = nil
	p1._cancelled = false
end
function t.IsTrackingInput(p1, p2) --[[ IsTrackingInput | Line: 143 ]]
	return p1._activeInput == p2
end
function t.IsCancelled(p1) --[[ IsCancelled | Line: 147 ]]
	return p1._cancelled
end
function t._init(p1) --[[ _init | Line: 155 | Upvalues: v1 (copy) ]]
	v1:AtDebug():Log("TouchTapTracker initialized")
end

return t