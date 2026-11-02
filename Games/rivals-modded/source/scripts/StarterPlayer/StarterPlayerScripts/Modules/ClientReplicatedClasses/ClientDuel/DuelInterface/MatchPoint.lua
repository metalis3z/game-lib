-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 8
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("Top"):WaitForChild("MatchPoint");
    v3.Background = v3.Frame:WaitForChild("Background");
    v3.Title = v3.Frame:WaitForChild("Title");
    v3._destroyed = false;
    v3._match_point_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.Play(u4, p5) -- Line: 28
    -- upvalues: Utility (copy)
    u4._match_point_hash = u4._match_point_hash + 1;

    if u4.DuelInterface.ClientDuel:Get("MatchPointVisualDisabled") then
        return;
    end;

    local _match_point_hash = u4._match_point_hash;
    u4.DuelInterface:CreateSound(p5 and "rbxassetid://17467242617" or "rbxassetid://17026600996", p5 and 1.5 or 1, 1, script, true, 15);
    u4.DuelInterface.Timer:SetVisible(false);
    u4.DuelInterface.Scores:SetVisible(false);
    u4.Frame.Visible = true;
    u4.Frame.GroupTransparency = 0;
    u4.Frame.Position = UDim2.new(0.5, 0, 0.02, 5);
    u4.Background.Size = p5 and UDim2.new(0.66, 0, 0.5, 0) or UDim2.new(0.6, 0, 0.5, 0);
    u4.Title.Text = p5 and "SUDDEN DEATH" or "MATCH POINT";
    u4:_UpdateTextBounds();
    u4.Frame:TweenPosition(UDim2.new(0.5, 0, 0.0425, 10), "Out", "Quint", 2, true, function() -- Line: 49
        -- upvalues: Utility (ref), _match_point_hash (copy), u4 (copy)
        Utility:RenderstepForLoop(0, 100, 2, function(p6) -- Line: 50
            -- upvalues: _match_point_hash (ref), u4 (ref)
            if _match_point_hash ~= u4._match_point_hash then
                return true;
            end;

            u4.Frame.GroupTransparency = 1 - (1 - p6 / 100) ^ 4;
        end);

        if _match_point_hash ~= u4._match_point_hash then
            return;
        end;

        u4.DuelInterface.Timer:SetVisible(true);
        u4.DuelInterface.Scores:SetVisible(true);
        u4.Frame.Visible = false;
    end);
end;

function u1.Destroy(p7) -- Line: 68
    p7._destroyed = true;
    p7._match_point_hash = p7._match_point_hash + 1;
end;

function u1._UpdateTextBounds(p8) -- Line: 77
    p8.Background.Size = UDim2.new(0.1, p8.Title.TextBounds.X, 0.5, 0);
end;

function u1._Init(u9) -- Line: 81
    u9.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 82
        -- upvalues: u9 (copy)
        u9:_UpdateTextBounds();
    end);
    u9:_UpdateTextBounds();
end;

return u1;