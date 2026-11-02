-- Notification badge pulse: every few seconds, soft red rings ripple out
-- from the badge while it does a tiny pop + bell wiggle. Subtle + clean.
local TweenService = game:GetService("TweenService")
local badge = script.Parent
local BASE_ROT = badge.Rotation
local RED = Color3.fromRGB(255, 45, 85)

local scale = Instance.new("UIScale")
scale.Name = "PulseScale"
scale.Parent = badge

-- one expanding ring, fading as it grows, then cleans itself up
local function ring()
    local r = Instance.new("Frame")
    r.Name = "PulseRing"
    r.AnchorPoint = Vector2.new(0.5, 0.5)
    r.Position = UDim2.new(0.5, 0, 0.5, 0)
    r.Size = UDim2.new(1, 0, 1, 0)
    r.BackgroundTransparency = 1
    r.ZIndex = 11                       -- behind the badge (12) and its "!" (13)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0.5, 0); c.Parent = r
    local s = Instance.new("UIStroke")
    s.Thickness = 3
    s.Color = RED
    s.Transparency = 0.25
    s.Parent = r
    r.Parent = badge
    local INFO = TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(r, INFO, { Size = UDim2.new(2.4, 0, 2.4, 0) }):Play()
    local fade = TweenService:Create(s, INFO, { Transparency = 1 })
    fade:Play()
    fade.Completed:Once(function() r:Destroy() end)
end

local function rot(target, dur)
    local tw = TweenService:Create(badge, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { Rotation = target })
    tw:Play()
    tw.Completed:Wait()
end

local function pop()
    local up = TweenService:Create(scale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 1.12 })
    up:Play()
    up.Completed:Wait()
    TweenService:Create(scale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
end

while true do
    task.wait(2.6)
    -- badge hidden = no claim waiting (DailyRewardController): skip the
    -- ripple/pop work entirely instead of animating an invisible frame
    if not badge.Visible then continue end
    ring()
    task.delay(0.22, ring)   -- second ripple right behind the first
    task.spawn(pop)
    -- bell wiggle around the badge's natural 20-degree tilt
    rot(BASE_ROT + 9, 0.09)
    rot(BASE_ROT - 9, 0.12)
    rot(BASE_ROT + 5, 0.10)
    rot(BASE_ROT, 0.10)
end
