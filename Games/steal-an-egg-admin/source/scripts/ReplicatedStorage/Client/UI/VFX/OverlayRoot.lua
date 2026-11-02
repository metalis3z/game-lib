-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    gui = "PlayerGui",
    name = "OverlayUI"
}
local LocalPlayer = game:GetService("Players").LocalPlayer
return function() -- line 8 | captures: LocalPlayer
    return LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("OverlayUI")
end
