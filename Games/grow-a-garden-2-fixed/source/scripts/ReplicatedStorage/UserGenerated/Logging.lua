--credit to prince games studio
local RunService = game:GetService("RunService")
local Keys = require(game.ReplicatedStorage.UserGenerated.Lang.Keys)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local Stringify = require(game.ReplicatedStorage.UserGenerated.Strings.Stringify)
local t = {
	Pretty = true,
	IndentChar = " ",
	IndentSize = 2
}

local function GetPrefix(p1) --[[ GetPrefix | Line: 40 ]]
	local v1, v2, v3 = debug.info((p1 or 0) + 2, "sln")
	local v4 = ("%*:%*"):format(v1, v2)

	return ("[%*]"):format(if v3 then v4 .. (" %*"):format(v3) else v4)
end

local function Format(p1) --[[ Format | Line: 52 | Upvalues: Stringify (copy), t (copy) ]]
	if type(p1) == "string" then
		return p1
	end

	if typeof(p1) == "Instance" then
		return ("%*[%*]"):format(p1.ClassName, (p1:GetFullName()))
	end

	return Stringify.Serialize(p1, t)
end

local function FormatArgs(...) --[[ FormatArgs | Line: 62 | Upvalues: Stringify (copy), t (copy) ]]
	local v1 = table.pack(...)

	for i = 1, v1.n do
		local v2
		local v3 = v1[i]

		v2 = if type(v3) == "string" then v3 elseif typeof(v3) == "Instance" then ("%*[%*]"):format(v3.ClassName, (v3:GetFullName())) else Stringify.Serialize(v3, t)
		v1[i] = v2
	end

	return table.unpack(v1)
end

local v1, v2

if RunService:IsStudio() then
	v1 = print
	v2 = warn
else
	v1 = function(...) --[[ Line: 70 | Upvalues: FormatArgs (copy) ]]
		local v1 = task.spawn

		local function f2(p1, ...) --[[ Line: 71 | Upvalues: FormatArgs (ref) ]]
			print(p1, FormatArgs(...))
		end

		local v3, v4, v5 = debug.info(2, "sln")
		local v6 = ("%*:%*"):format(v3, v4)

		v1(f2, ("[%*]"):format(if v5 then v6 .. (" %*"):format(v5) else v6), ...)
	end
	v2 = function(...) --[[ Line: 75 | Upvalues: FormatArgs (copy) ]]
		local v1 = task.spawn

		local function f2(p1, ...) --[[ Line: 76 | Upvalues: FormatArgs (ref) ]]
			warn(p1, FormatArgs(...))
		end

		local v3, v4, v5 = debug.info(2, "sln")
		local v6 = ("%*:%*"):format(v3, v4)

		v1(f2, ("[%*]"):format(if v5 then v6 .. (" %*"):format(v5) else v6), ...)
	end
end

local function f3() --[[ Line: 88 ]] end

local t2 = {
	Trace = 1,
	Debug = 2,
	Info = 3,
	Warn = 4,
	Error = 5,
	Critical = 6,
	Off = 7
}

table.freeze(t2)

local t3 = {
	Trace = v1,
	Debug = v1,
	Info = v1,
	Warn = v2,
	Error = v2,
	Critical = v2,
	Off = f3
}

table.freeze(t3)

local v4 = Asserts.Set(Keys(t2))
local v5 = table.clone(t3)
local v6 = "Info"

local function SetLevel(p1, p2) --[[ SetLevel | Line: 117 | Upvalues: t2 (copy), v6 (ref), v5 (copy), t3 (copy), f3 (copy) ]]
	assert(t2[p1])
	assert(if p2 == nil then true elseif type(p2) == "boolean" then true else false)

	if v6 == p1 and not p2 then
		return
	end

	v6 = p1

	local v4 = assert(t2[p1])

	for k, v in pairs(t2) do
		if v4 <= v then
			v5[k] = t3[k]

			continue
		end

		v5[k] = f3
	end
end

SetLevel(v6, true)

local t4 = {
	Levels = t2,
	AssertLevel = v4
}

setmetatable(t4, {
	__index = v5
})
function t4.GetLevel() --[[ GetLevel | Line: 145 | Upvalues: v6 (ref) ]]
	return v6
end
function t4.SetLevel(p1) --[[ SetLevel | Line: 149 | Upvalues: SetLevel (copy) ]]
	SetLevel(p1)
end
function t4.Sink(p1) --[[ Sink | Line: 153 | Upvalues: v5 (copy) ]]
	return assert(v5[p1])
end

return table.freeze(t4)