-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Bootloader = require(script.Parent.Parent.Parent.Parent.Parent.Bootloader)

local function GetModules() -- line 4
    local v1 = {}
    for v2, v3 in ipairs(script:GetChildren()) do
        if v3:IsA("ModuleScript") then
            table.insert(v1, v3)
        end
    end
    return v1
end

return Bootloader((GetModules()))
