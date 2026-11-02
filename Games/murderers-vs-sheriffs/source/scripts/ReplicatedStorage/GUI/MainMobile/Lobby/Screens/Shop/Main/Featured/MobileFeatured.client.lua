-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Event_0 = script.Parent.Event;
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
l_Event_0.ItemFrame.ItemContainer.Container.ActionButton.Activated:connect(function()
    l_WindowService_0:ToggleFrame("CurrentEvent");
    _G.ReturnGUI();
    _G.SetDock(false);
end);