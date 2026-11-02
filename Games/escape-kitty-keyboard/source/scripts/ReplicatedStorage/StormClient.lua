

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("TweenService")
local u4 = game:GetService("Lighting")
local u5 = game:GetService("Debris")
local v6 = require(v2:WaitForChild("EventsConfig"))
local u7 = v1.LocalPlayer
local u8 = u7:WaitForChild("PlayerGui")
local v9 = {}
local u10 = v6.Storm
if not u10 then
	return v9
end
local u11 = v2:WaitForChild("Remotes")
local u12 = false
local u13 = v2:FindFirstChild(u10.LightningFolder or "Ligtning")
local function u21(p14) 

	if type(p14) == "table" and p14.position then
		local v15 = p14.position
		local v16 = u13 and u13:FindFirstChild("HitParticles")
		if v16 then
			local u17 = v16:Clone()
			u17.Position = v15
			u17.Parent = workspace
			u5:AddItem(u17, 3)
			task.delay(0.3, function()

				if u17 and u17.Parent then
					for _, v18 in ipairs(u17:GetDescendants()) do
						if v18:IsA("ParticleEmitter") or v18:IsA("PointLight") then
							v18.Enabled = false
						end
					end
				end
			end)
		end
		local v19 = u13 and u13:FindFirstChild("LightningSound")
		if v19 then
			local v20 = v19:Clone()
			v20.Volume = u10.LightningSoundVolume or 2
			v20.Parent = u8
			v20:Play()
			u5:AddItem(v20, 5)
		end
	end
end
local u22 = nil
local function u24() 

	if not u22 then
		u22 = {
			["Brightness"] = u4.Brightness,
			["Ambient"] = u4.Ambient,
			["OutdoorAmbient"] = u4.OutdoorAmbient,
			["FogEnd"] = u4.FogEnd,
			["FogColor"] = u4.FogColor
		}
		if not u4:FindFirstChild("StormCC") then
			local v23 = Instance.new("ColorCorrectionEffect")
			v23.Name = "StormCC"
			v23.Parent = u4
		end
		u22.Saturation = 0
		u22.TintColor = Color3.fromRGB(255, 255, 255)
	end
end
local function u52(p25, p26) 

	if p25 then
		u24()
		if p26 then
			if p25.Brightness then
				u4.Brightness = p25.Brightness
			end
			if p25.Ambient then
				local v27 = u4
				local v28 = p25.Ambient
				local v29
				if type(v28) == "table" and #v28 >= 3 then
					v29 = Color3.fromRGB(v28[1], v28[2], v28[3])
				else
					v29 = Color3.fromRGB(255, 255, 255)
				end
				v27.Ambient = v29
			end
			if p25.OutdoorAmbient then
				local v30 = u4
				local v31 = p25.OutdoorAmbient
				local v32
				if type(v31) == "table" and #v31 >= 3 then
					v32 = Color3.fromRGB(v31[1], v31[2], v31[3])
				else
					v32 = Color3.fromRGB(255, 255, 255)
				end
				v30.OutdoorAmbient = v32
			end
			if p25.FogEnd then
				u4.FogEnd = p25.FogEnd
			end
			if p25.FogColor then
				local v33 = u4
				local v34 = p25.FogColor
				local v35
				if type(v34) == "table" and #v34 >= 3 then
					v35 = Color3.fromRGB(v34[1], v34[2], v34[3])
				else
					v35 = Color3.fromRGB(255, 255, 255)
				end
				v33.FogColor = v35
			end
			local v36 = u4:FindFirstChild("StormCC")
			if v36 then
				if p25.Saturation then
					v36.Saturation = p25.Saturation
				end
				if p25.ColorTint then
					local v37 = p25.ColorTint
					local v38
					if type(v37) == "table" and #v37 >= 3 then
						v38 = Color3.fromRGB(v37[1], v37[2], v37[3])
					else
						v38 = Color3.fromRGB(255, 255, 255)
					end
					v36.TintColor = v38
				end
			end
		else
			local v39 = p25.SkyTween or 2
			local v40 = TweenInfo.new(v39, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
			local v41 = {}
			if p25.Brightness then
				v41.Brightness = p25.Brightness
			end
			if p25.Ambient then
				local v42 = p25.Ambient
				local v43
				if type(v42) == "table" and #v42 >= 3 then
					v43 = Color3.fromRGB(v42[1], v42[2], v42[3])
				else
					v43 = Color3.fromRGB(255, 255, 255)
				end
				v41.Ambient = v43
			end
			if p25.OutdoorAmbient then
				local v44 = p25.OutdoorAmbient
				local v45
				if type(v44) == "table" and #v44 >= 3 then
					v45 = Color3.fromRGB(v44[1], v44[2], v44[3])
				else
					v45 = Color3.fromRGB(255, 255, 255)
				end
				v41.OutdoorAmbient = v45
			end
			if p25.FogEnd then
				v41.FogEnd = p25.FogEnd
			end
			if p25.FogColor then
				local v46 = p25.FogColor
				local v47
				if type(v46) == "table" and #v46 >= 3 then
					v47 = Color3.fromRGB(v46[1], v46[2], v46[3])
				else
					v47 = Color3.fromRGB(255, 255, 255)
				end
				v41.FogColor = v47
			end
			if next(v41) then
				u3:Create(u4, v40, v41):Play()
			end
			local v48 = u4:FindFirstChild("StormCC")
			if v48 then
				local v49 = {}
				if p25.Saturation then
					v49.Saturation = p25.Saturation
				end
				if p25.ColorTint then
					local v50 = p25.ColorTint
					local v51
					if type(v50) == "table" and #v50 >= 3 then
						v51 = Color3.fromRGB(v50[1], v50[2], v50[3])
					else
						v51 = Color3.fromRGB(255, 255, 255)
					end
					v49.TintColor = v51
				end
				if next(v49) then
					u3:Create(v48, v40, v49):Play()
				end
			end
		end
	else
		return
	end
end
local function u56() 

	if u22 then
		local v53 = u10.SkyRestoreDuration or 3
		local v54 = TweenInfo.new(v53, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		u3:Create(u4, v54, {
			["Brightness"] = u22.Brightness,
			["Ambient"] = u22.Ambient,
			["OutdoorAmbient"] = u22.OutdoorAmbient,
			["FogEnd"] = u22.FogEnd,
			["FogColor"] = u22.FogColor
		}):Play()
		local u55 = u4:FindFirstChild("StormCC")
		if u55 then
			u3:Create(u55, v54, {
				["Saturation"] = u22.Saturation,
				["TintColor"] = u22.TintColor
			}):Play()
			task.delay(v53 + 0.5, function()

				if u55 and u55.Parent then
					u55:Destroy()
				end
			end)
		end
		u22 = nil
	end
end
local function u60(p57) 

	if type(p57) == "table" then
		local v58 = p57.action
		if v58 == "start" then
			local v59 = p57.wave
			if v59 and v59.Sky then
				u52(v59.Sky, p57.instant)
				return
			end
		else
			if v58 == "stop" then
				return
			end
			if v58 == "end" then
				u56()
			end
		end
	end
end
local function u77(p61) 

	if type(p61) == "table" then
		if p61.skyWaveIndex and p61.skyWaveIndex > 0 then
			local v62 = u10.Waves
			if v62 and v62[p61.skyWaveIndex] then
				local v63 = v62[p61.skyWaveIndex]
				if v63.Sky then
					local v64 = v63.Sky
					if not v64 then
						return
					end
					u24()
					if v64.Brightness then
						u4.Brightness = v64.Brightness
					end
					if v64.Ambient then
						local v65 = u4
						local v66 = v64.Ambient
						local v67
						if type(v66) == "table" and #v66 >= 3 then
							v67 = Color3.fromRGB(v66[1], v66[2], v66[3])
						else
							v67 = Color3.fromRGB(255, 255, 255)
						end
						v65.Ambient = v67
					end
					if v64.OutdoorAmbient then
						local v68 = u4
						local v69 = v64.OutdoorAmbient
						local v70
						if type(v69) == "table" and #v69 >= 3 then
							v70 = Color3.fromRGB(v69[1], v69[2], v69[3])
						else
							v70 = Color3.fromRGB(255, 255, 255)
						end
						v68.OutdoorAmbient = v70
					end
					if v64.FogEnd then
						u4.FogEnd = v64.FogEnd
					end
					if v64.FogColor then
						local v71 = u4
						local v72 = v64.FogColor
						local v73
						if type(v72) == "table" and #v72 >= 3 then
							v73 = Color3.fromRGB(v72[1], v72[2], v72[3])
						else
							v73 = Color3.fromRGB(255, 255, 255)
						end
						v71.FogColor = v73
					end
					local v74 = u4:FindFirstChild("StormCC")
					if v74 then
						if v64.Saturation then
							v74.Saturation = v64.Saturation
						end
						if v64.ColorTint then
							local v75 = v64.ColorTint
							local v76
							if type(v75) == "table" and #v75 >= 3 then
								v76 = Color3.fromRGB(v75[1], v75[2], v75[3])
							else
								v76 = Color3.fromRGB(255, 255, 255)
							end
							v74.TintColor = v76
						end
					end
				end
			end
		end
	end
end
local u78 = u10.AdminUserId or 0
local u79 = nil
local u80 = false
local u81 = {}
local u82 = nil
local function u142() 

	if u7.UserId == u78 then
		local v83 = Color3.fromRGB(30, 30, 35)
		local u84 = Color3.fromRGB(40, 40, 48)
		local v85 = Color3.fromRGB(40, 160, 70)
		local v86 = Color3.fromRGB(180, 50, 50)
		local u87 = Color3.fromRGB(50, 110, 190)
		local u88 = Color3.fromRGB(130, 60, 180)
		local u89 = Color3.fromRGB(230, 230, 235)
		local u90 = Color3.fromRGB(160, 160, 170)
		local u91 = Instance.new("ScreenGui")
		u91.Name = "StormAdminPanel"
		u91.DisplayOrder = 200
		u91.ResetOnSpawn = false
		u91.Enabled = false
		u91.Parent = u8
		u79 = u91
		local u92 = Instance.new("Frame")
		u92.Name = "Main"
		u92.Size = UDim2.new(0, 340, 0, 400)
		u92.Position = UDim2.new(0.5, 0, 0.5, 0)
		u92.AnchorPoint = Vector2.new(0.5, 0.5)
		u92.BackgroundColor3 = v83
		u92.BackgroundTransparency = 0.02
		u92.BorderSizePixel = 0
		u92.Parent = u91
		local u93 = false
		local u94 = nil
		local u95 = nil
		local v96 = game:GetService("UserInputService")
		u92.InputBegan:Connect(function(p97)

			if (p97.UserInputType == Enum.UserInputType.MouseButton1 or p97.UserInputType == Enum.UserInputType.Touch) and p97.Position.Y - u92.AbsolutePosition.Y <= 38 then
				u93 = true
				u94 = p97.Position
				u95 = u92.Position
			end
		end)
		v96.InputChanged:Connect(function(p98)

			if u93 and (p98.UserInputType == Enum.UserInputType.MouseMovement or p98.UserInputType == Enum.UserInputType.Touch) then
				local v99 = p98.Position - u94
				u92.Position = UDim2.new(u95.X.Scale, u95.X.Offset + v99.X, u95.Y.Scale, u95.Y.Offset + v99.Y)
			end
		end)
		v96.InputEnded:Connect(function(p100)

			if p100.UserInputType == Enum.UserInputType.MouseButton1 or p100.UserInputType == Enum.UserInputType.Touch then
				u93 = false
			end
		end)
		Instance.new("UICorner", u92).CornerRadius = UDim.new(0, 10)
		local v101 = Instance.new("UIStroke")
		v101.Color = Color3.fromRGB(80, 80, 100)
		v101.Thickness = 1.5
		v101.Parent = u92
		local u102 = Instance.new("ScrollingFrame")
		u102.Size = UDim2.new(1, -16, 1, -50)
		u102.Position = UDim2.new(0, 8, 0, 42)
		u102.BackgroundTransparency = 1
		u102.ScrollBarThickness = 4
		u102.CanvasSize = UDim2.new(0, 0, 0, 0)
		u102.AutomaticCanvasSize = Enum.AutomaticSize.Y
		u102.Parent = u92
		local v103 = Instance.new("UIListLayout")
		v103.SortOrder = Enum.SortOrder.LayoutOrder
		v103.Padding = UDim.new(0, 6)
		v103.Parent = u102
		local v104 = Instance.new("UIPadding")
		v104.PaddingLeft = UDim.new(0, 4)
		v104.PaddingRight = UDim.new(0, 4)
		v104.PaddingTop = UDim.new(0, 4)
		v104.Parent = u102
		local v105 = Instance.new("TextLabel")
		v105.Size = UDim2.new(1, 0, 0, 38)
		v105.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
		v105.BackgroundTransparency = 0.1
		v105.BorderSizePixel = 0
		v105.Text = "STORM CONTROL"
		v105.TextColor3 = u89
		v105.TextSize = 16
		v105.Font = Enum.Font.GothamBold
		v105.Parent = u92
		Instance.new("UICorner", v105).CornerRadius = UDim.new(0, 10)
		local v106 = Instance.new("TextButton")
		v106.Size = UDim2.new(0, 30, 0, 30)
		v106.Position = UDim2.new(1, -34, 0, 4)
		v106.BackgroundColor3 = v86
		v106.BackgroundTransparency = 0.3
		v106.Text = "X"
		v106.TextColor3 = u89
		v106.TextSize = 14
		v106.Font = Enum.Font.GothamBold
		v106.BorderSizePixel = 0
		v106.Parent = u92
		Instance.new("UICorner", v106).CornerRadius = UDim.new(0, 6)
		v106.MouseButton1Click:Connect(function()

			u91.Enabled = false
		end)
		local u107 = 0
		local function v110(p108) 

			u107 = u107 + 1
			local v109 = Instance.new("TextLabel")
			v109.Size = UDim2.new(1, 0, 0, 22)
			v109.BackgroundTransparency = 1
			v109.Text = p108
			v109.TextColor3 = u90
			v109.TextSize = 11
			v109.Font = Enum.Font.GothamBold
			v109.TextXAlignment = Enum.TextXAlignment.Left
			v109.LayoutOrder = u107
			v109.Parent = u102
		end
		local function v116(p111, p112, p113, p114) 

			local v115 = Instance.new("TextButton")
			v115.Size = p114 or UDim2.new(0, 100, 0, 30)
			v115.BackgroundColor3 = p112
			v115.Text = p111
			v115.TextColor3 = u89
			v115.TextSize = 12
			v115.Font = Enum.Font.GothamBold
			v115.BorderSizePixel = 0
			v115.AutoButtonColor = true
			v115.Parent = p113
			Instance.new("UICorner", v115).CornerRadius = UDim.new(0, 6)
			return v115
		end
		v110("STATUS")
		u107 = u107 + 1
		local v117 = Instance.new("Frame")
		v117.Size = UDim2.new(1, 0, 0, 34)
		v117.BackgroundTransparency = 1
		v117.LayoutOrder = u107
		v117.Parent = u102
		v117.BackgroundColor3 = u84
		v117.BackgroundTransparency = 0.3
		Instance.new("UICorner", v117).CornerRadius = UDim.new(0, 6)
		local v118 = Instance.new("TextLabel")
		v118.Size = UDim2.new(1, -12, 1, 0)
		v118.Position = UDim2.new(0, 6, 0, 0)
		v118.BackgroundTransparency = 1
		v118.Text = "Wave: None | Lightning: OFF"
		v118.TextColor3 = Color3.fromRGB(120, 220, 160)
		v118.TextSize = 11
		v118.Font = Enum.Font.GothamMedium
		v118.TextXAlignment = Enum.TextXAlignment.Left
		v118.TextWrapped = true
		v118.Parent = v117
		u81.main = v118
		v110("SCOPE")
		u107 = u107 + 1
		local v119 = Instance.new("Frame")
		v119.Size = UDim2.new(1, 0, 0, 30)
		v119.BackgroundTransparency = 1
		v119.LayoutOrder = u107
		v119.Parent = u102
		local u120 = v116("This Server", u87, v119, UDim2.new(0.48, 0, 1, 0))
		u120.Position = UDim2.new(0, 0, 0, 0)
		local u121 = v116("All Servers", u84, v119, UDim2.new(0.48, 0, 1, 0))
		u121.Position = UDim2.new(0.52, 0, 0, 0)
		u121.BackgroundTransparency = 0.3
		u120.MouseButton1Click:Connect(function()

			u80 = false
			if u80 then
				u120.BackgroundColor3 = u84
				u120.BackgroundTransparency = 0.3
				u121.BackgroundColor3 = u88
				u121.BackgroundTransparency = 0
			else
				u120.BackgroundColor3 = u87
				u120.BackgroundTransparency = 0
				u121.BackgroundColor3 = u84
				u121.BackgroundTransparency = 0.3
			end
		end)
		u121.MouseButton1Click:Connect(function()

			u80 = true
			if u80 then
				u120.BackgroundColor3 = u84
				u120.BackgroundTransparency = 0.3
				u121.BackgroundColor3 = u88
				u121.BackgroundTransparency = 0
			else
				u120.BackgroundColor3 = u87
				u120.BackgroundTransparency = 0
				u121.BackgroundColor3 = u84
				u121.BackgroundTransparency = 0.3
			end
		end)
		v110("EVENT")
		u107 = u107 + 1
		local v122 = Instance.new("Frame")
		v122.Size = UDim2.new(1, 0, 0, 34)
		v122.BackgroundTransparency = 1
		v122.LayoutOrder = u107
		v122.Parent = u102
		local v123 = v116("Full Auto", v85, v122, UDim2.new(0.48, -2, 1, 0))
		v123.Position = UDim2.new(0, 0, 0, 0)
		v123.MouseButton1Click:Connect(function()

			if u82 then
				u82:FireServer({
					["action"] = "fullAuto",
					["allServers"] = u80
				})
			end
		end)
		local v124 = v116("Stop All", v86, v122, UDim2.new(0.48, -2, 1, 0))
		v124.Position = UDim2.new(0.52, 0, 0, 0)
		v124.MouseButton1Click:Connect(function()

			if u82 then
				u82:FireServer({
					["action"] = "stopAll",
					["allServers"] = u80
				})
			end
		end)
		v110("WAVES")
		u107 = u107 + 1
		local v125 = Instance.new("Frame")
		v125.Size = UDim2.new(1, 0, 0, 34)
		v125.BackgroundTransparency = 1
		v125.LayoutOrder = u107
		v125.Parent = u102
		local v126 = v125
		local u127 = 1
		local u128 = Instance.new("TextButton")
		u128.Size = UDim2.new(0.36, -2, 1, 0)
		u128.Position = UDim2.new(0, 0, 0, 0)
		u128.BackgroundColor3 = u84
		u128.Text = "Wave 1"
		u128.TextColor3 = u89
		u128.TextSize = 12
		u128.Font = Enum.Font.GothamBold
		u128.BorderSizePixel = 0
		u128.Parent = v126
		Instance.new("UICorner", u128).CornerRadius = UDim.new(0, 6)
		u128.MouseButton1Click:Connect(function()

			local v129 = u10.Waves or {}
			u127 = u127 % #v129 + 1
			local v130 = v129[u127]
			u128.Text = "Wave " .. u127 .. (v130 and " - " .. v130.Name or "")
		end)
		local v131 = v116("Start", v85, v126, UDim2.new(0.3, -2, 1, 0))
		v131.Position = UDim2.new(0.38, 0, 0, 0)
		v131.MouseButton1Click:Connect(function()

			local v132 = {
				["waveIndex"] = u127
			}
			if u82 then
				u82:FireServer({
					["action"] = "startWave",
					["args"] = v132,
					["allServers"] = u80
				})
			end
		end)
		local v133 = v116("Stop", v86, v126, UDim2.new(0.3, -2, 1, 0))
		v133.Position = UDim2.new(0.7, 0, 0, 0)
		v133.MouseButton1Click:Connect(function()

			if u82 then
				u82:FireServer({
					["action"] = "stopWave",
					["allServers"] = u80
				})
			end
		end)
		v110("AMBIANCE / SKY")
		u107 = u107 + 1
		local v134 = Instance.new("Frame")
		v134.Size = UDim2.new(1, 0, 0, 34)
		v134.BackgroundTransparency = 1
		v134.LayoutOrder = u107
		v134.Parent = u102
		local v135 = v134
		local u136 = 0
		local u137 = Instance.new("TextButton")
		u137.Size = UDim2.new(0.55, -2, 1, 0)
		u137.Position = UDim2.new(0, 0, 0, 0)
		u137.BackgroundColor3 = u84
		u137.Text = "Normal"
		u137.TextColor3 = u89
		u137.TextSize = 12
		u137.Font = Enum.Font.GothamBold
		u137.BorderSizePixel = 0
		u137.Parent = v135
		Instance.new("UICorner", u137).CornerRadius = UDim.new(0, 6)
		u137.MouseButton1Click:Connect(function()

			local v138 = u10.Waves or {}
			u136 = (u136 + 1) % (#v138 + 1)
			if u136 == 0 then
				u137.Text = "Normal"
			else
				local v139 = v138[u136]
				u137.Text = "Wave " .. u136 .. (v139 and " - " .. v139.Name or "")
			end
		end)
		local v140 = v116("Apply", u87, v135, UDim2.new(0.43, -2, 1, 0))
		v140.Position = UDim2.new(0.57, 0, 0, 0)
		v140.MouseButton1Click:Connect(function()

			if u136 == 0 then
				if u82 then
					u82:FireServer({
						["action"] = "restoreSky",
						["allServers"] = u80
					})
				end
			else
				local v141 = {
					["waveIndex"] = u136
				}
				if u82 then
					u82:FireServer({
						["action"] = "applySky",
						["args"] = v141,
						["allServers"] = u80
					})
				end
			end
		end)
	end
end
local function u146(p143) 

	if u81.main then
		if type(p143) == "table" then
			local v144 = p143.lightning and "ON" or "OFF"
			local v145 = p143.fullAuto and " | AUTO" or ""
			u81.main.Text = "Wave: " .. (p143.wave or "None") .. " | Lightning: " .. v144 .. v145
		end
	else
		return
	end
end
function v9.Init(_) 

	if not u12 then
		u12 = true
		u11:WaitForChild("StormLightning").OnClientEvent:Connect(u21)
		u11:WaitForChild("StormWave").OnClientEvent:Connect(u60)
		u11:WaitForChild("StormSync").OnClientEvent:Connect(u77)
		if u7.UserId == u78 then
			u82 = u11:WaitForChild("StormAdmin")
			u11:WaitForChild("StormStatus").OnClientEvent:Connect(u146)
			u142()
			if u7.UserId ~= u78 then
				return
			end
			task.spawn(function()

				local v147 = u8:WaitForChild("AdminMenuGUI_v2", 30)
				if v147 then
					local v148 = v147:WaitForChild("Panel", 10)
					if v148 then
						local v149 = v148:WaitForChild("StormButton", 10)
						if v149 then
							v149.MouseButton1Click:Connect(function()

								if u79 then
									u79.Enabled = not u79.Enabled
								end
							end)
						end
					else
						return
					end
				else
					return
				end
			end)
		end
	end
end
return v9