-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_SpectateService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("SpectateService"));
local l_Game_0 = script.Parent.Parent:WaitForChild("Game");
local l_Spectate_0 = l_Game_0:WaitForChild("Dock"):WaitForChild("Spectate");
local l_Spectate_1 = l_Game_0:WaitForChild("Spectate");
local function v4() --[[ Line: 9 ]] --[[ Name: onSpectateStarted ]]
    l_Spectate_1.Visible = true;
end;
local function v5() --[[ Line: 13 ]] --[[ Name: onSpectateCancelled ]]
    l_Spectate_1.Visible = false;
end;
local function v7(v6) --[[ Line: 17 ]] --[[ Name: onSpectateTargetChanged ]]
    l_Spectate_1.CodeImage.PlayerName.Text = v6.Name;
end;
local function v8() --[[ Line: 21 ]] --[[ Name: onSpectateButtonActivated ]]
    l_SpectateService_0:ToggleSpectate();
end;
l_SpectateService_0.SpectateStarted.Event:Connect(v4);
l_SpectateService_0.SpectateCancelled.Event:Connect(v5);
l_SpectateService_0.SpectateTargetChanged.Event:Connect(v7);
l_Spectate_1.Right.Activated:Connect(function() --[[ Line: 30 ]]
    l_SpectateService_0:NavigateSpectate(1);
end);
l_Spectate_1.Left.Activated:Connect(function() --[[ Line: 33 ]]
    l_SpectateService_0:NavigateSpectate(-1);
end);
l_Spectate_0.Activated:Connect(v8);