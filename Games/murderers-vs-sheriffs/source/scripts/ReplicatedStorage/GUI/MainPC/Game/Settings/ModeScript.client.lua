-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Mode_0 = script.Parent:WaitForChild("Mode");
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
l_Mode_0:WaitForChild("Button").Activated:Connect(function() --[[ Line: 5 ]]
    l_WindowService_0:ToggleFrame("ModeBrowser");
end);