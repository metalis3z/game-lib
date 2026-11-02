-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules.WeaponStatusHandler);
local DropdownSlot = require(Players.LocalPlayer.PlayerScripts.Modules.DropdownSlot);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local u1 = { "loose_glorycharm", "loose_glorywrap", "loose_gloryfinisher", "loose_gloryemote" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 21
    -- upvalues: u2 (copy)
    local v4 = setmetatable({}, u2);
    v4.Pages = p3;
    v4.Frame = v4.Pages.Frame:WaitForChild("Ranked");
    v4.Container = v4.Frame:WaitForChild("Container");
    v4.LooseFrame = v4.Container:WaitForChild("Loose");
    v4.LooseSlotsFrame = v4.LooseFrame:WaitForChild("Slots");
    v4.WeaponFrame = v4.Container:WaitForChild("Weapon");
    v4.WeaponSlotsFrame = v4.WeaponFrame:WaitForChild("Slots");
    v4.WeaponHeaderFrame = v4.WeaponFrame:WaitForChild("Header");
    v4.WeaponIcon = v4.WeaponHeaderFrame:WaitForChild("Icon");
    v4.WeaponDropdownFrame = v4.WeaponHeaderFrame:WaitForChild("Dropdown");
    v4.WeaponDropdownButton = v4.WeaponDropdownFrame:WaitForChild("Button");
    v4.WeaponDropdownTitle = v4.WeaponDropdownButton:WaitForChild("Title");
    v4._shop_slots = {};
    v4._selected_weapon_name = v4:_GetWeaponsWithGloriousCosmetics()[1];
    v4._dropdown_slot = nil;
    v4._play_glorious_cosmetic_animation = false;
    v4._update_cleanup = {};
    v4:_Init();

    return v4;
end;

function u2.SetSelectedWeaponName(p5, p6) -- Line: 52
    p5._selected_weapon_name = p6;
    p5:_Update();
end;

function u2.Open(p7) -- Line: 57
    p7:_Update();
end;

function u2.Close(p8) -- Line: 61
    p8:_Update();
    p8:_StopDropdown();
end;

function u2.Setup(p9) -- Line: 66
end;

function u2._GetWeaponsWithGloriousCosmetics(p10) -- Line: 74
    -- upvalues: PlayerDataController (copy), ShopLibrary (copy), CosmeticLibrary (copy)
    local UnlockedWeapons = PlayerDataController:GetUnlockedWeapons();
    local v11 = {};

    for _, v in pairs(ShopLibrary.OwnableWeaponsAlphabetized) do
        if UnlockedWeapons[v] and CosmeticLibrary.Cosmetics["Glorious " .. v] then
            table.insert(v11, v);
        end;
    end;

    return v11;
end;

function u2._StopDropdown(p12) -- Line: 87
    if p12._dropdown_slot then
        p12._dropdown_slot:Cancel();
        p12._dropdown_slot = nil;
    end;

    p12.WeaponDropdownButton.Visible = true;
end;

function u2._StartDropdown(u13) -- Line: 96
    -- upvalues: DropdownSlot (copy)
    u13:_StopDropdown();
    u13.WeaponDropdownButton.Visible = false;
    u13._dropdown_slot = DropdownSlot.new(u13.WeaponDropdownFrame, u13:_GetWeaponsWithGloriousCosmetics(), 9);
    u13._dropdown_slot.Selected:Connect(function(p14) -- Line: 103
        -- upvalues: u13 (copy)
        if p14 then
            u13._play_glorious_cosmetic_animation = true;
            u13:SetSelectedWeaponName(p14);
        end;

        u13:_StopDropdown();
    end);
end;

function u2._Update(p15) -- Line: 113
    -- upvalues: WeaponStatusHandler (copy), ItemLibrary (copy), u1 (copy), ShopLibrary (copy), TweenInfo_new_ret (copy), BetterDebris (copy), TweenService (copy)
    for _, v in pairs(p15._shop_slots) do
        v:Destroy();
    end;

    for _, v in pairs(p15._update_cleanup) do
        v:Destroy();
    end;

    p15._shop_slots = {};
    p15._update_cleanup = {};
    WeaponStatusHandler:ClearStatusElements(p15.WeaponDropdownTitle);

    if not p15.Pages.Shop:IsOpen() then
        return;
    end;

    p15.WeaponIcon.Image = ItemLibrary.Items[p15._selected_weapon_name] and (ItemLibrary.Items[p15._selected_weapon_name].Image or "") or "";
    p15.WeaponDropdownTitle.Text = p15._selected_weapon_name;
    WeaponStatusHandler:ApplyItemStatusToText(p15.WeaponDropdownTitle, ItemLibrary.Items[p15._selected_weapon_name] and ItemLibrary.Items[p15._selected_weapon_name].Status);

    for _, v in pairs(u1) do
        local v16 = p15.Pages.Shop:CreateShopSlot(nil, p15.LooseSlotsFrame:WaitForChild(v), v);

        if v16 then
            table.insert(p15._shop_slots, v16);
        end;
    end;

    local v17 = ShopLibrary.NUM_GLORIOUS_COSMETICS[p15._selected_weapon_name] or 0;
    local v18 = true;

    for i = 1, (1 / 0) do
        local v19 = p15.WeaponSlotsFrame:FindFirstChild(i);
        local v20 = p15.WeaponSlotsFrame:FindFirstChild("Arrow" .. i);

        if v19 then
            v19.Visible = false;
        end;

        if v20 then
            v20.Visible = false;
        end;

        if not (v19 or v20) then
            break;
        end;

        local _ = i;
    end;

    for i = 1, v17 do
        local v21 = p15.WeaponSlotsFrame:WaitForChild(i);
        local v22 = p15.Pages.Shop:CreateShopSlot(nil, v21, "loose_gloriouscosmetic_" .. i .. "_" .. p15._selected_weapon_name, not v18);

        if v22 then
            v18 = v22.IsOwned;
        else
            v18 = v22;
        end;

        local v23;

        if v22 then
            v21.Visible = true;
            v23 = i;

            for _, v in pairs({ v22.Frame, p15.WeaponSlotsFrame:FindFirstChild("Arrow" .. i - 1) }) do
                v.Visible = true;

                if p15._play_glorious_cosmetic_animation then
                    local v24 = (v23 - 1) * TweenInfo_new_ret.Time * 0.5;
                    local UIScale = Instance.new("UIScale");
                    UIScale.Scale = 0;
                    UIScale.Parent = v;
                    table.insert(p15._update_cleanup, UIScale);
                    BetterDebris:AddItem(UIScale, v24 + TweenInfo_new_ret.Time);
                    task.delay(v24, function() -- Line: 190
                        -- upvalues: TweenService (ref), UIScale (copy), TweenInfo_new_ret (ref)
                        TweenService:Create(UIScale, TweenInfo_new_ret, {
                            Scale = 1
                        }):Play();
                    end);
                end;
            end;

            table.insert(p15._shop_slots, v22);
        else
            v23 = i;
        end;
    end;
end;

function u2._Init(u25) -- Line: 199
    -- upvalues: PlayerDataController (copy), ButtonEffect (copy)
    u25.WeaponDropdownButton.MouseButton1Click:Connect(function() -- Line: 200
        -- upvalues: u25 (copy)
        u25:_StartDropdown();
    end);
    PlayerDataController:GetDataChangedSignal("CosmeticInventory"):Connect(function() -- Line: 204
        -- upvalues: u25 (copy)
        u25:_Update();
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 208
        -- upvalues: u25 (copy)
        u25:_Update();
    end);
    ButtonEffect:Add(u25.WeaponDropdownButton, nil, {
        ReleaseRatio = 1.025,
        HoverRatio = 1.025
    });
end;

return u2;