local RunService = game:GetService("RunService")
local SPEED = 0.25  -- cycles per second, left -> right

-- 20 keypoints (engine max) = smoothest possible ColorSequence, no banding.
local N = 19
local function seqAt(phase)
    local kps = table.create(N + 1)
    for i = 0, N do
        local t = i / N
        kps[i + 1] = ColorSequenceKeypoint.new(t, Color3.fromHSV((t - phase) % 1, 1, 1))
    end
    return ColorSequence.new(kps)
end

local grads = {}
for _, name in ipairs({"Product10B","Product1B","Product100M"}) do
    local item = script.Parent:WaitForChild(name, 10)
    local buy = item and item:FindFirstChild("BuyButton")
    local price = buy and buy:FindFirstChild("Price")
    local g = price and price:FindFirstChildOfClass("UIGradient")
    if g then
        g.Rotation = 0
        g.Offset = Vector2.new(0, 0)
        grads[#grads+1] = g
    end
end

-- 30 Hz is indistinguishable for a 0.25 cycle/s hue drift -- but setting
-- gradient Color EVERY rendered frame re-rasterized the price labels at
-- 240 Hz on high-refresh clients (constant idle GPU churn). Phase is
-- clock-based, so skipping frames never desyncs the flow.
local UPDATE_INTERVAL = 1 / 30
local accum = 0
RunService.RenderStepped:Connect(function(dt)
    accum += dt
    if accum < UPDATE_INTERVAL then return end
    accum = 0
    local phase = (os.clock() * SPEED) % 1   -- time-based: immune to dt jitter
    local seq = seqAt(phase)
    for _, g in ipairs(grads) do g.Color = seq end
end)
