-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent.Parent;
local l_Shop_0 = l_Parent_0:WaitForChild("Shop");
local _ = l_Shop_0:WaitForChild("Title");
local l_Main_0 = l_Shop_0:WaitForChild("Main");
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_ViewContents_0 = l_Main_0.ViewContents;
local l_Info_0 = l_Shop_0.Info;
local l_Container_0 = l_ViewContents_0.Items.ScrollFrame.Container;
local _, _, _ = game.ReplicatedStorage.Remotes.Extras.GetPlayerLevel:InvokeServer(game.Players.LocalPlayer);
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_DatabaseCompatability_0 = require(script:WaitForChild("DatabaseCompatability"));
local _ = l_Parent_0.Dock;
local l_Remotes_0 = game.ReplicatedStorage.Remotes;
local l_ContextActionService_0 = game:GetService("ContextActionService");
local _ = function(v17, v18, v19)
    l_ContextActionService_0:BindAction(v17, function(_, v21)
        if v21 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v19();
        end;
    end, false, v18);
end;
local _ = function(v23, _, _)
    l_ContextActionService_0:UnbindAction(v23);
end;
local function _(v27)
    if _G.Cache[v27] ~= nil then
        return _G.Cache[v27];
    else
        local v28 = (tonumber(v27) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v27 or v27) .. "&bust=" .. math.random(1, 10000);
        _G.Cache[v27] = v28;
        return v28;
    end;
end;
local _ = require(script.OpenCrate);
local l_Item_0 = script.Item;
local _ = l_DatabaseCompatability_0.Item;
local _ = l_DatabaseCompatability_0.Pets;
local l_Rarity_0 = l_DatabaseCompatability_0.Rarity;
local v36 = true;
if game.PlaceId ~= 188331334 then
	v36 = game.PlaceId == require(game.ReplicatedStorage.Constants).Places.Standard;
end;
local l_Shop_1 = l_DatabaseCompatability_0.Shop;
local v38 = require(game.ReplicatedStorage.Modules.ShopModule);
local v39 = require(game.ReplicatedStorage.Modules.ItemModule);
v38.GUI.ShopFrame = l_Shop_0;
v38.GUI.Main = l_Shop_0.Main;
l_DatabaseCompatability_0.Featured = l_DatabaseCompatability_0.XboxFeatured;
local _ = l_DatabaseCompatability_0.MysteryBox;
local v41 = {
    "Weapons", 
    "Emotes", 
    "Perks", 
    "Effects", 
    "Pets"
};
local v42 = {
    Weapons = nil, 
    Effects = nil, 
    Perks = nil, 
    Emotes = nil, 
    Radios = nil, 
    Pets = nil
};
local function v43(v44)
    local v45 = {};
    for v46, v47 in pairs(v44) do
        if type(v47) == "table" then
            v47 = v43(v47);
        end;
        v45[v46] = v47;
    end;
    return v45;
end;
local _ = function(v48, v49)
    if l_ProfileData_0[v49] == nil then
        return false;
    elseif l_ProfileData_0[v49].Owned[v48] then
        return true;
    else
        for _, v51 in l_ProfileData_0[v49].Owned do
            if v51 == v48 then
                return true;
            end;
        end;
        return false;
    end;
end;
for _, v54 in pairs(v41) do
    if v54 ~= "Featured" then
        v42[v54] = v43(l_ProfileData_0[v54]);
    end;
end;
for v55, v56 in pairs(l_Shop_1) do
    local v57 = {};
    local function v68(v58, v59)
        local _ = v58.ItemData;
        local _ = v59.ItemData;
        local l_ItemShopData_0 = v58.ItemShopData;
        local l_ItemShopData_1 = v59.ItemShopData;
        local _ = l_ItemShopData_0.Price.Gems;
        local _ = l_ItemShopData_1.Price.Gems;
        local _ = l_ItemShopData_0.Price.Coins;
        local _ = l_ItemShopData_1.Price.Coins;
        if l_ItemShopData_1.ExchangeAmount == nil and l_ItemShopData_0.ExchangeAmount ~= nil then
            return true;
        elseif l_ItemShopData_1.ExchangeAmount ~= nil and l_ItemShopData_0.ExchangeAmount == nil then
            return false;
        else
            return v58.ItemID > v59.ItemID;
        end;
    end;
    for v69, v70 in pairs(v56) do
        table.insert(v57, {
            ItemID = v69, 
            ItemData = l_DatabaseCompatability_0[v70.DataType or v55][v69], 
            ItemShopData = v70, 
            DataType = v70.DataType
        });
    end;
    if v55 ~= "XboxFeatured" then
        table.sort(v57, v68);
    end;
    l_DatabaseCompatability_0[v55] = {
        Sorted = v57, 
        Original = v56
    };
end;
local v71 = {};
local v72 = {
    MysteryBox = true, 
    Eggs = true
};
local l_Attribute_0 = game.ReplicatedFirst:GetAttribute("CratesRestricted");
for _, v75 in pairs(v41) do
    local l_Sorted_0 = l_DatabaseCompatability_0[v75].Sorted;
    local v77 = 0;
    local l_ScrollFrame_0 = l_Main_0[v75].Items.ScrollFrame;
    local l_Info_1 = l_Shop_0.Info;
    local l_Container_1 = l_ScrollFrame_0.Container;
    local l_Scale_0 = l_Item_0.Size.Y.Scale;
    local v82 = math.floor(1 / l_Scale_0);
    if l_Main_0[v75]:FindFirstChild("Casual") then
        l_Main_0[v75].Casual.Visible = v36;
    end;
    local v83 = nil;
    local v84 = nil;
    local v85 = l_Item_0:Clone();
    l_Container_1.Size = UDim2.new(1, 0, 1, 0);
    v85.Parent = l_Container_1;
    v83 = v85.AbsoluteSize.Y;
    l_Container_1.Size = UDim2.new(1, -l_ScrollFrame_0.ScrollBarThickness - 1, 1, 0);
    v84 = v85.AbsoluteSize.Y;
    v85:Destroy();
    local v86 = math.floor(#l_Sorted_0 / v82);
    local v87 = (v86 + 1) * v83 - 1;
    local v88 = l_ScrollFrame_0.AbsoluteSize.Y < v87;
    if v88 then
        v87 = (v86 + 1) * v84;
    end;
    l_Container_1.Size = v88 and UDim2.new(1, -l_ScrollFrame_0.ScrollBarThickness - 1, 1, 0) or UDim2.new(1, 0, 1, 0);
    l_ScrollFrame_0.CanvasSize = UDim2.new(0, 0, 0, v87);
    local l_Y_0 = l_ScrollFrame_0.CanvasPosition.Y;
    local v90 = false;
    do
        local l_v77_0, l_l_Y_0_0, l_v90_0 = v77, l_Y_0, v90;
        l_ScrollFrame_0.Changed:connect(function()
            if l_v90_0 then
                return;
            else
                if l_ScrollFrame_0.CanvasPosition.Y > l_l_Y_0_0 then
                    l_v90_0 = true;
                    l_ScrollFrame_0.CanvasPosition = Vector2.new(0, l_ScrollFrame_0.CanvasPosition.Y + 20);
                    game:GetService("RunService").RenderStepped:wait();
                    l_v90_0 = false;
                end;
                l_l_Y_0_0 = l_ScrollFrame_0.CanvasPosition.Y;
                return;
            end;
        end);
        v71[v75] = {};
        local function v184(v94, v95)
            local v96 = false;
            local v97 = math.floor(l_v77_0 / v82);
            local v98 = l_v77_0 % v82;
            local v99 = l_Item_0:Clone();
            local l_Container_2 = v99.Container;
            local v101 = v95.ItemData.ItemType and v95.ItemData.Name or v95.ItemID;
            local v102 = v95.ItemData.ItemData or v95.ItemData;
            local l_ItemShopData_2 = v95.ItemShopData;
            local l_DataType_0 = l_ItemShopData_2.DataType;
            local v105 = true;
            if l_DataType_0 ~= "MysteryBox" then
                v105 = l_DataType_0 == "Eggs";
            end;
            if v101 == "Key" and l_Attribute_0 then
                return;
            else
                v99.Parent = l_Container_1;
                v99.Size = UDim2.new(l_Scale_0, 0, l_Scale_0, 0);
                v99.Position = UDim2.new(v99.Size.X.Scale * v98, 0, 0, v99.AbsoluteSize.Y * v97);
                v99.Name = "Slot" .. l_v77_0;
                local l_Icon_0 = l_Container_2.Icon;
                local l_Image_0 = v102.Image;
                local v108;
                if _G.Cache[l_Image_0] ~= nil then
                    v108 = _G.Cache[l_Image_0];
                else
                    local v109 = (tonumber(l_Image_0) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_0 or l_Image_0) .. "&bust=" .. math.random(1, 10000);
                    _G.Cache[l_Image_0] = v109;
                    v108 = v109;
                end;
                l_Icon_0.Image = v108;
                l_Container_2.ItemName.Text = v102.Name or v102.ItemName;
                l_Info_1.Icon.Type.Text = v95.Type or v102.Type or v102.ItemName and v102.Rarity or "";
                v71[v75]["Slot" .. l_v77_0] = {};
                l_Icon_0 = false;
                if v95.Type == "Weapon Crate" then
                    v108 = v102.Released;
                    if os.time() - v108 < 86400 then
                        l_Icon_0 = true;
                    end;
                end;
                v108 = {
                    Weapons = true, 
                    Item = true, 
                    Pets = true
                };
                l_Image_0 = v95.ItemShopData.OwnedType or v95.ItemShopData.DataType or v75;
                if v38.CheckOwned(v101, l_Image_0) then
                    v99.Tags.Owned.Visible = true;
                else
                    for v110, v111 in pairs(l_ItemShopData_2.Price) do
                        local l_FirstChild_0 = v99.Tags:FindFirstChild(v110);
                        if l_FirstChild_0 then
                            l_FirstChild_0.Container.PriceFrame.PriceLabel.Text = v39.Commafy(v111);
                            l_FirstChild_0.Visible = true;
                            if l_Attribute_0 and v105 and v110 == "Gems" then
                                l_FirstChild_0.Visible = false;
                            end;
                        end;
                    end;
                end;
                local v113 = v95.ItemShopData.OwnedType or v95.ItemShopData.DataType or v75;
                local v114;
                if l_ProfileData_0[v113] == nil then
                    v114 = false;
                elseif l_ProfileData_0[v113].Owned[v101] then
                    v114 = true;
                else
                    for _, v116 in l_ProfileData_0[v113].Owned do
                        if v116 == v101 then
                            v114 = true;
                            v96 = true;
                        end;
                        if v96 then
                            break;
                        end;
                    end;
                    if not v96 then
                        v114 = false;
                    end;
                end;
                v96 = false;
                local _ = not v114;
                v71[v75]["Slot" .. l_v77_0].Select = function()
                    local v118 = false;
                    l_Info_1.Title.Text = v102.Name or v102.ItemName;
                    local l_Icon_1 = l_Info_1.Icon;
                    local l_Image_1 = v102.Image;
                    local v121;
                    if _G.Cache[l_Image_1] ~= nil then
                        v121 = _G.Cache[l_Image_1];
                    else
                        local v122 = (tonumber(l_Image_1) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_1 or l_Image_1) .. "&bust=" .. math.random(1, 10000);
                        _G.Cache[l_Image_1] = v122;
                        v121 = v122;
                    end;
                    l_Icon_1.Image = v121;
                    l_Info_1.Icon.Type.Text = v102.Type or v95.Type or v102.ItemName and v102.Rarity or "";
                    l_Icon_1 = l_Info_1.Buy;
                    local l_v101_0 = v101;
                    local v124 = v95.ItemShopData.OwnedType or v95.ItemShopData.DataType or v75;
                    if l_ProfileData_0[v124] == nil then
                        l_Image_1 = false;
                    elseif l_ProfileData_0[v124].Owned[l_v101_0] then
                        l_Image_1 = true;
                    else
                        for _, v126 in l_ProfileData_0[v124].Owned do
                            if v126 == l_v101_0 then
                                l_Image_1 = true;
                                v118 = true;
                            end;
                            if v118 then
                                break;
                            end;
                        end;
                        if not v118 then
                            l_Image_1 = false;
                        end;
                    end;
                    v118 = false;
                    l_Icon_1.Visible = not l_Image_1;
                    if v102.Description then
                        l_Info_1.Icon.Description.Text = v102.Description;
                        return;
                    else
                        l_Info_1.Icon.Description.Text = "";
                        return;
                    end;
                end;
                l_Container_2.Button.SelectionGained:connect(function()
                    local v127 = false;
                    l_Info_1.Title.Text = v102.Name or v102.ItemName;
                    local l_Icon_2 = l_Info_1.Icon;
                    local l_Image_2 = v102.Image;
                    local v130;
                    if _G.Cache[l_Image_2] ~= nil then
                        v130 = _G.Cache[l_Image_2];
                    else
                        local v131 = (tonumber(l_Image_2) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_2 or l_Image_2) .. "&bust=" .. math.random(1, 10000);
                        _G.Cache[l_Image_2] = v131;
                        v130 = v131;
                    end;
                    l_Icon_2.Image = v130;
                    l_Info_1.Icon.Type.Text = v102.Type or v95.Type or v102.ItemName and v102.Rarity or "";
                    l_Icon_2 = l_Info_1.Buy;
                    local l_v101_1 = v101;
                    local v133 = v95.ItemShopData.OwnedType or v95.ItemShopData.DataType or v75;
                    if l_ProfileData_0[v133] == nil then
                        l_Image_2 = false;
                    elseif l_ProfileData_0[v133].Owned[l_v101_1] then
                        l_Image_2 = true;
                    else
                        for _, v135 in l_ProfileData_0[v133].Owned do
                            if v135 == l_v101_1 then
                                l_Image_2 = true;
                                v127 = true;
                            end;
                            if v127 then
                                break;
                            end;
                        end;
                        if not v127 then
                            l_Image_2 = false;
                        end;
                    end;
                    v127 = false;
                    l_Icon_2.Visible = not l_Image_2;
                    l_Info_1.Buy.ButtonIcon.Title.Text = (not not v72[v95.ItemShopData.DataType] or v95.Type == "Bundle") and "View" or "Buy";
                    l_Info_1.Icon.CurrencyIcon.Image = "";
                    if v102.Description then
                        l_Info_1.Icon.Description.Text = v102.Description;
                        return;
                    else
                        l_Info_1.Icon.Description.Text = "";
                        return;
                    end;
                end);
                if v72[v95.ItemShopData.DataType] and v94 ~= "ItemPack" then
                    l_Container_2.Button.MouseButton1Click:connect(function()
                        if not _G.Tweening then
                            local _ = v72[v95.ItemShopData.DataType];
                            l_Info_0.Buy.ButtonIcon.Image = v95.Type == "Bundle" and "rbxasset://textures/ui/Settings/Help/YButtonDark@2x.png" or "rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png";
                            l_Info_0.Buy.ButtonIcon.Title.Text = "Buy";
                            local v137 = v95.Type == "Bundle" and Enum.KeyCode.ButtonY or Enum.KeyCode.ButtonA;
                            local function v138()

                            end;
                            local l_v138_0 = v138 --[[ copy: 2 -> 18 ]];
                            l_ContextActionService_0:BindAction("BuyCrateBundle", function(_, v141)
                                if v141 == Enum.UserInputState.Begin and not _G.PauseBinds then
                                    l_v138_0();
                                end;
                            end, false, v137);
                            v137 = l_Info_0.Icon;
                            local l_Image_3 = v102.Image;
                            if _G.Cache[l_Image_3] ~= nil then
                                v138 = _G.Cache[l_Image_3];
                            else
                                local v143 = (tonumber(l_Image_3) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_3 or l_Image_3) .. "&bust=" .. math.random(1, 10000);
                                _G.Cache[l_Image_3] = v143;
                                v138 = v143;
                            end;
                            v137.Image = v138;
                            l_Info_0.Title.Text = v102.Name;
                            for _, v145 in pairs(l_Shop_0.Info.BuyFrame.PurchaseOptions.Container:GetChildren()) do
                                if v145:IsA("TextButton") then
                                    v145.Visible = l_ItemShopData_2.Price[v145.Name] ~= nil;
                                    local v146 = v39.Commafy(l_ItemShopData_2.Price[v145.Name] or 0);
                                    if tonumber(v146) == 1 then
                                        v146 = "x" .. v146;
                                    end;
                                    v145.Cost.Text = v146;
                                    if v145.Name == "Coins" then
                                        v145.Style = l_ProfileData_0.Coins >= (l_ItemShopData_2.Price[v145.Name] or 0) and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
                                    end;
                                    if l_Attribute_0 and v105 and v145.Name == "Gems" then
                                        v145.Visible = false;
                                    end;
                                    if v145.Visible then
                                        game:GetService("GuiService").SelectedObject = v145;
                                    end;
                                end;
                            end;
                            v38.ViewBoxContentsXbox(v101, v102, l_ItemShopData_2);
                            game:GetService("GuiService"):AddSelectionParent("ViewBoxBuy", l_Shop_0.Info.BuyFrame.PurchaseOptions.Container);
                            l_Shop_0.Info.BuyFrame.Visible = true;
                            l_Container_0:ClearAllChildren();
                            v137 = 1;
                            for _, v148 in v102.Contents do
                                local v149 = false;
                                if v102.Chances then
                                    v149 = v102.MinimumRarity;
                                end;
                                local l_Scale_1 = script.Content.Size.Y.Scale;
                                local v151 = math.floor((v137 - 1) / (1 / l_Scale_1));
                                local v152 = (v137 - 1) % (1 / l_Scale_1);
                                local v153 = l_Sync_0[v102.BoxType][v148];
                                if not v149 or v102.Rarity == v149 then
                                    local v154 = script.Content:Clone();
                                    v154.Name = "Slot" .. v137;
                                    local l_Container_3 = v154.Container;
                                    local l_Icon_3 = l_Container_3.Icon;
                                    local l_Image_4 = v153.Image;
                                    local v158;
                                    if _G.Cache[l_Image_4] ~= nil then
                                        v158 = _G.Cache[l_Image_4];
                                    else
                                        local v159 = (tonumber(l_Image_4) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_4 or l_Image_4) .. "&bust=" .. math.random(1, 10000);
                                        _G.Cache[l_Image_4] = v159;
                                        v158 = v159;
                                    end;
                                    l_Icon_3.Image = v158;
                                    l_Container_3.ItemName.Text = v153.ItemName or v153.Name;
                                    l_Container_3.ItemName.TextColor3 = l_Rarity_0[v153.Rarity];
                                    v154.Parent = l_Container_0;
                                    v154.Position = UDim2.new(v154.Size.X.Scale * v152, 0, 0, v154.AbsoluteSize.Y * v151);
                                    l_Container_3.Button.Selectable = v95.Type == "Bundle";
                                    if v95.Type == "Bundle" then
                                        l_Container_3.Buy.MouseButton1Click:connect(function()
                                            if l_ProfileData_0.Coins >= v148.Price then
                                                script.Parent.Ching:Play();
                                                l_Container_3.Buy.Visible = false;
                                                local l_Owned_0 = l_ProfileData_0.Weapons.Owned;
                                                l_ProfileData_0.Coins = l_ProfileData_0.Coins - v148.Price;
                                                l_ProfileData_0.Weapons.Owned[v148.ItemName] = l_Owned_0[v148.ItemName] and l_Owned_0[v148.ItemName] + 1 or 1;
                                                game.ReplicatedStorage.Remotes.Shop.Buy:FireServer(v148.ItemName, "Weapons");
                                                return;
                                            else
                                                _G.GetCredits();
                                                return;
                                            end;
                                        end);
                                        l_Container_3.Price.Text = v148.Price;
                                        l_Container_3.Price.Visible = true;
                                        l_Container_3.CoinIcon.Visible = true;
                                    end;
                                    v137 = v137 + 1;
                                end;
                            end;
                            _G.CurrentFrame = "ViewContents";
                            _G.Tweening = true;
                            v138 = Enum.KeyCode.ButtonR1;
                            l_Image_3 = function()

                            end;
                            local l_l_Image_3_0 = l_Image_3 --[[ copy: 3 -> 19 ]];
                            l_ContextActionService_0:BindAction("NoRight", function(_, v163)
                                if v163 == Enum.UserInputState.Begin and not _G.PauseBinds then
                                    l_l_Image_3_0();
                                end;
                            end, false, v138);
                            v138 = Enum.KeyCode.ButtonL1;
                            l_Image_3 = function()

                            end;
                            local l_l_Image_3_1 = l_Image_3 --[[ copy: 3 -> 20 ]];
                            l_ContextActionService_0:BindAction("NoLeft", function(_, v166)
                                if v166 == Enum.UserInputState.Begin and not _G.PauseBinds then
                                    l_l_Image_3_1();
                                end;
                            end, false, v138);
                            v138 = Enum.KeyCode.ButtonB;
                            l_Image_3 = function()

                            end;
                            local l_l_Image_3_2 = l_Image_3 --[[ copy: 3 -> 21 ]];
                            l_ContextActionService_0:BindAction("ViewBack", function(_, v169)
                                if v169 == Enum.UserInputState.Begin and not _G.PauseBinds then
                                    l_l_Image_3_2();
                                end;
                            end, false, v138);
                            l_ViewContents_0.Position = UDim2.new(1, 0, 0, 0);
                            l_Main_0[v75]:TweenPosition(UDim2.new(-1, 0, 0, 0), "Out", "Quad", 0.2);
                            l_ViewContents_0:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2);
                            wait(0.2);
                            v138 = Enum.KeyCode.ButtonB;
                            l_Image_3 = function()
                                l_Main_0[v75]:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2);
                                l_ViewContents_0:TweenPosition(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.2);
                                game:GetService("GuiService").SelectedObject = l_Container_2.Button;
                                game:GetService("GuiService"):RemoveSelectionGroup("ViewBoxBuy");
                                l_Shop_0.Info.BuyFrame.Visible = false;
                                l_Info_0.Buy.ButtonIcon.Image = "rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png";
                                l_Info_0.Buy.ButtonIcon.Title.Text = "View";
                                l_ContextActionService_0:UnbindAction("ViewBack");
                                l_ContextActionService_0:UnbindAction("NoRight");
                                l_ContextActionService_0:UnbindAction("NoLeft");
                                l_ContextActionService_0:UnbindAction("BuyCrateBundle");
                            end;
                            l_ContextActionService_0:BindAction("ViewBack", function(_, v171)
                                if v171 == Enum.UserInputState.Begin and not _G.PauseBinds then
                                    l_Image_3();
                                end;
                            end, false, v138);
                            _G.Tweening = false;
                        end;
                    end);
                else
                    l_Container_2.Button.MouseButton1Click:connect(function()
                        if v102.Price == "Elite" then
                            game.ReplicatedStorage.Remotes.Shop.GetElite:FireServer();
                            return;
                        elseif v95.ItemData.PassID then
                            game.ReplicatedStorage.Remotes.Shop.GetPack:FireServer(v95.ItemData.PassID);
                            return;
                        else
                            v38.OpenBuyPopup(v101, v102, l_ItemShopData_2.DataType or v75, v75, l_ItemShopData_2);
                            game:GetService("GuiService"):AddSelectionParent("BuyPopup", l_Shop_0.Main.BuyPopup);
                            game:GetService("GuiService").SelectedObject = l_ItemShopData_2.Price.Gems ~= nil and l_Shop_0.Main.BuyPopup.Container.PriceFrame.Gems.Buy or l_ItemShopData_2.Price.SnowTokens2023 ~= nil and l_Shop_0.Main.BuyPopup.Container.PriceFrame.SnowTokens2023.Buy or l_Shop_0.Main.BuyPopup.Container.PriceFrame.Coins.Buy;
                            local l_ButtonR1_0 = Enum.KeyCode.ButtonR1;
                            local function v173()

                            end;
                            local l_v173_0 = v173 --[[ copy: 1 -> 3 ]];
                            l_ContextActionService_0:BindAction("NoRightBP", function(_, v176)
                                if v176 == Enum.UserInputState.Begin and not _G.PauseBinds then
                                    l_v173_0();
                                end;
                            end, false, l_ButtonR1_0);
                            l_ButtonR1_0 = Enum.KeyCode.ButtonL1;
                            v173 = function()

                            end;
                            local l_v173_1 = v173 --[[ copy: 1 -> 4 ]];
                            l_ContextActionService_0:BindAction("NoLeftBP", function(_, v179)
                                if v179 == Enum.UserInputState.Begin and not _G.PauseBinds then
                                    l_v173_1();
                                end;
                            end, false, l_ButtonR1_0);
                            l_ButtonR1_0 = function()
                                game:GetService("GuiService"):RemoveSelectionGroup("BuyPopup");
                                l_ContextActionService_0:UnbindAction("CloseBuyPopup");
                                l_ContextActionService_0:UnbindAction("NoRightBP");
                                l_ContextActionService_0:UnbindAction("NoLeftBP");
                            end;
                            v173 = Enum.KeyCode.ButtonB;
                            local function v180()
                                l_Shop_0.Main.BuyPopup.Visible = false;
                                game:GetService("GuiService").SelectedObject = l_Container_2.Button;
                                game:GetService("GuiService"):RemoveSelectionGroup("BuyPopup");
                                l_ContextActionService_0:UnbindAction("CloseBuyPopup");
                                l_ContextActionService_0:UnbindAction("NoRightBP");
                                l_ContextActionService_0:UnbindAction("NoLeftBP");
                            end;
                            l_ContextActionService_0:BindAction("CloseBuyPopup", function(_, v182)
                                if v182 == Enum.UserInputState.Begin and not _G.PauseBinds then
                                    v180();
                                end;
                            end, false, v173);
                            v38.SelectObject = function(v183)
                                if not v183 then
                                    game:GetService("GuiService").SelectedObject = l_Container_2.Button;
                                end;
                                game:GetService("GuiService"):RemoveSelectionGroup("BuyPopup");
                                l_ContextActionService_0:UnbindAction("CloseBuyPopup");
                                l_ContextActionService_0:UnbindAction("NoRightBP");
                                l_ContextActionService_0:UnbindAction("NoLeftBP");
                            end;
                            _G.LastShopSelection = l_Container_2.Button;
                            return;
                        end;
                    end);
                end;
                l_v77_0 = l_v77_0 + 1;
                return;
            end;
        end;
        if v75 ~= "Weapons" then
            for v185, v186 in pairs(l_Sorted_0) do
                if v186.ItemData.Price ~= "NotForSale" then
                    v184(v185, v186);
                end;
            end;
        else
            for v187, v188 in pairs(l_Sorted_0) do
                if v188.ItemData.Type ~= "Bundle" then
                    v184(v187, v188);
                end;
            end;
        end;
        for v189 = 0, l_v77_0 - 1 do
            local v190 = l_Container_1["Slot" .. v189];
            if l_Container_1:FindFirstChild("Slot" .. v189 + v82 + 1) == nil then
                local v191 = v189 + (v82 - v189 % v82);
                local v192 = nil;
                if v191 <= #l_Sorted_0 then
                    for v193 = v191, #l_Sorted_0 do
                        v192 = l_Container_1:FindFirstChild("Slot" .. v193 - 1);
                    end;
                    if v192 then
                        v190.Container.Button.NextSelectionDown = v192.Container.Button;
                    end;
                end;
            end;
        end;
    end;
end;
if _G.UnfinishedItem ~= nil then
    _G.NewItem(_G.UnfinishedItem, "You unboxed...", l_Parent_0.Inventory);
end;
comma_value = function(v194)
    local l_v194_0 = v194;
    while true do
        local v196, v197 = string.gsub(l_v194_0, "^(-?%d+)(%d%d%d)", "%1,%2");
        k = v197;
        l_v194_0 = v196;
        if not (k ~= 0) then
            break;
        end;
    end;
    return l_v194_0;
end;
UpdateCash = function()
    local l_Coins_2 = l_ProfileData_0.Coins;
    local l_Gems_2 = l_ProfileData_0.Gems;
    l_Shop_0.Cash.Amount.Text = comma_value(l_Coins_2);
    l_Shop_0.Gems.Amount.Text = comma_value(l_Gems_2);
end;
l_Remotes_0:WaitForChild("Inventory"):WaitForChild("ProfileDataChanged").Event:Connect(function(v200, _)
    if v200 == "Coins" or v200 == "Gems" then
        UpdateCash();
    end;
end);
UpdateCash();
local _ = game.Players.LocalPlayer:GetAttribute("Elite");
_G.CoinBagFull = false;
local v203 = {
    {
        Amount = "100", 
        Robux = "100R", 
        Image = "rbxassetid://3075310194", 
        Type = "Gems", 
        Color = Color3.fromRGB(11, 195, 180)
    }, 
    {
        Amount = "400", 
        Robux = "400R", 
        Image = "rbxassetid://3075319215", 
        Type = "Gems", 
        Color = Color3.fromRGB(11, 195, 180)
    }, 
    {
        Amount = "800", 
        Robux = "800R", 
        Image = "rbxassetid://3075329130", 
        Type = "Gems", 
        Color = Color3.fromRGB(11, 195, 180)
    }, 
    {
        Amount = "2200", 
        Robux = "2000R", 
        Image = "rbxassetid://3075340869", 
        Type = "Gems", 
        Color = Color3.fromRGB(27, 165, 229)
    }, 
    {
        Amount = "5500", 
        Robux = "4500R", 
        Image = "rbxassetid://3075354735", 
        Type = "Gems", 
        Color = Color3.fromRGB(27, 165, 229)
    }, 
    {
        Amount = "13000", 
        Robux = "10000R", 
        Image = "rbxassetid://3075423364", 
        Type = "Gems", 
        Color = Color3.fromRGB(142, 46, 226)
    }
};
(function()
    local l_ScrollFrame_1 = l_Shop_0.Main.Currency.Items.ScrollFrame;
    local l_Container_4 = l_ScrollFrame_1.Container;
    local l_Info_2 = l_Shop_0.Info;
    local l_Scale_2 = l_Item_0.Size.Y.Scale;
    local v208 = math.floor(1 / l_Scale_2);
    local v209 = math.floor(#v203 / v208);
    local v210 = nil;
    local v211 = nil;
    local v212 = l_Item_0:Clone();
    l_Container_4.Size = UDim2.new(1, 0, 1, 0);
    v212.Parent = l_Container_4;
    v210 = v212.AbsoluteSize.Y;
    l_Container_4.Size = UDim2.new(1, -l_ScrollFrame_1.ScrollBarThickness - 1, 1, 0);
    v211 = v212.AbsoluteSize.Y;
    v212:Destroy();
    local v213 = (v209 + 1) * v210 - 1;
    local v214 = l_ScrollFrame_1.AbsoluteSize.Y < v213;
    if v214 then
        v213 = (v209 + 1) * v211;
    end;
    l_Container_4.Size = v214 and UDim2.new(1, -l_ScrollFrame_1.ScrollBarThickness - 1, 1, 0) or UDim2.new(1, 0, 1, 0);
    l_ScrollFrame_1.CanvasSize = UDim2.new(0, 0, 0, v213);
    for v215, v216 in pairs(v203) do
        local v217 = math.floor((v215 - 1) / v208);
        local v218 = (v215 - 1) % v208;
        local v219 = script.CurrencyItem:Clone();
        local l_Container_5 = v219.Container;
        v219.Parent = l_Container_4;
        v219.Size = UDim2.new(l_Scale_2, 0, l_Scale_2, 0);
        v219.Position = UDim2.new(v219.Size.X.Scale * v218, 0, 0, v219.AbsoluteSize.Y * v217);
        l_Container_5.Amount.Text = v216.Amount;
        l_Container_5.Robux.Text = v216.Robux;
        l_Container_5.Icon.Image = v216.Image;
        l_Container_5.BG.ImageColor3 = v216.Color;
        l_Container_5.Button.MouseButton1Click:connect(function()
            game.ReplicatedStorage.Remotes.Shop.PurchaseProduct:FireServer(v216.Amount, v216.Type);
        end);
        l_Container_5.Button.SelectionGained:connect(function()
            l_Info_2.Title.Text = "+" .. v216.Amount;
            l_Info_2.Icon.Type.Text = v216.Robux;
            l_Info_2.Buy.Visible = true;
            l_Info_2.Icon.Image = "";
            l_Info_2.Icon.CurrencyIcon.Image = v216.Image;
            l_Info_2.Icon.Description.Text = "";
        end);
        v219.Name = "Slot" .. v215 - 1;
    end;
end)();
v38.GUI.ViewBoxFrame = l_Shop_0.Info;
v38.GUI.Processing = l_Parent_0.Processing;
v38.ConnectBuyPopup();
v38.ConnectViewBoxFrame();
local function v222()
    game:GetService("GuiService"):RemoveSelectionGroup("EventFrame");
    l_Parent_0.ItemBundle.Visible = false;
    _G.ResetDock();
    l_ContextActionService_0:UnbindAction("EventBack");
    local l_Parent_1 = script.Parent.Parent;
    l_Parent_1.CashBag:TweenPosition(UDim2.new(0.99, 0, 0.7, 0), "Out", "Quad", 0.2);
    l_Parent_1.Perk:TweenPosition(UDim2.new(0.99, 0, 0.99, 0), "Out", "Quad", 0.2);
    l_Parent_1.Weapon:TweenPosition(UDim2.new(0, 5, 0.8, -5), "Out", "Quad", 0.2);
    l_Parent_1.Leaderboard.Visible = true;
    l_Parent_1.Chat.Visible = true;
end;
local v223 = require(script.Parent.Parent.FeaturedItem);
local l_Attribute_2 = game.StarterGui:GetAttribute("showPrime");
local l_Prime_0 = l_Shop_0.Main.Featured.Items.ScrollFrame.Container.Prime;
local l_ItemPack_0 = l_Shop_0.Main.Featured.Items.ScrollFrame.Container.ItemPack;
local l_Christmas_0 = l_Shop_0.Main.Featured.Items.ScrollFrame.Container.Christmas;
local l_Valentines_0 = l_Shop_0.Main.Featured.Items.ScrollFrame.Container.Valentines;
local l_Summer_0 = l_Shop_0.Main.Featured.Items.ScrollFrame.Container.Summer;
local _ = l_Shop_0.Main.Featured.Items.ScrollFrame.Container.Halloween;
local l_FeaturedItem_0 = l_Shop_0.Main.Featured.Items.ScrollFrame.Container.FeaturedItem;
if not l_Attribute_2 then

end;
(function()
    local _ = l_Shop_0.Main.Featured.Items.ScrollFrame.Container;
    local l_l_FeaturedItem_0_0 = l_FeaturedItem_0;
    l_l_FeaturedItem_0_0.Name = "Slot0";
    l_l_FeaturedItem_0_0.Container.ItemName.Text = v223.ItemName;
    l_l_FeaturedItem_0_0.Container.Icon.Image = v223.Icon;
    l_l_FeaturedItem_0_0.Container.Button.MouseButton1Click:connect(function()
        _G.ResetDock();
        l_WindowService_0:ToggleFrame(v223.ViewFrame);
    end);
    local l_l_WindowService_0_Frame_0 = l_WindowService_0:GetFrame(v223.ViewFrame);
    if not l_l_WindowService_0_Frame_0 then
        return;
    else
        l_l_WindowService_0_Frame_0:GetPropertyChangedSignal("Visible"):Connect(function()
            if l_l_WindowService_0_Frame_0.Visible == true then
                game:GetService("GuiService"):AddSelectionParent(v223.ViewFrame, l_WindowService_0:GetFrame(v223.ViewFrame));
                game:GetService("GamepadService"):EnableGamepadCursor(l_WindowService_0:GetFrame(v223.ViewFrame));
                return;
            else
                game:GetService("GamepadService"):DisableGamepadCursor();
                return;
            end;
        end);
        return;
    end;
end)();
local _ = function()
    local _ = l_Shop_0.Main.Featured.Items.ScrollFrame.Container;
    l_ItemPack_0.Container.Button.MouseButton1Click:connect(function()
        _G.ResetDock();
        l_Parent_0.ItemBundle.Visible = true;
        game:GetService("GuiService").SelectedObject = l_Parent_0.ItemBundle.Frames.GodlyShop.Items.Knife.BuyItem;
        game:GetService("GuiService"):AddSelectionParent("EventFrame", l_Parent_0.ItemBundle);
        local l_ButtonB_0 = Enum.KeyCode.ButtonB;
        local function v237()
            v222();
        end;
        l_ContextActionService_0:BindAction("EventBack", function(_, v239)
            if v239 == Enum.UserInputState.Begin and not _G.PauseBinds then
                v237();
            end;
        end, false, l_ButtonB_0);
    end);
end;
local _ = function()
    local _ = l_Shop_0.Main.Featured.Items.ScrollFrame.Container;
    local l_l_Christmas_0_0 = l_Christmas_0;
    local l_Main_1 = game.Players.LocalPlayer.PlayerGui.CrossPlatform.Christmas2022.Main;
    l_l_Christmas_0_0.Container.Button.MouseButton1Click:connect(function()
        _G.ResetDock();
        l_Main_1.Visible = true;
        game:GetService("GuiService"):AddSelectionParent("Christmas2022", l_Main_1);
        game:GetService("GamepadService"):EnableGamepadCursor(l_Main_1);
    end);
end;
local _ = function()
    local _ = l_Shop_0.Main.Featured.Items.ScrollFrame.Container;
    local l_l_Valentines_0_0 = l_Valentines_0;
    local l_Valentines_1 = game.Players.LocalPlayer.PlayerGui.CrossPlatform.Valentines;
    l_l_Valentines_0_0.Container.Button.MouseButton1Click:connect(function()
        _G.ResetDock();
        l_Valentines_1.Visible = true;
        game:GetService("GuiService"):AddSelectionParent("Valentines", l_Valentines_1);
        game:GetService("GamepadService"):EnableGamepadCursor(l_Valentines_1);
    end);
end;
local _ = function()
    local _ = l_Shop_0.Main.Featured.Items.ScrollFrame.Container;
    local l_l_ItemPack_0_0 = l_ItemPack_0;
    local l_ItemPack_1 = game.Players.LocalPlayer.PlayerGui.CrossPlatform.ItemPack;
    l_l_ItemPack_0_0.Container.Button.MouseButton1Click:connect(function()
        _G.ResetDock();
        l_ItemPack_1.Visible = true;
        game:GetService("GuiService"):AddSelectionParent("ItemPack", l_ItemPack_1);
        game:GetService("GamepadService"):EnableGamepadCursor(l_ItemPack_1);
    end);
end;
local _ = function()
    local _ = l_Shop_0.Main.Featured.Items.ScrollFrame.Container;
    local l_l_Summer_0_0 = l_Summer_0;
    local l_Summer_1 = game.Players.LocalPlayer.PlayerGui.CrossPlatform.Summer;
    l_l_Summer_0_0.Container.Button.MouseButton1Click:connect(function()
        _G.ResetDock();
        l_Summer_1.Visible = true;
        game:GetService("GuiService"):AddSelectionParent("Summer", l_Summer_1);
        game:GetService("GamepadService"):EnableGamepadCursor(l_Summer_1);
    end);
end;
_G.OpenHalloweenXbox = function()
    local l_Halloween2023_0 = game.Players.LocalPlayer.PlayerGui.CrossPlatform.Halloween2023;
    _G.ResetDock();
    l_Halloween2023_0.Visible = true;
    game:GetService("GuiService"):AddSelectionParent("Halloween2023", l_Halloween2023_0);
    game:GetService("GamepadService"):EnableGamepadCursor(l_Halloween2023_0);
end;
local function _()
    l_Shop_0.Main.Featured.Items.ScrollFrame.Container.Slot0.Container.Button.MouseButton1Click:connect(function()
        _G.ResetDock();
        l_Parent_0.Halloween2022.Visible = true;
        game:GetService("GuiService"):AddSelectionParent("EventFrame", l_Parent_0.Halloween2022);
        game:GetService("GamepadService"):EnableGamepadCursor(l_Parent_0.Halloween2022);
    end);
end;
local _ = function()
    local _ = l_Shop_0.Main.Featured.Items.ScrollFrame.Container;
    l_Prime_0.Container.Button.MouseButton1Click:connect(function()
        _G.ResetDock();
        primeWindow.Visible = true;
        game:GetService("GuiService"):AddSelectionParent("PrimeGaming", primeWindow);
        game:GetService("GamepadService"):EnableGamepadCursor(primeWindow);
    end);
end;
if l_Attribute_2 then
    local _ = l_Shop_0.Main.Featured.Items.ScrollFrame.Container;
    l_Prime_0.Container.Button.MouseButton1Click:connect(function()
        _G.ResetDock();
        primeWindow.Visible = true;
        game:GetService("GuiService"):AddSelectionParent("PrimeGaming", primeWindow);
        game:GetService("GamepadService"):EnableGamepadCursor(primeWindow);
    end);
end;
local l_XboxFeatured_0 = l_DatabaseCompatability_0.XboxFeatured;
local _ = function()
    local l_ScrollFrame_2 = l_Shop_0.Main.Featured.Items.ScrollFrame;
    local l_Container_14 = l_ScrollFrame_2.Container;
    local l_Scale_3 = l_Item_0.Size.Y.Scale;
    local v266 = math.floor(1 / l_Scale_3);
    local v267 = math.floor(#v203 / v266);
    local v268 = nil;
    local v269 = nil;
    local v270 = l_Item_0:Clone();
    l_Container_14.Size = UDim2.new(1, 0, 1, 0);
    v270.Parent = l_Container_14;
    v268 = v270.AbsoluteSize.Y;
    l_Container_14.Size = UDim2.new(1, -l_ScrollFrame_2.ScrollBarThickness - 1, 1, 0);
    v269 = v270.AbsoluteSize.Y;
    v270:Destroy();
    local v271 = (v267 + 1) * v268 - 1;
    local v272 = l_ScrollFrame_2.AbsoluteSize.Y < v271;
    if v272 then
        v271 = (v267 + 1) * v269;
    end;
    l_Container_14.Size = v272 and UDim2.new(1, -l_ScrollFrame_2.ScrollBarThickness - 1, 1, 0) or UDim2.new(1, 0, 1, 0);
    l_ScrollFrame_2.CanvasSize = UDim2.new(0, 0, 0, v271);
    for v273, v274 in pairs(l_XboxFeatured_0) do
        local l_Name_0 = v274.Name;
        local l_ItemType_0 = v274.ItemType;
        local v277 = l_DatabaseCompatability_0[l_ItemType_0][l_Name_0];
        local v278 = l_DatabaseCompatability_0.Shop[l_ItemType_0][l_Name_0];
        local v279 = math.floor((v273 - 1) / v266);
        local v280 = (v273 - 1) % v266;
        local v281 = script.Item:Clone();
        local l_Container_15 = v281.Container;
        v281.Parent = l_Container_14;
        v281.Size = UDim2.new(l_Scale_3, 0, l_Scale_3, 0);
        v281.Position = UDim2.new(v281.Size.X.Scale * v280, 0, 0, v281.AbsoluteSize.Y * v279);
        l_Container_15.ItemName.Text = v277.Name or v277.Name;
        local l_Icon_4 = l_Container_15.Icon;
        local l_Image_5 = v277.Image;
        local v285;
        if _G.Cache[l_Image_5] ~= nil then
            v285 = _G.Cache[l_Image_5];
        else
            local v286 = (tonumber(l_Image_5) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_5 or l_Image_5) .. "&bust=" .. math.random(1, 10000);
            _G.Cache[l_Image_5] = v286;
            v285 = v286;
        end;
        l_Icon_4.Image = v285;
        v281.Name = "Slot" .. v273;
        l_Container_15.Button.MouseButton1Click:connect(function()
            v38.OpenBuyPopup(l_Name_0, v277, v278.DataType or l_ItemType_0, l_ItemType_0, v278);
            game:GetService("GuiService"):AddSelectionParent("BuyPopup", l_Shop_0.Main.BuyPopup);
            game:GetService("GuiService").SelectedObject = v278.Price.Gems ~= nil and l_Shop_0.Main.BuyPopup.Container.PriceFrame.Gems.Buy or l_Shop_0.Main.BuyPopup.Container.PriceFrame.Coins.Buy;
            local l_ButtonR1_1 = Enum.KeyCode.ButtonR1;
            local function v288()

            end;
            local l_v288_0 = v288 --[[ copy: 1 -> 3 ]];
            l_ContextActionService_0:BindAction("NoRightBP", function(_, v291)
                if v291 == Enum.UserInputState.Begin and not _G.PauseBinds then
                    l_v288_0();
                end;
            end, false, l_ButtonR1_1);
            l_ButtonR1_1 = Enum.KeyCode.ButtonL1;
            v288 = function()

            end;
            local l_v288_1 = v288 --[[ copy: 1 -> 4 ]];
            l_ContextActionService_0:BindAction("NoLeftBP", function(_, v294)
                if v294 == Enum.UserInputState.Begin and not _G.PauseBinds then
                    l_v288_1();
                end;
            end, false, l_ButtonR1_1);
            l_ButtonR1_1 = function()
                game:GetService("GuiService"):RemoveSelectionGroup("BuyPopup");
                l_ContextActionService_0:UnbindAction("CloseBuyPopup");
                l_ContextActionService_0:UnbindAction("NoRightBP");
                l_ContextActionService_0:UnbindAction("NoLeftBP");
            end;
            v288 = Enum.KeyCode.ButtonB;
            local function v295()
                l_Shop_0.Main.BuyPopup.Visible = false;
                game:GetService("GuiService").SelectedObject = l_Container_15.Button;
                game:GetService("GuiService"):RemoveSelectionGroup("BuyPopup");
                l_ContextActionService_0:UnbindAction("CloseBuyPopup");
                l_ContextActionService_0:UnbindAction("NoRightBP");
                l_ContextActionService_0:UnbindAction("NoLeftBP");
            end;
            l_ContextActionService_0:BindAction("CloseBuyPopup", function(_, v297)
                if v297 == Enum.UserInputState.Begin and not _G.PauseBinds then
                    v295();
                end;
            end, false, v288);
            v38.SelectObject = function(v298)
                if not v298 then
                    game:GetService("GuiService").SelectedObject = l_Container_15.Button;
                end;
                game:GetService("GuiService"):RemoveSelectionGroup("BuyPopup");
                l_ContextActionService_0:UnbindAction("CloseBuyPopup");
                l_ContextActionService_0:UnbindAction("NoRightBP");
                l_ContextActionService_0:UnbindAction("NoLeftBP");
            end;
            _G.LastShopSelection = l_Container_15.Button;
        end);
        if v38.CheckOwned(l_Name_0, l_ItemType_0) then
            v281.Tags.Owned.Visible = true;
        else
            for v299, v300 in pairs(v278.Price) do
                local l_FirstChild_1 = v281.Tags:FindFirstChild(v299);
                if l_FirstChild_1 then
                    l_FirstChild_1.Container.PriceFrame.PriceLabel.Text = v39.Commafy(v300);
                    l_FirstChild_1.Visible = true;
                end;
            end;
        end;
        l_Icon_4 = l_Shop_0.Info;
        l_Container_15.Button.SelectionGained:connect(function()
            local v302 = false;
            l_Icon_4.Title.Text = v277.Name or v277.ItemName;
            local l_Icon_5 = l_Icon_4.Icon;
            local l_Image_6 = v277.Image;
            local v305;
            if _G.Cache[l_Image_6] ~= nil then
                v305 = _G.Cache[l_Image_6];
            else
                local v306 = (tonumber(l_Image_6) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_6 or l_Image_6) .. "&bust=" .. math.random(1, 10000);
                _G.Cache[l_Image_6] = v306;
                v305 = v306;
            end;
            l_Icon_5.Image = v305;
            l_Icon_4.Icon.Type.Text = l_ItemType_0;
            l_Icon_5 = l_Icon_4.Buy;
            local l_l_Name_0_0 = l_Name_0;
            local v308 = v278.OwnedType or v278.DataType or l_ItemType_0;
            if l_ProfileData_0[v308] == nil then
                l_Image_6 = false;
            elseif l_ProfileData_0[v308].Owned[l_l_Name_0_0] then
                l_Image_6 = true;
            else
                for _, v310 in l_ProfileData_0[v308].Owned do
                    if v310 == l_l_Name_0_0 then
                        l_Image_6 = true;
                        v302 = true;
                    end;
                    if v302 then
                        break;
                    end;
                end;
                if not v302 then
                    l_Image_6 = false;
                end;
            end;
            v302 = false;
            l_Icon_5.Visible = not l_Image_6;
            l_Icon_4.Buy.ButtonIcon.Title.Text = v72[v278.DataType] and "View" or "Buy";
            l_Icon_4.Icon.CurrencyIcon.Image = "";
            if v277.Description then
                l_Icon_4.Icon.Description.Text = v277.Description;
                return;
            else
                l_Icon_4.Icon.Description.Text = "";
                return;
            end;
        end);
        v281.Name = "Slot" .. v273 - 1;
    end;
end;