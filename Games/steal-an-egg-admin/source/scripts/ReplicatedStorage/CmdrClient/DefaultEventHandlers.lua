-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local StarterGui = game:GetService("StarterGui")
local Window = require(script.Parent.CmdrInterface.Window)
return function(v1) -- line 8 | captures: StarterGui, Window
    v1:HandleEvent("Message", function(v2) -- line 9 | captures: StarterGui
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = ("[Announcement] %s"):format(v2),
            Color = Color3.fromRGB(249, 217, 56)
        })
    end)
    v1:HandleEvent("AddLine", function(...) -- line 12 | captures: Window
        Window:AddLine(...)
    end)
end
