-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local TweenService = game:GetService("TweenService");
local GuiService = game:GetService("GuiService");
local v1 = {};
local u2 = {};
local u3 = false;
local u4 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

local function getMouseGuiPosition() -- Line: 44
    -- upvalues: UserInputService (copy), GuiService (copy)
    return UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
end;

local function isMouseOverFrame(p5, p6) -- Line: 51
    local AbsolutePosition = p5.AbsolutePosition;
    local AbsoluteSize = p5.AbsoluteSize;
    local v7;

    if p6.X >= AbsolutePosition.X and (p6.X <= AbsolutePosition.X + AbsoluteSize.X and p6.Y >= AbsolutePosition.Y) then
        v7 = p6.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
    else
        v7 = false;
    end;

    return v7;
end;

local function isMouseOverAnyAttachedFrame() -- Line: 61
    -- upvalues: u2 (copy), UserInputService (copy), GuiService (copy)
    if next(u2) == nil then
        return false;
    end;

    local v8 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();

    for i in u2 do
        if i.Visible and i.Active then
            local AbsolutePosition = i.AbsolutePosition;
            local AbsoluteSize = i.AbsoluteSize;
            local v9;

            if v8.X >= AbsolutePosition.X and (v8.X <= AbsolutePosition.X + AbsoluteSize.X and v8.Y >= AbsolutePosition.Y) then
                v9 = v8.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
            else
                v9 = false;
            end;

            if v9 and i.AbsoluteCanvasSize.Y > i.AbsoluteWindowSize.Y then
                return true;
            end;
        end;
    end;

    return false;
end;

local function UpdateActionBinding() -- Line: 82
    -- upvalues: u2 (copy), u3 (ref), ContextActionService (copy), isMouseOverAnyAttachedFrame (copy)
    local v10 = next(u2) ~= nil;

    if not v10 or u3 then
        if not v10 and u3 then
            ContextActionService:UnbindAction("CustomScrollSpeed_MouseWheel");
            u3 = false;
        end;

        return;
    end;

    ContextActionService:BindAction("CustomScrollSpeed_MouseWheel", function(p11, p12, p13) -- Line: 87
        -- upvalues: isMouseOverAnyAttachedFrame (ref)
        if p12 ~= Enum.UserInputState.Change then
            return Enum.ContextActionResult.Pass;
        end;

        if p13.UserInputType ~= Enum.UserInputType.MouseWheel then
            return Enum.ContextActionResult.Pass;
        end;

        if isMouseOverAnyAttachedFrame() then
            return Enum.ContextActionResult.Sink;
        end;

        return Enum.ContextActionResult.Pass;
    end, false, Enum.UserInputType.MouseWheel);
    u3 = true;
end;

local function getOrInitState(p14) -- Line: 111
    -- upvalues: u2 (copy)
    local v15 = u2[p14];

    if not v15 then
        v15 = {
            mode = "Absolute",
            speed = 20,
            percent = 0.25,
            minPixels = 16,
            maxPixels = 96,
            tween = nil,
            targetY = p14.CanvasPosition.Y
        };
        u2[p14] = v15;
    end;

    return v15;
end;

local function getIncrementForFrame(p16, p17) -- Line: 128
    if p17.mode ~= "Relative" then
        return p17.speed or 20;
    end;

    local v18 = p17.percent or 0.25;

    if v18 > 1 then
        v18 = v18 / 100;
    end;

    return math.clamp(p16.AbsoluteWindowSize.Y * v18, p17.minPixels or 16, p17.maxPixels or 96);
end;

UserInputService.InputChanged:Connect(function(p19) -- Line: 150
    -- upvalues: u2 (copy), UserInputService (copy), GuiService (copy), TweenService (copy), u4 (copy)
    if p19.UserInputType ~= Enum.UserInputType.MouseWheel then
        return;
    end;

    if next(u2) == nil then
        return;
    end;

    local Z = p19.Position.Z;

    if Z == 0 then
        return;
    end;

    local v20 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();

    for i, v in pairs(u2) do
        if i.Visible and i.Active then
            local AbsolutePosition = i.AbsolutePosition;
            local AbsoluteSize = i.AbsoluteSize;
            local v21;

            if v20.X >= AbsolutePosition.X and (v20.X <= AbsolutePosition.X + AbsoluteSize.X and v20.Y >= AbsolutePosition.Y) then
                v21 = v20.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
            else
                v21 = false;
            end;

            if v21 then
                local Y = i.AbsoluteCanvasSize.Y;
                local Y2 = i.AbsoluteWindowSize.Y;

                if Y <= Y2 then
                    return;
                end;

                local v22;

                if v.mode == "Relative" then
                    local v23 = v.percent or 0.25;

                    if v23 > 1 then
                        v23 = v23 / 100;
                    end;

                    v22 = math.clamp(i.AbsoluteWindowSize.Y * v23, v.minPixels or 16, v.maxPixels or 96);
                else
                    v22 = v.speed or 20;
                end;

                local v24 = math.clamp((v.targetY or i.CanvasPosition.Y) + v22 * Z * -1, 0, Y - Y2);
                v.targetY = v24;

                if v.tween then
                    v.tween:Cancel();
                    v.tween = nil;
                end;

                local v25 = TweenService:Create(i, u4, {
                    CanvasPosition = Vector2.new(i.CanvasPosition.X, v24)
                });
                v.tween = v25;
                v25:Play();

                return;
            end;
        end;
    end;
end);

function v1.Attach(p26, p27) -- Line: 196
    -- upvalues: u2 (copy), UpdateActionBinding (copy)
    local v28 = u2[p26];

    if not v28 then
        v28 = {
            mode = "Absolute",
            speed = 20,
            percent = 0.25,
            minPixels = 16,
            maxPixels = 96,
            tween = nil,
            targetY = p26.CanvasPosition.Y
        };
        u2[p26] = v28;
    end;

    local mode = v28.mode;
    local speed = v28.speed;
    local percent = v28.percent;
    local minPixels = v28.minPixels;
    local maxPixels = v28.maxPixels;

    if typeof(p27) == "number" then
        speed = p27;
        mode = "Absolute";
    elseif typeof(p27) == "table" then
        mode = p27.Mode == "Relative" and "Relative" or (p27.Mode == "Absolute" and "Absolute" or mode);

        if p27.Speed ~= nil then
            speed = p27.Speed;
        end;

        if p27.Percent ~= nil then
            percent = p27.Percent;
        end;

        if p27.MinPixels ~= nil then
            minPixels = p27.MinPixels;
        end;

        if p27.MaxPixels ~= nil then
            maxPixels = p27.MaxPixels;
        end;
    end;

    v28.mode = mode;
    v28.speed = speed;
    v28.percent = percent;
    v28.minPixels = minPixels;
    v28.maxPixels = maxPixels;
    v28.targetY = p26.CanvasPosition.Y;
    UpdateActionBinding();
end;

function v1.Detach(p29) -- Line: 245
    -- upvalues: u2 (copy), UpdateActionBinding (copy)
    local v30 = u2[p29];

    if v30 then
        if v30.tween then
            v30.tween:Cancel();
        end;

        u2[p29] = nil;
    end;

    UpdateActionBinding();
end;

return v1;