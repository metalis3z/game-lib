-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("TweenService")
local v2 = script.Parent
local v3 = v2.Position
local v4 = {
	["Position"] = UDim2.new(v3.X.Scale, v3.X.Offset, v3.Y.Scale, v3.Y.Offset - 8)
}
v1:Create(v2, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), v4):Play()
