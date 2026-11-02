

local u1 = game:GetService("CollectionService")
local v2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("TweenService")
local u5 = game:GetService("ContentProvider")
local u6 = game:GetService("RunService")
local u7 = game:GetService("Lighting")
local u8 = game:GetService("Debris")
local u9 = game:GetService("SoundService")
local v10 = require(v3:WaitForChild("EventsConfig"))
local u11 = v2.LocalPlayer
local u12 = u11:WaitForChild("PlayerGui")
local v13 = {}
local u14 = v10.EggRain
if not u14 then
	return v13
end
local u15 = v3:WaitForChild("Remotes")
local v16 = v3:WaitForChild("Templates")
local u17 = false
local u18 = {}
local u19 = nil
local function u23(p20, p21) 
	if p20:IsA("BasePart") then
		p20.Transparency = p21
		p20.CanCollide = false
	end
	for _, v22 in ipairs(p20:GetDescendants()) do
		if v22:IsA("BasePart") then
			v22.Transparency = p21
			v22.CanCollide = false
		elseif v22:IsA("Decal") or v22:IsA("Texture") then
			v22.Transparency = p21
		end
	end
end
local function u27(p24) 

	local v25 = Instance.new("Sound")
	v25.SoundId = u14.SpawnSound
	v25.Volume = u14.SpawnSoundVolume or 1
	v25.RollOffMaxDistance = 150
	v25.RollOffMinDistance = 10
	local v26 = Instance.new("Part")
	v26.Size = Vector3.new(1, 1, 1)
	v26.Transparency = 1
	v26.Anchored = true
	v26.CanCollide = false
	v26.CFrame = CFrame.new(p24)
	v26.Parent = workspace
	v25.Parent = v26
	v25:Play()
	game:GetService("Debris"):AddItem(v26, 5)
end
local function u31(p28) 

	u18[p28] = true
	for _, v29 in ipairs(u1:GetTagged("EggRainEgg")) do
		if v29:GetAttribute("EggId") == p28 then
			u23(v29, 1)
			break
		end
	end
	if u14.CollectSound then
		local v30 = Instance.new("Sound")
		v30.SoundId = u14.CollectSound
		v30.Volume = u14.CollectSoundVol or 1
		v30.Parent = u12
		v30:Play()
		u8:AddItem(v30, 3)
	end
end
local u32 = u14.AnnounceDuration or 10
local u33 = u14.AnnounceFadeIn or 0.4
local u34 = u14.AnnounceFadeOut or 0.5
local u35 = v3:WaitForChild("NotificationFrame")
local function u40(p36) 
	local v37 = {}
	for _, v38 in ipairs(p36:GetDescendants()) do
		if v38:IsA("UIGradient") then
			local v39 = {
				["obj"] = v38,
				["original"] = v38.Transparency
			}
			table.insert(v37, v39)
		end
	end
	return v37
end
local function u44(p41) 
	local v42 = {}
	for _, v43 in ipairs(p41:GetDescendants()) do
		if v43:IsA("UIStroke") then
			table.insert(v42, {
				["prop"] = "Transparency",
				["obj"] = v43
			})
		elseif v43:IsA("TextLabel") or v43:IsA("TextButton") then
			table.insert(v42, {
				["prop"] = "TextTransparency",
				["obj"] = v43
			})
			if v43.BackgroundTransparency < 1 then
				table.insert(v42, {
					["prop"] = "BackgroundTransparency",
					["obj"] = v43
				})
			end
		elseif v43:IsA("ImageLabel") or v43:IsA("ImageButton") then
			table.insert(v42, {
				["prop"] = "ImageTransparency",
				["obj"] = v43
			})
			if v43.BackgroundTransparency < 1 then
				table.insert(v42, {
					["prop"] = "BackgroundTransparency",
					["obj"] = v43
				})
			end
		elseif v43:IsA("Frame") and v43.BackgroundTransparency < 1 then
			table.insert(v42, {
				["prop"] = "BackgroundTransparency",
				["obj"] = v43
			})
		end
	end
	if p41:IsA("Frame") and p41.BackgroundTransparency < 1 then
		table.insert(v42, {
			["prop"] = "BackgroundTransparency",
			["obj"] = p41
		})
	end
	return v42
end
local function u64(p45) 

	local v46 = u12:FindFirstChild("AdminAnnounce")
	if v46 then
		v46 = v46:FindFirstChild("MainFrame")
	end
	if v46 then
		local u47 = u35:Clone()
		local v48 = u47:FindFirstChild("Text")
		if v48 then
			v48.RichText = true
			v48.Text = "<font color=\"rgb(85,170,255)\"><b>" .. (u14.AdminUsername or "Admin") .. "</b></font>\238\128\128 : " .. p45
		end
		local u49 = u44(u47)
		local u50 = u40(u47)
		local v51 = {}
		for v52, v53 in ipairs(u49) do
			v51[v52] = v53.obj[v53.prop]
			v53.obj[v53.prop] = 1
		end
		local u54 = NumberSequence.new(1)
		for _, v55 in ipairs(u50) do
			v55.obj.Transparency = u54
		end
		u47.Parent = v46
		if u14.AnnounceSound then
			local v56 = Instance.new("Sound")
			v56.SoundId = u14.AnnounceSound
			v56.Volume = u14.AnnounceSoundVol or 0.8
			v56.Parent = u12
			v56:Play()
			game:GetService("Debris"):AddItem(v56, 5)
		end
		local v57 = TweenInfo.new(u33, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		for v58, v59 in ipairs(u49) do
			u4:Create(v59.obj, v57, {
				[v59.prop] = v51[v58]
			}):Play()
		end
		for _, v60 in ipairs(u50) do
			v60.obj.Transparency = v60.original
		end
		task.delay(u32, function()

			local v61 = TweenInfo.new(u34, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			for _, v62 in ipairs(u49) do
				u4:Create(v62.obj, v61, {
					[v62.prop] = 1
				}):Play()
			end
			for _, v63 in ipairs(u50) do
				v63.obj.Transparency = u54
			end
			task.delay(u34, function()

				if u47 and u47.Parent then
					u47:Destroy()
				end
			end)
		end)
	else
		warn("[EggRainClient] AdminAnnounce/MainFrame introuvable dans PlayerGui")
	end
end
local u65 = v16:WaitForChild("GoldenEggNotifFrame")
local function u83() 

	local v66 = u12:FindFirstChild("SpecialNotif")
	if v66 then
		v66 = v66:FindFirstChild("MainFrame")
	end
	if v66 then
		local u67 = u65:Clone()
		local u68 = u44(u67)
		local u69 = u40(u67)
		local v70 = {}
		for v71, v72 in ipairs(u68) do
			v70[v71] = v72.obj[v72.prop]
			v72.obj[v72.prop] = 1
		end
		local u73 = NumberSequence.new(1)
		for _, v74 in ipairs(u69) do
			v74.obj.Transparency = u73
		end
		u67.Parent = v66
		if u14.GoldenNotifSound then
			local v75 = Instance.new("Sound")
			v75.SoundId = u14.GoldenNotifSound
			v75.Volume = u14.GoldenNotifSVol or 1
			v75.Parent = u12
			v75:Play()
			u8:AddItem(v75, 5)
		end
		local v76 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		for v77, v78 in ipairs(u68) do
			u4:Create(v78.obj, v76, {
				[v78.prop] = v70[v77]
			}):Play()
		end
		for _, v79 in ipairs(u69) do
			v79.obj.Transparency = v79.original
		end
		task.delay(u14.GoldenNotifDuration or 3, function()

			local v80 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			for _, v81 in ipairs(u68) do
				u4:Create(v81.obj, v80, {
					[v81.prop] = 1
				}):Play()
			end
			for _, v82 in ipairs(u69) do
				v82.obj.Transparency = u73
			end
			task.delay(0.6, function()

				if u67 and u67.Parent then
					u67:Destroy()
				end
			end)
		end)
	else
		warn("[EggRainClient] SpecialNotif/MainFrame introuvable dans PlayerGui")
	end
end
local u84 = nil
local function u86() 

	if not u84 then
		u84 = {
			["Brightness"] = u7.Brightness,
			["Ambient"] = u7.Ambient,
			["OutdoorAmbient"] = u7.OutdoorAmbient,
			["FogEnd"] = u7.FogEnd,
			["FogColor"] = u7.FogColor
		}
		if not u7:FindFirstChild("EggRainCC") then
			local v85 = Instance.new("ColorCorrectionEffect")
			v85.Name = "EggRainCC"
			v85.Parent = u7
		end
		u84.Saturation = 0
		u84.TintColor = Color3.fromRGB(255, 255, 255)
	end
end
local function u114(p87, p88) 

	if p87 then
		u86()
		if p88 then
			if p87.Brightness then
				u7.Brightness = p87.Brightness
			end
			if p87.Ambient then
				local v89 = u7
				local v90 = p87.Ambient
				local v91
				if type(v90) == "table" and #v90 >= 3 then
					v91 = Color3.fromRGB(v90[1], v90[2], v90[3])
				else
					v91 = Color3.fromRGB(255, 255, 255)
				end
				v89.Ambient = v91
			end
			if p87.OutdoorAmbient then
				local v92 = u7
				local v93 = p87.OutdoorAmbient
				local v94
				if type(v93) == "table" and #v93 >= 3 then
					v94 = Color3.fromRGB(v93[1], v93[2], v93[3])
				else
					v94 = Color3.fromRGB(255, 255, 255)
				end
				v92.OutdoorAmbient = v94
			end
			if p87.FogEnd then
				u7.FogEnd = p87.FogEnd
			end
			if p87.FogColor then
				local v95 = u7
				local v96 = p87.FogColor
				local v97
				if type(v96) == "table" and #v96 >= 3 then
					v97 = Color3.fromRGB(v96[1], v96[2], v96[3])
				else
					v97 = Color3.fromRGB(255, 255, 255)
				end
				v95.FogColor = v97
			end
			local v98 = u7:FindFirstChild("EggRainCC")
			if v98 then
				if p87.Saturation then
					v98.Saturation = p87.Saturation
				end
				if p87.ColorTint then
					local v99 = p87.ColorTint
					local v100
					if type(v99) == "table" and #v99 >= 3 then
						v100 = Color3.fromRGB(v99[1], v99[2], v99[3])
					else
						v100 = Color3.fromRGB(255, 255, 255)
					end
					v98.TintColor = v100
				end
			end
		else
			local v101 = p87.SkyTween or 2
			local v102 = TweenInfo.new(v101, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
			local v103 = {}
			if p87.Brightness then
				v103.Brightness = p87.Brightness
			end
			if p87.Ambient then
				local v104 = p87.Ambient
				local v105
				if type(v104) == "table" and #v104 >= 3 then
					v105 = Color3.fromRGB(v104[1], v104[2], v104[3])
				else
					v105 = Color3.fromRGB(255, 255, 255)
				end
				v103.Ambient = v105
			end
			if p87.OutdoorAmbient then
				local v106 = p87.OutdoorAmbient
				local v107
				if type(v106) == "table" and #v106 >= 3 then
					v107 = Color3.fromRGB(v106[1], v106[2], v106[3])
				else
					v107 = Color3.fromRGB(255, 255, 255)
				end
				v103.OutdoorAmbient = v107
			end
			if p87.FogEnd then
				v103.FogEnd = p87.FogEnd
			end
			if p87.FogColor then
				local v108 = p87.FogColor
				local v109
				if type(v108) == "table" and #v108 >= 3 then
					v109 = Color3.fromRGB(v108[1], v108[2], v108[3])
				else
					v109 = Color3.fromRGB(255, 255, 255)
				end
				v103.FogColor = v109
			end
			if next(v103) then
				u4:Create(u7, v102, v103):Play()
			end
			local v110 = u7:FindFirstChild("EggRainCC")
			if v110 then
				local v111 = {}
				if p87.Saturation then
					v111.Saturation = p87.Saturation
				end
				if p87.ColorTint then
					local v112 = p87.ColorTint
					local v113
					if type(v112) == "table" and #v112 >= 3 then
						v113 = Color3.fromRGB(v112[1], v112[2], v112[3])
					else
						v113 = Color3.fromRGB(255, 255, 255)
					end
					v111.TintColor = v113
				end
				if next(v111) then
					u4:Create(v110, v102, v111):Play()
				end
			end
		end
	else
		return
	end
end
local function u118() 

	if u84 then
		local v115 = u14.SkyRestoreDuration or 3
		local v116 = TweenInfo.new(v115, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		u4:Create(u7, v116, {
			["Brightness"] = u84.Brightness,
			["Ambient"] = u84.Ambient,
			["OutdoorAmbient"] = u84.OutdoorAmbient,
			["FogEnd"] = u84.FogEnd,
			["FogColor"] = u84.FogColor
		}):Play()
		local u117 = u7:FindFirstChild("EggRainCC")
		if u117 then
			u4:Create(u117, v116, {
				["Saturation"] = u84.Saturation,
				["TintColor"] = u84.TintColor
			}):Play()
			task.delay(v115 + 0.5, function()

				if u117 and u117.Parent then
					u117:Destroy()
				end
			end)
		end
		u84 = nil
	end
end
local u119 = nil
local u120 = 0
local u121 = 0
local u122 = nil
local function u131(p123) 

	u121 = p123 or 0
	if u121 <= 0 then
		return
	else
		if u122 then
			task.cancel(u122)
			u122 = nil
		end
		local u124 = u14.ShakeFadeIn or 0.5
		task.spawn(function()

			local v125 = tick()
			while u120 < u121 and tick() - v125 < u124 do
				local v126 = (tick() - v125) / u124
				u120 = u121 * math.min(1, v126)
				task.wait()
			end
			u120 = u121
		end)
		if not u119 then
			u119 = u6.RenderStepped:Connect(function()

				local v127 = u11.Character
				if v127 then
					v127 = v127:FindFirstChildOfClass("Humanoid")
				end
				if v127 and u120 > 0 then
					local v128 = (math.random() - 0.5) * 2 * u120
					local v129 = (math.random() - 0.5) * 2 * u120
					local v130 = (math.random() - 0.5) * 2 * u120
					v127.CameraOffset = Vector3.new(v128, v129, v130)
				end
			end)
		end
	end
end
local function u143(p132) 

	local v133 = p132.number
	local v134 = p132.text or tostring(v133)
	local v135 = v133 == 0
	local u136 = Instance.new("ScreenGui")
	u136.Name = "EggRainCountdown"
	u136.ResetOnSpawn = false
	u136.DisplayOrder = 110
	u136.Parent = u12
	local u137 = Instance.new("TextLabel")
	u137.Size = UDim2.new(0.6, 0, 0.2, 0)
	u137.Position = UDim2.new(0.5, 0, 0.2, 0)
	u137.AnchorPoint = Vector2.new(0.5, 0.5)
	u137.BackgroundTransparency = 1
	u137.Text = v134
	u137.TextScaled = false
	u137.TextSize = u14.CountdownTextSize or 120
	u137.Font = Enum.Font.GothamBlack
	local v138 = u14.CountdownColor
	if v138 and type(v138) == "table" then
		u137.TextColor3 = Color3.fromRGB(v138[1], v138[2], v138[3])
	else
		u137.TextColor3 = Color3.fromRGB(255, 255, 255)
	end
	u137.TextStrokeTransparency = 0
	u137.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	u137.TextTransparency = 1
	u137.Parent = u136
	local u139 = Instance.new("UIStroke")
	u139.Thickness = 4
	u139.Color = Color3.fromRGB(0, 0, 0)
	u139.Transparency = 1
	u139.Parent = u137
	if u14.CountdownSound then
		local v140 = Instance.new("Sound")
		v140.SoundId = u14.CountdownSound
		v140.Volume = u14.CountdownSoundVol or 1
		v140.Parent = u12
		v140:Play()
		u8:AddItem(v140, 3)
	end
	local v141 = u14.CountdownTextSize or 120
	if v135 then
		v141 = v141 * 1.5 or v141
	end
	u137.TextTransparency = 0
	u137.TextStrokeTransparency = 0
	u139.Transparency = 0
	u137.TextSize = 1
	u4:Create(u137, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		["TextSize"] = v141
	}):Play()
	task.delay(v135 and 0.7 or 0.55, function()

		local v142 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		u4:Create(u137, v142, {
			["TextTransparency"] = 1,
			["TextStrokeTransparency"] = 1
		}):Play()
		u4:Create(u139, v142, {
			["Transparency"] = 1
		}):Play()
		task.delay(0.4, function()

			if u136 and u136.Parent then
				u136:Destroy()
			end
		end)
	end)
end
local u144 = v3:FindFirstChild(u14.LightningFolder or "Ligtning")
local _ = workspace.CurrentCamera
local function u152(p145) 

	if type(p145) == "table" and p145.position then
		local v146 = p145.position
		local v147 = u144 and u144:FindFirstChild("HitParticles")
		if v147 then
			local u148 = v147:Clone()
			u148.Position = v146
			u148.Parent = workspace
			u8:AddItem(u148, 3)
			task.delay(0.3, function()

				if u148 and u148.Parent then
					for _, v149 in ipairs(u148:GetDescendants()) do
						if v149:IsA("ParticleEmitter") or v149:IsA("PointLight") then
							v149.Enabled = false
						end
					end
				end
			end)
		end
		local v150 = u144 and u144:FindFirstChild("LightningSound")
		if v150 then
			local v151 = v150:Clone()
			v151.Volume = u14.LightningSoundVolume or 2
			v151.Parent = u12
			v151:Play()
			u8:AddItem(v151, 5)
		end
	end
end
local function u166(p153) 

	if type(p153) == "table" then
		local v154 = p153.action
		if v154 == "start" then
			local v155 = p153.wave
			if v155 then
				if v155.Sky then
					u114(v155.Sky, p153.instant)
				end
				if v155.Shake and v155.Shake > 0 then
					u131(v155.Shake)
					return
				end
			end
		else
			if v154 == "stop" then
				u121 = 0
				local u156 = u14.ShakeFadeOut or 0.3
				u122 = task.spawn(function()

					local v157 = u120
					local v158 = tick()
					while u120 > 0 and tick() - v158 < u156 do
						local v159 = (tick() - v158) / u156
						u120 = v157 * (1 - math.min(1, v159))
						task.wait()
					end
					u120 = 0
					u122 = nil
					if u119 then
						u119:Disconnect()
						u119 = nil
					end
					local v160 = u11.Character
					if v160 then
						v160 = v160:FindFirstChildOfClass("Humanoid")
					end
					if v160 then
						v160.CameraOffset = Vector3.new(0, 0, 0)
					end
				end)
				return
			end
			if v154 == "end" then
				u121 = 0
				local u161 = u14.ShakeFadeOut or 0.3
				u122 = task.spawn(function()

					local v162 = u120
					local v163 = tick()
					while u120 > 0 and tick() - v163 < u161 do
						local v164 = (tick() - v163) / u161
						u120 = v162 * (1 - math.min(1, v164))
						task.wait()
					end
					u120 = 0
					u122 = nil
					if u119 then
						u119:Disconnect()
						u119 = nil
					end
					local v165 = u11.Character
					if v165 then
						v165 = v165:FindFirstChildOfClass("Humanoid")
					end
					if v165 then
						v165.CameraOffset = Vector3.new(0, 0, 0)
					end
				end)
				u118()
			end
		end
	end
end
local u167 = false
local u168 = nil
local function u169() 

	return (not u14.MusicPlaylist or #u14.MusicPlaylist <= 0) and (u14.Music and u14.Music ~= "" and { u14.Music } or {}) or u14.MusicPlaylist
end
local function u173(u170, u171) 

	if u167 then
		local u172 = u19
		if u172 and u172.Parent then
			u172.SoundId = u170[u171]
			u172.Looped = false
			u172.TimePosition = 0
			if u168 then
				u168:Disconnect()
				u168 = nil
			end
			u168 = u172.Ended:Connect(function()

				if u167 then
					u173(u170, u171 % #u170 + 1)
				end
			end)
			task.spawn(function()

				if not u172.IsLoaded then
					u172.Loaded:Wait()
				end
				if u167 then
					u172:Play()
				end
			end)
		end
	else
		return
	end
end
local function u177(p174) 

	if type(p174) == "table" then
		if p174.action == "start" then
			if u19 then
				return
			else
				local v175 = u169()
				if #v175 ~= 0 then
					local v176 = Instance.new("Sound")
					v176.Name = "EggRainMusic"
					v176.Volume = u14.MusicVolume or 0.5
					v176.Looped = false
					v176.Parent = u9
					u19 = v176
					u167 = true
					u173(v175, 1)
				end
			end
		else
			if p174.action == "stop" then
				u167 = false
				if u168 then
					u168:Disconnect()
					u168 = nil
				end
				if u19 then
					u19:Stop()
					u19:Destroy()
					u19 = nil
				end
			end
			return
		end
	else
		return
	end
end
local function u194(p178) 

	if type(p178) == "table" then
		if p178.musicStartTime and p178.musicStartTime > 0 then
			u177({
				["action"] = "start",
				["musicStartTime"] = p178.musicStartTime
			})
		end
		if p178.skyWaveIndex and p178.skyWaveIndex > 0 then
			local v179 = u14.Waves
			if v179 and v179[p178.skyWaveIndex] then
				local v180 = v179[p178.skyWaveIndex]
				local v181 = v180.Sky and v180.Sky
				if v181 then
					u86()
					if v181.Brightness then
						u7.Brightness = v181.Brightness
					end
					if v181.Ambient then
						local v182 = u7
						local v183 = v181.Ambient
						local v184
						if type(v183) == "table" and #v183 >= 3 then
							v184 = Color3.fromRGB(v183[1], v183[2], v183[3])
						else
							v184 = Color3.fromRGB(255, 255, 255)
						end
						v182.Ambient = v184
					end
					if v181.OutdoorAmbient then
						local v185 = u7
						local v186 = v181.OutdoorAmbient
						local v187
						if type(v186) == "table" and #v186 >= 3 then
							v187 = Color3.fromRGB(v186[1], v186[2], v186[3])
						else
							v187 = Color3.fromRGB(255, 255, 255)
						end
						v185.OutdoorAmbient = v187
					end
					if v181.FogEnd then
						u7.FogEnd = v181.FogEnd
					end
					if v181.FogColor then
						local v188 = u7
						local v189 = v181.FogColor
						local v190
						if type(v189) == "table" and #v189 >= 3 then
							v190 = Color3.fromRGB(v189[1], v189[2], v189[3])
						else
							v190 = Color3.fromRGB(255, 255, 255)
						end
						v188.FogColor = v190
					end
					local v191 = u7:FindFirstChild("EggRainCC")
					if v191 then
						if v181.Saturation then
							v191.Saturation = v181.Saturation
						end
						if v181.ColorTint then
							local v192 = v181.ColorTint
							local v193
							if type(v192) == "table" and #v192 >= 3 then
								v193 = Color3.fromRGB(v192[1], v192[2], v192[3])
							else
								v193 = Color3.fromRGB(255, 255, 255)
							end
							v191.TintColor = v193
						end
					end
				end
			end
		end
		if p178.shakeIntensity and p178.shakeIntensity > 0 then
			u131(p178.shakeIntensity)
		end
	end
end
local u195 = u14.AdminUserId or 0
local u196 = nil
local u197 = false
local u198 = {}
local u199 = nil
local function u300() 

	if u11.UserId ~= u195 then
		return
	end
	local v200 = Color3.fromRGB(30, 30, 35)
	local u201 = Color3.fromRGB(40, 40, 48)
	local v202 = Color3.fromRGB(40, 160, 70)
	local v203 = Color3.fromRGB(180, 50, 50)
	local v204 = Color3.fromRGB(200, 130, 30)
	local u205 = Color3.fromRGB(50, 110, 190)
	local u206 = Color3.fromRGB(130, 60, 180)
	local u207 = Color3.fromRGB(230, 230, 235)
	local u208 = Color3.fromRGB(160, 160, 170)
	local u209 = Instance.new("ScreenGui")
	u209.Name = "EggRainAdminPanel"
	u209.DisplayOrder = 200
	u209.ResetOnSpawn = false
	u209.Enabled = false
	u209.Parent = u12
	u196 = u209
	local u210 = Instance.new("Frame")
	u210.Name = "Main"
	u210.Size = UDim2.new(0, 360, 0, 620)
	u210.Position = UDim2.new(0.5, 0, 0.5, 0)
	u210.AnchorPoint = Vector2.new(0.5, 0.5)
	u210.BackgroundColor3 = v200
	u210.BackgroundTransparency = 0.02
	u210.BorderSizePixel = 0
	u210.Parent = u209
	local u211 = false
	local u212 = nil
	local u213 = nil
	local v214 = game:GetService("UserInputService")
	u210.InputBegan:Connect(function(p215)

		if (p215.UserInputType == Enum.UserInputType.MouseButton1 or p215.UserInputType == Enum.UserInputType.Touch) and p215.Position.Y - u210.AbsolutePosition.Y <= 38 then
			u211 = true
			u212 = p215.Position
			u213 = u210.Position
		end
	end)
	v214.InputChanged:Connect(function(p216)

		if u211 and (p216.UserInputType == Enum.UserInputType.MouseMovement or p216.UserInputType == Enum.UserInputType.Touch) then
			local v217 = p216.Position - u212
			u210.Position = UDim2.new(u213.X.Scale, u213.X.Offset + v217.X, u213.Y.Scale, u213.Y.Offset + v217.Y)
		end
	end)
	v214.InputEnded:Connect(function(p218)

		if p218.UserInputType == Enum.UserInputType.MouseButton1 or p218.UserInputType == Enum.UserInputType.Touch then
			u211 = false
		end
	end)
	local v219 = Instance.new("UICorner")
	v219.CornerRadius = UDim.new(0, 10)
	v219.Parent = u210
	local v220 = Instance.new("UIStroke")
	v220.Color = Color3.fromRGB(80, 80, 100)
	v220.Thickness = 1.5
	v220.Parent = u210
	local u221 = Instance.new("ScrollingFrame")
	u221.Name = "Scroll"
	u221.Size = UDim2.new(1, -16, 1, -50)
	u221.Position = UDim2.new(0, 8, 0, 42)
	u221.BackgroundTransparency = 1
	u221.ScrollBarThickness = 4
	u221.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)
	u221.CanvasSize = UDim2.new(0, 0, 0, 0)
	u221.AutomaticCanvasSize = Enum.AutomaticSize.Y
	u221.Parent = u210
	local v222 = Instance.new("UIListLayout")
	v222.SortOrder = Enum.SortOrder.LayoutOrder
	v222.Padding = UDim.new(0, 6)
	v222.Parent = u221
	local v223 = Instance.new("UIPadding")
	v223.PaddingLeft = UDim.new(0, 4)
	v223.PaddingRight = UDim.new(0, 4)
	v223.PaddingTop = UDim.new(0, 4)
	v223.Parent = u221
	local v224 = Instance.new("TextLabel")
	v224.Name = "Title"
	v224.Size = UDim2.new(1, 0, 0, 38)
	v224.Position = UDim2.new(0, 0, 0, 0)
	v224.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	v224.BackgroundTransparency = 0.1
	v224.BorderSizePixel = 0
	v224.Text = "EGG RAIN CONTROL"
	v224.TextColor3 = u207
	v224.TextSize = 16
	v224.Font = Enum.Font.GothamBold
	v224.Parent = u210
	local v225 = Instance.new("UICorner")
	v225.CornerRadius = UDim.new(0, 10)
	v225.Parent = v224
	local v226 = Instance.new("TextButton")
	v226.Name = "Close"
	v226.Size = UDim2.new(0, 30, 0, 30)
	v226.Position = UDim2.new(1, -34, 0, 4)
	v226.BackgroundColor3 = v203
	v226.BackgroundTransparency = 0.3
	v226.Text = "X"
	v226.TextColor3 = u207
	v226.TextSize = 14
	v226.Font = Enum.Font.GothamBold
	v226.BorderSizePixel = 0
	v226.Parent = u210
	Instance.new("UICorner", v226).CornerRadius = UDim.new(0, 6)
	v226.MouseButton1Click:Connect(function()

		u209.Enabled = false
	end)
	local u227 = 0
	local function v230(p228) 

		u227 = u227 + 1
		local v229 = Instance.new("TextLabel")
		v229.Size = UDim2.new(1, 0, 0, 22)
		v229.BackgroundTransparency = 1
		v229.Text = p228
		v229.TextColor3 = u208
		v229.TextSize = 11
		v229.Font = Enum.Font.GothamBold
		v229.TextXAlignment = Enum.TextXAlignment.Left
		v229.LayoutOrder = u227
		v229.Parent = u221
		return v229
	end
	local function v236(p231, p232, p233, p234) 

		local v235 = Instance.new("TextButton")
		v235.Size = p234 or UDim2.new(0, 100, 0, 30)
		v235.BackgroundColor3 = p232
		v235.Text = p231
		v235.TextColor3 = u207
		v235.TextSize = 12
		v235.Font = Enum.Font.GothamBold
		v235.BorderSizePixel = 0
		v235.AutoButtonColor = true
		v235.Parent = p233
		Instance.new("UICorner", v235).CornerRadius = UDim.new(0, 6)
		return v235
	end
	v230("STATUS")
	u227 = u227 + 1
	local v237 = Instance.new("Frame")
	v237.Size = UDim2.new(1, 0, 0, 42)
	v237.BackgroundTransparency = 1
	v237.LayoutOrder = u227
	v237.Parent = u221
	v237.BackgroundColor3 = u201
	v237.BackgroundTransparency = 0.3
	Instance.new("UICorner", v237).CornerRadius = UDim.new(0, 6)
	local v238 = Instance.new("TextLabel")
	v238.Size = UDim2.new(1, -12, 1, 0)
	v238.Position = UDim2.new(0, 6, 0, 0)
	v238.BackgroundTransparency = 1
	v238.Text = "Wave: None | Music: OFF\nEggs: 0 | Lightning: OFF"
	v238.TextColor3 = Color3.fromRGB(120, 220, 160)
	v238.TextSize = 11
	v238.Font = Enum.Font.GothamMedium
	v238.TextXAlignment = Enum.TextXAlignment.Left
	v238.TextWrapped = true
	v238.Parent = v237
	u198.main = v238
	v230("SCOPE")
	u227 = u227 + 1
	local v239 = Instance.new("Frame")
	v239.Size = UDim2.new(1, 0, 0, 30)
	v239.BackgroundTransparency = 1
	v239.LayoutOrder = u227
	v239.Parent = u221
	local u240 = v236("This Server", u205, v239, UDim2.new(0.48, 0, 1, 0))
	u240.Position = UDim2.new(0, 0, 0, 0)
	u240.BackgroundTransparency = 0
	local u241 = v236("All Servers", u201, v239, UDim2.new(0.48, 0, 1, 0))
	u241.Position = UDim2.new(0.52, 0, 0, 0)
	u241.BackgroundTransparency = 0.3
	u240.MouseButton1Click:Connect(function()

		u197 = false
		if u197 then
			u240.BackgroundColor3 = u201
			u240.BackgroundTransparency = 0.3
			u241.BackgroundColor3 = u206
			u241.BackgroundTransparency = 0
		else
			u240.BackgroundColor3 = u205
			u240.BackgroundTransparency = 0
			u241.BackgroundColor3 = u201
			u241.BackgroundTransparency = 0.3
		end
	end)
	u241.MouseButton1Click:Connect(function()

		u197 = true
		if u197 then
			u240.BackgroundColor3 = u201
			u240.BackgroundTransparency = 0.3
			u241.BackgroundColor3 = u206
			u241.BackgroundTransparency = 0
		else
			u240.BackgroundColor3 = u205
			u240.BackgroundTransparency = 0
			u241.BackgroundColor3 = u201
			u241.BackgroundTransparency = 0.3
		end
	end)
	v230("EVENT")
	u227 = u227 + 1
	local v242 = Instance.new("Frame")
	v242.Size = UDim2.new(1, 0, 0, 34)
	v242.BackgroundTransparency = 1
	v242.LayoutOrder = u227
	v242.Parent = u221
	local v243 = v236("Full Auto", v202, v242, UDim2.new(0.32, -2, 1, 0))
	v243.Position = UDim2.new(0, 0, 0, 0)
	v243.MouseButton1Click:Connect(function()

		if u199 then
			u199:FireServer({
				["action"] = "fullAuto",
				["allServers"] = u197
			})
		end
	end)
	local v244 = v236("Stop All", v203, v242, UDim2.new(0.32, -2, 1, 0))
	v244.Position = UDim2.new(0.34, 0, 0, 0)
	v244.MouseButton1Click:Connect(function()

		if u199 then
			u199:FireServer({
				["action"] = "stopAll",
				["allServers"] = u197
			})
		end
	end)
	local v245 = v236("Cleanup", v204, v242, UDim2.new(0.32, -2, 1, 0))
	v245.Position = UDim2.new(0.68, 0, 0, 0)
	v245.MouseButton1Click:Connect(function()

		if u199 then
			u199:FireServer({
				["action"] = "cleanup",
				["allServers"] = u197
			})
		end
	end)
	v230("WAVES")
	u227 = u227 + 1
	local v246 = Instance.new("Frame")
	v246.Size = UDim2.new(1, 0, 0, 34)
	v246.BackgroundTransparency = 1
	v246.LayoutOrder = u227
	v246.Parent = u221
	local v247 = v246
	local u248 = 1
	local u249 = Instance.new("TextButton")
	u249.Size = UDim2.new(0.36, -2, 1, 0)
	u249.Position = UDim2.new(0, 0, 0, 0)
	u249.BackgroundColor3 = u201
	u249.Text = "Wave 1"
	u249.TextColor3 = u207
	u249.TextSize = 12
	u249.Font = Enum.Font.GothamBold
	u249.BorderSizePixel = 0
	u249.Parent = v247
	Instance.new("UICorner", u249).CornerRadius = UDim.new(0, 6)
	u249.MouseButton1Click:Connect(function()

		local v250 = u14.Waves or {}
		u248 = u248 % #v250 + 1
		local v251 = v250[u248]
		u249.Text = "Wave " .. u248 .. (v251 and " - " .. v251.Name or "")
	end)
	local v252 = v236("Start", v202, v247, UDim2.new(0.3, -2, 1, 0))
	v252.Position = UDim2.new(0.38, 0, 0, 0)
	v252.MouseButton1Click:Connect(function()

		local v253 = {
			["waveIndex"] = u248
		}
		if u199 then
			u199:FireServer({
				["action"] = "startWave",
				["args"] = v253,
				["allServers"] = u197
			})
		end
	end)
	local v254 = v236("Stop", v203, v247, UDim2.new(0.3, -2, 1, 0))
	v254.Position = UDim2.new(0.7, 0, 0, 0)
	v254.MouseButton1Click:Connect(function()

		if u199 then
			u199:FireServer({
				["action"] = "stopWave",
				["allServers"] = u197
			})
		end
	end)
	v230("MANUAL SPAWN")
	u227 = u227 + 1
	local v255 = Instance.new("Frame")
	v255.Size = UDim2.new(1, 0, 0, 34)
	v255.BackgroundTransparency = 1
	v255.LayoutOrder = u227
	v255.Parent = u221
	local u256 = Instance.new("TextBox")
	u256.Size = UDim2.new(0.25, -2, 1, 0)
	u256.Position = UDim2.new(0, 0, 0, 0)
	u256.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	u256.Text = "10"
	u256.PlaceholderText = "Qty"
	u256.TextColor3 = u207
	u256.TextSize = 13
	u256.Font = Enum.Font.GothamMedium
	u256.BorderSizePixel = 0
	u256.ClearTextOnFocus = false
	u256.Parent = v255
	Instance.new("UICorner", u256).CornerRadius = UDim.new(0, 6)
	local v257 = v236("Normal", u205, v255, UDim2.new(0.36, -2, 1, 0))
	v257.Position = UDim2.new(0.27, 0, 0, 0)
	v257.MouseButton1Click:Connect(function()

		local v258 = u256.Text
		local v259 = {
			["golden"] = false,
			["count"] = tonumber(v258) or 10
		}
		if u199 then
			u199:FireServer({
				["action"] = "spawnEggs",
				["args"] = v259,
				["allServers"] = u197
			})
		end
	end)
	local v260 = v236("Golden", Color3.fromRGB(200, 170, 30), v255, UDim2.new(0.36, -2, 1, 0))
	v260.Position = UDim2.new(0.64, 0, 0, 0)
	v260.MouseButton1Click:Connect(function()

		local v261 = u256.Text
		local v262 = {
			["golden"] = true,
			["count"] = tonumber(v261) or 10
		}
		if u199 then
			u199:FireServer({
				["action"] = "spawnEggs",
				["args"] = v262,
				["allServers"] = u197
			})
		end
	end)
	v230("MESSAGES")
	u227 = u227 + 1
	local v263 = Instance.new("Frame")
	v263.Size = UDim2.new(1, 0, 0, 34)
	v263.BackgroundTransparency = 1
	v263.LayoutOrder = u227
	v263.Parent = u221
	local u264 = Instance.new("TextBox")
	u264.Size = UDim2.new(0.72, -2, 1, 0)
	u264.Position = UDim2.new(0, 0, 0, 0)
	u264.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	u264.Text = ""
	u264.PlaceholderText = "Admin message..."
	u264.TextColor3 = u207
	u264.TextSize = 12
	u264.Font = Enum.Font.GothamMedium
	u264.BorderSizePixel = 0
	u264.ClearTextOnFocus = false
	u264.Parent = v263
	Instance.new("UICorner", u264).CornerRadius = UDim.new(0, 6)
	local v265 = v236("Send", v202, v263, UDim2.new(0.26, -2, 1, 0))
	v265.Position = UDim2.new(0.74, 0, 0, 0)
	v265.MouseButton1Click:Connect(function()

		if u264.Text ~= "" then
			local v266 = {
				["text"] = u264.Text
			}
			if u199 then
				u199:FireServer({
					["action"] = "announce",
					["args"] = v266,
					["allServers"] = u197
				})
			end
			u264.Text = ""
		end
	end)
	local v267 = {}
	if u14.Announcements then
		for v268, v269 in ipairs(u14.Announcements) do
			local v270 = {
				["label"] = "Intro " .. v268,
				["text"] = v269.Text
			}
			table.insert(v267, v270)
		end
	end
	if u14.Waves then
		for v271, v272 in ipairs(u14.Waves) do
			if v272.Announce then
				local v273 = {
					["label"] = "W" .. v271,
					["text"] = v272.Announce
				}
				table.insert(v267, v273)
			end
		end
	end
	if u14.EndAnnounce then
		local v274 = {
			["label"] = "End",
			["text"] = u14.EndAnnounce
		}
		table.insert(v267, v274)
	end
	if u14.EndSequence and u14.EndSequence.Messages then
		for v275, v276 in ipairs(u14.EndSequence.Messages) do
			local v277 = {
				["label"] = "End " .. v275 + 1,
				["text"] = v276.Text
			}
			table.insert(v267, v277)
		end
	end
	if #v267 > 0 then
		v230("PRESET ANNOUNCEMENTS")
		for v278 = 1, #v267, 3 do
			u227 = u227 + 1
			local v279 = Instance.new("Frame")
			v279.Size = UDim2.new(1, 0, 0, 28)
			v279.BackgroundTransparency = 1
			v279.LayoutOrder = u227
			v279.Parent = u221
			for v280 = 0, 2 do
				local v281 = v278 + v280
				if #v267 < v281 then
					break
				end
				local u282 = v267[v281]
				local v283 = #v267 - v278 + 1
				local v284 = 1 / math.min(3, v283)
				local v285 = v236(u282.label, Color3.fromRGB(70, 70, 85), v279, UDim2.new(v284, -3, 1, 0))
				v285.Position = UDim2.new(v284 * v280, 0, 0, 0)
				v285.TextSize = 10
				v285.MouseButton1Click:Connect(function()

					local v286 = {
						["text"] = u282.text
					}
					if u199 then
						u199:FireServer({
							["action"] = "announce",
							["args"] = v286,
							["allServers"] = u197
						})
					end
				end)
			end
		end
	end
	v230("AMBIANCE / SKY")
	u227 = u227 + 1
	local v287 = Instance.new("Frame")
	v287.Size = UDim2.new(1, 0, 0, 34)
	v287.BackgroundTransparency = 1
	v287.LayoutOrder = u227
	v287.Parent = u221
	local v288 = v287
	local u289 = 0
	local u290 = Instance.new("TextButton")
	u290.Size = UDim2.new(0.55, -2, 1, 0)
	u290.Position = UDim2.new(0, 0, 0, 0)
	u290.BackgroundColor3 = u201
	u290.Text = "Normal"
	u290.TextColor3 = u207
	u290.TextSize = 12
	u290.Font = Enum.Font.GothamBold
	u290.BorderSizePixel = 0
	u290.Parent = v288
	Instance.new("UICorner", u290).CornerRadius = UDim.new(0, 6)
	u290.MouseButton1Click:Connect(function()

		local v291 = u14.Waves or {}
		u289 = (u289 + 1) % (#v291 + 1)
		if u289 == 0 then
			u290.Text = "Normal"
		else
			local v292 = v291[u289]
			u290.Text = "Wave " .. u289 .. (v292 and " - " .. v292.Name or "")
		end
	end)
	local v293 = v236("Apply", u205, v288, UDim2.new(0.43, -2, 1, 0))
	v293.Position = UDim2.new(0.57, 0, 0, 0)
	v293.MouseButton1Click:Connect(function()

		if u289 == 0 then
			if u199 then
				u199:FireServer({
					["action"] = "restoreSky",
					["allServers"] = u197
				})
			end
		else
			local v294 = {
				["waveIndex"] = u289
			}
			if u199 then
				u199:FireServer({
					["action"] = "applySky",
					["args"] = v294,
					["allServers"] = u197
				})
			end
		end
	end)
	v230("MUSIC")
	u227 = u227 + 1
	local v295 = Instance.new("Frame")
	v295.Size = UDim2.new(1, 0, 0, 34)
	v295.BackgroundTransparency = 1
	v295.LayoutOrder = u227
	v295.Parent = u221
	local v296 = v236("Play", v202, v295, UDim2.new(0.48, -2, 1, 0))
	v296.Position = UDim2.new(0, 0, 0, 0)
	v296.MouseButton1Click:Connect(function()

		if u199 then
			u199:FireServer({
				["action"] = "startMusic",
				["allServers"] = u197
			})
		end
	end)
	local v297 = v236("Stop", v203, v295, UDim2.new(0.48, -2, 1, 0))
	v297.Position = UDim2.new(0.52, 0, 0, 0)
	v297.MouseButton1Click:Connect(function()

		if u199 then
			u199:FireServer({
				["action"] = "stopMusic",
				["allServers"] = u197
			})
		end
	end)
	v230("END SEQUENCE")
	u227 = u227 + 1
	local v298 = Instance.new("Frame")
	v298.Size = UDim2.new(1, 0, 0, 34)
	v298.BackgroundTransparency = 1
	v298.LayoutOrder = u227
	v298.Parent = u221
	local v299 = v236("Run End Sequence", v204, v298, UDim2.new(1, 0, 1, 0))
	v299.Position = UDim2.new(0, 0, 0, 0)
	v299.MouseButton1Click:Connect(function()

		if u199 then
			u199:FireServer({
				["action"] = "endSequence",
				["allServers"] = u197
			})
		end
	end)
end
local function u305(p301) 

	if u198.main then
		if type(p301) == "table" then
			local v302 = p301.music and "ON" or "OFF"
			local v303 = p301.lightning and "ON" or "OFF"
			local v304 = p301.fullAuto and " | AUTO" or ""
			u198.main.Text = "Wave: " .. (p301.wave or "None") .. " | Music: " .. v302 .. v304 .. "\nEggs: " .. (p301.eggsActive or 0) .. " | Lightning: " .. v303
		end
	else
		return
	end
end
function v13.Init(_) 

	if not u17 then
		u17 = true
		task.spawn(function()

			local v306 = { u14.SpawnSound }
			if u14.AnnounceSound then
				local v307 = u14.AnnounceSound
				table.insert(v306, v307)
			end
			if u14.GoldenNotifSound then
				local v308 = u14.GoldenNotifSound
				table.insert(v306, v308)
			end
			if u14.CountdownSound then
				local v309 = u14.CountdownSound
				table.insert(v306, v309)
			end
			if u14.CollectSound then
				local v310 = u14.CollectSound
				table.insert(v306, v310)
			end
			u5:PreloadAsync(v306)
		end)
		u15:WaitForChild("EggRainAnnounce").OnClientEvent:Connect(function(p311)

			if type(p311) == "table" and p311.text then
				u64(p311.text)
			end
		end)
		u15:WaitForChild("EggRainWave").OnClientEvent:Connect(u166)
		u15:WaitForChild("EggRainCountdown").OnClientEvent:Connect(function(p312)

			if type(p312) == "table" then
				u143(p312)
			end
		end)
		u15:WaitForChild("EggRainPre").OnClientEvent:Connect(function(p313)

			if type(p313) == "table" then
				local v314 = p313.position
				if v314 then
					u27(v314)
					if p313.eggType == 1 then
						u83()
					end
				end
			else
				return
			end
		end)
		u15:WaitForChild("EggRainHide").OnClientEvent:Connect(function(p315)

			if type(p315) == "table" then
				local v316 = p315.eggId
				if type(v316) == "number" then
					u31(p315.eggId)
					return
				end
			end
		end)
		u15:WaitForChild("EggRainLightning").OnClientEvent:Connect(u152)
		u15:WaitForChild("EggRainMusic").OnClientEvent:Connect(u177)
		u15:WaitForChild("EggRainSync").OnClientEvent:Connect(u194)
		if u11.UserId == u195 then
			u199 = u15:WaitForChild("EggRainAdmin")
			u15:WaitForChild("EggRainStatus").OnClientEvent:Connect(u305)
			u300()
			if u11.UserId ~= u195 then
				return
			end
			task.spawn(function()

				local v317 = u12:WaitForChild("AdminMenuGUI_v2", 30)
				if v317 then
					local v318 = v317:WaitForChild("Panel", 10)
					if v318 then
						local v319 = v318:WaitForChild("EggRainButton", 10)
						if v319 then
							v319.MouseButton1Click:Connect(function()

								if u196 then
									u196.Enabled = not u196.Enabled
								end
							end)
							print("[EggRainClient] Admin button hooked.")
						else
							warn("[EggRainClient] AdminMenuGUI_v2/Panel/EggRainButton introuvable")
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
return v13