-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Constant = require(script.Parent.Constant)
local NULL = Constant.NULL
local ESC_MAP = Constant.ESC_MAP
local t = {
	DEFAULT_PRINT_ADDRESSS = false,
	DEFAULT_MAX_DEPTH = 1000
}

function t.new(p1, p2) --[[ new | Line: 10 | Upvalues: t (copy) ]]
	local v1 = if p1 then p1 else t.DEFAULT_MAX_DEPTH

	if p2 == nil then
		p2 = t.DEFAULT_PRINT_ADDRESSS
	end

	return setmetatable({
		depth = 0,
		max_depth = v1,
		print_address = p2,
		fragments = {}
	}, {
		__index = t
	})
end

local function kindOf(p1) --[[ kindOf | Line: 23 | Upvalues: NULL (copy) ]]
	if type(p1) ~= "table" then
		return type(p1)
	end

	if p1 == NULL then
		return "table"
	end

	local count = 1

	for k in pairs(p1) do
		if p1[count] == nil then
			return "table"
		end

		count = count + 1
	end

	if count == 1 then
		return "table"
	end

	return "array"
end

local function escapeStr(p1) --[[ escapeStr | Line: 40 | Upvalues: ESC_MAP (copy) ]]
	for k, v in pairs(ESC_MAP) do
		p1 = p1:gsub(k, v)
	end

	return p1
end

function t.space(p1, p2) --[[ space | Line: 47 ]]
	for i = 1, p2 or 0 do
		p1:write(" ")
	end

	return p1
end
function t.key(p1, p2) --[[ key | Line: 54 | Upvalues: kindOf (copy), ESC_MAP (copy) ]]
	local v1 = kindOf(p2)

	if v1 == "array" then
		error("Can\'t encode array as key.")
	end

	if v1 == "table" then
		error("Can\'t encode table as key.")
	end

	if v1 == "string" then
		v2 = p2
		v3 = "\""

		for k, v in pairs(ESC_MAP) do
			v2 = v2:gsub(k, v)
		end

		p1:write(v3, v2, "\"")
	else
		if v1 == "number" then
			p1:write("\"", tostring(p2), "\"")

			return p1
		end

		if p1.print_address then
			p1:write((tostring(p2)))
		else
			error("Unjsonifiable type: " .. v1 .. ".")
		end
	end

	return p1
end
function t.array(p1, p2, p3, p4, p5) --[[ array | Line: 77 ]]
	p1:write("[")

	for i, v in ipairs(p2) do
		if p3 then
			v = p3(i, v)
		end

		p1:write(if i == 1 then "" else ",")
		p1:write(if p5 > 0 then "\n" else "")
		p1:space(p4)
		p1:json(v, p3, p4 + p5, p5)
	end

	if #p2 > 0 then
		p1:write(if p5 > 0 then "\n" else "")
		p1:space(p4 - p5)
	end

	p1:write("]")

	return p1
end
function t.table(p1, p2, p3, p4, p5) --[[ table | Line: 96 ]]
	p1:write("{")

	local count = 0

	for k, v in pairs(p2) do
		if p3 then
			v = p3(k, v)
		end

		if v ~= nil then
			p1:write(if count == 0 then "" else ",")
			p1:write(if p5 > 0 then "\n" else "")
			p1:space(p4)
			p1:key(k)
			p1:write(if p5 > 0 then ": " else ":")
			p1:json(v, p3, p4 + p5, p5)
			count = count + 1
		end
	end

	if count > 0 then
		p1:write(if p5 > 0 then "\n" else "")
		p1:space(p4 - p5)
	end

	p1:write("}")

	return p1
end
function t.json(p1, p2, p3, p4, p5) --[[ json | Line: 121 | Upvalues: kindOf (copy), ESC_MAP (copy) ]]
	local v1 = kindOf(p2)

	p1.depth = p1.depth + 1

	if p1.depth > p1.max_depth then
		local v2 = error

		v2("Reach max depth: " .. tostring(p1.max_depth))
	end

	if v1 == "array" then
		p1:array(p2, p3, p4, p5)
	elseif v1 == "table" then
		p1:table(p2, p3, p4, p5)
	elseif v1 == "string" then
		v3 = p2
		v4 = "\""

		for k, v in pairs(ESC_MAP) do
			v3 = v3:gsub(k, v)
		end

		p1:write(v4, v3, "\"")
	elseif v1 == "number" or v1 == "boolean" then
		p1:write((tostring(p2)))
	elseif v1 == "nil" then
		p1:write("null")
	elseif p1.print_address then
		p1:write((tostring(p2)))
	end

	p1.depth = p1.depth - 1

	return p1
end
function t.write(p1, ...) --[[ write | Line: 146 ]]
	local t = { ... }
	local fragments = p1.fragments

	table.move(t, 1, #t, #fragments + 1, fragments)
end
function t.toString(p1) --[[ toString | Line: 152 ]]
	return table.concat(p1.fragments)
end

return t