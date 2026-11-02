-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ContextActionService")
local v_u_2 = game:GetService("TextChatService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("UserInputService")
local v5 = game:GetService("ReplicatedStorage")
local v_u_6 = game:GetService("StarterGui")
local v_u_7 = game:GetService("GuiService")
local v8 = game:GetService("RunService")
local v_u_9 = game:GetService("VRService")
local v10 = game:GetService("Players")
local v11 = v10.LocalPlayer:WaitForChild("PlayerGui")
local v_u_12 = {
	["OpenClose"] = nil,
	["IsOpen"] = false,
	["StateChanged"] = Instance.new("BindableEvent"),
	["ModuleName"] = "Backpack",
	["KeepVRTopbarOpen"] = true,
	["VRIsExclusive"] = true,
	["VRClosesNonExclusive"] = true,
	["BackpackEmpty"] = Instance.new("BindableEvent")
}
v_u_12.BackpackEmpty.Name = "BackpackEmpty"
v_u_12.BackpackItemAdded = Instance.new("BindableEvent")
v_u_12.BackpackItemAdded.Name = "BackpackAdded"
v_u_12.BackpackItemRemoved = Instance.new("BindableEvent")
v_u_12.BackpackItemRemoved.Name = "BackpackRemoved"
local v13 = script
local v14 = v_u_7.PreferredTransparency or 1
local v_u_15 = not v13:GetAttribute("OutlineEquipBorder") or false
local v_u_16 = v13:GetAttribute("InsetIconPadding")
local v_u_17 = v13:GetAttribute("BackgroundTransparency") or 0.3
local v_u_18 = v_u_17 * v14
local v19 = UDim.new(0, 8)
local v_u_20 = v13:GetAttribute("BackgroundColor3") or Color3.new(0.09803921568627451, 0.10588235294117647, 0.11372549019607843)
local v_u_21 = v13:GetAttribute("EquipBorderColor3") or Color3.new(0, 0.6352941176470588, 1)
local v_u_22 = v13:GetAttribute("BackgroundTransparency") or 0.3
local v_u_23 = v_u_22 * v14
local v_u_24 = v13:GetAttribute("EquipBorderSizePixel") or 5
local v_u_25 = v13:GetAttribute("CornerRadius") or UDim.new(0, 8)
local v_u_26 = Color3.new(1, 1, 1)
local v_u_27 = v_u_25 - UDim.new(0, 5) or UDim.new(0, 3)
local v_u_28 = v13:GetAttribute("BackgroundColor3") or Color3.new(0.09803921568627451, 0.10588235294117647, 0.11372549019607843)
local v_u_29 = v13:GetAttribute("TextColor3") or Color3.new(1, 1, 1)
local v_u_30 = v13:GetAttribute("TextStrokeTransparency") or 0.5
local v_u_31 = v13:GetAttribute("TextStrokeColor3") or Color3.new(0, 0, 0)
local v32 = Color3.new(0.09803921568627451, 0.10588235294117647, 0.11372549019607843)
local v_u_33 = v14 * 0.2
local v34 = Color3.new(1, 1, 1)
local v35 = UDim.new(0, 3)
local v_u_36 = v13:GetAttribute("FontFace") or Font.new("rbxasset://fonts/families/BuilderSans.json")
local v_u_37 = v13:GetAttribute("TextSize") or 16
local v_u_38 = Enum.KeyCode.Backspace.Value
local v_u_39 = Enum.KeyCode.Zero.Value
local v_u_40 = {
	[Enum.UserInputType.MouseButton1] = true,
	[Enum.UserInputType.MouseButton2] = true,
	[Enum.UserInputType.MouseButton3] = true,
	[Enum.UserInputType.MouseMovement] = true,
	[Enum.UserInputType.MouseWheel] = true
}
local v_u_41 = {
	[Enum.UserInputType.Gamepad1] = true,
	[Enum.UserInputType.Gamepad2] = true,
	[Enum.UserInputType.Gamepad3] = true,
	[Enum.UserInputType.Gamepad4] = true,
	[Enum.UserInputType.Gamepad5] = true,
	[Enum.UserInputType.Gamepad6] = true,
	[Enum.UserInputType.Gamepad7] = true,
	[Enum.UserInputType.Gamepad8] = true
}
local v42 = script:WaitForChild("UI")
local v43 = v42:WaitForChild("EquipBest")
local v44 = v42:WaitForChild("FavoriteFilterButton")
local v_u_45 = true
local v_u_46 = require(script.Packages:WaitForChild("topbarplus")).new():setName("Inventory"):setImage("rbxasset://textures/ui/TopBar/inventoryOn.png", "Selected"):setImage("rbxasset://textures/ui/TopBar/inventoryOff.png", "Deselected"):setImageScale(1):setCaption("Inventory"):bindToggleKey(Enum.KeyCode.Backquote):autoDeselect(false):setOrder(-1)
v_u_46.toggled:Connect(function()
	-- upvalues: (copy) v_u_7, (copy) v_u_12
	if not v_u_7.MenuIsOpen then
		v_u_12.OpenClose()
	end
end)
local v_u_47 = Instance.new("ScreenGui")
v_u_47.DisplayOrder = 120
v_u_47.IgnoreGuiInset = true
v_u_47.ResetOnSpawn = false
v_u_47.Name = "BackpackGui"
v_u_47.Parent = v11
local v_u_48 = v_u_7:IsTenFootInterface()
local v_u_49
if v_u_48 then
	v_u_49 = 100
	v_u_37 = 24
else
	v_u_49 = 60
end
local v_u_50 = false
local v_u_51 = v_u_4.TouchEnabled
if v_u_51 then
	v_u_51 = workspace.CurrentCamera.ViewportSize.X < 1024
end
local v_u_52 = v10.LocalPlayer
local v53 = v5.Events
local v_u_54 = v53.ToggleFavorite
local v_u_55 = v53.EquipBest
local v_u_56 = nil
local v_u_57 = nil
local v_u_58 = nil
local v_u_59 = nil
local v_u_60 = nil
local v_u_61 = nil
local v_u_62 = nil
local v_u_63 = v_u_52.Character or v_u_52.CharacterAdded:Wait()
local v_u_64 = v_u_63:WaitForChild("Humanoid")
local v_u_65 = v_u_52:WaitForChild("Backpack")
local v_u_66 = {}
local v_u_67 = nil
local v_u_68 = {}
local v_u_69 = {}
local v_u_70 = {}
local v_u_71 = 0
local v_u_72 = nil
local v_u_73 = false
local v_u_74 = false
local v_u_75 = false
local v_u_76 = 0
local v_u_77 = {}
local v_u_78 = false
local v_u_79 = v_u_9.VREnabled
local v_u_80 = v_u_79 and 6 or (v_u_51 and 6 or 10)
local v_u_81 = v_u_79 and 3 or (v_u_51 and 2 or 4)
local v_u_82 = nil
function v_u_12.IsInventoryEmpty()
	-- upvalues: (copy) v_u_80, (copy) v_u_66
	for v83 = v_u_80 + 1, #v_u_66 do
		local v84 = v_u_66[v83]
		if v84 and v84.Tool then
			return false
		end
	end
	return true
end
local function v_u_91()
	-- upvalues: (ref) v_u_71, (copy) v_u_66, (copy) v_u_80, (ref) v_u_58
	v_u_71 = 0
	for _, v85 in v_u_66 do
		if v85.Tool and v_u_80 >= v85.Index then
			v_u_71 = v_u_71 + 1
		end
	end
	local v86 = v_u_58.Visible
	local v87 = v86 and v_u_80 or v_u_71
	local v88 = 0
	for v89 = 1, v_u_80 do
		local v90 = v_u_66[v89]
		if v90.Tool or v86 then
			v88 = v88 + 1
			v90:Readjust(v88, v87)
			v90.Frame.Visible = true
		else
			v90.Frame.Visible = false
		end
	end
end
local function v_u_96()
	-- upvalues: (ref) v_u_60, (ref) v_u_49, (ref) v_u_61
	local v92 = v_u_60.AbsoluteSize.X / (v_u_49 + 5)
	local v93 = math.floor(v92)
	local v94 = (#v_u_61:GetChildren() - 1) / v93
	local v95 = math.ceil(v94) * (v_u_49 + 5) + 5
	v_u_60.CanvasSize = UDim2.new(0, 0, 0, v95)
end
local function v_u_100()
	-- upvalues: (copy) v_u_80, (copy) v_u_66, (ref) v_u_76, (copy) v_u_96
	for v97 = v_u_80 + 1, #v_u_66 do
		local v98 = v_u_66[v97]
		if v98.Tool then
			local v99 = v98.Tool:GetAttribute("IsFavorited") == true
			if v_u_76 == 0 then
				v98.Frame.Visible = true
			elseif v_u_76 == 1 then
				v98.Frame.Visible = v99
			elseif v_u_76 == 2 then
				v98.Frame.Visible = not v99
			end
		else
			v98.Frame.Visible = false
		end
	end
	v_u_96()
end
local function v_u_103()
	-- upvalues: (copy) v_u_80, (copy) v_u_66, (copy) v_u_96
	for v101 = v_u_80 + 1, #v_u_66 do
		local v102 = v_u_66[v101]
		v102.Frame.LayoutOrder = v102.Index
		v102.Frame.Visible = v102.Tool ~= nil
	end
	v_u_96()
end
local function v104()
	-- upvalues: (ref) v_u_57, (copy) v_u_80, (ref) v_u_49, (ref) v_u_58, (copy) v_u_81, (copy) v_u_79, (ref) v_u_60, (copy) v_u_91, (copy) v_u_103
	v_u_57.Size = UDim2.new(0, v_u_80 * (v_u_49 + 5) + 5, 0, v_u_49 + 5 + 5)
	v_u_57.Position = UDim2.new(0.5, -v_u_57.Size.X.Offset / 2, 1, -v_u_57.Size.Y.Offset)
	v_u_58.Size = UDim2.new(0, v_u_57.Size.X.Offset, 0, v_u_57.Size.Y.Offset * v_u_81 + 40 + (v_u_79 and 80 or 0))
	v_u_58.Position = UDim2.new(0.5, -v_u_58.Size.X.Offset / 2, 1, v_u_57.Position.Y.Offset - v_u_58.Size.Y.Offset)
	v_u_60.Size = UDim2.new(1, v_u_60.ScrollBarThickness + 1, 1, -40 - (v_u_79 and 80 or 0))
	v_u_60.Position = UDim2.new(0, 0, 0, 40 + (v_u_79 and 40 or 0))
	v_u_91()
	v_u_103()
end
function FindLadder()
	-- upvalues: (copy) v_u_66
	local v105 = nil
	for v106, v107 in ipairs(v_u_66) do
		if v107.Tool and v107.Tool.Name == "Ladder" then
			return v106
		end
	end
	return v105
end
local function v_u_204(p108, p109)
	-- upvalues: (copy) v_u_66, (ref) v_u_23, (ref) v_u_57, (ref) v_u_49, (ref) v_u_76, (copy) v_u_100, (copy) v_u_80, (ref) v_u_58, (copy) v_u_4, (ref) v_u_71, (ref) v_u_73, (ref) v_u_50, (copy) v_u_1, (ref) v_u_62, (copy) v_u_68, (ref) v_u_67, (copy) v_u_54, (ref) v_u_63, (ref) v_u_82, (copy) v_u_24, (copy) v_u_21, (copy) v_u_15, (copy) v_u_96, (ref) v_u_64, (ref) v_u_72, (ref) v_u_65, (copy) v_u_20, (copy) v_u_26, (copy) v_u_25, (copy) v_u_51, (copy) v_u_16, (copy) v_u_29, (copy) v_u_30, (copy) v_u_31, (copy) v_u_36, (ref) v_u_37, (copy) v_u_3, (copy) v_u_28, (copy) v_u_27, (copy) v_u_204, (ref) v_u_61, (ref) v_u_75, (copy) v_u_69, (copy) v_u_39, (copy) v_u_70, (copy) v_u_46, (ref) v_u_60
	local v110 = p109 or #v_u_66 + 1
	local v_u_111 = {
		["Tool"] = nil,
		["Index"] = v110,
		["Frame"] = nil
	}
	local v_u_112 = nil
	local v_u_113 = nil
	local v_u_114 = nil
	local v_u_115 = nil
	local v_u_116 = nil
	local v_u_117 = nil
	local v_u_118 = nil
	local v_u_119 = nil
	local v_u_120 = nil
	function v_u_111.Readjust(_, p121, p122)
		-- upvalues: (ref) v_u_57, (ref) v_u_49, (ref) v_u_112
		local v123 = v_u_57.Size.X.Offset / 2
		local v124 = v_u_49 + 5
		local v125 = p121 - (p122 / 2 + 0.5)
		v_u_112.Position = UDim2.new(0, v123 - v_u_49 / 2 + v124 * v125, 0, 5)
	end
	function v_u_111.Fill(p_u_126, p_u_127)
		-- upvalues: (ref) v_u_114, (ref) v_u_115, (ref) v_u_119, (ref) v_u_116, (ref) v_u_118, (ref) v_u_76, (ref) v_u_100, (ref) v_u_80, (ref) v_u_58, (ref) v_u_4, (ref) v_u_112, (ref) v_u_71, (ref) v_u_73, (ref) v_u_50, (ref) v_u_1, (ref) v_u_62, (ref) v_u_68, (ref) v_u_67, (ref) v_u_66
		if not p_u_127 then
			return p_u_126:Clear()
		end
		p_u_126.Tool = p_u_127
		local function v_u_129()
			-- upvalues: (copy) p_u_127, (ref) v_u_114, (ref) v_u_115, (ref) v_u_119
			local v128 = p_u_127.TextureId
			v_u_114.Image = v128
			if v128 == "" then
				v_u_115.Visible = true
			else
				v_u_115.Visible = false
			end
			v_u_115.Text = p_u_127.Name
			if v_u_119 and p_u_127:IsA("Tool") then
				v_u_119.Text = p_u_127.ToolTip
				v_u_119.Size = UDim2.new(0, 0, 0, 16)
				v_u_119.Position = UDim2.new(0.5, 0, 0, -5)
			end
		end
		v_u_129()
		if v_u_116 then
			v_u_116:Disconnect()
			v_u_116 = nil
		end
		v_u_116 = p_u_127.Changed:Connect(function(p130)
			-- upvalues: (copy) v_u_129, (copy) p_u_126
			if p130 == "TextureId" or (p130 == "Name" or p130 == "ToolTip") then
				v_u_129()
			elseif p130 == "IsFavorited" then
				p_u_126:UpdateFavoriteStar()
			end
		end)
		p_u_126:UpdateFavoriteStar()
		if v_u_118 then
			v_u_118:Disconnect()
		end
		v_u_118 = p_u_127:GetAttributeChangedSignal("IsFavorited"):Connect(function()
			-- upvalues: (copy) p_u_126, (ref) v_u_76, (ref) v_u_100
			p_u_126:UpdateFavoriteStar()
			if v_u_76 ~= 0 then
				v_u_100()
			end
		end)
		local v131 = p_u_126.Index <= v_u_80
		if (not v131 or v_u_58.Visible) and not v_u_4.VREnabled then
			v_u_112.Draggable = true
		end
		p_u_126:UpdateEquipView()
		if v131 then
			v_u_71 = v_u_71 + 1
			if v_u_73 and (v_u_71 >= 1 and not v_u_50) then
				v_u_50 = true
				v_u_1:BindAction("BackpackHotbarEquip", v_u_62, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
			end
		end
		v_u_68[p_u_127] = p_u_126
		for v132 = 1, v_u_80 do
			v133 = v_u_66[v132]
			if not v133.Tool then
				::l23::
				v_u_67 = v133
				return
			end
		end
		local v133 = nil
		goto l23
	end
	function v_u_111.ToggleFavorite(p134)
		-- upvalues: (ref) v_u_54
		if p134.Tool then
			if p134.Tool:GetAttribute("Mutation") then
				v_u_54:FireServer(p134.Tool)
			end
		else
			return
		end
	end
	function v_u_111.Clear(p135)
		-- upvalues: (ref) v_u_116, (ref) v_u_118, (ref) v_u_114, (ref) v_u_115, (ref) v_u_119, (ref) v_u_112, (ref) v_u_80, (ref) v_u_71, (ref) v_u_50, (ref) v_u_1, (ref) v_u_68, (ref) v_u_67, (ref) v_u_66
		if not p135.Tool then
			return
		end
		if v_u_116 then
			v_u_116:Disconnect()
			v_u_116 = nil
		end
		if v_u_118 then
			v_u_118:Disconnect()
			v_u_118 = nil
		end
		v_u_114.Image = ""
		v_u_115.Text = ""
		if v_u_119 then
			v_u_119.Text = ""
			v_u_119.Visible = false
		end
		v_u_112.Draggable = false
		p135:UpdateEquipView(true)
		if p135.Index <= v_u_80 then
			v_u_71 = v_u_71 - 1
			if v_u_71 < 1 then
				v_u_50 = false
				v_u_1:UnbindAction("BackpackHotbarEquip")
			end
		end
		v_u_68[p135.Tool] = nil
		p135.Tool = nil
		p135:UpdateFavoriteStar()
		for v136 = 1, v_u_80 do
			v137 = v_u_66[v136]
			if not v137.Tool then
				::l16::
				v_u_67 = v137
				return
			end
		end
		local v137 = nil
		goto l16
	end
	function v_u_111.UpdateEquipView(p138, p139)
		-- upvalues: (ref) v_u_63, (ref) v_u_82, (copy) v_u_111, (ref) v_u_117, (ref) v_u_24, (ref) v_u_21, (ref) v_u_15, (ref) v_u_114, (ref) v_u_112, (ref) v_u_23
		if p139 or false then
			::l2::
			if v_u_117 then
				v_u_117.Parent = nil
			end
		else
			local v140 = p138.Tool
			if v140 then
				v140 = v140.Parent == v_u_63
			end
			if not v140 then
				goto l2
			end
			v_u_82 = v_u_111
			if not v_u_117 then
				v_u_117 = Instance.new("UIStroke")
				v_u_117.Name = "Border"
				v_u_117.Thickness = v_u_24
				v_u_117.Color = v_u_21
				v_u_117.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			end
			if v_u_15 == true then
				v_u_117.Parent = v_u_114
			else
				v_u_117.Parent = v_u_112
			end
		end
		v_u_112.SelectionImageObject = nil
		v_u_112.BackgroundTransparency = v_u_112.Draggable and 0 or v_u_23
	end
	function v_u_111.IsEquipped(p141)
		-- upvalues: (ref) v_u_63
		local v142 = p141.Tool
		if v142 then
			v142 = v142.Parent == v_u_63
		end
		return v142
	end
	function v_u_111.Delete(p143)
		-- upvalues: (ref) v_u_112, (ref) v_u_66, (ref) v_u_96
		v_u_112:Destroy()
		table.remove(v_u_66, p143.Index)
		local v144 = #v_u_66
		for v145 = p143.Index, v144 do
			v_u_66[v145]:SlideBack()
		end
		v_u_96()
	end
	function v_u_111.Swap(p146, p147)
		local v148 = p146.Tool
		local v149
		if p147 then
			v149 = p147.Tool
		else
			v149 = p147
		end
		p146:Clear()
		if v149 then
			p147:Clear()
			p146:Fill(v149)
		end
		if v148 then
			p147:Fill(v148)
		else
			p147:Clear()
		end
	end
	function v_u_111.SlideNext(p150)
		-- upvalues: (ref) v_u_112
		p150.Index = p150.Index + 1
		v_u_112.Name = p150.Index
		v_u_112.LayoutOrder = p150.Index
	end
	function v_u_111.SlideBack(p151)
		-- upvalues: (ref) v_u_112
		p151.Index = p151.Index - 1
		v_u_112.Name = p151.Index
		v_u_112.LayoutOrder = p151.Index
	end
	function v_u_111.TurnNumber(_, p152)
		-- upvalues: (ref) v_u_120
		if v_u_120 then
			v_u_120.Visible = p152
		end
	end
	function v_u_111.SetClickability(p153, p154)
		-- upvalues: (ref) v_u_4, (ref) v_u_112, (ref) v_u_23
		if p153.Tool then
			if v_u_4.VREnabled then
				v_u_112.Draggable = false
			else
				v_u_112.Draggable = not p154
			end
			v_u_112.SelectionImageObject = nil
			v_u_112.BackgroundTransparency = v_u_112.Draggable and 0 or v_u_23
		end
	end
	function v_u_111.CheckTerms(p155, p156)
		-- upvalues: (ref) v_u_115, (ref) v_u_119
		local v157 = 0
		local v158 = p155.Tool
		local v159
		if v158 then
			v159 = v157
			for v160 in pairs(p156) do
				local _, v161 = v_u_115.Text:lower():gsub(v160, "")
				v157 = v159 + v161
				if v158:IsA("Tool") then
					local _, v162 = (v_u_119 and v_u_119.Text or ""):lower():gsub(v160, "")
					v157 = v157 + v162
					v159 = v157
				else
					v159 = v157
				end
			end
		else
			v159 = v157
		end
		return v159
	end
	function v_u_111.Select(_)
		-- upvalues: (copy) v_u_111, (ref) v_u_63, (ref) v_u_64, (ref) v_u_72, (ref) v_u_68, (ref) v_u_65
		local v163 = v_u_111.Tool
		if v163 then
			local v164
			if v163 then
				v164 = v163.Parent == v_u_63
			else
				v164 = v163
			end
			if v164 then
				if v_u_64 then
					v_u_64:UnequipTools()
					if v_u_72 then
						v_u_72:ToggleSelect()
						v_u_68[v_u_72]:UpdateEquipView()
						v_u_72 = nil
						return
					end
				end
			elseif v163.Parent == v_u_65 then
				if v_u_64 then
					v_u_64:UnequipTools()
					if v_u_72 then
						v_u_72:ToggleSelect()
						v_u_68[v_u_72]:UpdateEquipView()
						v_u_72 = nil
					end
				end
				v_u_64:EquipTool(v163)
			end
		end
	end
	v_u_112 = Instance.new("TextButton")
	v_u_112.Name = tostring(v110)
	v_u_112.BackgroundColor3 = v_u_20
	v_u_112.BorderColor3 = v_u_26
	v_u_112.Text = ""
	v_u_112.BorderSizePixel = 0
	v_u_112.Size = UDim2.new(0, v_u_49, 0, v_u_49)
	v_u_112.Active = true
	v_u_112.Draggable = false
	v_u_112.BackgroundTransparency = v_u_23
	v_u_112.MouseButton1Click:Connect(function()
		-- upvalues: (copy) v_u_111
		changeSlot(v_u_111)
	end)
	local v165 = Instance.new("UICorner")
	v165.Name = "Corner"
	v165.CornerRadius = v_u_25
	v165.Parent = v_u_112
	v_u_111.Frame = v_u_112
	v_u_112.MouseButton2Click:Connect(function()
		-- upvalues: (copy) v_u_111
		if v_u_111.Tool then
			v_u_111:ToggleFavorite()
		end
	end)
	if v_u_51 then
		v_u_112.TouchLongPress:Connect(function()
			-- upvalues: (copy) v_u_111
			if v_u_111.Tool then
				v_u_111:ToggleFavorite()
			end
		end)
	end
	local v166 = Instance.new("Frame")
	v166.Name = "SelectionObjectClipper"
	v166.BackgroundTransparency = 1
	v166.Visible = false
	v166.Parent = v_u_112
	local v167 = Instance.new("ImageLabel")
	v167.Name = "Selector"
	v167.BackgroundTransparency = 1
	v167.Size = UDim2.new(1, 0, 1, 0)
	v167.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
	v167.ScaleType = Enum.ScaleType.Slice
	v167.SliceCenter = Rect.new(12, 12, 52, 52)
	v167.Parent = v166
	v_u_114 = Instance.new("ImageLabel")
	v_u_114.BackgroundTransparency = 1
	v_u_114.Name = "Icon"
	v_u_114.Size = UDim2.new(1, 0, 1, 0)
	v_u_114.Position = UDim2.new(0.5, 0, 0.5, 0)
	v_u_114.AnchorPoint = Vector2.new(0.5, 0.5)
	if v_u_16 == true then
		v_u_114.Size = UDim2.new(1, -v_u_24 * 2, 1, -v_u_24 * 2)
	else
		v_u_114.Size = UDim2.new(1, 0, 1, 0)
	end
	v_u_114.Parent = v_u_112
	local v168 = Instance.new("UICorner")
	v168.Name = "Corner"
	if v_u_16 == true then
		v168.CornerRadius = v_u_25 - UDim.new(0, v_u_24)
	else
		v168.CornerRadius = v_u_25
	end
	v168.Parent = v_u_114
	v_u_115 = Instance.new("TextLabel")
	v_u_115.BackgroundTransparency = 1
	v_u_115.Name = "ToolName"
	v_u_115.Text = ""
	v_u_115.TextColor3 = v_u_29
	v_u_115.TextStrokeTransparency = v_u_30
	v_u_115.TextStrokeColor3 = v_u_31
	v_u_115.FontFace = Font.new(v_u_36.Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	v_u_115.TextSize = v_u_37
	v_u_115.Size = UDim2.new(1, -v_u_24 * 2, 1, -v_u_24 * 2)
	v_u_115.Position = UDim2.new(0.5, 0, 0.5, 0)
	v_u_115.AnchorPoint = Vector2.new(0.5, 0.5)
	v_u_115.TextWrapped = true
	v_u_115.TextTruncate = Enum.TextTruncate.AtEnd
	v_u_115.Parent = v_u_112
	local v_u_169 = Instance.new("TextLabel")
	v_u_169.Name = "StarText"
	v_u_169.BackgroundTransparency = 1
	v_u_169.Size = UDim2.new(0.25, 0, 0.25, 0)
	v_u_169.Position = UDim2.new(1, -v_u_24, 1, -v_u_24)
	v_u_169.AnchorPoint = Vector2.new(1, 1)
	v_u_169.Text = "\226\152\133"
	v_u_169.TextColor3 = Color3.fromRGB(255, 215, 0)
	v_u_169.TextSize = 18
	v_u_169.Visible = false
	v_u_169.ZIndex = 3
	v_u_169.Parent = v_u_112
	function v_u_111.UpdateFavoriteStar(p170)
		-- upvalues: (ref) v_u_169, (ref) v_u_3
		if v_u_169 then
			if p170.Tool then
				local v171 = p170.Tool:GetAttribute("IsFavorited") == true
				v_u_169.Visible = v171
				if v171 then
					v_u_169.TextSize = 0
					v_u_169.Rotation = -45
					v_u_169.TextColor3 = Color3.fromRGB(255, 255, 255)
					v_u_3:Create(v_u_169, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
						["Rotation"] = 0,
						["TextSize"] = 18,
						["TextColor3"] = Color3.fromRGB(255, 215, 0)
					}):Play()
				end
			else
				v_u_169.Visible = false
			end
		else
			return
		end
	end
	v_u_111.Frame.LayoutOrder = v_u_111.Index
	if v110 <= v_u_80 then
		v_u_119 = Instance.new("TextLabel")
		v_u_119.Name = "ToolTip"
		v_u_119.Text = ""
		v_u_119.Size = UDim2.new(1, 0, 1, 0)
		v_u_119.TextColor3 = v_u_29
		v_u_119.TextStrokeTransparency = v_u_30
		v_u_119.TextStrokeColor3 = v_u_31
		v_u_119.FontFace = Font.new(v_u_36.Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal)
		v_u_119.TextSize = v_u_37
		v_u_119.ZIndex = 2
		v_u_119.TextWrapped = false
		v_u_119.TextYAlignment = Enum.TextYAlignment.Center
		v_u_119.BackgroundColor3 = v_u_28
		v_u_119.BackgroundTransparency = v_u_23
		v_u_119.AnchorPoint = Vector2.new(0.5, 1)
		v_u_119.BorderSizePixel = 0
		v_u_119.Visible = false
		v_u_119.AutomaticSize = Enum.AutomaticSize.X
		v_u_119.Parent = v_u_112
		local v172 = Instance.new("UICorner")
		v172.Name = "Corner"
		v172.CornerRadius = v_u_27
		v172.Parent = v_u_119
		local v173 = Instance.new("UIPadding")
		v173.PaddingLeft = UDim.new(0, 4)
		v173.PaddingRight = UDim.new(0, 4)
		v173.PaddingTop = UDim.new(0, 4)
		v173.PaddingBottom = UDim.new(0, 4)
		v173.Parent = v_u_119
		v_u_112.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_119
			if v_u_119.Text ~= "" then
				v_u_119.Visible = true
			end
		end)
		v_u_112.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_119
			v_u_119.Visible = false
		end)
		function v_u_111.MoveToInventory(p174)
			-- upvalues: (copy) v_u_111, (ref) v_u_80, (ref) v_u_204, (ref) v_u_61, (ref) v_u_63, (ref) v_u_64, (ref) v_u_72, (ref) v_u_68, (ref) v_u_75, (ref) v_u_58, (ref) v_u_76, (ref) v_u_100
			if v_u_111.Index <= v_u_80 then
				local v175 = v_u_111.Tool
				p174:Clear()
				local v176 = v_u_204(v_u_61)
				v176:Fill(v175)
				if v175 then
					v175 = v175.Parent == v_u_63
				end
				if v175 and v_u_64 then
					v_u_64:UnequipTools()
					if v_u_72 then
						v_u_72:ToggleSelect()
						v_u_68[v_u_72]:UpdateEquipView()
						v_u_72 = nil
					end
				end
				if v_u_75 then
					v176.Frame.Visible = false
					v176.Parent = v_u_58
				end
				if v_u_76 ~= 0 then
					v_u_100()
				end
			end
		end
		if v110 < 10 or v110 == v_u_80 then
			local v177 = v110 < 10 and (v110 or 0) or 0
			v_u_120 = Instance.new("TextLabel")
			v_u_120.BackgroundTransparency = 1
			v_u_120.Name = "Number"
			v_u_120.TextColor3 = v_u_29
			v_u_120.TextStrokeTransparency = v_u_30
			v_u_120.TextStrokeColor3 = v_u_31
			v_u_120.TextSize = v_u_37
			v_u_120.Text = tostring(v177)
			v_u_120.FontFace = Font.new(v_u_36.Family, Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
			v_u_120.Size = UDim2.new(0.4, 0, 0.4, 0)
			v_u_120.Visible = false
			v_u_120.Parent = v_u_112
			v_u_69[v_u_39 + v177] = v_u_111.Select
		end
	end
	local v_u_178 = v_u_112.Position
	local v_u_179 = 0
	local v_u_180 = nil
	v_u_112.DragBegin:Connect(function(p181)
		-- upvalues: (ref) v_u_70, (ref) v_u_112, (ref) v_u_178, (ref) v_u_46, (ref) v_u_114, (ref) v_u_115, (ref) v_u_120, (ref) v_u_180, (ref) v_u_61, (ref) v_u_58, (ref) v_u_113
		v_u_70[v_u_112] = true
		v_u_178 = p181
		v_u_112.BorderSizePixel = 2
		v_u_46:lock()
		v_u_112.ZIndex = 2
		v_u_114.ZIndex = 2
		v_u_115.ZIndex = 2
		v_u_112.Parent.ZIndex = 2
		if v_u_120 then
			v_u_120.ZIndex = 2
		end
		v_u_180 = v_u_112.Parent
		if v_u_180 == v_u_61 then
			local v182 = UDim2.new(0, v_u_112.AbsolutePosition.X - v_u_58.AbsolutePosition.X, 0, v_u_112.AbsolutePosition.Y - v_u_58.AbsolutePosition.Y)
			v_u_112.Parent = v_u_58
			v_u_112.Position = v182
			v_u_113 = Instance.new("Frame")
			v_u_113.Name = "FakeSlot"
			v_u_113.LayoutOrder = v_u_112.LayoutOrder
			v_u_113.Size = v_u_112.Size
			v_u_113.BackgroundTransparency = 1
			v_u_113.Parent = v_u_61
		end
	end)
	v_u_112.DragStopped:Connect(function(p183, p184)
		-- upvalues: (ref) v_u_113, (ref) v_u_112, (ref) v_u_178, (ref) v_u_180, (ref) v_u_46, (ref) v_u_114, (ref) v_u_115, (ref) v_u_120, (ref) v_u_70, (copy) v_u_111, (ref) v_u_58, (ref) v_u_80, (ref) v_u_179, (ref) v_u_67, (ref) v_u_76, (ref) v_u_100, (ref) v_u_57, (ref) v_u_66, (ref) v_u_63, (ref) v_u_64, (ref) v_u_72, (ref) v_u_68, (ref) v_u_75
		if v_u_113 then
			v_u_113:Destroy()
		end
		local v185 = os.clock()
		v_u_112.Position = v_u_178
		v_u_112.Parent = v_u_180
		v_u_112.BorderSizePixel = 0
		v_u_46:unlock()
		v_u_112.ZIndex = 1
		v_u_114.ZIndex = 1
		v_u_115.ZIndex = 1
		v_u_180.ZIndex = 1
		if v_u_120 then
			v_u_120.ZIndex = 1
		end
		v_u_70[v_u_112] = nil
		if v_u_111.Tool then
			local v186 = v_u_58
			local v187 = v186.AbsolutePosition
			local v188 = v186.AbsoluteSize
			local v189
			if v187.X < p183 and (p183 <= v187.X + v188.X and v187.Y < p184) then
				v189 = p184 <= v187.Y + v188.Y
			else
				v189 = false
			end
			if v189 then
				if v_u_111.Index <= v_u_80 then
					v_u_111:MoveToInventory()
				end
				if v_u_80 < v_u_111.Index and v185 - v_u_179 < 0.5 then
					if v_u_67 then
						local v190 = v_u_111.Tool
						v_u_111:Clear()
						v_u_67:Fill(v190)
						v_u_111:Delete()
						if v_u_76 == 0 then
							v185 = 0
						else
							v_u_100()
							v185 = 0
						end
					else
						v185 = 0
					end
				end
			else
				local v191 = v_u_57
				local v192 = v191.AbsolutePosition
				local v193 = v191.AbsoluteSize
				local v194
				if v192.X < p183 and (p183 <= v192.X + v193.X and v192.Y < p184) then
					v194 = p184 <= v192.Y + v193.Y
				else
					v194 = false
				end
				if v194 then
					local v195 = { (1 / 0), nil }
					for v196 = 1, v_u_80 do
						local v197 = v_u_66[v196]
						local v198 = v197.Frame
						local v199 = Vector2.new(p183, p184)
						local v200 = (v198.AbsolutePosition + v198.AbsoluteSize / 2 - v199).Magnitude
						if v200 < v195[1] then
							v195 = { v200, v197 }
						end
					end
					local v201 = v195[2]
					if v201 ~= v_u_111 then
						v_u_111:Swap(v201)
						if v_u_80 < v_u_111.Index then
							local v202 = v_u_111.Tool
							if v202 then
								if v202 then
									v202 = v202.Parent == v_u_63
								end
								if v202 and v_u_64 then
									v_u_64:UnequipTools()
									if v_u_72 then
										v_u_72:ToggleSelect()
										v_u_68[v_u_72]:UpdateEquipView()
										v_u_72 = nil
									end
								end
								if v_u_75 then
									v_u_111.Frame.Visible = false
									v_u_111.Frame.Parent = v_u_58
								end
								if v_u_76 ~= 0 then
									v_u_100()
								end
							else
								v_u_111:Delete()
							end
						end
					end
				elseif v_u_111.Index <= v_u_80 then
					v_u_111:MoveToInventory()
				end
			end
			v_u_179 = v185
		end
	end)
	v_u_112.Parent = p108
	v_u_66[v110] = v_u_111
	if v_u_80 < v110 then
		v_u_96()
		if v_u_58.Visible and not v_u_75 then
			local v203 = v_u_60.CanvasSize.Y.Offset - v_u_60.AbsoluteSize.Y
			v_u_60.CanvasPosition = Vector2.new(0, (math.max(0, v203)))
		end
	end
	return v_u_111
end
local function v_u_207(p205)
	-- upvalues: (ref) v_u_63, (ref) v_u_64, (ref) v_u_72, (copy) v_u_68, (ref) v_u_67, (copy) v_u_204, (ref) v_u_61, (copy) v_u_80, (ref) v_u_58, (copy) v_u_91, (copy) v_u_66, (ref) v_u_76, (copy) v_u_100, (copy) v_u_12
	if p205:IsA("Tool") or p205:IsA("HopperBin") then
		local _ = p205.Parent == v_u_63
		if v_u_72 and p205.Parent == v_u_63 then
			v_u_72:ToggleSelect()
			v_u_68[v_u_72]:UpdateEquipView()
			v_u_72 = nil
		end
		local v206 = v_u_68[p205]
		if v206 then
			v206:UpdateEquipView()
		else
			v206 = v_u_67 or v_u_204(v_u_61)
			v206:Fill(p205)
			if v206.Index <= v_u_80 and not v_u_58.Visible then
				v_u_91()
			end
			if p205:IsA("HopperBin") and p205.Active then
				if v_u_64 then
					v_u_64:UnequipTools()
					if v_u_72 then
						v_u_72:ToggleSelect()
						v_u_68[v_u_72]:UpdateEquipView()
						v_u_72 = nil
					end
				end
				v_u_72 = p205
			end
		end
		if p205.Name == "Ladder" then
			v206:Swap(v_u_66[2])
		end
		if v_u_76 ~= 0 and v_u_80 < v206.Index then
			v_u_100()
		end
		v_u_12.BackpackItemAdded:Fire()
	elseif p205:IsA("Humanoid") and p205.Parent == v_u_63 then
		v_u_64 = p205
	end
end
local function v_u_214(p208)
	-- upvalues: (ref) v_u_63, (ref) v_u_65, (copy) v_u_68, (copy) v_u_80, (ref) v_u_58, (copy) v_u_91, (ref) v_u_72, (copy) v_u_12, (copy) v_u_66
	if not (p208:IsA("Tool") or p208:IsA("HopperBin")) then
		return
	end
	local v209 = p208.Parent
	if v209 == v_u_63 or v209 == v_u_65 then
		return
	end
	local v210 = v_u_68[p208]
	if v210 then
		v210:Clear()
		if v_u_80 < v210.Index then
			v210:Delete()
		elseif not v_u_58.Visible then
			v_u_91()
		end
	end
	if p208 == v_u_72 then
		v_u_72 = nil
	end
	v_u_12.BackpackItemRemoved:Fire()
	for v211 = v_u_80 + 1, #v_u_66 do
		local v212 = v_u_66[v211]
		if v212 and v212.Tool then
			v213 = false
			::l19::
			if v213 then
				v_u_12.BackpackEmpty:Fire()
			end
			return
		end
	end
	local v213 = true
	goto l19
end
local function v233(p215)
	-- upvalues: (copy) v_u_66, (copy) v_u_80, (ref) v_u_72, (ref) v_u_77, (ref) v_u_63, (copy) v_u_214, (copy) v_u_207, (ref) v_u_65, (ref) v_u_52, (copy) v_u_91
	for v216 = #v_u_66, 1, -1 do
		local v217 = v_u_66[v216]
		if v217.Tool then
			v217:Clear()
		end
		if v_u_80 < v216 then
			v217:Delete()
		end
	end
	v_u_72 = nil
	for _, v218 in pairs(v_u_77) do
		v218:Disconnect()
	end
	v_u_77 = {}
	v_u_63 = p215
	local v219 = v_u_77
	local v220 = p215.ChildRemoved
	local v221 = v_u_214
	table.insert(v219, v220:Connect(v221))
	local v222 = v_u_77
	local v223 = p215.ChildAdded
	local v224 = v_u_207
	table.insert(v222, v223:Connect(v224))
	for _, v225 in pairs(p215:GetChildren()) do
		v_u_207(v225)
	end
	v_u_65 = v_u_52:WaitForChild("Backpack")
	local v226 = v_u_77
	local v227 = v_u_65.ChildRemoved
	local v228 = v_u_214
	table.insert(v226, v227:Connect(v228))
	local v229 = v_u_77
	local v230 = v_u_65.ChildAdded
	local v231 = v_u_207
	table.insert(v229, v230:Connect(v231))
	for _, v232 in pairs(v_u_65:GetChildren()) do
		v_u_207(v232)
	end
	v_u_91()
end
local function v239(p234, p235)
	-- upvalues: (copy) v_u_2, (ref) v_u_74, (ref) v_u_73, (copy) v_u_38, (copy) v_u_69, (ref) v_u_58, (copy) v_u_46
	local v236 = v_u_2:FindFirstChildOfClass("ChatInputBarConfiguration")
	local v237 = p234.UserInputType == Enum.UserInputType.Keyboard and (not v_u_74 and (not v236.IsFocused and (v_u_73 or p234.KeyCode.Value == v_u_38))) and v_u_69[p234.KeyCode.Value]
	if v237 then
		v237(p235)
	end
	local v238 = p234.UserInputType
	if not p235 and (v238 == Enum.UserInputType.MouseButton1 or v238 == Enum.UserInputType.Touch) and v_u_58.Visible then
		v_u_46:deselect()
	end
end
local function v246()
	-- upvalues: (copy) v_u_4, (copy) v_u_80, (copy) v_u_66, (copy) v_u_40, (copy) v_u_41
	if v_u_4:GetLastInputType() == Enum.UserInputType.Touch then
		for v240 = 1, v_u_80 do
			v_u_66[v240]:TurnNumber(false)
		end
		return
	elseif v_u_4:GetLastInputType() == Enum.UserInputType.Keyboard then
		for v241 = 1, v_u_80 do
			v_u_66[v241]:TurnNumber(true)
		end
	else
		for _, v242 in pairs(v_u_40) do
			if v_u_4:GetLastInputType() == v242 then
				for v243 = 1, v_u_80 do
					v_u_66[v243]:TurnNumber(true)
				end
				return
			end
		end
		for _, v244 in pairs(v_u_41) do
			if v_u_4:GetLastInputType() == v244 then
				for v245 = 1, v_u_80 do
					v_u_66[v245]:TurnNumber(false)
				end
				return
			end
		end
	end
end
local v_u_247 = nil
local v_u_248 = nil
local function v_u_249() end
function unbindAllGamepadEquipActions()
	-- upvalues: (copy) v_u_1
	v_u_1:UnbindAction("BackpackHasGamepadFocus")
	v_u_1:UnbindAction("BackpackCloseInventory")
end
local function v_u_258(_, p250, p_u_251)
	-- upvalues: (ref) v_u_247, (ref) v_u_248, (ref) v_u_64, (ref) v_u_72, (copy) v_u_68, (copy) v_u_80, (copy) v_u_66, (ref) v_u_82
	if p250 == Enum.UserInputState.Begin then
		if v_u_247 and (v_u_247.KeyCode == Enum.KeyCode.ButtonR1 and p_u_251.KeyCode == Enum.KeyCode.ButtonL1 or v_u_247.KeyCode == Enum.KeyCode.ButtonL1 and p_u_251.KeyCode == Enum.KeyCode.ButtonR1) and os.clock() - v_u_248 <= 0.06 then
			if v_u_64 then
				v_u_64:UnequipTools()
				if v_u_72 then
					v_u_72:ToggleSelect()
					v_u_68[v_u_72]:UpdateEquipView()
					v_u_72 = nil
				end
			end
			v_u_247 = p_u_251
			v_u_248 = os.clock()
		else
			v_u_247 = p_u_251
			v_u_248 = os.clock()
			task.delay(0.06, function()
				-- upvalues: (ref) v_u_247, (copy) p_u_251, (ref) v_u_80, (ref) v_u_66, (ref) v_u_64, (ref) v_u_72, (ref) v_u_68, (ref) v_u_82
				if v_u_247 == p_u_251 then
					local v252 = p_u_251.KeyCode == Enum.KeyCode.ButtonL1 and -1 or 1
					for v253 = 1, v_u_80 do
						if v_u_66[v253]:IsEquipped() then
							local v254 = v252 + v253
							local v255 = false
							if v_u_80 < v254 then
								v254 = 1
								v255 = true
							elseif v254 < 1 then
								v254 = v_u_80
								v255 = true
							end
							local v256 = v254
							while not v_u_66[v254].Tool do
								v254 = v254 + v252
								if v254 == v256 then
									return
								end
								if v_u_80 < v254 then
									v254 = 1
									v255 = true
								elseif v254 < 1 then
									v254 = v_u_80
									v255 = true
								end
							end
							if v255 then
								if v_u_64 then
									v_u_64:UnequipTools()
									if v_u_72 then
										v_u_72:ToggleSelect()
										v_u_68[v_u_72]:UpdateEquipView()
										v_u_72 = nil
									end
								end
								v_u_82 = nil
							else
								v_u_66[v254]:Select()
							end
						end
					end
					if v_u_82 and v_u_82.Tool then
						v_u_82:Select()
					else
						for v257 = v252 == -1 and (v_u_80 or 1) or 1, v252 == -1 and 1 or v_u_80, v252 do
							if v_u_66[v257].Tool then
								v_u_66[v257]:Select()
								return
							end
						end
					end
				else
					return
				end
			end)
		end
	else
		return
	end
end
function getGamepadSwapSlot()
	-- upvalues: (copy) v_u_66
	for v259 = 1, #v_u_66 do
		if v_u_66[v259].Frame.BorderSizePixel > 0 then
			return v_u_66[v259]
		end
	end
end
function changeSlot(p_u_260)
	-- upvalues: (copy) v_u_9, (ref) v_u_58, (copy) v_u_7, (ref) v_u_59, (copy) v_u_80
	local v261 = not v_u_9.VREnabled or v_u_58.Visible
	if p_u_260.Frame == v_u_7.SelectedObject and v261 then
		local v262 = getGamepadSwapSlot()
		if not v262 then
			local v_u_263 = p_u_260.Frame.Size
			local v_u_264 = p_u_260.Frame.Position
			p_u_260.Frame:TweenSizeAndPosition(v_u_263 + UDim2.new(0, 10, 0, 10), v_u_264 - UDim2.new(0, 5, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function()
				-- upvalues: (copy) p_u_260, (copy) v_u_263, (copy) v_u_264
				p_u_260.Frame:TweenSizeAndPosition(v_u_263, v_u_264, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true)
			end)
			p_u_260.Frame.BorderSizePixel = 3
			v_u_59.SelectionImageObject.Visible = true
			return
		end
		v262.Frame.BorderSizePixel = 0
		if v262 ~= p_u_260 then
			p_u_260:Swap(v262)
			v_u_59.SelectionImageObject.Visible = false
			if v_u_80 < p_u_260.Index and not p_u_260.Tool then
				if v_u_7.SelectedObject == p_u_260.Frame then
					v_u_7.SelectedObject = v262.Frame
				end
				p_u_260:Delete()
			end
			if v_u_80 < v262.Index and not v262.Tool then
				if v_u_7.SelectedObject == v262.Frame then
					v_u_7.SelectedObject = p_u_260.Frame
				end
				v262:Delete()
				return
			end
		end
	else
		p_u_260:Select()
		v_u_59.SelectionImageObject.Visible = false
	end
end
function vrMoveSlotToInventory()
	-- upvalues: (copy) v_u_9, (ref) v_u_59
	if v_u_9.VREnabled then
		local v265 = getGamepadSwapSlot()
		if v265 and v265.Tool then
			v265.Frame.BorderSizePixel = 0
			v265:MoveToInventory()
			v_u_59.SelectionImageObject.Visible = false
		end
	end
end
function enableGamepadInventoryControl()
	-- upvalues: (ref) v_u_58, (copy) v_u_46, (copy) v_u_1, (copy) v_u_249, (copy) v_u_7, (ref) v_u_57
	local function v267()
		-- upvalues: (ref) v_u_58, (ref) v_u_46
		if getGamepadSwapSlot() then
			local v266 = getGamepadSwapSlot()
			if v266 then
				v266.Frame.BorderSizePixel = 0
				return
			end
		elseif v_u_58.Visible then
			v_u_46:deselect()
		end
	end
	v_u_1:BindAction("BackpackHasGamepadFocus", v_u_249, false, Enum.UserInputType.Gamepad1)
	v_u_1:BindAction("BackpackCloseInventory", v267, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart)
	if true then
		v_u_7.SelectedObject = v_u_57:FindFirstChild("1")
	end
end
function disableGamepadInventoryControl()
	-- upvalues: (copy) v_u_80, (copy) v_u_66, (copy) v_u_7, (ref) v_u_56
	unbindAllGamepadEquipActions()
	for v268 = 1, v_u_80 do
		local v269 = v_u_66[v268]
		if v269 and v269.Frame then
			v269.Frame.BorderSizePixel = 0
		end
	end
	if v_u_7.SelectedObject and v_u_7.SelectedObject:IsDescendantOf(v_u_56) then
		v_u_7.SelectedObject = nil
	end
end
function gamepadDisconnected()
	-- upvalues: (ref) v_u_78
	v_u_78 = false
	disableGamepadInventoryControl()
end
function gamepadConnected()
	-- upvalues: (ref) v_u_78, (copy) v_u_7, (ref) v_u_56, (ref) v_u_71, (ref) v_u_73, (ref) v_u_50, (copy) v_u_1, (ref) v_u_258, (ref) v_u_58
	v_u_78 = true
	v_u_7:AddSelectionParent("BackpackSelection", v_u_56)
	if v_u_71 >= 1 and (v_u_73 and not v_u_50) then
		v_u_50 = true
		v_u_1:BindAction("BackpackHotbarEquip", v_u_258, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
	end
	if v_u_58.Visible then
		enableGamepadInventoryControl()
	end
end
local function v275(p270, p271)
	local v272 = Instance.new("ImageButton")
	v272.BackgroundTransparency = 1
	v272.Name = p270
	v272.Size = UDim2.new(0, 40, 0, 40)
	v272.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png"
	local v273 = Instance.new("ImageLabel")
	v273.Name = "Icon"
	v273.BackgroundTransparency = 1
	v273.Size = UDim2.new(0.5, 0, 0.5, 0)
	v273.Position = UDim2.new(0.25, 0, 0.25, 0)
	v273.Image = p271
	v273.Parent = v272
	local v274 = Instance.new("ImageLabel")
	v274.BackgroundTransparency = 1
	v274.Name = "Selection"
	v274.Size = UDim2.new(0.9, 0, 0.9, 0)
	v274.Position = UDim2.new(0.05, 0, 0.05, 0)
	v274.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png"
	v272.SelectionImageObject = v274
	return v272, v273, v274
end
local v276 = Instance.new("Frame")
v276.BackgroundTransparency = 1
v276.Name = "Backpack"
v276.Size = UDim2.new(1, 0, 1, 0)
v276.Visible = false
v276.Parent = v_u_47
local v277 = Instance.new("Frame")
v277.BackgroundTransparency = 1
v277.Name = "Hotbar"
v277.Size = UDim2.new(1, 0, 1, 0)
v277.Parent = v276
local v_u_278 = v_u_258
local v_u_279 = v276
local v_u_280 = v277
for v281 = 1, v_u_80 do
	local v282 = v_u_204(v_u_280, v281)
	v282.Frame.Visible = false
	if not v_u_67 then
		local v283 = v282
		v_u_67 = v283
	end
end
local v284 = Instance.new("ImageLabel")
v284.BackgroundTransparency = 1
v284.Name = "LeftBumper"
v284.Size = UDim2.new(0, 40, 0, 40)
v284.Position = UDim2.new(0, -v284.Size.X.Offset, 0.5, -v284.Size.Y.Offset / 2)
local v285 = Instance.new("ImageLabel")
v285.BackgroundTransparency = 1
v285.Name = "RightBumper"
v285.Size = UDim2.new(0, 40, 0, 40)
v285.Position = UDim2.new(1, 0, 0.5, -v285.Size.Y.Offset / 2)
local v_u_286 = Instance.new("Frame")
v_u_286.Name = "Inventory"
v_u_286.Size = UDim2.new(1, 0, 1, 0)
v_u_286.BackgroundTransparency = v_u_18
v_u_286.BackgroundColor3 = v_u_20
v_u_286.Active = true
v_u_286.Visible = false
v_u_286.Parent = v_u_279
local v287 = Instance.new("UICorner")
v287.Name = "Corner"
v287.CornerRadius = v19
v287.Parent = v_u_286
local v288 = Instance.new("TextButton")
v288.Name = "VRInventorySelector"
v288.Position = UDim2.new(0, 0, 0, 0)
v288.Size = UDim2.new(1, 0, 1, 0)
v288.BackgroundTransparency = 1
v288.Text = ""
v288.Parent = v_u_286
local v289 = Instance.new("ImageLabel")
v289.BackgroundTransparency = 1
v289.Name = "Selector"
v289.Size = UDim2.new(1, 0, 1, 0)
v289.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
v289.ScaleType = Enum.ScaleType.Slice
v289.SliceCenter = Rect.new(12, 12, 52, 52)
v289.Visible = false
v288.SelectionImageObject = v289
v288.MouseButton1Click:Connect(function()
	vrMoveSlotToInventory()
end)
local v_u_290 = Instance.new("ScrollingFrame")
v_u_290.BackgroundTransparency = 1
v_u_290.Name = "ScrollingFrame"
v_u_290.Size = UDim2.new(1, 0, 1, 0)
v_u_290.Selectable = false
v_u_290.ScrollingDirection = Enum.ScrollingDirection.Y
v_u_290.BorderSizePixel = 0
v_u_290.ScrollBarThickness = 8
v_u_290.ScrollBarImageColor3 = Color3.new(1, 1, 1)
v_u_290.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
v_u_290.CanvasSize = UDim2.new(0, 0, 0, 0)
v_u_290.Parent = v_u_286
local v_u_291 = Instance.new("Frame")
v_u_291.BackgroundTransparency = 1
v_u_291.Name = "UIGridFrame"
v_u_291.Selectable = false
v_u_291.Size = UDim2.new(1, -10, 1, 0)
v_u_291.Position = UDim2.new(0, 5, 0, 0)
v_u_291.Parent = v_u_290
local v292 = Instance.new("UIGridLayout")
v292.SortOrder = Enum.SortOrder.LayoutOrder
v292.CellSize = UDim2.new(0, v_u_49, 0, v_u_49)
v292.CellPadding = UDim2.new(0, 5, 0, 5)
v292.Parent = v_u_291
local v_u_293 = v275("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")
v_u_293.Size = UDim2.new(0, 34, 0, 34)
v_u_293.Position = UDim2.new(0.5, -v_u_293.Size.X.Offset / 2, 0, 43)
v_u_293.Icon.Position = v_u_293.Icon.Position - UDim2.new(0, 0, 0, 2)
v_u_293.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_290, (ref) v_u_49
	local v294 = v_u_290
	local v295 = Vector2.new
	local v296 = v_u_290.CanvasPosition.X
	local v297 = v_u_290.CanvasSize.Y.Offset - v_u_290.AbsoluteWindowSize.Y
	local v298 = v_u_290.CanvasPosition.Y - (v_u_49 + 5)
	local v299 = math.max(0, v298)
	v294.CanvasPosition = v295(v296, (math.min(v297, v299)))
end)
local v_u_300 = v275("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")
v_u_300.Rotation = 180
v_u_300.Icon.Position = v_u_300.Icon.Position - UDim2.new(0, 0, 0, 2)
v_u_300.Size = UDim2.new(0, 34, 0, 34)
v_u_300.Position = UDim2.new(0.5, -v_u_300.Size.X.Offset / 2, 1, -v_u_300.Size.Y.Offset - 3)
v_u_300.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_290, (ref) v_u_49
	local v301 = v_u_290
	local v302 = Vector2.new
	local v303 = v_u_290.CanvasPosition.X
	local v304 = v_u_290.CanvasSize.Y.Offset - v_u_290.AbsoluteWindowSize.Y
	local v305 = v_u_290.CanvasPosition.Y + (v_u_49 + 5)
	local v306 = math.max(0, v305)
	v301.CanvasPosition = v302(v303, (math.min(v304, v306)))
end)
v_u_290.Changed:Connect(function(p307)
	-- upvalues: (ref) v_u_290, (ref) v_u_293, (ref) v_u_300
	if p307 == "AbsoluteWindowSize" or (p307 == "CanvasPosition" or p307 == "CanvasSize") then
		local v308 = v_u_290.CanvasPosition.Y ~= 0
		local v309 = v_u_290.CanvasPosition.Y < v_u_290.CanvasSize.Y.Offset - v_u_290.AbsoluteWindowSize.Y
		v_u_293.Visible = v308
		v_u_300.Visible = v309
	end
end)
v104()
local v_u_310 = Instance.new("Frame")
v_u_310.Name = "GamepadHintsFrame"
v_u_310.Size = UDim2.new(0, v_u_280.Size.X.Offset, 0, v_u_48 and 95 or 60)
v_u_310.BackgroundTransparency = v_u_18
v_u_310.BackgroundColor3 = v_u_20
v_u_310.Visible = false
v_u_310.Parent = v_u_279
local v311 = Instance.new("UIListLayout")
v311.Name = "Layout"
v311.Padding = UDim.new(0, 25)
v311.FillDirection = Enum.FillDirection.Horizontal
v311.HorizontalAlignment = Enum.HorizontalAlignment.Center
v311.SortOrder = Enum.SortOrder.LayoutOrder
v311.Parent = v_u_310
local v312 = Instance.new("UICorner")
v312.Name = "Corner"
v312.CornerRadius = v19
v312.Parent = v_u_310
local function v320(p313, p314)
	-- upvalues: (copy) v_u_310, (copy) v_u_48, (copy) v_u_36
	local v315 = Instance.new("Frame")
	v315.Name = "HintFrame"
	v315.AutomaticSize = Enum.AutomaticSize.XY
	v315.BackgroundTransparency = 1
	v315.Parent = v_u_310
	local v316 = Instance.new("UIListLayout")
	v316.Name = "Layout"
	v316.Padding = v_u_48 and UDim.new(0, 20) or UDim.new(0, 12)
	v316.FillDirection = Enum.FillDirection.Horizontal
	v316.SortOrder = Enum.SortOrder.LayoutOrder
	v316.VerticalAlignment = Enum.VerticalAlignment.Center
	v316.Parent = v315
	local v317 = Instance.new("ImageLabel")
	v317.Name = "HintImage"
	v317.Size = v_u_48 and UDim2.new(0, 60, 0, 60) or UDim2.new(0, 30, 0, 30)
	v317.BackgroundTransparency = 1
	v317.Image = p313
	v317.Parent = v315
	local v318 = Instance.new("TextLabel")
	v318.Name = "HintText"
	v318.AutomaticSize = Enum.AutomaticSize.XY
	v318.FontFace = Font.new(v_u_36.Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	v318.TextSize = v_u_48 and 32 or 19
	v318.BackgroundTransparency = 1
	v318.Text = p314
	v318.TextColor3 = Color3.new(1, 1, 1)
	v318.TextXAlignment = Enum.TextXAlignment.Left
	v318.TextYAlignment = Enum.TextYAlignment.Center
	v318.TextWrapped = true
	v318.Parent = v315
	local v319 = Instance.new("UITextSizeConstraint")
	v319.MaxTextSize = v318.TextSize
	v319.Parent = v318
end
v320(v_u_4:GetImageForKeyCode(Enum.KeyCode.ButtonX), "Remove From Hotbar")
v320(v_u_4:GetImageForKeyCode(Enum.KeyCode.ButtonA), "Select/Swap")
v320(v_u_4:GetImageForKeyCode(Enum.KeyCode.ButtonB), "Close Backpack")
local function v_u_328()
	-- upvalues: (copy) v_u_310, (ref) v_u_280, (copy) v_u_48, (ref) v_u_286
	v_u_310.Size = UDim2.new(v_u_280.Size.X.Scale, v_u_280.Size.X.Offset, 0, v_u_48 and 95 or 60)
	v_u_310.Position = UDim2.new(v_u_280.Position.X.Scale, v_u_280.Position.X.Offset, v_u_286.Position.Y.Scale, v_u_286.Position.Y.Offset - v_u_310.Size.Y.Offset - 5)
	local v321 = v_u_310:GetChildren()
	local v322 = {}
	local v323 = 0
	for _, v324 in pairs(v321) do
		if v324:IsA("GuiObject") then
			table.insert(v322, v324)
		end
	end
	for v325 = 1, #v322 do
		if v322[v325]:IsA("GuiObject") then
			v322[v325].Size = UDim2.new(1, 0, 1, -5)
			v322[v325].Position = UDim2.new(0, 0, 0, 0)
			v323 = v323 + (v322[v325].HintText.Position.X.Offset + v322[v325].HintText.TextBounds.X)
		end
	end
	local v326 = (v_u_310.AbsoluteSize.X - v323) / (#v322 - 1)
	for v327 = 1, #v322 do
		v322[v327].Position = v327 == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0, v322[v327 - 1].Position.X.Offset + v322[v327 - 1].Size.X.Offset + v326, 0, 0)
		v322[v327].Size = UDim2.new(0, v322[v327].HintText.Position.X.Offset + v322[v327].HintText.TextBounds.X, 1, -5)
	end
end
local v_u_329 = Instance.new("Frame")
v_u_329.Name = "Search"
v_u_329.BackgroundColor3 = v32
v_u_329.BackgroundTransparency = v_u_33
v_u_329.Size = UDim2.new(0, 190, 0, 30)
v_u_329.Position = UDim2.new(1, -v_u_329.Size.X.Offset - 5, 0, 5)
v_u_329.Parent = v_u_286
local v330 = Instance.new("UICorner")
v330.Name = "Corner"
v330.CornerRadius = v35
v330.Parent = v_u_329
local v331 = Instance.new("UIStroke")
v331.Name = "Border"
v331.Color = v34
v331.Thickness = 1
v331.Transparency = 0.8
v331.Parent = v_u_329
local v_u_332 = Instance.new("TextBox")
v_u_332.BackgroundTransparency = 1
v_u_332.Name = "TextBox"
v_u_332.Text = ""
v_u_332.TextColor3 = v_u_29
v_u_332.TextStrokeTransparency = v_u_30
v_u_332.TextStrokeColor3 = v_u_31
v_u_332.FontFace = Font.new(v_u_36.Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal)
v_u_332.PlaceholderText = "Search"
v_u_332.TextColor3 = v_u_29
v_u_332.TextTransparency = v_u_30
v_u_332.TextStrokeColor3 = v_u_31
v_u_332.ClearTextOnFocus = false
v_u_332.TextTruncate = Enum.TextTruncate.AtEnd
v_u_332.TextSize = v_u_37
v_u_332.TextXAlignment = Enum.TextXAlignment.Left
v_u_332.TextYAlignment = Enum.TextYAlignment.Center
v_u_332.Size = UDim2.new(0, 154, 0, 14)
v_u_332.AnchorPoint = Vector2.new(0, 0.5)
v_u_332.Position = UDim2.new(0, 8, 0.5, 0)
v_u_332.ZIndex = 2
v_u_332.Parent = v_u_329
local v_u_333 = Instance.new("TextButton")
v_u_333.Name = "X"
v_u_333.Text = ""
v_u_333.Size = UDim2.new(0, 30, 0, 30)
v_u_333.Position = UDim2.new(1, -v_u_333.Size.X.Offset, 0.5, -v_u_333.Size.Y.Offset / 2)
v_u_333.ZIndex = 4
v_u_333.Visible = false
v_u_333.BackgroundTransparency = 1
v_u_333.Parent = v_u_329
local v334 = Instance.new("ImageButton")
v334.Name = "X"
v334.Image = "rbxasset://textures/ui/InspectMenu/x.png"
v334.BackgroundTransparency = 1
v334.Size = UDim2.new(0, v_u_329.Size.Y.Offset - 20, 0, v_u_329.Size.Y.Offset - 20)
v334.AnchorPoint = Vector2.new(0.5, 0.5)
v334.Position = UDim2.new(0.5, 0, 0.5, 0)
v334.ZIndex = 1
v334.BorderSizePixel = 0
v334.Parent = v_u_333
local function v_u_346()
	-- upvalues: (copy) v_u_332, (copy) v_u_80, (copy) v_u_66, (ref) v_u_286, (ref) v_u_75, (ref) v_u_291, (ref) v_u_290, (copy) v_u_96, (copy) v_u_333
	local v335 = {}
	for v336 in v_u_332.Text:gmatch("%S+") do
		v335[v336:lower()] = true
	end
	local v337 = {}
	for v338 = v_u_80 + 1, #v_u_66 do
		local v339 = v_u_66[v338]
		local v340 = { v339, (v339:CheckTerms(v335)) }
		table.insert(v337, v340)
		v339.Frame.Visible = false
		v339.Frame.Parent = v_u_286
	end
	table.sort(v337, function(p341, p342)
		return p341[2] > p342[2]
	end)
	v_u_75 = true
	local v343 = 0
	for _, v344 in ipairs(v337) do
		local v345 = v344[1]
		if v344[2] > 0 then
			v345.Frame.Visible = true
			v345.Frame.Parent = v_u_291
			v345.Frame.LayoutOrder = v_u_80 + v343
			v343 = v343 + 1
		end
	end
	v_u_290.CanvasPosition = Vector2.new(0, 0)
	v_u_96()
	v_u_333.ZIndex = 3
end
local function v_u_349()
	-- upvalues: (copy) v_u_333, (ref) v_u_75, (copy) v_u_80, (copy) v_u_66, (ref) v_u_291, (ref) v_u_76, (copy) v_u_100, (copy) v_u_96
	if v_u_333.ZIndex > 0 then
		v_u_75 = false
		for v347 = v_u_80 + 1, #v_u_66 do
			local v348 = v_u_66[v347]
			v348.Frame.LayoutOrder = v348.Index
			v348.Frame.Parent = v_u_291
			v348.Frame.Visible = true
		end
		v_u_333.ZIndex = 0
		if v_u_76 ~= 0 then
			v_u_100()
		end
	end
	v_u_96()
end
v_u_333.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_349, (copy) v_u_332
	v_u_349()
	v_u_332.Text = ""
end)
v_u_332.Changed:Connect(function(p350)
	-- upvalues: (copy) v_u_332, (copy) v_u_30, (copy) v_u_349, (copy) v_u_346, (copy) v_u_333
	if p350 == "Text" then
		local v351 = v_u_332.Text
		if v351 == "" then
			v_u_332.TextTransparency = v_u_30
			v_u_349()
		elseif v351 ~= "" then
			v_u_332.TextTransparency = 0
			v_u_346()
		end
		local v352 = v_u_333
		local v353
		if v351 == "" then
			v353 = false
		else
			v353 = v351 ~= ""
		end
		v352.Visible = v353
	end
end)
v_u_332.FocusLost:Connect(function(p354)
	-- upvalues: (copy) v_u_346
	if p354 then
		v_u_346()
	end
end)
v_u_12.StateChanged.Event:Connect(function(p355)
	-- upvalues: (copy) v_u_349, (copy) v_u_332
	if not p355 then
		v_u_349()
		v_u_332.Text = ""
	end
end)
v_u_69[Enum.KeyCode.Escape.Value] = function(p356)
	-- upvalues: (copy) v_u_349, (copy) v_u_332
	if p356 then
		v_u_349()
		v_u_332.Text = ""
	end
end
v_u_4.LastInputTypeChanged:Connect(function(p357)
	-- upvalues: (copy) v_u_4, (copy) v_u_329
	if p357 == Enum.UserInputType.Gamepad1 and not v_u_4.VREnabled then
		v_u_329.Visible = false
	else
		v_u_329.Visible = true
	end
end)
local v_u_358 = v43:Clone()
v_u_358.Size = UDim2.new(0, 160, 0, 40)
v_u_358.Position = UDim2.new(v_u_286.Position.X.Scale, v_u_286.Position.X.Offset + v_u_286.Size.X.Offset - 5 - 80, v_u_286.Position.Y.Scale, v_u_286.Position.Y.Offset - 6 - 20)
v_u_358.Visible = false
v_u_358.Parent = v_u_279
local v359 = v_u_358:WaitForChild("Scale")
local v360 = TweenInfo.new(0.2, Enum.EasingStyle.Back)
local v361 = TweenInfo.new(0.1, Enum.EasingStyle.Sine)
local v362 = TweenInfo.new(0.075, Enum.EasingStyle.Sine)
local v_u_363 = v_u_3:Create(v359, v360, {
	["Scale"] = 1.05
})
local v_u_364 = v_u_3:Create(v359, v361, {
	["Scale"] = 1
})
local v_u_365 = v_u_3:Create(v359, v362, {
	["Scale"] = 0.9
})
v_u_358.MouseEnter:Connect(function()
	-- upvalues: (copy) v_u_363
	v_u_363:Play()
end)
v_u_358.MouseLeave:Connect(function()
	-- upvalues: (copy) v_u_364
	v_u_364:Play()
end)
v_u_358.MouseButton1Down:Connect(function()
	-- upvalues: (copy) v_u_365
	v_u_365:Play()
end)
v_u_358.MouseButton1Up:Connect(function()
	-- upvalues: (copy) v_u_363
	v_u_363:Play()
end)
v_u_358.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_55
	v_u_55:FireServer()
end)
local v_u_366 = v44:Clone()
v_u_366.Size = UDim2.new(0, 30, 0, 30)
v_u_366.Position = UDim2.new(1, -v_u_329.Size.X.Offset - 30 - 10, 0, 5)
v_u_366.Parent = v_u_286
local v_u_367 = v_u_366:WaitForChild("StarBorder")
local v_u_368 = v_u_366:WaitForChild("StarFill")
local v_u_369 = v_u_366:WaitForChild("DiagonalLine")
v_u_366:WaitForChild("Button").MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_76, (copy) v_u_367, (copy) v_u_368, (copy) v_u_369, (copy) v_u_100
	v_u_76 = (v_u_76 + 1) % 3
	if v_u_76 == 0 then
		v_u_367.Visible = true
		v_u_368.Visible = false
		v_u_369.Visible = false
	elseif v_u_76 == 1 then
		v_u_367.Visible = false
		v_u_368.Visible = true
		v_u_369.Visible = false
	elseif v_u_76 == 2 then
		v_u_367.Visible = false
		v_u_368.Visible = true
		v_u_369.Visible = true
	end
	v_u_100()
end);
(function()
	-- upvalues: (ref) v_u_76, (copy) v_u_367, (copy) v_u_368, (copy) v_u_369
	if v_u_76 == 0 then
		v_u_367.Visible = true
		v_u_368.Visible = false
		v_u_369.Visible = false
		return
	elseif v_u_76 == 1 then
		v_u_367.Visible = false
		v_u_368.Visible = true
		v_u_369.Visible = false
	elseif v_u_76 == 2 then
		v_u_367.Visible = false
		v_u_368.Visible = true
		v_u_369.Visible = true
	end
end)()
local function v371(p370)
	-- upvalues: (copy) v_u_4, (ref) v_u_366
	if p370 == Enum.UserInputType.Gamepad1 and not v_u_4.VREnabled then
		v_u_366.Visible = false
	else
		v_u_366.Visible = true
	end
end
v_u_4.LastInputTypeChanged:Connect(v371)
v371(v_u_4:GetLastInputType())
v_u_7.MenuOpened:Connect(function()
	-- upvalues: (copy) v_u_47, (copy) v_u_46
	v_u_47.Enabled = false
	v_u_46:setEnabled(false)
end)
v_u_7.MenuClosed:Connect(function()
	-- upvalues: (copy) v_u_47, (copy) v_u_46
	v_u_47.Enabled = true
	v_u_46:setEnabled(true)
end)
local function v_u_374(_, p372, _)
	-- upvalues: (copy) v_u_7, (copy) v_u_80, (copy) v_u_66
	if p372 == Enum.UserInputState.Begin then
		if v_u_7.SelectedObject then
			for v373 = 1, v_u_80 do
				if v_u_66[v373].Frame == v_u_7.SelectedObject and v_u_66[v373].Tool then
					v_u_66[v373]:MoveToInventory()
					return
				end
			end
		end
	else
		return
	end
end
local function v377()
	-- upvalues: (copy) v_u_70, (ref) v_u_286, (copy) v_u_358, (ref) v_u_366, (copy) v_u_91, (ref) v_u_280, (copy) v_u_80, (copy) v_u_66, (ref) v_u_78, (copy) v_u_41, (copy) v_u_4, (copy) v_u_328, (copy) v_u_310, (copy) v_u_1, (copy) v_u_374, (copy) v_u_12
	if not next(v_u_70) then
		v_u_286.Visible = not v_u_286.Visible
		v_u_358.Visible = not v_u_358.Visible
		v_u_366.Visible = v_u_286.Visible
		local v375 = v_u_286.Visible
		v_u_91()
		v_u_280.Active = not v_u_280.Active
		for v376 = 1, v_u_80 do
			v_u_66[v376]:SetClickability(not v375)
		end
	end
	if v_u_286.Visible then
		if v_u_78 then
			if v_u_41[v_u_4:GetLastInputType()] then
				v_u_328()
				v_u_310.Visible = not v_u_4.VREnabled
			end
			enableGamepadInventoryControl()
		end
	else
		if v_u_78 then
			v_u_310.Visible = false
		end
		disableGamepadInventoryControl()
	end
	if v_u_286.Visible then
		v_u_1:BindAction("BackpackRemoveSlot", v_u_374, false, Enum.KeyCode.ButtonX)
	else
		v_u_1:UnbindAction("BackpackRemoveSlot")
	end
	v_u_12.IsOpen = v_u_286.Visible
	v_u_12.StateChanged:Fire(v_u_286.Visible)
end
v_u_6:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
v_u_12.OpenClose = v377
local v_u_378 = v_u_286
while not v_u_52 do
	task.wait()
	v_u_52 = v10.LocalPlayer
end
v_u_52.CharacterAdded:Connect(v233)
if v_u_52.Character then
	v233(v_u_52.Character)
end
v_u_4.InputBegan:Connect(v239)
v_u_4.TextBoxFocused:Connect(function()
	-- upvalues: (ref) v_u_74
	v_u_74 = true
end)
v_u_4.TextBoxFocusReleased:Connect(function()
	-- upvalues: (ref) v_u_74
	v_u_74 = false
end)
v_u_69[v_u_38] = function()
	-- upvalues: (ref) v_u_72, (ref) v_u_64, (copy) v_u_68
	if v_u_72 and v_u_64 then
		v_u_64:UnequipTools()
		if v_u_72 then
			v_u_72:ToggleSelect()
			v_u_68[v_u_72]:UpdateEquipView()
			v_u_72 = nil
		end
	end
end
v_u_4.LastInputTypeChanged:Connect(v246)
v246()
if v_u_4:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
	gamepadConnected()
end
v_u_4.GamepadConnected:Connect(function(p379)
	if p379 == Enum.UserInputType.Gamepad1 then
		gamepadConnected()
	end
end)
v_u_4.GamepadDisconnected:Connect(function(p380)
	if p380 == Enum.UserInputType.Gamepad1 then
		gamepadDisconnected()
	end
end)
function v_u_12.SetBackpackEnabled(_, p381)
	-- upvalues: (ref) v_u_45
	v_u_45 = p381
end
function v_u_12.IsOpened(_)
	-- upvalues: (copy) v_u_12
	return v_u_12.IsOpen
end
function v_u_12.GetBackpackEnabled(_)
	-- upvalues: (ref) v_u_45
	return v_u_45
end
function v_u_12.GetStateChangedEvent(_)
	-- upvalues: (copy) v_u_12
	return v_u_12.StateChanged
end
v8.Heartbeat:Connect(function()
	-- upvalues: (ref) v_u_45, (copy) v_u_6, (ref) v_u_73, (ref) v_u_279, (ref) v_u_71, (ref) v_u_50, (copy) v_u_1, (ref) v_u_278
	local v382 = v_u_45
	if v382 then
		v382 = v_u_6:GetCore("TopbarEnabled")
	end
	v_u_73 = v382
	v_u_279.Visible = v382
	if v382 then
		if v_u_71 >= 1 and (v_u_73 and not v_u_50) then
			v_u_50 = true
			v_u_1:BindAction("BackpackHotbarEquip", v_u_278, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
			return
		end
	else
		disableGamepadInventoryControl()
		v_u_50 = false
		v_u_1:UnbindAction("BackpackHotbarEquip")
	end
end)
v_u_7:GetPropertyChangedSignal("PreferredTransparency"):Connect(function()
	-- upvalues: (copy) v_u_7, (ref) v_u_18, (copy) v_u_17, (ref) v_u_378, (ref) v_u_23, (copy) v_u_22, (copy) v_u_66, (ref) v_u_33, (copy) v_u_329
	local v383 = v_u_7.PreferredTransparency
	v_u_18 = v_u_17 * v383
	v_u_378.BackgroundTransparency = v_u_18
	v_u_23 = v_u_22 * v383
	for _, v384 in ipairs(v_u_66) do
		v384.Frame.BackgroundTransparency = v_u_23
	end
	v_u_33 = v383 * 0.2
	v_u_329.BackgroundTransparency = v_u_33
end)
return v_u_12
