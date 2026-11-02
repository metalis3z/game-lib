-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local LootLibrary = require(ReplicatedStorage.Modules.LootLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local LootboxChanceSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LootboxChanceSlot");
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2, p3, p4, ...) -- Line: 20
    -- upvalues: Prompt (copy), u1 (copy)
    local v5 = Prompt.new(script.Name);
    local v6 = setmetatable(v5, u1);
    v6.CloseButton = v6.PromptFrame:WaitForChild("Close");
    v6.List = v6.PromptFrame:WaitForChild("List");
    v6.Container = v6.List:WaitForChild("Container");
    v6.Layout = v6.Container:WaitForChild("Layout");
    v6._root_name = p2;
    v6._root_weapon = p3 or "IsRandom";
    v6._back_to_prompt_name = p4;
    v6._back_to_prompt_args = { ... };
    v6:_Init();

    return v6;
end;

function u1.CloseRequest(p7) -- Line: 42
    -- upvalues: Prompt (copy)
    if p7._back_to_prompt_name then
        p7.OpenPrompt:Fire(p7._back_to_prompt_name, table.unpack(p7._back_to_prompt_args));

        return;
    end;

    Prompt.CloseRequest(p7);
end;

function u1._GenerateOddsData(u8, p9, p10, u11, p12) -- Line: 54
    -- upvalues: CosmeticLibrary (copy), LootLibrary (copy), PlayerDataController (copy), ShopLibrary (copy), CONSTANTS (copy), ItemLibrary (copy), LootboxChanceSlot (copy), WeaponStatusHandler (copy), RewardSlot (copy), ButtonEffect (copy)
    local RewardData = p10.RewardData;
    local DisplayType = p10.DisplayType;
    local v13 = RewardData.Name .. (RewardData.Quantity and RewardData.Quantity > 1 and (" [×" .. RewardData.Quantity .. "]" or "") or "");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local v14 = nil;
    local v15 = "";
    local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);
    local v16 = nil;
    local v17 = CosmeticLibrary.Cosmetics[RewardData.Name];
    local v18 = CosmeticLibrary.Rewards[RewardData.Name];
    local u19 = {};

    if v17 then
        Color3_fromRGB_ret = CosmeticLibrary.Rarities[v17.Rarity].Color;
        v15 = v17.Rarity .. " " .. v17.Type;

        if RewardData.Weapon == "IsUniversal" then
            v15 = v15 .. " for all weapons";
        elseif RewardData.Weapon == "IsRandom" then
            v15 = v15 .. " for a random weapon";
            local UnlockedWeaponsForSelection = LootLibrary:GetUnlockedWeaponsForSelection(PlayerDataController:Get("WeaponInventory"), true, RewardData.Name, PlayerDataController:Get("CosmeticInventory"));
            local v20 = {};
            local v21 = {};

            for _, v in pairs(ShopLibrary:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET, ShopLibrary.OwnableWeaponsAlphabetized)) do
                if not table.find(UnlockedWeaponsForSelection, v) then
                    if PlayerDataController:GetWeaponData(v) then
                        table.insert(v20, v);
                    else
                        table.insert(v21, v);
                    end;
                end;
            end;

            local function add_these(p22, p23) -- Line: 93
                -- upvalues: RewardData (copy), u19 (copy)
                for _, v in pairs(p22) do
                    table.insert(u19, {
                        Weight = 1,
                        RewardData = {
                            Name = RewardData.Name,
                            Weapon = v
                        },
                        DisplayType = p23
                    });
                end;
            end;

            add_these(UnlockedWeaponsForSelection, "Default");
            add_these(v20, "Owned");
            add_these(v21, "Locked");
        elseif RewardData.Weapon then
            v15 = v15 .. " for " .. RewardData.Weapon;
            v16 = ItemLibrary.Items[RewardData.Weapon].Status;
        end;
    elseif v18 then
        if v18.Type == "Weapon" then
            local v24 = ItemLibrary.Items[RewardData.Name];
            v15 = v24.Status .. " Weapon";
            v14 = v24.Status;
        else
            v15 = v18.Type;

            if RewardData.Weapon == "IsUniversal" then
                v15 = v15 .. " for all weapons";
            elseif RewardData.Weapon == "IsRandom" then
                v15 = v15 .. " for a random weapon";
            elseif RewardData.Weapon then
                v15 = v15 .. " for " .. RewardData.Weapon;
                v16 = ItemLibrary.Items[RewardData.Weapon].Status;
            end;

            if v18.Type == "Lootbox" then
                local LootboxPossibilities, v25, v26 = LootLibrary:GetLootboxPossibilities(v18.SmartRestrictionsEnabled, v18.GetContents(RewardData.Weapon), PlayerDataController:Get("CosmeticInventory"), PlayerDataController:GetUnlockedWeapons(), RewardData.Weapon);

                local function v29(p27, p28) -- Line: 129
                    -- upvalues: u19 (copy)
                    for _, v in pairs(p27) do
                        table.insert(u19, {
                            Weight = v.Weight,
                            RewardData = v.Reward,
                            DisplayType = p28
                        });
                    end;
                end;

                v29(LootboxPossibilities, "Default");
                v29(v26, "Owned");
                v29(v25, "Locked");
            end;
        end;
    end;

    local u30;

    if DisplayType == "Default" then
        u30 = #u19 > 0;
    else
        u30 = false;
    end;

    local u31 = LootboxChanceSlot:Clone();
    u31.Container.TitleContainer.Value.Text = v13;
    u31.Container.TitleContainer.Value.TextColor3 = Color3_fromRGB_ret;
    u31.Container.DescriptionContainer.Value.Text = v15;
    u31.Container.DescriptionContainer.Value.TextColor3 = Color3_fromRGB_ret2;
    u31.Container.Details.Chance.Text = string.format("%.2f%%", u11 * 100);
    u31.Container.Details.Chance.Visible = DisplayType == "Default";
    u31.Container.Details.Locked.Visible = DisplayType == "Locked";
    u31.Container.Details.Owned.Visible = DisplayType == "Owned";
    u31.Container.Button.Visible = u30;
    u31.Container.Arrow.Visible = u30;
    u31.Parent = p9;
    WeaponStatusHandler:ApplyItemStatusToText(u31.Container.TitleContainer.Value, v14);
    WeaponStatusHandler:ApplyItemStatusToText(u31.Container.DescriptionContainer.Value, v16);
    local v32 = RewardSlot.new(RewardData);
    v32:SetNameText("");
    v32:HideWeaponVisual();
    v32:SetParent(u31.Container.RewardContainer);
    local Children = u31.Container.Children;
    local Layout = Children.Layout;

    local function update() -- Line: 169
        -- upvalues: u31 (copy), Children (copy), Layout (copy)
        u31.Size = UDim2.new(1, 0, 0.075, not Children.Visible and 0 or Layout.AbsoluteContentSize.Y);
    end;

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update);
    Children:GetPropertyChangedSignal("Visible"):Connect(update);
    u31.Size = UDim2.new(1, 0, 0.075, not Children.Visible and 0 or Layout.AbsoluteContentSize.Y);
    local u33 = false;
    local u34 = false;

    local function set_children_visible(p35) -- Line: 181
        -- upvalues: u30 (copy), u33 (ref), u19 (copy), u11 (copy), u8 (copy), u31 (copy), u34 (ref)
        if p35 then
            p35 = u30;
        end;

        if p35 and not u33 then
            u33 = true;
            local v36 = 0;

            for _, v in pairs(u19) do
                v36 = v36 + (v.DisplayType == "Default" and (v.Weight or 0) or 0);
            end;

            for _, v in pairs(u19) do
                u8:_GenerateOddsData(u31.Container.Children, v, v.DisplayType ~= "Default" and 0 or u11 * v.Weight / v36);
            end;
        end;

        u34 = p35;
        u31.Container.Children.Visible = u34;
        u31.Container.Details.Visible = not u34;
        u31.Container.Arrow.Image = u34 and "rbxassetid://17654601337" or "rbxassetid://17654548862";
    end;

    if not p12 then
        u31.Container.Button.MouseButton1Click:Connect(function() -- Line: 207
            -- upvalues: set_children_visible (copy), u34 (ref)
            set_children_visible(not u34);
        end);
        ButtonEffect:Add(u31.Container.Button);
    end;

    set_children_visible(p12);
end;

function u1._Init(u37) -- Line: 217
    -- upvalues: ButtonEffect (copy)
    u37.CloseButton.MouseButton1Click:Connect(function() -- Line: 218
        -- upvalues: u37 (copy)
        u37:CloseRequest();
    end);
    u37.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 222
        -- upvalues: u37 (copy)
        u37.List.CanvasSize = UDim2.new(0, 0, 0, u37.Layout.AbsoluteContentSize.Y);
    end);
    task.defer(u37._GenerateOddsData, u37, u37.Container, {
        DisplayType = "Default",
        RewardData = {
            Name = u37._root_name,
            Weapon = u37._root_weapon
        }
    }, 1, true);
    ButtonEffect:Add(u37.CloseButton);
end;

return u1;