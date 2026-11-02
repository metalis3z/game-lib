-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Pretty = true,
	IndentChar = "\t",
	IndentSize = 1
}
local t2 = {}
local t3 = {}

local function getIntegerDistance(p1) --[[ getIntegerDistance | Line: 10 ]]
	return math.abs(p1 - math.round(p1))
end

local function isIntegerFuzzy(p1) --[[ isIntegerFuzzy | Line: 14 ]]
	return math.abs(p1 - math.round(p1)) < 0.001
end

local function round(p1, p2) --[[ round | Line: 18 ]]
	return math.round(p1 * p2) / p2
end

local function formatNumber(p1, p2) --[[ formatNumber | Line: 22 ]]
	local v1 = 10 ^ p2

	return string.format("%." .. p2 .. "f", math.round(p1 * v1) / v1):gsub("%.?0+$", "")
end

local function createIndent(p1, p2, p3) --[[ createIndent | Line: 28 ]]
	return string.rep(p1, p2 * p3)
end

local function canUseBareIdentifier(p1) --[[ canUseBareIdentifier | Line: 32 ]]
	return string.match(p1, "^[%a_][%w_]*$") ~= nil
end

local function serialize(p1, p2) --[[ serialize | Line: 36 | Upvalues: t3 (copy) ]]
	local v1 = typeof(p1)
	local v2 = t3[v1]

	if v2 then
		return v2(p1, p2)
	end

	warn((("Missing serializer: %*"):format(v1)))

	return ("[%*]"):format(v1)
end

local function serializeArguments(p1, p2) --[[ serializeArguments | Line: 46 | Upvalues: t3 (copy) ]]
	local v1 = if p2.Config.Pretty then ", " else ","
	local v2 = table.create(#p1)

	for i, v in ipairs(p1) do
		local v3
		local v4 = typeof(v)
		local v5 = t3[v4]

		if v5 then
			v3 = v5(v, p2)
		else
			warn((("Missing serializer: %*"):format(v4)))
			v3 = ("[%*]"):format(v4)
		end

		v2[i] = v3
	end

	return table.concat(v2, v1)
end

local function formatCall(p1, p2, p3) --[[ formatCall | Line: 55 | Upvalues: serializeArguments (copy) ]]
	return string.format("%s(%s)", p1, serializeArguments(p2, p3))
end

t3["nil"] = function(p1, p2) --[[ Line: 59 ]]
	return "nil"
end
function t3.boolean(p1, p2) --[[ boolean | Line: 63 ]]
	if p1 then
		return "true"
	end

	return "false"
end
function t3.number(p1, p2) --[[ number | Line: 67 | Upvalues: formatNumber (copy) ]]
	if p1 == (1 / 0) then
		return "math.huge"
	end

	if p1 == (-1 / 0) then
		return "-math.huge"
	end

	if p1 ~= p1 then
		return "0/0"
	end

	if p2.Config.Pretty then
		return formatNumber(p1, 6)
	end

	return tostring(p1)
end
function t3.string(p1, p2) --[[ string | Line: 83 ]]
	return string.format("%q", p1)
end
function t3.table(p1, p2) --[[ table | Line: 87 | Upvalues: t3 (copy) ]]
	local Order = p2.Order
	local count = 0
	local list = {}
	local v1 = "{"
	local v2 = true

	for k, v in pairs(p1) do
		count = count + 1

		if k ~= count then
			v2 = false
		end

		list[count] = {
			Key = k,
			Value = v
		}
	end

	if Order then
		table.sort(list, function(p1, p2) --[[ Line: 106 | Upvalues: Order (copy) ]]
			local v1 = Order[p1.Key]
			local v2 = Order[p2.Key]

			return (if v1 then v1.Index or (1 / 0) else (1 / 0)) < (v2 and v2.Index or (1 / 0))
		end)
	end

	p2.Level = p2.Level + 1

	local v3 = if p2.Config.Pretty then "\n" .. string.rep(p2.Config.IndentChar, p2.Config.IndentSize * p2.Level) else ""
	local v4 = false

	for i, v in ipairs(list) do
		local v5, v6, v7
		local Key = v.Key
		local v8 = v.Value
		local v9 = nil

		if Order then
			local v10 = Order[Key]

			if v10 then
				v9 = v10.Child
			end
		end

		p2.Order = v9

		if v4 then
			v1 = v1 .. ","
		else
			v4 = true
		end

		local v11 = v1 .. v3

		if not v2 then
			local v12 = typeof(Key)
			local v13 = t3[v12]

			if v13 then
				v5 = v13(Key, p2)
			else
				warn((("Missing serializer: %*"):format(v12)))
				v5 = ("[%*]"):format(v12)
			end

			if type(Key) == "string" and v5 == string.format("%q", Key) then
				local v16 = if string.match(Key, "^[%a_][%w_]*$") == nil then false else true

				v6 = if v16 then v11 .. Key else v11 .. ("[%*]"):format(v5)
			else
				v6 = v11 .. ("[%*]"):format(v5)
			end

			v11 = v6 .. (if p2.Config.Pretty then " = " else "=")
		end

		local v18 = typeof(v8)
		local v19 = t3[v18]

		if v19 then
			v7 = v19(v8, p2)
		else
			warn((("Missing serializer: %*"):format(v18)))
			v7 = ("[%*]"):format(v18)
		end

		v1 = v11 .. v7
	end

	p2.Level = p2.Level - 1
	p2.Order = Order

	if v4 and p2.Config.Pretty then
		v1 = v1 .. ",\n" .. string.rep(p2.Config.IndentChar, p2.Config.IndentSize * p2.Level)
	end

	return v1 .. "}"
end
function t3.Color3(p1, p2) --[[ Color3 | Line: 164 | Upvalues: formatCall (copy) ]]
	local v1 = p1.R * 255
	local v2 = p1.G * 255
	local v3 = p1.B * 255
	local v4 = "fromRGB"
	local v7, v8, v9

	if if math.abs(v1 - math.round(v1)) < 0.001 then true else false then
		local v11 = if math.abs(v2 - math.round(v2)) < 0.001 then true else false

		if v11 and (if math.abs(v3 - math.round(v3)) < 0.001 then true else false) then
			local v14 = math.round(v1)
			local v15 = math.round(v2)

			v7, v8, v9 = v14, v15, math.round(v3)
		else
			v7 = p1.R
			v8 = p1.G
			v9 = p1.B
			v4 = "new"
		end
	else
		v7 = p1.R
		v8 = p1.G
		v9 = p1.B
		v4 = "new"
	end

	return formatCall("Color3." .. v4, { v7, v8, v9 }, p2)
end
function t3.Vector3(p1, p2) --[[ Vector3 | Line: 187 | Upvalues: formatCall (copy) ]]
	if p1 == Vector3.new(0, 0, 0) then
		return "Vector3.zero"
	end

	if p1 == Vector3.new(1, 1, 1) then
		return "Vector3.one"
	end

	if p1 == Vector3.new(1, 0, 0) then
		return "Vector3.xAxis"
	end

	if p1 == Vector3.new(0, 1, 0) then
		return "Vector3.yAxis"
	end

	if p1 == Vector3.new(0, 0, 1) then
		return "Vector3.zAxis"
	end

	return formatCall("Vector3.new", { p1.X, p1.Y, p1.Z }, p2)
end
function t3.Vector2(p1, p2) --[[ Vector2 | Line: 203 | Upvalues: formatCall (copy) ]]
	if p1 == Vector2.zero then
		return "Vector2.zero"
	end

	if p1 == Vector2.one then
		return "Vector2.one"
	end

	if p1 == Vector2.xAxis then
		return "Vector2.xAxis"
	end

	if p1 == Vector2.yAxis then
		return "Vector2.yAxis"
	end

	return formatCall("Vector2.new", { p1.X, p1.Y }, p2)
end
function t3.CFrame(p1, p2) --[[ CFrame | Line: 217 | Upvalues: serializeArguments (copy), t3 (copy), serialize (copy) ]]
	if p1 == CFrame.identity then
		return "CFrame.identity"
	end

	local X = p1.X
	local Y = p1.Y
	local Z = p1.Z
	local v1, v2, v3 = p1:ToOrientation()

	if p2.Config.Pretty then
		X = math.round(X * 1000000) / 1000000
		Y = math.round(Y * 1000000) / 1000000
		Z = math.round(Z * 1000000) / 1000000
		v1 = math.round(math.deg(v1) * 1000000) / 1000000
		v2 = math.round(math.deg(v2) * 1000000) / 1000000
		v3 = math.round(math.deg(v3) * 1000000) / 1000000
	end

	local v7 = if math.sqrt(X ^ 2 + Y ^ 2 + Z ^ 2) > 1e-6 then true else false
	local v8 = if math.sqrt(v1 ^ 2 + v2 ^ 2 + v3 ^ 2) > 0.00001 then true else false

	if not (v7 or v8) then
		return "CFrame.identity"
	end

	local v9 = if v7 then string.format("%s(%s)", "CFrame.new", serializeArguments({ X, Y, Z }, p2)) else nil
	local v11

	if v8 then
		if p2.Config.Pretty then
			local v13 = typeof(v1)
			local v14 = t3[v13]
			local v15

			if v14 then
				v15 = v14(v1, p2)
			else
				warn((("Missing serializer: %*"):format(v13)))
				v15 = ("[%*]"):format(v13)
			end

			local v18 = typeof(v2)
			local v19 = t3[v18]
			local v20

			if v19 then
				v20 = v19(v2, p2)
			else
				warn((("Missing serializer: %*"):format(v18)))
				v20 = ("[%*]"):format(v18)
			end

			v11 = ("CFrame.fromOrientation(math.rad(%s), math.rad(%s), math.rad(%s))"):format(v15, v20, serialize(v3, p2))
		else
			v11 = string.format("%s(%s)", "CFrame.fromOrientation", serializeArguments({ v1, v2, v3 }, p2))
		end
	else
		v11 = nil
	end

	if v9 and v11 then
		return p2.Config.Pretty and ("%s * %s"):format(v9, v11) or ("%s*%s"):format(v9, v11)
	end

	return v9 or v11
end
function t3.EnumItem(p1, p2) --[[ EnumItem | Line: 268 ]]
	return ("Enum.%s.%s"):format(p1.EnumType, p1.Name)
end
function t2.Pretty(p1, p2) --[[ Pretty | Line: 272 | Upvalues: t (copy), serialize (copy) ]]
	local v1 = if p2 then p2 else t

	return serialize(p1, {
		Level = 0,
		Config = v1,
		Order = v1.Order
	})
end
function t2.CompileOrder(p1) --[[ CompileOrder | Line: 281 | Upvalues: t2 (copy) ]]
	assert(type(p1) == "table")
	assert(if #p1 == 0 then if next(p1) == nil then true else false else true)

	local t = {}

	for i, v in ipairs(p1) do
		if type(v) == "table" then
			local Key = v.Key

			assert(type(Key) == "string")
			t[Key] = {
				Index = i,
				Child = t2.CompileOrder(v.Value)
			}

			continue
		end

		t[v] = {
			Index = i
		}
	end

	return t
end

return t2