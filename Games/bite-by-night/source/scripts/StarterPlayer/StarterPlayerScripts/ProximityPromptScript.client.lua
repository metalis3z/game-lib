-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("UserInputService")
local v2 = game:GetService("ProximityPromptService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("TextService")
local v_u_5 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local v_u_6 = {
	[Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png",
	[Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png",
	[Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png",
	[Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png",
	[Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png",
	[Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png",
	[Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png",
	[Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png",
	[Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png",
	[Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS.png",
	[Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS.png"
}
local v_u_7 = {
	[Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
	[Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
	[Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
	[Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
	[Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
}
local v_u_8 = {
	["\'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
	[","] = "rbxasset://textures/ui/Controls/comma.png",
	["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
	["."] = "rbxasset://textures/ui/Controls/period.png",
	[" "] = "rbxasset://textures/ui/Controls/spacebar.png"
}
local v_u_9 = {
	[Enum.KeyCode.LeftControl] = "Ctrl",
	[Enum.KeyCode.RightControl] = "Ctrl",
	[Enum.KeyCode.LeftAlt] = "Alt",
	[Enum.KeyCode.RightAlt] = "Alt",
	[Enum.KeyCode.F1] = "F1",
	[Enum.KeyCode.F2] = "F2",
	[Enum.KeyCode.F3] = "F3",
	[Enum.KeyCode.F4] = "F4",
	[Enum.KeyCode.F5] = "F5",
	[Enum.KeyCode.F6] = "F6",
	[Enum.KeyCode.F7] = "F7",
	[Enum.KeyCode.F8] = "F8",
	[Enum.KeyCode.F9] = "F9",
	[Enum.KeyCode.F10] = "F10",
	[Enum.KeyCode.F11] = "F11",
	[Enum.KeyCode.F12] = "F12"
}
local function v_u_204(p_u_10, p11, p12)
	-- upvalues: (copy) v_u_3, (copy) v_u_6, (copy) v_u_1, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_4
	local v_u_13 = {}
	local v_u_14 = {}
	local v_u_15 = {}
	local v_u_16 = {}
	local v17 = TweenInfo.new(p_u_10.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v_u_18 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v_u_19 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local v20 = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local v_u_21 = nil
	local v22 = p_u_10:GetAttribute("Theme")
	if v22 then
		local v23 = script:FindFirstChild(v22)
		if v23 then
			v_u_21 = v23:Clone()
		end
	end
	if v_u_21 == nil then
		v_u_21 = script.Default:Clone()
	end
	local v24 = p_u_10.UIOffset.X
	local v25 = p_u_10.UIOffset.Y
	v_u_21.StudsOffsetWorldSpace = Vector3.new(v24, v25, 0)
	v_u_21.Enabled = true
	local v26 = v_u_21.LongPrompt
	local v27 = v_u_21.SquarePrompt
	local v28 = v26.Keybind
	local v29 = v27.Keybind
	local v_u_30 = v26.ActionText
	local v_u_31 = v26.ObjectText
	local v32 = v26.BackgroundTransparency
	local v33 = v26.GroupTransparency
	v26.BackgroundTransparency = 1
	v26.GroupTransparency = 1
	local v34 = v_u_3
	local v35 = {
		["Size"] = UDim2.fromScale(1, 1),
		["BackgroundTransparency"] = 1,
		["GroupTransparency"] = 0
	}
	table.insert(v_u_13, v34:Create(v27, v_u_18, v35))
	local v36 = v_u_3
	local v37 = {
		["Size"] = UDim2.fromScale(0.5, 1),
		["BackgroundTransparency"] = 1,
		["GroupTransparency"] = 1
	}
	table.insert(v_u_14, v36:Create(v27, v_u_18, v37))
	local v38 = v_u_3
	local v39 = {
		["Size"] = UDim2.fromScale(0.5, 1),
		["BackgroundTransparency"] = 1,
		["GroupTransparency"] = 1
	}
	table.insert(v_u_15, v38:Create(v27, v_u_18, v39))
	local v40 = v_u_3
	local v41 = {
		["Size"] = UDim2.fromScale(0.5, 1),
		["BackgroundTransparency"] = 1,
		["GroupTransparency"] = 1
	}
	table.insert(v_u_16, v40:Create(v27, v_u_18, v41))
	local v42 = v_u_3
	local v43 = {
		["Size"] = UDim2.fromScale(0.5, 1),
		["BackgroundTransparency"] = 1,
		["GroupTransparency"] = 1
	}
	table.insert(v_u_13, v42:Create(v26, v_u_18, v43))
	local v44 = v_u_3
	local v45 = {
		["Size"] = UDim2.fromScale(1, 1),
		["BackgroundTransparency"] = v32,
		["GroupTransparency"] = v33
	}
	table.insert(v_u_14, v44:Create(v26, v_u_18, v45))
	local v46 = v_u_3
	local v47 = {
		["Size"] = UDim2.fromScale(0.5, 1),
		["BackgroundTransparency"] = 1,
		["GroupTransparency"] = 1
	}
	table.insert(v_u_15, v46:Create(v26, v_u_18, v47))
	local v48 = v_u_3
	local v49 = {
		["Size"] = UDim2.fromScale(1, 1),
		["BackgroundTransparency"] = v32,
		["GroupTransparency"] = v33
	}
	table.insert(v_u_16, v48:Create(v26, v_u_18, v49))
	local function v_u_64(p50)
		-- upvalues: (copy) v_u_13, (ref) v_u_3, (copy) v_u_18, (copy) v_u_14, (copy) v_u_15, (copy) v_u_16
		local v51 = p50.Transparency
		p50.Transparency = 1
		local v52 = v_u_13
		local v53 = v_u_3
		local v54 = v_u_18
		table.insert(v52, v53:Create(p50, v54, {
			["Transparency"] = 1
		}))
		local v55 = v_u_14
		local v56 = v_u_3
		local v57 = v_u_18
		table.insert(v55, v56:Create(p50, v57, {
			["Transparency"] = v51
		}))
		local v58 = v_u_15
		local v59 = v_u_3
		local v60 = v_u_18
		table.insert(v58, v59:Create(p50, v60, {
			["Transparency"] = 1
		}))
		local v61 = v_u_16
		local v62 = v_u_3
		local v63 = v_u_18
		table.insert(v61, v62:Create(p50, v63, {
			["Transparency"] = v51
		}))
	end
	local function v_u_79(p65)
		-- upvalues: (copy) v_u_13, (ref) v_u_3, (copy) v_u_18, (copy) v_u_14, (copy) v_u_15, (copy) v_u_16
		local v66 = p65.BackgroundTransparency
		p65.BackgroundTransparency = 1
		local v67 = v_u_13
		local v68 = v_u_3
		local v69 = v_u_18
		table.insert(v67, v68:Create(p65, v69, {
			["BackgroundTransparency"] = 1
		}))
		local v70 = v_u_14
		local v71 = v_u_3
		local v72 = v_u_18
		table.insert(v70, v71:Create(p65, v72, {
			["BackgroundTransparency"] = v66
		}))
		local v73 = v_u_15
		local v74 = v_u_3
		local v75 = v_u_18
		table.insert(v73, v74:Create(p65, v75, {
			["BackgroundTransparency"] = 1
		}))
		local v76 = v_u_16
		local v77 = v_u_3
		local v78 = v_u_18
		table.insert(v76, v77:Create(p65, v78, {
			["BackgroundTransparency"] = v66
		}))
	end
	local function v_u_95(p80)
		-- upvalues: (copy) v_u_13, (ref) v_u_3, (copy) v_u_18, (copy) v_u_14, (copy) v_u_15, (copy) v_u_16
		local v81 = p80.TextTransparency
		local v82 = p80.TextStrokeTransparency
		p80.TextTransparency = 1
		p80.TextStrokeTransparency = 1
		local v83 = v_u_13
		local v84 = v_u_3
		local v85 = v_u_18
		table.insert(v83, v84:Create(p80, v85, {
			["TextTransparency"] = 1,
			["TextStrokeTransparency"] = 1
		}))
		local v86 = v_u_14
		local v87 = v_u_3
		local v88 = v_u_18
		table.insert(v86, v87:Create(p80, v88, {
			["TextTransparency"] = v81,
			["TextStrokeTransparency"] = v82
		}))
		local v89 = v_u_15
		local v90 = v_u_3
		local v91 = v_u_18
		table.insert(v89, v90:Create(p80, v91, {
			["TextTransparency"] = 1,
			["TextStrokeTransparency"] = 1
		}))
		local v92 = v_u_16
		local v93 = v_u_3
		local v94 = v_u_18
		table.insert(v92, v93:Create(p80, v94, {
			["TextTransparency"] = v81,
			["TextStrokeTransparency"] = v82
		}))
	end
	local function v_u_110(p96)
		-- upvalues: (copy) v_u_13, (ref) v_u_3, (copy) v_u_18, (copy) v_u_14, (copy) v_u_15, (copy) v_u_16
		local v97 = p96.ImageTransparency
		p96.ImageTransparency = 1
		local v98 = v_u_13
		local v99 = v_u_3
		local v100 = v_u_18
		table.insert(v98, v99:Create(p96, v100, {
			["ImageTransparency"] = 1
		}))
		local v101 = v_u_14
		local v102 = v_u_3
		local v103 = v_u_18
		table.insert(v101, v102:Create(p96, v103, {
			["ImageTransparency"] = v97
		}))
		local v104 = v_u_15
		local v105 = v_u_3
		local v106 = v_u_18
		table.insert(v104, v105:Create(p96, v106, {
			["ImageTransparency"] = 1
		}))
		local v107 = v_u_16
		local v108 = v_u_3
		local v109 = v_u_18
		table.insert(v107, v108:Create(p96, v109, {
			["ImageTransparency"] = v97
		}))
	end
	local function v_u_113(p111)
		-- upvalues: (copy) v_u_64, (copy) v_u_79, (copy) v_u_95, (copy) v_u_110, (copy) v_u_113
		if p111:IsA("UIStroke") then
			v_u_64(p111)
		elseif not p111:IsA("UIGradient") and p111:IsA("GuiObject") then
			v_u_79(p111)
			if p111:IsA("TextLabel") then
				v_u_95(p111)
			elseif p111:IsA("ImageLabel") then
				v_u_110(p111)
			end
		end
		for _, v112 in pairs(p111:GetChildren()) do
			v_u_113(v112)
		end
	end
	local v114 = {
		[v28] = false,
		[v_u_30] = true,
		[v_u_31] = true
	}
	for _, v115 in pairs(v26:GetChildren()) do
		if v114[v115] == nil then
			v_u_113(v115)
		elseif v114[v115] == true then
			for _, v116 in pairs(v115:GetChildren()) do
				v_u_113(v116)
			end
		end
	end
	v_u_95(v_u_30)
	v_u_95(v_u_31)
	local v_u_117 = v28.ButtonImage
	local v118 = v29.ButtonImage
	local v119 = v29.TextLabel
	local v_u_120 = v28.TextLabel
	local v_u_121 = v28.ButtonTextImage
	local function v141()
		-- upvalues: (copy) v_u_120, (copy) v_u_15, (ref) v_u_3, (copy) v_u_19, (copy) v_u_16
		local v122 = v_u_120.TextTransparency
		local v123 = v_u_120.TextStrokeTransparency
		local v124 = v_u_120.BackgroundTransparency
		v_u_120.BackgroundTransparency = 1
		v_u_120.TextStrokeTransparency = 1
		v_u_120.TextTransparency = 1
		local v125 = v_u_15
		local v126 = v_u_3
		local v127 = v_u_120
		local v128 = v_u_19
		table.insert(v125, v126:Create(v127, v128, {
			["TextTransparency"] = 1,
			["TextStrokeTransparency"] = 1,
			["BackgroundTransparency"] = 1
		}))
		local v129 = v_u_16
		local v130 = v_u_3
		local v131 = v_u_120
		local v132 = v_u_19
		table.insert(v129, v130:Create(v131, v132, {
			["TextTransparency"] = v122,
			["TextStrokeTransparency"] = v123,
			["BackgroundTransparency"] = v124
		}))
		for _, v133 in pairs(v_u_120:getChildren()) do
			if v133:IsA("UIStroke") then
				local v134 = v_u_15
				local v135 = v_u_3
				local v136 = v_u_19
				table.insert(v134, v135:Create(v133, v136, {
					["Transparency"] = 1
				}))
				local v137 = v_u_16
				local v138 = v_u_3
				local v139 = v_u_19
				local v140 = {
					["Transparency"] = v133.Transparency
				}
				table.insert(v137, v138:Create(v133, v139, v140))
			end
		end
	end
	local function v152()
		-- upvalues: (copy) v_u_117, (copy) v_u_15, (ref) v_u_3, (copy) v_u_19, (copy) v_u_16
		local v142 = v_u_117.ImageTransparency
		local v143 = v_u_117.BackgroundTransparency
		v_u_117.BackgroundTransparency = 1
		v_u_117.ImageTransparency = 1
		local v144 = v_u_15
		local v145 = v_u_3
		local v146 = v_u_117
		local v147 = v_u_19
		table.insert(v144, v145:Create(v146, v147, {
			["ImageTransparency"] = 1,
			["BackgroundTransparency"] = 1
		}))
		local v148 = v_u_16
		local v149 = v_u_3
		local v150 = v_u_117
		local v151 = v_u_19
		table.insert(v148, v149:Create(v150, v151, {
			["ImageTransparency"] = v142,
			["BackgroundTransparency"] = v143
		}))
	end
	local function v163()
		-- upvalues: (copy) v_u_121, (copy) v_u_15, (ref) v_u_3, (copy) v_u_19, (copy) v_u_16
		local v153 = v_u_121.BackgroundTransparency
		local v154 = v_u_121.ImageTransparency
		v_u_121.BackgroundTransparency = 1
		v_u_121.ImageTransparency = 1
		local v155 = v_u_15
		local v156 = v_u_3
		local v157 = v_u_121
		local v158 = v_u_19
		table.insert(v155, v156:Create(v157, v158, {
			["ImageTransparency"] = 1,
			["BackgroundTransparency"] = 1
		}))
		local v159 = v_u_16
		local v160 = v_u_3
		local v161 = v_u_121
		local v162 = v_u_19
		table.insert(v159, v160:Create(v161, v162, {
			["ImageTransparency"] = v154,
			["BackgroundTransparency"] = v153
		}))
	end
	if p11 == Enum.ProximityPromptInputType.Gamepad then
		if v_u_6[p_u_10.GamepadKeyCode] then
			v163()
			v_u_121.Image = v_u_6[p_u_10.GamepadKeyCode]
			v_u_120.Visible = false
			v_u_117.Visible = false
			v119.Visible = false
			v118.Visible = false
			v_u_121.Visible = true
		end
	elseif p11 == Enum.ProximityPromptInputType.Touch then
		v152()
		v_u_117.Image = "rbxassetid://123656284228864"
		v118.Image = "rbxassetid://123656284228864"
		v119.Visible = false
		v_u_120.Visible = false
		v_u_121.Visible = false
		v_u_117.Visible = true
	else
		v152()
		v_u_117.Visible = true
		v119.Visible = true
		local v164 = v_u_1:GetStringForKeyCode(p_u_10.KeyboardKeyCode)
		local v165 = v_u_7[p_u_10.KeyboardKeyCode]
		if v165 == nil then
			v165 = v_u_8[v164]
		end
		if v165 == nil then
			v164 = v_u_9[p_u_10.KeyboardKeyCode] or v164
		end
		if v165 then
			v163()
			v_u_121.Image = v165
			v_u_120.Visible = false
			v119.Visible = false
			v_u_121.Visible = true
		elseif v164 == nil or v164 == "" then
			local v166 = error
			local v167 = p_u_10.Name
			local v168 = p_u_10.KeyboardKeyCode
			v166("ProximityPrompt \'" .. v167 .. "\' has an unsupported keycode for rendering UI: " .. tostring(v168))
		else
			if string.len(v164) > 2 then
				local v169 = v_u_120.TextSize * 6 / 7
				v_u_120.TextSize = math.round(v169)
			end
			v141()
			v_u_120.Text = v164
			v119.Text = v164
			v_u_121.Visible = false
			v_u_120.Visible = true
			v119.Visible = true
		end
	end
	if p11 == Enum.ProximityPromptInputType.Touch or p_u_10.ClickablePrompt then
		local v170 = v_u_21.TextButton
		local v_u_171 = false
		v170.InputBegan:Connect(function(p172)
			-- upvalues: (copy) p_u_10, (ref) v_u_171
			if (p172.UserInputType == Enum.UserInputType.Touch or p172.UserInputType == Enum.UserInputType.MouseButton1) and p172.UserInputState ~= Enum.UserInputState.Change then
				p_u_10:InputHoldBegin()
				v_u_171 = true
			end
		end)
		v170.InputEnded:Connect(function(p173)
			-- upvalues: (ref) v_u_171, (copy) p_u_10
			if (p173.UserInputType == Enum.UserInputType.Touch or p173.UserInputType == Enum.UserInputType.MouseButton1) and v_u_171 then
				v_u_171 = false
				p_u_10:InputHoldEnd()
			end
		end)
		v_u_21.Active = true
	end
	if p_u_10.HoldDuration > 0 then
		local v_u_174 = v_u_21.SquarePrompt.Fill.UIGradient
		local v_u_175 = v_u_21.Progress
		v_u_175.Changed:Connect(function(_)
			-- upvalues: (copy) v_u_174, (copy) v_u_175
			v_u_174.Offset = Vector2.new(0, -(v_u_175.Value / 1))
		end)
		local v176 = v_u_3
		local v177 = v_u_21.Progress
		table.insert(v_u_13, v176:Create(v177, v17, {
			["Value"] = 1
		}))
		local v178 = v_u_3
		local v179 = v_u_21.Progress
		table.insert(v_u_14, v178:Create(v179, v20, {
			["Value"] = 0
		}))
	end
	local v_u_180 = nil
	local v_u_181, v_u_182
	if p_u_10.HoldDuration > 0 then
		v_u_181 = p_u_10.PromptButtonHoldBegan:Connect(function()
			-- upvalues: (copy) v_u_13
			for _, v183 in ipairs(v_u_13) do
				v183:Play()
			end
		end)
		v_u_182 = p_u_10.PromptButtonHoldEnded:Connect(function()
			-- upvalues: (copy) v_u_14
			for _, v184 in ipairs(v_u_14) do
				v184:Play()
			end
		end)
	else
		v_u_181 = nil
		v_u_182 = nil
	end
	local v_u_186 = p_u_10.Triggered:Connect(function()
		-- upvalues: (copy) v_u_15
		for _, v185 in ipairs(v_u_15) do
			v185:Play()
		end
	end)
	local v_u_188 = p_u_10.TriggerEnded:Connect(function()
		-- upvalues: (copy) v_u_16
		for _, v187 in ipairs(v_u_16) do
			v187:Play()
		end
	end)
	local function v196()
		-- upvalues: (copy) p_u_10, (copy) v_u_30, (ref) v_u_4, (copy) v_u_31, (ref) v_u_21
		local v189 = Instance.new("GetTextBoundsParams")
		v189.Text = p_u_10.ActionText
		v189.Font = v_u_30.FontFace
		v189.Size = v_u_30.TextSize
		v189.Width = 1000
		local v190 = v_u_4:GetTextBoundsAsync(v189)
		local v191 = Instance.new("GetTextBoundsParams")
		v191.Text = p_u_10.ObjectText
		v191.Font = v_u_31.FontFace
		v191.Size = v_u_31.TextSize
		v191.Width = 1000
		local v192 = v_u_4:GetTextBoundsAsync(v191)
		local v193 = v190.X
		local v194 = v192.X
		local v195 = math.max(v193, v194)
		if p_u_10.ActionText ~= nil and p_u_10.ActionText ~= "" or p_u_10.ObjectText ~= nil and p_u_10.ObjectText ~= "" then
			local _ = v195 + 72 + 24
		end
		local _ = p_u_10.ObjectText == nil or p_u_10.ObjectText == ""
		if p_u_10.ActionText == "" and p_u_10.ObjectText ~= "" then
			v_u_31.Position = UDim2.new(v_u_31.Position.X.Scale, v_u_31.Position.X.Offset, 0.5, 0)
		end
		if p_u_10.ObjectText == "" and p_u_10.ActionText ~= "" then
			v_u_30.Position = UDim2.new(v_u_30.Position.X.Scale, v_u_30.Position.X.Offset, 0.5, 0)
		end
		v_u_30.Text = p_u_10.ActionText
		v_u_31.Text = p_u_10.ObjectText
		v_u_30.AutoLocalize = p_u_10.AutoLocalize
		v_u_30.RootLocalizationTable = p_u_10.RootLocalizationTable
		v_u_31.AutoLocalize = p_u_10.AutoLocalize
		v_u_31.RootLocalizationTable = p_u_10.RootLocalizationTable
		v_u_21.Size = UDim2.fromOffset(v195 + 120, v_u_21.Size.Y.Offset)
	end
	for _, v197 in ipairs(v_u_16) do
		v197:Play()
	end
	if p_u_10.Enabled == false then
		for _, v198 in ipairs(v_u_15) do
			v198:Play()
		end
	end
	local v_u_200 = p_u_10:GetPropertyChangedSignal("Enabled"):Connect(function()
		-- upvalues: (copy) p_u_10, (copy) v_u_15
		if p_u_10.Enabled == false then
			for _, v199 in ipairs(v_u_15) do
				v199:Play()
			end
		end
	end)
	local v_u_201 = p_u_10.Changed:Connect(v196)
	v196()
	v_u_21.Adornee = p_u_10.Parent
	v_u_21.Parent = p12
	local function v_u_203()
		-- upvalues: (ref) v_u_181, (ref) v_u_182, (ref) v_u_186, (ref) v_u_188, (copy) v_u_201, (ref) v_u_200, (ref) v_u_180, (copy) v_u_15, (ref) v_u_21
		if v_u_181 then
			v_u_181:Disconnect()
		end
		if v_u_182 then
			v_u_182:Disconnect()
		end
		v_u_186:Disconnect()
		v_u_188:Disconnect()
		v_u_201:Disconnect()
		v_u_200:Disconnect()
		v_u_180:Disconnect()
		for _, v202 in ipairs(v_u_15) do
			v202:Play()
		end
		wait(0.2)
		v_u_21.Parent = nil
	end
	v_u_180 = p_u_10:GetPropertyChangedSignal("Parent"):Connect(function()
		-- upvalues: (copy) p_u_10, (copy) v_u_203
		if p_u_10.Parent == nil then
			v_u_203()
		end
	end)
	return v_u_203
end
v2.PromptShown:Connect(function(p205, p206)
	-- upvalues: (copy) v_u_5, (copy) v_u_204
	if p205.Style ~= Enum.ProximityPromptStyle.Default then
		local v207 = v_u_5:FindFirstChild("ProximityPrompts")
		if v207 == nil then
			v207 = Instance.new("ScreenGui")
			v207.Name = "ProximityPrompts"
			v207.ResetOnSpawn = false
			v207.Parent = v_u_5
		end
		local v208 = v_u_204(p205, p206, v207)
		p205.PromptHidden:Wait()
		v208()
	end
end)