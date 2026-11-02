-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("Players")
local v1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
require(v1.Modules.Misc.Trove)
require(v1.Modules.Util)
require(v1.Modules.Thread)
return {
	["OnExecution"] = function(_, _, p_u_2)
		local v_u_3 = p_u_2:FindFirstChild("Humanoid")
		local v4 = require(game.ReplicatedStorage.Modules.Ragdolls)
		local v5 = p_u_2.Name == "Shedletsky"
		local v6 = v5 and 0.7833333333333333 or 2.066666666666667
		local v7
		if v5 then
			v7 = {
				["AnchorDelay"] = true,
				["Applied"] = os.clock() + 5,
				["Velocity"] = p_u_2.PrimaryPart.CFrame.RightVector.Unit * 150,
				["KillEffects"] = {
					["Decapitate"] = true
				}
			}
		else
			v7 = {
				["AnchorDelay"] = true,
				["Applied"] = os.clock() + 5,
				["Velocity"] = p_u_2.PrimaryPart.CFrame.RightVector.Unit * -150
			}
		end
		v4.AddProfile(p_u_2, v7)
		task.delay(v6, function()
			-- upvalues: (copy) v_u_3, (copy) p_u_2
			if v_u_3 then
				p_u_2:FindFirstChild("Humanoid").Health = 0
				if p_u_2 and p_u_2.PrimaryPart then
					p_u_2.PrimaryPart.Anchored = false
				end
			end
		end)
	end
}