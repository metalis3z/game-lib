-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = script.ScarfAnimation
local v2 = {}
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
function v2.CreatedPost(_, p_u_4)
	-- upvalues: (copy) v_u_1
	if game["Run Service"]:IsClient() then
		task.spawn(function()
			-- upvalues: (copy) p_u_4, (ref) v_u_1
			local v5 = p_u_4.Rig
			if v5 then
				local v6 = v5:FindFirstChild("4D_Cube")
				if not v6 then
					return
				end
				v6:FindFirstChildOfClass("AnimationController").Animator:LoadAnimation(v_u_1):Play()
			end
		end)
	end
end
function v2.OnExecution(_, p_u_7, p_u_8)
	-- upvalues: (copy) v_u_3
	local v9 = p_u_8:FindFirstChild("Sword")
	local v_u_10 = p_u_8:FindFirstChild("Humanoid")
	local v_u_11 = p_u_8:FindFirstChild("Head")
	local v_u_12 = require(game.ReplicatedStorage.Modules.Ragdolls)
	if p_u_8.Name == "Shedletsky" then
		v9.Transparency = 0
		local _ = workspace:GetServerTimeNow() + 3.23
		task.delay(2.84, function()
			-- upvalues: (copy) v_u_10, (copy) v_u_12, (copy) p_u_8, (copy) v_u_11
			if v_u_10 then
				v_u_12.AddProfile(p_u_8, {
					["Velocity"] = Vector3.new(0, 50, 0),
					["KillEffects"] = {
						["HeadSquash"] = true
					}
				})
				v_u_10.Health = 0
				for _, v13 in ipairs(p_u_8 and p_u_8:GetChildren() or {}) do
					if v13:IsA("Accessory") then
						v13:Destroy()
					end
				end
				if v_u_11 then
					v_u_11:Destroy()
				end
			end
		end)
	else
		local _ = workspace:GetServerTimeNow() + 2
		local v14 = tick()
		local v_u_15 = p_u_7.Config.ZombieTemplate:Clone()
		v_u_15.Name = "OutroZombie"
		v_u_15.PrimaryPart.Anchored = true
		v_u_15:SetPrimaryPartCFrame(p_u_7.Rig.PrimaryPart.CFrame)
		v_u_15.Parent = workspace.Misc
		local v16 = v_u_3:LoadAnimationFromID(v_u_15, p_u_7.Config.Animations.Execution.ZombieRig, true)
		v16:Play(0)
		v16.TimePosition = tick() - v14
		task.delay(2, function()
			-- upvalues: (copy) v_u_10, (copy) v_u_12, (copy) p_u_8, (copy) p_u_7, (copy) v_u_15
			if v_u_10 then
				local v17 = v_u_12.AddProfile
				local v18 = p_u_8
				local v19 = {
					["Velocity"] = p_u_7.Rig.PrimaryPart.CFrame.LookVector.Unit * 35,
					["KillEffects"] = {
						["HeadSquash"] = true
					}
				}
				v17(v18, v19)
				local v20 = {
					["Velocity"] = Vector3.new(0, 50, 0),
					["KillEffects"] = {
						["HeadSquash"] = true
					}
				}
				v_u_12.AddProfile(v_u_15, v20)
				local v21 = v_u_15:FindFirstChild("Humanoid")
				v_u_10.Health = 0
				v21.Health = 0
				task.delay(0.05, function()
					-- upvalues: (ref) v_u_15
					v_u_15:Destroy()
				end)
			end
		end)
	end
end
return v2