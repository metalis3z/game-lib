-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local StatisticsLibrary = require(ReplicatedStorage.Modules.StatisticsLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules.WeaponStatusHandler);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local EquipmentDetailsDescription = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EquipmentDetailsDescription");
local u1 = { "Lookin\' good!" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 19
    -- upvalues: u2 (copy)
    local v4 = setmetatable({}, u2);
    v4.Right = p3;
    v4.Frame = v4.Right.Container:WaitForChild("Details");
    v4.Container = v4.Frame:WaitForChild("Container");
    v4.Title = v4.Container:WaitForChild("Title");
    v4.Icon = v4.Container:WaitForChild("Icon");
    v4.Headshot = v4.Container:WaitForChild("Headshot");
    v4.DescriptionsFrame = v4.Container:WaitForChild("Descriptions");
    v4.DescriptionsLayout = v4.DescriptionsFrame:WaitForChild("Layout");
    v4.FavoritedFrame = v4.Container:WaitForChild("Favorited");
    v4.FavoritedButton = v4.FavoritedFrame:WaitForChild("Button");
    v4.FavoritedFilled = v4.FavoritedButton:WaitForChild("Filled");
    v4.FavoritedEmpty = v4.FavoritedButton:WaitForChild("Empty");
    v4._cleanup = {};
    v4:_Init();

    return v4;
end;

function u2.OnStateChanged(p5) -- Line: 46
    p5:_Generate();
end;

function u2._Generate(p6) -- Line: 54
    -- upvalues: WeaponStatusHandler (copy), ShopLibrary (copy), PlayerDataController (copy), CONSTANTS (copy), Players (copy), ComplianceController (copy), u1 (copy), ItemLibrary (copy), StatisticsLibrary (copy)
    for _, v in pairs(p6._cleanup) do
        WeaponStatusHandler:ClearStatusElements(v);
        v:Destroy();
    end;

    p6._cleanup = {};
    WeaponStatusHandler:ClearStatusElements(p6.Title);
    local v7 = p6.Right.Interface.Equipment:IsCareerPageOpen();
    local SelectedWeapon = p6.Right.Interface.Equipment:GetSelectedWeapon();
    local _, _, v8, _ = ShopLibrary:GetWeaponKeyPriceInfo(SelectedWeapon, PlayerDataController:Get("UnlockTokens"), PlayerDataController:Get("FreeWeaponUnlockCheck"));
    local TimeUntilWeaponRelease = ShopLibrary:GetTimeUntilWeaponRelease(SelectedWeapon);
    local v9 = not v8 and TimeUntilWeaponRelease > 0;
    local v10;

    if v7 then
        v10 = v7;
    elseif SelectedWeapon then
        v10 = not v9;
    else
        v10 = SelectedWeapon;
    end;

    p6.Frame.Visible = v10;

    if not v10 then
        return;
    end;

    local v11;

    if SelectedWeapon then
        v11 = PlayerDataController:GetWeaponData(SelectedWeapon) ~= nil;
    else
        v11 = SelectedWeapon;
    end;

    local v12;

    if SelectedWeapon then
        v12 = PlayerDataController:GetFavoritedWeapons()[SelectedWeapon];
    else
        v12 = SelectedWeapon;
    end;

    p6.FavoritedFrame.Visible = v11;
    p6.FavoritedFilled.Visible = v12;
    p6.FavoritedEmpty.Visible = not v12;

    if not v7 then
        if SelectedWeapon then
            local v13 = ItemLibrary.Items[SelectedWeapon];
            local v14 = StatisticsLibrary.Items[SelectedWeapon];
            local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);
            p6.Headshot.Image = "";
            p6.Icon.Image = WeaponData and ItemLibrary:GetViewModelImageFromWeaponData(WeaponData) or "";
            p6.Title.Text = SelectedWeapon;
            p6.Title.AutoLocalize = true;
            WeaponStatusHandler:ApplyItemStatusToText(p6.Title, v13.Status);
            WeaponStatusHandler:ApplyItemStatusToText(p6:_CreateDescription("• " .. v13.Status .. " " .. v13.Class, 1), v13.Status);

            for _, v in pairs(v14 and v14.Descriptions or {}) do
                local table_unpack_ret, v15 = table.unpack(v);
                p6:_CreateDescription("• " .. v15, table_unpack_ret);
            end;
        end;

        return;
    end;

    p6.Headshot.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, Players.LocalPlayer.UserId);
    p6.Icon.Image = "";
    p6.Title.AutoLocalize = false;
    p6.Title.Text = ComplianceController:GetName(Players.LocalPlayer);

    if Players.LocalPlayer.Name ~= Players.LocalPlayer.DisplayName then
        local v16 = "• Also known as @" .. Players.LocalPlayer.Name;
        p6:_CreateDescription(v16, #v16 > 34 and 2 or 1);
    end;

    p6:_CreateDescription("• " .. u1[math.random(#u1)], 1);
end;

function u2._CreateDescription(p17, p18, p19) -- Line: 120
    -- upvalues: EquipmentDetailsDescription (copy)
    local v20 = EquipmentDetailsDescription:Clone();
    v20.Text = p18;
    v20.Size = UDim2.new(0.75, 0, 0.05 * p19, 0);
    v20.LayoutOrder = #p17._cleanup;
    v20.Parent = p17.DescriptionsFrame;
    table.insert(p17._cleanup, v20);

    return v20;
end;

function u2._Update(p21) -- Line: 131
    p21.Frame.Size = UDim2.new(1, 0, 0, (p21.DescriptionsFrame.AbsolutePosition.Y - p21.Frame.AbsolutePosition.Y) * 1.25 + p21.DescriptionsLayout.AbsoluteContentSize.Y);
end;

function u2._Init(u22) -- Line: 135
    -- upvalues: PlayerDataController (copy), ButtonEffect (copy)
    u22.DescriptionsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 136
        -- upvalues: u22 (copy)
        u22:_Update();
    end);
    u22.FavoritedButton.MouseButton1Click:Connect(function() -- Line: 140
        -- upvalues: u22 (copy)
        u22.Right.Interface.Equipment:FavoriteWeapon();
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 144
        -- upvalues: u22 (copy)
        u22:_Generate();
    end);
    u22:_Update();
    ButtonEffect:Add(u22.FavoritedButton);
end;

return u2;