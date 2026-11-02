---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = script.Parent
local v_u_2 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(0.16666666666666666, Color3.fromRGB(255, 180, 110)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 62, 48)),
	ColorSequenceKeypoint.new(0.8333333333333334, Color3.fromRGB(97, 160, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
local v3 = game:GetService("ReplicatedStorage")
local v4 = game:GetService("RunService")
local v_u_5 = require(v3.Shared.EvalColorSequence)
local v_u_6 = require(v3.Shared.RecolorPart)
local v_u_7 = 0
v4.RenderStepped:Connect(function(p8)
	-- upvalues: (ref) v_u_7, (copy) v_u_5, (copy) v_u_2, (copy) v_u_6, (copy) v_u_1
	v_u_7 = v_u_7 + p8 * script:GetAttribute("Speed")
	local v9 = v_u_5(v_u_2, v_u_7 % 1)
	script:SetAttribute("Color", v9)
	v_u_6(v_u_1, v9)
end)
