

local u1 = game:GetService("Players")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("TweenService")
local u4 = game:GetService("RunService")
local u5 = require(u2:WaitForChild("Shared"):WaitForChild("AdminAbuseConfig"))
local u6 = require(game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts"):WaitForChild("Client"):WaitForChild("AdminAbuseTransition"))
local u7 = nil
local u8 = nil
local u9 = nil
local u10 = nil
local u11 = nil
local u12 = nil
local u13 = nil
local u14 = 0
local u15 = 1
local u16 = false
local u17 = nil
local u18 = nil
local function u32() 

	local v19 = u8
	local v20 = u9
	local v21 = u10
	if v21 and (v19 and u15 > 0) then
		local v22 = v21.Value
		local v23 = u15
		local v24 = math.clamp(v22, 0, v23)
		local v25 = v24 / u15
		local v26 = math.clamp(v25, 0, 1)
		v19.Size = UDim2.new(v26, 0, 1, 0)
		if v20 then
			local v27 = u15
			if v27 >= 1000000 then
				v20.Text = string.format("%.3fM / %.1fM", v24 / 1000000, v27 / 1000000)
				return
			end
			local v28 = string.format
			local v29 = v24 + 0.5
			local v30 = math.floor(v29)
			local v31 = v27 + 0.5
			v20.Text = v28("%d / %d", v30, (math.floor(v31)))
		end
	end
end
local function u42(p33, p34, p35) 

	local v36 = u10
	if v36 then
		if type(p33) == "number" then
			if type(p34) ~= "number" then
				p34 = p33
			end
			if p34 <= 0 then
				return
			elseif type(p35) == "number" and p35 < u14 then
				return
			else
				if type(p35) == "number" then
					u14 = p35
				end
				u15 = p34
				if u13 then
					u13:Cancel()
					u13 = nil
				end
				local v37 = math.clamp(p33, 0, p34)
				local v38 = not u16
				if not v38 then
					local v39 = u5.BossBarTweenDurationSec
					v38 = ((type(v39) ~= "number" or v39 <= 0) and 0.38 or v39) <= 0
				end
				u16 = true
				if v38 then
					v36.Value = v37
					u32()
				else
					local v40 = u5.BossBarTweenDurationSec
					local v41 = (type(v40) ~= "number" or v40 <= 0) and 0.38 or v40
					u13 = u3:Create(v36, TweenInfo.new(v41, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["Value"] = v37
					})
					u13:Play()
				end
			end
		else
			return
		end
	else
		return
	end
end
local u43 = u1.LocalPlayer
local u44 = false
local u45 = {
	"rbxassetid://140658568629873",
	"rbxassetid://135791338543784",
	"rbxassetid://1838475719",
	"rbxassetid://1843024859",
	"rbxassetid://1838450596",
	"rbxassetid://1837922109",
	"rbxassetid://1847617400"
}
local u46 = 1
local u47 = nil
local function v51(p48) 

	task.wait(0.1)
	if u44 or u6.isActive() then
		return
	else
		local v49 = workspace.CurrentCamera
		if v49 then
			v49.CameraType = Enum.CameraType.Custom
			local v50 = p48:WaitForChild("Humanoid", 10)
			if v50 then
				v49.CameraSubject = v50
			end
		end
	end
end
if u43 then
	if u43.Character then
		v51(u43.Character)
	end
	u43.CharacterAdded:Connect(v51)
end
local u52 = nil
u4:BindToRenderStep("LokiiBossCinematicLock", Enum.RenderPriority.Camera.Value + 2, function()

	if u44 then
		local v53 = workspace.CurrentCamera
		if v53 then
			v53.CameraSubject = nil
			if v53.CameraType ~= Enum.CameraType.Scriptable then
				v53.CameraType = Enum.CameraType.Scriptable
				if u52 then
					v53.CFrame = u52
				end
			end
			u52 = v53.CFrame
			return
		end
	else
		u52 = nil
	end
end)
local function u54() 

	if u13 then
		u13:Cancel()
		u13 = nil
	end
	if u12 then
		u12:Disconnect()
		u12 = nil
	end
	if u11 then
		u11:Disconnect()
		u11 = nil
	end
	if u18 then
		u18:Disconnect()
		u18 = nil
	end
	if u7 and u7.Parent then
		u7:Destroy()
	end
	u7 = nil
	u8 = nil
	u9 = nil
	u10 = nil
	u44 = false
	u14 = 0
	u15 = 1
	u16 = false
	u17 = nil
	if u47 then
		u47:Stop()
		u47:Destroy()
		u47 = nil
	end
	if pulseGui then
		pulseGui:Destroy()
		pulseGui = nil
	end
end
local function u89() 

	if u7 then
		return
	else
		local v55 = u1.LocalPlayer
		if v55 then
			local v56 = v55:WaitForChild("PlayerGui")
			local v57 = u2:FindFirstChild("PulseBoss")
			if v57 and v57:IsA("ScreenGui") then
				pulseGui = v57:Clone()
				pulseGui.Parent = v56
				local u58 = pulseGui:FindFirstChild("Frame")
				if u58 then
					task.spawn(function()

						while pulseGui and pulseGui.Parent do
							local v59 = os.clock() * 3
							u58.BackgroundTransparency = (math.sin(v59) + 1) / 2 * 0.3 + 0.6
							task.wait()
						end
					end)
				end
			end
			local v60 = Instance.new("ScreenGui")
			v60.Name = "LokiiBossHud"
			v60.ResetOnSpawn = false
			v60.IgnoreGuiInset = true
			v60.DisplayOrder = 80
			v60.Parent = v56
			u7 = v60
			local v61 = Instance.new("Frame")
			v61.Name = "LevelFrame"
			v61.Parent = v60
			v61.AnchorPoint = Vector2.new(0.5, 0)
			v61.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
			v61.BackgroundTransparency = 1
			v61.Position = UDim2.new(0.5, 0, 0, 45)
			v61.Size = UDim2.new(0.6, 0, 0.08, 0)
			local v62 = Instance.new("Frame")
			v62.Name = "ProgressBg"
			v62.Parent = v61
			v62.AnchorPoint = Vector2.new(0.5, 0.5)
			v62.BackgroundColor3 = Color3.fromRGB(38, 17, 0)
			v62.BackgroundTransparency = 0.4
			v62.Position = UDim2.new(0.5, 0, 0.5, 0)
			v62.Size = UDim2.new(1, 0, 0.65, 0)
			local v63 = Instance.new("UICorner")
			v63.CornerRadius = UDim.new(0.5, 0)
			v63.Parent = v62
			local v64 = Instance.new("ImageLabel")
			v64.Name = "BossIcon"
			v64.Parent = v62
			v64.AnchorPoint = Vector2.new(0, 0.5)
			v64.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			v64.BorderSizePixel = 0
			v64.Position = UDim2.new(0, -65, 0.5, 0)
			v64.Size = UDim2.new(0, 60, 0, 60)
			v64.Image = "rbxthumb://type=AvatarHeadShot&id=3845375404&w=150&h=150"
			local v65 = Instance.new("UICorner")
			v65.CornerRadius = UDim.new(1, 0)
			v65.Parent = v64
			local v66 = Instance.new("UIStroke")
			v66.Color = Color3.fromRGB(255, 215, 0)
			v66.Thickness = 2
			v66.Parent = v64
			local v67 = Instance.new("TextLabel")
			v67.Name = "TrophyIcon"
			v67.Parent = v62
			v67.AnchorPoint = Vector2.new(0, 0.5)
			v67.BackgroundTransparency = 1
			v67.Position = UDim2.new(1, 10, 0.5, 0)
			v67.Size = UDim2.new(0, 50, 0, 50)
			v67.Font = Enum.Font.GothamBold
			v67.Text = "\240\159\143\134"
			v67.TextScaled = true
			v67.Parent = v62
			local v68 = Instance.new("Frame")
			v68.Name = "ProgressFill"
			v68.Parent = v62
			v68.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			v68.Size = UDim2.new(0, 0, 1, 0)
			u8 = v68
			local v69 = Instance.new("UICorner")
			v69.CornerRadius = UDim.new(0.5, 0)
			v69.Parent = v68
			local v70 = Instance.new("UIGradient")
			v70.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(167, 126, 69)), ColorSequenceKeypoint.new(1, Color3.fromRGB(221, 174, 120)) })
			v70.Rotation = -90
			v70.Parent = v68
			local v71 = Instance.new("TextLabel")
			v71.Name = "LevelText"
			v71.Parent = v62
			v71.BackgroundTransparency = 1
			v71.Size = UDim2.new(0.4, 0, 1, 0)
			v71.Font = Enum.Font.GothamBold
			v71.Text = "LOKII BOSS EVENT"
			v71.TextColor3 = Color3.fromRGB(255, 255, 255)
			v71.TextScaled = true
			v71.TextXAlignment = Enum.TextXAlignment.Left
			local v72 = Instance.new("UIPadding")
			v72.PaddingBottom = UDim.new(0.15, 0)
			v72.PaddingLeft = UDim.new(0.04, 0)
			v72.PaddingTop = UDim.new(0.15, 0)
			v72.Parent = v71
			local v73 = Instance.new("TextLabel")
			v73.Name = "XPText"
			v73.Parent = v62
			v73.AnchorPoint = Vector2.new(1, 0)
			v73.BackgroundTransparency = 1
			v73.Position = UDim2.new(1, 0, 0, 0)
			v73.Size = UDim2.new(0.4, 0, 1, 0)
			v73.Font = Enum.Font.GothamBold
			v73.Text = "0 / 100M"
			v73.TextColor3 = Color3.fromRGB(255, 255, 255)
			v73.TextScaled = true
			v73.TextXAlignment = Enum.TextXAlignment.Right
			u9 = v73
			local v74 = Instance.new("UIPadding")
			v74.PaddingBottom = UDim.new(0.15, 0)
			v74.PaddingRight = UDim.new(0.04, 0)
			v74.PaddingTop = UDim.new(0.15, 0)
			v74.Parent = v73
			for v75, v76 in ipairs({ 0.6, 0.9 }) do
				local v77 = Instance.new("Frame")
				v77.Name = "PhaseMarker" .. v75
				v77.Parent = v62
				v77.AnchorPoint = Vector2.new(0.5, 0)
				v77.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
				v77.BorderSizePixel = 0
				v77.ZIndex = 6
				v77.Position = UDim2.new(v76, 0, 0, 0)
				v77.Size = UDim2.new(0, 3, 1, 0)
			end
			local v78 = Instance.new("Frame")
			v78.Name = "SpeedDisplay"
			v78.Parent = v61
			v78.AnchorPoint = Vector2.new(0.5, 0)
			v78.BackgroundTransparency = 1
			v78.Position = UDim2.new(0.5, 0, 1, 0)
			v78.Size = UDim2.new(0.3, 0, 0.6, 0)
			local v79 = Instance.new("TextLabel")
			v79.Name = "SpeedValue"
			v79.Parent = v78
			v79.AnchorPoint = Vector2.new(0.5, 0.5)
			v79.BackgroundTransparency = 1
			v79.Position = UDim2.new(0.5, 0, 0.5, 0)
			v79.Size = UDim2.new(1, 0, 1, 0)
			v79.Font = Enum.Font.GothamBlack
			v79.Text = "GLOBAL TROPHIES WON"
			v79.TextColor3 = Color3.fromRGB(255, 255, 255)
			v79.TextScaled = true
			v79.TextYAlignment = Enum.TextYAlignment.Bottom
			local v80 = Instance.new("Frame")
			v80.Name = "GamepassMultiplierDisplay"
			v80.Parent = v61
			v80.AnchorPoint = Vector2.new(0, 0)
			v80.BackgroundTransparency = 1
			v80.Position = UDim2.new(0, 0, 1, 0)
			v80.Size = UDim2.new(0.3, 0, 0.3, 0)
			local u81 = Instance.new("TextLabel")
			u81.Name = "GamepassMultiplierLabel"
			u81.Parent = v80
			u81.AnchorPoint = Vector2.new(0.5, 0.5)
			u81.BackgroundTransparency = 1
			u81.Position = UDim2.new(0.5, 0, 0.5, 0)
			u81.Size = UDim2.new(1, 0, 1, 0)
			u81.Font = Enum.Font.GothamBlack
			u81.Text = "ACTIVE EVENT x2"
			u81.TextColor3 = Color3.fromRGB(255, 255, 255)
			u81.TextScaled = true
			u81.TextXAlignment = Enum.TextXAlignment.Left
			local u82 = Instance.new("UIGradient")
			u82.Parent = u81
			task.spawn(function()

				local v83 = 0
				while u81 and u81.Parent do
					v83 = v83 + u4.RenderStepped:Wait() * 0.2
					local v84 = v83 % 1
					local v85 = (v83 + 0.1) % 1
					u82.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHSV(v84, 0.7, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(v85, 0.7, 1)) })
				end
			end)
			local v86 = Instance.new("NumberValue")
			v86.Name = "BossHpDisplay"
			v86.Value = 0
			v86.Parent = v60
			u10 = v86
			u12 = v86.Changed:Connect(u32)
			if u47 then
				u47:Stop()
				u47:Destroy()
				u47 = nil
			end
			u46 = 1
			local function u88() 

				if u7 and u7.Parent then
					if u46 > #u45 then
						u46 = 1
					end
					local v87 = u45[u46]
					u47 = Instance.new("Sound")
					u47.Name = "BossMusic"
					u47.SoundId = v87
					u47.Volume = 0.4
					u47.Parent = workspace.CurrentCamera or u43:WaitForChild("PlayerGui")
					u47:Play()
					u47.Ended:Connect(function()

						if u47 then
							u47:Destroy()
						end
						u46 = u46 + 1
						u88()
					end)
				end
			end
			u88()
		end
	end
end
local function u277() 

	local v90 = u2:WaitForChild("AdminAbuse"):WaitForChild("Remotes"):WaitForChild("AdminAbuseBossSync")
	if v90:IsA("RemoteEvent") then
		if u11 then
			u11:Disconnect()
		end
		u11 = v90.OnClientEvent:Connect(function(...)

			u89()
			if u10 then
				u42(...)
			end
		end)
	end
	local v91 = u2:WaitForChild("AdminAbuse"):WaitForChild("Remotes"):WaitForChild("AdminAbuseBossFx")
	if v91:IsA("RemoteEvent") then
		if u18 then
			u18:Disconnect()
		end
		u18 = v91.OnClientEvent:Connect(function(p92, p93)

			if type(p92) ~= "string" or type(p93) ~= "table" then
				return
			end
			if p92 == "ZoneWarn" then
				local v94 = p93.x
				local v95 = type(v94) ~= "number" and 0 or v94
				local v96 = p93.y
				local v97 = type(v96) ~= "number" and 0 or v96
				local v98 = p93.z
				local v99 = type(v98) ~= "number" and 0 or v98
				local v100 = Vector3.new(v95, v97, v99)
				local v101 = p93.hx
				local v102 = type(v101) ~= "number" and 6 or v101
				local v103 = p93.hz
				local v104 = type(v103) ~= "number" and 6 or v103
				local v105 = p93.t
				local v106 = type(v105) ~= "number" and 1.2 or v105
				local u107 = Instance.new("Part")
				u107.Name = "BossZoneWarnFx"
				u107.Shape = Enum.PartType.Cylinder
				u107.Anchored = true
				u107.CanCollide = false
				u107.CanQuery = false
				u107.Material = Enum.Material.Neon
				u107.Color = Color3.fromRGB(200, 70, 70)
				local v108 = v102 * 2
				local v109 = v104 * 2
				u107.Size = Vector3.new(4.5, v108, v109)
				u107.CFrame = CFrame.new(v100 + Vector3.new(0, -0.2, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
				u107.Transparency = 0.4
				u107.Parent = workspace
				task.delay(v106, function()

					if u107.Parent then
						u107:Destroy()
					end
				end)
				return
			end
			if p92 == "ZoneHit" then
				local v110 = p93.x
				local v111 = type(v110) ~= "number" and 0 or v110
				local v112 = p93.y
				local v113 = type(v112) ~= "number" and 0 or v112
				local v114 = p93.z
				local v115 = type(v114) ~= "number" and 0 or v114
				local v116 = Vector3.new(v111, v113, v115)
				local v117 = p93.hx
				local v118 = type(v117) ~= "number" and 6 or v117
				local v119 = p93.hz
				local v120 = type(v119) ~= "number" and 6 or v119
				local v121 = p93.style
				local v122
				if (type(v121) ~= "string" and "sweet" or v121) == "chocolate" then
					v122 = Color3.fromRGB(113, 54, 0)
				else
					v122 = Color3.fromRGB(255, 130, 210)
				end
				local u123 = Instance.new("Part")
				u123.Name = "BossZoneJetFx"
				u123.Shape = Enum.PartType.Cylinder
				u123.Anchored = true
				u123.CanCollide = false
				u123.CanQuery = false
				u123.Material = Enum.Material.SmoothPlastic
				u123.Color = v122
				local v124 = v118 * 1.5
				local v125 = v120 * 1.5
				u123.Size = Vector3.new(2, v124, v125)
				u123.CFrame = CFrame.new(v116 + Vector3.new(0, -10, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
				u123.Parent = workspace
				local v126 = v118 * 1.8
				local v127 = v120 * 1.8
				local v128 = Vector3.new(150, v126, v127)
				local v129 = v116 + Vector3.new(0, 65, 0)
				u3:Create(u123, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["Size"] = v128,
					["CFrame"] = CFrame.new(v129) * CFrame.Angles(0, 0, 1.5707963267948966)
				}):Play()
				task.delay(0.4, function()

					local v130 = u3:Create(u123, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
						["Transparency"] = 1,
						["Size"] = Vector3.new(150, 0.1, 0.1)
					})
					v130:Play()
					v130.Completed:Connect(function()

						u123:Destroy()
					end)
				end)
				local u131 = Instance.new("Part")
				u131.Anchored = true
				u131.CanCollide = false
				u131.CanQuery = false
				u131.Size = Vector3.new(2, 0.4, 2)
				u131.Transparency = 0.5
				u131.Color = Color3.fromRGB(255, 255, 255)
				u131.CFrame = CFrame.new(v116 + Vector3.new(0, 0.2, 0))
				u131.Parent = workspace
				local v132 = u3
				local v133 = TweenInfo.new(0.3)
				local v134 = {
					["Transparency"] = 1
				}
				local v135 = v118 * 3
				local v136 = v120 * 3
				v134.Size = Vector3.new(v135, 0.4, v136)
				v132:Create(u131, v133, v134):Play()
				task.delay(0.35, function()

					if u131.Parent then
						u131:Destroy()
					end
				end)
				return
			end
			if p92 == "DashTelegraph" then
				local v137 = p93.sx
				local v138 = type(v137) ~= "number" and 0 or v137
				local v139 = p93.sy
				local v140 = type(v139) ~= "number" and 0 or v139
				local v141 = p93.sz
				local v142 = type(v141) ~= "number" and 0 or v141
				local v143 = p93.lx
				local v144 = type(v143) ~= "number" and 0 or v143
				local v145 = p93.ly
				local v146 = type(v145) ~= "number" and 0 or v145
				local v147 = p93.lz
				local v148 = type(v147) ~= "number" and 0 or v147
				local v149 = p93.r
				local v150 = type(v149) ~= "number" and 11 or v149
				local v151 = p93.t
				local v152 = type(v151) ~= "number" and 2.5 or v151
				local v153 = math.min(v140, v146) + 0.35
				local v154 = Vector3.new(v138, v153, v142)
				local v155 = Vector3.new(v144, v153, v148)
				local v156 = (v155 - v154).Magnitude
				local v157 = (v154 + v155) * 0.5
				local u158 = Instance.new("Part")
				u158.Name = "BossDashTrailFx"
				u158.Anchored = true
				u158.CanCollide = false
				u158.CanQuery = false
				u158.Material = Enum.Material.Neon
				u158.Color = Color3.fromRGB(255, 50, 80)
				u158.Transparency = 0.28
				local v159 = v150 * 0.75
				local v160 = math.clamp(v159, 6, 32)
				local v161 = math.max(v156, 0.05)
				u158.Size = Vector3.new(v160, 1.7, v161)
				local v162
				if v156 > 0.05 then
					v162 = CFrame.lookAt(v157 + Vector3.new(0, 0.85, 0), v155 + Vector3.new(0, 0.85, 0))
				else
					v162 = CFrame.new(v157 + Vector3.new(0, 0.85, 0))
				end
				u158.CFrame = v162
				u158.Parent = workspace
				local u163 = Instance.new("Part")
				u163.Name = "BossDashLandFx"
				u163.Shape = Enum.PartType.Cylinder
				u163.Anchored = true
				u163.CanCollide = false
				u163.CanQuery = false
				u163.Material = Enum.Material.Neon
				u163.Color = Color3.fromRGB(255, 90, 110)
				local v164 = v150 * 2
				local v165 = v150 * 2
				u163.Size = Vector3.new(1.7, v164, v165)
				local v166 = CFrame.new
				local v167 = v153 + 0.85
				u163.CFrame = v166((Vector3.new(v144, v167, v148))) * CFrame.Angles(0, 0, 1.5707963267948966)
				u163.Transparency = 0.45
				u163.Parent = workspace
				local v168 = u3:Create(u163, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					["Transparency"] = 0.2
				})
				local u169 = u3:Create(u163, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
					["Transparency"] = 0.55
				})
				v168:Play()
				v168.Completed:Connect(function()

					u169:Play()
				end)
				task.delay(v152, function()

					if u158.Parent then
						u158:Destroy()
					end
					if u163.Parent then
						u163:Destroy()
					end
				end)
				return
			end
			if p92 == "CircleWarn" then
				local v170 = p93.x
				local v171 = type(v170) ~= "number" and 0 or v170
				local v172 = p93.y
				local v173 = type(v172) ~= "number" and 0 or v172
				local v174 = p93.z
				local v175 = type(v174) ~= "number" and 0 or v174
				local v176 = p93.r
				local v177 = type(v176) ~= "number" and 26 or v176
				local v178 = p93.t
				local v179 = type(v178) ~= "number" and 2.2 or v178
				local u180 = Instance.new("Part")
				u180.Name = "BossCircleWarnFx"
				u180.Shape = Enum.PartType.Cylinder
				u180.Anchored = true
				u180.CanCollide = false
				u180.CanQuery = false
				u180.Material = Enum.Material.Neon
				u180.Color = Color3.fromRGB(235, 45, 65)
				local v181 = v177 * 2
				local v182 = v177 * 2
				u180.Size = Vector3.new(1.7, v181, v182)
				u180.CFrame = CFrame.new(v171, v173 + 0.85, v175) * CFrame.Angles(0, 0, 1.5707963267948966)
				u180.Transparency = 0.52
				u180.Parent = workspace
				local u183 = Instance.new("Part")
				u183.Name = "BossCircleWarnRingFx"
				u183.Shape = Enum.PartType.Cylinder
				u183.Anchored = true
				u183.CanCollide = false
				u183.CanQuery = false
				u183.Material = Enum.Material.Neon
				u183.Color = Color3.fromRGB(255, 120, 70)
				local v184 = v177 * 2 + 4
				local v185 = v177 * 2 + 4
				u183.Size = Vector3.new(0.18, v184, v185)
				u183.CFrame = CFrame.new(v171, v173 + 0.04, v175) * CFrame.Angles(0, 0, 1.5707963267948966)
				u183.Transparency = 0.65
				u183.Parent = workspace
				local v186 = u3
				local v187 = TweenInfo.new
				local v188 = v179 * 0.18
				local v189 = v186:Create(u180, v187(math.min(0.4, v188), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					["Transparency"] = 0.22
				})
				local v190 = u3
				local v191 = TweenInfo.new
				local v192 = v179 * 0.2
				local v193 = v190:Create(u183, v191(math.min(0.45, v192), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["Transparency"] = 0.38
				})
				v189:Play()
				v193:Play()
				task.delay(v179, function()

					if u180.Parent then
						u180:Destroy()
					end
					if u183.Parent then
						u183:Destroy()
					end
				end)
				return
			end
			if p92 == "DashHit" then
				local v194 = p93.x
				local v195 = type(v194) ~= "number" and 0 or v194
				local v196 = p93.y
				local v197 = type(v196) ~= "number" and 0 or v196
				local v198 = p93.z
				local v199 = type(v198) ~= "number" and 0 or v198
				local v200 = Vector3.new(v195, v197, v199)
				local u201 = Instance.new("Part")
				u201.Shape = Enum.PartType.Ball
				u201.Anchored = true
				u201.CanCollide = false
				u201.Size = Vector3.new(6, 6, 6)
				u201.Transparency = 0.65
				u201.Color = Color3.fromRGB(255, 50, 80)
				u201.CFrame = CFrame.new(v200 + Vector3.new(0, 2, 0))
				u201.Parent = workspace
				u3:Create(u201, TweenInfo.new(0.2), {
					["Transparency"] = 1,
					["Size"] = Vector3.new(18, 18, 18)
				}):Play()
				task.delay(0.22, function()

					if u201.Parent then
						u201:Destroy()
					end
				end)
				return
			end
			if p92 == "PlaySound" then
				local v202 = p93.id
				if type(v202) == "string" then
					local v203 = p93.vol
					local v204 = type(v203) ~= "number" and 1 or v203
					local v205 = p93.pitch
					local v206 = type(v205) ~= "number" and 1 or v205
					local u207 = p93.global == true
					local u208
					if u207 then
						u208 = workspace.CurrentCamera or u43:FindFirstChild("PlayerGui")
					else
						local v209 = p93.x
						local v210 = type(v209) ~= "number" and 0 or v209
						local v211 = p93.y
						local v212 = type(v211) ~= "number" and 0 or v211
						local v213 = p93.z
						local v214 = type(v213) ~= "number" and 0 or v213
						local v215 = Vector3.new(v210, v212, v214)
						u208 = Instance.new("Part")
						u208.Transparency = 1
						u208.Anchored = true
						u208.CanCollide = false
						u208.CFrame = CFrame.new(v215)
						u208.Parent = workspace
					end
					if u208 then
						local u216 = Instance.new("Sound")
						u216.SoundId = v202
						u216.Volume = v204
						u216.PlaybackSpeed = v206
						u216.Parent = u208
						local v217 = p93.minDist
						local v218 = type(v217) ~= "number" and 0 or v217
						local v219 = p93.maxDist
						local v220 = type(v219) ~= "number" and 0 or v219
						if v218 > 0 then
							u216.RollOffMinDistance = v218
						end
						if v220 > 0 then
							u216.RollOffMaxDistance = v220
						end
						u216:Play()
						u216.Ended:Connect(function()

							if u207 then
								u216:Destroy()
							else
								u208:Destroy()
							end
						end)
						task.delay(10, function()

							if u207 or not (u208 and u208.Parent) then
								if u207 and u216.Parent then
									u216:Destroy()
								end
							else
								u208:Destroy()
							end
						end)
					end
				else
					return
				end
			end
			if p92 == "StopSound" then
				local v221 = p93.id
				if type(v221) == "string" then
					for _, v222 in { workspace.CurrentCamera, u43:FindFirstChild("PlayerGui") } do
						if v222 then
							for _, v223 in v222:GetChildren() do
								if v223:IsA("Sound") and v223.SoundId == v221 then
									v223:Stop()
									v223:Destroy()
								end
							end
						end
					end
				end
			end
			if p92 == "ScreenShake" then
				local v224 = p93.intensity
				local u225 = type(v224) ~= "number" and 1 or v224
				local v226 = p93.duration
				local u227 = type(v226) ~= "number" and 0.5 or v226
				local v228 = p93.x
				local v229 = p93.y
				local v230 = p93.z
				local u231 = workspace.CurrentCamera
				if u231 then
					if type(v228) == "number" and (type(v229) == "number" and type(v230) == "number") then
						local v232 = (u231.CFrame.Position - Vector3.new(v228, v229, v230)).Magnitude
						if v232 > 150 then
							return
						end
						local v233 = 1 - v232 / 150
						u225 = u225 * math.clamp(v233, 0, 1)
					end
					if u225 <= 0.01 then
						return
					end
					task.spawn(function()

						local v234 = os.clock()
						while os.clock() - v234 < u227 do
							local v235 = u225 * (1 - (os.clock() - v234) / u227)
							u231.CFrame = u231.CFrame * CFrame.new((math.random() - 0.5) * v235, (math.random() - 0.5) * v235, (math.random() - 0.5) * v235)
							u4.RenderStepped:Wait()
						end
					end)
				end
				return
			end
			if p92 == "DustPuff" then
				local v236 = p93.x
				local v237 = type(v236) ~= "number" and 0 or v236
				local v238 = p93.y
				local v239 = type(v238) ~= "number" and 0 or v238
				local v240 = p93.z
				local v241 = type(v240) ~= "number" and 0 or v240
				local v242 = Vector3.new(v237, v239, v241)
				local u243 = Instance.new("Part")
				u243.Transparency = 1
				u243.Anchored = true
				u243.CanCollide = false
				u243.CFrame = CFrame.new(v242)
				u243.Parent = workspace
				local v244 = Instance.new("Attachment")
				v244.Parent = u243
				local v245 = Instance.new("ParticleEmitter")
				v245.Color = ColorSequence.new(Color3.fromRGB(200, 200, 200))
				v245.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 2), NumberSequenceKeypoint.new(1, 0) })
				v245.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.5), NumberSequenceKeypoint.new(1, 1) })
				v245.Lifetime = NumberRange.new(0.5, 1)
				v245.Rate = 0
				v245.Speed = NumberRange.new(5, 10)
				v245.SpreadAngle = Vector2.new(0, 360)
				v245.Parent = v244
				v245:Emit(15)
				task.delay(1.5, function()

					u243:Destroy()
				end)
				return
			end
			if p92 == "MapBreak" then
				local u246 = workspace.CurrentCamera
				if u246 then
					local u247 = u246.CFrame
					task.spawn(function()

						for _ = 1, 8 do
							if not u246 or u246.Parent == nil then
								break
							end
							u246.CFrame = u247 * CFrame.new((math.random() - 0.5) * 0.8, (math.random() - 0.5) * 0.6, 0)
							task.wait(0.03)
						end
						if u246 then
							u246.CFrame = u247
						end
					end)
					return
				end
			elseif p92 == "SetCamera" then
				local v248 = workspace.CurrentCamera
				if not v248 then
					return
				end
				local v249 = p93.type
				if v249 == "Reset" then
					task.wait(0.1)
					u44 = false
					v248.CameraType = Enum.CameraType.Custom
					local v250 = u1.LocalPlayer.Character
					local v251 = v250 and v250:FindFirstChild("Humanoid")
					if v251 then
						v248.CameraSubject = v251
					end
					return
				end
				local v252 = CFrame.new
				local v253 = p93.cx
				local v254 = type(v253) ~= "number" and 0 or v253
				local v255 = p93.cy
				local v256 = type(v255) ~= "number" and 0 or v255
				local v257 = p93.cz
				local v258 = v252(v254, v256, type(v257) ~= "number" and 0 or v257)
				local v259 = p93.tx
				local v260 = type(v259) ~= "number" and 0 or v259
				local v261 = p93.ty
				local v262 = type(v261) ~= "number" and 0 or v261
				local v263 = p93.tz
				local v264 = type(v263) ~= "number" and 0 or v263
				local v265 = Vector3.new(v260, v262, v264)
				local v266 = CFrame.lookAt(v258.Position, v265)
				u44 = true
				v248.CameraType = Enum.CameraType.Scriptable
				v248.CameraSubject = nil
				if v249 == "Fixed" then
					v248.CFrame = v266
					return
				end
				if v249 == "Tween" then
					local v267 = p93.dur
					local v268 = type(v267) ~= "number" and 2 or v267
					u3:Create(v248, TweenInfo.new(v268, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
						["CFrame"] = v266
					}):Play()
					return
				end
			elseif p92 == "Presentation" then
				u44 = true
				local u269 = workspace.CurrentCamera
				if u269 then
					u269.CameraType = Enum.CameraType.Scriptable
					u269.CameraSubject = nil
				end
				task.wait(1)
				if not u269 then
					return
				end
				local v270 = workspace:FindFirstChild("BossRig_Live")
				if not v270 then
					for _, v271 in workspace:GetChildren() do
						if v271.Name:find("Boss") then
							v270 = v271
							break
						end
					end
				end
				local v272 = not v270 and Vector3.new(0, 20, -320) or v270:GetPivot().Position
				local _ = u269.CFrame
				local v273 = v272 + Vector3.new(0, 25, 60)
				local v274 = {
					["CFrame"] = CFrame.lookAt(v273, v272)
				}
				local v275 = u3:Create(u269, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), v274)
				v275:Play()
				v275.Completed:Connect(function()

					u89()
					task.wait(0.5)
					u44 = false
					u269.CameraType = Enum.CameraType.Custom
					local v276 = u43.Character
					if v276 then
						v276 = v276:FindFirstChildOfClass("Humanoid")
					end
					if v276 then
						u269.CameraSubject = v276
					end
				end)
			end
		end)
	end
end
return {
	["Stop"] = function() 

		u54()
	end,
	["Fire"] = function() 

		u54()
		u277()
	end
}