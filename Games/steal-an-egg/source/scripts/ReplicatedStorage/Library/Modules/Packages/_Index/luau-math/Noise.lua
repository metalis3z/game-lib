-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Algebra.Vector)
require(script.Parent.Algebra.Matrix)
require(script.Solver)

local t = {}

t.__index = t
t.Random = require(script:WaitForChild("Solver"))
t.Simplex = require(script:WaitForChild("Simplex"))
t.Cellular = require(script:WaitForChild("Cellular"))
t.Voronoi = require(script:WaitForChild("Voronoi"))

return t