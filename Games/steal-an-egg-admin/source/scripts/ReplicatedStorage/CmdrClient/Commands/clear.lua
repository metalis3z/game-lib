-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local v1 = {
    Name = "clear",
    Description = "Clear all lines above the entry line of the Cmdr window.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {}
}

function v1.ClientRun() -- line 13 | captures: Players
    local Cmdr = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr")
    local Frame = Cmdr:WaitForChild("Frame")
    if Cmdr and Frame then
        for v2, v3 in pairs(Frame:GetChildren()) do
            if v3.Name == "Line" and v3:IsA("TextBox") then
                v3:Destroy()
            end
        end
    end
    return ""
end

return v1
