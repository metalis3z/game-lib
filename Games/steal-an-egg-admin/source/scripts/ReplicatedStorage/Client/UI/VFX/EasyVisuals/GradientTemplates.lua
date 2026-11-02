-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
for v2, v3 in script:GetDescendants() do
    if v3:IsA("ModuleScript") then
        v1[v3.Name] = require(v3)
    end
end
return v1
