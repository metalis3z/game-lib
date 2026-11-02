-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent.Parent;
local l_Lobby_0 = script.Parent.Parent.Lobby;
local _ = l_Lobby_0.Screens;
local _ = l_Parent_0.Game;
local l_TradeRequest_0 = l_Lobby_0.Leaderboard.Container.OverlayMenu.TradeRequest;
local l_LeaderBar_0 = l_Lobby_0.LeaderBar;
local l_GameBar_0 = l_Lobby_0.GameBar;
local l_TradeGUI_Phone_0 = game.Players.LocalPlayer.PlayerGui.TradeGUI_Phone;
local l_TradeModule_0 = game.ReplicatedStorage.Modules.TradeModule;
local v9 = require(l_TradeModule_0);
v9.GUI.RequestFrame = l_TradeRequest_0;
v9.GUI.TradeGUI = l_TradeGUI_Phone_0;
v9.GUI.Actions = l_TradeGUI_Phone_0.Container.Trade.Actions;
v9.GUI.YourOffer = l_TradeGUI_Phone_0.Container.Trade.YourOffer;
v9.GUI.TheirOffer = l_TradeGUI_Phone_0.Container.Trade.TheirOffer;
v9.GUI.ItemLayout = l_TradeModule_0.TradeGridLayout;
_G.NewTradeRequest = function(v10)
    l_LeaderBar_0.Main.Plus.TradeRequest.Visible = v10;
    l_GameBar_0.Main.Plus.TradeRequest.Visible = v10;
end;
local v11, v12 = game.ReplicatedStorage.Trade.GetTradeStatus:InvokeServer();
v9.UpdateTradeRequestWindow(v11, v12);
v9.ConnectRequestWindow();
v9.ConnectActions();
v9.ConnectTabButtons();
l_TradeGUI_Phone_0.Changed:connect(function()
    l_TradeGUI_Phone_0.ClickBlocker.Visible = l_TradeGUI_Phone_0.Enabled;
end);
local l_LocalPlayer_0 = game.Players.LocalPlayer;
l_LocalPlayer_0.Changed:connect(function()
    l_TradeGUI_Phone_0.Container.Processing.Visible = l_LocalPlayer_0:GetAttribute("PerformingTrade") == true;
end);