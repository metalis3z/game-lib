-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local StarterGui = game:GetService("StarterGui")
local v1 = { "OverlayUI", "ScreenGui", "ShiftLockButton" }
task.wait(3)
for v2, v3 in StarterGui:GetChildren() do
    if not table.find(v1, v3.Name) and v3:IsA("ScreenGui") and v3.ResetOnSpawn then
        error("ScreenGui '" .. v3.Name .. "' has ResetOnSpawn enabled, which is not allowed.")
    end
end
