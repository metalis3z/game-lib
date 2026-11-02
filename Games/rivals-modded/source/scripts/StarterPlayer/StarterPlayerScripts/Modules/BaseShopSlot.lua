-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local CurrencyLibrary = require(ReplicatedStorage.Modules.CurrencyLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 13
    -- upvalues: u1 (copy), CosmeticLibrary (copy), PlayerDataController (copy)
    local v4 = setmetatable({}, u1);
    v4.ShopEntry = p2;
    v4.FirstRewardData = v4.ShopEntry.Rewards[1];
    v4.IsOwned = CosmeticLibrary:OwnsCosmetic(PlayerDataController:Get("CosmeticInventory"), v4.FirstRewardData.Name, v4.FirstRewardData.Weapon);
    local Weapon = v4.FirstRewardData.Weapon;

    if Weapon then
        if v4.FirstRewardData.Weapon == "IsRandom" or v4.FirstRewardData.Weapon == "IsUniversal" then
            Weapon = false;
        else
            Weapon = not PlayerDataController:GetWeaponData(v4.FirstRewardData.Weapon);
        end;
    end;

    v4.IsLockedRaw = Weapon;
    v4.IsLocked = p3 or false;
    v4:_Init();

    return v4;
end;

function u1.OnClick(p5, p6) -- Line: 31
    assert(false, "Not implemented");
end;

function u1.Destroy(p7) -- Line: 35
end;

function u1._SetupBuyButton(p8, p9, p10) -- Line: 43
    -- upvalues: CosmeticLibrary (copy), CurrencyLibrary (copy), Utility (copy), MonetizationController (copy)
    local v11 = CosmeticLibrary.Cosmetics[p8.FirstRewardData.Name];
    local v12 = CurrencyLibrary.Info[p8.ShopEntry.MainCurrency];
    local v13 = p8.ShopEntry.Prices[p8.ShopEntry.MainCurrency];

    if p10 then
        p10.Visible = p8.IsOwned;
    end;

    p9.Visible = not p8.IsOwned;
    p9.Limited.Visible = false;
    p9.Locked.Visible = not p9.Limited.Visible and p8.IsLocked;
    p9.Price.Visible = not p9.Limited.Visible and (not p8.IsLocked and p8.ShopEntry.MainCurrency) and v13 > 0;
    p9.Free.Visible = not p9.Limited.Visible and (not p8.IsLocked and p8.ShopEntry.MainCurrency) and v13 == 0;
    p9.Robux.Visible = not (p9.Limited.Visible or p8.IsLocked) and p8.ShopEntry.ProductID;
    p9.Size = v11 and UDim2.new(0.5, 0, 0.25, 0) or UDim2.new(0.625, 0, 0.3125, 0);

    if p9.Price.Visible then
        p9.Price.Value.Text = Utility:PrettyNumber(v13);
        p9.Price.Value.Icon.Image = v12.ImageFlatOutline;
        p9.Price.Value.Icon.ImageLabel.Image = v12.ImageFlat;
        p9.Price.Background.ImageColor3 = v12.Color;
        p9.Price.Background.UIGradient.Color = v12.ColorGradient;
    end;

    if p8.ShopEntry.ProductID then
        MonetizationController:SetRobuxText(p9.Robux.Value, p8.ShopEntry.ProductID, Enum.InfoType.Product);
    end;

    for _, v in pairs({ "Locked", "Price", "Free", "Robux", "Limited" }) do
        if not p9[v].Visible then
            p9[v]:Destroy();
        end;
    end;

    if p9:FindFirstChild("Price") then
        local Value = p9.Price.Value;
        local Icon = Value.Icon;

        local function update() -- Line: 82
            -- upvalues: Icon (copy), Value (copy)
            Icon.Position = UDim2.new(0.5, Value.TextBounds.X / 2, 0.5, 0);
        end;

        Value:GetPropertyChangedSignal("TextBounds"):Connect(update);
        p9.AncestryChanged:Connect(update);
        Icon.Position = UDim2.new(0.5, Value.TextBounds.X / 2, 0.5, 0);
    end;
end;

function u1._Init(p14) -- Line: 92
end;

return u1;