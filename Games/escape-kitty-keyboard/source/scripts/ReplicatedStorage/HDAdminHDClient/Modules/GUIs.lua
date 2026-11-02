

local u1 = {}
local u2 = _G.HDAdminMain
local u3 = u2:GetModule("Signal").new()
local u4 = nil
local u5 = {
	["About"] = { "Soon" },
	["Revenue"] = { "Soon" },
	["Commands"] = { "Commands" },
	["Boost"] = { "Buy" },
	["Moderation"] = { "Ranks", "Server Ranks", "Banland" },
	["Settings"] = { "Custom" }
}
local u6 = u2.gui.MainFrame
local u7 = u6.DragBar
local _ = u2.gui.CustomTopBar.ImageButton
local u8 = u6.Pages
local u9 = u8.Home
local u10 = Instance.new("BindableEvent")
local function u13(p11) 

	for _, v12 in pairs(u6.Pages.Home:GetChildren()) do
		if v12:FindFirstChild("Arrow") then
			v12.Arrow.Visible = p11
		end
	end
end
local function u21(p14, p15) 

	local v16 = p14 or u9
	if p15 == nil then
		p15 = u9:GetAttribute("HideBack")
	end
	local v17 = v16.Name == "Home"
	local v18 = UDim2.new(0.04, 0, 0.15, 0)
	if v17 then
		u7.Left.Title.Text = "Dashboard"
		u7.Left.Back.Visible = false
		u7.Left.Gap2.Visible = false
		u7.Left.Nanoblox.Visible = true
		u7.Left.Title.Position = v18
		u13(true)
	else
		if p15 then
			u7.Left.Back.Visible = false
			u7.Left.Title.Position = v18
			u7.Left.Gap2.Visible = true
		else
			u7.Left.Back.Visible = true
			u7.Left.Title.Position = UDim2.new(0.15, 0, 0.15, 0)
			u7.Left.Gap2.Visible = false
		end
		local v19 = v16.Name
		local v20 = v19 == "Boost" and "Unlock" or v19
		u7.Left.Nanoblox.Visible = false
		u7.Left.Title.Text = v20
		u13(false)
	end
end
local function u27(p22, p23) 
	local v24 = p22:FindFirstChild("SearchBar")
	if v24 then
		if p23 == nil then
			p23 = v24.Visible
		end
		if v24.Visible ~= p23 then
			v24.Visible = p23
		end
		local v25 = p23 and 0.92 or 1
		for _, v26 in pairs(p22:GetChildren()) do
			if v26:IsA("ScrollingFrame") then
				v26.Size = UDim2.new(1, 0, v25, 0)
			end
		end
	end
end
local function u35(p28, p29, p30) 

	local v31 = TweenInfo.new(p30 and 0 or 0.3, Enum.EasingStyle.Quad)
	local v32 = u9
	local v33 = u2.tweenService:Create(u9, v31, {
		["Position"] = p28
	})
	local v34 = u2.tweenService:Create(p29, v31, {
		["Position"] = UDim2.new(0, 0, 0, 0)
	})
	if p29.Name == "Home" then
		p29.Position = UDim2.new(-1, 0, 0, 0)
	else
		p29.Position = UDim2.new(1, 0, 0, 0)
		if p29.Name == "Moderation" then
			spawn(function()

				u2:GetModule("PageModeration"):UpdatePages()
			end)
		end
	end
	if v32.Name == "Home" and not p30 then
		u27(p29, true)
	end
	p29.Visible = true
	v33:Play()
	v34:Play()
	u9 = p29
	u4 = p29.Name
	u3:Fire(p29.Name)
	u21()
	v34.Completed:Wait()
	v32.Visible = false
end
u6.Visible = false
local u36 = u4
local u37 = u9
local u38 = true
for _, u39 in pairs(u8.Home:GetChildren()) do
	if u39:IsA("TextButton") then
		local u40 = u39.Fade
		local u41 = u39:FindFirstChild("RankBlocker")
		u39.MouseButton1Click:Connect(function()

			if not (u41 and u41.Visible) then
				if u38 then
					u38 = false
					local v42 = u8:FindFirstChild(u39.Name)
					if v42 then
						u35(UDim2.new(-1, 0, 0, 0), v42)
					end
					u38 = true
				end
			end
		end)
		u39.InputBegan:Connect(function(_)

			u2.tweenService:Create(u40, TweenInfo.new(0.2), {
				["BackgroundTransparency"] = 0.95
			}):Play()
		end)
		u39.InputEnded:Connect(function(p43)

			if p43.UserInputType ~= Enum.UserInputType.Keyboard then
				u2.tweenService:Create(u40, TweenInfo.new(0.2), {
					["BackgroundTransparency"] = 1
				}):Play()
			end
		end)
	end
end
local function u59(p44, p45, p46, p47, p48) 

	local v49 = TweenInfo.new(p48 and 0 or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v50 = u5[p44.Name]
	local u51
	if tonumber(p45) then
		u51 = v50[p45]
		if u51 then
			u51 = p44[u51]
		end
	else
		u51 = nil
	end
	local v52 = v50[p46]
	if v52 then
		v52 = p44[v52]
	end
	if v52 then
		local v53 = nil
		if u51 and u51:IsA("ScrollingFrame") then
			u51.ScrollBarImageTransparency = 1
		end
		if v52:IsA("ScrollingFrame") then
			v52.ScrollBarImageTransparency = 0
		end
		u27(p44)
		for _, v54 in pairs(v50) do
			local v55 = p44[v54]
			if v55 ~= v52 and v55 ~= u51 then
				v55.Position = UDim2.new(-2, 0, v55.Position.Y.Scale, 0)
			end
		end
		local v56 = p47 == "Right" and 1 or (p47 == "Left" and -1 or v53)
		local u57 = v56 * -1
		if p44:FindFirstChild("NavigateButtons") then
			p44.NavigateButtons.TextLabel.Text = v52.Name
		end
		v52.Position = UDim2.new(v56, 0, v52.Position.Y.Scale, v52.Position.Y.Offset)
		u2.tweenService:Create(v52, v49, {
			["Position"] = UDim2.new(0, 0, v52.Position.Y.Scale, 0)
		}):Play()
		if u51 then
			local u58 = u2.tweenService:Create(u51, v49, {
				["Position"] = UDim2.new(u57, 0, u51.Position.Y.Scale, 0)
			})
			u58:Play()
			spawn(function()

				u58.Completed:Wait()
				if u51.Position.X.Scale == u57 then
					u51.Position = UDim2.new(-2, 0, u51.Position.Y.Scale, 0)
				end
			end)
		end
	end
end
for _, u60 in pairs(u8:GetChildren()) do
	if u60:FindFirstChild("NavigateButtons") then
		local u61 = u5[u60.Name]
		local v62 = 0
		local u63 = 1
		for v64, v65 in pairs(u61) do
			local v66 = u60[v65]
			if v64 == 1 then
				u60.NavigateButtons.TextLabel.Text = v65
			else
				v62 = 1
			end
			v66.Position = UDim2.new(v62, 0, v66.Position.Y.Scale, 0)
			v66.Visible = true
		end
		for _, u67 in pairs(u60.NavigateButtons:GetChildren()) do
			if u67:IsA("TextButton") then
				u67.MouseButton1Down:Connect(function()

					local v68 = u63
					if u67.Name == "Right" then
						u63 = u63 + 1
						if u63 > #u61 then
							u63 = 1
						end
					elseif u67.Name == "Left" then
						u63 = u63 - 1
						if u63 < 1 then
							u63 = #u61
						end
					end
					u59(u60, v68, u63, u67.Name)
				end)
			end
		end
	end
end
local v69 = u7.Left
local v70 = u7.Right
local u71 = v69.Back
local function u72()

	u35(UDim2.new(1, 0, 0, 0), u8.Home)
end
u71.MouseButton1Down:Connect(function(...)

	if u38 then
		u38 = false
		u72(u71)
		u38 = true
	end
end)
local u73 = v70.Minimise
local function u75(p74)

	if p74.TextLabel.Text == "-" then
		u2.tweenService:Create(u8, TweenInfo.new(0.5), {
			["Position"] = UDim2.new(0, 0, -0.79, 0)
		}):Play()
		p74.TextLabel.Text = "+"
	else
		u8.Parent.Visible = true
		u2.tweenService:Create(u8, TweenInfo.new(0.5), {
			["Position"] = UDim2.new(0, 0, 0.1, 0)
		}):Play()
		p74.TextLabel.Text = "-"
	end
end
u73.MouseButton1Down:Connect(function(...)

	if u38 then
		u38 = false
		u75(u73)
		u38 = true
	end
end)
local u76 = v70.Close
local function u77()

	u1:CloseMainFrame()
end
u76.MouseButton1Down:Connect(function(...)

	if u38 then
		u38 = false
		u77(u76)
		u38 = true
	end
end)
local u78 = u2:GetModule("CmdBar")
local u79 = v70.ToggleCmdbar
local u80 = u79.BackgroundTransparency
local function u82() 

	if u78.isOpen then
		u79.BackgroundTransparency = 0.25
	else
		u79.BackgroundTransparency = u80
	end
	local v81
	if u2.pdata.Rank > 0 and u36 == "Commands" then
		v81 = u2.device == "Computer"
	else
		v81 = false
	end
	u79.Visible = v81
end
local function u85()

	if u78.isOpen then
		u79.BackgroundTransparency = 0.25
	else
		u79.BackgroundTransparency = u80
	end
	local v83
	if u2.pdata.Rank > 0 and u36 == "Commands" then
		v83 = u2.device == "Computer"
	else
		v83 = false
	end
	u79.Visible = v83
	if u78.isOpen then
		u78:CloseCmdBar()
	else
		u78:OpenCmdBar()
	end
	if u78.isOpen then
		u79.BackgroundTransparency = 0.25
	else
		u79.BackgroundTransparency = u80
	end
	local v84
	if u2.pdata.Rank > 0 and u36 == "Commands" then
		v84 = u2.device == "Computer"
	else
		v84 = false
	end
	u79.Visible = v84
end
u79.MouseButton1Down:Connect(function(...)

	if u38 then
		u38 = false
		u85(u79)
		u38 = true
	end
end)
u78.cmdbarToggled:Connect(u82)
task.defer(function()

	u2:GetModule("cf"):GetRankChangedSignal():Connect(u82)
end)
u3:Connect(u82)
function u1.OpenMainFrame(_) 

	local v86 = u2:GetModule("TopbarIcons")
	local v87 = v86.Dashboard
	local v88 = v86.Commands
	if not (v88.isEnabled and v88.isSelected) then
		v87:select()
	end
end
function u1.CloseMainFrame(_) 

	local v89 = u2:GetModule("TopbarIcons")
	v89.Dashboard:deselect()
	v89.Commands:deselect()
end
task.defer(function()

	local v90 = u2:GetModule("TopbarIcons")
	v90.Dashboard:bindEvent("deselected", function()

		u10:Fire()
	end)
	v90.Commands:bindEvent("deselected", function()

		u10:Fire()
	end)
end)
u1:CloseMainFrame()
u21()
local u91 = {}
function u1.ShowSpecificPage(_, u92, p93, u94, u95, p96, p97) 

	local v98 = false
	if u92 == "Boost" and p93 == "Buy" then
		if not p97 then
			if u94 ~= true then
				task.defer(function()

					local v99 = u2:GetModule("cf")
					if not v99:HasBooster() then
						v99:PromptGamepass(u2.player, "Booster")
					end
				end)
			end
			v98 = u94 ~= false and true or v98
		end
		u10.Event:Once(function()

			u2:GetModule("PageBooster"):OfferOnClose()
			u2:GetModule("GUIs"):ShowSpecificPage("Commands")
		end)
	end
	if u94 then
		v98 = true
		if typeof(u94) ~= "string" then
			u94 = nil
		end
	end
	for _, u100 in pairs(u8:GetChildren()) do
		if u100.Name == u92 then
			if v98 then
				u27(u100, p96 == true)
				u10.Event:Once(function()

					local v101 = u2:GetModule("PageCommands")
					if v101:GetSearchText() == "Booster" then
						v101:SetSearchText("")
						u2:GetModule("PageBooster"):OfferOnClose()
					end
					u27(u100, true)
				end)
				if u94 then
					local u102 = u7.Left.Back.BackOverride
					local u103 = nil
					local function v104() 

						if u103 then
							u103:Disconnect()
							u103 = nil
							u102.Visible = false
						end
					end
					u102.Visible = true
					u103 = u102.MouseButton1Down:Connect(function()

						if u103 then
							u103:Disconnect()
							u103 = nil
							u102.Visible = false
						end
						u1:ShowSpecificPage(u94, u95, u91[u94] == true, nil, nil, true)
					end)
					u10.Event:Once(v104)
					u100:SetAttribute("HideBack", nil)
				else
					u100:SetAttribute("HideBack", true)
					u91[u92] = true
					u10.Event:Once(function()

						task.wait()
						u100:SetAttribute("HideBack", nil)
						u91[u92] = nil
						u21(u100)
					end)
				end
				u21(u100)
			end
			if u92 == "Boost" and p93 == "Buy" then
				u100:SetAttribute("HideBack", true)
			end
			if u37 == u100 then
				u100.Visible = true
				u21(u100)
			else
				u35(UDim2.new(-1, 0, 0, 0), u100, true)
			end
			local v105 = u5[u100.Name]
			if v105 then
				local v106 = nil
				local v107 = nil
				for v108, v109 in pairs(v105) do
					local v110 = u100[v109]
					if v110.Name == p93 then
						v107 = v108
					elseif v110.Position.X.Scale == 0 then
						v106 = v108
					end
				end
				if v106 == nil then
					for v111 = 1, #v105 do
						if v111 ~= v107 then
							v106 = v111
						end
					end
				end
				if u92 == "Moderation" and u37.Name == "Moderation" then
					spawn(function()

						u2:GetModule("PageModeration"):UpdatePages()
					end)
				end
				if p93 ~= nil then
					u1:OpenMainFrame()
				end
				if u100:FindFirstChild("NavigateButtons") then
					u59(u100, v106, v107, "Left", true)
				end
			end
		else
			u100.Visible = false
		end
	end
	u36 = u92
	u3:Fire(u92)
end
u1:ShowSpecificPage("Home")
for _, u112 in pairs(u2.warnings:GetChildren()) do
	u112.CloseX.MouseButton1Down:Connect(function()

		u2.warnings.Visible = false
	end)
	local u113 = u112:FindFirstChild("MainButton")
	if u113 then
		local u114 = true
		u113.MouseButton1Down:Connect(function()

			if u114 then
				u114 = false
				if u112.Name == "BuyFrame" then
					local v115 = u113.ProductId.Value
					if u113.ProductType.Value == "Gamepass" then
						u2:GetModule("cf"):PromptGamepass(u2.player, v115)
					else
						u2.marketplaceService:PromptPurchase(u2.player, v115)
					end
				elseif u112.Name == "UnBan" then
					local v116 = u112
					v116.LoadingButton.Visible = true
					v116.MainButton.Visible = false
					u2.signals.RequestCommandModification:InvokeServer(u2.pdata.Prefix .. "undirectban " .. u112.PlrName.Text)
					u2:GetModule("PageModeration"):CreateBanland()
					local v117 = u112
					v117.LoadingButton.Visible = false
					v117.MainButton.Visible = true
					u2.warnings.Visible = false
				elseif u112.Name == "PermRank" then
					local v118 = u112
					v118.LoadingButton.Visible = true
					v118.MainButton.Visible = false
					local v119 = u112.PlrName.Text
					local v120 = { u2:GetModule("cf"):GetUserId(v119), v119 }
					u2.signals.RemovePermRank:InvokeServer(v120)
					u2:GetModule("PageModeration"):CreateRanks()
					local v121 = u112
					v121.LoadingButton.Visible = false
					v121.MainButton.Visible = true
					u2.warnings.Visible = false
				elseif u112.Name == "Teleport" then
					local v122 = u112
					v122.LoadingButton.Visible = true
					v122.MainButton.Visible = false
					local v123 = u112.MainButton.PlaceId.Value
					u2.teleportService:Teleport(v123)
					u2.teleportService.TeleportInitFailed:Wait()
					local v124 = u112
					v124.LoadingButton.Visible = false
					v124.MainButton.Visible = true
				end
				u114 = true
			end
		end)
	end
end
u2.warnings.Visible = false
function u1.DisplayPagesAccordingToRank(_, _) 

	local v125 = u8
	if v125 then
		v125 = u8:FindFirstChild("Home")
	end
	if v125 then
		for v126, v127 in pairs(u2.settings.RankRequiredToViewPage) do
			local v128 = v125:FindFirstChild(v126)
			local u129 = tonumber(v127) or 0
			if v128 then
				local v130 = v128.RankBlocker
				if v126 == "About" or u2.pdata.Rank >= u129 then
					v128.RankBlocker.Visible = false
				else
					local u131 = u2:GetModule("cf"):GetRankName(u129)
					v130.Visible = true
					v130.Active = false
					v130.TextLabel.Text = u131 .. "+"
					for _, v132 in pairs(v130:GetChildren()) do
						if v132:IsA("GuiObject") then
							v132.Visible = false
						end
					end
					if not v130:GetAttribute("WarningActive") then
						v130:SetAttribute("WarningActive", true)
						v130.MouseButton1Click:Connect(function()

							u2:GetModule("Notices"):Notice("Error", u2.hdAdminCoreName, (("Rank \'%*\' is required to view this page."):format(u131)))
							u2:GetModule("cf"):CheckPromptRank(u129)
						end)
					end
				end
			end
		end
	end
end
function u1.UpdateFont(_) 

	task.defer(function()

		local v133 = 0
		local v134 = u2.settings.AppFont
		if v134 then
			local v135 = nil
			local v136 = typeof(v134)
			if v136 == "number" then
				v135 = Font.fromId(v134)
			elseif v136 == "EnumItem" then
				v135 = Font.fromEnum(v134)
			elseif v136 == "string" and not v134:match("rbxasset") then
				v135 = Font.fromName(v134)
			end
			local v137 = v135 or Font.new(v134)
			if v137.Family ~= "rbxasset://fonts/families/SourceSansPro.json" then
				for _, v138 in pairs(u2.gui:GetDescendants()) do
					if v138:IsA("TextLabel") or (v138:IsA("TextButton") or v138:IsA("TextBox")) then
						local v139 = v138.Parent
						if v139 then
							v139 = v139.Name
						end
						if v139 ~= "Minimise" and v139 ~= "Close" then
							v138.FontFace = v137
							v133 = v133 + 1
							if v133 % 20 == 0 then
								task.wait()
							end
						end
					end
				end
				u2:GetModule("PageCommands"):CreateCommands()
			end
		else
			return
		end
	end)
end
local v140 = u2.gui.MenuTemplates
for _, v141 in pairs(v140:GetChildren()) do
	if v141:IsA("Frame") then
		v141.Visible = false
	end
end
return u1