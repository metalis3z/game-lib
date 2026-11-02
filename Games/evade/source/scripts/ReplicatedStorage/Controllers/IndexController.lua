-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("RunService")
local v4 = v1:WaitForChild("Packages")
local v_u_5 = require(v1.Packages.Gradients)
local v_u_6 = require(v1.Utils.TimeUtils)
local v_u_7 = require(v1.Packages.FFlags)
local v_u_8 = require(v4.Synchronizer)
local v9 = require(v4.Trove)
local v10 = require(v1.Packages.Signal)
local v11 = v1:WaitForChild("Datas")
local v_u_12 = require(v11.Animals)
local v_u_13 = require(v11.Rarities)
local v_u_14 = require(v1.Datas.Index)
local v15 = v1:WaitForChild("Shared")
local v_u_16 = require(v15.Animals)
local v_u_17 = require(v15.Index)
local v_u_18 = require(v15.Updates)
local v19 = v1:WaitForChild("Controllers")
local v_u_20 = require(v19.InterfaceController)
local v21 = v1:WaitForChild("Classes")
local v_u_22 = require(v21.AnimatedButton)
local v_u_23 = v2.LocalPlayer
local v_u_24 = v_u_23.PlayerGui:WaitForChild("Index").Index
local v_u_25 = v_u_24.Main.Header
local v_u_26 = v_u_25.Close
local v_u_27 = v_u_24.Main.Content.Holder.List
local v_u_28 = v_u_27.Template
local v_u_29 = v_u_24.Main.Mutations
local v_u_30 = v_u_29.Template
local v31 = v_u_24.Progress
local v_u_32 = v31.Description
local v33 = v31.Bar
local v_u_34 = v33.Loading
local v_u_35 = v33.Number
local v_u_36 = {}
local v_u_37 = "Default"
local v_u_38 = v10.new()
local v_u_39 = v9.new()
local v_u_40 = nil
local v41 = {}
local v_u_42 = false
local function v_u_74()
	-- upvalues: (ref) v_u_42, (copy) v_u_38, (ref) v_u_37, (copy) v_u_8, (copy) v_u_23, (copy) v_u_14, (copy) v_u_16, (copy) v_u_12, (copy) v_u_13, (copy) v_u_17, (copy) v_u_27, (copy) v_u_28, (copy) v_u_39, (copy) v_u_5, (copy) v_u_36, (copy) v_u_34, (copy) v_u_25, (copy) v_u_35
	if v_u_42 then
		v_u_38:Fire(v_u_37)
	else
		local v_u_43 = v_u_8:Get(v_u_23)
		if v_u_43 then
			v_u_42 = true
			local v44 = v_u_14[v_u_37]
			local v45 = v_u_16:GetList("Generation", true)
			for v46 = 1, #v45 do
				local v_u_47 = v45[v46]
				local v48 = v_u_12[v_u_47]
				local v49 = v_u_13[v48.Rarity]
				if v_u_17:CanShowInIndex(v_u_47) then
					local v50 = v_u_27:FindFirstChild(v_u_47)
					if v50 then
						v50.LayoutOrder = v46
					else
						local v_u_51 = v_u_28:Clone()
						v_u_51.Name = v_u_47
						v_u_51.LayoutOrder = v46
						v_u_51.Visible = not v44 or (not v44.Index or v44.Index[v_u_47])
						v_u_38:Connect(function()
							-- upvalues: (ref) v_u_14, (ref) v_u_37, (copy) v_u_51, (copy) v_u_47
							local v52 = v_u_14[v_u_37]
							v_u_51.Visible = not v52 or (not v52.Index or v52.Index[v_u_47])
						end)
						local v_u_53 = v_u_51.ViewportFrame
						local v_u_54 = nil
						local v_u_55 = nil
						local v_u_56 = nil
						v_u_51.NameLabel.Text = v48.DisplayName
						if v49.GradientPreset then
							v_u_51.RarityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							v_u_39:Add(v_u_5.apply(v_u_51.RarityLabel, v49.GradientPreset))
						else
							v_u_51.RarityLabel.TextColor3 = v49.Color
						end
						v_u_51.RarityLabel.Text = v48.Rarity
						local v57, v_u_58 = v_u_16:AttachOnViewport(v_u_47, v_u_53, true, nil, true)
						if v57 then
							v_u_36[v_u_53] = {
								["targetParent"] = v_u_51,
								["cellIndex"] = v46,
								["state"] = nil
							}
						end
						local function v_u_65()
							-- upvalues: (ref) v_u_37, (ref) v_u_14, (copy) v_u_43, (copy) v_u_47, (copy) v_u_51, (copy) v_u_53, (ref) v_u_55, (ref) v_u_39, (ref) v_u_54, (ref) v_u_56, (ref) v_u_5, (copy) v_u_58, (ref) v_u_16
							local v59 = v_u_37 or "Default"
							local v60 = not v_u_14[v59] and "Default" or v59
							local v61 = not v_u_14[v60] or v_u_14[v60].IsMutation
							local v62 = v_u_43:Get({ "Index", v_u_47 })
							local v63
							if v_u_14[v60] and v_u_14[v60].CustomIndex then
								if v62 == nil then
									v63 = nil
								else
									v63 = v62[v_u_14[v60].CustomIndex.Name] or nil
								end
							elseif v61 then
								if v62 == nil then
									v63 = nil
								else
									v63 = v62[v60] or nil
								end
							elseif v62 == nil then
								v63 = false
							else
								v63 = next(v62) ~= nil
							end
							v_u_51.NameLabel.Visible = v63
							v_u_53.ImageColor3 = not v63 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
							if v_u_55 then
								v_u_39:Remove(v_u_55)
								v_u_55 = nil
							end
							if v_u_54 then
								v_u_39:Remove(v_u_54)
								v_u_54 = nil
							end
							if v_u_56 then
								v_u_56()
								v_u_56 = nil
							end
							if v60 == "Rainbow" then
								v_u_51.MutationLabel.Text = "Rainbow"
								local v64 = v_u_5.apply(v_u_51.MutationLabel, "Rainbow")
								if v64 then
									v_u_55 = v_u_39:Add(v64)
								end
							else
								v_u_51.MutationLabel.Text = not v_u_14[v60] and "Default" or v_u_14[v60].DisplayWithRichText
							end
							if v_u_58 and (v60 ~= "Default" and (v63 and v61)) then
								v_u_54 = v_u_39:Add(v_u_16:ApplyMutation(v_u_58, v_u_47, v60, true))
							end
						end
						v_u_38:Connect(function()
							-- upvalues: (ref) v_u_55, (ref) v_u_39, (ref) v_u_54, (ref) v_u_56, (copy) v_u_65
							if v_u_55 then
								v_u_39:Remove(v_u_55)
								v_u_55 = nil
							end
							if v_u_54 then
								v_u_39:Remove(v_u_54)
								v_u_54 = nil
							end
							if v_u_56 then
								v_u_56()
								v_u_56 = nil
							end
							v_u_65()
						end)
						v_u_43:OnChanged({ "Index", v_u_47 }, v_u_65, true)
						task.spawn(v_u_65)
						v_u_51.Parent = v_u_27
					end
				end
			end
			local function v73()
				-- upvalues: (ref) v_u_17, (ref) v_u_23, (ref) v_u_37, (ref) v_u_34, (ref) v_u_25, (ref) v_u_35
				local v66, v67, v68 = v_u_17:GetIndexAnimals(v_u_23, v_u_37)
				assert(v66, v67, v68)
				local v69 = v_u_17:IsComplete(v_u_23, v_u_37)
				local v70 = v_u_34
				local v71 = UDim2.new
				local v72 = v66 / v67
				v70.Size = v71(math.clamp(v72, 0, 1), 0, 1, 0)
				v_u_25.Total.Text = ("%*/%*"):format(v66, v68)
				if v69 then
					v_u_35.Text = "Milestone Completed"
					v_u_35.TextColor3 = Color3.new(0.0588235, 1, 0.32549)
					v_u_34.BackgroundColor3 = Color3.new(0.490196, 0.941176, 0.439216)
				else
					v_u_35.Text = ("%*/%*"):format(v66, v67)
					v_u_35.TextColor3 = Color3.new(1, 1, 1)
					v_u_34.BackgroundColor3 = Color3.new(0.941176, 0.729412, 0.482353)
				end
			end
			v_u_38:Connect(v73)
			v73()
		end
	end
end
function v41.Start(_)
	-- upvalues: (ref) v_u_40, (copy) v_u_20, (copy) v_u_24, (copy) v_u_26, (copy) v_u_30, (copy) v_u_29, (copy) v_u_22, (ref) v_u_37, (copy) v_u_38, (copy) v_u_14, (copy) v_u_5, (copy) v_u_18, (copy) v_u_7, (copy) v_u_6, (copy) v_u_27, (copy) v_u_3, (copy) v_u_36, (copy) v_u_8, (copy) v_u_23, (copy) v_u_74, (copy) v_u_39, (copy) v_u_32
	v_u_40 = v_u_20:Register("Index", v_u_24, "TopQuint")
	v_u_40:AttachCloseButton(v_u_26)
	v_u_40:Close()
	local v_u_75 = v_u_30:Clone()
	v_u_75.TextLabel.Text = "Normal"
	v_u_75.Name = "Default"
	v_u_75.Parent = v_u_29
	v_u_75.Visible = true
	local v76 = v_u_22.new(v_u_75)
	v76:Animate()
	v76.OnActivated:Connect(function()
		-- upvalues: (ref) v_u_37, (copy) v_u_75, (ref) v_u_38
		if v_u_37 ~= v_u_75.Name then
			v_u_37 = v_u_75.Name
			v_u_38:Fire(v_u_37)
		end
	end)
	for v_u_77, v78 in v_u_14 do
		local v_u_79 = v78.LimitedMutation
		if (not v_u_79 or workspace:GetServerTimeNow() <= v_u_79) and not v78.DisableIndex then
			local v_u_80 = v_u_30:Clone()
			v_u_80.Name = v_u_77
			v_u_80.LayoutOrder = v78.Order or 1
			v_u_80.Visible = true
			local v81 = v_u_80.TextLabel
			local v82
			if v78.UseRichText then
				v82 = v78.DisplayWithRichText
			else
				v82 = v78.DisplayText
			end
			v81.Text = v82
			v_u_80.TextLabel.RichText = v78.UseRichText
			if v_u_77 == "Rainbow" then
				v_u_5.apply(v_u_80.TextLabel, "Rainbow")
			else
				v_u_80.TextLabel.TextColor3 = v78.MainColor
			end
			v_u_80.Parent = v_u_29
			local function v_u_84()
				-- upvalues: (ref) v_u_18, (copy) v_u_77, (ref) v_u_7, (copy) v_u_79
				local v83 = v_u_18.Methods.IsEnabled("Update-11/15/2025")
				if (v_u_77 == "Radioactive" or v_u_77 == "Aquatic") and not v83 then
					return false
				elseif v_u_77 == "YinYang" and v83 then
					return false
				else
					return v_u_7:GetInstant(("%*Timer"):format(v_u_77), v_u_79) - workspace:GetServerTimeNow() > 0
				end
			end
			if v_u_79 then
				task.spawn(function()
					-- upvalues: (ref) v_u_18, (copy) v_u_80, (copy) v_u_84, (ref) v_u_29, (ref) v_u_7, (copy) v_u_77, (copy) v_u_79, (ref) v_u_6, (ref) v_u_37, (ref) v_u_38
					v_u_18.OnUpdateEnabled:Connect(function()
						-- upvalues: (ref) v_u_80, (ref) v_u_84
						v_u_80.Visible = v_u_84()
					end)
					v_u_18.OnUpdateDisabled:Connect(function()
						-- upvalues: (ref) v_u_80, (ref) v_u_84
						v_u_80.Visible = v_u_84()
					end)
					local v85 = true
					while v_u_80.Parent == v_u_29 do
						local v86 = v_u_7:GetInstant(("%*Timer"):format(v_u_77), v_u_79) - workspace:GetServerTimeNow()
						v_u_80.Timer.Text = v_u_6:E(v86)
						v_u_80.Timer.Visible = v86 > 0
						if v86 <= 0 and not v85 then
							v85 = true
							v_u_80.TextLabel.Position = UDim2.fromScale(0.5, 0.5)
							v_u_80.TextLabel.Size = UDim2.fromScale(0.85, 0.55)
							v_u_80.TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
							v_u_80.Visible = v_u_84()
							if v_u_37 == v_u_77 then
								v_u_37 = "Default"
								v_u_38:Fire(v_u_37)
							end
						elseif v86 > 0 and v85 then
							v_u_80.TextLabel.Position = UDim2.fromScale(0.5, 0)
							v_u_80.TextLabel.Size = UDim2.fromScale(0.85, 0.65)
							v_u_80.TextLabel.AnchorPoint = Vector2.new(0.5, 0)
							v_u_80.Visible = v_u_84()
							v85 = false
						end
						task.wait(1)
					end
				end)
			end
			local v87 = v_u_22.new(v_u_80)
			v87:Animate()
			v87.OnActivated:Connect(function()
				-- upvalues: (ref) v_u_37, (copy) v_u_77, (ref) v_u_38
				if v_u_37 ~= v_u_77 then
					v_u_37 = v_u_77
					v_u_38:Fire(v_u_37)
				end
			end)
		end
	end
	local v_u_88 = 0
	local v_u_89 = 0
	local v_u_90 = 0
	local v_u_91 = Vector2.zero
	local _ = Vector2.zero
	local v_u_92 = nil
	local v_u_93 = v_u_27.UIGridLayout
	local function v95()
		-- upvalues: (ref) v_u_91, (ref) v_u_27, (ref) v_u_89, (copy) v_u_93, (ref) v_u_92
		v_u_91 = v_u_27.AbsoluteSize
		v_u_89 = v_u_27.AbsolutePosition.Y + v_u_91.Y
		local v94 = v_u_93.CellPadding
		v_u_92 = v94.Y.Scale * v_u_91.Y + v94.Y.Offset
	end
	local v_u_96 = false
	local function v97()
		-- upvalues: (ref) v_u_90, (ref) v_u_88, (ref) v_u_27, (ref) v_u_96, (ref) v_u_24
		v_u_90 = v_u_88 - v_u_27.CanvasPosition.Y
		v_u_96 = v_u_24.Visible
	end
	v_u_91 = v_u_27.AbsoluteSize
	v_u_89 = v_u_27.AbsolutePosition.Y + v_u_91.Y
	local v98 = v_u_93.CellPadding
	v_u_92 = v98.Y.Scale * v_u_91.Y + v98.Y.Offset
	v_u_88 = v_u_27.AbsolutePosition.Y
	v_u_89 = v_u_27.AbsolutePosition.Y + v_u_91.Y
	v_u_90 = v_u_88 - v_u_27.CanvasPosition.Y
	v_u_96 = v_u_24.Visible
	local v_u_99 = v_u_93.AbsoluteCellCount
	local v_u_100 = v_u_93.AbsoluteCellSize
	v_u_93:GetPropertyChangedSignal("AbsoluteCellCount"):Connect(function()
		-- upvalues: (ref) v_u_99, (copy) v_u_93
		v_u_99 = v_u_93.AbsoluteCellCount
	end)
	v_u_93:GetPropertyChangedSignal("AbsoluteCellSize"):Connect(function()
		-- upvalues: (ref) v_u_100, (copy) v_u_93
		v_u_100 = v_u_93.AbsoluteCellSize
	end)
	v_u_93:GetPropertyChangedSignal("CellPadding"):Connect(function()
		-- upvalues: (copy) v_u_93, (ref) v_u_92, (ref) v_u_91
		local v101 = v_u_93.CellPadding
		v_u_92 = v101.Y.Scale * v_u_91.Y + v101.Y.Offset
	end)
	v_u_27:GetPropertyChangedSignal("AbsoluteSize"):Connect(v95)
	v_u_27:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (ref) v_u_88, (ref) v_u_27, (ref) v_u_89, (ref) v_u_91, (ref) v_u_90, (ref) v_u_96, (ref) v_u_24
		v_u_88 = v_u_27.AbsolutePosition.Y
		v_u_89 = v_u_27.AbsolutePosition.Y + v_u_91.Y
		v_u_90 = v_u_88 - v_u_27.CanvasPosition.Y
		v_u_96 = v_u_24.Visible
	end)
	v_u_27:GetPropertyChangedSignal("CanvasPosition"):Connect(v97)
	v_u_24:GetPropertyChangedSignal("Visible"):Connect(function()
		-- upvalues: (ref) v_u_88, (ref) v_u_27, (ref) v_u_89, (ref) v_u_91, (copy) v_u_93, (ref) v_u_92, (ref) v_u_90, (ref) v_u_96, (ref) v_u_24
		v_u_88 = v_u_27.AbsolutePosition.Y
		v_u_89 = v_u_27.AbsolutePosition.Y + v_u_91.Y
		v_u_91 = v_u_27.AbsoluteSize
		v_u_89 = v_u_27.AbsolutePosition.Y + v_u_91.Y
		local v102 = v_u_93.CellPadding
		v_u_92 = v102.Y.Scale * v_u_91.Y + v102.Y.Offset
		v_u_90 = v_u_88 - v_u_27.CanvasPosition.Y
		v_u_96 = v_u_24.Visible
	end)
	local v_u_103 = {}
	local v_u_104 = false
	local function v114()
		-- upvalues: (ref) v_u_104, (ref) v_u_27, (copy) v_u_103
		if not v_u_104 then
			v_u_104 = true
			task.defer(function()
				-- upvalues: (ref) v_u_104, (ref) v_u_27, (ref) v_u_103
				v_u_104 = false
				local v105 = v_u_27:GetChildren()
				local v_u_106 = {}
				local v_u_107 = {}
				local v_u_108 = {}
				for v109 = #v105, 1, -1 do
					if v105[v109]:IsA("GuiObject") and v105[v109].Visible then
						v_u_106[v105[v109]] = v105[v109].Name
						v_u_107[v105[v109]] = v105[v109].LayoutOrder
						v_u_108[v105[v109]] = v109
					else
						table.remove(v105, v109)
					end
				end
				table.sort(v105, function(p110, p111)
					-- upvalues: (copy) v_u_107, (copy) v_u_106, (copy) v_u_108
					if v_u_107[p110] == v_u_107[p111] then
						if v_u_106[p110] == v_u_106[p111] then
							return v_u_108[p110] < v_u_108[p111]
						else
							return v_u_106[p110] < v_u_106[p111]
						end
					else
						return v_u_107[p110] < v_u_107[p111]
					end
				end)
				table.clear(v_u_103)
				for v112, v113 in v105 do
					v_u_103[v113] = v112
				end
			end)
		end
	end
	if not v_u_104 then
		v_u_104 = true
		task.defer(function()
			-- upvalues: (ref) v_u_104, (ref) v_u_27, (copy) v_u_103
			v_u_104 = false
			local v115 = v_u_27:GetChildren()
			local v_u_116 = {}
			local v_u_117 = {}
			local v_u_118 = {}
			for v119 = #v115, 1, -1 do
				if v115[v119]:IsA("GuiObject") and v115[v119].Visible then
					v_u_116[v115[v119]] = v115[v119].Name
					v_u_117[v115[v119]] = v115[v119].LayoutOrder
					v_u_118[v115[v119]] = v119
				else
					table.remove(v115, v119)
				end
			end
			table.sort(v115, function(p120, p121)
				-- upvalues: (copy) v_u_117, (copy) v_u_116, (copy) v_u_118
				if v_u_117[p120] == v_u_117[p121] then
					if v_u_116[p120] == v_u_116[p121] then
						return v_u_118[p120] < v_u_118[p121]
					else
						return v_u_116[p120] < v_u_116[p121]
					end
				else
					return v_u_117[p120] < v_u_117[p121]
				end
			end)
			table.clear(v_u_103)
			for v122, v123 in v115 do
				v_u_103[v123] = v122
			end
		end)
	end
	v_u_27.UIGridLayout:GetPropertyChangedSignal("AbsoluteCellCount"):Connect(v114)
	v_u_3.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u_100, (ref) v_u_36, (copy) v_u_103, (ref) v_u_99, (ref) v_u_90, (ref) v_u_92, (ref) v_u_96, (ref) v_u_88, (ref) v_u_89
		debug.profilebegin("Index::Cull")
		local v124 = v_u_100.Y * 2
		local v125 = 0
		for v126, v127 in v_u_36 do
			local v128 = v_u_103[v127.targetParent]
			local v129
			if v128 then
				local v130 = v128 / v_u_99.X
				local v131 = math.ceil(v130) - 1
				local v132 = v_u_90 + (v_u_100.Y + v_u_92) * v131 - v_u_92
				local v133 = v132 + v_u_100.Y
				v129 = v_u_96
				if v129 then
					if v_u_88 < v133 then
						v129 = v132 < v_u_89 + v124
					else
						v129 = false
					end
				end
			else
				v129 = false
			end
			if v127.state ~= v129 then
				local v134
				if v129 then
					v134 = v127.targetParent
				else
					v134 = nil
				end
				v126.Parent = v134
				v127.state = v129
				if v127.scheduledUpdate and v129 == true then
					v127.scheduledUpdate()
					v127.scheduledUpdate = nil
				end
			end
			v125 = v125 + 1
		end
		debug.profileend()
	end)
	v_u_8:WaitAndCall(v_u_23, function(_)
		-- upvalues: (ref) v_u_40, (ref) v_u_74, (ref) v_u_39
		v_u_40.OnOpen:Connect(v_u_74)
		v_u_40.OnClose:Connect(function()
			-- upvalues: (ref) v_u_39
			v_u_39:Clean()
		end)
		if v_u_40:IsOpened() then
			v_u_74()
		end
	end)
	v_u_18.OnUpdateEnabled:Connect(function()
		-- upvalues: (ref) v_u_40, (ref) v_u_38, (ref) v_u_37, (ref) v_u_74
		if v_u_40:IsOpened() then
			v_u_38:Fire(v_u_37)
			v_u_74()
		end
	end)
	v_u_18.OnUpdateDisabled:Connect(function()
		-- upvalues: (ref) v_u_40, (ref) v_u_74
		if v_u_40:IsOpened() then
			v_u_74()
		end
	end)
	local function v146()
		-- upvalues: (ref) v_u_37, (ref) v_u_14, (ref) v_u_32
		if v_u_37 then
			local v135 = v_u_14[v_u_37]
			local v136 = v135 and v135.CompletitionPercent or (v_u_37 == "Default" and 0.75 or 1)
			local v137 = Color3.new(1, 1, 1)
			if v_u_37 ~= "Default" and (v_u_37 ~= nil and v135) then
				v137 = v135.MainColor
			end
			local v138
			if v135 then
				v138 = v135.LimitedMutation
			else
				v138 = v135
			end
			local v139 = not v138
			local v140 = v135 and v135.DisplayWithRichText or ("<font color=\"#%*\">%*</font>"):format(v137:ToHex(), v_u_37)
			local v141 = v_u_32
			local v142
			if v_u_37 == "Default" then
				local v143 = v136 * 100
				v142 = ("Collect %*%% Normal Brainrots for +0.5x Base Multi"):format((math.ceil(v143)))
			elseif v_u_37 == "Halloween" then
				local v144 = v136 * 100
				v142 = ("Collect %*%% %* Brainrots for a <font color=\"#%*\">%* Base</font>"):format(math.ceil(v144), v140, v137:ToHex(), v140)
			else
				local v145 = v136 * 100
				v142 = ("Collect %*%% %* Brainrots for %*a <font color=\"#%*\">%* Base</font>"):format(math.ceil(v145), v140, v139 and "+0.5x Base Multi and " or "", v137:ToHex(), v140)
			end
			v141.Text = v142
		end
	end
	v_u_38:Connect(v146)
	v146()
end
return v41
