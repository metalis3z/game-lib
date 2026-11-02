-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
script.Parent.Rotation = -15
game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
	["Rotation"] = -script.Parent.Rotation
}):Play()
