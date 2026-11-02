

local u1 = game:GetService("Players")
local u2 = Color3.fromRGB(24, 24, 26)
local u3 = Color3.fromRGB(38, 38, 42)
local u4 = Color3.fromRGB(48, 48, 54)
local u5 = Color3.fromRGB(210, 255, 80)
local u6 = Color3.fromRGB(235, 235, 238)
local u7 = Color3.fromRGB(120, 120, 128)
local u8 = Color3.fromRGB(190, 45, 55)
local u9 = Color3.fromRGB(80, 200, 120)
local u10 = Enum.Font.RobotoMono
local function u19(p11, p12) 

	local u13 = Instance.new("TextButton")
	u13.Name = p11.name
	u13.AutoButtonColor = false
	u13.BackgroundColor3 = u3
	u13.BorderSizePixel = 0
	u13.Size = UDim2.new(1, 0, 0, 40)
	u13.LayoutOrder = p12
	u13.Font = u10
	if p11.needsDuration and p11.maxDurationSeconds then
		local v14 = "  "
		local v15 = p11.name
		local v16 = "  (max "
		local v17 = p11.maxDurationSeconds / 60
		local v18
		if v17 == math.floor(v17) then
			v18 = string.format("%d min", (math.floor(v17)))
		else
			v18 = string.format("%.1f min", v17)
		end
		u13.Text = v14 .. v15 .. v16 .. v18 .. ")"
	else
		u13.Text = "  " .. p11.name
	end
	u13.TextColor3 = u6
	u13.TextSize = 15
	u13.TextXAlignment = Enum.TextXAlignment.Left
	u13.ZIndex = 2
	u13.MouseEnter:Connect(function()

		u13.BackgroundColor3 = u4
	end)
	u13.MouseLeave:Connect(function()

		u13.BackgroundColor3 = u3
	end)
	return u13
end
local u77 = {
	["mount"] = function(p20, p21) 

		local u22 = {
			["current"] = p21
		}
		local u23 = Instance.new("ScreenGui")
		u23.Name = "AdminAbuseEvent"
		u23.ResetOnSpawn = false
		u23.IgnoreGuiInset = true
		u23.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		u23.DisplayOrder = 100
		u23.Enabled = false
		u23.Parent = p20
		local v24 = Instance.new("TextButton")
		v24.Name = "Backdrop"
		v24.AutoButtonColor = false
		v24.Size = UDim2.fromScale(1, 1)
		v24.BackgroundColor3 = Color3.new(0, 0, 0)
		v24.BackgroundTransparency = 0.45
		v24.BorderSizePixel = 0
		v24.Text = ""
		v24.ZIndex = 1
		v24.Parent = u23
		local v25 = Instance.new("Frame")
		v25.Name = "Root"
		v25.AnchorPoint = Vector2.new(0.5, 0.5)
		v25.Position = UDim2.fromScale(0.5, 0.5)
		v25.Size = UDim2.fromOffset(360, 420)
		v25.BackgroundColor3 = u2
		v25.BorderSizePixel = 0
		v25.ZIndex = 2
		v25.Parent = u23
		local v26 = Instance.new("Frame")
		v26.Name = "Stripe"
		v26.BackgroundColor3 = u5
		v26.BorderSizePixel = 0
		v26.Position = UDim2.new(0, 0, 0, 0)
		v26.Size = UDim2.new(0, 4, 1, 0)
		v26.ZIndex = 3
		v26.Parent = v25
		local v27 = Instance.new("TextLabel")
		v27.Name = "Title"
		v27.BackgroundTransparency = 1
		v27.Position = UDim2.new(0, 16, 0, 14)
		v27.Size = UDim2.new(1, -24, 0, 22)
		v27.Font = u10
		v27.Text = "admin_abuse"
		v27.TextColor3 = u5
		v27.TextSize = 17
		v27.TextXAlignment = Enum.TextXAlignment.Left
		v27.ZIndex = 3
		v27.Parent = v25
		local v28 = Instance.new("TextLabel")
		v28.Name = "Hint"
		v28.BackgroundTransparency = 1
		v28.Position = UDim2.new(0, 16, 0, 36)
		v28.Size = UDim2.new(1, -24, 0, 16)
		v28.Font = u10
		v28.Text = "modules/"
		v28.TextColor3 = u7
		v28.TextSize = 12
		v28.TextXAlignment = Enum.TextXAlignment.Left
		v28.ZIndex = 3
		v28.Parent = v25
		local u29 = Instance.new("ScrollingFrame")
		u29.Name = "Actions"
		u29.BackgroundTransparency = 1
		u29.BorderSizePixel = 0
		u29.Position = UDim2.new(0, 12, 0, 64)
		u29.Size = UDim2.new(1, -24, 1, -120)
		u29.CanvasSize = UDim2.new(0, 0, 0, 0)
		u29.ScrollBarThickness = 6
		u29.ScrollBarImageColor3 = u7
		u29.AutomaticCanvasSize = Enum.AutomaticSize.Y
		u29.ScrollingDirection = Enum.ScrollingDirection.Y
		u29.ZIndex = 2
		u29.Parent = v25
		local v30 = Instance.new("UIListLayout")
		v30.Padding = UDim.new(0, 2)
		v30.SortOrder = Enum.SortOrder.LayoutOrder
		v30.Parent = u29
		local v31 = Instance.new("UIPadding")
		v31.PaddingBottom = UDim.new(0, 4)
		v31.PaddingTop = UDim.new(0, 2)
		v31.Parent = u29
		local v32 = Instance.new("Frame")
		v32.Name = "Footer"
		v32.BackgroundTransparency = 1
		v32.AnchorPoint = Vector2.new(0, 1)
		v32.Position = UDim2.new(0, 0, 1, 0)
		v32.Size = UDim2.new(1, 0, 0, 52)
		v32.ZIndex = 3
		v32.Parent = v25
		local u33 = Instance.new("TextButton")
		u33.Name = "Stop"
		u33.AutoButtonColor = false
		u33.AnchorPoint = Vector2.new(0, 1)
		u33.Position = UDim2.new(0, 12, 1, -12)
		u33.Size = UDim2.new(0.28, -8, 0, 36)
		u33.BackgroundColor3 = u8
		u33.BorderSizePixel = 0
		u33.Font = u10
		u33.Text = "stop"
		u33.TextColor3 = u6
		u33.TextSize = 14
		u33.ZIndex = 3
		u33.Parent = v32
		local u34 = Instance.new("TextButton")
		u34.Name = "BossMinus"
		u34.AutoButtonColor = false
		u34.AnchorPoint = Vector2.new(0, 1)
		u34.Position = UDim2.new(0.3, 0, 1, -12)
		u34.Size = UDim2.new(0.18, -6, 0, 36)
		u34.BackgroundColor3 = u3
		u34.BorderSizePixel = 0
		u34.Font = u10
		u34.Text = "boss \226\136\146"
		u34.TextColor3 = u6
		u34.TextSize = 12
		u34.ZIndex = 3
		u34.Parent = v32
		local u35 = Instance.new("TextButton")
		u35.Name = "BossPlus"
		u35.AutoButtonColor = false
		u35.AnchorPoint = Vector2.new(0, 1)
		u35.Position = UDim2.new(0.49, 0, 1, -12)
		u35.Size = UDim2.new(0.18, -6, 0, 36)
		u35.BackgroundColor3 = u3
		u35.BorderSizePixel = 0
		u35.Font = u10
		u35.Text = "boss +"
		u35.TextColor3 = u6
		u35.TextSize = 12
		u35.ZIndex = 3
		u35.Parent = v32
		u33.MouseButton1Click:Connect(function()

			u22.current.onStop()
		end)
		u34.MouseButton1Click:Connect(function()

			u22.current.onBossDelta(-500)
		end)
		u35.MouseButton1Click:Connect(function()

			u22.current.onBossDelta(500)
		end)
		local u36 = Instance.new("TextButton")
		u36.Name = "Close"
		u36.AutoButtonColor = false
		u36.AnchorPoint = Vector2.new(1, 1)
		u36.Position = UDim2.new(1, -12, 1, -12)
		u36.Size = UDim2.new(0.3, -8, 0, 36)
		u36.BackgroundColor3 = u3
		u36.BorderSizePixel = 0
		u36.Font = u10
		u36.Text = "close"
		u36.TextColor3 = u6
		u36.TextSize = 14
		u36.ZIndex = 3
		u36.Parent = v32
		local u37 = Instance.new("Frame")
		u37.Name = "DurationPrompt"
		u37.BackgroundColor3 = u2
		u37.BorderSizePixel = 0
		u37.Size = UDim2.new(1, 0, 1, 0)
		u37.Position = UDim2.new(0, 0, 0, 0)
		u37.Visible = false
		u37.ZIndex = 5
		u37.Parent = v25
		local v38 = Instance.new("Frame")
		v38.BackgroundColor3 = u5
		v38.BorderSizePixel = 0
		v38.Size = UDim2.new(0, 4, 1, 0)
		v38.ZIndex = 6
		v38.Parent = u37
		local v39 = Instance.new("TextLabel")
		v39.BackgroundTransparency = 1
		v39.Position = UDim2.new(0, 16, 0, 14)
		v39.Size = UDim2.new(1, -24, 0, 22)
		v39.Font = u10
		v39.Text = "duration"
		v39.TextColor3 = u5
		v39.TextSize = 17
		v39.TextXAlignment = Enum.TextXAlignment.Left
		v39.ZIndex = 6
		v39.Parent = u37
		local u40 = Instance.new("TextLabel")
		u40.Name = "Subtitle"
		u40.BackgroundTransparency = 1
		u40.Position = UDim2.new(0, 16, 0, 36)
		u40.Size = UDim2.new(1, -24, 0, 16)
		u40.Font = u10
		u40.Text = "module"
		u40.TextColor3 = u7
		u40.TextSize = 12
		u40.TextXAlignment = Enum.TextXAlignment.Left
		u40.ZIndex = 6
		u40.Parent = u37
		local v41 = Instance.new("TextLabel")
		v41.BackgroundTransparency = 1
		v41.Position = UDim2.new(0, 16, 0, 80)
		v41.Size = UDim2.new(1, -32, 0, 18)
		v41.Font = u10
		v41.Text = "Dur\195\169e (minutes)"
		v41.TextColor3 = u6
		v41.TextSize = 13
		v41.TextXAlignment = Enum.TextXAlignment.Left
		v41.ZIndex = 6
		v41.Parent = u37
		local u42 = Instance.new("TextLabel")
		u42.Name = "DurHint"
		u42.BackgroundTransparency = 1
		u42.Position = UDim2.new(0, 16, 0, 158)
		u42.Size = UDim2.new(1, -32, 0, 16)
		u42.Font = u10
		u42.Text = ""
		u42.TextColor3 = u7
		u42.TextSize = 12
		u42.TextXAlignment = Enum.TextXAlignment.Left
		u42.ZIndex = 6
		u42.Parent = u37
		local u43 = Instance.new("TextBox")
		u43.Name = "DurBox"
		u43.BackgroundColor3 = u3
		u43.BorderSizePixel = 0
		u43.Position = UDim2.new(0, 16, 0, 102)
		u43.Size = UDim2.new(1, -32, 0, 48)
		u43.Font = u10
		u43.PlaceholderText = "5"
		u43.Text = ""
		u43.TextColor3 = u6
		u43.TextSize = 22
		u43.ClearTextOnFocus = false
		u43.ZIndex = 6
		u43.Parent = u37
		local v44 = Instance.new("TextButton")
		v44.Name = "DurStart"
		v44.AutoButtonColor = false
		v44.AnchorPoint = Vector2.new(0, 1)
		v44.Position = UDim2.new(0, 12, 1, -12)
		v44.Size = UDim2.new(0.5, -14, 0, 36)
		v44.BackgroundColor3 = u9
		v44.BorderSizePixel = 0
		v44.Font = u10
		v44.Text = "start"
		v44.TextColor3 = u6
		v44.TextSize = 14
		v44.ZIndex = 6
		v44.Parent = u37
		local v45 = Instance.new("TextButton")
		v45.Name = "DurCancel"
		v45.AutoButtonColor = false
		v45.AnchorPoint = Vector2.new(1, 1)
		v45.Position = UDim2.new(1, -12, 1, -12)
		v45.Size = UDim2.new(0.5, -14, 0, 36)
		v45.BackgroundColor3 = u3
		v45.BorderSizePixel = 0
		v45.Font = u10
		v45.Text = "cancel"
		v45.TextColor3 = u6
		v45.TextSize = 14
		v45.ZIndex = 6
		v45.Parent = u37
		local u46 = nil
		local function v47() 

			u46 = nil
			u37.Visible = false
		end
		local function u57(p48) 

			u46 = p48
			local v49 = p48.maxDurationSeconds or 600
			local v50 = (p48.defaultDurationSeconds or v49) / 60 + 0.5
			local v51 = math.floor(v50)
			local v52 = v51 < 1 and 1 or v51
			u40.Text = "modules/" .. p48.name
			u43.Text = tostring(v52)
			u43.PlaceholderText = tostring(v52)
			local v53 = u42
			local v54 = "Maximum "
			local v55 = v49 / 60
			local v56
			if v55 == math.floor(v55) then
				v56 = string.format("%d min", (math.floor(v55)))
			else
				v56 = string.format("%.1f min", v55)
			end
			v53.Text = v54 .. v56
			u37.Visible = true
		end
		local function v58() 

			u46 = nil
			u37.Visible = false
			u23.Enabled = false
		end
		u36.MouseButton1Click:Connect(v58)
		v24.MouseButton1Click:Connect(v58)
		v45.MouseButton1Click:Connect(v47)
		v44.MouseButton1Click:Connect(function()

			local v59 = u46
			if v59 then
				local v60 = v59.maxDurationSeconds or 600
				local v61 = u43.Text
				local v62 = tonumber(v61)
				if not v62 or v62 <= 0 then
					v62 = (v59.defaultDurationSeconds or v60) / 60
				end
				local v63 = v62 * 60 + 0.5
				local v64 = math.floor(v63)
				local v65 = v64 <= 0 and 60 or v64
				if v60 < v65 then
					v65 = v60
				end
				u46 = nil
				u37.Visible = false
				u22.current.onPickModule(v59.name, v65)
				u23.Enabled = false
			end
		end)
		local function u67() 

			for _, v66 in ipairs(u29:GetChildren()) do
				if v66:IsA("TextButton") then
					v66:Destroy()
				end
			end
		end
		local function u72(p68) 

			u67()
			u46 = nil
			u37.Visible = false
			for v69, u70 in ipairs(p68.moduleMetas) do
				local v71 = u19(u70, v69)
				v71.Parent = u29
				v71.MouseButton1Click:Connect(function()

					if u70.needsDuration then
						u57(u70)
					else
						u22.current.onPickModule(u70.name, nil)
						u23.Enabled = false
					end
				end)
			end
			u33.Visible = p68.showStop
			u34.Visible = p68.showStop
			u35.Visible = p68.showStop
			if p68.showStop then
				u33.AnchorPoint = Vector2.new(0, 1)
				u33.Position = UDim2.new(0, 12, 1, -12)
				u33.Size = UDim2.new(0.28, -8, 0, 36)
				u34.Position = UDim2.new(0.3, 0, 1, -12)
				u35.Position = UDim2.new(0.49, 0, 1, -12)
				u36.AnchorPoint = Vector2.new(1, 1)
				u36.Position = UDim2.new(1, -12, 1, -12)
				u36.Size = UDim2.new(0.3, -8, 0, 36)
			else
				u36.AnchorPoint = Vector2.new(0.5, 1)
				u36.Position = UDim2.new(0.5, 0, 1, -12)
				u36.Size = UDim2.new(1, -24, 0, 36)
			end
		end
		u72(u22.current)
		return {
			["ScreenGui"] = u23,
			["SetVisible"] = function(p73) 

				if not p73 then
					u46 = nil
					u37.Visible = false
				end
				u23.Enabled = p73
			end,
			["SetProps"] = function(p74) 

				u22.current = p74
				u72(p74)
			end,
			["Destroy"] = function() 

				u23:Destroy()
			end
		}
	end,
	["mountLocalPlayer"] = function(p75) 

		local v76 = u1.LocalPlayer
		assert(v76, "LocalPlayer manquant")
		return u77.mount(v76:WaitForChild("PlayerGui"), p75)
	end
}
return u77