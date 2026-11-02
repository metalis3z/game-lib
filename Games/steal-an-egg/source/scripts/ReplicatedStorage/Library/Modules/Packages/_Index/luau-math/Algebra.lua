-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Types)

local Vector = require(script:WaitForChild("Vector"))
local Matrix = require(script:WaitForChild("Matrix"))
local t = {}

t.__index = t
t.Vector = Vector
t.Matrix = Matrix

local Lerp = require(script.Lerp)

function t.lerp(p1, p2, p3) --[[ lerp | Line: 39 | Upvalues: Lerp (copy) ]]
	return Lerp(p1, p2, p3)
end

local Ease = require(script.Ease)

function t.ease(p1, p2, p3) --[[ ease | Line: 52 | Upvalues: Ease (copy) ]]
	return Ease(p1, p2, p3)
end
function t.bezier(...) --[[ bezier | Line: 63 | Upvalues: Lerp (copy), Vector (copy) ]]
	local t = { ... }

	assert(#t > 1, "not enough points")

	local function v2(p1, p2) --[[ solve | Line: 66 | Upvalues: Lerp (ref), Vector (ref), v2 (copy) ]]
		local function typeLerp(p1, p2, p3) --[[ typeLerp | Line: 68 | Upvalues: Lerp (ref), Vector (ref) ]]
			if typeof(p1) == "Vector2" then
				return Lerp(p1, p2, p3)
			end

			if typeof(p1) == "Vector3" then
				return Lerp(p1, p2, p3)
			end

			if typeof(p1) == "table" and getmetatable(p1) == Vector then
				return Lerp(p1, p2, p3)
			end

			return nil
		end

		local t = {}

		for i = 1, #p2 - 1 do
			local v1 = typeLerp(p2[i], p2[i + 1], p1)

			if v1 ~= nil then
				table.insert(t, v1)
			end
		end

		if #t <= 1 then
			return t[1]
		end

		return v2(p1, t)
	end

	return function(p1) --[[ Line: 94 | Upvalues: t (copy), v2 (copy) ]]
		assert(if t == nil then false else true)

		local v22 = v2(p1, t)

		assert(v22 ~= nil)

		return v22
	end
end

return t