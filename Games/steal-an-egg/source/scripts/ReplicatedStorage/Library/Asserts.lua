-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local IsASCII = require(Library:WaitForChild("Functions"):WaitForChild("IsASCII"))
local t = {
	optional = {},
	array = {},
	custom = {}
}

function IsFinite(p1) --[[ IsFinite | Line: 10 ]]
	return if p1 == p1 and p1 ~= (1 / 0) then p1 ~= (-1 / 0) else false
end
function IsFiniteVec2(p1) --[[ IsFiniteVec2 | Line: 21 ]]
	return IsFinite(p1.X) and IsFinite(p1.Y)
end
function IsFiniteVec(p1) --[[ IsFiniteVec | Line: 25 ]]
	return IsFinite(p1.X) and (IsFinite(p1.Y) and IsFinite(p1.Z))
end
function IsFiniteCFrame(p1) --[[ IsFiniteCFrame | Line: 29 ]]
	local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 = p1:GetComponents()

	return IsFinite(v1) and IsFinite(v2) and IsFinite(v3) and IsFinite(v4) and IsFinite(v5) and IsFinite(v6) and IsFinite(v7) and IsFinite(v8) and IsFinite(v9) and IsFinite(v10) and IsFinite(v11) and IsFinite(v12)
end
function cassert(p1, p2) --[[ cassert | Line: 49 ]]
	if p1 then
		return
	end

	error("assertion failed!", (p2 or 0) + 3)
end
t.cassert = cassert
function t.defined(p1, p2) --[[ defined | Line: 56 ]]
	cassert(if p1 == nil then false else true, p2)

	return p1
end
function t.exists(p1, p2) --[[ exists | Line: 61 | Upvalues: t (copy) ]]
	t.defined(p1, p2)

	return p1
end
function t.cond(p1, p2) --[[ cond | Line: 66 ]]
	cassert(if p1 == true then true else false, p2)
end
function t.boolean(p1, p2) --[[ boolean | Line: 70 ]]
	local v1 = cassert

	v1(if type(p1) == "boolean" then true else false, p2)
end

local function boolean(p1, p2) --[[ boolean | Line: 74 ]]
	cassert(if p1 == nil then true else type(p1) == "boolean", p2)
end

t.optional.boolean = boolean
function t.enum(p1, p2) --[[ enum | Line: 82 ]]
	local v1 = cassert

	v1(if typeof(p1) == "EnumItem" then true else false, p2)
end

local function enum(p1, p2) --[[ enum | Line: 86 ]]
	if p1 == nil then
		return
	end

	local v1 = cassert

	v1(if typeof(p1) == "EnumItem" then true else false, p2)
end

t.optional.enum = enum
function t.number(p1, p2) --[[ number | Line: 93 ]]
	local v1 = cassert

	v1(if type(p1) == "number" then true else false, p2)
end

local function number(p1, p2) --[[ number | Line: 97 ]]
	cassert(if p1 == nil then true else type(p1) == "number", p2)
end

t.optional.number = number
function t.TweenInfo(p1, p2) --[[ TweenInfo | Line: 105 ]]
	local v1 = cassert

	v1(if typeof(p1) == "TweenInfo" then true else false, p2)
end

local function v(p1, p2) --[[ TweenInfo | Line: 109 ]]
	cassert(if p1 == nil then true else typeof(p1) == "TweenInfo", p2)
end

t.optional.TweenInfo = v
function t.nonNegativeInteger(p1, p2) --[[ nonNegativeInteger | Line: 117 | Upvalues: t (copy) ]]
	t.integer(p1, p2)
	cassert(p1 >= 0, p2)
	cassert(math.floor(p1) == p1, p2)
end

local function nonNegativeInteger(p1, p2) --[[ nonNegativeInteger | Line: 123 | Upvalues: t (copy) ]]
	t.optional.integer(p1, p2)

	if p1 == nil then
		return
	end

	cassert(p1 >= 0, p2)
	cassert(math.floor(p1) == p1, p2)
end

t.optional.nonNegativeInteger = nonNegativeInteger
function t.positiveInteger(p1, p2) --[[ positiveInteger | Line: 131 | Upvalues: t (copy) ]]
	t.integer(p1, p2)
	cassert(p1 > 0, p2)
	cassert(math.floor(p1) == p1, p2)
end

local function positiveInteger(p1, p2) --[[ positiveInteger | Line: 137 | Upvalues: t (copy) ]]
	t.optional.integer(p1, p2)

	if p1 == nil then
		return
	end

	cassert(p1 > 0, p2)
	cassert(math.floor(p1) == p1, p2)
end

t.optional.positiveInteger = positiveInteger
function t.real(p1, p2) --[[ real | Line: 145 ]]
	cassert(if type(p1) == "number" then true else false, p2)
	cassert(p1 == p1, p2)
end

local function real(p1, p2) --[[ real | Line: 150 ]]
	if p1 == nil then
		return
	end

	cassert(if type(p1) == "number" then true else false, p2)
	cassert(p1 == p1, p2)
end

t.optional.real = real
function t.finite(p1, p2) --[[ finite | Line: 157 ]]
	local v1 = cassert

	v1(if type(p1) == "number" then true else false, p2)
	cassert(IsFinite(p1), p2)
end

local function finite(p1, p2) --[[ finite | Line: 162 ]]
	if p1 == nil then
		return
	end

	local v1 = cassert

	v1(if type(p1) == "number" then true else false, p2)
	cassert(IsFinite(p1), p2)
end

t.optional.finite = finite
function t.finiteNonNegative(p1, p2) --[[ finiteNonNegative | Line: 169 ]]
	cassert(if type(p1) == "number" then true else false, p2)
	cassert(IsFinite(p1), p2)
	cassert(p1 >= 0, p2)
end

local function finiteNonNegative(p1, p2) --[[ finiteNonNegative | Line: 175 ]]
	if p1 == nil then
		return
	end

	cassert(if type(p1) == "number" then true else false, p2)
	cassert(IsFinite(p1), p2)
	cassert(p1 >= 0, p2)
end

t.optional.finiteNonNegative = finiteNonNegative
function t.integer(p1, p2) --[[ integer | Line: 183 ]]
	local v1 = cassert

	v1(if type(p1) == "number" then true else false, p2)
	cassert(IsFinite(p1), p2)

	local v3 = cassert

	v3(math.floor(p1) == p1, p2)
end

local function integer(p1, p2) --[[ integer | Line: 189 ]]
	if p1 == nil then
		return
	end

	local v1 = cassert

	v1(if type(p1) == "number" then true else false, p2)
	cassert(IsFinite(p1), p2)

	local v3 = cassert

	v3(math.floor(p1) == p1, p2)
end

t.optional.integer = integer
function t.integerNonNegative(p1, p2) --[[ integerNonNegative | Line: 197 ]]
	cassert(if type(p1) == "number" then true else false, p2)
	cassert(IsFinite(p1), p2)
	cassert(math.floor(p1) == p1, p2)
	cassert(p1 >= 0, p2)
end

local function integerNonNegative(p1, p2) --[[ integerNonNegative | Line: 204 ]]
	if p1 == nil then
		return
	end

	cassert(if type(p1) == "number" then true else false, p2)
	cassert(IsFinite(p1), p2)
	cassert(math.floor(p1) == p1, p2)
	cassert(p1 >= 0, p2)
end

t.optional.integerNonNegative = integerNonNegative
function t.natural(p1, p2) --[[ natural | Line: 213 ]]
	cassert(if type(p1) == "number" then true else false, p2)
	cassert(IsFinite(p1), p2)
	cassert(math.floor(p1) == p1, p2)
	cassert(p1 > 0, p2)
end

local function natural(p1, p2) --[[ natural | Line: 220 ]]
	if p1 == nil then
		return
	end

	cassert(if type(p1) == "number" then true else false, p2)
	cassert(IsFinite(p1), p2)
	cassert(math.floor(p1) == p1, p2)
	cassert(p1 > 0, p2)
end

t.optional.natural = natural
function t.string(p1, p2) --[[ string | Line: 229 ]]
	local v1 = cassert

	v1(if type(p1) == "string" then true else false, p2)
end

local function string(p1, p2) --[[ string | Line: 233 ]]
	cassert(if p1 == nil then true else type(p1) == "string", p2)
end

t.optional.string = string

local function v2(p1, p2) --[[ UDim | Line: 241 ]]
	cassert(if p1 == nil then true else typeof(p1) == "UDim", p2)
end

t.optional.UDim = v2

local function v3(p1, p2) --[[ UDim2 | Line: 249 ]]
	cassert(if p1 == nil then true else typeof(p1) == "UDim2", p2)
end

t.optional.UDim2 = v3
function t.Color3(p1, p2) --[[ Color3 | Line: 256 ]]
	local v1 = cassert

	v1(if typeof(p1) == "Color3" then true else false, p2)
end

local function v4(p1, p2) --[[ Color3 | Line: 260 ]]
	if p1 == nil then
		return
	end

	local v1 = cassert

	v1(if typeof(p1) == "Color3" then true else false, p2)
end

t.optional.Color3 = v4
function t.ascii(p1, p2) --[[ ascii | Line: 266 | Upvalues: IsASCII (copy) ]]
	local v1 = cassert

	v1(if type(p1) == "string" then true else false, p2)
	cassert(IsASCII(p1), p2)
end

local function ascii(p1, p2) --[[ ascii | Line: 271 | Upvalues: IsASCII (copy) ]]
	if p1 == nil then
		return
	end

	local v1 = cassert

	v1(if type(p1) == "string" then true else false, p2)
	cassert(IsASCII(p1), p2)
end

t.optional.ascii = ascii
function t.username(p1, p2) --[[ username | Line: 278 | Upvalues: IsASCII (copy) ]]
	local v1 = cassert

	v1(if type(p1) == "string" then true else false, p2)
	cassert(IsASCII(p1), p2)
end

local function username(p1, p2) --[[ username | Line: 283 ]]
	if p1 == nil then
		return
	end

	cassert(if type(p1) == "string" then true else false, p2)
	cassert(if #p1 >= 3 then if #p1 <= 20 then true else false else false, p2)
	cassert(p1:find("^%w+$") ~= nil, p2)
	cassert(if p1:sub(1, 1) == "_" then false elseif p1:sub(-1) == "_" then false else true, p2)
	cassert(p1:find("__") == nil, p2)
	cassert(p1:find("^%d+$") == nil, p2)
end

t.optional.username = username
function t.uuid(p1, p2) --[[ uuid | Line: 302 ]]
	cassert(if type(p1) == "string" then true else false, p2)
	cassert(#p1 == 36, p2)
	cassert(p1:find("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") ~= nil, p2)
end

local function uuid(p1, p2) --[[ uuid | Line: 308 ]]
	if p1 == nil then
		return
	end

	cassert(if type(p1) == "string" then true else false, p2)
	cassert(#p1 == 36, p2)
	cassert(p1:find("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") ~= nil, p2)
end

t.optional.uuid = uuid
function t.uuidStripped(p1, p2) --[[ uuidStripped | Line: 316 ]]
	cassert(if type(p1) == "string" then true else false, p2)
	cassert(#p1 == 32, p2)
	cassert(p1:find("^%x+$") ~= nil, p2)
end

local function uuidStripped(p1, p2) --[[ uuidStripped | Line: 322 ]]
	if p1 == nil then
		return
	end

	cassert(if type(p1) == "string" then true else false, p2)
	cassert(#p1 == 32, p2)
	cassert(p1:find("^%x+$") ~= nil, p2)
end

t.optional.uuidStripped = uuidStripped
function t.FromGenerateUID(p1, p2) --[[ FromGenerateUID | Line: 330 | Upvalues: t (copy) ]]
	return t.UUIDv4StrippedUpper(p1, p2)
end

local function FromGenerateUID(p1, p2) --[[ FromGenerateUID | Line: 334 | Upvalues: t (copy) ]]
	return t.optional.UUIDv4StrippedUpper(p1, p2)
end

t.optional.FromGenerateUID = FromGenerateUID
function t.UUIDv4StrippedLower(p1, p2) --[[ UUIDv4StrippedLower | Line: 338 ]]
	cassert(if type(p1) == "string" then true else false, p2)
	cassert(#p1 == 32, p2)
	cassert(p1:find("^[0-9a-f]+$") ~= nil, p2)
	cassert(p1:sub(13, 13) == "4", p2)
	cassert(p1:sub(17, 17):find("[8-9a-b]") ~= nil, p2)
end

local function UUIDv4StrippedLower(p1, p2) --[[ UUIDv4StrippedLower | Line: 346 ]]
	if p1 == nil then
		return
	end

	cassert(if type(p1) == "string" then true else false, p2)
	cassert(#p1 == 32, p2)
	cassert(p1:find("^[0-9a-f]+$") ~= nil, p2)
	cassert(p1:sub(13, 13) == "4", p2)
	cassert(p1:sub(17, 17):find("[8-9a-b]") ~= nil, p2)
end

t.optional.UUIDv4StrippedLower = UUIDv4StrippedLower
function t.UUIDv4StrippedLowerFast(p1, p2) --[[ UUIDv4StrippedLowerFast | Line: 356 ]]
	cassert(if type(p1) == "string" then true else false, p2)
	cassert(#p1 == 32, p2)
end

local function UUIDv4StrippedLowerFast(p1, p2) --[[ UUIDv4StrippedLowerFast | Line: 361 ]]
	if p1 == nil then
		return
	end

	cassert(if type(p1) == "string" then true else false, p2)
	cassert(#p1 == 32, p2)
end

t.optional.UUIDv4StrippedLowerFast = UUIDv4StrippedLowerFast
function t.UUIDv4StrippedUpper(p1, p2) --[[ UUIDv4StrippedUpper | Line: 368 ]]
	cassert(if type(p1) == "string" then true else false, p2)
	cassert(#p1 == 32, p2)
	cassert(p1:find("^[0-9A-F]+$") ~= nil, p2)
	cassert(p1:sub(13, 13) == "4", p2)
	cassert(p1:sub(17, 17):find("[8-9A-B]") ~= nil, p2)
end

local function UUIDv4StrippedUpper(p1, p2) --[[ UUIDv4StrippedUpper | Line: 376 ]]
	if p1 == nil then
		return
	end

	cassert(if type(p1) == "string" then true else false, p2)
	cassert(#p1 == 32, p2)
	cassert(p1:find("^[0-9A-F]+$") ~= nil, p2)
	cassert(p1:sub(13, 13) == "4", p2)
	cassert(p1:sub(17, 17):find("[8-9A-B]") ~= nil, p2)
end

t.optional.UUIDv4StrippedUpper = UUIDv4StrippedUpper
function t.func(p1, p2) --[[ func | Line: 386 ]]
	local v1 = cassert

	v1(if type(p1) == "function" then true else false, p2)
end

local function func(p1, p2) --[[ func | Line: 390 ]]
	cassert(if p1 == nil then true else type(p1) == "function", p2)
end

t.optional.func = func
function t.table(p1, p2) --[[ table | Line: 398 ]]
	local v1 = cassert

	v1(if type(p1) == "table" then true else false, p2)
end

local function table(p1, p2) --[[ table | Line: 402 ]]
	cassert(if p1 == nil then true else type(p1) == "table", p2)
end

t.optional.table = table

local function generic(p1, p2, p3) --[[ generic | Line: 410 ]]
	local v1 = cassert

	v1(if type(p1) == "table" then true else false, p3)

	local v3 = #p1

	if v3 > 0 then
		local count = 0

		for k, v in pairs(p1) do
			count = count + 1
			cassert(if k == count then true else false, p3)
			cassert(if type(v) == p2 then true else false, p3)
		end

		cassert(count == v3, p3)
	else
		local v10 = cassert

		v10(next(p1) == nil, p3)
	end
end

t.array.generic = generic

local function notEmpty(p1, p2) --[[ notEmpty | Line: 425 ]]
	cassert(if type(p1) == "table" then true else false, p2)
	assert(#p1 > 0, "An empty array was provided")
end

t.array.notEmpty = notEmpty

local function custom(p1, p2, p3) --[[ custom | Line: 430 ]]
	local v1 = cassert

	v1(if type(p1) == "table" then true else false, p3)

	local v3 = #p1

	if v3 > 0 then
		local count = 0

		for k, v in pairs(p1) do
			count = count + 1
			cassert(if k == count then true else false, p3)
			p2(v, (p3 or 0) + 1)
		end

		cassert(count == v3, p3)
	else
		local v8 = cassert

		v8(next(p1) == nil, p3)
	end
end

t.array.custom = custom

local function uuid2(p1, p2) --[[ uuid | Line: 446 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.uuid, (p2 or 0) + 1)
end

t.array.uuid = uuid2

local function uuidStripped2(p1, p2) --[[ uuidStripped | Line: 450 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.uuidStripped, (p2 or 0) + 1)
end

t.array.uuidStripped = uuidStripped2

local function UUIDv4StrippedLower2(p1, p2) --[[ UUIDv4StrippedLower | Line: 454 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.UUIDv4StrippedLower, (p2 or 0) + 1)
end

t.array.UUIDv4StrippedLower = UUIDv4StrippedLower2

local function uniqueUUID(p1, p2) --[[ uniqueUUID | Line: 458 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.uuid, (p2 or 0) + 1)

	local t2 = {}

	for i, v in ipairs(p1) do
		cassert(not t2[v], p2)
		t2[v] = true
	end
end

t.array.uniqueUUID = uniqueUUID

local function uniqueUUIDStripped(p1, p2) --[[ uniqueUUIDStripped | Line: 467 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.uuidStripped, (p2 or 0) + 1)

	local t2 = {}

	for i, v in ipairs(p1) do
		cassert(not t2[v], p2)
		t2[v] = true
	end
end

t.array.uniqueUUIDStripped = uniqueUUIDStripped

local function uniqueUUIDv4StrippedLower(p1, p2) --[[ uniqueUUIDv4StrippedLower | Line: 476 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.UUIDv4StrippedLower, (p2 or 0) + 1)

	local t2 = {}

	for i, v in ipairs(p1) do
		cassert(not t2[v], p2)
		t2[v] = true
	end
end

t.array.uniqueUUIDv4StrippedLower = uniqueUUIDv4StrippedLower

local function uniqueUUIDv4StrippedLowerFast(p1, p2) --[[ uniqueUUIDv4StrippedLowerFast | Line: 485 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.UUIDv4StrippedLowerFast, (p2 or 0) + 1)

	local t2 = {}

	for i, v in ipairs(p1) do
		cassert(not t2[v], p2)
		t2[v] = true
	end
end

t.array.uniqueUUIDv4StrippedLowerFast = uniqueUUIDv4StrippedLowerFast

local function boolean2(p1, p2) --[[ boolean | Line: 494 | Upvalues: t (copy) ]]
	t.array.generic(p1, "boolean", (p2 or 0) + 1)
end

t.array.boolean = boolean2

local function number2(p1, p2) --[[ number | Line: 498 | Upvalues: t (copy) ]]
	t.array.generic(p1, "number", (p2 or 0) + 1)
end

t.array.number = number2

local function string2(p1, p2) --[[ string | Line: 502 | Upvalues: t (copy) ]]
	t.array.generic(p1, "string", (p2 or 0) + 1)
end

t.array.string = string2

local function table2(p1, p2) --[[ table | Line: 506 | Upvalues: t (copy) ]]
	t.array.generic(p1, "table", (p2 or 0) + 1)
end

t.array.table = table2

local function v5(p1, p2) --[[ Vector2 | Line: 510 | Upvalues: t (copy) ]]
	t.array.generic(p1, "Vector2", (p2 or 0) + 1)
end

t.array.Vector2 = v5

local function finiteVector2(p1, p2) --[[ finiteVector2 | Line: 514 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.finiteVector2, (p2 or 0) + 1)
end

t.array.finiteVector2 = finiteVector2

local function v6(p1, p2) --[[ Vector3 | Line: 518 | Upvalues: t (copy) ]]
	t.array.generic(p1, "Vector3", (p2 or 0) + 1)
end

t.array.Vector3 = v6

local function finiteVector3(p1, p2) --[[ finiteVector3 | Line: 522 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.finiteVector3, (p2 or 0) + 1)
end

t.array.finiteVector3 = finiteVector3

local function v7(p1, p2) --[[ CFrame | Line: 526 | Upvalues: t (copy) ]]
	t.array.generic(p1, "CFrame", (p2 or 0) + 1)
end

t.array.CFrame = v7

local function finiteCFrame(p1, p2) --[[ finiteCFrame | Line: 530 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.finiteCFrame, (p2 or 0) + 1)
end

t.array.finiteCFrame = finiteCFrame

local function integer2(p1, p2) --[[ integer | Line: 534 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.integer, (p2 or 0) + 1)
end

t.array.integer = integer2

local function positiveInteger2(p1, p2) --[[ positiveInteger | Line: 538 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.positiveInteger, (p2 or 0) + 1)
end

t.array.positiveInteger = positiveInteger2

local function Player(p1, p2) --[[ Player | Line: 542 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.Player, (p2 or 0) + 1)
end

t.array.Player = Player

local function finite2(p1, p2) --[[ finite | Line: 546 | Upvalues: t (copy) ]]
	t.array.custom(p1, t.finite, (p2 or 0) + 1)
end

t.array.finite = finite2

local function uniqueInteger(p1, p2) --[[ uniqueInteger | Line: 550 | Upvalues: t (copy) ]]
	local t2 = {}

	t.array.custom(p1, function(p1, p2) --[[ Line: 552 | Upvalues: t (ref), t2 (copy) ]]
		t.integer(p1, (p2 or 0) + 1)
		cassert(not t2[p1], p2)
		t2[p1] = true
	end, (p2 or 0) + 1)
end

t.array.uniqueInteger = uniqueInteger

local function uniquePlayer(p1, p2) --[[ uniquePlayer | Line: 559 | Upvalues: t (copy) ]]
	local t2 = {}

	t.array.custom(p1, function(p1, p2) --[[ Line: 561 | Upvalues: t (ref), t2 (copy) ]]
		t.Player(p1, (p2 or 0) + 1)
		cassert(not t2[p1], p2)
		t2[p1] = true
	end, (p2 or 0) + 1)
end

t.array.uniquePlayer = uniquePlayer

local function uniqueModel(p1, p2) --[[ uniqueModel | Line: 568 | Upvalues: t (copy) ]]
	local t2 = {}

	t.array.custom(p1, function(p1, p2) --[[ Line: 570 | Upvalues: t (ref), t2 (copy) ]]
		t.Model(p1, (p2 or 0) + 1)
		cassert(not t2[p1], p2)
		t2[p1] = true
	end, (p2 or 0) + 1)
end

t.array.uniqueModel = uniqueModel
function t.Vector2(p1, p2) --[[ Vector2 | Line: 577 ]]
	local v1 = cassert

	v1(if typeof(p1) == "Vector2" then true else false, p2)
end

local function v8(p1, p2) --[[ Vector2 | Line: 581 ]]
	cassert(if p1 == nil then true else typeof(p1) == "Vector2", p2)
end

t.optional.Vector2 = v8
function t.finiteVector2(p1, p2) --[[ finiteVector2 | Line: 589 ]]
	local v1 = cassert

	v1(if typeof(p1) == "Vector2" then true else false, p2)
	cassert(IsFiniteVec2(p1), p2)
end

local function finiteVector22(p1, p2) --[[ finiteVector2 | Line: 594 ]]
	if p1 == nil then
		return
	end

	local v1 = cassert

	v1(if typeof(p1) == "Vector2" then true else false, p2)
	cassert(IsFiniteVec2(p1), p2)
end

t.optional.finiteVector2 = finiteVector22
function t.Vector3(p1, p2) --[[ Vector3 | Line: 601 ]]
	local v1 = cassert

	v1(if typeof(p1) == "Vector3" then true else false, p2)
end

local function v9(p1, p2) --[[ Vector3 | Line: 605 ]]
	cassert(if p1 == nil then true else typeof(p1) == "Vector3", p2)
end

t.optional.Vector3 = v9
function t.finiteVector3(p1, p2) --[[ finiteVector3 | Line: 613 ]]
	local v1 = cassert

	v1(if typeof(p1) == "Vector3" then true else false, p2)
	cassert(IsFiniteVec(p1), p2)
end

local function finiteVector32(p1, p2) --[[ finiteVector3 | Line: 618 ]]
	if p1 == nil then
		return
	end

	local v1 = cassert

	v1(if typeof(p1) == "Vector3" then true else false, p2)
	cassert(IsFiniteVec(p1), p2)
end

t.optional.finiteVector3 = finiteVector32
function t.CFrame(p1, p2) --[[ CFrame | Line: 625 ]]
	local v1 = cassert

	v1(if typeof(p1) == "CFrame" then true else false, p2)
end

local function v10(p1, p2) --[[ CFrame | Line: 629 ]]
	cassert(if p1 == nil then true else typeof(p1) == "CFrame", p2)
end

t.optional.CFrame = v10
function t.finiteCFrame(p1, p2) --[[ finiteCFrame | Line: 637 ]]
	local v1 = cassert

	v1(if typeof(p1) == "CFrame" then true else false, p2)
	cassert(IsFiniteCFrame(p1), p2)
end

local function finiteCFrame2(p1, p2) --[[ finiteCFrame | Line: 642 ]]
	if p1 == nil then
		return
	end

	local v1 = cassert

	v1(if typeof(p1) == "CFrame" then true else false, p2)
	cassert(IsFiniteCFrame(p1), p2)
end

t.optional.finiteCFrame = finiteCFrame2
function t.Instance(p1, p2) --[[ Instance | Line: 649 ]]
	local v1 = cassert

	v1(if typeof(p1) == "Instance" then true else false, p2)
end

local function v11(p1, p2) --[[ Instance | Line: 653 ]]
	cassert(if p1 == nil then true else typeof(p1) == "Instance", p2)
end

t.optional.Instance = v11
function t.Player(p1, p2) --[[ Player | Line: 661 ]]
	cassert(if typeof(p1) == "Instance" then p1.ClassName == "Player" else false, p2)
end

local function Player2(p1, p2) --[[ Player | Line: 669 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1.ClassName == "Player" else false, p2)
end

t.optional.Player = Player2
function t.Model(p1, p2) --[[ Model | Line: 680 ]]
	cassert(if typeof(p1) == "Instance" then p1.ClassName == "Model" else false, p2)
end
function t.Sound(p1, p2) --[[ Sound | Line: 688 ]]
	cassert(if typeof(p1) == "Instance" then p1.ClassName == "Sound" else false, p2)
end

local function Sound(p1, p2) --[[ Sound | Line: 696 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1.ClassName == "Sound" else false, p2)
end

t.optional.Sound = Sound

local function Model(p1, p2) --[[ Model | Line: 707 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1.ClassName == "Model" else false, p2)
end

t.optional.Model = Model
function t.Attachment(p1, p2) --[[ Attachment | Line: 718 ]]
	cassert(if typeof(p1) == "Instance" then p1.ClassName == "Attachment" else false, p2)
end

local function Attachment(p1, p2) --[[ Attachment | Line: 726 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1.ClassName == "Attachment" else false, p2)
end

t.optional.Attachment = Attachment
function t.BasePart(p1, p2) --[[ BasePart | Line: 737 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("BasePart") else false, p2)
end

local function BasePart(p1, p2) --[[ BasePart | Line: 745 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("BasePart") else false, p2)
end

t.optional.BasePart = BasePart
function t.Tool(p1, p2) --[[ Tool | Line: 756 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("Tool") else false, p2)
end

local function Tool(p1, p2) --[[ Tool | Line: 764 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("Tool") else false, p2)
end

t.optional.Tool = Tool
function t.Motor6D(p1, p2) --[[ Motor6D | Line: 775 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("Motor6D") else false, p2)
end

local function Motor6D(p1, p2) --[[ Motor6D | Line: 783 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("Motor6D") else false, p2)
end

t.optional.Motor6D = Motor6D
function t.UIGradient(p1, p2) --[[ UIGradient | Line: 794 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("UIGradient") else false, p2)
end

local function UIGradient(p1, p2) --[[ UIGradient | Line: 802 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("UIGradient") else false, p2)
end

t.optional.UIGradient = UIGradient
function t.ImageLabel(p1, p2) --[[ ImageLabel | Line: 813 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("ImageLabel") else false, p2)
end

local function ImageLabel(p1, p2) --[[ ImageLabel | Line: 821 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("ImageLabel") else false, p2)
end

t.optional.ImageLabel = ImageLabel
function t.GuiObject(p1, p2) --[[ GuiObject | Line: 832 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("GuiObject") else false, p2)
end

local function GuiObject(p1, p2) --[[ GuiObject | Line: 840 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("GuiObject") else false, p2)
end

t.optional.GuiObject = GuiObject
function t.Frame(p1, p2) --[[ Frame | Line: 851 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("Frame") else false, p2)
end

local function Frame(p1, p2) --[[ Frame | Line: 859 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("Frame") else false, p2)
end

t.optional.Frame = Frame
function t.Folder(p1, p2) --[[ Folder | Line: 870 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("Folder") else false, p2)
end

local function Folder(p1, p2) --[[ Folder | Line: 878 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("Folder") else false, p2)
end

t.optional.Folder = Folder
function t.MeshPart(p1, p2) --[[ MeshPart | Line: 889 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("MeshPart") else false, p2)
end

local function MeshPart(p1, p2) --[[ MeshPart | Line: 897 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("MeshPart") else false, p2)
end

t.optional.MeshPart = MeshPart
function t.BillboardGui(p1, p2) --[[ BillboardGui | Line: 908 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("BillboardGui") else false, p2)
end

local function BillboardGui(p1, p2) --[[ BillboardGui | Line: 916 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("BillboardGui") else false, p2)
end

t.optional.BillboardGui = BillboardGui
function t.TextLabel(p1, p2) --[[ TextLabel | Line: 927 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("TextLabel") else false, p2)
end

local function TextLabel(p1, p2) --[[ TextLabel | Line: 935 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("TextLabel") else false, p2)
end

t.optional.TextLabel = TextLabel
function t.UIScale(p1, p2) --[[ UIScale | Line: 946 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("UIScale") else false, p2)
end

local function UIScale(p1, p2) --[[ UIScale | Line: 954 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("UIScale") else false, p2)
end

t.optional.UIScale = UIScale
function t.ScrollingFrame(p1, p2) --[[ ScrollingFrame | Line: 965 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("ScrollingFrame") else false, p2)
end

local function ScrollingFrame(p1, p2) --[[ ScrollingFrame | Line: 973 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("ScrollingFrame") else false, p2)
end

t.optional.ScrollingFrame = ScrollingFrame
function t.ModuleScript(p1, p2) --[[ ModuleScript | Line: 984 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("ModuleScript") else false, p2)
end

local function ModuleScript(p1, p2) --[[ ModuleScript | Line: 992 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("ModuleScript") else false, p2)
end

t.optional.ModuleScript = ModuleScript
function t.GuiButton(p1, p2) --[[ GuiButton | Line: 1003 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("GuiButton") else false, p2)
end

local function GuiButton(p1, p2) --[[ GuiButton | Line: 1011 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("GuiButton") else false, p2)
end

t.optional.GuiButton = GuiButton
function t.Humanoid(p1, p2) --[[ Humanoid | Line: 1022 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("Humanoid") else false, p2)
end

local function Humanoid(p1, p2) --[[ Humanoid | Line: 1030 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("Humanoid") else false, p2)
end

t.optional.Humanoid = Humanoid
function t.Animator(p1, p2) --[[ Animator | Line: 1041 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("Animator") else false, p2)
end

local function Animator(p1, p2) --[[ Animator | Line: 1049 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("Animator") else false, p2)
end

t.optional.Animator = Animator
function t.Animation(p1, p2) --[[ Animation | Line: 1060 ]]
	cassert(if typeof(p1) == "Instance" then p1:IsA("Animation") else false, p2)
end

local function Animation(p1, p2) --[[ Animation | Line: 1068 ]]
	cassert(if p1 == nil then true elseif typeof(p1) == "Instance" then p1:IsA("Animation") else false, p2)
end

t.optional.Animation = Animation

return t