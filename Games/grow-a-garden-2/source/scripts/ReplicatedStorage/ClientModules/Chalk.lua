--credit to prince games studio
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

t3.__index = t3

local function GenerateCustomHandlerFunction(p1) --[[ GenerateCustomHandlerFunction | Line: 92 | Upvalues: t (copy) ]]
	return function(p1) --[[ Line: 93 | Upvalues: t (ref), p1 (copy) ]]
		local v12 = t[p1].Start:format(p1)

		return function(p1) --[[ Line: 96 | Upvalues: v12 (copy), t (ref), p1 (ref) ]]
			return ("%*%*%*"):format(v12, p1, t[p1].End)
		end
	end
end

local function GenerateChalkDataFunction(p1) --[[ GenerateChalkDataFunction | Line: 102 | Upvalues: t (copy) ]]
	return function(p13) --[[ Line: 103 | Upvalues: t (ref), p1 (copy) ]]
		local v1 = t[p1]

		return ("%*%*%*"):format(v1.Start, p13, v1.End)
	end
end

local function GenerateColorFunction(p1) --[[ GenerateColorFunction | Line: 109 | Upvalues: t (copy) ]]
	return function(p1) --[[ Line: 110 | Upvalues: p1 (copy), t (ref) ]]
		return ("%*%*%*"):format(t.FONT_COLOR_RGB.Start:format(math.floor(p1.r * 255), math.floor(p1.g * 255), (math.floor(p1.b * 255))), p1, t.FONT_COLOR_RGB.End)
	end
end

local function ValidateHex(p1) --[[ ValidateHex | Line: 121 ]]
	if typeof(p1) == "string" then
		return string.match(p1:gsub("#", ""), "^%x%x%x%x%x%x$")
	end
end

local t4 = {}
local v1 = "FONT_SIZE"

function t4.size(p1) --[[ Line: 93 | Upvalues: t (copy), v1 (copy) ]]
	local v12 = t[v1].Start:format(p1)

	return function(p1) --[[ Line: 96 | Upvalues: v12 (copy), t (ref), v1 (ref) ]]
		return ("%*%*%*"):format(v12, p1, t[p1].End)
	end
end

local v2 = "FONT_FACE"

function t4.face(p1) --[[ Line: 93 | Upvalues: t (copy), v2 (copy) ]]
	local v12 = t[v2].Start:format(p1)

	return function(p1) --[[ Line: 96 | Upvalues: v12 (copy), t (ref), v2 (ref) ]]
		return ("%*%*%*"):format(v12, p1, t[p1].End)
	end
end

local v3 = "FONT_FAMILY"

function t4.family(p1) --[[ Line: 93 | Upvalues: t (copy), v3 (copy) ]]
	local v12 = t[v3].Start:format(p1)

	return function(p1) --[[ Line: 96 | Upvalues: v12 (copy), t (ref), v3 (ref) ]]
		return ("%*%*%*"):format(v12, p1, t[p1].End)
	end
end

local v4 = "FONT_WEIGHT"

function t4.weight(p1) --[[ Line: 93 | Upvalues: t (copy), v4 (copy) ]]
	local v12 = t[v4].Start:format(p1)

	return function(p1) --[[ Line: 96 | Upvalues: v12 (copy), t (ref), v4 (ref) ]]
		return ("%*%*%*"):format(v12, p1, t[p1].End)
	end
end

local v5 = "FONT_TRANSPARENCY"

function t4.transparency(p1) --[[ Line: 93 | Upvalues: t (copy), v5 (copy) ]]
	local v12 = t[v5].Start:format(p1)

	return function(p1) --[[ Line: 96 | Upvalues: v12 (copy), t (ref), v5 (ref) ]]
		return ("%*%*%*"):format(v12, p1, t[p1].End)
	end
end
function t4.stroke(p1) --[[ Line: 135 | Upvalues: t (copy) ]]
	local v5 = t.STROKE.Start:format(("#%*"):format((p1.Color:ToHex())), p1.Joins or "Round", p1.Thickness or 1, p1.Transparency or 0)

	return function(p1) --[[ Line: 145 | Upvalues: v5 (copy), t (ref) ]]
		return ("%*%*%*"):format(v5, p1, t.STROKE.End)
	end
end
function t4.color(...) --[[ Line: 149 | Upvalues: t (copy) ]]
	local t2 = { ... }
	local v1 = t2[1]
	local v2 = if typeof(v1) == "string" then string.match(v1:gsub("#", ""), "^%x%x%x%x%x%x$") else nil
	local v6 = if typeof(t2[1]) == "Color3" then true else false
	local v7 = t2[1]
	local v8 = if v6 and v7 then v7 else Color3.fromRGB(v7, t2[2], t2[3])
	local v9, v10, v11, v12, v13, v14, v15

	if v2 then
		v9 = t.FONT_COLOR_HEX.Start:format(v7:gsub("#", ""))

		if not v9 then
			v10 = t.FONT_COLOR_RGB.Start
			v11 = v8.R * 255
			v12 = math.floor(v11)
			v13 = v8.G * 255
			v14 = math.floor(v13)
			v15 = v8.B * 255
			v9 = v10:format(v12, v14, (math.floor(v15)))
		end
	else
		v10 = t.FONT_COLOR_RGB.Start
		v11 = v8.R * 255
		v12 = math.floor(v11)
		v13 = v8.G * 255
		v14 = math.floor(v13)
		v15 = v8.B * 255
		v9 = v10:format(v12, v14, (math.floor(v15)))
	end

	return function(p1) --[[ Line: 163 | Upvalues: v9 (copy), t (ref) ]]
		return ("%*%*%*"):format(v9, p1, t.FONT_COLOR_RGB.End)
	end
end

local v6 = "BOLD"

function t2.bold(p13) --[[ Line: 103 | Upvalues: t (copy), v6 (copy) ]]
	local v1 = t[v6]

	return ("%*%*%*"):format(v1.Start, p13, v1.End)
end

local v7 = "ITALIC"

function t2.italic(p13) --[[ Line: 103 | Upvalues: t (copy), v7 (copy) ]]
	local v1 = t[v7]

	return ("%*%*%*"):format(v1.Start, p13, v1.End)
end

local v8 = "UNDERLINE"

function t2.underline(p13) --[[ Line: 103 | Upvalues: t (copy), v8 (copy) ]]
	local v1 = t[v8]

	return ("%*%*%*"):format(v1.Start, p13, v1.End)
end

local v9 = "STRIKETHROUGH"

function t2.strikethrough(p13) --[[ Line: 103 | Upvalues: t (copy), v9 (copy) ]]
	local v1 = t[v9]

	return ("%*%*%*"):format(v1.Start, p13, v1.End)
end

local v10 = "UPPERCASE"

function t2.uppercase(p13) --[[ Line: 103 | Upvalues: t (copy), v10 (copy) ]]
	local v1 = t[v10]

	return ("%*%*%*"):format(v1.Start, p13, v1.End)
end

local v11 = "SMALLCAPS"

function t2.smallcaps(p13) --[[ Line: 103 | Upvalues: t (copy), v11 (copy) ]]
	local v1 = t[v11]

	return ("%*%*%*"):format(v1.Start, p13, v1.End)
end

local v12 = Color3.fromRGB(255, 255, 255)

function t2.white(p1) --[[ Line: 110 | Upvalues: v12 (copy), t (copy) ]]
	return ("%*%*%*"):format(t.FONT_COLOR_RGB.Start:format(math.floor(v12.r * 255), math.floor(v12.g * 255), (math.floor(v12.b * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v13 = Color3.fromRGB(0, 0, 0)

function t2.black(p1) --[[ Line: 110 | Upvalues: v13 (copy), t (copy) ]]
	return ("%*%*%*"):format(t.FONT_COLOR_RGB.Start:format(math.floor(v13.r * 255), math.floor(v13.g * 255), (math.floor(v13.b * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v14 = Color3.fromRGB(255, 0, 0)

function t2.red(p1) --[[ Line: 110 | Upvalues: v14 (copy), t (copy) ]]
	return ("%*%*%*"):format(t.FONT_COLOR_RGB.Start:format(math.floor(v14.r * 255), math.floor(v14.g * 255), (math.floor(v14.b * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v15 = Color3.fromRGB(153, 51, 0)

function t2.brown(p1) --[[ Line: 110 | Upvalues: v15 (copy), t (copy) ]]
	return ("%*%*%*"):format(t.FONT_COLOR_RGB.Start:format(math.floor(v15.r * 255), math.floor(v15.g * 255), (math.floor(v15.b * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v16 = Color3.fromRGB(255, 153, 0)

function t2.orange(p1) --[[ Line: 110 | Upvalues: v16 (copy), t (copy) ]]
	return ("%*%*%*"):format(t.FONT_COLOR_RGB.Start:format(math.floor(v16.r * 255), math.floor(v16.g * 255), (math.floor(v16.b * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v17 = Color3.fromRGB(255, 255, 0)

function t2.yellow(p1) --[[ Line: 110 | Upvalues: v17 (copy), t (copy) ]]
	return ("%*%*%*"):format(t.FONT_COLOR_RGB.Start:format(math.floor(v17.r * 255), math.floor(v17.g * 255), (math.floor(v17.b * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v18 = Color3.fromRGB(153, 255, 0)

function t2.lime(p1) --[[ Line: 110 | Upvalues: v18 (copy), t (copy) ]]
	return ("%*%*%*"):format(t.FONT_COLOR_RGB.Start:format(math.floor(v18.r * 255), math.floor(v18.g * 255), (math.floor(v18.b * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v19 = Color3.fromRGB(0, 255, 0)

function t2.green(p1) --[[ Line: 110 | Upvalues: v19 (copy), t (copy) ]]
	return ("%*%*%*"):format(t.FONT_COLOR_RGB.Start:format(math.floor(v19.r * 255), math.floor(v19.g * 255), (math.floor(v19.b * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v20 = Color3.fromRGB(0, 0, 255)

function t2.blue(p1) --[[ Line: 110 | Upvalues: v20 (copy), t (copy) ]]
	return ("%*%*%*"):format(t.FONT_COLOR_RGB.Start:format(math.floor(v20.r * 255), math.floor(v20.g * 255), (math.floor(v20.b * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v21 = Color3.fromRGB(102, 0, 153)

function t2.purple(p1) --[[ Line: 110 | Upvalues: v21 (copy), t (copy) ]]
	return ("%*%*%*"):format(t.FONT_COLOR_RGB.Start:format(math.floor(v21.r * 255), math.floor(v21.g * 255), (math.floor(v21.b * 255))), p1, t.FONT_COLOR_RGB.End)
end

local v22 = Color3.fromRGB(255, 0, 255)

function t2.pink(p1) --[[ Line: 110 | Upvalues: v22 (copy), t (copy) ]]
	return ("%*%*%*"):format(t.FONT_COLOR_RGB.Start:format(math.floor(v22.r * 255), math.floor(v22.g * 255), (math.floor(v22.b * 255))), p1, t.FONT_COLOR_RGB.End)
end
function t3.new(p1) --[[ new | Line: 188 | Upvalues: t4 (copy), t2 (copy) ]]
	local t = {}
	local t3 = {}
	local t5 = {}

	t.Formatters = t5

	local v1 = nil
	local v2 = nil

	function t3.__call(p1, ...) --[[ __call | Line: 196 | Upvalues: v1 (ref), t5 (copy) ]]
		local t = { ... }

		if v1 then
			local v12 = v1

			v1 = nil

			return v12(unpack(t))
		end

		local t2 = {}

		for v2, v3 in t do
			for v4, v5 in t5 do
				v3 = v5(v3)
			end

			table.insert(t2, v3)
		end

		return unpack(t2)
	end
	function t3.__index(p1, p2) --[[ __index | Line: 220 | Upvalues: t4 (ref), v1 (ref), t5 (copy), v2 (ref), t2 (ref) ]]
		local v12 = t4[p2]

		if v12 then
			v1 = function(...) --[[ Line: 224 | Upvalues: v12 (copy), t5 (ref), v2 (ref) ]]
				table.insert(t5, (v12(...)))

				return v2
			end

			return v2
		end

		table.insert(t5, t2[p2])

		return p1
	end
	t3:__index(p1)
	v2 = setmetatable(t, t3)

	return v2
end

return setmetatable({}, {
	__index = function(p1, p2) --[[ __index | Line: 249 | Upvalues: t3 (copy) ]]
		return t3.new(p2)
	end,
	__newindex = function() --[[ __newindex | Line: 252 ]]
		return error("Chalk is READONLY")
	end
})