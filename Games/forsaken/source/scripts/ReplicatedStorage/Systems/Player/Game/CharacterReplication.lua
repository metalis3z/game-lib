-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = require(v1.Modules.Network)
local v_u_5 = require(v1.Modules.Util)
local v_u_6 = {}
local v_u_7 = game.Players.LocalPlayer
local v_u_8 = {}
local v_u_9 = {}
local v_u_10 = 0
local v_u_11 = os.clock()
function v_u_6.__onRenderSteppedOld(p12)
	-- upvalues: (ref) v_u_11, (copy) v_u_9, (copy) v_u_7
	if workspace:GetAttribute("ExperimentalReplication") then
		if os.clock() - v_u_11 <= 0.1 then
			local _ = os.clock() - v_u_11
			for v13, v14 in pairs(v_u_9) do
				if v13 ~= v_u_7 and (v13 and (v13.Parent and (v13.Character and (v13.Character.PrimaryPart and (v13.Character:HasTag("Replicating") and not v13.Character:GetAttribute("Ragdolling")))))) then
					local v15 = v13.Character:GetAttribute("ServerUPS") or 30
					if v15 < 7 then
						return
					end
					local v16 = v15 / 2
					local v17 = 10 ^ (-math.clamp(v16, 1, 10))
					local _ = v14.CFrameAtUpdate
					local v18 = v14.Timestamps
					if v18[#v18 - 1] then
						local v19 = v18[#v18].CFrame
						local v20
						if (v19.Position - v13.Character.PrimaryPart.Position).Magnitude > 30 then
							v20 = 1
						else
							local v21 = 1 - v17 ^ p12
							v20 = math.clamp(v21, 0, 1)
						end
						local v22 = v13.Character.PrimaryPart.Position:Lerp(v19.Position, v20)
						local v23 = v13.Character.PrimaryPart
						local v24 = CFrame.new(v22)
						local v25 = v13.Character.PrimaryPart.CFrame.Rotation
						local v26 = v19.Rotation
						local v27 = 1 - (v17 / 2.5) ^ p12
						v23.CFrame = v24 * v25:Lerp(v26, (math.clamp(v27, 0, 1)))
					end
				end
			end
		end
	else
		return
	end
end
function v_u_6.__onHeartbeat(p28)
	-- upvalues: (copy) v_u_3, (copy) v_u_7, (copy) v_u_5
	if workspace:GetAttribute("ExperimentalReplication") then
		for _, v29 in pairs(v_u_3:GetTagged("Replicating")) do
			if game.Players:GetPlayerFromCharacter(v29) and (v29 ~= v_u_7.Character and (not v29:GetAttribute("Ragdolling") and v_u_5:IsAlive(v29))) then
				local v30 = v29:FindFirstChild("QueryHitbox")
				if v30 then
					local v31 = (v29:GetAttribute("ServerUPS") or 30) / 2.5
					local v32 = 10 ^ (-math.clamp(v31, 3, 9))
					local v33 = 1 - v32 ^ p28
					local v34 = math.clamp(v33, 0, 1)
					local v35 = v30.CFrame
					local v36 = (v35.Position - v29.PrimaryPart.Position).Magnitude > 30 and true or v29.PrimaryPart.Anchored
					local v37 = CFrame.new(v29.PrimaryPart.Position:Lerp(v35.Position, v36 and 1 or v34))
					local v38 = v29.PrimaryPart.CFrame.Rotation
					local v39 = v35.Rotation
					local v40
					if v36 then
						v40 = 1
					else
						local v41 = 1 - (v32 / 1.5) ^ p28
						v40 = math.clamp(v41, 0, 1)
					end
					local v42 = v38:Lerp(v39, v40)
					v29.PrimaryPart.CFrame = v37 * v42
				end
			end
		end
	end
end
function v_u_6.Serialize(p43, p44)
	local v45 = p43.Position
	local v46 = p43.LookVector
	local v47 = buffer.create(p44 and 30 or 18)
	local v48 = {
		v45.X,
		v45.Y,
		v45.Z,
		v46.X,
		v46.Y,
		v46.Z
	}
	if p44 then
		v48[7] = p44.X
		v48[8] = p44.Y
		v48[9] = p44.Z
	end
	local v49 = 0
	for v50, v51 in ipairs(v48) do
		local v52
		if v50 > 3 then
			v52 = v50 <= 6
		else
			v52 = false
		end
		if v52 then
			local v53 = v51 * 10000
			local v54 = math.floor(v53)
			buffer.writei16(v47, v49, v54)
		else
			local v55 = string.format
			local v56 = tonumber(v55("%.2f", v51))
			buffer.writef32(v47, v49, v56)
		end
		v49 = v49 + (v52 and 2 or 4)
	end
	return v47
end
function v_u_6.Deserialize(p57)
	local v58 = buffer.readf32(p57, 0)
	local v59 = buffer.readf32(p57, 4)
	local v60 = buffer.readf32(p57, 8)
	local v61 = vector.create(v58, v59, v60)
	local v62 = buffer.readi16(p57, 12) / 10000
	local v63 = buffer.readi16(p57, 14) / 10000
	local v64 = buffer.readi16(p57, 16) / 10000
	local v65 = vector.create(v62, v63, v64)
	local v66
	if buffer.len(p57) > 28 then
		local v67 = buffer.readf32(p57, 18)
		local v68 = buffer.readf32(p57, 22)
		local v69 = buffer.readf32(p57, 26)
		v66 = vector.create(v67, v68, v69)
	else
		v66 = nil
	end
	return CFrame.new(v61, v61 + v65), v66
end
function v_u_6.Start(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_9, (copy) v_u_8, (copy) v_u_6, (copy) v_u_4, (ref) v_u_10, (ref) v_u_11, (copy) v_u_7
	if not v_u_2:IsServer() then
		local function v71(p70)
			-- upvalues: (ref) v_u_9, (ref) v_u_8
			if v_u_9[p70] then
				table.clear(v_u_9[p70])
			end
			v_u_9[p70] = nil
			v_u_8[p70.UserId] = nil
		end
		v_u_2.Heartbeat:Connect(v_u_6.__onHeartbeat)
		v_u_4:SetConnection("UpdCF", "UREMOTE_EVENT", function(p72)
			-- upvalues: (ref) v_u_10, (ref) v_u_11, (ref) v_u_7, (ref) v_u_8, (ref) v_u_6, (ref) v_u_9, (ref) v_u_2
			v_u_10 = os.clock() - v_u_11
			v_u_11 = os.clock()
			if v_u_10 < 0.01 then
				return
			end
			for v73, v74 in pairs(p72) do
				local v75 = tonumber(v73)
				if v75 ~= v_u_7.UserId then
					local v76 = v_u_8[v75]
					if not v76 then
						for _, v77 in ipairs(game.Players:GetPlayers()) do
							if v77.UserId == v75 then
								v_u_8[v75] = v77
								v76 = v77
								break
							end
						end
					end
					if v76 then
						local v78 = v76.Character
						if v78 then
							v78 = v78:HasTag("Replicating")
						end
						if v78 then
							local v79 = v_u_6.Deserialize(v74)
							local v80 = v_u_9[v76] and (v_u_9[v76].Timestamps or {}) or {}
							if #v80 >= 5 then
								table.remove(v80, 1)
							end
							local v81 = {
								["Clock"] = os.clock(),
								["CFrame"] = v79
							}
							table.insert(v80, v81)
							local v82 = 0
							local v83 = 0
							for v84 = 2, 5 do
								local v85 = v80[v84 - 1]
								local v86 = v80[v84]
								if v86 and v85 then
									v82 = v82 + 1
									local v87 = (v86.CFrame.Position - v85.CFrame.Position).Magnitude
									local _ = v86.Clock - v85.Clock
									v83 = v83 + v87
								end
							end
							v_u_9[v76] = {
								["Timestamps"] = v80,
								["AverageSpeed"] = v83 / (os.clock() - v80[1].Clock),
								["TotalDisplacement"] = v83,
								["CFrameAtUpdate"] = v76.Character.PrimaryPart.CFrame
							}
							if v_u_2:IsStudio() then
								local v88 = game.ReplicatedStorage.Assets.Instances.Nothingburger:Clone()
								v88.Transparency = 0.1
								v88.CFrame = v79
								v88.Size = Vector3.new(0.3, 0.3, 0.3)
								local v89 = Color3.new
								local v90 = tick() * 4
								local v91 = math.sin(v90)
								local v92 = tick() * 4
								v88.Color = v89(v91, math.cos(v92), 0)
								v88.Parent = workspace
								game.Debris:AddItem(v88, 2)
							end
						end
					end
				end
			end
		end)
		game.Players.PlayerRemoving:Connect(v71)
	end
end
return v_u_6
