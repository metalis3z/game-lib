-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = 0
local v_u_2 = 0
script.Parent:WaitForChild("Weld").Enabled = false
script.Parent.Anchored = true
local v_u_3 = game:GetService("TweenService")
game:GetService("RunService").Stepped:Connect(function(_, p4)
	-- upvalues: (ref) v_u_1, (ref) v_u_2, (copy) v_u_3
	v_u_1 = v_u_1 + 0.01 * (p4 * 100)
	v_u_2 = v_u_2 + 1 * (p4 * 100)
	local v5 = v_u_2
	local v6 = script.Parent.Weld.Part0.CFrame * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 0) * CFrame.fromEulerAnglesXYZ(0, 0, (math.rad(v5))) * CFrame.new(3, 0, 0)
	local v7 = v_u_3
	local v8 = script.Parent
	local v9 = TweenInfo.new(0.75)
	local v10 = {}
	local v11 = v_u_1
	local v12 = v6 * CFrame.new(0, 0, math.sin(v11) * 2)
	local v13 = CFrame.Angles
	local v14 = v_u_1
	local v15 = math.sin(v14) * 15
	local v16 = math.rad(v15)
	local v17 = v_u_1 * 100
	v10.CFrame = v12 * v13(0, v16, (math.rad(v17)))
	v7:Create(v8, v9, v10):Play()
end)