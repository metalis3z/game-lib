-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	FONT_COLOR_RGB = {
		Start = "<font color=\"rgb(%s,%s,%s)\">",
		End = "</font>"
	},
	FONT_COLOR_HEX = {
		Start = "<font color=\"#%s\">",
		End = "</font>"
	},
	FONT_SIZE = {
		Start = "<font size=\"%d\">",
		End = "</font>"
	},
	FONT_FACE = {
		Start = "<font face=\"%s\">",
		End = "</font>"
	},
	FONT_FAMILY = {
		Start = "<font family=\"%s\">",
		End = "</font>"
	},
	FONT_WEIGHT = {
		Start = "<font weight=\"%s\">",
		End = "</font>"
	},
	FONT_TRANSPARENCY = {
		Start = "<font transparency=\"%s\">",
		End = "</font>"
	},
	STROKE = {
		Start = "<stroke color=\"#%s\" joins=\"%s\" thickness=\"%s\" transparency=\"%s\">",
		End = "</stroke>"
	},
	BOLD = {
		Start = "<b>",
		End = "</b>"
	},
	ITALIC = {
		Start = "<i>",
		End = "</i>"
	},
	UNDERLINE = {
		Start = "<u>",
		End = "</u>"
	},
	STRIKETHROUGH = {
		Start = "<s>",
		End = "</s>"
	},
	UPPERCASE = {
		Start = "<uppercase>",
		End = "</uppercase>"
	},
	SMALLCAPS = {
		Start = "<smallcaps>",
		End = "</smallcaps>"
	}
}
local t2 = {}
local t3 = {}
local t4 = {}

t4.__index = t4

local function GenerateCustomHandlerFunction(p1) --[[ GenerateCustomHandlerFunction | Line: 65 | Upvalues: t (copy) ]]
	return function(p1) --[[ Line: 66 | Upvalues: t (ref), p1 (copy) ]]
		local v12 = t[p1].Start:format(p1)

		return function(p1) --[[ Line: 68 | Upvalues: v12 (copy), t (ref), p1 (ref) ]]
			return string.format("%s%s%s", v12, p1, t[p1].End)
		end
	end
end

local function GenerateDirectFunction(p1) --[[ GenerateDirectFunction | Line: 74 | Upvalues: t (copy) ]]
	return function(p13) --[[ Line: 75 | Upvalues: t (ref), p1 (copy) ]]
		local v1 = t[p1]

		return string.format("%s%s%s", v1.Start, p13, v1.End)
	end
end

local function GenerateColorFunction(p1) --[[ GenerateColorFunction | Line: 81 | Upvalues: t (copy) ]]
	return function(p1) --[[ Line: 82 | Upvalues: p1 (copy), t (ref) ]]
		return string.format("%s%s%s", t.FONT_COLOR_RGB.Start:format(math.floor(p1.R * 255), math.floor(p1.G * 255), (math.floor(p1.B * 255))), p1, t.FONT_COLOR_RGB.End)
	end
end

local function ValidateHex(p1) --[[ ValidateHex | Line: 95 ]]
	if typeof(p1) ~= "string" then
		return false
	end

	return string.match(p1:gsub("#", ""), "^%x%x%x%x%x%x$") ~= nil
end

local v1 = "FONT_SIZE"

function t3.size(p1) --[[ Line: 66 | Upvalues: t (copy), v1 (copy) ]]
	local v12 = t[v1].Start:format(p1)

	return function(p1) --[[ Line: 68 | Upvalues: v12 (copy), t (ref), v1 (ref) ]]
		return string.format("%s%s%s", v12, p1, t[p1].End)
	end
end

local v2 = "FONT_FACE"

function t3.face(p1) --[[ Line: 66 | Upvalues: t (copy), v2 (copy) ]]
	local v12 = t[v2].Start:format(p1)

	return function(p1) --[[ Line: 68 | Upvalues: v12 (copy), t (ref), v2 (ref) ]]
		return string.format("%s%s%s", v12, p1, t[p1].End)
	end
end

local v3 = "FONT_FAMILY"

function t3.family(p1) --[[ Line: 66 | Upvalues: t (copy), v3 (copy) ]]
	local v12 = t[v3].Start:format(p1)

	return function(p1) --[[ Line: 68 | Upvalues: v12 (copy), t (ref), v3 (ref) ]]
		return string.format("%s%s%s", v12, p1, t[p1].End)
	end
end

local v4 = "FONT_WEIGHT"

function t3.weight(p1) --[[ Line: 66 | Upvalues: t (copy), v4 (copy) ]]
	local v12 = t[v4].Start:format(p1)

	return function(p1) --[[ Line: 68 | Upvalues: v12 (copy), t (ref), v4 (ref) ]]
		return string.format("%s%s%s", v12, p1, t[p1].End)
	end
end

local v5 = "FONT_TRANSPARENCY"

function t3.transparency(p1) --[[ Line: 66 | Upvalues: t (copy), v5 (copy) ]]
	local v12 = t[v5].Start:format(p1)

	return function(p1) --[[ Line: 68 | Upvalues: v12 (copy), t (ref), v5 (ref) ]]
		return string.format("%s%s%s", v12, p1, t[p1].End)
	end
end
function t3.stroke(p1) --[[ Line: 109 | Upvalues: t (copy) ]]
	local v5 = t.STROKE.Start:format(string.format("#%s", p1.Color:ToHex()), p1.Joins or "Round", p1.Thickness or 1, p1.Transparency or 0)

	return function(p1) --[[ Line: 115 | Upvalues: v5 (copy), t (ref) ]]
		return string.format("%s%s%s", v5, p1, t.STROKE.End)
	end
end
function t3.color(...) --[[ Line: 120 | Upvalues: t (copy) ]]
	local t2 = { ... }
	local v1 = t2[1]
	local v2 = if typeof(v1) == "string" then string.match(v1:gsub("#", ""), "^%x%x%x%x%x%x$") ~= nil else false
	local v4 = if typeof(v1) == "Color3" then true else false
	local v5 = if v4 then v1 else Color3.fromRGB(v1, t2[2], t2[3])
	local v6 = if v2 then t.FONT_COLOR_HEX.Start:format(v1:gsub("#", "")) else t.FONT_COLOR_RGB.Start:format(math.floor(v5.R * 255), math.floor(v5.G * 255), (math.floor(v5.B * 255)))

	return function(p1) --[[ Line: 143 | Upvalues: v6 (ref), t (ref) ]]
		return string.format("%s%s%s", v6, p1, t.FONT_COLOR_RGB.End)
	end
end

local v6 = "BOLD"

function t2.bold(p13) --[[ Line: 75 | Upvalues: t (copy), v6 (copy) ]]
	local v1 = t[v6]

	return string.format("%s%s%s", v1.Start, p13, v1.End)
end

local v7 = "ITALIC"

function t2.italic(p13) --[[ Line: 75 | Upvalues: t (copy), v7 (copy) ]]
	local v1 = t[v7]

	return string.format("%s%s%s", v1.Start, p13, v1.End)
end

local v8 = "UNDERLINE"

function t2.underline(p13) --[[ Line: 75 | Upvalues: t (copy), v8 (copy) ]]
	local v1 = t[v8]

	return string.format("%s%s%s", v1.Start, p13, v1.End)
end

local v9 = "STRIKETHROUGH"

function t2.strikethrough(p13) --[[ Line: 75 | Upvalues: t (copy), v9 (copy) ]]
	local v1 = t[v9]

	return string.format("%s%s%s", v1.Start, p13, v1.End)
end

local v10 = "UPPERCASE"

function t2.uppercase(p13) --[[ Line: 75 | Upvalues: t (copy), v10 (copy) ]]
	local v1 = t[v10]

	return string.format("%s%s%s", v1.Start, p13, v1.End)
end

local v11 = "SMALLCAPS"

function t2.smallcaps(p13) --[[ Line: 75 | Upvalues: t (copy), v11 (copy) ]]
	local v1 = t[v11]

	return string.format("%s%s%s", v1.Start, p13, v1.End)
end

local v12 = Color3.fromRGB(255, 255, 255)

function t2.white(p1) --[[ Line: 82 | Upvalues: v12 (copy), t (copy) ]]
	return string.format("%s%s%s", t.FONT_COLOR_RGB.Start:format(math.floor(v12.R * 255), math.floor(v12.G * 255), (math.floor(v12.B * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v13 = Color3.fromRGB(0, 0, 0)

function t2.black(p1) --[[ Line: 82 | Upvalues: v13 (copy), t (copy) ]]
	return string.format("%s%s%s", t.FONT_COLOR_RGB.Start:format(math.floor(v13.R * 255), math.floor(v13.G * 255), (math.floor(v13.B * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v14 = Color3.fromRGB(255, 0, 0)

function t2.red(p1) --[[ Line: 82 | Upvalues: v14 (copy), t (copy) ]]
	return string.format("%s%s%s", t.FONT_COLOR_RGB.Start:format(math.floor(v14.R * 255), math.floor(v14.G * 255), (math.floor(v14.B * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v15 = Color3.fromRGB(153, 51, 0)

function t2.brown(p1) --[[ Line: 82 | Upvalues: v15 (copy), t (copy) ]]
	return string.format("%s%s%s", t.FONT_COLOR_RGB.Start:format(math.floor(v15.R * 255), math.floor(v15.G * 255), (math.floor(v15.B * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v16 = Color3.fromRGB(255, 153, 0)

function t2.orange(p1) --[[ Line: 82 | Upvalues: v16 (copy), t (copy) ]]
	return string.format("%s%s%s", t.FONT_COLOR_RGB.Start:format(math.floor(v16.R * 255), math.floor(v16.G * 255), (math.floor(v16.B * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v17 = Color3.fromRGB(255, 255, 0)

function t2.yellow(p1) --[[ Line: 82 | Upvalues: v17 (copy), t (copy) ]]
	return string.format("%s%s%s", t.FONT_COLOR_RGB.Start:format(math.floor(v17.R * 255), math.floor(v17.G * 255), (math.floor(v17.B * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v18 = Color3.fromRGB(153, 255, 0)

function t2.lime(p1) --[[ Line: 82 | Upvalues: v18 (copy), t (copy) ]]
	return string.format("%s%s%s", t.FONT_COLOR_RGB.Start:format(math.floor(v18.R * 255), math.floor(v18.G * 255), (math.floor(v18.B * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v19 = Color3.fromRGB(0, 255, 0)

function t2.green(p1) --[[ Line: 82 | Upvalues: v19 (copy), t (copy) ]]
	return string.format("%s%s%s", t.FONT_COLOR_RGB.Start:format(math.floor(v19.R * 255), math.floor(v19.G * 255), (math.floor(v19.B * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v20 = Color3.fromRGB(0, 0, 255)

function t2.blue(p1) --[[ Line: 82 | Upvalues: v20 (copy), t (copy) ]]
	return string.format("%s%s%s", t.FONT_COLOR_RGB.Start:format(math.floor(v20.R * 255), math.floor(v20.G * 255), (math.floor(v20.B * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v21 = Color3.fromRGB(102, 0, 153)

function t2.purple(p1) --[[ Line: 82 | Upvalues: v21 (copy), t (copy) ]]
	return string.format("%s%s%s", t.FONT_COLOR_RGB.Start:format(math.floor(v21.R * 255), math.floor(v21.G * 255), (math.floor(v21.B * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v22 = Color3.fromRGB(255, 0, 255)

function t2.pink(p1) --[[ Line: 82 | Upvalues: v22 (copy), t (copy) ]]
	return string.format("%s%s%s", t.FONT_COLOR_RGB.Start:format(math.floor(v22.R * 255), math.floor(v22.G * 255), (math.floor(v22.B * 255))), p1, t.FONT_COLOR_RGB.End)
end
function t4.new(p1) --[[ new | Line: 167 | Upvalues: t3 (copy), t2 (copy) ]]
	local t = {}
	local t4 = {}
	local t5 = {}

	t.Formatters = t5

	local v1 = nil
	local v2 = nil

	function t4.__call(p1, ...) --[[ Line: 177 | Upvalues: v1 (ref), t5 (copy) ]]
		local list = { ... }

		if v1 then
			local v12 = v1

			v1 = nil

			return v12(unpack(list))
		end

		local t = {}

		for i, v in ipairs(list) do
			for i2, v2 in ipairs(t5) do
				v = v2(v)
			end

			table.insert(t, v)
		end

		return unpack(t)
	end
	function t4.__index(p1, p2) --[[ Line: 196 | Upvalues: t3 (ref), v1 (ref), t5 (copy), v2 (ref), t2 (ref) ]]
		local v12 = t3[p2]

		if v12 then
			v1 = function(...) --[[ Line: 199 | Upvalues: v12 (copy), t5 (ref), v2 (ref) ]]
				table.insert(t5, (v12(...)))

				return v2
			end

			return v2
		end

		local v22 = t2[p2]

		if v22 then
			table.insert(t5, v22)

			return p1
		end
	end

	if p1 then
		t4.__index(t, p1)
	end

	v2 = setmetatable(t, t4)

	return v2
end

return setmetatable({}, {
	__index = function(p1, p2) --[[ __index | Line: 223 | Upvalues: t4 (copy) ]]
		return t4.new(p2)
	end,
	__newindex = function() --[[ __newindex | Line: 226 ]]
		error("Chalk is READONLY")
	end
})