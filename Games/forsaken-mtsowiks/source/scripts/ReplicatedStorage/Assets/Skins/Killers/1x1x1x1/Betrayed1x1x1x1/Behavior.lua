-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
require(game.ReplicatedStorage.Modules.Sounds)
require(game.ReplicatedStorage.Modules.Util)
require(game.ReplicatedStorage.Modules.Hitboxes)
require(game.ReplicatedStorage.Modules.Statuses)
require(game.ReplicatedStorage.Modules.Network)
function v1.OnIntroduction(_, p2, _, p3)
	local v4 = require(game.ReplicatedStorage.Modules.Util):CreateFOVMultiplier(game.Players.LocalPlayer, 0.35, "BetrayedIntroScene")
	game.Debris:AddItem(v4, p3)
	local v_u_5 = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
	v_u_5:SetCustomLighting(p2.Config.IntroLighting)
	task.delay(p3, function()
		-- upvalues: (copy) v_u_5
		v_u_5:SetAsCurrentLighting()
	end)
end
function v1.OnExecution(_, p6, p_u_7)
	local v_u_8 = require(game.ReplicatedStorage.Modules.Ragdolls)
	local v_u_9 = p_u_7:FindFirstChild("Humanoid")
	local v_u_10 = p6.Rig.PrimaryPart.CFrame.LookVector.Unit * 200
	task.delay(1.57, function()
		-- upvalues: (copy) v_u_9, (copy) v_u_8, (copy) p_u_7, (copy) v_u_10
		if v_u_9 then
			local v11 = {
				["Velocity"] = v_u_10
			}
			v_u_8.AddProfile(p_u_7, v11)
			v_u_9.Health = 0
		end
	end)
end
return v1