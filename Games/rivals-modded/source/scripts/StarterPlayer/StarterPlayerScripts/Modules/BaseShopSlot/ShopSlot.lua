-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local script_Parent = require(script.Parent);
local ShopSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ShopSlot");
local u1 = setmetatable({}, script_Parent);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: script_Parent (copy), u1 (copy), ShopSlot (copy)
    local v2 = script_Parent.new(...);
    local v3 = setmetatable(v2, u1);
    v3.Frame = ShopSlot:Clone();
    v3.DetailsFrame = v3.Frame.Details;
    v3.RewardSlot = nil;
    v3:_Init();

    return v3;
end;

function u1.OnClick(p4, ...) -- Line: 27
    p4.RewardSlot:OnClick(...);
end;

function u1.Destroy(p5) -- Line: 31
    -- upvalues: script_Parent (copy)
    p5.Frame:Destroy();

    if p5.RewardSlot then
        p5.RewardSlot:Destroy();
    end;

    script_Parent.Destroy(p5);
end;

function u1._Setup(p6) -- Line: 45
    -- upvalues: RewardSlot (copy)
    p6.RewardSlot = RewardSlot.new(p6.FirstRewardData, p6.IsLocked or p6.IsOwned);
    p6.RewardSlot:SetNameText("");
    p6.RewardSlot:SetParent(p6.Frame.Container);
    p6.DetailsFrame.Parent = p6.RewardSlot.CosmeticSlot and p6.RewardSlot.CosmeticSlot.Frame.Button or p6.RewardSlot.Frame.Reward;
end;

function u1._Init(p7) -- Line: 52
    p7:_Setup();
    p7:_SetupBuyButton(p7.DetailsFrame.Buy, p7.DetailsFrame.Owned);
end;

return u1;