local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_PolicyService_0 = game:GetService("PolicyService");
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Game_0 = script.Parent.Parent.Game;
local v4 = require(game.ReplicatedStorage.Modules.TradeModule);
local v5 = require(game.ReplicatedStorage.Modules.LevelModule);
local l_Trade_0 = game:GetService("ReplicatedStorage"):WaitForChild("Trade");
local l_status_0, l_result_0 = pcall(function()
    return l_PolicyService_0:GetPolicyInfoForPlayerAsync(l_LocalPlayer_0);
end);
local v9 = v5.GetLevel(l_ProfileData_0.NewXP);
local v10 = true;
if v9 < 10 then
    v10 = l_ProfileData_0.Prestige > 0;
end;
if not l_status_0 then
    warn("PolicyService error: " .. l_result_0);
elseif not l_result_0.IsPaidItemTradingAllowed then
    l_Game_0.Leaderboard.Inspect.Trade.Visible = false;
    v4.RequestsEnabled = false;
    return "Trading Not Allowed";
end;
if not v10 then
    l_Game_0.Leaderboard.Inspect.Trade.Visible = false;
    v4.RequestsEnabled = false;
end;
local l_Leaderboard_0 = l_Game_0.Leaderboard;
local _ = l_Leaderboard_0.Inspect;
local l_TradeRequest_0 = l_Leaderboard_0.Container.TradeRequest;
local l_TradeGUI_0 = game.Players.LocalPlayer.PlayerGui.TradeGUI;
v4.GUI.RequestFrame = l_TradeRequest_0;
v4.GUI.TradeGUI = game.Players.LocalPlayer.PlayerGui.TradeGUI;
v4.GUI.Actions = l_TradeGUI_0.Container.Trade.Actions;
v4.GUI.YourOffer = l_TradeGUI_0.Container.Trade.YourOffer;
v4.GUI.TheirOffer = l_TradeGUI_0.Container.Trade.TheirOffer;
local v15, v16 = game.ReplicatedStorage.Trade.GetTradeStatus:InvokeServer();
v4.UpdateTradeRequestWindow(v15, v16);
v4.ConnectRequestWindow();
v4.ConnectActions();
v4.ConnectTabButtons();
local l_ToggleRequests_0 = l_Game_0.Leaderboard.Container.ToggleRequests;
l_ToggleRequests_0.On.Visible = v4.RequestsEnabled;
l_ToggleRequests_0.Off.Visible = not v4.RequestsEnabled;
l_ToggleRequests_0.On.Activated:Connect(function() --[[ Line: 78 ]]
    l_ToggleRequests_0.On.Visible = false;
    l_ToggleRequests_0.Off.Visible = true;
    v4.RequestsEnabled = false;
    game.ReplicatedStorage.Trade.DeclineRequest:FireServer();
    l_Trade_0.SetRequestsEnabled:FireServer(false);
    l_TradeRequest_0.Visible = false;
end);
l_ToggleRequests_0.Off.Activated:Connect(function() --[[ Line: 86 ]]
    l_ToggleRequests_0.On.Visible = true;
    l_ToggleRequests_0.Off.Visible = false;
    l_Trade_0.SetRequestsEnabled:FireServer(true);
    v4.RequestsEnabled = true;
end);
l_TradeGUI_0.Changed:Connect(function() --[[ Line: 94 ]]
    l_TradeGUI_0.ClickBlocker.Visible = l_TradeGUI_0.Enabled;
end);
local l_LocalPlayer_1 = game.Players.LocalPlayer;
l_LocalPlayer_1.Changed:connect(function() --[[ Line: 100 ]]
    l_TradeGUI_0.Container.Visible = l_LocalPlayer_1:GetAttribute("PerformingTrade") ~= true;
    l_TradeGUI_0.Processing.Visible = l_LocalPlayer_1:GetAttribute("PerformingTrade") == true;
end);