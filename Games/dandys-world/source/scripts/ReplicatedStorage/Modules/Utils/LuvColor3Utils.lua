--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- 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

-- https://lua.expert/
local LuvUtils = require(script.Parent.LuvUtils)
local t = {}

local function lerp(p1, p2, p3) --[[ lerp | Line: 19 ]]
	return p1 + (p2 - p1) * p3
end

function t.lerp(p1, p2, p3) --[[ lerp | Line: 32 | Upvalues: t (copy) ]]
	assert(if typeof(p1) == "Color3" then true else false, "Bad color0")
	assert(if typeof(p2) == "Color3" then true else false, "Bad color1")
	assert(if type(p3) == "number" then true else false, "Bad t")

	if p3 == 0 then
		return p1
	end

	if p3 == 1 then
		return p2
	end

	local v4, v5, v6 = unpack(t.fromColor3(p1))
	local v7, v8, v9 = unpack(t.fromColor3(p2))

	return t.toColor3({ v4 + (((v7 - v4) % 360 + 540) % 360 - 180) * p3, v5 + (v8 - v5) * p3, v6 + (v9 - v6) * p3 })
end
function t.desaturate(p1, p2) --[[ desaturate | Line: 62 | Upvalues: t (copy) ]]
	local v1, v2, v3 = unpack(t.fromColor3(p1))

	return t.toColor3({ v1, v2 * math.clamp(1 - p2, 0, 1), v3 })
end
function t.darken(p1, p2) --[[ darken | Line: 74 | Upvalues: t (copy) ]]
	local v1, v2, v3 = unpack(t.fromColor3(p1))

	return t.toColor3({ v1, v2, v3 * math.clamp(1 - p2, 0, 1) })
end
function t.lighten(p1, p2) --[[ lighten | Line: 86 | Upvalues: t (copy) ]]
	local v1, v2, v3 = unpack(t.fromColor3(p1))

	return t.toColor3({ v1, v2, v3 + (100 - v3) * math.clamp(p2, 0, 1) })
end
function t.fromColor3(p1) --[[ fromColor3 | Line: 98 | Upvalues: LuvUtils (copy) ]]
	assert(typeof(p1) == "Color3", "Bad color3")

	return LuvUtils.rgb_to_hsluv({ p1.R, p1.G, p1.B })
end
function t.toColor3(p1) --[[ toColor3 | Line: 109 | Upvalues: LuvUtils (copy) ]]
	assert(type(p1) == "table", "Bad hsluv")

	local v2, v3, v4 = unpack(LuvUtils.hsluv_to_rgb(p1))

	return Color3.new(math.clamp(v2, 0, 1), math.clamp(v3, 0, 1), (math.clamp(v4, 0, 1)))
end

return t