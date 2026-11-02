-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Util)
function v1.OnExecution(_, p_u_3, p_u_4)
	-- upvalues: (copy) v_u_2
	local v5 = p_u_4:FindFirstChild("Sword")
	local v_u_6 = p_u_4:FindFirstChild("Humanoid")
	local v_u_7 = p_u_4:FindFirstChild("Head")
	local v_u_8 = require(game.ReplicatedStorage.Modules.Ragdolls)
	if p_u_4.Name == "Shedletsky" then
		v5.Transparency = 0
		local _ = workspace:GetServerTimeNow() + 3.23
		task.delay(2.84, function()
			-- upvalues: (copy) v_u_6, (copy) v_u_8, (copy) p_u_4, (copy) v_u_7
			if v_u_6 then
				v_u_8.AddProfile(p_u_4, {
					["Velocity"] = Vector3.new(0, 50, 0),
					["KillEffects"] = {
						["HeadSquash"] = true
					}
				})
				v_u_6.Health = 0
				for _, v9 in ipairs(p_u_4 and p_u_4:GetChildren() or {}) do
					if v9:IsA("Accessory") then
						v9:Destroy()
					end
				end
				if v_u_7 then
					v_u_7:Destroy()
				end
			end
		end)
	else
		local _ = workspace:GetServerTimeNow() + 2
		local v10 = tick()
		local v_u_11 = p_u_3.Config.ZombieTemplate:Clone()
		v_u_11.Name = "OutroZombie"
		v_u_11.PrimaryPart.Anchored = true
		v_u_11:SetPrimaryPartCFrame(p_u_3.Rig.PrimaryPart.CFrame)
		v_u_11.Parent = workspace.Misc
		local v12 = v_u_2:LoadAnimationFromID(v_u_11, p_u_3.Config.Animations.Execution.ZombieRig, true)
		v12:Play(0)
		v12.TimePosition = tick() - v10
		task.delay(2, function()
			-- upvalues: (copy) v_u_6, (copy) v_u_8, (copy) p_u_4, (copy) p_u_3, (copy) v_u_11
			if v_u_6 then
				local v13 = v_u_8.AddProfile
				local v14 = p_u_4
				local v15 = {
					["Velocity"] = p_u_3.Rig.PrimaryPart.CFrame.LookVector.Unit * 35,
					["KillEffects"] = {
						["HeadSquash"] = true
					}
				}
				v13(v14, v15)
				local v16 = {
					["Velocity"] = Vector3.new(0, 50, 0),
					["KillEffects"] = {
						["HeadSquash"] = true
					}
				}
				v_u_8.AddProfile(v_u_11, v16)
				local v17 = v_u_11:FindFirstChild("Humanoid")
				v_u_6.Health = 0
				v17.Health = 0
				task.delay(0.05, function()
					-- upvalues: (ref) v_u_11
					v_u_11:Destroy()
				end)
			end
		end)
	end
end
function v1.GetRig(_, p_u_18)
	local v_u_19 = p_u_18.Rig:Clone()
	v_u_19:SetPrimaryPartCFrame(CFrame.new(0, 100000, 0))
	local v20
	if v_u_19 then
		v20 = v_u_19.PrimaryPart
	else
		v20 = v_u_19
	end
	if v20 then
		v20.Anchored = true
	end
	v_u_19.Parent = workspace
	pcall(function()
		-- upvalues: (copy) p_u_18, (copy) v_u_19
		local v21 = game.Players:GetHumanoidDescriptionFromUserId(p_u_18.Player.UserId)
		v_u_19.Humanoid:ApplyDescription(v21, Enum.AssetTypeVerification.Always)
		for _, v22 in pairs(v_u_19:GetChildren()) do
			if v22:IsA("CharacterMesh") and v22.MeshId ~= 48112070 then
				v22:Destroy()
			end
		end
		v_u_19.ExtraModels.HaxxedCrown.Color = v21.TorsoColor
		v_u_19.ExtraModels.GlowyTorso.Attachment.PointLight.Color = v21.TorsoColor
		for _, v23 in pairs(v_u_19:GetDescendants()) do
			if v23:IsA("ParticleEmitter") and (v23.Name == "Number" or v23.Name == "Aura") then
				v23.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v21.TorsoColor), ColorSequenceKeypoint.new(1, v21.TorsoColor) })
			end
		end
	end)
	return v_u_19
end
return v1