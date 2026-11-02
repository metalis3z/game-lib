-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v12 = {
	["DisplayName"] = "Yorick\'s Resting Place",
	["Description"] = "\"Sorry, but the skull is in another castle...just kidding!\"",
	["Render"] = "rbxassetid://131087067611316",
	["Ambience"] = "rbxassetid://97186231698797",
	["AmbienceProperties"] = {
		["Volume"] = 0.5
	},
	["Created"] = function(p_u_1)
		local v_u_2 = 0
		p_u_1.Connection = game["Run Service"].Heartbeat:Connect(function(p3)
			-- upvalues: (copy) p_u_1, (ref) v_u_2
			if p_u_1.Map.Parent then
				v_u_2 = v_u_2 + p3
				if v_u_2 >= 0.25 then
					for _, v4 in pairs(p_u_1.Map.AcidContainer.Acid:GetChildren()) do
						local v5 = workspace:GetPartBoundsInBox(v4.CFrame, v4.Size)
						for _, v6 in pairs(v5) do
							local v7 = v6:FindFirstAncestorOfClass("Model")
							local v8
							if v7 then
								v8 = v7:FindFirstChild("Humanoid")
							else
								v8 = v7
							end
							if v8 then
								require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(v7, "Poisoned", {
									["Level"] = 1,
									["Duration"] = 8
								})
							end
						end
					end
				end
			else
				p_u_1.Connection:Disconnect()
			end
		end)
		task.spawn(function()
			-- upvalues: (copy) p_u_1
			local v9 = p_u_1.Map.Conveyors
			while task.wait(0.1) and v9.Parent do
				for _, v10 in pairs(v9:GetChildren()) do
					v10.AssemblyLinearVelocity = v10.CFrame.LookVector * 50
				end
			end
		end)
	end,
	["Destroyed"] = function(p11)
		if p11.Connection then
			p11.Connection:Disconnect()
		end
	end
}
return v12
