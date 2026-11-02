-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_ContextActionService_0 = game:GetService("ContextActionService");
local _ = function(v2, v3, v4)
    l_ContextActionService_0:BindAction(v2, function(_, v6)
        if v6 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v4();
        end;
    end, false, v3);
end;
local _ = function(v8, _, _)
    l_ContextActionService_0:UnbindAction(v8);
end;
local l_DatabaseCompatability_0 = require(script:WaitForChild("DatabaseCompatability"));
local _ = l_DatabaseCompatability_0.Item;
local _ = l_DatabaseCompatability_0.Pets;
local l_Rarity_0 = l_DatabaseCompatability_0.Rarity;
local v16 = {};
local function v20(v17)
    for _, v19 in pairs(v16) do
        game:GetService("GuiService"):RemoveSelectionGroup(v19);
    end;
    if v17 then
        game:GetService("GuiService"):AddSelectionParent(v17.Name, v17);
        table.insert(v16, v17.Name);
    end;
end;
local function v21(v22, v23)
    local v24 = "";
    for _ = 1, v23 do
        v24 = v24 .. "--";
    end;
    for v26, v27 in pairs(v22) do
        if type(v27) == "table" then
            print(v24 .. v26 .. "{");
            v21(v27, v23 + 1);
        else
            print(v24 .. v26 .. ": " .. tostring(v27));
        end;
    end;
end;
local function _(v28)
    if _G.Cache[v28] ~= nil then
        return _G.Cache[v28];
    else
        local v29 = (tonumber(v28) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v28 or v28) .. "&bust=" .. math.random(1, 10000);
        _G.Cache[v28] = v29;
        return v29;
    end;
end;
local l_Parent_0 = script.Parent.Parent;
local l_Trade_0 = game.ReplicatedStorage.Trade;
local l_Request_0 = l_Parent_0.Leaderboard.Trade.Request;
local l_Trade_1 = l_Parent_0.Trade;
local function _(v35)
    if v35.Player1.Player == game.Players.LocalPlayer then
        return "Player1", "Player2";
    elseif v35.Player2.Player == game.Players.LocalPlayer then
        return "Player2", "Player1";
    else
        return;
    end;
end;
local v37 = false;
local function v42(v38, v39)
    if not v39 then
        v37 = true;
        l_Request_0.Title.Text = "Waiting for " .. v38 .. " to respond.";
    else
        v37 = false;
        l_Request_0.Title.Text = v38 .. " wants to trade.";
    end;
    l_Parent_0.Leaderboard.Trade.Request.Visible = true;
    for _, v41 in pairs(l_Parent_0.Leaderboard.List:GetChildren()) do
        if v41.Container.Response.Visible then
            v41.Container.Response.Visible = false;
        end;
    end;
end;
_G.ShowRequest = v42;
local v43 = {};
local v44 = false;
local v45 = 5;
ResetCooldown = function()
    l_Parent_0.Trade.Offers.Accept.TradeAccepted.Visible = false;
    v45 = 5;
    l_Parent_0.Trade.Offers.Accept.Cooldown.Text = "(" .. v45 .. ")";
    if not v44 then
        l_Parent_0.Trade.Offers.Accept.Cooldown.Visible = true;
        v44 = true;
        while true do
            wait(1);
            v45 = v45 - 1;
            l_Parent_0.Trade.Offers.Accept.Cooldown.Text = "(" .. v45 .. ")";
            if not (v45 > 0) then
                break;
            end;
        end;
        v44 = false;
        l_Parent_0.Trade.Offers.Accept.Cooldown.Visible = false;
        return;
    else
        v45 = 5;
        return;
    end;
end;
local v46 = false;
local function v89(v47)
    l_Request_0.Visible = false;
    l_Trade_1.Offers.Accept.TradeAccepted.Visible = false;
    l_Trade_1.Offers.Accept.Waiting.Visible = false;
    for _, v49 in pairs(l_Trade_1.Offers.OfferContainer.Offer1:GetChildren()) do
        if v49.Name ~= "OfferLabel" then
            v49.Container.Icon.Image = "";
            v49.Container.ItemName.Text = "";
            v49.Container.Amount.Text = "";
        end;
    end;
    for _, v51 in pairs(l_Trade_1.Offers.OfferContainer.Offer2:GetChildren()) do
        if v51.Name ~= "OfferLabel" then
            v51.Container.Icon.Image = "";
            v51.Container.ItemName.Text = "";
            v51.Container.Amount.Text = "";
        end;
    end;
    for _, v53 in pairs(v43) do
        v53:disconnect();
    end;
    if v47 then
        l_Trade_1.Visible = true;
        local v54, v55;
        if v47.Player1.Player == game.Players.LocalPlayer then
            v54 = "Player1";
            v55 = "Player2";
        elseif v47.Player2.Player == game.Players.LocalPlayer then
            v54 = "Player2";
            v55 = "Player1";
        else
            v54 = nil;
            v55 = nil;
        end;
        local l_Offer_0 = v47[v54].Offer;
        local l_Offer_1 = v47[v55].Offer;
        for v58, v59 in pairs(l_Offer_0) do
            local v60 = l_DatabaseCompatability_0[v59[3]];
            local l_Icon_0 = l_Trade_1.Offers.OfferContainer.Offer1["Slot" .. v58].Container.Icon;
            local l_Image_0 = v60[v59[1]].Image;
            local v63;
            if _G.Cache[l_Image_0] ~= nil then
                v63 = _G.Cache[l_Image_0];
            else
                local v64 = (tonumber(l_Image_0) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_0 or l_Image_0) .. "&bust=" .. math.random(1, 10000);
                _G.Cache[l_Image_0] = v64;
                v63 = v64;
            end;
            l_Icon_0.Image = v63;
            l_Trade_1.Offers.OfferContainer.Offer1["Slot" .. v58].Container.ItemName.Text = v60[v59[1]].ItemName or v60[v59[1]].Name;
            l_Trade_1.Offers.OfferContainer.Offer1["Slot" .. v58].Container.ItemName.TextColor3 = l_Rarity_0[v60[v59[1]].Rarity];
            l_Trade_1.Offers.OfferContainer.Offer1["Slot" .. v58].Container.Amount.Text = "x" .. v59[2];
            table.insert(v43, l_Trade_1.Offers.OfferContainer.Offer1["Slot" .. v58].Container.Button.MouseButton1Click:connect(function()
                l_Trade_0.RemoveOffer:FireServer(v59[1], v59[3]);
            end));
        end;
        for v65, v66 in pairs(l_Offer_1) do
            local v67 = l_DatabaseCompatability_0[v66[3]];
            local l_Icon_1 = l_Trade_1.Offers.OfferContainer.Offer2["Slot" .. v65].Container.Icon;
            local l_Image_1 = v67[v66[1]].Image;
            local v70;
            if _G.Cache[l_Image_1] ~= nil then
                v70 = _G.Cache[l_Image_1];
            else
                local v71 = (tonumber(l_Image_1) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_1 or l_Image_1) .. "&bust=" .. math.random(1, 10000);
                _G.Cache[l_Image_1] = v71;
                v70 = v71;
            end;
            l_Icon_1.Image = v70;
            l_Trade_1.Offers.OfferContainer.Offer2["Slot" .. v65].Container.ItemName.Text = v67[v66[1]].ItemName or v67[v66[1]].Name;
            l_Trade_1.Offers.OfferContainer.Offer2["Slot" .. v65].Container.ItemName.TextColor3 = l_Rarity_0[v67[v66[1]].Rarity];
            l_Trade_1.Offers.OfferContainer.Offer2["Slot" .. v65].Container.Amount.Text = "x" .. v66[2];
        end;
        spawn(ResetCooldown);
        return;
    else
        l_Parent_0.Leaderboard.Visible = false;
        local l_ButtonY_0 = Enum.KeyCode.ButtonY;
        local function v73()
            v46 = not v46;
            l_Trade_1.YourItems.Pets.Style = v46 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
            l_Trade_1.TheirItems.Pets.Style = v46 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
            l_Trade_1.YourItems.Weapons.Style = v46 and Enum.ButtonStyle.RobloxRoundButton or Enum.ButtonStyle.RobloxRoundDefaultButton;
            l_Trade_1.TheirItems.Weapons.Style = v46 and Enum.ButtonStyle.RobloxRoundButton or Enum.ButtonStyle.RobloxRoundDefaultButton;
            l_Trade_1.YourItems.PetsFrame.Visible = v46;
            l_Trade_1.YourItems.Items.Visible = not v46;
            l_Trade_1.TheirItems.PetsFrame.Visible = v46;
            l_Trade_1.TheirItems.Items.Visible = not v46;
            v20(l_Trade_1);
            game:GetService("GuiService").SelectedObject = l_Trade_1.YourItems[v46 and "PetsFrame" or "Items"].Container.Slot1.Container.Button;
        end;
        local l_v73_0 = v73 --[[ copy: 2 -> 15 ]];
        l_ContextActionService_0:BindAction("ToggleItemType", function(_, v76)
            if v76 == Enum.UserInputState.Begin and not _G.PauseBinds then
                l_v73_0();
            end;
        end, false, l_ButtonY_0);
        l_ButtonY_0 = Enum.KeyCode.ButtonB;
        v73 = function()

        end;
        local l_v73_1 = v73 --[[ copy: 2 -> 16 ]];
        l_ContextActionService_0:BindAction("TradeNoB", function(_, v79)
            if v79 == Enum.UserInputState.Begin and not _G.PauseBinds then
                l_v73_1();
            end;
        end, false, l_ButtonY_0);
        l_ButtonY_0 = Enum.KeyCode.ButtonL3;
        v73 = function()
            l_Parent_0.Chat.ChatBox:CaptureFocus();
        end;
        local l_v73_2 = v73 --[[ copy: 2 -> 17 ]];
        l_ContextActionService_0:BindAction("TradeChat", function(_, v82)
            if v82 == Enum.UserInputState.Begin and not _G.PauseBinds then
                l_v73_2();
            end;
        end, false, l_ButtonY_0);
        l_Trade_1.Visible = true;
        UpdateInventory("YourItems", l_ProfileData_0.Weapons.Owned, l_ProfileData_0.Pets.Owned);
        v20(l_Trade_1);
        game:GetService("GuiService").SelectedObject = l_Trade_1.YourItems.Items.Container.Slot1.Container.Button;
        l_ButtonY_0, v73 = game.ReplicatedStorage.Trade.GetTradeStatus:InvokeServer();
        local v83;
        if v73.Player1.Player == game.Players.LocalPlayer then
            local _ = "Player1";
            v83 = "Player2";
        elseif v73.Player2.Player == game.Players.LocalPlayer then
            local _ = "Player2";
            v83 = "Player1";
        else
            local _ = nil;
            v83 = nil;
        end;
        local l_Player_0 = v73[v83].Player;
        local v88 = game.ReplicatedStorage.Remotes.Extras.GetFullInventory:InvokeServer(l_Player_0);
        UpdateInventory("TheirItems", v88.Weapons.Owned, v88.Pets.Owned);
        return;
    end;
end;
l_Trade_0.DeclineTrade.OnClientEvent:connect(function()
    l_Trade_1.Visible = false;
    l_Parent_0.Leaderboard.Visible = true;
    l_ContextActionService_0:UnbindAction("TradeNoB");
    l_ContextActionService_0:UnbindAction("TradeChat");
    v20(l_Parent_0.Leaderboard);
    game:GetService("GuiService").SelectedObject = l_Parent_0.Leaderboard.List.Player1.Container.Button;
end);
l_Trade_0.DeclineRequest.OnClientEvent:connect(function()
    l_Parent_0.Leaderboard.Trade.Request.Visible = false;
    l_Parent_0.Leaderboard.Trade.Request.Response.Visible = false;
    _G.Chatted("Server", "Your trade request was declined.");
end);
l_Trade_0.CancelRequest.OnClientEvent:connect(function()
    l_Parent_0.Leaderboard.Trade.Request.Visible = false;
    l_Parent_0.Leaderboard.Trade.Request.Response.Visible = false;
end);
l_Trade_0.SendRequest.OnClientInvoke = function(v90)
    if _G.RequestsEnabled then
        _G.Chatted("Server", v90.Name .. " has sent you a trade request.");
        v42(v90.Name, true);
    end;
    return _G.RequestsEnabled;
end;
l_Trade_0.RequestSent.OnClientEvent:Connect(function(v91)
    if _G.RequestsEnabled then
        _G.Chatted("Server", v91.Name .. " has sent you a trade request.");
        v42(v91.Name, true);
    end;
end);
l_Trade_0.UpdateTrade.OnClientEvent:connect(v89);
l_Trade_0.StartTrade.OnClientEvent:connect(function()
    v89();
    l_Parent_0.Leaderboard.Trade.Request.Visible = false;
    l_Parent_0.Leaderboard.Trade.Request.Response.Visible = false;
end);
l_Trade_0.AcceptTrade.OnClientEvent:connect(function(v92)
    if v92 then
        l_Trade_1.Visible = false;
        l_Parent_0.Leaderboard.Visible = true;
        l_ContextActionService_0:UnbindAction("TradeNoB");
        l_ContextActionService_0:UnbindAction("TradeChat");
        return;
    else
        l_Trade_1.Offers.Accept.TradeAccepted.Visible = true;
        return;
    end;
end);
l_Trade_1.Offers.Decline.MouseButton1Click:connect(function()
    l_Trade_0.DeclineTrade:FireServer();
end);
local v93 = nil;
l_Parent_0.Leaderboard.Trade.Toggle.SelectionGained:connect(function()
    if l_Parent_0.Leaderboard.Trade.Request.Visible and not v37 then
        l_Parent_0.Leaderboard.Trade.Request.Response.Visible = true;
        v93 = game:GetService("UserInputService").InputBegan:connect(function(v94)
            if v94.KeyCode == Enum.KeyCode.DPadLeft and l_Parent_0.Leaderboard.Trade.Request.Visible and not l_Parent_0.Chat.Control.Visible then
                if v93 then
                    v93:disconnect();
                end;
                l_Parent_0.Leaderboard.Trade.Request.Visible = false;
                l_Parent_0.Leaderboard.Trade.Request.Response.Visible = false;
                l_Trade_0.AcceptRequest:FireServer();
                v20(nil);
                game:GetService("GuiService").SelectedObject = nil;
                return;
            else
                if v94.KeyCode == Enum.KeyCode.DPadRight and l_Parent_0.Leaderboard.Trade.Request.Visible and not l_Parent_0.Chat.Control.Visible then
                    if v93 then
                        v93:disconnect();
                    end;
                    v20(l_Parent_0.Leaderboard);
                    game:GetService("GuiService").SelectedObject = l_Parent_0.Leaderboard.List.Player1.Container.Button;
                    l_Parent_0.Leaderboard.Trade.Request.Visible = false;
                    l_Parent_0.Leaderboard.Trade.Request.Response.Visible = false;
                    l_Trade_0.DeclineRequest:FireServer();
                end;
                return;
            end;
        end);
        return;
    else
        if l_Parent_0.Leaderboard.Trade.Request.Visible and v37 then
            l_Parent_0.Leaderboard.Trade.Request.Cancel.Visible = true;
            v93 = game:GetService("UserInputService").InputBegan:connect(function(v95)
                if v95.KeyCode == Enum.KeyCode.DPadRight and l_Parent_0.Leaderboard.Trade.Request.Visible then
                    if v93 then
                        v93:disconnect();
                    end;
                    v20(l_Parent_0.Leaderboard);
                    game:GetService("GuiService").SelectedObject = l_Parent_0.Leaderboard.List.Player1.Container.Button;
                    l_Parent_0.Leaderboard.Trade.Request.Visible = false;
                    l_Parent_0.Leaderboard.Trade.Request.Cancel.Visible = false;
                    l_Trade_0.CancelRequest:FireServer();
                end;
            end);
        end;
        return;
    end;
end);
l_Parent_0.Leaderboard.Trade.Toggle.SelectionLost:connect(function()
    l_Parent_0.Leaderboard.Trade.Request.Response.Visible = false;
    l_Parent_0.Leaderboard.Trade.Request.Cancel.Visible = false;
    if v93 then
        v93:disconnect();
    end;
end);
local v96 = time();
l_Trade_1.Offers.Accept.MouseButton1Click:connect(function()
    if v44 == false and time() - v96 >= 1 then
        v96 = time();
        l_Trade_1.Offers.Accept.Waiting.Visible = true;
        l_Trade_0.AcceptTrade:FireServer(game.PlaceId * 2);
    end;
end);
local v97, v98 = game.ReplicatedStorage.Trade.GetTradeStatus:InvokeServer();
if v97 == "StartTrade" then
    v89(v98);
    game:GetService("GuiService").SelectedObject = l_Trade_1.YourItems.Items.Container.Slot1.Container.Button;
elseif v97 == "ShowRequest" then
    v42(v98, false);
elseif v97 == "SendRequest" then
    v42(v98, true);
end;
local v99 = {
    Classic = 1, 
    Common = 2, 
    Uncommon = 3, 
    Rare = 4, 
    Legendary = 5, 
    Godly = 6, 
    Victim = 7, 
    Unique = 7, 
    Ancient = 6.5, 
    Christmas = 1.6, 
    Halloween = 1.5
};
UpdateInventory = function(v100, v101, v102)
    local l_Item_1 = l_DatabaseCompatability_0.Item;
    local l_Pets_1 = l_DatabaseCompatability_0.Pets;
    local l_Container_0 = l_Trade_1[v100].Items.Container;
    local l_Container_1 = l_Trade_1[v100].PetsFrame.Container;
    l_Container_0:ClearAllChildren();
    l_Container_1:ClearAllChildren();
    local v107 = {};
    local v108 = {};
    for v109, v110 in pairs(v101) do
        table.insert(v107, {
            ItemName = v109, 
            Amount = v110
        });
    end;
    for v111, v112 in pairs(v102) do
        table.insert(v108, {
            ItemName = v111, 
            Amount = v112
        });
    end;
    table.sort(v108, function(v113, v114)
        if v99[l_Pets_1[v113.ItemName].Rarity] ~= v99[l_Pets_1[v114.ItemName].Rarity] then
            return v99[l_Pets_1[v113.ItemName].Rarity] > v99[l_Pets_1[v114.ItemName].Rarity];
        else
            return v113.Amount > v114.Amount;
        end;
    end);
    table.sort(v107, function(v115, v116)
        if v115.ItemName == "DefaultKnife" then
            return true;
        elseif v116.ItemName == "DefaultKnife" then
            return false;
        elseif v115.ItemName == "DefaultGun" then
            return true;
        elseif v116.ItemName == "DefaultGun" then
            return false;
        elseif v99[l_Item_1[v115.ItemName].Rarity] ~= v99[l_Item_1[v116.ItemName].Rarity] then
            return v99[l_Item_1[v115.ItemName].Rarity] > v99[l_Item_1[v116.ItemName].Rarity];
        else
            return v115.Amount > v116.Amount;
        end;
    end);
    local v117 = 0;
    for _, v119 in pairs(v107) do
        local l_ItemName_0 = v119.ItemName;
        local l_Amount_0 = v119.Amount;
        v117 = v117 + 1;
        local v122 = l_DatabaseCompatability_0.Item[l_ItemName_0];
        local v123 = script.Slot:Clone();
        v123.Parent = l_Trade_1[v100].Items.Container;
        local v124 = math.floor((v117 - 1) / 4);
        local v125 = (v117 - 1) % 4;
        v123.Position = UDim2.new(v123.Size.X.Scale * v125, 0, 0, v123.AbsoluteSize.Y * v124);
        v123.Container.Icon.Image = v122.Image;
        v123.Container.ItemName.Text = l_DatabaseCompatability_0.Item[l_ItemName_0].ItemName;
        v123.Container.ItemName.TextColor3 = l_DatabaseCompatability_0.Rarity[v122.Rarity];
        v123.Name = "Slot" .. v117;
        if l_Amount_0 > 1 then
            v123.Container.Amount.Text = "x" .. l_Amount_0;
        end;
        if v100 == "YourItems" then
            v123.Container.Button.MouseButton1Click:connect(function()
                l_Trade_0.OfferItem:FireServer(l_ItemName_0, "Weapons");
            end);
        else
            v123.Container.Button.Selectable = false;
        end;
    end;
    local v126 = 0;
    for _, v128 in pairs(v108) do
        local l_ItemName_1 = v128.ItemName;
        local l_Amount_1 = v128.Amount;
        v126 = v126 + 1;
        local v131 = l_Pets_1[l_ItemName_1];
        local v132 = script.Slot:Clone();
        v132.Parent = l_Container_1;
        local v133 = math.floor((v126 - 1) / 4);
        local v134 = (v126 - 1) % 4;
        v132.Position = UDim2.new(v132.Size.X.Scale * v134, 0, 0, v132.AbsoluteSize.Y * v133);
        local l_Icon_2 = v132.Container.Icon;
        local l_Image_2 = v131.Image;
        local v137;
        if _G.Cache[l_Image_2] ~= nil then
            v137 = _G.Cache[l_Image_2];
        else
            local v138 = (tonumber(l_Image_2) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_2 or l_Image_2) .. "&bust=" .. math.random(1, 10000);
            _G.Cache[l_Image_2] = v138;
            v137 = v138;
        end;
        l_Icon_2.Image = v137;
        v132.Container.ItemName.Text = l_Pets_1[l_ItemName_1].Name;
        v132.Container.ItemName.TextColor3 = l_DatabaseCompatability_0.Rarity[v131.Rarity];
        v132.Name = "Slot" .. v126;
        if l_Amount_1 > 1 then
            v132.Container.Amount.Text = "x" .. l_Amount_1;
        end;
        if v100 == "YourItems" then
            v132.Container.Button.MouseButton1Click:connect(function()
                l_Trade_0.OfferItem:FireServer(l_ItemName_1, "Pets");
            end);
        else
            v132.Container.Button.Selectable = false;
        end;
    end;
end;
if _G.RequestsEnabled == nil then
    _G.RequestsEnabled = true;
end;
l_Parent_0.Leaderboard.Trade.Status.BackgroundColor3 = _G.RequestsEnabled and Color3.new(0, 0.7019607843137254, 0) or Color3.new(0.6666666666666666, 0, 0);
l_Parent_0.Leaderboard.Trade.Title.Text = "Trade Requests: " .. (_G.RequestsEnabled and "On" or "Off");
l_Parent_0.Leaderboard.Trade.Toggle.MouseButton1Click:Connect(function()
    if not l_Parent_0.Leaderboard.Trade.Request.Visible then
        _G.RequestsEnabled = not _G.RequestsEnabled;
        l_Trade_0.SetRequestsEnabled:FireServer(_G.RequestsEnabled);
        l_Parent_0.Leaderboard.Trade.Status.BackgroundColor3 = _G.RequestsEnabled and Color3.new(0, 0.7019607843137254, 0) or Color3.new(0.6666666666666666, 0, 0);
        l_Parent_0.Leaderboard.Trade.Title.Text = "Trade Requests: " .. (_G.RequestsEnabled and "On" or "Off");
        l_Trade_0.DeclineRequest:FireServer();
    end;
end);
UpdateInventory("YourItems", l_ProfileData_0.Weapons.Owned, l_ProfileData_0.Pets.Owned);