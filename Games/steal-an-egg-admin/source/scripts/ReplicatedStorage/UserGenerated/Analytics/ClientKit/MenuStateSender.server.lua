-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GuiService = game:GetService("GuiService")
local MenuState = script.Parent:WaitForChild("MenuState")
GuiService.MenuOpened:Connect(function() -- line 8 | captures: MenuState
    MenuState:FireServer(true)
end)
GuiService.MenuClosed:Connect(function() -- line 11 | captures: MenuState
    MenuState:FireServer(false)
end)
