-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ShopController = require(Players.LocalPlayer.PlayerScripts.Controllers.ShopController);
local StaticViewModel = require(Players.LocalPlayer.PlayerScripts.Modules.StaticModel.StaticViewModel);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Part = p2;
    v3.HologramViewModel = nil;
    v3.SkinViewModel = nil;
    v3._connections = {};
    v3._index = 0;
    v3._next_increment = 0;
    v3._last_change = 0;
    v3:_Init();

    return v3;
end;

function u1.Set(p4, p5) -- Line: 34
    -- upvalues: StaticViewModel (copy)
    if p4.HologramViewModel then
        p4.HologramViewModel:Destroy();
        p4.HologramViewModel = nil;
    end;

    if p4.SkinViewModel then
        p4.SkinViewModel:Destroy();
        p4.SkinViewModel = nil;
    end;

    if not p5 then
        return;
    end;

    p4._last_change = tick();
    p4.HologramViewModel = StaticViewModel.new(p5);
    p4.HologramViewModel:SetWrap({
        Name = "Hologram"
    });
    p4.HologramViewModel:ScaleTo(4);
    p4.SkinViewModel = StaticViewModel.new(p5);
    p4.SkinViewModel:ScaleTo(4);
    p4:Update(0);
end;

function u1.Increment(p6, p7) -- Line: 61
    local v8 = p6:_GetSkinNames();

    if #v8 == 0 then
        p6:Set(nil);

        return;
    end;

    local v9;

    if p7 then
        v9 = (p6._index - 1) % #v8 + 1;
    else
        v9 = p6._index % #v8 + 1;
    end;

    p6._index = v9;
    p6:Set(v8[p6._index]);
end;

function u1.Update(p10, p11) -- Line: 72
    if tick() > p10._next_increment then
        p10._next_increment = tick() + 10;
        p10:Increment();
    end;

    local v12 = tick() - p10._last_change;
    local v13;

    if v12 > 1.5 then
        v13 = false;
    else
        v13 = math.floor(10 * v12 - v12 ^ 3) % 2 == 1;
    end;

    if p10.HologramViewModel then
        p10.HologramViewModel:PivotTo(p10.Part.CFrame);
        local v14;

        if v13 then
            v14 = p10.Part;
        else
            v14 = nil;
        end;

        p10.HologramViewModel:SetParent(v14);
    end;

    if p10.SkinViewModel then
        p10.SkinViewModel:PivotTo(p10.Part.CFrame);
        local v15;

        if v13 then
            v15 = nil;
        else
            v15 = p10.Part;
        end;

        p10.SkinViewModel:SetParent(v15);
    end;
end;

function u1.Destroy(p16) -- Line: 92
    for _, v in pairs(p16._connections) do
        v:Disconnect();
    end;

    p16._connections = {};
    p16:Set(nil);
end;

function u1._GetSkinNames(p17) -- Line: 106
    -- upvalues: ShopController (copy), CosmeticLibrary (copy)
    local v18 = {};

    for _, v in pairs(ShopController:GetDailyShop()) do
        local v19 = v.Rewards[1];

        if CosmeticLibrary.Cosmetics[v19.Name].Type == "Skin" then
            table.insert(v18, v19.Name);
        end;
    end;

    return v18;
end;

function u1._Init(u20) -- Line: 121
    -- upvalues: ShopController (copy)
    table.insert(u20._connections, ShopController.DailyShopRefreshed:Connect(function() -- Line: 122
        -- upvalues: u20 (copy)
        u20:Increment(true);
    end));
end;

return u1;