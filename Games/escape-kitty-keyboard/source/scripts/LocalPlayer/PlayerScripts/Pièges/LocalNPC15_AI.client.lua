-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local u2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("PathfindingService")
local u5 = game:GetService("RunService")
local u6 = game:GetService("ContentProvider")
local u7 = game:GetService("TweenService")
local u8 = v1.LocalPlayer
local u9 = {
	["CHASE_SPEED"] = 230,
	["PATHFIND_SPEED"] = 230,
	["BOOST_SPEED"] = 280,
	["RETURN_SPEED"] = 500,
	["COUNTDOWN"] = 3,
	["KILL_RADIUS"] = 13,
	["KILL_WALL_HALF_WIDTH"] = 100,
	["KILL_WALL_BEHIND"] = 2,
	["KILL_WALL_MAX_DIST"] = 120,
	["WAYPOINT_REACH"] = 5,
	["PATH_RECOMPUTE"] = 0.3,
	["STOP_DISTANCE"] = 6,
	["ID_WALK"] = "rbxassetid://136780856423547",
	["ID_IDLE"] = "rbxassetid://103924730807406"
}
local u10 = v3:WaitForChild("NPC15")
local u11 = u10:GetPivot()
local u12 = Instance.new("Animation")
u12.AnimationId = u9.ID_WALK
local u13 = Instance.new("Animation")
u13.AnimationId = u9.ID_IDLE
task.spawn(function()
	-- upvalues: (copy) u6, (copy) u12, (copy) u13, (copy) u10
	u6:PreloadAsync({ u12, u13, u10 })
end)
local function u18() -- name: loadWaypoints
	-- upvalues: (copy) u2
	local v14 = {}
	for _, v15 in ipairs(u2:GetTagged("NPC15_Waypoint")) do
		if v15:IsA("BasePart") then
			table.insert(v14, v15)
		end
	end
	table.sort(v14, function(p16, p17)
		return (p16:GetAttribute("Order") or 0) < (p17:GetAttribute("Order") or 0)
	end)
	return v14
end
local u19 = {
	["AgentRadius"] = 1,
	["AgentHeight"] = 5,
	["AgentCanJump"] = false,
	["AgentCanClimb"] = false,
	["WaypointSpacing"] = 4
}
local function u28(p20) -- name: isInAnyZonePart
	-- upvalues: (copy) u2
	for _, v21 in ipairs(u2:GetTagged("NPC15_Zone")) do
		if v21:IsA("BasePart") then
			local v22 = v21.CFrame:PointToObjectSpace(p20)
			local v23 = v22.X
			if math.abs(v23) <= v21.Size.X / 2 then
				local v24 = v22.Y
				local v25 = math.abs(v24)
				local v26 = v21.Size.Y / 2
				if v25 <= math.max(v26, 30) then
					local v27 = v22.Z
					if math.abs(v27) <= v21.Size.Z / 2 then
						return true
					end
				end
			end
		end
	end
	return false
end
local function u37(p29) -- name: isInSpeedZone
	-- upvalues: (copy) u2
	for _, v30 in ipairs(u2:GetTagged("NPC15_SpeedZone")) do
		if v30:IsA("BasePart") then
			local v31 = v30.CFrame:PointToObjectSpace(p29)
			local v32 = v31.X
			if math.abs(v32) <= v30.Size.X / 2 then
				local v33 = v31.Y
				local v34 = math.abs(v33)
				local v35 = v30.Size.Y / 2
				if v34 <= math.max(v35, 30) then
					local v36 = v31.Z
					if math.abs(v36) <= v30.Size.Z / 2 then
						return true
					end
				end
			end
		end
	end
	return false
end
local u38 = false
local function u240() -- name: startNPC
	-- upvalues: (ref) u38, (copy) u18, (copy) u2, (copy) u10, (copy) u11, (copy) u4, (copy) u19, (copy) u12, (copy) u13, (copy) u9, (copy) u8, (copy) u7, (copy) u5, (copy) u28, (copy) u37
	if not u38 then
		u38 = true
		local u39 = u18()
		if #u39 == 0 then
			local v40 = 0
			while #u39 == 0 and v40 < 30 do
				task.wait(0.5)
				u39 = u18()
				v40 = v40 + 1
			end
			if #u39 == 0 then
				warn("[NPC15] Aucun waypoint trouv\195\169 apr\195\168s 15s d\'attente !")
			end
		end
		u2:GetInstanceAddedSignal("NPC15_Waypoint"):Connect(function()
			-- upvalues: (ref) u39, (ref) u18
			u39 = u18()
		end)
		local u41 = u10:Clone()
		u41:PivotTo(u11)
		u41.Parent = workspace
		local u42 = u41:WaitForChild("HumanoidRootPart")
		local v43 = u41:WaitForChild("Humanoid"):WaitForChild("Animator")
		local u44 = u42:WaitForChild("ChaseMusic")
		local u45 = u42:WaitForChild("Footstep")
		local u46 = 0
		u42.Anchored = true
		if #u39 > 0 then
			local _ = u39[#u39].Position.Y
		else
			local _ = u11.Y
		end
		local u47 = RaycastParams.new()
		u47.FilterType = Enum.RaycastFilterType.Exclude
		u47.FilterDescendantsInstances = { u41 }
		local u48 = u11.Y
		local function u60(p49) -- name: getGroundY
			-- upvalues: (ref) u48, (copy) u47
			local v50 = p49.X
			local v51 = u48 + 10
			local v52 = p49.Z
			local v53 = Vector3.new(v50, v51, v52)
			local v54 = workspace:Raycast(v53, Vector3.new(0, -200, 0), u47)
			if v54 then
				u48 = v54.Position.Y + 3
				return u48
			end
			local v55 = p49.X
			local v56 = u48 + 50
			local v57 = p49.Z
			local v58 = Vector3.new(v55, v56, v57)
			local v59 = workspace:Raycast(v58, Vector3.new(0, -200, 0), u47)
			if not v59 then
				return u48
			end
			u48 = v59.Position.Y + 3
			return u48
		end
		task.spawn(function()
			-- upvalues: (ref) u4, (ref) u19, (ref) u11
			local u61 = u4:CreatePath(u19)
			pcall(function()
				-- upvalues: (copy) u61, (ref) u11
				u61:ComputeAsync(u11.Position, u11.Position + Vector3.new(10, 0, 10))
			end)
		end)
		local u62 = v43:LoadAnimation(u12)
		local u63 = v43:LoadAnimation(u13)
		u63:Play()
		local u64 = "Idle"
		local u65 = false
		local u66 = true
		local u67 = 0
		local u68 = 1
		local u69 = Vector3.new(0, 0, 1)
		local u70 = u9.CHASE_SPEED
		local u71 = u9.PATHFIND_SPEED
		local u72 = nil
		local u73 = false
		local function u82() -- name: findClosestWaypointIndex
			-- upvalues: (copy) u42, (ref) u39
			local v74 = u42.Position
			local v75 = (1 / 0)
			local v76 = 1
			for v77, v78 in ipairs(u39) do
				local v79 = v74.X - v78.Position.X
				local v80 = v74.Z - v78.Position.Z
				local v81 = v79 * v79 + v80 * v80
				if v81 < v75 then
					v76 = v77
					v75 = v81
				end
			end
			return v76
		end
		local u83 = {}
		local u84 = 0
		local u85 = false
		local u86 = 0
		local function u87() -- name: goIdle
			-- upvalues: (ref) u64, (ref) u65, (copy) u62, (copy) u63, (copy) u44, (copy) u45, (ref) u83, (ref) u84, (ref) u68, (ref) u48, (ref) u11
			u64 = "Idle"
			u65 = false
			u62:Stop(0.1)
			u63:Play()
			if u44.IsPlaying then
				u44:Stop()
			end
			u45:Stop()
			u83 = {}
			u84 = 0
			u68 = 1
			u48 = u11.Y
		end
		local u88 = {
			[3] = Color3.fromRGB(255, 160, 0),
			[2] = Color3.fromRGB(255, 80, 0),
			[1] = Color3.fromRGB(255, 20, 0)
		}
		local function u105(p89, p90) -- name: showBossUI
			-- upvalues: (ref) u8, (copy) u88, (ref) u7
			local v91 = u8.PlayerGui
			local v92 = v91:FindFirstChild("BossCountdownGui")
			if v92 then
				v92:Destroy()
			end
			local u93 = Instance.new("ScreenGui")
			u93.Name = "BossCountdownGui"
			u93.ResetOnSpawn = false
			u93.Parent = v91
			local u94 = Instance.new("Frame")
			u94.Name = "BossNotif"
			u94.Size = UDim2.new(0.6, 0, 0.2, 0)
			u94.Position = UDim2.new(0.5, 0, 0.45, 0)
			u94.AnchorPoint = Vector2.new(0.5, 0.5)
			u94.BackgroundTransparency = 1
			u94.Parent = u93
			local v95 = Instance.new("UIListLayout", u94)
			v95.HorizontalAlignment = Enum.HorizontalAlignment.Center
			v95.VerticalAlignment = Enum.VerticalAlignment.Center
			v95.Padding = UDim.new(0.05, 0)
			local u96 = Instance.new("UIScale", u94)
			u96.Scale = 0
			local v97 = Instance.new("TextLabel", u94)
			v97.Size = UDim2.new(1, 0, 0.4, 0)
			v97.BackgroundTransparency = 1
			v97.Text = p90 and "\240\159\146\128 BOSS IS CHASING \240\159\146\128" or "\226\154\160\239\184\143 BOSS INCOMING \226\154\160\239\184\143"
			local v98
			if p90 then
				v98 = Color3.fromRGB(255, 80, 80)
			else
				v98 = Color3.fromRGB(255, 160, 0)
			end
			v97.TextColor3 = v98
			v97.TextScaled = true
			v97.Font = Enum.Font.GothamBlack
			local v99 = Instance.new("UIStroke", v97)
			v99.Thickness = 4
			v99.Color = Color3.fromRGB(0, 0, 0)
			local v100 = Instance.new("TextLabel", u94)
			v100.Size = UDim2.new(1, 0, 0.45, 0)
			v100.BackgroundTransparency = 1
			v100.Text = p90 and "RUN !" or tostring(p89)
			local v101
			if p90 then
				v101 = Color3.fromRGB(255, 255, 255)
			else
				v101 = u88[p89] or Color3.fromRGB(255, 30, 30)
			end
			v100.TextColor3 = v101
			v100.TextScaled = true
			v100.Font = Enum.Font.GothamBlack
			local v102 = Instance.new("UIStroke", v100)
			v102.Thickness = 4
			v102.Color = Color3.fromRGB(0, 0, 0)
			u7:Create(u96, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				["Scale"] = 1
			}):Play()
			u7:Create(u94, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				["Position"] = UDim2.new(0.5, 0, 0.4, 0)
			}):Play()
			task.delay(p90 and 2.2 or 0.9, function()
				-- upvalues: (copy) u93, (ref) u7, (copy) u94, (copy) u96
				if u93.Parent then
					u7:Create(u94, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						["Position"] = UDim2.new(0.5, 0, 0.3, 0)
					}):Play()
					u7:Create(u96, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
						["Scale"] = 0
					}):Play()
					local v103 = TweenInfo.new(0.5)
					for _, v104 in ipairs(u94:GetDescendants()) do
						if v104:IsA("TextLabel") then
							u7:Create(v104, v103, {
								["TextTransparency"] = 1
							}):Play()
						elseif v104:IsA("UIStroke") then
							u7:Create(v104, v103, {
								["Transparency"] = 1
							}):Play()
						end
					end
					task.delay(0.65, function()
						-- upvalues: (ref) u93
						if u93.Parent then
							u93:Destroy()
						end
					end)
				end
			end)
		end
		local u106 = RaycastParams.new()
		u106.FilterType = Enum.RaycastFilterType.Exclude
		u106.FilterDescendantsInstances = { u41 }
		local function u115(p107, p108) -- name: hasLineOfSight
			-- upvalues: (ref) u8, (copy) u106, (copy) u41
			local v109 = u8.Character
			local v110 = u106
			local v111
			if v109 then
				v111 = { u41, v109 }
			else
				v111 = { u41 }
			end
			v110.FilterDescendantsInstances = v111
			local v112 = p108.X - p107.X
			local v113 = p108.Z - p107.Z
			local v114 = Vector3.new(v112, 0, v113)
			return workspace:Raycast(p107, v114, u106) == nil
		end
		local function u142(p116) -- name: moveWaypoints
			-- upvalues: (ref) u68, (ref) u39, (copy) u42, (ref) u9, (ref) u64, (ref) u83, (ref) u84, (ref) u86, (ref) u48, (ref) u69, (ref) u46, (copy) u45, (ref) u70, (copy) u41
			while u68 <= #u39 do
				local v117 = u39[u68]
				local v118 = u42.Position
				local v119 = v117.Position.X - v118.X
				local v120 = v117.Position.Z - v118.Z
				local v121 = v119 * v119 + v120 * v120
				if math.sqrt(v121) >= u9.WAYPOINT_REACH then
					break
				end
				u68 = u68 + 1
			end
			if u68 > #u39 then
				u64 = "ChasingPathfind"
				u83 = {}
				u84 = 0
				u86 = 0
				u48 = u42.Position.Y
			else
				local v122 = u39[u68].Position
				local v123 = u42.Position
				local v124 = v122.X - v123.X
				local v125 = v122.Z - v123.Z
				local v126 = v124 * v124 + v125 * v125
				local v127 = math.sqrt(v126)
				if v127 > 0.1 then
					local v128 = v124 / v127
					local v129 = v125 / v127
					u69 = Vector3.new(v128, 0, v129)
				end
				local v130 = os.clock()
				if v130 - u46 >= 0.5 then
					u46 = v130
					u45:Play()
				end
				local v131 = u70 * math.min(p116, 0.1)
				local v132 = math.min(v131, v127) / v127
				local v133 = v123.X + v124 * v132
				local v134 = v123.Z + v125 * v132
				local v135 = v123.Y + (v122.Y - v123.Y) * v132
				local v136 = Vector3.new(v133, v135, v134)
				local v137 = v124 / v127
				local v138 = v125 / v127
				local v139 = v133 + v137
				local v140 = v134 + v138
				local v141 = Vector3.new(v139, v135, v140)
				u41:PivotTo(CFrame.lookAt(v136, v141))
			end
		end
		local function u159(p143, p144) -- name: moveDirectToPlayer
			-- upvalues: (copy) u42, (ref) u46, (copy) u45, (ref) u70, (ref) u69, (copy) u41
			local v145 = u42.Position
			local v146 = p144 - v145
			local v147 = v146.Magnitude
			if v147 >= 0.5 then
				local v148 = os.clock()
				if v148 - u46 >= 0.5 then
					u46 = v148
					u45:Play()
				end
				local v149 = u70 * math.min(p143, 0.1)
				local v150 = math.min(v149, v147)
				local v151 = v146 / v147
				local v152 = v145 + v151 * v150
				local v153 = v151.X
				local v154 = v151.Z
				u69 = Vector3.new(v153, 0, v154).Unit
				local v155 = v152.X + v151.X
				local v156 = v152.Y
				local v157 = v152.Z + v151.Z
				local v158 = Vector3.new(v155, v156, v157)
				u41:PivotTo(CFrame.lookAt(v152, v158))
			end
		end
		local function u197(p160, u161) -- name: movePathfind
			-- upvalues: (copy) u42, (ref) u86, (ref) u9, (ref) u85, (ref) u4, (ref) u19, (ref) u83, (ref) u84, (copy) u115, (ref) u46, (copy) u45, (ref) u71, (copy) u60, (copy) u41
			local u162 = u42.Position
			local v163 = os.clock()
			if v163 - u86 > u9.PATH_RECOMPUTE then
				u86 = v163
				if not u85 then
					u85 = true
					task.spawn(function()
						-- upvalues: (ref) u4, (ref) u19, (copy) u162, (copy) u161, (ref) u42, (ref) u83, (ref) u84, (ref) u85
						local u164 = u4:CreatePath(u19)
						if pcall(function()
							-- upvalues: (copy) u164, (ref) u162, (ref) u161
							u164:ComputeAsync(u162, u161)
						end) and u164.Status == Enum.PathStatus.Success then
							local v165 = u164:GetWaypoints()
							if #v165 >= 2 then
								local v166 = u42.Position
								local v167 = (1 / 0)
								local v168 = 1
								for v169 = 1, #v165 do
									local v170 = v166.X - v165[v169].Position.X
									local v171 = v166.Z - v165[v169].Position.Z
									local v172 = v170 * v170 + v171 * v171
									if v172 < v167 then
										v168 = v169
										v167 = v172
									end
								end
								u83 = v165
								local v173 = v168 + 1
								local v174 = #v165
								u84 = math.min(v173, v174)
							end
						end
						u85 = false
					end)
				end
			end
			local v175 = nil
			if u115(u162, u161) then
				v175 = u161
			elseif u84 > 0 and u84 <= #u83 then
				v175 = u83[u84].Position
				local v176 = u162.X - v175.X
				local v177 = u162.Z - v175.Z
				local v178 = v176 * v176 + v177 * v177
				if math.sqrt(v178) < u9.WAYPOINT_REACH then
					u84 = u84 + 1
					if u84 <= #u83 then
						v175 = u83[u84].Position
					else
						v175 = nil
					end
				end
			end
			if v175 then
				local v179 = v175.X - u162.X
				local v180 = v175.Z - u162.Z
				local v181 = v179 * v179 + v180 * v180
				local v182 = math.sqrt(v181)
				if v182 > 0.5 then
					local v183 = os.clock()
					if v183 - u46 >= 0.5 then
						u46 = v183
						u45:Play()
					end
					local v184 = u71 * math.min(p160, 0.1)
					local v185 = math.min(v184, v182) / v182
					local v186 = u162.X + v179 * v185
					local v187 = u162.Z + v180 * v185
					local v188 = u60
					local v189 = u162.Y
					local v190 = v188((Vector3.new(v186, v189, v187)))
					local v191 = Vector3.new(v186, v190, v187)
					local v192 = v179 / v182
					local v193 = v180 / v182
					local v194 = v186 + v192
					local v195 = v187 + v193
					local v196 = Vector3.new(v194, v190, v195)
					u41:PivotTo(CFrame.lookAt(v191, v196))
				end
			end
		end
		local u198 = nil
		local u199 = nil
		local u200 = nil
		local function u207() -- name: checkKillRadius
			-- upvalues: (ref) u8, (copy) u42, (ref) u9
			local v201 = u8.Character
			if v201 then
				local v202 = v201:FindFirstChild("HumanoidRootPart")
				if v202 then
					local v203 = u42.Position.X - v202.Position.X
					local v204 = u42.Position.Z - v202.Position.Z
					local v205 = v203 * v203 + v204 * v204
					if math.sqrt(v205) < u9.KILL_RADIUS then
						local v206 = v201:FindFirstChildOfClass("Humanoid")
						if v206 and v206.Health > 0 then
							v206.Health = 0
						end
					end
				end
			else
				return
			end
		end
		local function u219() -- name: checkKillWall
			-- upvalues: (ref) u8, (copy) u42, (ref) u69, (ref) u9
			local v208 = u8.Character
			if v208 then
				local v209 = v208:FindFirstChild("HumanoidRootPart")
				if v209 then
					local v210 = v208:FindFirstChildOfClass("Humanoid")
					if v210 and v210.Health > 0 then
						local v211 = u42.Position
						local v212 = v209.Position
						local v213 = v212.X - v211.X
						local v214 = v212.Z - v211.Z
						local v215 = u69.X * v213 + u69.Z * v214
						local v216 = v213 * v213 + v214 * v214
						local v217 = math.sqrt(v216)
						if v215 < -u9.KILL_WALL_BEHIND and v217 < u9.KILL_WALL_MAX_DIST then
							local v218 = u69.X * v214 - u69.Z * v213
							if math.abs(v218) < u9.KILL_WALL_HALF_WIDTH then
								v210.Health = 0
							end
						end
					end
				else
					return
				end
			else
				return
			end
		end
		local u220 = nil
		u220 = u5.RenderStepped:Connect(function(p221)
			-- upvalues: (copy) u41, (ref) u220, (ref) u66, (ref) u8, (copy) u42, (ref) u72, (ref) u28, (ref) u37, (ref) u70, (ref) u9, (ref) u71, (ref) u64, (ref) u65, (ref) u83, (ref) u84, (ref) u86, (ref) u68, (ref) u11, (ref) u48, (copy) u105, (ref) u67, (copy) u62, (copy) u63, (copy) u44, (copy) u87, (ref) u73, (copy) u159, (copy) u219, (copy) u207, (copy) u82, (copy) u142, (copy) u197, (ref) u198, (ref) u199, (ref) u200
			if u41.Parent then
				local v222 = u8.Character
				local v223
				if v222 then
					v223 = v222:FindFirstChild("HumanoidRootPart")
				else
					v223 = v222
				end
				if v222 then
					v222 = v222:FindFirstChildOfClass("Humanoid")
				end
				local v224
				if v223 == nil or v222 == nil then
					v224 = false
				else
					v224 = v222.Health > 0
				end
				local v225 = v224 and v223.Position or nil
				local v226 = u42.Position
				if v225 then
					u72 = v225
				end
				local v227
				if (v225 or u72) == nil then
					v227 = false
				else
					v227 = u28(v225 or u72) or false
				end
				local v228
				if (v225 or u72) == nil then
					v228 = false
				else
					v228 = u37(v225 or u72) or false
				end
				local v229
				if v228 then
					v229 = u9.BOOST_SPEED
				else
					v229 = u9.CHASE_SPEED
				end
				u70 = v229
				local v230
				if v228 then
					v230 = u9.BOOST_SPEED
				else
					v230 = u9.PATHFIND_SPEED
				end
				u71 = v230
				if not v224 and (u64 == "ChasingWaypoints" or (u64 == "ChasingPathfind" or u64 == "Countdown")) then
					u65 = false
					u64 = "Returning"
					u83 = {}
					u84 = 0
					u86 = 0
					u68 = 1
				end
				if u64 ~= "ChasingWaypoints" then
					local v231
					if u64 == "Idle" or u64 == "Returning" then
						v231 = u11.Y
					else
						v231 = u48
					end
					if v226.Y < v231 - 50 then
						local v232 = v226.X
						local v233 = v226.Z
						local v234 = Vector3.new(v232, v231, v233)
						u41:PivotTo(CFrame.new(v234))
					end
				end
				if u64 == "Idle" then
					if v227 then
						u64 = "Countdown"
						u65 = true
						task.spawn(function()
							-- upvalues: (ref) u9, (ref) u65, (ref) u66, (ref) u8, (ref) u105, (ref) u64, (ref) u67, (ref) u68, (ref) u62, (ref) u63, (ref) u44
							for v235 = u9.COUNTDOWN, 1, -1 do
								if not (u65 and u66) then
									local v236 = u8.PlayerGui:FindFirstChild("BossCountdownGui")
									if v236 then
										v236:Destroy()
									end
									return
								end
								u105(v235, false)
								task.wait(1)
							end
							if u65 and u66 then
								u105(nil, true)
								u64 = "ChasingWaypoints"
								u67 = os.clock()
								u68 = 1
								u62:Play()
								u63:Stop()
								if not u44.IsPlaying then
									u44:Play()
								end
							else
								local v237 = u8.PlayerGui:FindFirstChild("BossCountdownGui")
								if v237 then
									v237:Destroy()
								end
							end
						end)
					end
				elseif u64 == "Countdown" then
					if not v227 then
						u65 = false
						u87()
					end
				elseif u64 == "ChasingWaypoints" then
					if v227 or os.clock() - u67 <= 2 then
						if v228 then
							u73 = true
							local v238 = v225 or u72
							if v238 then
								u159(p221, v238)
							end
							u219()
							u207()
						else
							if u73 then
								u73 = false
								u68 = u82()
							end
							u142(p221)
							u219()
							u207()
						end
					else
						u64 = "Returning"
						u83 = {}
						u84 = 0
						u86 = 0
						u68 = 1
					end
				elseif u64 == "ChasingPathfind" then
					if v227 or os.clock() - u67 <= 2 then
						local v239 = v225 or u72
						if v239 then
							if v228 then
								u73 = true
								u159(p221, v239)
							else
								u73 = false
								u197(p221, v239)
							end
							u207()
						end
					else
						u64 = "Returning"
						u83 = {}
						u84 = 0
						u86 = 0
						u68 = 1
					end
				elseif u64 == "Returning" then
					u41:PivotTo(u11)
					u87()
				end
				if u198 then
					u198:Destroy()
					u198 = nil
				end
				if u199 then
					u199:Destroy()
					u199 = nil
				end
				if u200 then
					u200:Destroy()
					u200 = nil
				end
			else
				u220:Disconnect()
				u66 = false
				u41:Destroy()
			end
		end)
	end
end
local function v241() -- name: tryStart
	-- upvalues: (ref) u38, (copy) u2, (copy) u240
	if not u38 then
		if #u2:GetTagged("NPC15_Zone") > 0 then
			task.spawn(u240)
		end
	end
end
u2:GetInstanceAddedSignal("NPC15_Zone"):Connect(v241)
if not u38 and #u2:GetTagged("NPC15_Zone") > 0 then
	task.spawn(u240)
end