-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Modules = require(script.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local SoundController = require(Modules.Controllers.SoundController);
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u2 = Color3.fromRGB(51, 95, 255);
local u3 = Color3.fromHex("494d5a");
local u4 = {};
u4.__index = u4;

function u4.UpdateState(p5, p6, p7, p8) -- Line: 15
    -- upvalues: ThemeController (copy), u2 (copy), u3 (copy), TweenService (copy), u1 (copy)
    local Button = p5.Button;
    local Circle = p5.Circle;
    p5.State = p6;

    if p7 then
        local v9 = p6 and 1 or 0;
        local v10;

        if p6 then
            v10 = u2;
        else
            v10 = u3;
        end;

        Button.BackgroundColor3 = ThemeController.GetColor(v10);
        Circle.Position = UDim2.fromScale(v9, 0.5);
        Circle.AnchorPoint = Vector2.new(v9, 0.5);
        Circle.UIAspectRatioConstraint.AspectRatio = 1;
    else
        local v11;

        if p6 == true then
            v11 = TweenService:Create(Circle, u1, {
                Position = UDim2.fromScale(1, 0.5),
                AnchorPoint = Vector2.new(1, 0.5)
            });
            TweenService:Create(Button, u1, {
                BackgroundColor3 = ThemeController.GetColor(u2)
            }):Play();
        else
            v11 = TweenService:Create(Circle, u1, {
                Position = UDim2.fromScale(0, 0.5),
                AnchorPoint = Vector2.new(0, 0.5)
            });
            TweenService:Create(Button, u1, {
                BackgroundColor3 = u3
            }):Play();
        end;

        v11:Play();
        task.delay(u1.Time / 2, function() -- Line: 39
            -- upvalues: TweenService (ref), Circle (copy), u1 (ref)
            TweenService:Create(Circle.UIAspectRatioConstraint, u1, {
                AspectRatio = 1
            }):Play();
        end);
    end;

    if not p8 then
        p5._onStateUpdated:Fire(p6);
    end;
end;

function u4.Cleanup(p12) -- Line: 47
    for _, v in p12._connections do
        v:Disconnect();
    end;

    p12._onStateUpdated:Destroy();
    p12._onStateUpdated = nil;
    p12._connections = nil;
    p12.Button = nil;
    p12.Circle = nil;
    p12.State = nil;
    p12.OnStateUpdated = nil;
end;

function u4.Destroy(p13) -- Line: 62
    p13:Cleanup();
end;

function u4.new(p14) -- Line: 66
    -- upvalues: u4 (copy), SoundController (copy), TweenService (copy), u1 (copy)
    local u15 = setmetatable({}, u4);
    local Button = p14.Button;
    local circle = Button:FindFirstChild("circle");
    u15.Button = Button;
    u15.Circle = circle;
    u15.State = p14.State or false;
    u15._connections = {};
    u15._onStateUpdated = Instance.new("BindableEvent");
    u15.OnStateUpdated = u15._onStateUpdated.Event;
    u15:UpdateState(u15.State, true);
    table.insert(u15._connections, u15.Button.Activated:Connect(function() -- Line: 82
        -- upvalues: SoundController (ref), u15 (copy)
        SoundController.PlaySound("CLICK");
        u15.State = not u15.State;
        u15:UpdateState(u15.State);
    end));
    table.insert(u15._connections, u15.Button.MouseEnter:Connect(function() -- Line: 88
        -- upvalues: SoundController (ref)
        SoundController.PlaySound("HOVER");
    end));
    table.insert(u15._connections, u15.Button.MouseButton1Down:Connect(function() -- Line: 92
        -- upvalues: TweenService (ref), circle (copy), u1 (ref)
        TweenService:Create(circle.UIAspectRatioConstraint, u1, {
            AspectRatio = 1.25
        }):Play();
    end));
    table.insert(u15._connections, u15.Button.MouseLeave:Connect(function() -- Line: 96
        -- upvalues: TweenService (ref), circle (copy), u1 (ref)
        TweenService:Create(circle.UIAspectRatioConstraint, u1, {
            AspectRatio = 1
        }):Play();
    end));

    return u15;
end;

return u4;