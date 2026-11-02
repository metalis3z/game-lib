-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Parent = script.Parent
local UIStroke = Parent:FindFirstChild("UIStroke")

if UIStroke then
    UIStroke.Color = Color3.new(0, 0, 0)
end
local RainbowGradient = Parent:FindFirstChild("RainbowGradient")
local v1 = RainbowGradient

if not RainbowGradient then
    local UIGradient = Instance.new("UIGradient")
    v1 = UIGradient
    UIGradient.Name = "RainbowGradient"
    UIGradient.Parent = Parent
end
local AdminPanel = script:FindFirstAncestor("AdminPanel")
local v2 = 0
local v3 = RunService.Heartbeat:Connect(function(v4) -- line 18 | captures: v1, v2, AdminPanel
    if AdminPanel and not AdminPanel.Visible then
        return
    end
    v2 += v4 / 3
    if v2 >= 1 then
        v2 -= 1
    end
    v1.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHSV((v2 + 0) % 1, 1, 1)),
        ColorSequenceKeypoint.new(0.17, Color3.fromHSV((v2 + 0.17) % 1, 1, 1)),
        ColorSequenceKeypoint.new(0.33, Color3.fromHSV((v2 + 0.33) % 1, 1, 1)),
        ColorSequenceKeypoint.new(0.5, Color3.fromHSV((v2 + 0.5) % 1, 1, 1)),
        ColorSequenceKeypoint.new(0.67, Color3.fromHSV((v2 + 0.67) % 1, 1, 1)),
        ColorSequenceKeypoint.new(0.83, Color3.fromHSV((v2 + 0.83) % 1, 1, 1)),
        ColorSequenceKeypoint.new(1, Color3.fromHSV((v2 + 1) % 1, 1, 1))
    })
end)
script.AncestryChanged:Connect(function() -- line 48 | captures: v3
    if not script:IsDescendantOf(game) then
        v3:Disconnect()
    end
end)
