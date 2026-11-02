-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TweenService = game:GetService("TweenService")
local v1 = {
    Distance = 6,
    Duration = 1.4,
    Sway = 0,
    SwayDuration = 1.9,
    Style = Enum.EasingStyle.Sine
}
local Parent = script.Parent
local Position = Parent.Position
local Rotation = Parent.Rotation
local v2 = Position - UDim2.fromOffset(0, v1.Distance)
local v3 = Position + UDim2.fromOffset(0, v1.Distance)
local v4 = {}
local v5 = TweenInfo.new(v1.Duration, v1.Style, Enum.EasingDirection.InOut, -1, true)
local v6 = TweenService:Create(Parent, TweenInfo.new(v1.Duration / 2, v1.Style, Enum.EasingDirection.Out), { Position = v2 })
table.insert(v4, v6)
v6.Completed:Connect(function(v7) -- line 24 | captures: TweenService, Parent, v3, v4, v5
    if v7 ~= Enum.PlaybackState.Completed then
        return
    end
    local v8 = TweenService:Create(Parent, v5, { Position = v3 })
    table.insert(v4, v8)
    v8:Play()
end)
v6:Play()

if not (v1.Sway and v1.Sway > 0) then
    return
end
Parent.Rotation = Rotation - v1.Sway

local v9 = TweenService:Create(Parent, TweenInfo.new(v1.SwayDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), { Rotation = Rotation + v1.Sway })
table.insert(v4, v9)
v9:Play()
