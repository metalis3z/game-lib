-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local v1 = {
    Name = "hover",
    Description = "Returns the name of the player you are hovering over.",
    Group = "DefaultUtil",
    Args = {}
}

function v1.ClientRun() -- line 12 | captures: Players
    local Target = Players.LocalPlayer:GetMouse().Target
    if Target then
        local v2 = Players:GetPlayerFromCharacter(Target:FindFirstAncestorOfClass("Model"))
        if v2 then
            return v2.Name or ""
        end
    end
    return ""
end

return v1
