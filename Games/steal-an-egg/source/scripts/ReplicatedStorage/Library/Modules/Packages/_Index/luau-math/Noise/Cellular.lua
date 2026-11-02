-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent:WaitForChild("Algebra"):WaitForChild("Vector"))
require(script.Parent.Parent:WaitForChild("Algebra"):WaitForChild("Matrix"))

local Solver = require(script.Parent:WaitForChild("Solver"))
local t = {}

t.__index = t
function t.Get(p1, p2) --[[ Get | Line: 14 ]]
	assert(if #p1.Points > 0 then true else false, "No points")

	local v3, v4, v5, v6, v7 = p1.translateVector(p2), nil, (1 / 0), nil, 0

	for i, v in ipairs(p1.Points) do
		local Magnitude = (v - v3).Magnitude

		if not v4 or Magnitude < v5 then
			v4 = v
			v5 = Magnitude
		end

		if not v6 or v7 < Magnitude then
			v6 = v
			v7 = Magnitude
		end
	end

	return p1:_Compile(v3, v5 / p1.SeparationLimit)
end
function t.Clone(p1) --[[ Clone | Line: 42 | Upvalues: t (copy) ]]
	return p1:_CopyConfiguration((t.new()))
end
function t.new(...) --[[ new | Line: 47 | Upvalues: Solver (copy), t (copy) ]]
	local v1 = Solver.new(...)

	v1.Points = {}
	setmetatable(v1, t)

	return v1
end
setmetatable(t, Solver)

return t