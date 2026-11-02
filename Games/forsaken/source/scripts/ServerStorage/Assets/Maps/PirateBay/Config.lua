-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v10 = {
	["DisplayName"] = "Pirate Bay",
	["Description"] = "Those who Code",
	["Render"] = "rbxassetid://114348798781867",
	["Ambience"] = "rbxassetid://74727058288514",
	["AmbienceProperties"] = {
		["Volume"] = 0.5
	},
	["Created"] = function(p_u_1)
		local v_u_2 = 0
		p_u_1.Connection = game["Run Service"].Heartbeat:Connect(function(p3)
			-- upvalues: (copy) p_u_1, (ref) v_u_2
			if p_u_1.Map.Parent or not p_u_1.Connection then
				v_u_2 = v_u_2 + p3
				if v_u_2 >= 0.25 then
					for _, v4 in pairs(p_u_1.Map.MAP.BigBadBleed:GetChildren()) do
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
								local v9 = require(game.ReplicatedStorage.Modules.Statuses)
								if not v9:PlayerHasStatus(v7, "Bleeding") then
									v9:ApplyStatus(v7, "Bleeding", {
										["Level"] = 1,
										["Duration"] = 4
									})
								end
							end
						end
					end
				end
			else
				p_u_1.Connection:Disconnect()
			end
		end)
	end
}
return v10
