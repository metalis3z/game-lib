-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_Parent_0 = script.Parent;
local l_Humanoid_0 = l_Parent_0:WaitForChild("Humanoid");
local l_Head_0 = l_Parent_0:WaitForChild("Head");
local function v11(v6) --[[ Line: 10 ]] --[[ Name: teleportToPart ]]
	print(v6.Name)
	if not l_Humanoid_0.RootPart then
		return;
	else
		local l_Position_0 = v6.Position;
		local v8 = Vector3.new(v6.CFrame.LookVector.X, l_Humanoid_0.RootPart.CFrame.LookVector.Y, v6.CFrame.LookVector.Z);
		local v9 = l_Position_0 + Vector3.new(0, l_Humanoid_0.HipHeight, 0);
		local v10 = CFrame.lookAt(v9, v9 + v8);
		l_Parent_0:PivotTo(v10);
		return;
	end;
end;



local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local v_u_1 = game:GetService("Players").LocalPlayer
local v_u_2 = v_u_1.Character or v_u_1.CharacterAdded:Wait()

local v_u_4 = nil
local v_u_5 = {}
local v_u_6 = {}

local function v_u_10(p1)
	for _, v in pairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			return v
		end
	end
	return nil
end

local function v_u_11(p2, p3)
	for _, v in pairs(p2) do
		if v:IsA("BasePart") or v:IsA("Decal") or v:IsA("ParticleEmitter") or v:IsA("Fire") then
			v.LocalTransparencyModifier = p3
		end
	end
end

local function v_u_20(p4, p5)
	if not v_u_4 or not v_u_4:IsA("BasePart") then return end
	if p5 then
		local v1 = { p5 }
		for _, v2 in p5:GetDescendants() do
			if v2:IsA("BasePart") or v2:IsA("Decal") or v2:IsA("ParticleEmitter") or v2:IsA("Fire") then
				table.insert(v1, v2)
			end
		end
		local v3 = v_u_4.LocalTransparencyModifier
		v_u_11(v1, v3)
		if p4 == "Knife" then
			v_u_5 = v1
		elseif p4 == "Gun" then
			v_u_6 = v1
		end
	end
end

local function v_u_12(p6, p7)
	if p6 then
		v_u_20(p7, p6.Value)
		p6:GetPropertyChangedSignal("Value"):Connect(function()
			v_u_20(p7, p6.Value)
		end)
	end
end

local function v_u_13(p8)
	v_u_2 = p8
	v_u_4 = v_u_10(p8)

	local v1 = p8:FindFirstChild("DisplayRefKnife")
	local v2 = p8:FindFirstChild("DisplayRefGun")

	v_u_12(v1, "Knife")
	v_u_12(v2, "Gun")

	p8.ChildAdded:Connect(function(p9)
		if p9.Name == "DisplayRefKnife" then
			v_u_12(p9, "Knife")
		elseif p9.Name == "DisplayRefGun" then
			v_u_12(p9, "Gun")
		end
	end)

	if v_u_4 then
		v_u_4:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
			local v3 = v_u_4.LocalTransparencyModifier
			if v3 >= 1 or v3 <= 0 then
				v_u_11(v_u_5, v3)
				v_u_11(v_u_6, v3)
			end
		end)
	end
end

v_u_13(v_u_2)
v_u_1.CharacterAdded:Connect(function(p10)
	v_u_13(p10)
end)