-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent.Parent;
local l_Main_0 = l_Parent_0.Inventory.Main;
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Processing_0 = l_Parent_0.Processing;
local l_ReplicatedStorage_0 = game.ReplicatedStorage;
local l_Remotes_0 = l_ReplicatedStorage_0.Remotes;
local l_Attribute_0 = game.Players.LocalPlayer:GetAttribute("Radio");
local function _(v7)
    if _G.Cache[v7] ~= nil then
        return _G.Cache[v7];
    else
        local v8 = (tonumber(v7) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v7 or v7) .. "&bust=" .. math.random(1, 10000);
        _G.Cache[v7] = v8;
        return v8;
    end;
end;
local l_ContextActionService_0 = game:GetService("ContextActionService");
local _ = function(v11, v12, v13)
    l_ContextActionService_0:BindAction(v11, function(_, v15)
        if v15 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v13();
        end;
    end, false, v12);
end;
local _ = function(v17, _, _)
    l_ContextActionService_0:UnbindAction(v17);
end;
local v21 = nil;
local l_DatabaseCompatability_0 = require(script:WaitForChild("DatabaseCompatability"));
local l_Rarity_0 = l_DatabaseCompatability_0.Rarity;
local v24 = {
    Classic = 1, 
    Common = 2, 
    Uncommon = 3, 
    Rare = 4, 
    Legendary = 5, 
    Godly = 6, 
    Victim = 7, 
    Unique = 7, 
    Christmas = 1.5, 
    Halloween = 1.6, 
    Ancient = 6.5
};
local v25 = {
    Weapons = nil, 
    Effects = nil, 
    Perks = nil, 
    Emotes = nil, 
    Radios = nil, 
    Pets = nil
};
local v26 = {
    "Weapons", 
    "Perks", 
    "Effects", 
    "Pets"
};
local v27 = {
    {
        ItemID = nil, 
        Amount = 0
    }, 
    {
        ItemID = nil, 
        Amount = 0
    }, 
    {
        ItemID = nil, 
        Amount = 0
    }, 
    {
        ItemID = nil, 
        Amount = 0
    }
};
local v28 = {};
local function v29(v30)
    local v31 = {};
    for v32, v33 in pairs(v30) do
        if type(v33) == "table" then
            v33 = v29(v33);
        end;
        v31[v32] = v33;
    end;
    return v31;
end;
local function v43(v34, v35, v36, v37)
    local v38 = (not not v34:IsA("ImageLabel") or v34:IsA("ImageButton")) and v34 or v34.Icon;
    v37 = v37 == "Item" and "Weapons" or v37;
    if v35 == nil then
        v38.Image = "";
        v34.ItemName.Text = "";
        if v34:FindFirstChild("Amount") then
            v34.Amount.Text = "";
            return;
        end;
    else
        local v39 = l_DatabaseCompatability_0[v37 or "Weapons"][v35];
        local l_Image_0 = v39.Image;
        local v41;
        if _G.Cache[l_Image_0] ~= nil then
            v41 = _G.Cache[l_Image_0];
        else
            local v42 = (tonumber(l_Image_0) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_0 or l_Image_0) .. "&bust=" .. math.random(1, 10000);
            _G.Cache[l_Image_0] = v42;
            v41 = v42;
        end;
        v38.Image = v41;
        v34.ItemName.Text = v39.ItemName or v39.Name;
        v34.ItemName.TextColor3 = v39.Rarity and l_Rarity_0[v39.Rarity] or Color3.new(1, 1, 1);
        if tonumber(v36) and v34:FindFirstChild("Amount") then
            v34.Amount.Text = "x" .. v36;
        end;
        if v34:FindFirstChild("Rarity") then
            v34.Rarity.Text = v39.Rarity or "";
            v34.Rarity.TextColor3 = l_Rarity_0[v39.Rarity] or Color3.new(1, 1, 1);
        end;
    end;
end;
local function v66()
    for _, v45 in pairs(v26) do
        local v46 = v29(l_ProfileData_0[v45]);
        if v46 ~= nil then
            table.sort(v46.Owned, function(v47, v48)
                return v47 < v48;
            end);
            v25[v45] = v46;
        end;
    end;
    for _, v50 in pairs({
        "Weapons", 
        "Pets"
    }) do
        local v51 = v29(l_ProfileData_0[v50]);
        local v52 = {};
        for v53, v54 in pairs(v51.Owned) do
            table.insert(v52, {
                ItemID = v53, 
                Amount = v54
            });
        end;
        if v50 == "Weapons" then
            for _, v56 in pairs(l_ProfileData_0.Uniques) do
                local l_BaseItem_0 = v56.BaseItem;
                if v56.EvoEquipped then
                    local v58 = 1;
                    for v59 = 1, 4 do
                        if v56.XP >= l_DatabaseCompatability_0.Weapons[l_BaseItem_0].Evo[v59].XPRequired then
                            v58 = v59;
                        end;
                    end;
                    l_BaseItem_0 = l_DatabaseCompatability_0.Weapons[l_BaseItem_0].Evo[v58].ItemName;
                end;
                table.insert(v52, {
                    ItemID = l_BaseItem_0, 
                    Amount = 1
                });
            end;
        end;
        table.sort(v52, function(v60, v61)
            local v62 = {
                v60.ItemID, 
                v61.ItemID
            };
            local v63 = {
                v60.Amount, 
                v61.Amount
            };
            local v64 = {
                l_DatabaseCompatability_0[v50][v62[1]], 
                l_DatabaseCompatability_0[v50][v62[2]]
            };
            local v65 = {
                v24[v64[1].Rarity], 
                v24[v64[2].Rarity]
            };
            if v62[1] == "DefaultKnife" then
                return true;
            elseif v62[2] == "DefaultKnife" then
                return false;
            elseif v62[1] == "DefaultGun" then
                return true;
            elseif v62[2] == "DefaultGun" then
                return false;
            elseif v65[1] ~= v65[2] then
                return v65[1] > v65[2];
            elseif v63[1] ~= v63[2] then
                return v63[1] > v63[2];
            else
                return v64[1][v50 == "Weapons" and "ItemName" or "Name"] < v64[2][v50 == "Weapons" and "ItemName" or "Name"];
            end;
        end);
        v51.Owned = v52;
        v25[v50] = v51;
    end;
end;
local function _()

end;
local _ = function(v68)
    local v69 = v28[1];
    local v70 = l_DatabaseCompatability_0.Weapons[v68];
    local v71 = false;
    for _, v73 in pairs(l_DatabaseCompatability_0.Recyclable) do
        if v73 == v68 then
            v71 = true;
        end;
    end;
    if v69 and v71 then
        local v74 = l_DatabaseCompatability_0.Weapons[v69];
        local l_ItemType_0 = v74.ItemType;
        if v74.Rarity == v70.Rarity and v70.ItemType == l_ItemType_0 then
            local v76 = 0;
            for _, v78 in pairs(v25.Weapons.Owned) do
                if v78.ItemID == v68 then
                    v76 = v78.Amount;
                    break;
                end;
            end;
            for _, v80 in pairs(v28) do
                if v80 == v68 then
                    v76 = v76 - 1;
                end;
            end;
            return v76 > 0, "Not Enough";
        else
            local v81 = false;
            if v70.ItemType ~= l_ItemType_0 then
                return v81, "Wrong Type";
            else
                return v81, "Wrong Rarity";
            end;
        end;
    else
        return v71, "Can't Recycle";
    end;
end;
local _ = {
    Common = "Uncommon", 
    Uncommon = "Rare", 
    Rare = "Legendary"
};
local _ = {};
local function _()

end;
for _, _ in pairs(v27) do

end;
local function v105()
    for _, v89 in pairs(v26) do
        if v89 ~= "Weapons" and v25[v89].Equipped then
            local l_Equipped_0 = l_Main_0[v89].Equipped;
            for v91, v92 in pairs(v25[v89].Equipped) do
                local v93 = l_Equipped_0["Slot" .. v91];
                local l_Image_1 = l_DatabaseCompatability_0[v89][v92].Image;
                local v95;
                if _G.Cache[l_Image_1] ~= nil then
                    v95 = _G.Cache[l_Image_1];
                else
                    local v96 = (tonumber(l_Image_1) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_1 or l_Image_1) .. "&bust=" .. math.random(1, 10000);
                    _G.Cache[l_Image_1] = v96;
                    v95 = v96;
                end;
                v93.Image = v95;
                v93.ItemName.Text = l_DatabaseCompatability_0[v89][v92].Name;
                v93.MouseButton1Click:connect(function()
                    if l_DatabaseCompatability_0.SlotInfo[v89] and l_DatabaseCompatability_0.SlotInfo[v89].Unequip then
                        table.remove(l_ProfileData_0[v89].Equipped, v91);
                        v21();
                        l_Remotes_0.Inventory.Unequip:FireServer(v91, v89);
                    end;
                end);
            end;
        else
            for v97, v98 in pairs(v25.Weapons.Equipped) do
                if v97 ~= "Misc" then
                    local v99 = v97 == "Knife" and l_Main_0.Weapons.Equipped or l_Main_0.Weapons.Equipped.Knife;
                    local v100 = l_DatabaseCompatability_0.Weapons[v98];
                    local l_Icon_0 = v99[v97].Icon;
                    local l_Image_2 = v100.Image;
                    local v103;
                    if _G.Cache[l_Image_2] ~= nil then
                        v103 = _G.Cache[l_Image_2];
                    else
                        local v104 = (tonumber(l_Image_2) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_2 or l_Image_2) .. "&bust=" .. math.random(1, 10000);
                        _G.Cache[l_Image_2] = v104;
                        v103 = v104;
                    end;
                    l_Icon_0.Image = v103;
                    v99[v97].ItemName.Text = v100.ItemName;
                    v99[v97].ItemName.TextColor3 = l_Rarity_0[v100.Rarity];
                end;
            end;
        end;
    end;
end;
local function v111(v106, v107)
    for _, v109 in pairs(v25[v106].Equipped) do
        if v109 == v107 then
            return;
        end;
    end;
    table.insert(v25[v106].Equipped, 1, v107);
    local v110 = #v25[v106].Equipped;
    if v25[v106].Slots < v110 then
        table.remove(v25[v106].Equipped, v110);
    end;
    v105();
    l_ReplicatedStorage_0.Remotes.Inventory.Equip:FireServer(v107, v106);
end;
local function v116(v112, _, v114, _)
    if v114.ItemType ~= "Misc" then
        v25.Weapons.Equipped[v114.ItemType] = v112;
        v105();
        l_ReplicatedStorage_0.Remotes.Inventory.Equip:FireServer(v112, "Weapons");
    end;
end;
local v157 = {
    Weapons = {
        FrameFunction = function(v117, _, v119)
            local v120 = l_DatabaseCompatability_0.Weapons[v119.ItemID];
            v117.Icon.Image = v120.Image;
            v117.ItemName.Text = v120.ItemName;
            v117.ItemName.TextColor3 = l_Rarity_0[v120.Rarity];
            v117.Rarity.Text = v120.Rarity;
            v117.Rarity.TextColor3 = l_Rarity_0[v120.Rarity];
            if v119.Amount > 1 then
                v117.Amount.Text = "x" .. v119.Amount;
            end;
            v117.Button.MouseButton1Click:connect(function()
                v116(v119.ItemID, v119.Amount, v120);
            end);
        end
    }, 
    Effects = {
        FrameFunction = function(v121, _, v123)
            local v124 = l_DatabaseCompatability_0.Effects[v123];
            v121.Icon.Image = v124.Image;
            v121.Type.Text = v124.Type;
            v121.ItemName.Text = v124.Name;
        end
    }, 
    Perks = {
        FrameFunction = function(v125, _, v127)
            local v128 = l_DatabaseCompatability_0.Perks[v127];
            local l_Icon_1 = v125.Icon;
            local l_Image_3 = v128.Image;
            local v131;
            if _G.Cache[l_Image_3] ~= nil then
                v131 = _G.Cache[l_Image_3];
            else
                local v132 = (tonumber(l_Image_3) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_3 or l_Image_3) .. "&bust=" .. math.random(1, 10000);
                _G.Cache[l_Image_3] = v132;
                v131 = v132;
            end;
            l_Icon_1.Image = v131;
            v125.ItemName.Text = v128.Name;
        end
    }, 
    Emotes = {
        FrameFunction = function(v133, _, v135)
            local v136 = l_DatabaseCompatability_0.Emotes[v135];
            v133.ItemName.Text = v136.Name;
            v133.Icon.Image = v136.Image;
            v133.Type.Text = "";
        end
    }, 
    Radios = {
        FrameFunction = function(v137, _, v139)
            local v140 = l_DatabaseCompatability_0.Radios[v139];
            v137.ItemName.Text = v140.Name;
            v137.Icon.Image = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v140.Image;
        end
    }, 
    Toys = {
        FrameFunction = function(v141, _, v143)
            local v144 = l_DatabaseCompatability_0.Toys[v143];
            v141.ItemName.Text = v144.Name;
            local l_Icon_2 = v141.Icon;
            local l_Image_4 = v144.Image;
            local v147;
            if _G.Cache[l_Image_4] ~= nil then
                v147 = _G.Cache[l_Image_4];
            else
                local v148 = (tonumber(l_Image_4) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_4 or l_Image_4) .. "&bust=" .. math.random(1, 10000);
                _G.Cache[l_Image_4] = v148;
                v147 = v148;
            end;
            l_Icon_2.Image = v147;
        end
    }, 
    Pets = {
        FrameFunction = function(v149, _, v151)
            local v152 = l_DatabaseCompatability_0.Pets[v151.ItemID];
            local l_Icon_3 = v149.Icon;
            local l_Image_5 = v152.Image;
            local v155;
            if _G.Cache[l_Image_5] ~= nil then
                v155 = _G.Cache[l_Image_5];
            else
                local v156 = (tonumber(l_Image_5) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_5 or l_Image_5) .. "&bust=" .. math.random(1, 10000);
                _G.Cache[l_Image_5] = v156;
                v155 = v156;
            end;
            l_Icon_3.Image = v155;
            v149.ItemName.Text = v152.Name;
            v149.ItemName.TextColor3 = l_Rarity_0[v152.Rarity];
            v149.Rarity.Text = v152.Rarity;
            v149.Rarity.TextColor3 = l_Rarity_0[v152.Rarity];
            if v151.Amount > 1 then
                v149.Amount.Text = "x" .. v151.Amount;
            end;
            v149.MouseEnter:connect(function()
                v149.Rarity.Visible = true;
            end);
            v149.MouseLeave:connect(function()
                v149.Rarity.Visible = false;
            end);
        end
    }
};
local function v177(v158)
    if v25[v158] == nil then
        return;
    else
        local v159 = 0;
        local l_ScrollFrame_0 = l_Main_0[v158].Items.ScrollFrame;
        local l_Container_0 = l_ScrollFrame_0.Container;
        local v162 = v157[v158] and v157[v158].Size or 0.2;
        local v163 = v157[v158] and v157[v158].FrameFunction or function()

        end;
        local l_Y_0 = l_ScrollFrame_0.CanvasPosition.Y;
        local v165 = false;
        l_ScrollFrame_0.Changed:connect(function()
            if v165 then
                return;
            else
                if l_ScrollFrame_0.CanvasPosition.Y > l_Y_0 then
                    v165 = true;
                    l_ScrollFrame_0.CanvasPosition = Vector2.new(0, l_ScrollFrame_0.CanvasPosition.Y + 20);
                    game:GetService("RunService").RenderStepped:wait();
                    v165 = false;
                end;
                l_Y_0 = l_ScrollFrame_0.CanvasPosition.Y;
                return;
            end;
        end);
        if v25[v158].Equipped and v158 ~= "Weapons" then
            l_Main_0[v158].Equipped:ClearAllChildren();
            local v166 = script.EquipSlot:Clone();
            v166.ItemName.Text = "Empty";
            v166.Parent = l_Main_0[v158].Equipped;
            v166.Name = "Slot" .. 1;
            local v167 = true;
            if v158 ~= "Effects" then
                v167 = v158 == "Pets";
            end;
            v166.Selectable = v167;
        end;
        l_Container_0:ClearAllChildren();
        local v168 = nil;
        local function v174(v169, v170)
            if v170 ~= "None" then
                local v171 = math.floor(v159 / (1 / v162));
                local v172 = v159 % (1 / v162);
                local v173 = v170 == "GetMore" and script.GetMore:Clone() or script.Item:Clone();
                v173.Size = UDim2.new(v162, 0, v162, 0);
                v173.Parent = l_Container_0;
                if not v168 then
                    v168 = v173.AbsoluteSize.Y;
                end;
                v173.Position = UDim2.new(v162 * v172, 0, 0, v168 * v171);
                v173.Name = "Slot" .. v159;
                if v169 and v170 then
                    v163(v173.Container, v169, v170);
                    if v158 ~= "Weapons" and v158 ~= "Emotes" then
                        v173.Container.Button.MouseButton1Click:Connect(function()
                            if v158 == "Pets" then
                                v111(v158, v170.ItemID);
                                return;
                            else
                                v111(v158, v170);
                                return;
                            end;
                        end);
                    end;
                end;
                if v170 == "GetMore" then
                    v173.Container.Button.MouseButton1Click:Connect(function()
                        _G.Navigate(v158, 0);
                    end);
                end;
                l_ScrollFrame_0.CanvasSize = UDim2.new(0, 0, 0, (v171 + 1) * v168);
                v159 = v159 + 1;
            end;
        end;
        if l_Main_0[v158]:FindFirstChild("BuyRadio") and l_Attribute_0 then
            l_Main_0[v158].BuyRadio.Visible = false;
        end;
        for v175, v176 in pairs(v25[v158].Owned) do
            v174(v175, v176);
        end;
        return;
    end;
end;
v21 = function(v178)
    if not v178 then
        local l_SelectedObject_0 = game:GetService("GuiService").SelectedObject;
        local v180 = nil;
        local v181 = nil;
        if l_SelectedObject_0 then
            v180 = l_SelectedObject_0.Name;
            v181 = l_SelectedObject_0.Parent;
        end;
        v66();
        for _, v183 in v26 do
            v177(v183);
        end;
        v105();
        if v180 and v181 then
            game:GetService("GuiService").SelectedObject = v181[v180];
        end;
    end;
end;
v21();
game.ReplicatedStorage.Remotes.Inventory.InventoryDataChanged.Event:Connect(v21);
local function _()

end;
local l_NewItem_0 = l_Parent_0.NewItem;
local v186 = nil;
local v187 = {};
local function v188()
    local v189 = v187[1];
    v43(l_NewItem_0.Container.Item, v189.ItemName, nil, v189.Type);
    l_NewItem_0.Container.Title.Text = v189.TitleText;
    if v189.LFrame then
        v186 = v189.LFrame;
        v186.Visible = false;
    end;
    l_NewItem_0.Visible = true;
    local l_ButtonA_0 = Enum.KeyCode.ButtonA;
    local function v192()
        l_ContextActionService_0:UnbindAction("Claim");
        l_ContextActionService_0:UnbindAction("Claim2");
        l_NewItem_0.Visible = false;
        _G.UnfinishedItem = nil;
        table.remove(v187, 1);
        if v187[1] ~= nil then
            v188();
            return;
        else
            if v186 then
                v186.Visible = true;
            end;
            local v191 = _G.LastShopSelection and _G.LastShopSelection.Parent and (_G.LastShopSelection.Parent.Name == "BattlePass" or _G.LastShopSelection.Parent.Parent.Parent.Name == "BattlePass");
            if _G.LastShopSelection and (v191 or v186 and v186.Name == "Shop") then
                game:GetService("GuiService").SelectedObject = _G.LastShopSelection;
            end;
            return;
        end;
    end;
    local l_v192_0 = v192 --[[ copy: 2 -> 3 ]];
    l_ContextActionService_0:BindAction("Claim", function(_, v195)
        if v195 == Enum.UserInputState.Begin and not _G.PauseBinds then
            l_v192_0();
        end;
    end, false, l_ButtonA_0);
    l_ButtonA_0 = Enum.KeyCode.ButtonB;
    v192 = function()
        l_ContextActionService_0:UnbindAction("Claim");
        l_ContextActionService_0:UnbindAction("Claim2");
        l_NewItem_0.Visible = false;
        _G.UnfinishedItem = nil;
        table.remove(v187, 1);
        if v187[1] ~= nil then
            v188();
            return;
        else
            if v186 then
                v186.Visible = true;
            end;
            local v196 = _G.LastShopSelection and _G.LastShopSelection.Parent and (_G.LastShopSelection.Parent.Name == "BattlePass" or _G.LastShopSelection.Parent.Parent.Parent.Name == "BattlePass");
            if _G.LastShopSelection and (v196 or v186 and v186.Name == "Shop") then
                game:GetService("GuiService").SelectedObject = _G.LastShopSelection;
            end;
            return;
        end;
    end;
    l_ContextActionService_0:BindAction("Claim2", function(_, v198)
        if v198 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v192();
        end;
    end, false, l_ButtonA_0);
end;
_G.NewItem = function(v199, v200, v201, v202)
    table.insert(v187, {
        ItemName = v199, 
        TitleText = v200 or "You Got...", 
        LFrame = v201, 
        Type = v202 or "Weapons"
    });
    if not l_NewItem_0.Visible then
        v188();
    end;
end;
game.ReplicatedStorage.ItemGift.OnClientEvent:connect(function(v203, v204)
    _G.NewItem(v203, "You Got...", nil, v204);
end);
_G.Process = function(v205)
    if not v205 then
        l_Processing_0.Visible = false;
        return;
    else
        l_Processing_0.Title.Text = v205;
        spawn(function()
            while l_Processing_0.Visible == true do
                l_Processing_0.Frame.Spinner.Rotation = l_Processing_0.Frame.Spinner.Rotation + 5;
                game:GetService("RunService").RenderStepped:wait();
            end;
        end);
        spawn(function()
            while l_Processing_0.Visible == true do
                wait(0.2);
                l_Processing_0.Title.Text = l_Processing_0.Title.Text .. ".";
            end;
        end);
        l_Processing_0.Visible = true;
        return;
    end;
end;