-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)

local function applyMutationVisuals(p1, p2) --[[ applyMutationVisuals | Line: 8 | Upvalues: Mutations (copy) ]]
	local v1 = Mutations.Exists(p2)

	assert(v1, (("Mutation %* does not exist"):format(p2)))
	p1.Image = assert(Mutations.GetMutation(p2)).Icon or ""
end

return function(p1, p2, p3) --[[ Line: 14 | Upvalues: Asserts (copy), Mutations (copy) ]]
	local v1 = assert(p1:FindFirstChild("icon"))

	v1.Visible = false
	Asserts.array.string(p3)

	if #p3 == 0 then
		return
	end

	for i, v in ipairs(p3) do
		local v2 = v1:Clone()

		v2.Name = v
		v2.Visible = true

		local v3 = Mutations.Exists(v)

		assert(v3, (("Mutation %* does not exist"):format(v)))
		v2.Image = assert(Mutations.GetMutation(v)).Icon or ""
		v2.Parent = p1
	end
end