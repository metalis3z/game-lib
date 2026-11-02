-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local t2 = {}
local v1 = setmetatable({}, {
	__mode = "k"
})

local function proxy_tostring(p1) --[[ proxy_tostring | Line: 5 | Upvalues: v1 (copy) ]]
	return v1[p1].type_name .. ": " .. v1[p1].as_string
end

local v2 = table.freeze({
	DEFAULT = 0,
	NUMBER_FORMATTER = 1,
	SYMBOLS = 2
})

t.ImmutabilityType = v2
function t.create_init_function(p1, p2, p3, p4, p5) --[[ create_init_function | Line: 16 | Upvalues: t2 (copy), v2 (copy), proxy_tostring (copy), v1 (copy) ]]
	local v12 = if p4 then setmetatable(table.clone(p4), {
	__index = p3
}) else p3

	t2[p1] = p2 or "FormatNumberObject"

	return function(p12, p2) --[[ Line: 33 | Upvalues: p5 (copy), v2 (ref), p1 (copy), v12 (ref), proxy_tostring (ref), v1 (ref) ]]
		local v13 = newproxy(true)
		local v22 = getmetatable(v13)

		if p5 ~= v2.SYMBOLS and type(p12) == "table" then
			table.freeze(p12)
		end

		v22.data = p12
		v22.resolved_data = nil
		v22.type_name = p1
		v22.as_string = p2 or string.sub(tostring(v13), 11)
		v22.__index = v12
		v22.__tostring = proxy_tostring
		v22.__metatable = "The metatable is locked"

		if p5 ~= v2.NUMBER_FORMATTER then
			table.freeze(v22)
		end

		v1[v13] = v22

		return v13
	end
end
function t.is_a(p1, p2) --[[ is_a | Line: 59 | Upvalues: v1 (copy), t2 (copy) ]]
	local v12 = v1[p1]
	local v2 = if v12 then v12.type_name else v12
	local v3 = false

	if v2 == p2 then
		return true
	end

	if v2 then
		repeat
			v2 = t2[v2]
			v3 = v2 == p2
		until not v2 or v3
	end

	return v3
end
function t.get_data(p1) --[[ get_data | Line: 77 | Upvalues: v1 (copy) ]]
	return v1[p1].data
end
function t.get_resolved_data(p1, p2) --[[ get_resolved_data | Line: 81 | Upvalues: v1 (copy) ]]
	local v12 = v1[p1]
	local resolved_data = v12.resolved_data

	if not resolved_data then
		local v2 = p2(v12.data)

		v12.resolved_data = v2

		if v2 then
			table.freeze(v12)
		end

		resolved_data = v2
	end

	return resolved_data
end
function t.try_coerce(p1, p2, p3, p4) --[[ try_coerce | Line: 96 | Upvalues: t (copy), v1 (copy) ]]
	local v12 = false
	local v2 = nil

	if p2 == nil and p4 ~= nil then
		v12 = true
		v2 = p4
	elseif p3 == "string" then
		if type(p2) == "string" then
			v12 = true
			v2 = p2
		elseif type(p2) == "number" then
			v12, v2 = true, tostring(p2)
		else
			v12 = false
		end
	elseif p3 == "number" then
		local v4 = tonumber(p2)

		if v4 then
			v12 = true
			v2 = v4
		else
			v12, p3, v2 = false, p3 .. " object", v4
		end
	elseif string.sub(p3, 1, 1) == "{" then
		local v5 = string.sub(p3, 2, -2)

		if type(p2) == "table" then
			local v6 = table.move(p2, 1, rawlen(p2), 1, table.create((rawlen(p2))))

			v2 = v6

			for v7, v8 in v6 do
				if type(v8) ~= v5 then
					error(string.format("Values inside the table argument must be a %s, index %d got %s", v5, v7, (type(v8))), 3)
				end
			end

			v12 = true
		else
			p3 = "table"
		end
	elseif t.is_a(p2, p3) then
		v2 = v1[p2].data
		v12 = true
	end

	if v12 then
		return v2
	end

	error(string.format("Argument #%d provided must be a %s", p1, p3), 3)
end
function t.try_coerce_range(p1, p2, p3, p4, p5) --[[ try_coerce_range | Line: 151 | Upvalues: t (copy) ]]
	local v1 = nil

	if p2 == nil then
		v1 = p5
	else
		local v2 = tonumber(p2)

		if v2 then
			local v3 = t.double_to_int32(v2)

			if p3 <= v3 and v3 <= p4 then
				v1 = v3
			end
		end
	end

	return if v1 then v1 else error(string.format("Argument #%d provided must be an integer that is in the range of %d to (and including) %d", p1, p3, p4), 3)
end
function t.try_coerce_enum(p1, p2, p3, p4) --[[ try_coerce_enum | Line: 179 | Upvalues: t (copy) ]]
	local v1 = nil

	if p2 == nil then
		v1 = p4
	elseif tonumber(p2) then
		local v3 = t.double_to_int32(p2)

		for v4, v5 in p3 do
			if v3 == v5 then
				v1 = v5

				break
			end
		end
	end

	return if v1 then v1 else error(string.format("Argument #%d provided is out of range", p1), 3)
end
function t.double_to_int32(p1) --[[ double_to_int32 | Line: 200 ]]
	if p1 > -2147483649 and p1 < 2147483648 then
		if p1 <= -1 then
			return math.ceil(p1)
		end

		if p1 >= 1 then
			return math.floor(p1)
		end

		return 0
	end

	return UDim.new(nil, p1).Offset
end

return table.freeze(t)