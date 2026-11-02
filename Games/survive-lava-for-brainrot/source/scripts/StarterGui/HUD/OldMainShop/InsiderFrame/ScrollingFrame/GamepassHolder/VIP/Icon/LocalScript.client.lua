-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("TweenService")
local v2 = script.Parent
local v3 = v2.AnchorPoint
local v4 = Vector2.new(0.5, 0.5)
v2.AnchorPoint = v4
v2.Position = v2.Position + UDim2.new((v4.X - v3.X) * v2.Size.X.Scale, (v4.X - v3.X) * v2.Size.X.Offset, (v4.Y - v3.Y) * v2.Size.Y.Scale, (v4.Y - v3.Y) * v2.Size.Y.Offset)
local v5 = v1:Create(v2, TweenInfo.new(0.08, Enum.EasingStyle.Sine), {
	["Rotation"] = -6
})
local v6 = v1:Create(v2, TweenInfo.new(0.08, Enum.EasingStyle.Sine), {
	["Rotation"] = 6
})
local v7 = v1:Create(v2, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
	["Rotation"] = 0
})
while true do
	wait(math.random(2, 5))
	for _ = 1, 4 do
		v5:Play()
		wait(0.08)
		v6:Play()
		wait(0.08)
	end
	v7:Play()
end
