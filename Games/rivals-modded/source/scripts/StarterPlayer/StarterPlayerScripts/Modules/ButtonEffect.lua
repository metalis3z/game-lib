-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("HapticService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 16
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:_Init();

    return v2;
end;

function u1.ClickSound(p3) -- Line: 28
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://177266782", 0.5, 1, script, true, 4);
end;

function u1.Add(u4, p5, u6, p7) -- Line: 33
    -- upvalues: Players (copy)
    local v8;

    if typeof(p5) == "Instance" then
        v8 = p5:IsA("ImageButton") or (p5:IsA("TextButton") or p5:IsA("ClickDetector"));
    else
        v8 = false;
    end;

    local v9 = "Argument 1 invalid, expected an ImageButton or TextButton or ClickDetector, got " .. tostring(p5);
    assert(v8, v9);
    local v10 = not u6 or typeof(u6) == "boolean";
    local v11 = "Argument 2 invalid, expected a boolean or nil, got " .. tostring(u6);
    assert(v10, v11);
    local v12 = not p7 or typeof(p7) == "table";
    local v13 = "Argument 3 invalid, expected a table or nil, got " .. tostring(p7);
    assert(v12, v13);
    local u14 = p7 and table.clone(p7) or {};
    u14.Speed = u14.Speed or 1;
    u14.PressRatio = u14.PressRatio or 0.875;
    u14.HoverRatio = u14.HoverRatio or 1.125;
    u14.ReleaseRatio = u14.ReleaseRatio or 1.125;
    u14.TargetElement = u14.TargetElement or p5;
    u14.OnRelease = u14.OnRelease or nil;
    u14.OnHover = u14.OnHover or nil;
    u14.DontReposition = u14.DontReposition or nil;
    local TargetElement = u14.TargetElement;

    if not p5:IsA("ClickDetector") then
        local u15 = nil;
        local u16 = nil;
        local u17 = nil;
        local u18 = nil;

        local function update_original_size(p19) -- Line: 63
            -- upvalues: u15 (ref), u16 (ref), u14 (copy), u17 (ref), u18 (ref)
            u15 = p19;
            u16 = typeof(u14.PressRatio) == "UDim2" and u15 + u14.PressRatio or UDim2.new(u15.X.Scale * u14.PressRatio, u15.X.Offset * u14.PressRatio, u15.Y.Scale * u14.PressRatio, u15.Y.Offset * u14.PressRatio);
            u17 = typeof(u14.HoverRatio) == "UDim2" and u15 + u14.HoverRatio or UDim2.new(u15.X.Scale * u14.HoverRatio, u15.X.Offset * u14.HoverRatio, u15.Y.Scale * u14.HoverRatio, u15.Y.Offset * u14.HoverRatio);
            u18 = typeof(u14.ReleaseRatio) == "UDim2" and u15 + u14.ReleaseRatio or UDim2.new(u15.X.Scale * u14.ReleaseRatio, u15.X.Offset * u14.ReleaseRatio, u15.Y.Scale * u14.ReleaseRatio, u15.Y.Offset * u14.ReleaseRatio);
        end;

        update_original_size(TargetElement.Size);
        local u20 = false;

        local function release() -- Line: 92
            -- upvalues: u20 (ref), u6 (copy), TargetElement (copy), Players (ref), u18 (ref), u15 (ref), u14 (copy)
            u20 = false;

            if not u6 then
                if TargetElement:IsDescendantOf(workspace) or TargetElement:IsDescendantOf(Players) then
                    TargetElement.Size = u18;
                    TargetElement:TweenSize(u15, "Out", "Back", 0.25, true);
                else
                    TargetElement.Size = u15;
                end;
            end;

            if u14.OnRelease then
                u14.OnRelease();
            end;
        end;

        p5.MouseButton1Up:Connect(release);
        p5.MouseLeave:Connect(release);
        p5.SelectionLost:Connect(release);

        local function hover() -- Line: 119
            -- upvalues: u6 (copy), TargetElement (copy), Players (ref), u17 (ref), u14 (copy)
            if not u6 then
                if TargetElement:IsDescendantOf(workspace) or TargetElement:IsDescendantOf(Players) then
                    TargetElement:TweenSize(u17, "Out", "Quint", 0.25, true);
                else
                    TargetElement.Size = u17;
                end;
            end;

            if u14.OnHover then
                u14.OnHover();
            end;
        end;

        p5.MouseEnter:Connect(hover);
        p5.SelectionGained:Connect(hover);
        p5.MouseButton1Down:Connect(function() -- Line: 136, Name: press
            -- upvalues: u20 (ref), u6 (copy), TargetElement (copy), Players (ref), u16 (ref), u4 (copy)
            u20 = true;

            if not u6 then
                if TargetElement:IsDescendantOf(workspace) or TargetElement:IsDescendantOf(Players) then
                    TargetElement:TweenSize(u16, "Out", "Quint", 0.25, true);
                else
                    TargetElement.Size = u16;
                end;
            end;

            u4:ClickSound();
        end);

        if not (u6 or u14.DontReposition) then
            local v21 = 0.5 - TargetElement.AnchorPoint.X;
            local v22 = 0.5 - TargetElement.AnchorPoint.Y;
            TargetElement.Position = TargetElement.Position + UDim2.new(TargetElement.Size.X.Scale * v21, TargetElement.Size.X.Offset * v21, TargetElement.Size.Y.Scale * v22, TargetElement.Size.Y.Offset * v22);
            TargetElement.AnchorPoint = Vector2.new(0.5, 0.5);
        end;

        return {
            UpdateOriginalSize = update_original_size
        };
    end;

    p5.MouseClick:Connect(function() -- Line: 51
        -- upvalues: u4 (copy)
        u4:ClickSound();
    end);
end;

function u1._Init(p23) -- Line: 169
end;

return u1._new();