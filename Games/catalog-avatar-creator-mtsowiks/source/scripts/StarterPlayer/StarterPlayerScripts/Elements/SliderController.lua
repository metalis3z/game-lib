-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Modules = require(script.Parent.Parent.Modules);
local SoundController = require(Modules.Controllers.SoundController);
local u1 = {};
u1.__index = u1;

function u1.SetValue(p2, p3, p4, p5, p6) -- Line: 11
    -- upvalues: TweenService (copy)
    if not p2.Circle then
        return;
    end;

    local v7 = p4 or p2.Instant;
    local v8 = math.clamp(p3 or (p2.Value or p2.MinValue), p2.MinValue, p2.MaxValue);
    local v9 = (v8 - p2.MinValue) / (p2.MaxValue - p2.MinValue);
    local X = p2.Line.AbsoluteSize.X;
    local X2 = p2.Circle.AbsoluteSize.X;
    local v10 = 0;
    local v11;

    if X > 0 then
        v10 = math.clamp(X2 / 2 / X, 0, 0.5);
        v11 = UDim2.new(v10 + v9 * (1 - v10 * 2), 0, p2.Circle.Position.Y.Scale, p2.Circle.Position.Y.Offset);
    else
        v11 = UDim2.new(v9, 0, p2.Circle.Position.Y.Scale, p2.Circle.Position.Y.Offset);
    end;

    local v12 = v9 * (1 - v10);
    local v13;

    if p2.Fill then
        v13 = UDim2.new(v12, 0, p2.Fill.Size.Y.Scale, p2.Fill.Size.Y.Offset);
    else
        v13 = nil;
    end;

    if v7 then
        p2.Circle.Position = v11;

        if p2.Fill then
            p2.Fill.Size = v13;
        end;
    else
        TweenService:Create(p2.Circle, p2.TweenInfo, {
            Position = v11
        }):Play();

        if p2.Fill then
            TweenService:Create(p2.Fill, p2.TweenInfo, {
                Size = v13
            }):Play();
        end;
    end;

    p2.Value = v8;

    if not p5 and p2._onValueUpdated then
        p2._onValueUpdated:Fire(v8);
    end;

    if p2._onThumbUpdated then
        p2._onThumbUpdated(v8, p6);
    end;

    if p2.ValueBox then
        local v14 = p2.NoPercentageSign == true and "" or "%";
        local ValueBox = p2.ValueBox;
        local v15 = math.round(v8);
        ValueBox.Text = tostring(v15) .. v14;
    end;
end;

function u1.SetBounds(p16, p17, p18) -- Line: 64
    p16.MinValue = p17;
    p16.MaxValue = p18;
    p16:SetValue(p16.Value, true, true, true);
end;

function u1.UpdateFromMouse(p19) -- Line: 70
    -- upvalues: UserInputService (copy), SoundController (copy)
    if not p19.Line then
        return;
    end;

    local v20 = UserInputService:GetMouseLocation();

    if p19.LastMouseLocation == v20 then
        return;
    end;

    p19.LastMouseLocation = v20;
    local v21 = math.clamp((v20.X - p19.Line.AbsolutePosition.X) / p19.Line.AbsoluteSize.X, 0, 1);
    local v22 = math.round((p19.MinValue + v21 * (p19.MaxValue - p19.MinValue)) / p19.Increment) * p19.Increment;

    if v22 ~= p19.Value then
        if p19._onThumbUpdated then
            p19._onThumbUpdated(v22);
        end;

        local v23 = p19.MaxValue - p19.MinValue;

        if v23 > 0 then
            local v24 = v23 / 10;

            if math.floor((p19.Value - p19.MinValue) / v24) ~= math.floor((v22 - p19.MinValue) / v24) then
                SoundController.PlaySound("HOVER", nil, {
                    PlaybackSpeed = 1.2,
                    Volume = 0.3
                });
            end;
        end;

        p19:SetValue(v22);
    end;
end;

function u1.StopDrag(p25) -- Line: 105
    if p25.DragConnection then
        p25.DragConnection:Disconnect();
        p25.DragConnection = nil;
    end;

    if p25.ReleaseConnection then
        p25.ReleaseConnection:Disconnect();
        p25.ReleaseConnection = nil;
    end;
end;

function u1.Cleanup(p26) -- Line: 117
    p26:StopDrag();

    if p26._connections then
        for _, v in p26._connections do
            if v.Connected then
                v:Disconnect();
            end;
        end;

        p26._connections = nil;
    end;

    if p26._onValueUpdated then
        p26._onValueUpdated:Destroy();
        p26._onValueUpdated = nil;
    end;

    if p26._onInputEnded then
        p26._onInputEnded:Destroy();
        p26._onInputEnded = nil;
    end;

    p26.SliderButton = nil;
    p26.ValueBox = nil;
    p26.Circle = nil;
    p26.Line = nil;
    p26.Fill = nil;
    p26.OnValueUpdated = nil;
    p26.OnInputEnded = nil;
end;

function u1.new(p27) -- Line: 149
    -- upvalues: u1 (copy), RunService (copy), UserInputService (copy)
    local u28 = setmetatable({}, u1);
    u28._connections = {};
    u28._onValueUpdated = Instance.new("BindableEvent");
    u28.OnValueUpdated = u28._onValueUpdated.Event;
    u28._onInputEnded = Instance.new("BindableEvent");
    u28.OnInputEnded = u28._onInputEnded.Event;
    u28._onThumbUpdated = p27.OnThumbUpdated;
    u28.NoPercentageSign = p27.NoPercentageSign;
    u28.SliderButton = p27.SliderButton;
    u28.ValueBox = p27.ValueBox;
    u28.Circle = u28.SliderButton:WaitForChild("circle");
    u28.Line = u28.SliderButton:WaitForChild("line");
    u28.Fill = u28.Line:FindFirstChild("fill");
    u28.MinValue = p27.MinValue;
    u28.MaxValue = p27.MaxValue;
    u28.Instant = p27.Instant;
    u28.Increment = p27.Increment or 1;
    u28.TweenInfo = p27.TweenInfo or TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

    local function beginDrag() -- Line: 176
        -- upvalues: u28 (copy), RunService (ref), UserInputService (ref)
        u28:StopDrag();
        u28:UpdateFromMouse();
        u28.DragConnection = RunService.RenderStepped:Connect(function() -- Line: 180
            -- upvalues: u28 (ref)
            u28:UpdateFromMouse();
        end);
        u28.ReleaseConnection = UserInputService.InputEnded:Connect(function(p29) -- Line: 184
            -- upvalues: u28 (ref)
            if p29.UserInputType == Enum.UserInputType.MouseButton1 or p29.UserInputType == Enum.UserInputType.Touch then
                u28:StopDrag();

                if u28._onInputEnded then
                    u28._onInputEnded:Fire(u28.Value);
                end;
            end;
        end);
    end;

    local v36 = u28.SliderButton.InputBegan:Connect(function(u30) -- Line: 194
        -- upvalues: beginDrag (copy), UserInputService (ref)
        if u30.UserInputType == Enum.UserInputType.MouseButton1 then
            beginDrag();

            return;
        end;

        if u30.UserInputType == Enum.UserInputType.Touch then
            local Position = u30.Position;
            local u31 = nil;
            local u32 = nil;

            local function cleanupTouch() -- Line: 203
                -- upvalues: u31 (ref), u32 (ref)
                if u31 then
                    u31:Disconnect();
                    u31 = nil;
                end;

                if u32 then
                    u32:Disconnect();
                    u32 = nil;
                end;
            end;

            u31 = UserInputService.InputChanged:Connect(function(p33) -- Line: 208
                -- upvalues: u30 (copy), Position (copy), u31 (ref), u32 (ref), beginDrag (ref)
                if p33 ~= u30 then
                    return;
                end;

                local v34 = p33.Position - Position;

                if math.abs(v34.X) < 8 then
                    if math.abs(v34.Y) >= 8 then
                        if u31 then
                            u31:Disconnect();
                            u31 = nil;
                        end;

                        if u32 then
                            u32:Disconnect();
                            u32 = nil;
                        end;
                    end;

                    return;
                end;

                if u31 then
                    u31:Disconnect();
                    u31 = nil;
                end;

                if u32 then
                    u32:Disconnect();
                    u32 = nil;
                end;

                beginDrag();
            end);
            u32 = UserInputService.InputEnded:Connect(function(p35) -- Line: 219
                -- upvalues: u30 (copy), u31 (ref), u32 (ref)
                if p35 ~= u30 then
                    return;
                end;

                if u31 then
                    u31:Disconnect();
                    u31 = nil;
                end;

                if u32 then
                    u32:Disconnect();
                    u32 = nil;
                end;
            end);
        end;
    end);
    table.insert(u28._connections, v36);

    if u28.ValueBox then
        local v40 = u28.ValueBox.FocusLost:Connect(function() -- Line: 228
            -- upvalues: u28 (copy)
            local v37 = string.gsub(u28.ValueBox.Text, "%%", "");
            local v38 = string.gsub(v37, " ", "");
            local v39 = tonumber(v38);

            if v39 then
                u28:SetValue(math.round(v39 / u28.Increment) * u28.Increment);

                return;
            end;

            u28:SetValue(u28.Value);
        end);
        table.insert(u28._connections, v40);
    end;

    local v41 = u28.Line:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 245
        -- upvalues: u28 (copy)
        u28:SetValue(u28.Value, true, true, true);
    end);
    table.insert(u28._connections, v41);
    u28:SetValue(p27.Value or u28.MinValue, true);

    return u28;
end;

return u1;