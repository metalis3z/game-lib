-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Color3_fromRGB_ret = Color3.fromRGB(200, 200, 200);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 15
    -- upvalues: u1 (copy), Signal (copy)
    local v5 = setmetatable({}, u1);
    v5.Clicked = Signal.new();
    v5.Frame = p2;
    v5._destroyed = false;
    v5._stroke_thickness = p3 or 4;
    v5._always_bright = p4 or false;
    v5._hover_hash = 0;
    v5._tween_alpha = 0;
    v5:_Init();

    return v5;
end;

function u1.Set(p6, p7) -- Line: 37
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    if p6._destroyed then
        return;
    end;

    local v8 = p6._always_bright and 1 or p7;
    p6.Frame.Button.Thumbnail.ImageTransparency = 0.375 - 0.375 * v8;
    p6.Frame.Button.Thumbnail.ImageColor3 = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, v8);
    p6.Frame.Button.Stroke.Size = UDim2.new(1, 2 - p6._stroke_thickness * 2 * p7, 1, 2 - p6._stroke_thickness * 2 * p7);
    p6.Frame.Button.Stroke.UIStroke.Thickness = p6._stroke_thickness * p7;
end;

function u1.Tween(u9, p10) -- Line: 50
    -- upvalues: Utility (copy)
    if u9._destroyed then
        return;
    end;

    u9._hover_hash = u9._hover_hash + 1;
    local _hover_hash = u9._hover_hash;
    Utility:RenderstepForLoop(u9._tween_alpha, p10, 0.15 * (p10 < u9._tween_alpha and -1 or 1), function(p11) -- Line: 58
        -- upvalues: _hover_hash (copy), u9 (copy)
        if _hover_hash ~= u9._hover_hash or u9._destroyed then
            return true;
        end;

        u9._tween_alpha = p11;
        u9:Set(1 - (1 - u9._tween_alpha) ^ 3);
    end);
end;

function u1.Destroy(p12) -- Line: 68
    p12._destroyed = true;
    p12.Clicked:Destroy();
    p12.Frame:Destroy();
end;

function u1._Init(u13) -- Line: 78
    -- upvalues: ButtonEffect (copy)
    u13.Frame.Button.MouseLeave:Connect(function() -- Line: 79
        -- upvalues: u13 (copy)
        u13:Tween(0);
    end);
    u13.Frame.Button.SelectionLost:Connect(function() -- Line: 83
        -- upvalues: u13 (copy)
        u13:Tween(0);
    end);
    u13.Frame.Button.MouseEnter:Connect(function() -- Line: 87
        -- upvalues: u13 (copy)
        u13:Tween(1);
    end);
    u13.Frame.Button.SelectionGained:Connect(function() -- Line: 91
        -- upvalues: u13 (copy)
        u13:Tween(1);
    end);
    u13.Frame.Button.MouseButton1Click:Connect(function() -- Line: 95
        -- upvalues: u13 (copy)
        u13.Clicked:Fire();
    end);
    u13:Set(0);
    ButtonEffect:Add(u13.Frame.Button, nil, {
        ReleaseRatio = 0.975,
        HoverRatio = 0.975
    });
end;

return u1;