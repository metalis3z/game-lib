-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_SpectateService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("SpectateService"));
local l_Lobby_0 = script.Parent.Parent:WaitForChild("Lobby");
local l_Spectate_0 = l_Lobby_0:WaitForChild("Dock"):WaitForChild("Spectate");
local l_Spectate_1 = l_Lobby_0:WaitForChild("Screens"):WaitForChild("Spectate");
local function v4()
    l_Spectate_1.Visible = true;
end;
local function v5()
    l_Spectate_1.Visible = false;
end;
local function v7(v6)
    l_Spectate_1.PlayerName.Text = v6.Name;
end;
local function v8()
    l_SpectateService_0:ToggleSpectate();
end;
l_SpectateService_0.SpectateStarted.Event:Connect(v4);
l_SpectateService_0.SpectateCancelled.Event:Connect(v5);
l_SpectateService_0.SpectateTargetChanged.Event:Connect(v7);
l_Spectate_1.Right.Activated:Connect(function()
    l_SpectateService_0:NavigateSpectate(1);
end);
l_Spectate_1.Left.Activated:Connect(function()
    l_SpectateService_0:NavigateSpectate(-1);
end);
l_Spectate_0.Activated:Connect(v8);
_G.CancelSpectate = l_SpectateService_0.CancelSpectate;