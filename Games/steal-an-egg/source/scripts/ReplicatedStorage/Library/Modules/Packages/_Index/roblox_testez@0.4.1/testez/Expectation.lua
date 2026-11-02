-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local t2 = {
	to = true,
	be = true,
	been = true,
	have = true,
	was = true,
	at = true
}
local t3 = {
	never = true
}

local function assertLevel(p1, p2, p3) --[[ assertLevel | Line: 42 ]]
	if p1 then
		return
	end

	error(p2 or "Assertion failed!", (p3 or 1) + 1)
end

local function bindSelf(p1, p2) --[[ bindSelf | Line: 54 ]]
	return function(p13, ...) --[[ Line: 55 | Upvalues: p1 (copy), p2 (copy) ]]
		if p13 == p1 then
			return p2(p1, ...)
		end

		return p2(p1, p13, ...)
	end
end

local function formatMessage(p1, p2, p3) --[[ formatMessage | Line: 64 ]]
	if p1 then
		return p2
	end

	return p3
end

function t.new(p1) --[[ new | Line: 75 | Upvalues: t (copy) ]]
	local t2 = {
		successCondition = true,
		condition = false,
		value = p1,
		matchers = {},
		_boundMatchers = {}
	}

	setmetatable(t2, t)

	local a = t2.a

	function t2.a(p13, ...) --[[ Line: 55 | Upvalues: t2 (copy), a (copy) ]]
		if p13 == t2 then
			return a(t2, ...)
		end

		return a(t2, p13, ...)
	end
	t2.an = t2.a

	local ok = t2.ok

	function t2.ok(p13, ...) --[[ Line: 55 | Upvalues: t2 (copy), ok (copy) ]]
		if p13 == t2 then
			return ok(t2, ...)
		end

		return ok(t2, p13, ...)
	end

	local equal = t2.equal

	function t2.equal(p13, ...) --[[ Line: 55 | Upvalues: t2 (copy), equal (copy) ]]
		if p13 == t2 then
			return equal(t2, ...)
		end

		return equal(t2, p13, ...)
	end

	local throw = t2.throw

	function t2.throw(p13, ...) --[[ Line: 55 | Upvalues: t2 (copy), throw (copy) ]]
		if p13 == t2 then
			return throw(t2, ...)
		end

		return throw(t2, p13, ...)
	end

	local near = t2.near

	function t2.near(p13, ...) --[[ Line: 55 | Upvalues: t2 (copy), near (copy) ]]
		if p13 == t2 then
			return near(t2, ...)
		end

		return near(t2, p13, ...)
	end

	return t2
end
function t.checkMatcherNameCollisions(p1) --[[ checkMatcherNameCollisions | Line: 96 | Upvalues: t2 (copy), t3 (copy), t (copy) ]]
	return not (t2[p1] or (t3[p1] or t[p1]))
end
function t.extend(p1, p2) --[[ extend | Line: 104 ]]
	p1.matchers = if p2 then p2 else {}

	for k, v in pairs(p1.matchers) do
		local function f2(p12, ...) --[[ Line: 108 | Upvalues: v (copy), p1 (copy) ]]
			local v1 = v(p1.value, ...)

			if v1.pass == p1.successCondition then
				p1:_resetModifiers()

				return p1
			end

			error(v1.message or "Assertion failed!", (3 or 1) + 1)
		end

		p1._boundMatchers[k] = function(p13, ...) --[[ Line: 55 | Upvalues: p1 (copy), f2 (copy) ]]
			if p13 == p1 then
				return f2(p1, ...)
			end

			return f2(p1, p13, ...)
		end
	end

	return p1
end
function t.__index(p1, p2) --[[ __index | Line: 121 | Upvalues: t2 (copy), t3 (copy), t (copy) ]]
	if t2[p2] then
		return p1
	end

	if t3[p2] then
		local v1 = t.new(p1.value):extend(p1.matchers)

		v1.successCondition = not p1.successCondition

		return v1
	end

	if p1._boundMatchers[p2] then
		return p1._boundMatchers[p2]
	end

	return t[p2]
end
function t._resetModifiers(p1) --[[ _resetModifiers | Line: 154 ]]
	p1.successCondition = true
end
function t.a(p1, p2) --[[ a | Line: 163 ]]
	local v2 = if type(p1.value) == p2 == p1.successCondition then true else false
	local v4 = ("Expected value of type %q, got value %q of type %s"):format(p2, tostring(p1.value), (type(p1.value)))
	local v8 = (if p1.successCondition then v4 else ("Expected value not of type %q, got value %q of type %s"):format(p2, tostring(p1.value), (type(p1.value)))) or "Assertion failed!"

	if v2 then
		p1:_resetModifiers()

		return p1
	end

	error(v8, (3 or 1) + 1)
end
t.an = t.a
function t.ok(p1) --[[ ok | Line: 188 ]]
	local v1 = ("Expected value %q to be non-nil"):format((tostring(p1.value)))
	local v4 = (if p1.successCondition then v1 else ("Expected value %q to be nil"):format((tostring(p1.value)))) or "Assertion failed!"

	if p1.value ~= nil == p1.successCondition then
		p1:_resetModifiers()

		return p1
	end

	error(v4, (3 or 1) + 1)
end
function t.equal(p1, p2) --[[ equal | Line: 206 ]]
	local v1 = if p1.value == p2 == p1.successCondition then true else false
	local v5 = ("Expected value %q (%s), got %q (%s) instead"):format(tostring(p2), type(p2), tostring(p1.value), (type(p1.value)))
	local v8 = (if p1.successCondition then v5 else ("Expected anything but value %q (%s)"):format(tostring(p2), (type(p2)))) or "Assertion failed!"

	if v1 then
		p1:_resetModifiers()

		return p1
	end

	error(v8, (3 or 1) + 1)
end
function t.near(p1, p2, p3) --[[ near | Line: 230 ]]
	assert(if type(p1.value) == "number" then true else false, "Expectation value must be a number to use \'near\'")
	assert(if type(p2) == "number" then true else false, "otherValue must be a number")
	assert(if type(p3) == "number" then true elseif p3 == nil then true else false, "limit must be a number or nil")

	local v4 = p3 or 1e-7
	local v7 = if math.abs(p1.value - p2) <= v4 == p1.successCondition then true else false
	local v8 = ("Expected value to be near %f (within %f) but got %f instead"):format(p2, v4, p1.value)
	local v11 = (if p1.successCondition then v8 else ("Expected value to not be near %f (within %f) but got %f instead"):format(p2, v4, p1.value)) or "Assertion failed!"

	if v7 then
		p1:_resetModifiers()

		return p1
	end

	error(v11, (3 or 1) + 1)
end
function t.throw(p1, p2) --[[ throw | Line: 256 ]]
	local ok, result = pcall(p1.value)
	local v1 = if ok == p1.successCondition then false else true

	if p2 and not ok then
		v1 = if p1.successCondition then result:find(p2, 1, true) ~= nil elseif result:find(p2, 1, true) == nil then true else false
	end

	local v2

	if p2 then
		local v4, v5

		if result then
			v4 = ("threw: %s"):format(result)

			if v4 then
				v5 = p2
			else
				v5 = p2
				v4 = "did not throw."
			end
		else
			v5 = p2
			v4 = "did not throw."
		end

		local v6 = ("Expected function to throw an error containing %q, but it %s"):format(v5, v4)

		v2 = if p1.successCondition then v6 else ("Expected function to never throw an error containing %q, but it threw: %s"):format(p2, (tostring(result)))
	else
		v2 = if p1.successCondition then "Expected function to throw an error, but it did not throw." else ("Expected function to succeed, but it threw an error: %s"):format((tostring(result)))
	end

	if v1 then
		p1:_resetModifiers()

		return p1
	end

	error(v2 or "Assertion failed!", (3 or 1) + 1)
end

return t