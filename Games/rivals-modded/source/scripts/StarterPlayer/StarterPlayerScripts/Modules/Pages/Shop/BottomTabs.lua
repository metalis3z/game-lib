-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
require(Players.LocalPlayer.PlayerScripts.Controllers.ShopController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 9
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Shop = p2;
    v3.Frame = v3.Shop.List:WaitForChild("BottomTabs");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.GiftingButton = v3.Container:WaitForChild("Gifting");
    v3.RewardsButton = v3.Container:WaitForChild("Rewards");
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 27
end;

function u1.Close(p5) -- Line: 31
end;

function u1.Setup(p6) -- Line: 35
end;

function u1._Init(u7) -- Line: 43
    -- upvalues: ButtonEffect (copy)
    u7.GiftingButton.MouseButton1Click:Connect(function() -- Line: 44
        -- upvalues: u7 (copy)
        u7.Shop:SetPage("Gifting");
    end);
    u7.RewardsButton.MouseButton1Click:Connect(function() -- Line: 48
        -- upvalues: u7 (copy)
        u7.Shop:SetPage("Rewards");
    end);
    ButtonEffect:Add(u7.GiftingButton);
    ButtonEffect:Add(u7.RewardsButton);
end;

return u1;