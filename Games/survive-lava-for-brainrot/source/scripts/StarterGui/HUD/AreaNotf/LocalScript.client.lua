-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("TweenService")
local v2 = TweenInfo.new(2, Enum.EasingStyle.Linear)
local v3 = script.Parent:WaitForChild("UIGradient")
local v4 = script.Parent:WaitForChild("UIStroke"):WaitForChild("UIGradient")
local v5 = 0
while true do
	local v6 = v1:Create(v3, v2, {
		["Offset"] = Vector2.new(0, 0.5)
	})
	v6:Play()
	local v7 = v1:Create(v4, v2, {
		["Offset"] = Vector2.new(0, 0.5)
	})
	v7:Play()
	v6.Completed:Wait()
	v7:Cancel()
	local v8 = v5 + 1
	v5 = v8 == 2 and 0 or v8
	v3.Rotation = v5 * 180 + 90
	v4.Rotation = v5 * 180 + 90
	v3.Offset = Vector2.new(0, -0.5)
	v4.Offset = Vector2.new(0, -0.5)
end
