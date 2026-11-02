-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local u2 = script.Parent:WaitForChild("UIGradient")
local u3 = 0
v1.RenderStepped:Connect(function(p4)
	-- upvalues: (ref) u3, (copy) u2
	u3 = u3 + p4 * 0.1
	local v5 = u3 % 1
	local v6 = (u3 + 0.05) % 1
	local v7 = Color3.fromHSV(v5, 0.8, 1)
	local v8 = Color3.fromHSV(v6, 0.8, 1)
	u2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v7), ColorSequenceKeypoint.new(1, v8) })
end)