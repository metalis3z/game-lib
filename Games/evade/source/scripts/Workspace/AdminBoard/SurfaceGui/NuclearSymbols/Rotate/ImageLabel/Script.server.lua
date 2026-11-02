---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

-- Decompiled with Bunni.lol Decompiler

local v_tween = game:GetService("TweenService")
local v_new = TweenInfo.new(3, Enum.EasingStyle.Linear)
local v_create = v_tween:Create(script.Parent, v_new, {
	["Position"] = UDim2.new(0.5, 0, 0, 0)
})
while true do
	script.Parent.Position = UDim2.new(0, 0, 0, 0)
	v_create:Play()
	v_create.Completed:Wait()
end