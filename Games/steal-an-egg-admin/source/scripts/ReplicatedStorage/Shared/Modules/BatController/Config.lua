-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Workspace = game:GetService("Workspace")
local v1 = {
    Range = 15,
    HitTolerance = 2,
    TargetViewSamplePadding = 0.05,
    MaximumTargetViewAge = 0.35,
    DragonEggEventHitboxScalar = 2.5,
    DragonEggEventActiveAttribute = "DragonEggEventActive"
}

function v1.GetHitboxScalar() -- line 15 | captures: Workspace, v1
    if Workspace:GetAttribute(v1.DragonEggEventActiveAttribute) == true then
        return v1.DragonEggEventHitboxScalar
    end
    return 1
end

return table.freeze(v1)
