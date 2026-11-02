-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["SpawnProjectiles"] = function(p_u_1)
		local v2 = p_u_1.root
		local v_u_3 = p_u_1.projectile
		local v_u_4 = p_u_1.onHit or function() end
		local v_u_5 = p_u_1.tickFunc or function() end
		local v6 = p_u_1.count or 1
		local v7 = p_u_1.spreadRadius or 5
		local v8 = p_u_1.startHeight or 5
		local v_u_9 = p_u_1.duration or 1
		local v_u_10 = p_u_1.arcHeight or 10
		local v11 = p_u_1.evenlySpaced or false
		local v_u_12 = p_u_1.rotate or false
		local v13 = p_u_1.spawnDelay or 0
		local v_u_14 = p_u_1.lifetime or 1
		local v15 = p_u_1.YOffset or 0
		
		local v_u_16 = v2.Position + Vector3.new(0, v8, 0)
		for v17 = 1, v6 do
			local v18
			if v11 then
				local v19 = v17 / v6 * 3.141592653589793 * 2
				local v20 = math.cos(v19) * v7
				local v21 = math.sin(v19) * v7
				v18 = Vector3.new(v20, 0, v21)
			else
				local v22 = math.random(-v7, v7)
				local v23 = math.random
				local v24 = -v7
				v18 = Vector3.new(v22, 0, v23(v24, v7))
			end
			if v15 then
				local v25 = v18.X
				local v26 = math.random(-v15, v15)
				local v27 = v18.Z
				v18 = Vector3.new(v25, v26, v27)
			end
			local v_u_28 = v2.Position + v18
			local v29 = math.random() * v13
			task.delay(v29, function()
				-- upvalues: (copy) v_u_3, (copy) v_u_16, (copy) p_u_1, (ref) v_u_10, (copy) v_u_28, (ref) v_u_9, (copy) v_u_4, (copy) v_u_14, (copy) v_u_5, (copy) v_u_12
				local v_u_30 = v_u_3:Clone()
				v_u_30.CFrame = CFrame.new(v_u_16)
				v_u_30.Parent = workspace.IGNORE
				if p_u_1.arcHeightRandom then
					v_u_10 = math.random(p_u_1.arcHeightRandom[1], p_u_1.arcHeightRandom[2])
				end
				local v31 = v_u_10
				local v_u_32 = (v_u_16 + v_u_28) / 2 + Vector3.new(0, v31, 0)
				if p_u_1.durationRandom then
					v_u_9 = Random.new():NextNumber(p_u_1.durationRandom[1], p_u_1.durationRandom[2])
				end
				local v_u_33 = v_u_9 / 30
				local v_u_34 = 0
				local v_u_35 = nil
				v_u_35 = game:GetService("RunService").Heartbeat:Connect(function(p36)
					-- upvalues: (ref) v_u_34, (copy) v_u_33, (ref) v_u_35, (copy) v_u_30, (ref) v_u_4, (ref) v_u_14, (ref) v_u_5, (ref) v_u_16, (copy) v_u_32, (ref) v_u_28, (ref) v_u_12
					v_u_34 = v_u_34 + p36 / v_u_33
					if v_u_34 >= 30 then
						v_u_35:Disconnect()
						if v_u_30 and v_u_30.Parent then
							for _, v37 in ipairs(v_u_30:GetChildren()) do
								if v37:IsA("ParticleEmitter") then
									v37:Emit(v37:GetAttribute("EmitCount") or 30)
								end
							end
							v_u_4(v_u_30.Position, v_u_30)
							task.delay(v_u_14, function()
								-- upvalues: (ref) v_u_30
								if v_u_30 and v_u_30.Parent then
									v_u_30:Destroy()
								end
							end)
							return
						end
					else
						v_u_5(v_u_30)
						local v38 = v_u_34 / 30
						local v39 = v_u_16
						local v40 = v_u_32
						local v41 = v_u_28
						local v42 = (1 - v38) ^ 2 * v39 + 2 * (1 - v38) * v38 * v40 + v38 ^ 2 * v41
						v_u_30.CFrame = CFrame.new(v42)
						if v_u_12 then
							local v43 = (v_u_28 - v42).Unit
							v_u_30.CFrame = CFrame.new(v42, v42 + v43)
						end
					end
				end)
			end)
		end
	end
}