-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("RunService")
local v_u_4 = v2.LocalPlayer
local v5 = {}
local v_u_6 = {}
local function v_u_9(p7)
	-- upvalues: (copy) v_u_6
	local v8 = p7:GetPivot()
	v_u_6[p7] = {
		["Model"] = p7,
		["Position"] = Vector2.new(v8.Position.X, v8.Position.Z),
		["Origin"] = v8,
		["Offset"] = math.random() * 30,
		["Variability"] = 4 + math.random() * 2 - 1
	}
end
function v5.Init(_)
	-- upvalues: (copy) v_u_1, (copy) v_u_9, (copy) v_u_4, (copy) v_u_3, (copy) v_u_6
	for _, v10 in v_u_1:GetTagged("AnimatedCloud") do
		if v10:IsA("Model") then
			v_u_9(v10)
		end
	end
	v_u_1:GetInstanceAddedSignal("AnimatedCloud"):Connect(function(p11)
		-- upvalues: (ref) v_u_9
		if p11:IsA("Model") then
			v_u_9(p11)
		end
	end)
	local v_u_12 = Vector2.zero
	local v_u_13 = nil
	local function v15(p14)
		-- upvalues: (ref) v_u_13
		v_u_13 = p14:WaitForChild("HumanoidRootPart", 3)
	end
	if v_u_4.Character then
		v_u_13 = v_u_4.Character:WaitForChild("HumanoidRootPart", 3)
	end
	v_u_4.CharacterAdded:Connect(v15)
	v_u_3.PreSimulation:Connect(function()
		-- upvalues: (ref) v_u_13, (ref) v_u_12, (ref) v_u_6
		local v16 = os.clock()
		if v_u_13 then
			v_u_12 = Vector2.new(v_u_13.Position.X, v_u_13.Position.Z)
		end
		for _, v17 in v_u_6 do
			if (v_u_12 - v17.Position).Magnitude <= 300 then
				local v18 = v17.Origin
				local v19 = v17.Offset
				local v20 = v17.Variability
				local v21 = (v16 + v19) * 0.65
				local v22 = v18 + Vector3.new(0, 1, 0) * math.sin(v21) * v20
				v17.Model:PivotTo(v22)
			end
		end
	end)
end
return v5
