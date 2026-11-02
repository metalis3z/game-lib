-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t._new(p1) --[[ _new | Line: 129 | Upvalues: t (copy) ]]
	local t2 = {
		ClassName = "Option",
		_v = p1
	}

	t2._s = p1 ~= nil

	return setmetatable(t2, t)
end
function t.Some(p1) --[[ Some | Line: 145 | Upvalues: t (copy) ]]
	assert(p1 ~= nil, "Option.Some() value cannot be nil")

	return t._new(p1)
end
function t.Wrap(p1) --[[ Wrap | Line: 158 | Upvalues: t (copy) ]]
	if p1 == nil then
		return t.None
	end

	return t.Some(p1)
end
function t.Is(p1) --[[ Is | Line: 171 | Upvalues: t (copy) ]]
	return if type(p1) == "table" then getmetatable(p1) == t else false
end
function t.Assert(p1) --[[ Assert | Line: 179 | Upvalues: t (copy) ]]
	assert(t.Is(p1), "Result was not of type Option")
end
function t.Deserialize(p1) --[[ Deserialize | Line: 189 | Upvalues: t (copy) ]]
	assert(if type(p1) == "table" then if p1.ClassName == "Option" then true else false else false, "Invalid data for deserializing Option")

	return p1.Value == nil and t.None or t.Some(p1.Value)
end
function t.Serialize(p1) --[[ Serialize | Line: 198 ]]
	return {
		ClassName = p1.ClassName,
		Value = p1._v
	}
end
function t.Match(p1, p2) --[[ Match | Line: 219 ]]
	local Some = p2.Some
	local None = p2.None

	assert(if type(Some) == "function" then true else false, "Missing \'Some\' match")
	assert(if type(None) == "function" then true else false, "Missing \'None\' match")

	if p1:IsSome() then
		return Some(p1:Unwrap())
	end

	return None()
end
function t.IsSome(p1) --[[ IsSome | Line: 235 ]]
	return p1._s
end
function t.IsNone(p1) --[[ IsNone | Line: 243 ]]
	return not p1._s
end
function t.Expect(p1, p2) --[[ Expect | Line: 257 ]]
	assert(p1:IsSome(), p2)

	return p1._v
end
function t.ExpectNone(p1, p2) --[[ ExpectNone | Line: 266 ]]
	assert(p1:IsNone(), p2)
end
function t.Unwrap(p1) --[[ Unwrap | Line: 274 ]]
	return p1:Expect("Cannot unwrap option of None type")
end
function t.UnwrapOr(p1, p2) --[[ UnwrapOr | Line: 283 ]]
	if p1:IsSome() then
		return p1:Unwrap()
	end

	return p2
end
function t.UnwrapOrElse(p1, p2) --[[ UnwrapOrElse | Line: 297 ]]
	if p1:IsSome() then
		return p1:Unwrap()
	end

	return p2()
end
function t.And(p1, p2) --[[ And | Line: 323 | Upvalues: t (copy) ]]
	if p1:IsSome() then
		return p2
	end

	return t.None
end
function t.AndThen(p1, p2) --[[ AndThen | Line: 347 | Upvalues: t (copy) ]]
	if p1:IsSome() then
		local v1 = p2(p1:Unwrap())

		t.Assert(v1)

		return v1
	end

	return t.None
end
function t.Or(p1, p2) --[[ Or | Line: 362 ]]
	if p1:IsSome() then
		return p1
	end

	return p2
end
function t.OrElse(p1, p2) --[[ OrElse | Line: 376 | Upvalues: t (copy) ]]
	if p1:IsSome() then
		return p1
	end

	local v1 = p2()

	t.Assert(v1)

	return v1
end
function t.XOr(p1, p2) --[[ XOr | Line: 393 | Upvalues: t (copy) ]]
	local v1 = p1:IsSome()

	if v1 == p2:IsSome() then
		return t.None
	end

	if v1 then
		return p1
	end

	return p2
end
function t.Filter(p1, p2) --[[ Filter | Line: 411 | Upvalues: t (copy) ]]
	if p1:IsNone() or not p2(p1._v) then
		return t.None
	end

	return p1
end
function t.Contains(p1, p2) --[[ Contains | Line: 424 ]]
	return p1:IsSome() and p1._v == p2
end
function t.__tostring(p1) --[[ __tostring | Line: 438 ]]
	if p1:IsSome() then
		return "Option<" .. typeof(p1._v) .. ">"
	end

	return "Option<None>"
end
function t.__eq(p1, p2) --[[ __eq | Line: 464 | Upvalues: t (copy) ]]
	if not t.Is(p2) then
		return false
	end

	if p1:IsSome() and p2:IsSome() then
		return p1:Unwrap() == p2:Unwrap()
	end

	if p1:IsNone() and p2:IsNone() then
		return true
	end

	return false
end
t.None = t._new()

return t