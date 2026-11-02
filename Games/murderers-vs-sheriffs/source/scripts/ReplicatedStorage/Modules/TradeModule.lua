local v0 = {};
local l_Trade_0 = game.ReplicatedStorage.Trade;
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local v4 = require(script.Parent.InventoryModule);
local v5 = require(game.ReplicatedStorage.Modules.ItemModule);
v0.GUI = {};
v0.RequestsEnabled = true;
v0.TradeInventory = nil;
_G.NewTradeRequest = function()
end;
v0.SendTradeRequest = function(v8)
    if not l_Trade_0.SendRequest:InvokeServer(game.Players[v8]) then
        v0.UpdateTradeRequestWindow("SendingRequest", {
            Receiver = {
                Name = v8
            }
        });
    end;
end;
v0.UpdateTradeRequestWindow = function(v9, v10)
    local l_RequestFrame_0 = v0.GUI.RequestFrame;
    for _, v13 in pairs(l_RequestFrame_0:GetChildren()) do
        v13.Visible = v13.Name == v9;
    end;
    l_RequestFrame_0.Visible = true;
    _G.NewTradeRequest(false);
    if v9 == "SendingRequest" then
        l_RequestFrame_0.SendingRequest.Username.Text = v10.Receiver.Name;
        return;
    elseif v9 == "ReceivingRequest" then
        l_RequestFrame_0.ReceivingRequest.Username.Text = v10.Sender.Name;
        _G.NewTradeRequest(true);
        return;
    else
        l_RequestFrame_0.Visible = false;
        return;
    end;
end;
v0.ConnectRequestWindow = function() --[[ Line: 66 ]]
    v0.GUI.RequestFrame.SendingRequest.Cancel.MouseButton1Click:connect(function()
        v0.GUI.RequestFrame.Visible = false;
        l_Trade_0.CancelRequest:FireServer();
    end);
    v0.GUI.RequestFrame.ReceivingRequest.Accept.MouseButton1Click:connect(function()
        v0.GUI.RequestFrame.Visible = false;
        l_Trade_0.AcceptRequest:FireServer();
        _G.NewTradeRequest(false);
    end);
    v0.GUI.RequestFrame.ReceivingRequest.Decline.MouseButton1Click:connect(function()
        v0.GUI.RequestFrame.Visible = false;
        l_Trade_0.DeclineRequest:FireServer();
        _G.NewTradeRequest(false);
    end);
end;
l_Trade_0.DeclineRequest.OnClientEvent:connect(function()
    v0.UpdateTradeRequestWindow();
    _G.NewTradeRequest(false);
end);
l_Trade_0.CancelRequest.OnClientEvent:Connect(function()
    v0.UpdateTradeRequestWindow();
end);
l_Trade_0.RequestSent.OnClientEvent:Connect(function(v14)
    if v0.RequestsEnabled then
        v0.UpdateTradeRequestWindow("ReceivingRequest", {
            Sender = {
                Name = v14.Name
            }
        });
    end;
end);
l_Trade_0.SendRequest.OnClientInvoke = function(v15)
    if v0.RequestsEnabled then
        v0.UpdateTradeRequestWindow("ReceivingRequest",{
            Sender = {
                Name = v15.Name
            }
        });
    end;
    return v0.RequestsEnabled;
end;
local v18 = {};
local function v22(v19)
    for _, v21 in pairs(v19:GetChildren()) do
        if v21:IsA("Frame") then
            v21.Visible = false;
            if v18[v21] then
                v18[v21]:disconnect();
            end;
        end;
    end;
end;
local function v34(v23, v24)
    for v25, v26 in v24 do
        local v27 = v26[1] or v26.ItemID;
        local v28 = v26[2] or v26.Amount;
        local v29 = v26[3] or v26.ItemType;
        local v30 = {};
        for v31, v32 in l_Sync_0[v29][v27] do
            v30[v31] = v32;
        end;
        v30.DataType = v29;
        v30.Amount = v28;
        local v33 = v23.Container["NewItem" .. v25];
        v5.DisplayItem(v33, v30);
        if v18[v33] then
            v18[v33]:Disconnect();
        end;
        v18[v33] = v33.Container.ActionButton.MouseButton1Click:Connect(function()
            l_Trade_0.RemoveOffer:FireServer(v27, v29);
        end);
        v33.Visible = true;
    end;
end;
local v35 = "Accept";
v0.UpdateTrade = function(v36) --[[ Line: 186 ]]
    local v37, v38;
    if v36.Player1.Player == game.Players.LocalPlayer then
        v37 = "Player1";
        v38 = "Player2";
    elseif v36.Player2.Player == game.Players.LocalPlayer then
        v37 = "Player2";
        v38 = "Player1";
    else
        v37 = nil;
        v38 = nil;
    end;
    local l_Offer_0 = v36[v37].Offer;
    local l_Offer_1 = v36[v38].Offer;
    local l_Player_0 = v36[v38].Player;
    if not l_Player_0 then
		warn("Trade failed UpdateTrade1 - " .. tostring(v6));
        v6 = nil;
        l_Trade_0.DeclineTrade:FireServer();
        v0.GUI.TradeGUI.Enabled = false;
        v0.TradeInventory = nil;
        return;
    else
        local l_FirstChild_0 = game.Players:FindFirstChild(l_Player_0.Name);
        if not l_FirstChild_0 then
			warn("Trade failed UpdateTrade2 - " .. tostring(v6));
            v6 = nil;
            l_Trade_0.DeclineTrade:FireServer();
            v0.GUI.TradeGUI.Enabled = false;
            v0.TradeInventory = nil;
            return;
        else
            v22(v0.GUI.YourOffer.Container);
            v22(v0.GUI.TheirOffer.Container);
            v34(v0.GUI.YourOffer, l_Offer_0);
            v34(v0.GUI.TheirOffer, l_Offer_1);
            v35 = "Accept";
            v0.GUI.YourOffer.Accepted.Visible = false;
            v0.GUI.TheirOffer.Accepted.Visible = false;
            v0.GUI.TheirOffer.Username.Text = "(" .. l_FirstChild_0.Name .. ")";
            v0.GUI.Actions.Accept.Confirm.Visible = false;
            v0.GUI.Actions.Accept.Cancel.Visible = false;
            local l_AddItem_0 = v0.GUI.Actions.Accept.AddItem;
            local v44 = false;
            if #l_Offer_0 < 1 then
                v44 = #l_Offer_1 < 1;
            end;
            l_AddItem_0.Visible = v44;
            v0.UpdateTradeInventory(v36);
            l_AddItem_0 = v0.ResetCooldown;
            v44 = false;
            if #l_Offer_0 < 1 then
                v44 = #l_Offer_1 < 1;
            end;
            l_AddItem_0(v44);
            return;
        end;
    end;
end;
l_Trade_0.UpdateTrade.OnClientEvent:connect(v0.UpdateTrade);
local v45 = nil;
l_Trade_0.StartTrade.OnClientEvent:Connect(function(v46, v47)
    if v6 ~= nil then
		warn("Trade failed StartTrade - " .. tostring(v6));
        v6 = nil;
        l_Trade_0.DeclineTrade:FireServer();
        v0.GUI.TradeGUI.Enabled = false;
        v0.TradeInventory = nil;
        return;
	else
		v6 = v47;
        for _, v49 in pairs({
            "Weapons", 
            "Pets"
        }) do
            for v50, _ in pairs(v4.CreateBlankTradeInventoryTable()[v49]) do
                v0.GUI.TradeGUI.Container.Items.Main:FindFirstChild(v49).Items.Container:FindFirstChild(v50).Container:ClearAllChildren();
            end;
        end;
        v0.TradeInventory = v4.GenerateInventory(v0.GUI.TradeGUI.Container.Items, l_ProfileData_0, "Trading", v0.GUI.ItemsLayout);
        v0.ConnectOfferButtons(v0.TradeInventory);
        v0.UpdateTrade(v46);
		v0.GUI.TheirOffer.Username.Text = "(" .. tostring(v47) .. ")";
        v0.GUI.TradeGUI.Enabled = true;
        v0.GUI.RequestFrame.Visible = false;
        if v45 then
            v45:disconnect();
        end;
        local l_SearchText_0 = v0.GUI.TradeGUI.Container.Items.Tabs.Search.Container.SearchText;
        v45 = l_SearchText_0:GetPropertyChangedSignal("Text"):connect(function() --[[ Line: 268 ]]
            local l_Text_0 = l_SearchText_0.Text;
            l_Text_0 = string.gsub(l_Text_0, "S", "");
            for _, v55 in pairs(v0.TradeInventory.Data) do
                for _, v57 in pairs(v55.Current) do
                    v57.Frame.Visible = string.find(string.lower(v57.Name), string.lower(l_Text_0));
                    if v57.Frame.Parent.Parent:IsA("ScrollingFrame") then
                        v57.Frame.Parent.Parent.CanvasPosition = Vector2.new(0, 0);
                    else
                        v57.Frame.Parent.Parent.Parent.Parent.CanvasPosition = Vector2.new(0, 0);
                    end;
                end;
            end;
        end);
        return;
    end;
end);
v0.UpdateTradeInventory = function(v58)
    local v59, v60;
    if v58.Player1.Player == game.Players.LocalPlayer then
        v59 = "Player1";
        v60 = "Player2";
    elseif v58.Player2.Player == game.Players.LocalPlayer then
        v59 = "Player2";
        v60 = "Player1";
    else
        v59 = nil;
        v60 = nil;
    end;
    local l_Offer_2 = v58[v59].Offer;
    local _ = v58[v60].Offer;
    for v63, v64 in pairs(v0.TradeInventory.Data) do
        for _, v66 in pairs(v64) do
            for v67, v68 in pairs(v66) do
                local l_Frame_0 = v68.Frame;
                local l_Amount_0 = v68.Amount;
                for _, v72 in pairs(l_Offer_2) do
                    local v73 = v72[1] or v72.ItemID;
                    local v74 = v72[2] or v72.Amount;
                    local v75 = v72[3] or v72.ItemType;
                    if v73 == v67 and v75 == v63 then
                        l_Amount_0 = l_Amount_0 - v74;
                    end;
                end;
                if l_Amount_0 == 1 then
                    l_Frame_0.Container.Amount.Text = "";
                    l_Frame_0.Visible = true;
                elseif l_Amount_0 > 1 then
                    l_Frame_0.Container.Amount.Text = "x" .. l_Amount_0;
                    l_Frame_0.Visible = true;
                elseif l_Amount_0 < 1 then
                    l_Frame_0.Visible = false;
                end;
            end;
        end;
    end;
end;
v0.ConnectOfferButtons = function(v76)
    for v77, v78 in pairs(v76.Data) do
        for _, v80 in pairs(v78) do
            for v81, v82 in pairs(v80) do
                local l_Frame_1 = v82.Frame;
                if l_Frame_1 then
                    l_Frame_1.Container.ActionButton.MouseButton1Click:Connect(function()
                        l_Trade_0.OfferItem:FireServer(v81, v77);
                    end);
                end;
            end;
        end;
    end;
end;
local v84 = false;
local v85 = 6;
v0.ResetCooldown = function(v86)
    if v86 then
        v0.GUI.Actions.Accept.Cooldown.Visible = false;
        v85 = 0;
        v84 = false;
        return;
    else
        v0.GUI.Actions.Accept.Cooldown.Visible = true;
        v85 = 6;
        v0.GUI.Actions.Accept.Cooldown.Title.Text = " Please wait (" .. v85 .. ") before accepting.";
        if not v84 then
            v0.GUI.Actions.Accept.Cooldown.Visible = true;
            v84 = true;
            repeat
                wait(1);
                v85 = v85 - 1;
                v0.GUI.Actions.Accept.Cooldown.Title.Text = " Please wait (" .. v85 .. ") before accepting.";
            until v85 <= 0;
            v84 = false;
            v0.GUI.Actions.Accept.Cooldown.Visible = false;
            return;
        else
            v85 = 6;
            return;
        end;
    end;
end;
local v87 = time();
v0.ConnectActions = function()
    v0.GUI.Actions.Accept.ActionButton.MouseButton1Click:connect(function()
        if v85 <= 0 and v35 == "Accept" then
            v35 = "Confirm";
            v87 = time();
            v0.GUI.Actions.Accept.Confirm.Visible = true;
        end;
    end);
    v0.GUI.Actions.Accept.Confirm.ActionButton.MouseButton1Click:connect(function()
        if v85 <= 0 and time() - v87 >= 0.4 and v35 == "Confirm" then
            v35 = "Waiting";
            v0.GUI.YourOffer.Accepted.Visible = true;
            v0.GUI.Actions.Accept.Cancel.Visible = true;
			l_Trade_0.AcceptTrade:FireServer(v6)

        end;
    end);
    v0.GUI.Actions.Accept.Cancel.ActionButton.MouseButton1Click:connect(function()
        l_Trade_0.CancelAccept:FireServer();
    end);
    v0.GUI.Actions.Decline.ActionButton.MouseButton1Click:connect(function()
        v6 = nil;
        l_Trade_0.DeclineTrade:FireServer();
        v0.GUI.TradeGUI.Enabled = false;
        v0.TradeInventory = nil;
    end);
    if v0.GUI.Actions:FindFirstChild("AddItems") then
        v0.GUI.Actions.AddItems.ActionButton.MouseButton1Click:connect(function()
            v0.GUI.TradeGUI.Container.Items.Visible = true;
        end);
        v0.GUI.TradeGUI.Container.Items.Tabs.Close.ActionButton.MouseButton1Click:connect(function()
            v0.GUI.TradeGUI.Container.Items.Visible = false;
        end);
    end;
end;
l_Trade_0.AcceptTrade.OnClientEvent:Connect(function(v88, v89)
    if v88 then
        v6 = nil;
		v0.GUI.TradeGUI.Enabled = false;
    else
        v0.GUI.TheirOffer.Accepted.Visible = true;
    end;
end);
l_Trade_0.DeclineTrade.OnClientEvent:connect(function()
    v6 = nil;
    v0.GUI.TradeGUI.Enabled = false;
    v0.TradeInventory = nil;
end);
v0.ConnectTabButtons = function()
    v4.ConnectTabButtons(nil, nil, v0.GUI.TradeGUI.Container.Items, v0.GUI.TradeGUI.Container.Items.Main);
end;
return v0;