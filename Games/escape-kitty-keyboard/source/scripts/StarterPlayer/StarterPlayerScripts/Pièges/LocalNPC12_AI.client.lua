

local v1 = game:GetService("Players")
local v2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("PathfindingService")
local u5 = game:GetService("RunService")
local u6 = game:GetService("ContentProvider")
local u7 = game:GetService("TweenService")
local u8 = v1.LocalPlayer
local u9 = {
	["CHASE_SPEED"] = 190,
	["RETURN_SPEED"] = 250,
	["COUNTDOWN"] = 5,
	["KILL_RADIUS"] = 13,
	["WAYPOINT_REACH"] = 3,
	["PATH_RECOMPUTE"] = 0.3,
	["STOP_DISTANCE"] = 6,
	["ID_WALK"] = "rbxassetid://104571570562605",
	["ID_IDLE"] = "rbxassetid://123873530367173"
}
local u10 = v3:WaitForChild("NPC12")
local u11 = u10:GetPivot()
local u12 = Instance.new("Animation")
u12.AnimationId = u9.ID_WALK
local u13 = Instance.new("Animation")
u13.AnimationId = u9.ID_IDLE
task.spawn(function()

	u6:PreloadAsync({ u12, u13, u10 })
end)
local u14 = {}
local u15 = {
	["AgentRadius"] = 1,
	["AgentHeight"] = 5,
	["AgentCanJump"] = false,
	["AgentCanClimb"] = false,
	["WaypointSpacing"] = 4
}
local function u25(p16, p17) 
	local v18 = p16.CFrame:PointToObjectSpace(p17)
	local v19 = v18.X
	local v20
	if math.abs(v19) <= p16.Size.X / 2 then
		local v21 = v18.Y
		local v22 = math.abs(v21)
		local v23 = p16.Size.Y / 2
		if v22 <= math.max(v23, 30) then
			local v24 = v18.Z
			v20 = math.abs(v24) <= p16.Size.Z / 2
		else
			v20 = false
		end
	else
		v20 = false
	end
	return v20
end
local function u149(u26) 

	if not u14[u26] then
		u14[u26] = true
		local u27 = u10:Clone()
		u27:PivotTo(u11)
		u27.Parent = workspace
		local u28 = u27:WaitForChild("HumanoidRootPart")
		local v29 = u27:WaitForChild("Humanoid"):WaitForChild("Animator")
		local u30 = u28:WaitForChild("ChaseMusic")
		local u31 = u28:WaitForChild("Footstep")
		local u32 = 0
		u28.Anchored = true
		local u33 = u11.Y
		task.spawn(function()

			local u34 = u4:CreatePath(u15)
			pcall(function()

				u34:ComputeAsync(u11.Position, u11.Position + Vector3.new(10, 0, 10))
			end)
		end)
		local u35 = v29:LoadAnimation(u12)
		local u36 = v29:LoadAnimation(u13)
		u36:Play()
		local u37 = "Idle"
		local u38 = false
		local u39 = true
		local u40 = 0
		local u41 = {}
		local u42 = 0
		local u43 = false
		local u44 = 0
		local function u45() 

			u37 = "Idle"
			u38 = false
			u35:Stop(0.1)
			u36:Play()
			if u30.IsPlaying then
				u30:Stop()
			end
			u31:Stop()
			u41 = {}
			u42 = 0
		end
		local u46 = {
			[3] = Color3.fromRGB(255, 160, 0),
			[2] = Color3.fromRGB(255, 80, 0),
			[1] = Color3.fromRGB(255, 20, 0)
		}
		local function u63(p47, p48) 

			local v49 = u8.PlayerGui
			local v50 = v49:FindFirstChild("BossCountdownGui")
			if v50 then
				v50:Destroy()
			end
			local u51 = Instance.new("ScreenGui")
			u51.Name = "BossCountdownGui"
			u51.ResetOnSpawn = false
			u51.Parent = v49
			local u52 = Instance.new("Frame")
			u52.Name = "BossNotif"
			u52.Size = UDim2.new(0.6, 0, 0.2, 0)
			u52.Position = UDim2.new(0.5, 0, 0.45, 0)
			u52.AnchorPoint = Vector2.new(0.5, 0.5)
			u52.BackgroundTransparency = 1
			u52.Parent = u51
			local v53 = Instance.new("UIListLayout", u52)
			v53.HorizontalAlignment = Enum.HorizontalAlignment.Center
			v53.VerticalAlignment = Enum.VerticalAlignment.Center
			v53.Padding = UDim.new(0.05, 0)
			local u54 = Instance.new("UIScale", u52)
			u54.Scale = 0
			local v55 = Instance.new("TextLabel", u52)
			v55.Size = UDim2.new(1, 0, 0.4, 0)
			v55.BackgroundTransparency = 1
			v55.Text = p48 and "\240\159\146\128 BOSS IS CHASING \240\159\146\128" or "\226\154\160\239\184\143 BOSS INCOMING \226\154\160\239\184\143"
			local v56
			if p48 then
				v56 = Color3.fromRGB(255, 80, 80)
			else
				v56 = Color3.fromRGB(255, 160, 0)
			end
			v55.TextColor3 = v56
			v55.TextScaled = true
			v55.Font = Enum.Font.GothamBlack
			local v57 = Instance.new("UIStroke", v55)
			v57.Thickness = 4
			v57.Color = Color3.fromRGB(0, 0, 0)
			local v58 = Instance.new("TextLabel", u52)
			v58.Size = UDim2.new(1, 0, 0.45, 0)
			v58.BackgroundTransparency = 1
			v58.Text = p48 and "RUN !" or tostring(p47)
			local v59
			if p48 then
				v59 = Color3.fromRGB(255, 255, 255)
			else
				v59 = u46[p47] or Color3.fromRGB(255, 30, 30)
			end
			v58.TextColor3 = v59
			v58.TextScaled = true
			v58.Font = Enum.Font.GothamBlack
			local v60 = Instance.new("UIStroke", v58)
			v60.Thickness = 4
			v60.Color = Color3.fromRGB(0, 0, 0)
			u7:Create(u54, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				["Scale"] = 1
			}):Play()
			u7:Create(u52, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				["Position"] = UDim2.new(0.5, 0, 0.4, 0)
			}):Play()
			task.delay(p48 and 2.2 or 0.9, function()

				if u51.Parent then
					u7:Create(u52, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						["Position"] = UDim2.new(0.5, 0, 0.3, 0)
					}):Play()
					u7:Create(u54, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
						["Scale"] = 0
					}):Play()
					local v61 = TweenInfo.new(0.5)
					for _, v62 in ipairs(u52:GetDescendants()) do
						if v62:IsA("TextLabel") then
							u7:Create(v62, v61, {
								["TextTransparency"] = 1
							}):Play()
						elseif v62:IsA("UIStroke") then
							u7:Create(v62, v61, {
								["Transparency"] = 1
							}):Play()
						end
					end
					task.delay(0.65, function()

						if u51.Parent then
							u51:Destroy()
						end
					end)
				end
			end)
		end
		local function u81() 

			u37 = "Countdown"
			u38 = true
			local v64 = u8.Character
			if v64 then
				v64 = v64:FindFirstChild("HumanoidRootPart")
			end
			if v64 then
				local u65 = u11.Position
				local u66 = v64.Position
				if not u43 then
					u43 = true
					task.spawn(function()

						local u67 = u4:CreatePath(u15)
						if pcall(function()

							u67:ComputeAsync(u65, u66)
						end) and u67.Status == Enum.PathStatus.Success then
							local v68 = u67:GetWaypoints()
							if #v68 >= 2 then
								local v69 = u28.Position
								local v70 = (1 / 0)
								local v71 = 1
								for v72 = 1, #v68 do
									local v73 = v69.X - v68[v72].Position.X
									local v74 = v69.Z - v68[v72].Position.Z
									local v75 = v73 * v73 + v74 * v74
									if v75 < v70 then
										v71 = v72
										v70 = v75
									end
								end
								u41 = v68
								local v76 = v71 + 1
								local v77 = #v68
								u42 = math.min(v76, v77)
							end
						end
						u43 = false
					end)
				end
			end
			task.spawn(function()

				for v78 = u9.COUNTDOWN, 1, -1 do
					if not (u38 and u39) then
						local v79 = u8.PlayerGui:FindFirstChild("BossCountdownGui")
						if v79 then
							v79:Destroy()
						end
						return
					end
					u63(v78, false)
					task.wait(1)
				end
				if u38 and u39 then
					u63(nil, true)
					u37 = "Chasing"
					u40 = os.clock()
					u35:Play()
					u36:Stop()
					if not u30.IsPlaying then
						u30:Play()
					end
					if #u41 == 0 then
						u44 = 0
					end
				else
					local v80 = u8.PlayerGui:FindFirstChild("BossCountdownGui")
					if v80 then
						v80:Destroy()
					end
				end
			end)
		end
		local u82 = RaycastParams.new()
		u82.FilterType = Enum.RaycastFilterType.Exclude
		u82.FilterDescendantsInstances = { u27 }
		local function u91(p83, p84) 

			local v85 = u8.Character
			local v86 = u82
			local v87
			if v85 then
				v87 = { u27, v85 }
			else
				v87 = { u27 }
			end
			v86.FilterDescendantsInstances = v87
			local v88 = p84.X - p83.X
			local v89 = p84.Z - p83.Z
			local v90 = Vector3.new(v88, 0, v89)
			return workspace:Raycast(p83, v90, u82) == nil
		end
		local function u129(p92, u93, p94) 

			local u95 = u28.Position
			local v96 = os.clock()
			if v96 - u44 > u9.PATH_RECOMPUTE then
				u44 = v96
				if not u43 then
					u43 = true
					task.spawn(function()

						local u97 = u4:CreatePath(u15)
						if pcall(function()

							u97:ComputeAsync(u95, u93)
						end) and u97.Status == Enum.PathStatus.Success then
							local v98 = u97:GetWaypoints()
							if #v98 >= 2 then
								local v99 = u28.Position
								local v100 = (1 / 0)
								local v101 = 1
								for v102 = 1, #v98 do
									local v103 = v99.X - v98[v102].Position.X
									local v104 = v99.Z - v98[v102].Position.Z
									local v105 = v103 * v103 + v104 * v104
									if v105 < v100 then
										v101 = v102
										v100 = v105
									end
								end
								u41 = v98
								local v106 = v101 + 1
								local v107 = #v98
								u42 = math.min(v106, v107)
							end
						end
						u43 = false
					end)
				end
			end
			local v108 = nil
			if u91(u95, u93) then
				v108 = u93
			elseif u42 > 0 and u42 <= #u41 then
				v108 = u41[u42].Position
				local v109 = u95.X - v108.X
				local v110 = u95.Z - v108.Z
				local v111 = v109 * v109 + v110 * v110
				if math.sqrt(v111) < u9.WAYPOINT_REACH then
					u42 = u42 + 1
					if u42 <= #u41 then
						v108 = u41[u42].Position
					else
						v108 = nil
					end
				end
			end
			if v108 then
				local v112 = v108.X - u95.X
				local v113 = v108.Z - u95.Z
				local v114 = v112 * v112 + v113 * v113
				local v115 = math.sqrt(v114)
				if v115 > 0.5 then
					local v116 = os.clock()
					if v116 - u32 >= 0.5 then
						u32 = v116
						u31:Play()
					end
					local v117 = p94 * math.min(p92, 0.1)
					local v118 = math.min(v117, v115) / v115
					local v119 = u95.X + v112 * v118
					local v120 = u95.Z + v113 * v118
					local v121 = u33
					local v122 = Vector3.new(v119, v121, v120)
					local v123 = v112 / v115
					local v124 = v113 / v115
					local v125 = v119 + v123
					local v126 = u33
					local v127 = v120 + v124
					local v128 = Vector3.new(v125, v126, v127)
					u27:PivotTo(CFrame.lookAt(v122, v128))
				end
			end
		end
		local function u136() 

			local v130 = u8.Character
			if v130 then
				local v131 = v130:FindFirstChild("HumanoidRootPart")
				if v131 then
					local v132 = u28.Position.X - v131.Position.X
					local v133 = u28.Position.Z - v131.Position.Z
					local v134 = v132 * v132 + v133 * v133
					if math.sqrt(v134) < u9.KILL_RADIUS then
						local v135 = v130:FindFirstChildOfClass("Humanoid")
						if v135 and v135.Health > 0 then
							v135.Health = 0
						end
					end
				end
			else
				return
			end
		end
		local u137 = nil
		u137 = u5.RenderStepped:Connect(function(p138)

			if u27.Parent and u26.Parent then
				local v139 = u8.Character
				local v140
				if v139 then
					v140 = v139:FindFirstChild("HumanoidRootPart")
				else
					v140 = v139
				end
				if v139 then
					v139 = v139:FindFirstChildOfClass("Humanoid")
				end
				local v141
				if v140 == nil or v139 == nil then
					v141 = false
				else
					v141 = v139.Health > 0
				end
				local v142 = v141 and v140.Position or nil
				local v143 = u28.Position
				local v144
				if v142 == nil then
					v144 = false
				else
					v144 = u25(u26, v142) or false
				end
				if not v141 and (u37 == "Chasing" or u37 == "Countdown") then
					u38 = false
					u37 = "Returning"
					u41 = {}
					u42 = 0
					u44 = 0
				end
				if v143.Y < u33 - 50 then
					local v145 = v143.X
					local v146 = u33
					local v147 = v143.Z
					local v148 = Vector3.new(v145, v146, v147)
					u27:PivotTo(CFrame.new(v148))
				end
				if u37 == "Idle" then
					if v144 then
						u81()
						return
					end
				elseif u37 == "Countdown" then
					if not v144 then
						u38 = false
						u45()
						return
					end
				elseif u37 == "Chasing" then
					if not v144 and os.clock() - u40 > 2 then
						u37 = "Returning"
						u41 = {}
						u42 = 0
						u44 = 0
						return
					end
					if v142 then
						u129(p138, v142, u9.CHASE_SPEED)
						u136()
						return
					end
				elseif u37 == "Returning" then
					if ((v143 - u11.Position) * Vector3.new(1, 0, 1)).Magnitude < u9.STOP_DISTANCE then
						u45()
						u27:PivotTo(u11)
						return
					end
					u129(p138, u11.Position, u9.RETURN_SPEED)
				end
			else
				u137:Disconnect()
				u14[u26] = nil
				u39 = false
				u27:Destroy()
			end
		end)
	end
end
local function v151(p150) 

	u149(p150)
end
v2:GetInstanceAddedSignal("NPC12_LabyrinthZone"):Connect(v151)
for _, v152 in ipairs(v2:GetTagged("NPC12_LabyrinthZone")) do
	task.spawn(v151, v152)
end