

local v1 = game:GetService("Players")
local u2 = game:GetService("TweenService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("CollectionService")
local u5 = require(v3:WaitForChild("Config"))
local u6 = require(v3:WaitForChild("SoundManager"))
local u7 = v1.LocalPlayer
local u8 = u7:WaitForChild("PlayerGui")
local v9 = {}
local u10 = nil
local function u15(p11) 

	if u10 and u10.Parent then
		return u10
	end
	local v12 = p11 or 0
	for _ = 0, v12 do
		local v13 = u4:GetTagged("MainGUI")
		for _, v14 in ipairs(v13) do
			if v14:IsDescendantOf(u8) then
				u10 = v14
				return v14
			end
		end
		if v12 > 0 then
			task.wait(0.2)
		end
	end
	return nil
end
local u16 = {
	{ 1e63, "Vg" },
	{ 1e60, "Nd" },
	{ 1e57, "Od" },
	{ 1e54, "Spd" },
	{ 1e51, "Sxd" },
	{ 1e48, "Qid" },
	{ 1e45, "Qad" },
	{ 1e42, "Td" },
	{ 1e39, "Dd" },
	{ 1e36, "Ud" },
	{ 1e33, "Dc" },
	{ 1e30, "No" },
	{ 1e27, "Oc" },
	{ 1e24, "Sp" },
	{ 1e21, "Sx" },
	{ 1e18, "Qi" },
	{ 1000000000000000, "Qa" },
	{ 1000000000000, "T" },
	{ 1000000000, "B" },
	{ 1000000, "M" },
	{ 1000, "K" }
}
local function u23(p17) 

	local v18 = tonumber(p17) or 0
	for _, v19 in ipairs(u16) do
		local v20 = v19[1]
		local v21 = v19[2]
		if v20 <= v18 then
			return string.format("%.2f", v18 / v20):gsub("%.?0+$", "") .. v21
		end
	end
	local v22 = math.floor(v18)
	return tostring(v22)
end
function v9.ShowMessage(_, p24, p25) 

	local v26 = u15()
	if v26 then
		local u27 = Instance.new("TextLabel")
		u27.Name = "CenterMessage"
		u27.Size = UDim2.new(0.6, 0, 0.06, 0)
		u27.Position = UDim2.new(0.5, 0, 0.35, 0)
		u27.AnchorPoint = Vector2.new(0.5, 0.5)
		u27.BackgroundTransparency = 1
		u27.Text = p24
		u27.TextColor3 = p25 or Color3.fromRGB(255, 255, 255)
		u27.TextScaled = true
		u27.Font = Enum.Font.GothamBlack
		u27.Parent = v26
		Instance.new("UITextSizeConstraint", u27).MaxTextSize = 35
		local u28 = Instance.new("UIStroke", u27)
		u28.Color = Color3.fromRGB(0, 0, 0)
		u28.Thickness = 2.5
		local v29 = Instance.new("UIScale", u27)
		v29.Scale = 0.7
		u2:Create(v29, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["Scale"] = 1
		}):Play()
		u2:Create(u27, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			["Position"] = UDim2.new(0.5, 0, 0.3, 0)
		}):Play()
		task.delay(u5.DURATIONS.MESSAGE or 2, function()

			local v30 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			u2:Create(u27, v30, {
				["TextTransparency"] = 1,
				["Position"] = UDim2.new(0.5, 0, 0.25, 0)
			}):Play()
			u2:Create(u28, v30, {
				["Transparency"] = 1
			}):Play()
			task.delay(0.5, function()

				u27:Destroy()
			end)
		end)
	end
end
function v9.ShowLevelUp(_, _, p31) 

	local v32 = u15(10)
	if v32 then
		u6:Play("LEVEL_UP")
		local u33 = Instance.new("Frame")
		u33.Name = "LevelUpNotification"
		u33.Size = UDim2.new(0.6, 0, 0.2, 0)
		u33.Position = UDim2.new(0.5, 0, 0.45, 0)
		u33.AnchorPoint = Vector2.new(0.5, 0.5)
		u33.BackgroundTransparency = 1
		u33.Parent = v32
		local v34 = Instance.new("UIListLayout", u33)
		v34.HorizontalAlignment = Enum.HorizontalAlignment.Center
		v34.VerticalAlignment = Enum.VerticalAlignment.Center
		v34.Padding = UDim.new(0.05, 0)
		local u35 = Instance.new("UIScale", u33)
		u35.Scale = 0
		local v36 = Instance.new("TextLabel", u33)
		v36.Size = UDim2.new(1, 0, 0.4, 0)
		v36.BackgroundTransparency = 1
		v36.Text = "\240\159\142\137 LEVEL UP! \240\159\142\137"
		v36.TextColor3 = Color3.fromRGB(255, 215, 0)
		v36.TextScaled = true
		v36.Font = Enum.Font.GothamBlack
		Instance.new("UIStroke", v36).Thickness = 4
		local v37 = Instance.new("TextLabel", u33)
		v37.Size = UDim2.new(1, 0, 0.3, 0)
		v37.BackgroundTransparency = 1
		v37.Text = "Level " .. p31
		v37.TextColor3 = Color3.fromRGB(255, 255, 255)
		v37.TextScaled = true
		v37.Font = Enum.Font.GothamBold
		Instance.new("UIStroke", v37).Thickness = 3
		u2:Create(u35, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["Scale"] = 1
		}):Play()
		u2:Create(u33, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			["Position"] = UDim2.new(0.5, 0, 0.4, 0)
		}):Play()
		task.delay(u5.DURATIONS.LEVEL_UP or 2.5, function()

			u2:Create(u33, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["Position"] = UDim2.new(0.5, 0, 0.3, 0)
			}):Play()
			u2:Create(u35, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				["Scale"] = 0
			}):Play()
			local v38 = TweenInfo.new(0.5)
			for _, v39 in pairs(u33:GetDescendants()) do
				if v39:IsA("TextLabel") then
					u2:Create(v39, v38, {
						["TextTransparency"] = 1
					}):Play()
				elseif v39:IsA("UIStroke") then
					u2:Create(v39, v38, {
						["Transparency"] = 1
					}):Play()
				end
			end
			task.wait(0.6)
			u33:Destroy()
		end)
	end
end
function v9.ShowPlusOne(_, p40, p41, p42, p43, p44, p45) 

	local v46 = u7.Character
	if v46 and v46:FindFirstChild("HumanoidRootPart") then
		local v47 = v46.HumanoidRootPart
		local v48 = p44 or 1
		local v49 = p40 * p41 * (p42 or 1) * (p43 or 1) * v48 * (p45 or 1)
		local u50 = Instance.new("BillboardGui", u8)
		u50.Name = "PlusOne"
		u50.Size = UDim2.new(4.5, 0, 1.5, 0)
		u50.StudsOffset = Vector3.new(0, 1, 0)
		u50.AlwaysOnTop = true
		u50.Adornee = v47
		local v51 = Instance.new("Frame", u50)
		v51.Size = UDim2.new(0, 0, 0, 0)
		v51.Position = UDim2.new(0.5, 0, 0.5, 0)
		v51.AnchorPoint = Vector2.new(0.5, 0.5)
		v51.BackgroundTransparency = 1
		local v52 = Instance.new("UIListLayout", v51)
		v52.FillDirection = Enum.FillDirection.Horizontal
		v52.HorizontalAlignment = Enum.HorizontalAlignment.Center
		v52.VerticalAlignment = Enum.VerticalAlignment.Center
		v52.Padding = UDim.new(0.05, 0)
		local u53 = Instance.new("ImageLabel", v51)
		u53.Size = UDim2.new(0.3, 0, 0.8, 0)
		u53.BackgroundTransparency = 1
		u53.Image = "rbxassetid://16408406294"
		Instance.new("UIAspectRatioConstraint", u53).AspectRatio = 1
		local u54 = Instance.new("TextLabel", v51)
		u54.Size = UDim2.new(0.6, 0, 0.9, 0)
		u54.BackgroundTransparency = 1
		local v55 = Color3.fromRGB(255, 227, 178)
		local xpMult = p45 or 1
		if v48 >= 100 then
			v55 = Color3.fromRGB(255, 0, 0)
		elseif v48 >= 25 then
			v55 = Color3.fromRGB(255, 67, 199)
		elseif v48 >= 9 then
			v55 = Color3.fromRGB(0, 255, 255)
		elseif v48 > 1 then
			v55 = Color3.fromRGB(255, 238, 0)
		elseif xpMult > 1 then
			v55 = Color3.fromRGB(100, 200, 255)
		elseif p42 and p42 > 1 then
			v55 = Color3.fromRGB(255, 125, 65)
		end
		u54.TextColor3 = v55
		u54.Text = "+" .. u23(v49)
		u54.TextScaled = true
		u54.Font = Enum.Font.GothamBlack
		local u56 = Instance.new("UIStroke", u54)
		u56.Thickness = 2

		-- Show multiplier badge if XP boost is active
		local multLabel = nil
		local multStroke = nil
		if xpMult > 1 then
			multLabel = Instance.new("TextLabel")
			multLabel.Name = "XPMultiplier"
			multLabel.Size = UDim2.new(0.5, 0, 0.6, 0)
			multLabel.BackgroundTransparency = 1
			multLabel.Text = "x" .. tostring(xpMult == math.floor(xpMult) and math.floor(xpMult) or xpMult)
			multLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
			multLabel.TextScaled = true
			multLabel.Font = Enum.Font.GothamBlack
			multLabel.Parent = v51
			multStroke = Instance.new("UIStroke", multLabel)
			multStroke.Thickness = 2
			multStroke.Color = Color3.fromRGB(0, 80, 160)
		end

		local v57 = math.random(-4, 4)
		local v58 = math.random(3, 5)
		local v59 = math.random
		local u60 = Vector3.new(v57, v58, v59(-2, 2))
		u2:Create(v51, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["Size"] = UDim2.new(1, 0, 1, 0)
		}):Play()
		u2:Create(u50, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			["StudsOffset"] = u60
		}):Play()
		task.delay(0.5, function()

			local v61 = TweenInfo.new(0.3)
			u2:Create(u54, v61, {
				["TextTransparency"] = 1
			}):Play()
			u2:Create(u53, v61, {
				["ImageTransparency"] = 1
			}):Play()
			u2:Create(u56, v61, {
				["Transparency"] = 1
			}):Play()
			if multLabel then
				u2:Create(multLabel, v61, {
					["TextTransparency"] = 1
				}):Play()
				u2:Create(multStroke, v61, {
					["Transparency"] = 1
				}):Play()
			end
			u2:Create(u50, v61, {
				["StudsOffset"] = u60 + Vector3.new(0, -1, 0)
			}):Play()
			task.delay(0.35, function()

				u50:Destroy()
			end)
		end)
	end
end
function v9.ShowWinNotification(_, p62) 

	local v63 = u15(10)
	if v63 then
		u6:Play("WIN")
		local u64 = Instance.new("Frame", v63)
		u64.Name = "WinNotification"
		u64.Size = UDim2.new(0.5, 0, 0.12, 0)
		u64.Position = UDim2.new(0.5, 0, 0.5, 0)
		u64.AnchorPoint = Vector2.new(0.5, 0.5)
		u64.BackgroundTransparency = 1
		local v65 = Instance.new("UIListLayout", u64)
		v65.FillDirection = Enum.FillDirection.Horizontal
		v65.HorizontalAlignment = Enum.HorizontalAlignment.Center
		v65.VerticalAlignment = Enum.VerticalAlignment.Center
		v65.Padding = UDim.new(0.02, 0)
		local u66 = Instance.new("UIScale", u64)
		u66.Scale = 0
		local u67 = Instance.new("ImageLabel", u64)
		u67.Size = UDim2.new(0.15, 0, 0.9, 0)
		u67.BackgroundTransparency = 1
		u67.Image = "rbxassetid://15540211845"
		u67.Rotation = -20
		Instance.new("UIAspectRatioConstraint", u67)
		local u68 = Instance.new("TextLabel", u64)
		u68.AutomaticSize = Enum.AutomaticSize.X
		u68.Size = UDim2.new(0, 0, 0.8, 0)
		u68.BackgroundTransparency = 1
		u68.Text = "+" .. (p62 or 1) .. " Win" .. ((p62 or 1) > 1 and "s" or "") .. "!"
		u68.TextColor3 = Color3.fromRGB(255, 215, 0)
		u68.TextScaled = true
		u68.Font = Enum.Font.GothamBlack
		local u69 = Instance.new("UIStroke", u68)
		u69.Thickness = 3
		u2:Create(u66, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["Scale"] = 1
		}):Play()
		u2:Create(u64, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			["Position"] = UDim2.new(0.5, 0, 0.4, 0)
		}):Play()
		u2:Create(u67, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["Rotation"] = 0
		}):Play()
		task.delay(u5.DURATIONS.WIN or 2, function()

			u2:Create(u64, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["Position"] = UDim2.new(0.5, 0, 0.3, 0)
			}):Play()
			u2:Create(u66, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				["Scale"] = 0
			}):Play()
			local v70 = TweenInfo.new(0.4)
			u2:Create(u68, v70, {
				["TextTransparency"] = 1
			}):Play()
			u2:Create(u67, v70, {
				["ImageTransparency"] = 1
			}):Play()
			u2:Create(u69, v70, {
				["Transparency"] = 1
			}):Play()
			task.wait(0.5)
			u64:Destroy()
		end)
	end
end
function v9.ShowRebirth(_, p71) 

	local v72 = u15(10)
	if v72 then
		u6:Play("REBIRTH")
		local u73 = Instance.new("Frame")
		u73.Name = "RebirthNotification"
		u73.Size = UDim2.new(0.6, 0, 0.2, 0)
		u73.Position = UDim2.new(0.5, 0, 0.45, 0)
		u73.AnchorPoint = Vector2.new(0.5, 0.5)
		u73.BackgroundTransparency = 1
		u73.Parent = v72
		local v74 = Instance.new("UIListLayout", u73)
		v74.HorizontalAlignment = Enum.HorizontalAlignment.Center
		v74.VerticalAlignment = Enum.VerticalAlignment.Center
		v74.Padding = UDim.new(0.05, 0)
		local u75 = Instance.new("UIScale", u73)
		u75.Scale = 0
		local v76 = Instance.new("TextLabel", u73)
		v76.Size = UDim2.new(1, 0, 0.4, 0)
		v76.BackgroundTransparency = 1
		v76.Text = "\240\159\140\128 NEW REBIRTH! \240\159\140\128"
		v76.TextColor3 = Color3.fromRGB(0, 255, 255)
		v76.TextScaled = true
		v76.Font = Enum.Font.GothamBlack
		local v77 = Instance.new("UIStroke", v76)
		v77.Thickness = 4
		v77.Color = Color3.fromRGB(0, 50, 100)
		local v78 = Instance.new("TextLabel", u73)
		v78.Size = UDim2.new(1, 0, 0.3, 0)
		v78.BackgroundTransparency = 1
		v78.Text = "Rebirth #" .. p71
		v78.TextColor3 = Color3.fromRGB(255, 255, 255)
		v78.TextScaled = true
		v78.Font = Enum.Font.GothamBold
		Instance.new("UIStroke", v78).Thickness = 3
		u2:Create(u75, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["Scale"] = 1
		}):Play()
		u2:Create(u73, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			["Position"] = UDim2.new(0.5, 0, 0.4, 0)
		}):Play()
		task.delay(3, function()

			u2:Create(u73, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["Position"] = UDim2.new(0.5, 0, 0.3, 0)
			}):Play()
			u2:Create(u75, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				["Scale"] = 0
			}):Play()
			local v79 = TweenInfo.new(0.5)
			for _, v80 in pairs(u73:GetDescendants()) do
				if v80:IsA("TextLabel") then
					u2:Create(v80, v79, {
						["TextTransparency"] = 1
					}):Play()
				elseif v80:IsA("UIStroke") then
					u2:Create(v80, v79, {
						["Transparency"] = 1
					}):Play()
				end
			end
			task.wait(0.6)
			u73:Destroy()
		end)
	end
end
function v9.ShowCurrencyCollect(_, p81, p82, p83, p84) 

	local v85 = u7.Character
	if v85 and v85:FindFirstChild("HumanoidRootPart") then
		local v86 = v85.HumanoidRootPart
		local v87 = p84 == 1 and Color3.fromRGB(255, 247, 0) or Color3.fromRGB(238, 0, 255)
		local u88 = Instance.new("BillboardGui", u8)
		u88.Name = "CurrencyCollect"
		u88.Size = UDim2.new(8, 0, 2.2, 0)
		u88.StudsOffset = Vector3.new(0, 1, 0)
		u88.AlwaysOnTop = true
		u88.Adornee = v86
		local v89 = Instance.new("Frame", u88)
		v89.Size = UDim2.new(0, 0, 0, 0)
		v89.Position = UDim2.new(0.5, 0, 0.5, 0)
		v89.AnchorPoint = Vector2.new(0.5, 0.5)
		v89.BackgroundTransparency = 1
		local v90 = Instance.new("UIListLayout", v89)
		v90.FillDirection = Enum.FillDirection.Horizontal
		v90.HorizontalAlignment = Enum.HorizontalAlignment.Center
		v90.VerticalAlignment = Enum.VerticalAlignment.Center
		v90.Padding = UDim.new(0.05, 0)
		local u91 = Instance.new("ImageLabel", v89)
		u91.Size = UDim2.new(0.3, 0, 0.8, 0)
		u91.BackgroundTransparency = 1
		u91.Image = "rbxassetid://" .. tostring(p81 or 0)
		Instance.new("UIAspectRatioConstraint", u91).AspectRatio = 1
		local u92 = Instance.new("TextLabel", v89)
		u92.Size = UDim2.new(0.65, 0, 0.9, 0)
		u92.BackgroundTransparency = 1
		u92.Text = "+" .. tostring(p83 or 1) .. " " .. tostring(p82 or "")
		u92.TextColor3 = v87
		u92.TextScaled = true
		u92.Font = Enum.Font.GothamBlack
		local u93 = Instance.new("UIStroke", u92)
		u93.Thickness = 2
		local v94 = math.random(-4, 4)
		local v95 = math.random(3, 5)
		local v96 = math.random
		local u97 = Vector3.new(v94, v95, v96(-2, 2))
		u2:Create(v89, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["Size"] = UDim2.new(1, 0, 1, 0)
		}):Play()
		u2:Create(u88, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			["StudsOffset"] = u97
		}):Play()
		task.delay(1.8, function()

			local v98 = TweenInfo.new(0.45)
			u2:Create(u92, v98, {
				["TextTransparency"] = 1
			}):Play()
			u2:Create(u91, v98, {
				["ImageTransparency"] = 1
			}):Play()
			u2:Create(u93, v98, {
				["Transparency"] = 1
			}):Play()
			u2:Create(u88, v98, {
				["StudsOffset"] = u97 + Vector3.new(0, -1, 0)
			}):Play()
			task.delay(0.5, function()

				u88:Destroy()
			end)
		end)
	end
end
function v9.ShowBossHit(_) 

	local v99 = u15(10)
	if v99 then
		u6:Play("BOSS_HIT")
		local u100 = Instance.new("Frame", v99)
		u100.Name = "BossHitNotification"
		u100.Size = UDim2.new(0.5, 0, 0.08, 0)
		u100.Position = UDim2.new(0.5, 0, 0.12, 0)
		u100.AnchorPoint = Vector2.new(0.5, 0.5)
		u100.BackgroundTransparency = 1
		local u101 = Instance.new("UIScale", u100)
		u101.Scale = 0
		local u102 = Instance.new("TextLabel", u100)
		u102.Size = UDim2.new(1, 0, 1, 0)
		u102.BackgroundTransparency = 1
		u102.Text = "[BOSS] -100 HP \240\159\146\165"
		u102.TextColor3 = Color3.fromRGB(255, 30, 30)
		u102.TextScaled = true
		u102.Font = Enum.Font.GothamBlack
		local u103 = Instance.new("UIStroke", u102)
		u103.Thickness = 3
		u103.Color = Color3.fromRGB(80, 0, 0)
		u2:Create(u101, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			["Scale"] = 1.2
		}):Play()
		task.delay(0.3, function()

			u2:Create(u101, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
				["Scale"] = 1
			}):Play()
		end)
		task.spawn(function()

			for _ = 1, 4 do
				local v104 = math.random(-8, 8)
				u2:Create(u100, TweenInfo.new(0.05), {
					["Position"] = UDim2.new(0.5, v104, 0.12, 0)
				}):Play()
				task.wait(0.05)
			end
			u2:Create(u100, TweenInfo.new(0.05), {
				["Position"] = UDim2.new(0.5, 0, 0.12, 0)
			}):Play()
		end)
		task.delay(1.5, function()

			u2:Create(u101, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				["Scale"] = 0
			}):Play()
			u2:Create(u102, TweenInfo.new(0.4), {
				["TextTransparency"] = 1
			}):Play()
			u2:Create(u103, TweenInfo.new(0.4), {
				["Transparency"] = 1
			}):Play()
			task.wait(0.5)
			u100:Destroy()
		end)
	end
end
return v9