-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

function v1.SetAnchored(v2, v3) -- line 9 | captures: t
    t.strict(t.instanceIsA("Model"))(v2)
    t.strict(t.boolean)(v3)
    for v4, v5 in v2:QueryDescendants("BasePart") do
        v5.Anchored = v3
    end
end

function v1.DisableAllPhysics(v6, v7) -- line 18 | captures: t
    t.strict(t.Instance)(v6)
    t.strict(t.optional(t.boolean))(v7)
    for v8, v9 in v6:QueryDescendants("BasePart") do
        v9.CanCollide = false
        v9.CanQuery = v7 == true
        v9.CanTouch = false
        v9.Massless = true
    end
end

function v1.SetCollisionGroup(v10, v11) -- line 33 | captures: t
    t.strict(t.instanceIsA("Model"))(v10)
    t.strict(t.string)(v11)
    for v12, v13 in v10:QueryDescendants("BasePart") do
        v13.CollisionGroup = v11
    end
end

return table.freeze(v1)
