-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

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
					local v31 = 1 - 1e-9 ^ p28
					local v32 = math.clamp(v31, 0, 1)
					local v33 = v30.CFrame
					local v34 = (v33.Position - v29.PrimaryPart.Position).Magnitude > 30 and true or v29.PrimaryPart.Anchored
					local v35 = CFrame.new(v29.PrimaryPart.Position:Lerp(v33.Position, v34 and 1 or v32))
					local v36 = v29.PrimaryPart.CFrame.Rotation
					local v37 = v33.Rotation
					local v38
					if v34 then
						v38 = 1
					else
						local v39 = 1 - 6.666666666666667e-10 ^ p28
						v38 = math.clamp(v39, 0, 1)
					end
					local v40 = v36:Lerp(v37, v38)
					v29.PrimaryPart.CFrame = v35 * v40
				end
			end
		end
	end
end
function v_u_6.Serialize(p41, p42)
	local v43 = p41.Position
	local v44 = p41.LookVector
	local v45 = buffer.create(p42 and 30 or 18)
	local v46 = {
		v43.X,
		v43.Y,
		v43.Z,
		v44.X,
		v44.Y,
		v44.Z
	}
	if p42 then
		v46[7] = p42.X
		v46[8] = p42.Y
		v46[9] = p42.Z
	end
	local v47 = 0
	for v48, v49 in ipairs(v46) do
		local v50
		if v48 > 3 then
			v50 = v48 <= 6
		else
			v50 = false
		end
		if v50 then
			local v51 = v49 * 10000
			local v52 = math.floor(v51)
			buffer.writei16(v45, v47, v52)
		else
			local v53 = string.format
			local v54 = tonumber(v53("%.2f", v49))
			buffer.writef32(v45, v47, v54)
		end
		v47 = v47 + (v50 and 2 or 4)
	end
	return v45
end
function v_u_6.Deserialize(p55)
	local v56 = buffer.readf32(p55, 0)
	local v57 = buffer.readf32(p55, 4)
	local v58 = buffer.readf32(p55, 8)
	local v59 = vector.create(v56, v57, v58)
	local v60 = buffer.readi16(p55, 12) / 10000
	local v61 = buffer.readi16(p55, 14) / 10000
	local v62 = buffer.readi16(p55, 16) / 10000
	local v63 = vector.create(v60, v61, v62)
	local v64
	if buffer.len(p55) > 28 then
		local v65 = buffer.readf32(p55, 18)
		local v66 = buffer.readf32(p55, 22)
		local v67 = buffer.readf32(p55, 26)
		v64 = vector.create(v65, v66, v67)
	else
		v64 = nil
	end
	return CFrame.new(v59, v59 + v63), v64
end
function v_u_6.Start(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_9, (copy) v_u_8, (copy) v_u_6, (copy) v_u_4, (ref) v_u_10, (ref) v_u_11, (copy) v_u_7
	if not v_u_2:IsServer() then
		local function v69(p68)
			-- upvalues: (ref) v_u_9, (ref) v_u_8
			if v_u_9[p68] then
				table.clear(v_u_9[p68])
			end
			v_u_9[p68] = nil
			v_u_8[p68.UserId] = nil
		end
		v_u_2.Heartbeat:Connect(v_u_6.__onHeartbeat)
		v_u_4:SetConnection("UpdCF", "UREMOTE_EVENT", function(p70)
			-- upvalues: (ref) v_u_10, (ref) v_u_11, (ref) v_u_7, (ref) v_u_8, (ref) v_u_6, (ref) v_u_9, (ref) v_u_2
			v_u_10 = os.clock() - v_u_11
			v_u_11 = os.clock()
			if v_u_10 < 0.01 then
				return
			end
			for v71, v72 in pairs(p70) do
				local v73 = tonumber(v71)
				if v73 ~= v_u_7.UserId then
					local v74 = v_u_8[v73]
					if not v74 then
						for _, v75 in ipairs(game.Players:GetPlayers()) do
							if v75.UserId == v73 then
								v_u_8[v73] = v75
								v74 = v75
								break
							end
						end
					end
					if v74 then
						local v76 = v74.Character
						if v76 then
							v76 = v76:HasTag("Replicating")
						end
						if v76 then
							local v77 = v_u_6.Deserialize(v72)
							local v78 = v_u_9[v74] and (v_u_9[v74].Timestamps or {}) or {}
							if #v78 >= 5 then
								table.remove(v78, 1)
							end
							local v79 = {
								["Clock"] = os.clock(),
								["CFrame"] = v77
							}
							table.insert(v78, v79)
							local v80 = 0
							local v81 = 0
							for v82 = 2, 5 do
								local v83 = v78[v82 - 1]
								local v84 = v78[v82]
								if v84 and v83 then
									v80 = v80 + 1
									local v85 = (v84.CFrame.Position - v83.CFrame.Position).Magnitude
									local _ = v84.Clock - v83.Clock
									v81 = v81 + v85
								end
							end
							v_u_9[v74] = {
								["Timestamps"] = v78,
								["AverageSpeed"] = v81 / (os.clock() - v78[1].Clock),
								["TotalDisplacement"] = v81,
								["CFrameAtUpdate"] = v74.Character.PrimaryPart.CFrame
							}
							if v_u_2:IsStudio() then
								local v86 = game.ReplicatedStorage.Assets.Instances.Nothingburger:Clone()
								v86.Transparency = 0.1
								v86.CFrame = v77
								v86.Size = Vector3.new(0.3, 0.3, 0.3)
								local v87 = Color3.new
								local v88 = tick() * 4
								local v89 = math.sin(v88)
								local v90 = tick() * 4
								v86.Color = v87(v89, math.cos(v90), 0)
								v86.Parent = workspace
								game.Debris:AddItem(v86, 2)
							end
						end
					end
				end
			end
		end)
		game.Players.PlayerRemoving:Connect(v69)
	end
end
return v_u_6
