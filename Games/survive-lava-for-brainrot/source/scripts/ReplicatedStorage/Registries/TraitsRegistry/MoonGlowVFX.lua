-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("RunService")
local v_u_2 = script:WaitForChild("The Moon")
return function(p_u_3)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	if p_u_3 then
		local v_u_4 = v_u_2:Clone()
		local v_u_5 = nil
		local function v14(_)
			-- upvalues: (copy) p_u_3, (ref) v_u_5, (copy) v_u_4
			if p_u_3:IsDescendantOf(game) then
				if p_u_3.PrimaryPart then
					v_u_4.Parent = workspace
					local v6 = os.clock()
					local v7 = v6 * 2
					local v8 = math.cos(v7) * 4
					local v9 = v6 * 2
					local v10 = math.sin(v9) * 4
					local v11 = v6 * 2
					local v12 = math.sin(v11)
					local v13 = CFrame.Angles(0, v6 * 4, 0)
					v_u_4:PivotTo(p_u_3.PrimaryPart.CFrame * CFrame.new(v8, v12, v10) * v13)
				else
					v_u_4.Parent = script
				end
			else
				if v_u_5 and v_u_5 then
					warn("done")
					v_u_5:Disconnect()
					v_u_5 = nil
					v_u_4:Destroy()
				end
				return
			end
		end
		v_u_5 = v_u_1.Heartbeat:Connect(v14)
		p_u_3.Destroying:Once(function()
			-- upvalues: (ref) v_u_5, (copy) v_u_4
			if v_u_5 then
				warn("done")
				v_u_5:Disconnect()
				v_u_5 = nil
				v_u_4:Destroy()
			end
		end)
	end
end
