-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Util)
local v_u_3 = require(game.ReplicatedStorage.Modules.Schematics.Achievements)
local function v_u_13(p_u_4, p_u_5)
	if p_u_5 then
		if p_u_4 then
			local v_u_6 = game:GetService("BadgeService")
			local v7, v8 = pcall(function()
				-- upvalues: (copy) v_u_6, (copy) p_u_5
				return v_u_6:GetBadgeInfoAsync(p_u_5)
			end)
			if v7 then
				if v8.IsEnabled then
					local v9, v10 = pcall(function()
						-- upvalues: (copy) v_u_6, (copy) p_u_4, (copy) p_u_5
						return v_u_6:UserHasBadgeAsync(p_u_4.UserId, p_u_5)
					end)
					if v9 and v10 then
						warn((("[AchievementUtil/awardBadge]: Player: %* already owns the badge: %*"):format(p_u_4, p_u_5)))
						return
					end
					local v11, v12 = pcall(function()
						-- upvalues: (copy) v_u_6, (copy) p_u_4, (copy) p_u_5
						return v_u_6:AwardBadge(p_u_4.UserId, p_u_5)
					end)
					if not v11 then
						warn("Error while awarding badge:", v12)
						return
					end
					if not v12 then
						return
					end
				end
			else
				warn("Error while fetching badge info: " .. v8)
			end
		end
	else
		return
	end
end
local function v_u_29(p14)
	-- upvalues: (copy) v_u_1
	if not p14 then
		return
	end
	if typeof(p14) ~= "Instance" then
		return
	end
	if not p14:IsA("Player") then
		return
	end
	local v15 = p14:WaitForChild("PlayerData")
	if not v15 then
		return
	end
	if not v15:FindFirstChild("Achievements") then
		return
	end
	local v16 = v15:FindFirstChild("AchievementsData")
	if not v16 then
		return
	end
	for _, v17 in ipairs(v16:GetChildren()) do
		local v18 = ""
		for v19 in v17.Name:gmatch(".") do
			if v19 == "_" then
				break
			end
			v18 = v18 .. v19
		end
		local v20, v21 = v_u_1:GetAchievementData(v18)
		if v20 then
			local v22 = v_u_1:GetAchievementDataValue(p14, v21, v18)
			if v22 then
				local v23 = v20.RewardType
				local v24 = tostring(v23)
				if v17:IsA("BoolValue") and v17.Name == v18 .. "_" .. v24 then
					if v22:IsA("BoolValue") and not v22.Value then
						v22.Value = true
					elseif v22:IsA("IntValue") and v20.Requirement then
						local v25 = v20.Requirement
						local v26 = typeof(v25) == "function" and v20.Requirement(p14) or v20.Requirement
						if v22.Value < v26 then
							v22.Value = v26
						end
					end
				end
			else
				local v27 = ("Achievement ValueBase for %* not found."):format(v18)
				warn("[AchievementUtil]: " .. v27)
			end
		else
			local v28 = ("Achievement data for %* not found."):format(v18)
			warn("[AchievementUtil]: " .. v28)
		end
	end
end
local function v_u_49(p30, p31)
	-- upvalues: (copy) v_u_3, (copy) v_u_1, (copy) v_u_13, (copy) v_u_2
	if p30 then
		if typeof(p30) == "Instance" then
			if p30:IsA("Player") then
				if workspace:GetAttribute("ServerType") ~= "VIP" then
					for v32, v33 in pairs(v_u_3) do
						local v34 = v33.Achievements
						if v34 then
							v34 = v33.Achievements[p31]
						end
						if v34 then
							if not v_u_1:GetAchievementDataValue(p30, v32, p31) then
								return
							end
							local v35 = p30:FindFirstChild("PlayerData")
							if not v35 then
								return
							end
							v_u_13(p30, v34.BadgeID)
							local v36 = tostring(p31)
							local v37 = v34.RewardType
							local v38 = ("%*_%*"):format(v36, (tostring(v37)))
							local v39 = false
							if v35.AchievementsData:FindFirstChild(v38) then
								v39 = true
							else
								local v40 = Instance.new("BoolValue")
								v40.Value = true
								v40.Name = v38
								v40.Parent = v35.AchievementsData
							end
							if not v39 then
								require(game.ReplicatedStorage.Modules.Network):FireClientConnection(p30, "AchievementCompleted", "REMOTE_EVENT", p31)
							end
							if v34.RewardType == "Currency" then
								if not v39 then
									local v41 = v34.Amount
									local v42 = tonumber(v41)
									if v42 then
										v_u_2:AddToPlayerStat(p30, "Money", v42)
										return true
									end
									warn((("%* has no RewardAmount!!! fix asap pls"):format(p31)))
								end
							end
							if v34.RewardType == "Emote" or v34.RewardType == "Skin" then
								local v43 = v34.Skins or (v34.Emotes or {})
								local v44 = v34.Skin
								table.insert(v43, v44)
								local v45 = v34.Emote
								table.insert(v43, v45)
								for _, v46 in pairs(v43) do
									if v46 then
										local v47 = v35:FindFirstChild("Purchased")
										if v47 then
											v47 = v35.Purchased:FindFirstChild((("%*s"):format(v34.RewardType)))
										end
										if v47 and not v47:FindFirstChild(v46) then
											local v48 = Instance.new("IntValue")
											v48.Value = 0
											v48.Name = v46
											v48.Parent = v47
										end
									end
								end
								return true
							end
						end
					end
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
function v_u_1.GetAchievementData(_, p50)
	-- upvalues: (copy) v_u_3
	for v51, v52 in pairs(v_u_3) do
		local v53 = v52.Achievements
		if v53 then
			v53 = v52.Achievements[p50]
		end
		if v53 then
			return v53, v51
		end
	end
end
function v_u_1.GetAchievementDataValue(_, p54, p55, p56)
	if p54 then
		if typeof(p54) == "Instance" then
			if p54:IsA("Player") then
				local v57 = p54:FindFirstChild("PlayerData")
				if v57 then
					if p56 then
						local v58 = v57.Achievements:FindFirstChild((tostring(p55)))
						if v58 then
							v58 = v58:FindFirstChild((tostring(p56)))
						end
						return v58
					end
					if p55 then
						local v59 = v57.Achievements
						if v59 then
							v59 = v57.Achievements:FindFirstChild(tostring(p55), true)
						end
						return v59
					end
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
function v_u_1.IncrementAchievementProgress(_, p60, p61, p62)
	-- upvalues: (copy) v_u_3, (copy) v_u_1, (copy) v_u_49
	if p60 then
		if typeof(p60) == "Instance" then
			if p60:IsA("Player") then
				if workspace:GetAttribute("ServerType") ~= "VIP" then
					for v63, v64 in pairs(v_u_3) do
						local v65 = v64.Achievements
						if v65 then
							v65 = v64.Achievements[p61]
						end
						if v65 then
							local v66 = v_u_1:GetAchievementDataValue(p60, v63, p61)
							if v66 then
								if p62 then
									local v67 = p60:FindFirstChild("PlayerData")
									if not v67 then
										return
									end
									local v68 = ("%*_%*"):format(p61, p62)
									if v67.AchievementsData:FindFirstChild(v68) then
										return
									end
									local v69 = Instance.new("BoolValue")
									v69.Value = true
									v69.Name = v68
									v69.Parent = v67.AchievementsData
								end
								if v66:IsA("BoolValue") and not v66.Value then
									v66.Value = true
									v_u_49(p60, p61)
								elseif v66:IsA("IntValue") and v65.Requirement then
									local v70 = v65.Requirement
									local v71 = typeof(v70) == "function" and v65.Requirement(p60) or v65.Requirement
									if v66.Value < v71 then
										v66.Value = v66.Value + 1
										if v71 <= v66.Value then
											v_u_49(p60, p61)
										end
									end
								end
								return true
							end
							return
						end
					end
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
function v_u_1.QueryAchievement(_, p72, p73, p74)
	-- upvalues: (copy) v_u_3, (copy) v_u_1
	if p72 then
		local v75 = nil
		for _, v76 in pairs(v_u_3) do
			v75 = v76.Achievements
			if v75 then
				v75 = v76.Achievements[p72]
			end
			if v75 then
				break
			end
		end
		if v75 then
			v75 = v75.Callback
		end
		if v75 then
			local v77, v78 = pcall(v75, p74)
			if v77 then
				if v78 == true and p73 then
					v_u_1:IncrementAchievementProgress(p73, p72)
					return v78
				else
					if typeof(v78) == "table" then
						for _, v79 in pairs(v78) do
							v_u_1:IncrementAchievementProgress(v79, p72)
						end
					end
					return v78
				end
			else
				warn((("Failed to query achievement %*! %*"):format(p72, v78)))
				return v78
			end
		else
			warn((("No callback found for achievement %*!"):format(p72)))
			return
		end
	else
		return
	end
end
function v_u_1.Start(_)
	-- upvalues: (copy) v_u_49, (copy) v_u_29, (copy) v_u_1
	if not game["Run Service"]:IsClient() then
		local v80 = require(game.ReplicatedStorage.Modules.Util)
		local v_u_81 = require(game.ReplicatedStorage.Modules.Schematics.Achievements)
		v80.OnPlayerAdded(function(p_u_82)
			-- upvalues: (copy) v_u_81, (ref) v_u_49, (ref) v_u_29
			local v83 = p_u_82:WaitForChild("PlayerData", 30)
			if v83 then
				local v84 = v83.Achievements
				for _, v_u_85 in pairs(v84:GetChildren()) do
					for _, v_u_86 in pairs(v_u_85:GetChildren()) do
						local function v90()
							-- upvalues: (ref) v_u_81, (copy) v_u_85, (copy) v_u_86, (copy) p_u_82, (ref) v_u_49
							local v87 = v_u_81[v_u_85.Name] and v_u_81[v_u_85.Name].Achievements
							if v87 then
								v87 = v_u_81[v_u_85.Name].Achievements[v_u_86.Name]
							end
							if v87 then
								local v88 = v87.Requirement
								local v89 = typeof(v88) == "function" and v87.Requirement(p_u_82) or v87.Requirement
								if v_u_86:IsA("IntValue") and (v89 and v89 <= v_u_86.Value) or v_u_86:IsA("BoolValue") and v_u_86.Value then
									v_u_49(p_u_82, v_u_86.Name)
								end
							end
						end
						v_u_86:GetPropertyChangedSignal("Value"):Connect(v90)
						v90()
					end
				end
				v_u_29(p_u_82)
			end
		end)
		require(game.ReplicatedStorage.Modules.Network):SetConnection("UnlockAchievement", "REMOTE_EVENT", function(p91, p92)
			-- upvalues: (copy) v_u_81, (ref) v_u_1
			for _, v93 in pairs(v_u_81) do
				local v94 = v93.Achievements
				if v94 then
					v94 = v93.Achievements[p92]
				end
				if v94 and v94.Clientsided then
					v_u_1:IncrementAchievementProgress(p91, p92)
				end
			end
		end)
	end
end
return v_u_1
