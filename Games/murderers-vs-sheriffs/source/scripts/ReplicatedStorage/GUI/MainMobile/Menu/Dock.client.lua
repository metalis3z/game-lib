-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local _ = game.Players.LocalPlayer;
local l_Parent_0 = script.Parent.Parent;
local l_Parent_1 = l_Parent_0.Parent;
local l_Lobby_0 = l_Parent_0.Lobby;
local l_Dock_0 = l_Lobby_0.Dock;
local l_Game_0 = l_Parent_0.Game;
local l_Screens_0 = l_Lobby_0.Screens;
local l_LeaderBar_0 = l_Lobby_0.LeaderBar;
local l_GameBar_0 = l_Lobby_0.GameBar;
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemPopupService")).AnimationTargetLocation = l_Dock_0:WaitForChild("Inventory");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local v13 = "Lobby";
game.ReplicatedStorage.Remotes.Gameplay.Fade.OnClientEvent:connect(function()
    v13 = "Game";
end);
_G.ReturnGUI = function()
    if v13 == "Lobby" then
        for _, v15 in pairs(l_Screens_0:GetChildren()) do
            if v15:IsA("Frame") then
                v15.Visible = v15.Name == "Waiting";
            end;
        end;
        for _, v17 in pairs(l_Parent_0:GetChildren()) do
            if v17:IsA("Frame") then
                v17.Visible = v17.Name == "Lobby";
            end;
        end;
        l_Dock_0.BG.Visible = false;
        l_GuiService_0.TouchControlsEnabled = true;
        l_LeaderBar_0.Visible = true;
        return;
    else
        if v13 == "Game" then
            for _, v19 in pairs(l_Parent_0:GetChildren()) do
                if v19:IsA("Frame") then
                    local v20 = true;
                    if v19.Name ~= "Game" then
                        v20 = v19.Name == "Lobby";
                    end;
                    v19.Visible = v20;
                end;
            end;
            l_GuiService_0.TouchControlsEnabled = true;
            l_Parent_1:SetTopbarTransparency(0.5);
            l_GameBar_0.Visible = true;
        end;
        return;
    end;
end;
local v21 = true;
local v22 = false;
_G.SetDock = function(v23)
    if v22 then
        return;
    else
        v21 = v23 ~= nil and v23 or not v21;
        local v24 = v23 ~= nil and 0 or 0.2;
        local v25 = v23 ~= nil and 0 or 0.2;
        local v26 = TweenInfo.new(v25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        l_TweenService_0:Create(l_Dock_0, v26, {
            Position = UDim2.new(0, v21 and 0 or -100, 0, 0)
        }):Play();
        l_TweenService_0:Create(l_Screens_0, v26, {
            Position = UDim2.new(0, v21 and 100 or 0, 0, 0), 
            Size = UDim2.new(1, v21 and -100 or 0, 1, 0)
        }):Play();
        if v21 then
            l_WindowService_0:CloseAllFrames();
        end;
        l_Screens_0.Waiting.Hide.TextLabel.Text = v21 and "<" or ">";
        l_Screens_0.Waiting.Hide.BackgroundTransparency = v21 and "0.3" or "0.75";
        wait(v24);
        v22 = false;
        return;
    end;
end;
l_Screens_0.Waiting.Hide.MouseButton1Click:connect(_G.SetDock);
_G.ViewLobbyFrame = function(v27)
    if v27 == "Spectate" then
        l_GuiService_0.TouchControlsEnabled = not l_GuiService_0.TouchControlsEnabled;
	elseif v27 == "Shop" then
		l_WindowService_0:ToggleFrame("Shop");
		_G.CancelSpectate();
	else
        l_Screens_0[v27].Visible = not l_Screens_0[v27].Visible;
        _G.CancelSpectate();
    end;
    if v27 == "Christmas2018" then
        if l_Game_0.Emotes.Visible == false then
            game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
        end;
        l_Game_0.Visible = false;
        _G.SetDock(true);
    end;
    for _, v29 in pairs(l_Screens_0:GetChildren()) do
        if v29:IsA("Frame") and v29.Name ~= v27 then
            v29.Visible = false;
        end;
    end;
    if not l_Screens_0[v27].Visible then
        (v13 == "Game" and l_GameBar_0 or l_LeaderBar_0).Visible = true;
        l_Screens_0.Waiting.Visible = true;
        l_Dock_0.BG.Visible = false;
        l_GuiService_0.TouchControlsEnabled = true;
        if l_Game_0.Emotes.Visible == false then
            game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true);
        end;
        l_Game_0.Visible = true;
        return;
    else
        l_Dock_0.BG.Visible = true;
        return;
    end;
end;
for _, v31 in pairs(l_Dock_0:GetChildren()) do
    if v31:IsA("GuiButton") then
        v31.MouseButton1Click:connect(function()
            if v21 and not v22 then
                if l_Game_0.Emotes.Visible == false then
                    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
                end;
                l_Game_0.Visible = false;
                _G.ViewLobbyFrame(v31.Name);
            end;
        end);
    end;
end;
l_GuiService_0.TouchControlsEnabled = true;
game.StarterGui:SetCore("ChatActive", false);
game.StarterGui:SetCore("ChatWindowPosition", UDim2.new(0, 100, 0, 100));