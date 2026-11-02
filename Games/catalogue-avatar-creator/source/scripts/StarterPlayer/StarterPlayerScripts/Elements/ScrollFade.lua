-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local u1 = {};
u1.__index = u1;
local Quad = Enum.EasingStyle.Quad;
local Out = Enum.EasingDirection.Out;

local function getFadeProp(p2) -- Line: 18
    return p2 ~= nil and (p2:IsA("CanvasGroup") and "GroupTransparency" or ((p2:IsA("ImageLabel") or p2:IsA("ImageButton")) and "ImageTransparency" or "BackgroundTransparency")) or nil;
end;

function u1.new(p3, p4, p5, p6) -- Line: 32
    -- upvalues: u1 (copy)
    local u7 = setmetatable({}, u1);
    u7._scrollingFrame = p3;
    u7._topFade = p4;
    u7._bottomBuffer = p5;
    u7._threshold = p6 and (p6.Threshold or 8) or 8;
    u7._fadeTime = p6 and p6.FadeTime or 0.15;
    u7._topFadeShown = false;
    u7._topFadeTween = nil;
    u7._topFadeSeq = 0;
    u7._bottomBufferShown = false;
    u7._bottomBufferTween = nil;
    u7._bottomBufferSeq = 0;
    u7._connections = {};

    if u7._topFade then
        local _topFade = u7._topFade;
        u7._topFade[_topFade ~= nil and (_topFade:IsA("CanvasGroup") and "GroupTransparency" or ((_topFade:IsA("ImageLabel") or _topFade:IsA("ImageButton")) and "ImageTransparency" or "BackgroundTransparency")) or nil] = 1;
        u7._topFade.Visible = false;
    end;

    if u7._bottomBuffer then
        local _bottomBuffer = u7._bottomBuffer;
        u7._bottomBuffer[_bottomBuffer ~= nil and (_bottomBuffer:IsA("CanvasGroup") and "GroupTransparency" or ((_bottomBuffer:IsA("ImageLabel") or _bottomBuffer:IsA("ImageButton")) and "ImageTransparency" or "BackgroundTransparency")) or nil] = 0;
        u7._bottomBuffer.Visible = true;
        u7._bottomBufferShown = true;
    end;

    local _connections = u7._connections;
    local v8 = p3:GetPropertyChangedSignal("CanvasPosition");
    table.insert(_connections, v8:Connect(function() -- Line: 64
        -- upvalues: u7 (copy)
        u7:Update();
    end));
    local _connections2 = u7._connections;
    local v9 = p3:GetPropertyChangedSignal("AbsoluteCanvasSize");
    table.insert(_connections2, v9:Connect(function() -- Line: 67
        -- upvalues: u7 (copy)
        u7:Update();
    end));
    local v10 = p3:FindFirstChildWhichIsA("UIGridLayout") or p3:FindFirstChildWhichIsA("UIListLayout");

    if v10 then
        local _connections3 = u7._connections;
        local v11 = v10:GetPropertyChangedSignal("AbsoluteContentSize");
        table.insert(_connections3, v11:Connect(function() -- Line: 74
            -- upvalues: u7 (copy)
            u7:Update();
        end));
    end;

    task.defer(function() -- Line: 80
        -- upvalues: u7 (copy)
        u7:Update();
    end);

    return u7;
end;

function u1._tweenTopFade(u12, p13) -- Line: 87
    -- upvalues: TweenService (copy), Quad (copy), Out (copy)
    local _topFade = u12._topFade;

    if not _topFade then
        return;
    end;

    if u12._topFadeShown == p13 and _topFade.Visible == p13 then
        return;
    end;

    if u12._topFadeTween then
        u12._topFadeTween:Cancel();
        u12._topFadeTween = nil;
    end;

    u12._topFadeSeq = u12._topFadeSeq + 1;
    local _topFadeSeq = u12._topFadeSeq;
    local _fadeTime = u12._fadeTime;

    if p13 then
        _topFade.Visible = true;
        u12._topFadeTween = TweenService:Create(_topFade, TweenInfo.new(_fadeTime, Quad, Out), {
            [_topFade ~= nil and (_topFade:IsA("CanvasGroup") and "GroupTransparency" or ((_topFade:IsA("ImageLabel") or _topFade:IsA("ImageButton")) and "ImageTransparency" or "BackgroundTransparency")) or nil] = 0
        });
        u12._topFadeTween:Play();
        u12._topFadeShown = true;

        return;
    end;

    u12._topFadeTween = TweenService:Create(_topFade, TweenInfo.new(_fadeTime, Quad, Out), {
        [_topFade ~= nil and (_topFade:IsA("CanvasGroup") and "GroupTransparency" or ((_topFade:IsA("ImageLabel") or _topFade:IsA("ImageButton")) and "ImageTransparency" or "BackgroundTransparency")) or nil] = 1
    });
    u12._topFadeTween:Play();
    u12._topFadeShown = false;
    task.delay(_fadeTime + 0.02, function() -- Line: 110
        -- upvalues: _topFadeSeq (copy), u12 (copy), _topFade (copy)
        if _topFadeSeq == u12._topFadeSeq and (_topFade and not u12._topFadeShown) then
            _topFade.Visible = false;
        end;
    end);
end;

function u1._tweenBottomBuffer(u14, p15) -- Line: 118
    -- upvalues: TweenService (copy), Quad (copy), Out (copy)
    local _bottomBuffer = u14._bottomBuffer;

    if not _bottomBuffer then
        return;
    end;

    if u14._bottomBufferShown == p15 and _bottomBuffer.Visible == p15 then
        return;
    end;

    if u14._bottomBufferTween then
        u14._bottomBufferTween:Cancel();
        u14._bottomBufferTween = nil;
    end;

    u14._bottomBufferSeq = u14._bottomBufferSeq + 1;
    local _bottomBufferSeq = u14._bottomBufferSeq;
    local _fadeTime = u14._fadeTime;

    if p15 then
        _bottomBuffer.Visible = true;
        u14._bottomBufferTween = TweenService:Create(_bottomBuffer, TweenInfo.new(_fadeTime, Quad, Out), {
            [_bottomBuffer ~= nil and (_bottomBuffer:IsA("CanvasGroup") and "GroupTransparency" or ((_bottomBuffer:IsA("ImageLabel") or _bottomBuffer:IsA("ImageButton")) and "ImageTransparency" or "BackgroundTransparency")) or nil] = 0
        });
        u14._bottomBufferTween:Play();
        u14._bottomBufferShown = true;

        return;
    end;

    u14._bottomBufferTween = TweenService:Create(_bottomBuffer, TweenInfo.new(_fadeTime, Quad, Out), {
        [_bottomBuffer ~= nil and (_bottomBuffer:IsA("CanvasGroup") and "GroupTransparency" or ((_bottomBuffer:IsA("ImageLabel") or _bottomBuffer:IsA("ImageButton")) and "ImageTransparency" or "BackgroundTransparency")) or nil] = 1
    });
    u14._bottomBufferTween:Play();
    u14._bottomBufferShown = false;
    task.delay(_fadeTime + 0.02, function() -- Line: 141
        -- upvalues: _bottomBufferSeq (copy), u14 (copy), _bottomBuffer (copy)
        if _bottomBufferSeq == u14._bottomBufferSeq and (_bottomBuffer and not u14._bottomBufferShown) then
            _bottomBuffer.Visible = false;
        end;
    end);
end;

function u1.Update(p16) -- Line: 149
    local _scrollingFrame = p16._scrollingFrame;

    if not _scrollingFrame then
        return;
    end;

    if p16._topFade then
        p16:_tweenTopFade(_scrollingFrame.CanvasPosition.Y > p16._threshold);
    end;

    if p16._bottomBuffer then
        local Y = _scrollingFrame.AbsoluteCanvasSize.Y;
        local Y2 = _scrollingFrame.AbsoluteWindowSize.Y;

        if Y <= Y2 then
            p16:_tweenBottomBuffer(false);

            return;
        end;

        p16:_tweenBottomBuffer(Y - (_scrollingFrame.CanvasPosition.Y + Y2) > p16._threshold);
    end;
end;

function u1.ShowTopFade(p17, p18) -- Line: 174
    p17:_tweenTopFade(p18);
end;

function u1.ShowBottomBuffer(p19, p20) -- Line: 178
    p19:_tweenBottomBuffer(p20);
end;

function u1.Destroy(p21) -- Line: 182
    for _, v in p21._connections do
        v:Disconnect();
    end;

    table.clear(p21._connections);

    if p21._topFadeTween then
        p21._topFadeTween:Cancel();
    end;

    if p21._bottomBufferTween then
        p21._bottomBufferTween:Cancel();
    end;

    p21._scrollingFrame = nil;
    p21._topFade = nil;
    p21._bottomBuffer = nil;
end;

return u1;