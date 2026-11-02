-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players").LocalPlayer
local v_u_4 = v2.Brainrots
local v5 = {}
local v_u_6 = Vector3.new(0, 0, 0)
local v_u_7 = {}
local function v_u_15()
	-- upvalues: (ref) v_u_6, (copy) v_u_7
	local v8 = Vector2.new(v_u_6.X, v_u_6.Z)
	local v9 = 0
	for v10, v11 in v_u_7 do
		local v12 = v10:GetPivot().Position
		if (Vector2.new(v12.X, v12.Z) - v8).Magnitude >= 200 then
			for _, v13 in v11 do
				if v13.IsPlaying then
					v13:Stop()
				end
			end
		else
			for _, v14 in v11 do
				if not v14.IsPlaying then
					v14:Play()
				end
			end
		end
		v9 = v9 + 1
		if v9 % 10 == 0 then
			task.wait()
		end
	end
end
local function v_u_31(p_u_16)
	-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) v_u_15
	local v17 = p_u_16:GetAttribute("Name")
	if v17 then
		local v18 = v_u_4.Normal:FindFirstChild(v17)
		if v18 then
			local v19 = v18:FindFirstChildWhichIsA("Animation", true)
			if v19 then
				if v19.AnimationId == "" then
					warn(p_u_16, v19, "has no AnimationId")
					return
				else
					local v20 = {}
					if p_u_16:FindFirstChildOfClass("Model") then
						for _, v21 in p_u_16:GetChildren() do
							local v22 = v21:FindFirstChild("AnimationController")
							if v22 then
								table.insert(v20, v22)
							else
								local v23 = Instance.new("AnimationController")
								v23.Parent = v21
								table.insert(v20, v23)
							end
						end
					else
						local v24 = p_u_16:FindFirstChild("AnimationController")
						if v24 then
							table.insert(v20, v24)
						else
							local v25 = Instance.new("AnimationController")
							v25.Parent = p_u_16
							table.insert(v20, v25)
						end
					end
					local v26 = {}
					for v27, v28 in v20 do
						local v29 = v28:FindFirstChild("Animator")
						if not v29 then
							v29 = Instance.new("Animator")
							v29.Parent = v28
						end
						local v30 = v29:LoadAnimation(v19)
						v30:Play()
						if v27 <= 1 then
							table.insert(v26, v30)
						end
					end
					v_u_7[p_u_16] = v26
					if v19 and v19.AnimationId then
						p_u_16.Destroying:Connect(function()
							-- upvalues: (ref) v_u_7, (copy) p_u_16
							v_u_7[p_u_16] = nil
						end)
						v_u_15()
					else
						print(p_u_16.Name, "Animation is invalid")
					end
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
function v5.Init(_)
	-- upvalues: (copy) v_u_1, (copy) v_u_31, (ref) v_u_6, (copy) v_u_3, (copy) v_u_15
	v_u_1:GetInstanceAddedSignal("AnimatedBrainrot"):Connect(function(p32)
		-- upvalues: (ref) v_u_31
		if p32:IsA("Model") then
			task.wait(0.25)
			v_u_31(p32)
		end
	end)
	for _, v_u_33 in v_u_1:GetTagged("AnimatedBrainrot") do
		if v_u_33:IsA("Model") then
			task.delay(1, function()
				-- upvalues: (ref) v_u_31, (copy) v_u_33
				v_u_31(v_u_33)
			end)
		end
	end
	local v_u_34 = nil
	local function v36(p35)
		-- upvalues: (ref) v_u_6, (ref) v_u_34
		if v_u_6 == Vector3.new(0, 0, 0) then
			v_u_6 = p35:GetPivot().Position
		end
		v_u_34 = p35:WaitForChild("HumanoidRootPart", 3)
	end
	if v_u_3.Character then
		local v37 = v_u_3.Character
		if v_u_6 == Vector3.new(0, 0, 0) then
			v_u_6 = v37:GetPivot().Position
		end
		v_u_34 = v37:WaitForChild("HumanoidRootPart", 3)
	end
	v_u_3.CharacterAdded:Connect(v36)
	task.spawn(function()
		-- upvalues: (ref) v_u_34, (ref) v_u_6, (ref) v_u_15
		while true do
			repeat
				task.wait(1)
			until v_u_34 and (v_u_34.Parent and (v_u_34.Position - v_u_6).Magnitude > 1)
			v_u_6 = v_u_34.Position
			v_u_15()
		end
	end)
end
return v5
