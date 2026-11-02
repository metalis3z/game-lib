-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 11
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 23
    -- upvalues: CollectionService (copy)
    local v6 = tick() * 0.25;
    local v7 = math.sin(v6) ^ 30 * 1;
    local v8 = tick() * 0.1 % 6.283185307179586;
    Vector3.new(0, v7, 0);
    CFrame.Angles(0, v8, 0);
    local v9 = tick() * 0.75;
    local v10 = math.sin(v9) ^ 30 * 1;
    local v11 = tick() * -0.2 % 6.283185307179586;
    local Vector3_new_ret = Vector3.new(0, v10, 0);
    local CFrame_Angles_ret = CFrame.Angles(0, v11, 0);

    for _, v in pairs(CollectionService:GetTagged("LobbyFloatingDisplay")) do
        if v:IsDescendantOf(workspace) then
            local v12 = p4:_GetOriginalPivot(v);
            local v13;

            if v:GetAttribute("NoSpin") then
                v13 = CFrame.identity or CFrame_Angles_ret;
            else
                v13 = CFrame_Angles_ret;
            end;

            v:PivotTo(v12 * v13 + Vector3_new_ret);
        end;
    end;

    for _, v in pairs(CollectionService:GetTagged("LobbyRing")) do
        local v14 = v:GetAttribute("Multiplier") or 1;
        local v15 = v:GetAttribute("IsGlobalSpace") or false;
        local v16 = p4:_GetOriginalPivot(v);
        local CFrame_Angles_ret2 = CFrame.Angles(0, tick() * 0.1 * v14 % 6.283185307179586, 0);

        if v15 then
            v:PivotTo(CFrame.new(v16.Position) * CFrame_Angles_ret2 * v16.Rotation);
        else
            v:PivotTo(v16 * CFrame_Angles_ret2);
        end;
    end;

    for _, v in pairs(CollectionService:GetTagged("LobbyHologramGift")) do
        v:PivotTo(p4:_GetOriginalPivot(v) * CFrame_Angles_ret + Vector3_new_ret);
    end;

    for _, v in pairs(CollectionService:GetTagged("LobbyHologramMobile")) do
        v.Earth:PivotTo(p4:_GetOriginalPivot(v.Earth) * CFrame.Angles(0, tick() * 0.35 % 6.283185307179586, 0));
        local Phone = v.Phone;
        local v17 = p4:_GetOriginalPivot(v.Phone);
        local v18 = tick() * 0.75;
        local v19 = math.sin(v18) * 0.75;
        Phone:PivotTo(v17 + Vector3.new(0, v19, 0));
        local Tablet = v.Tablet;
        local v20 = p4:_GetOriginalPivot(v.Tablet);
        local v21 = tick() * 0.375;
        local math_cos_ret = math.cos(v21);
        Tablet:PivotTo(v20 + Vector3.new(0, math_cos_ret, 0));
    end;
end;

function u1._UpdateSeasonTexts(p22) -- Line: 75
    -- upvalues: CollectionService (copy), SeasonLibrary (copy)
    for _, v in pairs(CollectionService:GetTagged("SeasonNameDisplay")) do
        v.Text = string.upper(SeasonLibrary.CurrentSeason.Name);
    end;

    for _, v in pairs(CollectionService:GetTagged("SeasonVersionDisplay")) do
        v.Text = "SEASON " .. SeasonLibrary.CurrentSeason.Version;
    end;
end;

function u1._Init(u23) -- Line: 85
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("SeasonNameDisplay"):Connect(function() -- Line: 86
        -- upvalues: u23 (copy)
        u23:_UpdateSeasonTexts();
    end);
    CollectionService:GetInstanceAddedSignal("SeasonVersionDisplay"):Connect(function() -- Line: 90
        -- upvalues: u23 (copy)
        u23:_UpdateSeasonTexts();
    end);
    u23:_UpdateSeasonTexts();
end;

return u1._new();