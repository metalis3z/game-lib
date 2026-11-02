-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local MouseMovement = require(script.Parent:WaitForChild("MouseMovement"));
local TweenService = game:GetService("TweenService");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 7
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ColorPicker = p2;
    v3.ScaleElement = p2.Instance:WaitForChild("UIScale");
    v3.Window = p2.Instance;
    v3.InfoMenu = v3.Window:WaitForChild("Info");
    v3.InputBox = v3.InfoMenu:WaitForChild("Scale"):WaitForChild("Input");
    v3:Init();

    return v3;
end;

function u1.GetScaleBounds(p4) -- Line: 20
    local v5 = math.floor(p4.ColorPicker.UI.AbsoluteSize.Y / 250);

    return 1, math.max(v5, 2);
end;

function u1.SetScale(p6, p7) -- Line: 24
    local v8 = math.clamp(p7, p6:GetScaleBounds()) * 100;
    local v9 = math.round(v8) / 100;
    p6.ScaleElement.Scale = v9;
    p6.InputBox.Text = tostring(v9);
end;

function u1.Init(u10) -- Line: 31
    u10.InputBox.FocusLost:Connect(function() -- Line: 32
        -- upvalues: u10 (copy)
        u10:SetScale(tonumber(u10.InputBox.Text) or 1);
    end);
end;

function u1.Create(u11) -- Line: 37
    -- upvalues: TweenService (copy), MouseMovement (copy)
    local u12 = script.Parent:WaitForChild("Samples"):WaitForChild("ResizeFrame"):Clone();
    u12.Frame.BackgroundTransparency = 1;
    u12.Parent = u11.ColorPicker.Instance;
    u12.MouseEnter:Connect(function() -- Line: 43
        -- upvalues: TweenService (ref), u12 (copy)
        TweenService:Create(u12.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 0.5
        }):Play();
    end);
    u12.MouseLeave:Connect(function() -- Line: 51
        -- upvalues: TweenService (ref), u12 (copy)
        TweenService:Create(u12.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 1
        }):Play();
    end);
    u11._mouseMovement = MouseMovement.new(function(p13, p14) -- Line: 59
        -- upvalues: u11 (copy)
        local v15 = p14 + (u11.ColorPicker:GetMousePos().X - p13.X) / u11.Window.Size.X.Offset;

        if math.abs(p14 - v15) <= 0.05 then
            v15 = p14;
        else
            local v16 = math.round(v15) - v15;

            if math.abs(v16) <= 0.075 then
                v15 = math.round(v15);
            end;
        end;

        u11:SetScale(v15);
    end);
    local UIScale = u11.ColorPicker.Instance:WaitForChild("UIScale");
    u12.Button.MouseButton1Down:Connect(function() -- Line: 71
        -- upvalues: u11 (copy), UIScale (copy)
        local v17 = u11.ColorPicker:GetMousePos();
        u11._mouseMovement:Connect(v17, UIScale.Scale);
    end);
    u11.Instance = u12;
end;

function u1.Destroy(p18) -- Line: 80
    if p18._mouseMovement then
        p18._mouseMovement:Destroy();
        p18._mouseMovement = nil;
    end;

    if p18.Instance then
        p18.Instance:Destroy();
        p18.Instance = nil;
    end;
end;

return u1;