-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Custom = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Custom);
local u1 = {
    Utility = "rbxassetid://134135466396929",
    Melee = "rbxassetid://78813062969940",
    Secondary = "rbxassetid://136044794858753",
    Primary = "rbxassetid://77716075365102"
};
local u2 = setmetatable({}, Custom);
u2.__index = u2;

function u2.new(...) -- Line: 20
    -- upvalues: Custom (copy), u2 (copy)
    local v3 = Custom.new(...);
    local v4 = setmetatable(v3, u2);
    v4._use_cooldown = 0;
    v4:_Init();

    return v4;
end;

function u2.GetAutoShootReactionTime(p5) -- Line: 34
    return nil;
end;

function u2.CanQuickAttack(p6) -- Line: 38
    local v7;

    if tick() > p6._use_cooldown then
        v7 = not p6:IsEquipping();
    else
        v7 = false;
    end;

    return v7;
end;

function u2.StartShooting(u8, p9) -- Line: 42
    if not (p9 or tick() >= u8._use_cooldown and not u8:IsEquipping()) then
        return false;
    end;

    u8._use_cooldown = tick() + u8.Info.RollDuration + u8.Info.Cooldown;
    u8.ViewModel:PlayAnimation("Use");
    u8:CooldownEffect("rbxassetid://132973552546079", u8.Info.RollDuration, "Rolling", true);
    task.delay(u8.Info.RollDuration, function() -- Line: 51
        -- upvalues: u8 (copy)
        if u8._destroyed then
            return;
        end;

        u8:CooldownEffect("rbxassetid://17156089790", u8.Info.Cooldown, "Cooldown");
    end);

    return true, "StartShooting";
end;

function u2.ReplicateFromServer(p10, p11, ...) -- Line: 62
    -- upvalues: u1 (copy), ItemLibrary (copy), Custom (copy)
    if p11 ~= "RollResult" then
        Custom.ReplicateFromServer(p10, p11, ...);

        return;
    end;

    if not p10:IsRendered() then
        return;
    end;

    local v12, v13 = ...;
    local v14 = v13 and "rbxassetid://136831234910767" or (u1[ItemLibrary.Items[v12].Class] or "rbxassetid://134135466396929");

    if p10.ClientFighter.FighterInterface then
        p10.ClientFighter.FighterInterface:HotbarRollEffect(p10);
    end;

    p10:CreateSound("rbxassetid://95740132815107", 1.5, 1 + 0.1 * math.random(), true, 0.4):SetAttribute("DontClearSound", true);
    wait(0.4);
    p10:CreateSound(v14, 1.5, 1 + 0.2 * math.random(), true, 5):SetAttribute("DontClearSound", true);
end;

function u2._Init(p15) -- Line: 89
end;

return u2;