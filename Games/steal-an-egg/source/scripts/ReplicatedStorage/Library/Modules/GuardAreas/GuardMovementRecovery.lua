-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local t = {}

t.__index = t
t.__class = "GuardMovementRecovery"
function t.new(p1, p2) --[[ new | Line: 37 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.BasePart(p1)
	Asserts.BasePart(p2)

	local v2 = setmetatable({}, t)

	v2._ground = p2
	v2._lastProgressPosition = nil
	v2._lastProgressTime = 0
	v2._returnHomeStartedAt = nil
	v2._root = p1

	return v2
end
function t._getHorizontalDistance(p1, p2) --[[ _getHorizontalDistance | Line: 55 ]]
	local v1 = p1._root.Position - p2

	return Vector3.new(v1.X, 0, v1.Z).Magnitude
end
function t.Reset(p1) --[[ Reset | Line: 64 ]]
	p1._lastProgressPosition = nil
	p1._lastProgressTime = 0
	p1._returnHomeStartedAt = nil
end
function t.ShouldRecoverFromFall(p1) --[[ ShouldRecoverFromFall | Line: 70 | Upvalues: v1 (copy) ]]
	if p1._root.Position.Y >= p1._ground.Position.Y - 5 then
		return false
	end

	v1:AtWarning():Log((("Guard fell below the world and requires recovery: %*"):format((p1._root:GetFullName()))))

	return true
end
function t.Step(p1, p2, p3, p4) --[[ Step | Line: 79 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.number(p2)
	Asserts.boolean(p3)
	Asserts.boolean(p4)

	if p4 then
		local _returnHomeStartedAt = p1._returnHomeStartedAt

		if _returnHomeStartedAt == nil then
			p1._returnHomeStartedAt = p2
		elseif p2 - _returnHomeStartedAt >= 20 then
			v1:AtWarning():Log((("Guard return-home timeout triggered for %*"):format((p1._root:GetFullName()))))
			p1:Reset()

			return true
		end
	else
		p1._returnHomeStartedAt = nil
	end

	if not p3 then
		p1._lastProgressPosition = nil
		p1._lastProgressTime = 0

		return false
	end

	local _lastProgressPosition = p1._lastProgressPosition

	if _lastProgressPosition == nil then
		p1._lastProgressPosition = p1._root.Position
		p1._lastProgressTime = p2

		return false
	end

	if p1:_getHorizontalDistance(_lastProgressPosition) >= 3 then
		p1._lastProgressPosition = p1._root.Position
		p1._lastProgressTime = p2

		return false
	end

	if p2 - p1._lastProgressTime < 10 then
		return false
	end

	v1:AtWarning():Log((("Guard stuck recovery triggered for %*"):format((p1._root:GetFullName()))))
	p1:Reset()

	return true
end

return t