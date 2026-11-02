-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.interface({
    Uid = t.string,
    Egg = Eggs.SchemaValidation.SerializedSavedEgg
})
local v2 = {}
local v3 = { blank = false }
local v4 = t.literal(false)

v3.check = t.union(v4, v1)
v2.Egg = v3
v2.Unlocked = {
    blank = false,
    check = t.boolean
}
v2.TutorialSeen = {
    blank = false,
    check = t.boolean
}
v2.Deposited = {
    blank = 0,
    check = t.number
}
v2.LuckBoost = {
    blank = 0,
    check = t.number
}
v2.Uses = {
    blank = 0,
    check = t.number
}
v2.CostResetAt = {
    blank = 0,
    check = t.number
}
v2.TotalMutations = {
    blank = 0,
    check = t.number
}

local v5 = {}
local v6 = {}
for v7, v8 in v2 do
    v5[v7] = v8.check
    v6[v7] = v8.blank
end
table.freeze(v6)
local v9 = {
    IncubatorEgg = v1,
    State = t.interface(v5),
    MutateResult = t.interface({
        Uid = t.string,
        Egg = Eggs.SchemaValidation.SerializedSavedEgg,
        Mutation = t.string
    })
}

function v9.Blank() -- line 36 | captures: v6
    return (table.clone(v6))
end

return v9
