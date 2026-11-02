-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
game:GetService("RunService")
require(game.ReplicatedStorage.Modules.Sounds)
require(game.ReplicatedStorage.Modules.Util)
require(game.ReplicatedStorage.Modules.Hitboxes)
require(game.ReplicatedStorage.Modules.Statuses)
require(game.ReplicatedStorage.Modules.Schematics.Lighting)
local v_u_2 = require(game.ReplicatedStorage.Modules.Ragdolls)
function v1.OnExecution(_, p_u_3, p_u_4)
	-- upvalues: (copy) v_u_2
	local v_u_5 = p_u_4:FindFirstChild("Humanoid")
	if v_u_5 then
		if p_u_4.Name == "Shedletsky" then
			task.delay(2.2, function()
				-- upvalues: (copy) v_u_5, (copy) p_u_3, (ref) v_u_2, (copy) p_u_4
				if v_u_5 then
					local v6 = p_u_3.Rig.PrimaryPart.CFrame
					v_u_2.AddProfile(p_u_4, {
						["Velocity"] = v6.LookVector * 15 + v6.RightVector * 30,
						["Applied"] = (1 / 0)
					})
					v_u_5.Health = 0
				end
			end)
		else
			task.delay(1.6, function()
				-- upvalues: (ref) v_u_2, (copy) p_u_4, (copy) p_u_3, (copy) v_u_5
				local v7 = v_u_2.AddProfile
				local v8 = p_u_4
				local v9 = {
					["Velocity"] = p_u_3.Rig.PrimaryPart.CFrame.LookVector * 30,
					["KillEffects"] = {
						["Decapitate"] = true
					},
					["Applied"] = (1 / 0)
				}
				v7(v8, v9)
				v_u_5.Health = 0
			end)
		end
	else
		return
	end
end
function v1.EntangleStart(p10)
	local v_u_11 = p10.Rig
	if v_u_11 then
		for _, v12 in ipairs({ "KunaiA", "KunaiB", "KunaiC" }) do
			local v13 = v_u_11:FindFirstChild("Left Arm"):FindFirstChild(v12)
			if v13 then
				v13.Transparency = 0
				for _, v14 in ipairs(v13:GetChildren()) do
					if v14:IsA("ParticleEmitter") then
						v14.Enabled = true
						v14:Emit(20)
					elseif v14:IsA("Trail") then
						v14.Enabled = true
					elseif v14:IsA("PointLight") then
						v14.Enabled = true
					end
				end
			end
		end
		task.delay(1.3, function()
			-- upvalues: (copy) v_u_11
			for _, v15 in ipairs({ "KunaiA", "KunaiB", "KunaiC" }) do
				local v16 = v_u_11:FindFirstChild("Left Arm"):FindFirstChild(v15)
				if v16 then
					v16.Transparency = 1
					for _, v17 in ipairs(v16:GetChildren()) do
						if v17:IsA("ParticleEmitter") then
							v17.Enabled = false
						elseif v17:IsA("Trail") then
							v17.Enabled = false
						elseif v17:IsA("PointLight") then
							v17.Enabled = false
						end
					end
				end
			end
		end)
	end
end
return v1