-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
require(game.ReplicatedStorage.Modules.Sounds)
require(game.ReplicatedStorage.Modules.Util)
require(game.ReplicatedStorage.Modules.Hitboxes)
require(game.ReplicatedStorage.Modules.Statuses)
require(game.ReplicatedStorage.Modules.Network)
local v_u_2 = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
local v_u_3 = game:GetService("TweenService")
function v1.SummonZombie(_, p4)
	if p4 then
		if p4.PrimaryPart then
			if not p4.PrimaryPart:FindFirstChild("Radius") then
				return
			end
			p4.PrimaryPart.Radius:Play()
		end
	end
end
function v1.OnIntroduction(_, p5, _, p6)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local _ = game.Players.LocalPlayer
	v_u_2:SetCustomLighting(p5.Config.IntroLighting)
	task.spawn(function()
		-- upvalues: (ref) v_u_3
		local v_u_7 = script.IntroScreen:Clone()
		v_u_7.Parent = game.Players.LocalPlayer.PlayerGui
		game.TweenService:Create(v_u_7.Main.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
			["ImageTransparency"] = 0
		}):Play()
		game.Debris:AddItem(v_u_7, 2)
		task.delay(0.92, function()
			-- upvalues: (copy) v_u_7
			game.TweenService:Create(v_u_7.Main.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quart), {
				["ImageTransparency"] = 1
			}):Play()
		end)
		local v8 = workspace.CurrentCamera
		v8.FieldOfView = 30
		game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true)
		task.wait(0.92)
		v_u_3:Create(v8, TweenInfo.new(1.2), {
			["FieldOfView"] = 50
		}):Play()
		task.wait(1.2)
		v_u_3:Create(v8, TweenInfo.new(1.38), {
			["FieldOfView"] = 25
		}):Play()
		task.wait(1.38)
		v_u_3:Create(v8, TweenInfo.new(1.03, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			["FieldOfView"] = 60
		}):Play()
		task.wait(1.03)
		v_u_3:Create(v8, TweenInfo.new(0.42, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			["FieldOfView"] = 0
		}):Play()
	end)
	task.delay(p6, function()
		-- upvalues: (ref) v_u_2
		v_u_2:SetAsCurrentLighting()
		game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil)
	end)
end
function v1.OnExecution(_, p_u_9, p_u_10)
	local v11 = p_u_10:FindFirstChild("Sword")
	local v_u_12 = p_u_10:FindFirstChild("Humanoid")
	p_u_10:FindFirstChild("Head")
	local v_u_13 = require(game.ReplicatedStorage.Modules.Ragdolls)
	if p_u_10.Name == "Shedletsky" then
		v11.Transparency = 0
		local _ = workspace:GetServerTimeNow() + 4.17
		task.delay(4.17, function()
			-- upvalues: (copy) v_u_12, (copy) v_u_13, (copy) p_u_10, (copy) p_u_9
			if v_u_12 then
				v_u_13.AddProfile(p_u_10, {
					["Velocity"] = p_u_9.Rig.PrimaryPart.CFrame.LookVector.Unit * 35
				})
				v_u_12.Health = 0
			end
		end)
	else
		local _ = workspace:GetServerTimeNow() + 1.89
		task.delay(1.89, function()
			-- upvalues: (copy) v_u_12, (copy) v_u_13, (copy) p_u_10, (copy) p_u_9
			if v_u_12 then
				v_u_13.AddProfile(p_u_10, {
					["Velocity"] = p_u_9.Rig.PrimaryPart.CFrame.LookVector.Unit * 35
				})
				v_u_12.Health = 0
			end
		end)
	end
end
return v1