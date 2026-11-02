-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EmitDescendants = require(script.Parent.EmitDescendants)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local AddDebris = require(script.Parent.AddDebris)
local Weld = require(script.Parent.Weld)
local __DEBRIS = workspace:WaitForChild("__DEBRIS")
local v1 = t.interface({
	AddToDebris = t.optional(t.boolean),
	DestroyDelay = t.optional(t.number),
	AutoParentLikeOriginal = t.optional(t.union(t.boolean, t.literal("Debris"))),
	WeldToPart = t.optional(t.instanceIsA("BasePart")),
	OptimizeForMobile = t.optional(t.boolean),
	Properties = t.optional(t.interface({
		Position = t.optional(t.Vector3),
		CFrame = t.optional(t.CFrame),
		Parent = t.optional(t.Instance)
	}))
})

return function(p1, p2) --[[ Line: 46 | Upvalues: Asserts (copy), v1 (copy), __DEBRIS (copy), AddDebris (copy), Weld (copy), EmitDescendants (copy) ]]
	Asserts.BasePart(p1)

	local v12 = if p2 then p2 else {}

	assert(v1(v12))

	local v3 = p1:Clone()

	if v12.Properties then
		for v4, v5 in v12.Properties do
			v3[v4] = v5
		end
	end

	if v12.AutoParentLikeOriginal then
		v3.Parent = if v12.AutoParentLikeOriginal == "Debris" then __DEBRIS else p1.Parent or __DEBRIS
	end

	if v12.AddToDebris then
		AddDebris(v3, v12.DestroyDelay or 10)
	end

	if v12.WeldToPart then
		v3.CFrame = v12.WeldToPart.CFrame
		v3.Anchored = false
		Weld(v3, v12.WeldToPart)
	end

	EmitDescendants(v3, v12.OptimizeForMobile)

	return v3
end