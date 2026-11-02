-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(220, 220, 220);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 14
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.DuelInterface = p2;
    v3._blur = Instance.new("BlurEffect");
    v3._colorcorrection = Instance.new("ColorCorrectionEffect");
    v3._last_blur_enabled = nil;
    v3._last_cc_enabled = nil;
    v3._tween_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.Update(p4) -- Line: 34
    -- upvalues: Lighting (copy)
    local v5 = p4.DuelInterface:IsActive() and Lighting or nil;
    p4._blur.Parent = v5;
    p4._colorcorrection.Parent = v5;
end;

function u1.Destroy(p6) -- Line: 41
    p6._blur:Destroy();
    p6._colorcorrection:Destroy();
    p6._tween_hash = p6._tween_hash + 1;
end;

function u1._Tween(u7, p8, p9) -- Line: 51
    -- upvalues: Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), Utility (copy)
    local v10;

    if p8 then
        v10 = not u7.DuelInterface.Voting:IsOpen();
    else
        v10 = p8;
    end;

    if p8 == u7._last_blur_enabled and v10 == u7._last_cc_enabled then
        return;
    end;

    u7._tween_last = p8;
    u7._tween_hash = u7._tween_hash + 1;
    local _tween_hash = u7._tween_hash;
    local Size = u7._blur.Size;
    local Brightness = u7._colorcorrection.Brightness;
    local TintColor = u7._colorcorrection.TintColor;
    local u11 = p8 and 24 or 0;
    local u12 = v10 and -0.1 or 0;
    local u13 = v10 and Color3_fromRGB_ret2 or Color3_fromRGB_ret;
    task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, p9 and 100 or 4, function(p14) -- Line: 71
        -- upvalues: _tween_hash (copy), u7 (copy), Size (copy), u11 (copy), Brightness (copy), u12 (copy), TintColor (copy), u13 (copy)
        if _tween_hash ~= u7._tween_hash then
            return true;
        end;

        local v15 = 1 - (1 - p14 / 100) ^ 3;
        u7._blur.Size = Size + (u11 - Size) * v15;
        u7._colorcorrection.Brightness = Brightness + (u12 - Brightness) * v15;
        u7._colorcorrection.TintColor = TintColor:Lerp(u13, v15);
    end);
end;

function u1._UpdateLighting(p16) -- Line: 84
    p16:_Tween(p16.DuelInterface.Frame.Visible and (p16.DuelInterface.Scoreboard:IsOpen() or (p16.DuelInterface.FinalResults.CurrentPage == "Summary" and true or p16.DuelInterface.Voting:IsOpen())));
end;

function u1._Setup(p17) -- Line: 93
    p17._blur.Name = "DuelInterface";
    p17._colorcorrection.Name = "DuelInterface";
end;

function u1._Init(u18) -- Line: 98
    u18.DuelInterface.Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 99
        -- upvalues: u18 (copy)
        u18:_UpdateLighting();
    end);
    u18.DuelInterface.Scoreboard.VisibilityChanged:Connect(function() -- Line: 103
        -- upvalues: u18 (copy)
        u18:_UpdateLighting();
    end);
    u18.DuelInterface.FinalResults.PageChanged:Connect(function() -- Line: 107
        -- upvalues: u18 (copy)
        u18:_UpdateLighting();
    end);
    u18.DuelInterface.Voting.VisibilityChanged:Connect(function() -- Line: 111
        -- upvalues: u18 (copy)
        u18:_UpdateLighting();
    end);
    u18:_Setup();
    task.defer(u18._Tween, u18, false, true);
end;

return u1;