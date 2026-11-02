-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent.Parent.Parent;
local _ = game.ReplicatedStorage;
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_MysteryBox_0 = l_Sync_0.MysteryBox;
local l_Rarity_0 = l_Sync_0.Rarity;
local l_Item_0 = l_Sync_0.Item;
local l_Pets_0 = l_Sync_0.Pets;
local v7 = {
    Common = Color3.new(0.2196078431372549, 0.2196078431372549, 0.2196078431372549), 
    Uncommon = Color3.new(0.12156862745098039, 0.1411764705882353, 0.1411764705882353), 
    Rare = Color3.new(0.13725490196078433, 0.17647058823529413, 0.13333333333333333), 
    Legendary = Color3.new(0.16470588235294117, 0.10196078431372549, 0.10980392156862745), 
    Godly = Color3.new(0.18823529411764706, 0.10196078431372549, 0.19215686274509805)
};
local function _(v8)
    if _G.Cache[v8] ~= nil then
        return _G.Cache[v8];
    else
        local v9 = (tonumber(v8) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v8 or v8) .. "&bust=" .. math.random(1, 10000);
        _G.Cache[v8] = v9;
        return v9;
    end;
end;
local l_ContextActionService_0 = game:GetService("ContextActionService");
local _ = function(v12, v13, v14)
    l_ContextActionService_0:BindAction(v12, function(_, v16)
        if v16 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v14();
        end;
    end, false, v13);
end;
local _ = function(v18, _, _)
    l_ContextActionService_0:UnbindAction(v18);
end;
return function(v22, v23)
    _G.UnfinishedItem = v23;
    _G.UnfinishedType = l_MysteryBox_0[v22].Type;
    local l_ItemRow_0 = l_Parent_0.CrateOpen.Container.ItemRow;
    local l_ButtonX_0 = Enum.KeyCode.ButtonX;
    local function v26()

    end;
    local l_v26_0 = v26 --[[ copy: 4 -> 29 ]];
    l_ContextActionService_0:BindAction("CrateX", function(_, v29)
        if v29 == Enum.UserInputState.Begin and not _G.PauseBinds then
            l_v26_0();
        end;
    end, false, l_ButtonX_0);
    l_ButtonX_0 = Enum.KeyCode.ButtonY;
    v26 = function()

    end;
    local l_v26_1 = v26 --[[ copy: 4 -> 30 ]];
    l_ContextActionService_0:BindAction("CrateY", function(_, v32)
        if v32 == Enum.UserInputState.Begin and not _G.PauseBinds then
            l_v26_1();
        end;
    end, false, l_ButtonX_0);
    l_ButtonX_0 = Enum.KeyCode.ButtonB;
    v26 = function()

    end;
    local l_v26_2 = v26 --[[ copy: 4 -> 31 ]];
    l_ContextActionService_0:BindAction("CrateB", function(_, v35)
        if v35 == Enum.UserInputState.Begin and not _G.PauseBinds then
            l_v26_2();
        end;
    end, false, l_ButtonX_0);
    l_ButtonX_0 = Enum.KeyCode.ButtonA;
    v26 = function()

    end;
    local l_v26_3 = v26 --[[ copy: 4 -> 32 ]];
    l_ContextActionService_0:BindAction("CrateA", function(_, v38)
        if v38 == Enum.UserInputState.Begin and not _G.PauseBinds then
            l_v26_3();
        end;
    end, false, l_ButtonX_0);
    l_ItemRow_0:ClearAllChildren();
    l_ButtonX_0 = l_MysteryBox_0[v22].Contents;
    v26 = l_MysteryBox_0[v22].Type == "Weapons" and l_Item_0 or l_Pets_0;
    local _ = v26[v23];
    local v40 = nil;
    for v41 = 1, 23 do
        local v42 = nil;
        local v43 = nil;
        if not l_MysteryBox_0[v22].Chances then
            local v44 = math.random(1, 100);
            v42 = v44 >= 1 and v44 <= 60 and "Common" or v44 > 60 and v44 <= 85 and "Uncommon" or v44 > 80 and v44 <= 95 and "Rare" or "Legendary";
            local v45 = {
                Common = {}, 
                Uncommon = {}, 
                Rare = {}, 
                Legendary = {}, 
                Godly = {
                    l_MysteryBox_0[v22].Godly
                }
            };
            for _, v47 in pairs(l_ButtonX_0) do
                table.insert(v45[v26[v47].Rarity], v47);
            end;
            v43 = v26[v45[v42][math.random(1, #v45[v42])]];
            if math.random(1, 500) == 1 then
                v42 = "Godly";
                v43 = v26[l_MysteryBox_0[v22].Godly];
            end;
        else
            local l_Chances_0 = l_MysteryBox_0[v22].Chances;
            local v49 = {};
            for v50, v51 in pairs(l_Chances_0) do
                if v51 >= 0 then
                    v49[v50] = {};
                    for _, v53 in pairs(l_MysteryBox_0) do
                        if v53.Contents and v53.Type == "Weapons" then
                            for _, v55 in pairs(v53.Contents) do
                                if v26[v55].Rarity == v50 then
                                    table.insert(v49[v50], v55);
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            local _ = math.random(1, 100);
            local v57 = {};
            for v58, v59 in pairs(l_Chances_0) do
                for _ = 1, v59 do
                    table.insert(v57, v58);
                end;
            end;
            v42 = v57[math.random(1, #v57)];
            v57 = {};
            v43 = v26[v49[v42][math.random(1, #v49[v42])]];
            if l_Chances_0.Common <= 0 and math.random(1, 500) == 1 then
                v42 = "Godly";
                local v61 = {};
                for _, v63 in pairs(l_MysteryBox_0) do
                    if v63.Type == "Weapons" and v63.Godly then
                        table.insert(v61, v63.Godly);
                    end;
                end;
                v43 = v26[v61[math.random(1, #v61)]];
            end;
        end;
        if v41 == 20 then
            v43 = v26[v23];
            v42 = v43.Rarity;
        end;
        local v64 = script.Item:Clone();
        v64.Parent = l_ItemRow_0;
        v64.Position = UDim2.new(0, v64.AbsoluteSize.X * (v41 - 1) - v64.AbsoluteSize.X / 2, 0.5, -v64.AbsoluteSize.Y / 2);
        local v65 = l_MysteryBox_0[v22].Type == "Weapons" and "ItemName" or "Name";
        v64.Container.ItemName.Text = v43[v65];
        v64.Container.ItemName.TextColor3 = l_Rarity_0[v42];
        v64.Container.RarityBar.BackgroundColor3 = l_Rarity_0[v42];
        v64.Container.BackgroundColor3 = v7[v42];
        local l_Icon_0 = v64.Container.Icon;
        local l_Image_0 = v43.Image;
        local v68;
        if _G.Cache[l_Image_0] ~= nil then
            v68 = _G.Cache[l_Image_0];
        else
            local v69 = (tonumber(l_Image_0) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_0 or l_Image_0) .. "&bust=" .. math.random(1, 10000);
            _G.Cache[l_Image_0] = v69;
            v68 = v69;
        end;
        l_Icon_0.Image = v68;
        v40 = v64;
    end;
    l_ItemRow_0.Position = UDim2.new(0.5, 0, 0.05, 0);
    l_Parent_0.Processing.Visible = false;
    l_Parent_0.CrateOpen.Visible = true;
    local v70 = 0;
    local v71 = 19 * v40.AbsoluteSize.X;
    local v72 = 15;
    v71 = v71 + math.random(-(v40.AbsoluteSize.X / 2), v40.AbsoluteSize.X / 2);
    local v73 = v71 - v40.AbsoluteSize.X * (math.random(200, 400) / 100);
    wait(0.25);
    while v70 < v71 do
        local v74 = v70 - v73;
        local v75 = v71 - v73 - v40.AbsoluteSize.X / 2;
        if v73 <= v70 then
            v72 = 15 * (1 - v74 / v75);
            if v72 < 1 then
                v72 = 1;
            end;
        end;
        l_ItemRow_0.Position = UDim2.new(0.5, l_ItemRow_0.Position.X.Offset - v72, 0.05, 0);
        v70 = v70 + v72;
        if v72 >= 5 then
            game:GetService("RunService").RenderStepped:wait();
        else
            game:GetService("RunService").RenderStepped:wait();
        end;
    end;
    wait(1.25);
    l_ContextActionService_0:UnbindAction("CrateX");
    l_ContextActionService_0:UnbindAction("CrateA");
    l_ContextActionService_0:UnbindAction("CrateB");
    l_ContextActionService_0:UnbindAction("CrateY");
    l_Parent_0.CrateOpen.Visible = false;
    _G.NewItem(v23, "You Unboxed...", l_Parent_0.Inventory, l_MysteryBox_0[v22].Type);
    game.ReplicatedStorage.Remotes.Shop.CrateComplete:FireServer();
    l_Parent_0.Dock.Visible = true;
end;