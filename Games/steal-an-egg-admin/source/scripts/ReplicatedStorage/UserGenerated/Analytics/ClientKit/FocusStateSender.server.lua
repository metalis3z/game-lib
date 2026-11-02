-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local UserInputService = game:GetService("UserInputService")
local FocusState = script.Parent:WaitForChild("FocusState")
UserInputService.WindowFocused:Connect(function() -- line 8 | captures: FocusState
    FocusState:FireServer(true)
end)
UserInputService.WindowFocusReleased:Connect(function() -- line 11 | captures: FocusState
    FocusState:FireServer(false)
end)
