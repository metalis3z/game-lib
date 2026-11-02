-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local v2 = {}
local v3 = ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1))
local v4 = ColorSequenceKeypoint.new(0.5, Color3.new(0.7098039388656616, 0.7215686440467834, 0.7372549176216125))

v2[1] = v3
v2[2] = v4
v2[3] = ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
v1.Color = ColorSequence.new(v2)

local v5 = {}
local v6 = NumberSequenceKeypoint.new(0, 0)
local v7 = NumberSequenceKeypoint.new(0.09894459694623947, 0)
local v8 = NumberSequenceKeypoint.new(0.5, 1)
local v9 = NumberSequenceKeypoint.new(0.8997361660003662, 0)

v5[1] = v6
v5[2] = v7
v5[3] = v8
v5[4] = v9
v5[5] = NumberSequenceKeypoint.new(1, 0)
v1.Transparency = NumberSequence.new(v5)
return v1
