-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v3 = {};

local function setScrollButtonVisible(u4, p5, p6) -- Line: 8
    if p5 then
        u4.Visible = true;
        p6:Play();

        return;
    end;

    p6:Play();
    p6.Completed:Once(function() -- Line: 14
        -- upvalues: u4 (copy)
        u4.Visible = false;
    end);
end;

function v3.new(p7) -- Line: 20
    -- upvalues: TweenService (copy), u1 (copy), u2 (copy)
    local ScrollingFrame = p7.ScrollingFrame;
    local ScrollLeftButton = p7.ScrollLeftButton;
    local ScrollRightButton = p7.ScrollRightButton;
    local IncrementPercentage = p7.IncrementPercentage;
    local LeftFade = p7.LeftFade;
    local RightFade = p7.RightFade;
    local u8 = TweenService:Create(ScrollLeftButton, u1, {
        ImageTransparency = 0.24,
        BackgroundTransparency = 0
    });
    local u9 = TweenService:Create(ScrollLeftButton, u1, {
        ImageTransparency = 1,
        BackgroundTransparency = 1
    });
    local u10 = TweenService:Create(ScrollRightButton, u1, {
        ImageTransparency = 0.24,
        BackgroundTransparency = 0
    });
    local u11 = TweenService:Create(ScrollRightButton, u1, {
        ImageTransparency = 1,
        BackgroundTransparency = 1
    });
    local u12 = 0;

    local function updateScrollButtons() -- Line: 36
        -- upvalues: ScrollingFrame (copy), u12 (ref), ScrollLeftButton (copy), u8 (copy), u9 (copy), ScrollRightButton (copy), u10 (copy), u11 (copy), LeftFade (copy), TweenService (ref), u1 (ref), RightFade (copy)
        local v13 = u12 < 1;
        local v14 = u12 >= ScrollingFrame.AbsoluteCanvasSize.X - ScrollingFrame.AbsoluteSize.X - 1;

        if v13 == false then
            ScrollLeftButton.Visible = true;
            u8:Play();
        else
            local u15 = ScrollLeftButton;
            local v16 = u9;
            v16:Play();
            v16.Completed:Once(function() -- Line: 14
                -- upvalues: u15 (copy)
                u15.Visible = false;
            end);
        end;

        if v14 == false then
            ScrollRightButton.Visible = true;
            u10:Play();
        else
            local u17 = ScrollRightButton;
            local v18 = u11;
            v18:Play();
            v18.Completed:Once(function() -- Line: 14
                -- upvalues: u17 (copy)
                u17.Visible = false;
            end);
        end;

        if LeftFade then
            TweenService:Create(LeftFade, u1, {
                BackgroundTransparency = v13 and 1 or 0
            }):Play();
        end;

        if RightFade then
            TweenService:Create(RightFade, u1, {
                BackgroundTransparency = v14 and 1 or 0
            }):Play();
        end;
    end;

    local function smoothScroll(p19) -- Line: 66
        -- upvalues: ScrollingFrame (copy), u12 (ref), updateScrollButtons (copy), TweenService (ref), u2 (ref)
        local v20 = Vector2.new(math.clamp(u12 + p19, 0, ScrollingFrame.AbsoluteCanvasSize.X - ScrollingFrame.AbsoluteSize.X), ScrollingFrame.CanvasPosition.Y);
        u12 = v20.X;
        updateScrollButtons();
        TweenService:Create(ScrollingFrame, u2, {
            CanvasPosition = v20
        }):Play();
    end;

    updateScrollButtons();
    ScrollingFrame:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateScrollButtons);
    ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateScrollButtons);
    ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(updateScrollButtons);
    ScrollLeftButton.Activated:Connect(function() -- Line: 85
        -- upvalues: IncrementPercentage (copy), ScrollingFrame (copy), smoothScroll (copy)
        smoothScroll(-(IncrementPercentage / 100 * ScrollingFrame.AbsoluteWindowSize.X));
    end);
    ScrollRightButton.Activated:Connect(function() -- Line: 90
        -- upvalues: IncrementPercentage (copy), ScrollingFrame (copy), smoothScroll (copy)
        smoothScroll(IncrementPercentage / 100 * ScrollingFrame.AbsoluteWindowSize.X);
    end);
end;

return v3;