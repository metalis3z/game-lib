-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local u1 = { "rbxassetid://121789380697435", "rbxassetid://131598663318488" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 14
    -- upvalues: u2 (copy)
    local v4 = setmetatable({}, u2);
    v4.ClientDueler = p3;
    v4._connections = {};
    v4._honcho_highlight = nil;
    v4._bodyguard_highlight = nil;
    v4._hide_honcho_highlight_until = 0;
    v4._aura_sound = nil;
    v4:_Init();

    return v4;
end;

function u2.Destroy(p5) -- Line: 34
    for _, v in pairs(p5._connections) do
        v:Disconnect();
    end;

    if p5._honcho_highlight then
        p5._honcho_highlight:Destroy();
        p5._honcho_highlight = nil;
    end;

    if p5._bodyguard_highlight then
        p5._bodyguard_highlight:Destroy();
        p5._bodyguard_highlight = nil;
    end;

    if p5._aura_sound then
        p5._aura_sound:Destroy();
        p5._aura_sound = nil;
    end;
end;

function u2._UpdateBodyguardHighlight(p6) -- Line: 59
    if p6._bodyguard_highlight then
        p6._bodyguard_highlight:Destroy();
        p6._bodyguard_highlight = nil;
    end;

    if not p6.ClientDueler.ClientDuel:Get("IsSpectating") then
        return;
    end;

    if p6.ClientDueler:Get("IsHeadHoncho") ~= false or not (p6.ClientDueler.ClientFighter and (not p6.ClientDueler.ClientFighter:Get("IsSpectating") and p6.ClientDueler.ClientFighter.Entity)) then
        return;
    end;

    if not (p6.ClientDueler.ClientDuel.LocalDueler and (p6.ClientDueler.ClientDuel.LocalDueler:Get("IsHeadHoncho") == true and p6.ClientDueler.ClientDuel.LocalDueler:Get("TeamID") ~= p6.ClientDueler:Get("TeamID"))) then
        return;
    end;

    local Model = p6.ClientDueler.ClientFighter.Entity.Model;
    p6._bodyguard_highlight = Instance.new("Highlight");
    p6._bodyguard_highlight.FillTransparency = 1;
    p6._bodyguard_highlight.OutlineColor = Color3.fromRGB(255, 50, 50);
    p6._bodyguard_highlight.OutlineTransparency = 0.5;
    p6._bodyguard_highlight.Adornee = Model;
    p6._bodyguard_highlight.Parent = Model;
end;

function u2._UpdateHonchoHighlight(p7) -- Line: 87
    -- upvalues: u1 (copy), DuelLibrary (copy)
    if p7._honcho_highlight then
        p7._honcho_highlight:Destroy();
        p7._honcho_highlight = nil;
    end;

    if p7._aura_sound then
        p7._aura_sound:Destroy();
        p7._aura_sound = nil;
    end;

    if not p7.ClientDueler.ClientDuel:Get("IsSpectating") then
        return;
    end;

    if p7.ClientDueler:Get("IsHeadHoncho") ~= true or not (p7.ClientDueler.ClientFighter and p7.ClientDueler.ClientFighter.Entity) then
        return;
    end;

    p7.ClientDueler.ClientFighter:Get("IsSpectating");

    if not u1[DuelLibrary.TeamsByID[p7.ClientDueler:Get("TeamID")].TeamIndex] then
        local _ = u1[1];
    end;

    if p7.ClientDueler.ClientFighter:Get("IsSpectating") then
        return;
    end;

    local TeamColor = DuelLibrary:GetTeamColor(p7.ClientDueler:Get("TeamID"));
    local Model = p7.ClientDueler.ClientFighter.Entity.Model;
    p7._honcho_highlight = Instance.new("Highlight");
    p7._honcho_highlight.DepthMode = tick() < p7._hide_honcho_highlight_until and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop;
    p7._honcho_highlight.FillColor = TeamColor;
    p7._honcho_highlight.OutlineColor = TeamColor;
    p7._honcho_highlight.Adornee = Model;
    p7._honcho_highlight.Parent = Model;
end;

function u2._SetupDamageTakenLogic(u8) -- Line: 128
    if not u8.ClientDueler.ClientFighter then
        return;
    end;

    local _connections = u8._connections;
    local DataChangedSignal = u8.ClientDueler.ClientFighter:GetDataChangedSignal("IsSpectating");
    table.insert(_connections, DataChangedSignal:Connect(function(...) -- Line: 133
        -- upvalues: u8 (copy)
        u8:_UpdateHonchoHighlight();
        u8:_UpdateBodyguardHighlight();
    end));
    local u9 = nil;
    table.insert(u8._connections, u8.ClientDueler.ClientFighter.HealthChanged:Connect(function(...) -- Line: 140
        -- upvalues: u8 (copy), u9 (ref)
        if u9 and u8.ClientDueler.ClientFighter:GetHealth() < u9 then
            u8._hide_honcho_highlight_until = tick() + 5;
            u8:_UpdateHonchoHighlight();
            task.delay(5, u8._UpdateHonchoHighlight, u8);
        end;

        u9 = u8.ClientDueler.ClientFighter:GetHealth();
    end));
end;

function u2._Init(u10) -- Line: 153
    local _connections = u10._connections;
    local DataChangedSignal = u10.ClientDueler.ClientDuel:GetDataChangedSignal("IsSpectating");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 154
        -- upvalues: u10 (copy)
        u10:_UpdateHonchoHighlight();
        u10:_UpdateBodyguardHighlight();
    end));
    u10.ClientDueler:GetDataChangedSignal("IsHeadHoncho"):Connect(function() -- Line: 159
        -- upvalues: u10 (copy)
        u10:_UpdateHonchoHighlight();
        u10:_UpdateBodyguardHighlight();
    end);
    u10.ClientDueler:GetDataChangedSignal("TeamID"):Connect(function() -- Line: 164
        -- upvalues: u10 (copy)
        u10:_UpdateHonchoHighlight();
        u10:_UpdateBodyguardHighlight();
    end);
    u10.ClientDueler.EntityAdded:Connect(function() -- Line: 169
        -- upvalues: u10 (copy)
        u10:_UpdateHonchoHighlight();
        u10:_UpdateBodyguardHighlight();
    end);
    u10:_SetupDamageTakenLogic();
    u10:_UpdateHonchoHighlight();
    u10:_UpdateBodyguardHighlight();
end;

return u2;