-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v_u_2 = game:GetService("TweenService")
require(game.ReplicatedStorage.Modules.Sounds)
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
require(game.ReplicatedStorage.Modules.Hitboxes)
require(game.ReplicatedStorage.Modules.Statuses)
require(game.ReplicatedStorage.Modules.Network)
function v1.OnIntroduction(_, p4, _, p5)
	local v6 = require(game.ReplicatedStorage.Modules.Util):CreateFOVMultiplier(game.Players.LocalPlayer, 0.8, "BetrayedIntroScene")
	game.Debris:AddItem(v6, p5)
	local v_u_7 = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
	v_u_7:SetCustomLighting(p4.Config.IntroLighting)
	task.delay(p5, function()
		-- upvalues: (copy) v_u_7
		v_u_7:SetAsCurrentLighting()
	end)
end
function v1.OnExecution(_, p8, p_u_9)
	local v_u_10 = require(game.ReplicatedStorage.Modules.Ragdolls)
	local v_u_11 = p_u_9:FindFirstChild("Humanoid")
	local v_u_12 = p8.Rig.PrimaryPart.CFrame.LookVector.Unit * 200
	local v_u_13 = p8.Rig.HumanoidRootPart.Execute
	local v14 = p_u_9:FindFirstChild("Sword")
	if p_u_9.Name == "Shedletsky" then
		v14.Transparency = 0
		local _ = workspace:GetServerTimeNow() + 3.23
		task.delay(1.78, function()
			-- upvalues: (copy) v_u_11, (copy) v_u_10, (copy) p_u_9
			if v_u_11 then
				v_u_10.AddProfile(p_u_9, {
					["Velocity"] = Vector3.new(0, 50, 0)
				})
				v_u_11.Health = 0
				for _, v15 in ipairs(p_u_9 and p_u_9:GetChildren() or {}) do
					if v15:IsA("Accessory") then
						v15:Destroy()
					end
				end
			end
		end)
		task.delay(1.72, function()
			-- upvalues: (copy) v_u_13
			for _, v16 in v_u_13:GetDescendants() do
				if v16:IsA("ParticleEmitter") then
					v16:Emit(v16.Name == "Number" and 30 or 2)
				end
			end
		end)
	else
		task.delay(1.5, function()
			-- upvalues: (copy) v_u_11, (copy) v_u_10, (copy) p_u_9, (copy) v_u_12
			if v_u_11 then
				local v17 = {
					["Velocity"] = v_u_12
				}
				v_u_10.AddProfile(p_u_9, v17)
				v_u_11.Health = 0
			end
		end)
	end
end
function v1.EntangleStart(p18)
	local v_u_19 = p18.Rig.HumanoidRootPart.Entangle
	task.delay(0.5, function()
		-- upvalues: (copy) v_u_19
		for _, v20 in v_u_19:GetDescendants() do
			if v20:IsA("ParticleEmitter") then
				v20:Emit(v20.Name == "Number" and 30 or 2)
			end
		end
	end)
end
function v1.OnVictory(_, p21, p22, _, _)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v23 = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
	if p21 == "Start" then
		v23:SetCustomLighting(p22.Config.OutroLighting)
		task.delay(3.1, function()
			-- upvalues: (ref) v_u_2
			local v24 = Instance.new("ColorCorrectionEffect", game.Lighting)
			v24.Name = "JohnDoeStabCC"
			local v25 = v_u_2:Create(v24, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				["Contrast"] = 0.4,
				["Brightness"] = 0.1
			})
			v25:Play()
			task.wait(0.3)
			v25:Pause()
			task.wait(0.1)
			v24.Brightness = 6
			v24.Contrast = 1
			v24.TintColor = Color3.new(0, 0.129412, 0.364706)
			v_u_2:Create(v24, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				["TintColor"] = Color3.new(0, 0, 0),
				["Brightness"] = 5,
				["Contrast"] = 1,
				["Saturation"] = -1
			}):Play()
		end)
	elseif p21 == "End" then
		v23:SetAsCurrentLighting()
		local v26 = v_u_3:CreateFOVMultiplier(game.Players.LocalPlayer, 1, "JohnDoeOutroScene")
		game.Debris:AddItem(v26, 1)
		local v27 = game.Lighting:WaitForChild("JohnDoeStabCC", 8)
		if v27 then
			v27:Destroy()
		end
	end
end
return v1