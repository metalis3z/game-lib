-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

return {
	["CreatedPost"] = function(_, p_u_1)
		if game:GetService("RunService"):IsServer() then
			local v_u_2 = p_u_1.Rig.Humanoid
			local v_u_3 = v_u_2.Health
			local v_u_4 = true
			v_u_2:GetPropertyChangedSignal("Health"):Connect(function()
				-- upvalues: (copy) v_u_2, (ref) v_u_3, (ref) v_u_4, (copy) p_u_1
				if v_u_2.Health < v_u_3 and (v_u_4 and (p_u_1.Rig:FindFirstChild("Life1") and (p_u_1.Rig.Life1:FindFirstChild("Torso") and p_u_1.Rig.Life1.Torso:FindFirstChild("ouch")))) then
					v_u_4 = false
					p_u_1.Rig.Life1.Torso.ouch:Play()
					task.delay(1, function()
						-- upvalues: (ref) v_u_4
						v_u_4 = true
					end)
				end
				v_u_3 = v_u_2.Health
			end)
		end
	end
}
