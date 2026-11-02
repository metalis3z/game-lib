-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local HttpService = game:GetService("HttpService")
local t2 = {}
local t3 = {}
local v1 = 0
local v2 = false

local function escape(p1) --[[ escape | Line: 8 | Upvalues: t2 (copy) ]]
	return p1:gsub("[%c\"\\]", function(p13) --[[ Line: 9 | Upvalues: t2 (ref) ]]
		return "\127" .. t2[p13]
	end)
end

local function unescape(p1) --[[ unescape | Line: 14 | Upvalues: t2 (copy) ]]
	return p1:gsub("\127(.)", function(p1) --[[ Line: 15 | Upvalues: t2 (ref) ]]
		return t2[p1]
	end)
end

local function copy(p1) --[[ copy | Line: 20 ]]
	return table.clone(p1)
end

local function toBase93(p1) --[[ toBase93 | Line: 24 | Upvalues: t3 (copy) ]]
	local v1 = ""

	repeat
		local v2 = p1 % 93

		v1 = t3[v2] .. v1
		p1 = (p1 - v2) / 93
	until p1 == 0

	return v1
end

local function toBase10(p1) --[[ toBase10 | Line: 34 | Upvalues: t3 (copy) ]]
	local sum = 0

	for i = 1, #p1 do
		sum = sum + 93 ^ (i - 1) * t3[p1:sub(-i, -i)]
	end

	return sum
end

local function init() --[[ init | Line: 42 | Upvalues: t3 (copy), v1 (ref), t2 (copy), v2 (ref) ]]
	for i = 32, 127 do
		if i ~= 34 and i ~= 92 then
			local v12 = string.char(i)

			t3[v12] = v1
			t3[v1] = v12
			v1 = v1 + 1
		end
	end

	for j = 1, 34 do
		local v22 = ({ 34, 92, 127 })[j - 31] or j
		local v3 = string.char(v22)
		local v4 = string.char(v22 + 31)

		t2[v3] = v4
		t2[v4] = v3
	end

	v2 = true
end

local function encodeInternal(p1) --[[ encodeInternal | Line: 62 | Upvalues: v2 (ref), init (copy), t3 (copy), t2 (copy) ]]
	if not v2 then
		init()
	end

	local v22 = table.clone(t3)
	local v3 = p1:gsub("[%c\"\\]", function(p13) --[[ Line: 9 | Upvalues: t2 (ref) ]]
		return "\127" .. t2[p13]
	end)
	local v4, v5, v6, v7, v8, v9, count = "", v22, 1, {}, 0, {}, #v22

	for i = 1, #v3 do
		local v10
		local v11 = v3:sub(i, i)
		local v12 = v4 .. v11

		if v5[v12] then
			v4 = v12

			continue
		end

		local v13 = v5[v4]
		local v14 = ""

		repeat
			local v15 = v13 % 93

			v14 = t3[v15] .. v14
			v13 = (v13 - v15) / 93
		until v13 == 0

		if v6 < #v14 then
			v7[v6] = v8
			v10 = v14
			v6 = #v14
			v8 = 0
		else
			v10 = v14
		end

		v9[#v9 + 1] = (" "):rep(v6 - #v10) .. v10
		count = count + 1
		v5[v12] = count
		v5[count] = v12
		v4, v8 = v11, v8 + 1
	end

	local v16 = v5[v4]
	local v17 = ""

	repeat
		local v18 = v16 % 93

		v17 = t3[v18] .. v17
		v16 = (v16 - v18) / 93
	until v16 == 0

	local v19

	if v6 < #v17 then
		v7[v6] = v8
		v19 = v17
		v6 = #v17
		v8 = 0
	else
		v19 = v17
	end

	v9[#v9 + 1] = (" "):rep(v6 - #v19) .. v19
	v7[v6] = v8 + 1

	return table.concat(v7, ",") .. "|" .. table.concat(v9)
end

local function decodeInternal(p1) --[[ decodeInternal | Line: 108 | Upvalues: v2 (ref), init (copy), t3 (copy), toBase10 (copy), unescape (copy) ]]
	if not v2 then
		init()
	end

	local v22 = table.clone(t3)
	local v3, v4 = p1:match("(.-)|(.*)")
	local t, sum, v5, v6 = {}, 1, {}, v22

	for v7 in v3:gmatch("%d+") do
		local v8 = #t + 1

		t[v8] = v4:sub(sum, sum + v7 * v8 - 1)
		sum = sum + v7 * v8
	end

	local v9 = nil

	for i = 1, #t do
		for v10 in t[i]:gmatch(("."):rep(i)) do
			local v11 = v6[toBase10(v10)]

			if v9 then
				if v11 then
					v5[#v5 + 1] = v11
					v6[#v6 + 1] = v9 .. v11:sub(1, 1)
				else
					v11 = v9 .. v9:sub(1, 1)
					v5[#v5 + 1] = v11
					v6[#v6 + 1] = v11
				end
			else
				v5[1] = v11
			end

			v9 = v11
		end
	end

	return unescape(table.concat(v5))
end

function t.Encode(p1) --[[ Encode | Line: 144 | Upvalues: HttpService (copy), encodeInternal (copy) ]]
	local v1

	if typeof(p1) == "table" then
		local ok, result = pcall(function() --[[ Line: 147 | Upvalues: HttpService (ref), p1 (ref) ]]
			return HttpService:JSONEncode(p1)
		end)

		if not (ok and result) then
			warn("Failed to convert table to string")

			return
		end

		p1 = result
		v1 = true
	else
		v1 = false
	end

	local v2 = encodeInternal(p1)

	if utf8.len(p1) > utf8.len(v2) then
		return v2
	end

	return p1, v1
end
function t.Decode(p1) --[[ Decode | Line: 164 | Upvalues: decodeInternal (copy) ]]
	local v1 = decodeInternal(p1)

	if v1 then
		return v1
	end

	warn("Failed to decode string")
end

return t