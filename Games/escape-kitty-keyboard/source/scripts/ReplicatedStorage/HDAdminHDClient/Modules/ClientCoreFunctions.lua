

local u1 = {}
local u2 = _G.HDAdminMain
local u3 = u2.warnings.UnBan
local u4 = u2.warnings.PermRank
local u5 = u2.gui.MenuTemplates
local u6 = u2:GetModule("Signal").new()
local u7 = 1
local function u13(p8, p9) 
	for _, v10 in pairs(p8:GetDescendants()) do
		if v10:IsA("GuiObject") and v10:FindFirstChild("OriginalZIndex") == nil then
			local v11 = Instance.new("IntValue")
			v11.Name = "OriginalZIndex"
			local v12 = v10.ZIndex
			if p9 then
				v12 = v12 + 10000
			end
			v11.Value = v12
			v11.Parent = v10
		end
	end
end
local function u18(_, p14) 

	for v15, v16 in pairs(u2.commandMenus) do
		for _, v17 in pairs(v16:GetDescendants()) do
			if v17:IsA("GuiObject") and (v17:FindFirstChild("OriginalZIndex") and (not p14 or v16 == p14)) then
				v17.ZIndex = v17.OriginalZIndex.Value + (v15 - 1) * 10 - 1000
			end
		end
	end
end
function u1.CheckPromptRank(_, p19) 

	local v20 = u2:GetModule("cf"):GetGamepasses()[tostring(p19)]
	local v21 = nil
	if v20 then
		for _, v22 in pairs(v20) do
			v21 = v22
			break
		end
	end
	if v21 then
		local _ = v21.Name
		local u23 = v21.GamepassId
		task.defer(function()

			u2.marketplaceService:PromptGamePassPurchase(u2.player, u23)
		end)
	end
end
local u24 = nil
function u1.GetGamepasses(_) 

	if u24 then
		return u24
	end
	local v25 = u2.signals.RetrieveGamepasses:InvokeServer()
	if v25 then
		u24 = v25
		return v25
	end
end
function u1.ReplicateEffect(_, p26, p27) 

	u2.signals.ReplicateEffect:FireServer(p26, p27)
end
local u28 = nil
local u29 = nil
function u1.GetRankChangedSignal(_) 

	if u28 then
		return u28
	end
	u28 = u2:GetModule("Signal").new()
	return u28
end
function u1.WaitForLoadedRank(_) 

	if u29 then
		return u29
	else
		return u1:GetRankChangedSignal():Wait()
	end
end
function u1.RankChangedUpdater(_) 

	task.defer(function()

		if u2.initialized then
			repeat
				task.wait(0.5)
			until u2.initialized
		end
		local v30 = u1:GetRankChangedSignal()
		local v31 = u2.pdata.Rank
		u29 = v31
		v30:Fire(v31)
		u2:GetModule("PageAbout"):UpdateRankName()
		u2:GetModule("GUIs"):DisplayPagesAccordingToRank(true)
		u2:GetModule("PageCommands"):CreateCommands()
		u1:UpdateIconVisiblity()
	end)
end
function u1.UpdateIconVisiblity(_) 

	local v32 = false
	local v33 = false
	local v34 = u2.settings.RankRequiredToViewDashboardIcon or u2.settings.RankRequiredToViewIcon
	local v35 = u2.settings.RankRequiredToViewCommandsIcon or u2.settings.RankRequiredToViewIcon
	local v36 = u2.pdata.Rank or 0
	if v34 <= v36 then
		v32 = true
	elseif v35 <= v36 then
		v33 = true
	end
	local v37 = u2:GetModule("TopbarIcons")
	local v38 = v37.Dashboard
	local v39 = v37.Commands
	v38:setEnabled(v32)
	v39:setEnabled(v33)
end
function u1.DeactivateCommand(_, p40) 

	u2.commandsAllowedToUse[p40] = nil
	u2.commandsActive[p40] = nil
	if not u2.commandsToDisableCompletely[p40] then
		local v41 = u2.gui:FindFirstChild("CommandMenu" .. p40)
		u2:GetModule("cf"):DestroyCommandMenuFrame(v41)
	end
end
function u1.EndCommand(_, p42) 

	u2.commandsActive[p42] = nil
	u2:GetModule("cf"):UpdateCommandMenu(p42)
end
function u1.ActivateClientCommand(_, u43, p44) 

	if u2.commandsAllowedToUse[u43] and not (u2.commandsActive[u43] or p44 and (p44.DontForceActivate and u2.gui:FindFirstChild("CommandMenu" .. u43))) then
		u2.commandsActive[u43] = true
		spawn(function()

			u2:GetModule("cf"):UpdateCommandMenu(u43)
			local v45 = u2:GetModule("ClientCommands")[u43]
			local v46 = v45 and v45.Activate
			if v46 then
				v46(v45)
			end
			u2.commandsActive[u43] = nil
		end)
	end
end
function u1.GetCF(_, p47, p48) 
	local v49 = p47.CFrame
	local v50 = CFrame.new(v49.p)
	local v51, v52, v53 = (workspace.CurrentCamera.CFrame - workspace.CurrentCamera.CFrame.p):toEulerAnglesXYZ()
	return v50 * CFrame.Angles(p48 and v53 and v53 or v51, v52, v53)
end
function u1.GetNextMovement(_, p54, p55) 

	local v56 = Vector3.new()
	local v57 = {
		["Left"] = Vector3.new(-1, 0, 0),
		["Right"] = Vector3.new(1, 0, 0),
		["Forwards"] = Vector3.new(0, 0, -1),
		["Backwards"] = Vector3.new(0, 0, 1),
		["Up"] = Vector3.new(0, 1, 0),
		["Down"] = Vector3.new(0, -1, 0)
	}
	if u2.device == "Computer" then
		for _, v58 in pairs(u2.movementKeysPressed) do
			local v59 = v57[v58]
			if v59 then
				v56 = v56 + v59
			end
		end
	else
		local v60 = u2:GetModule("cf"):GetHumanoid()
		local v61 = u2:GetModule("cf"):GetHRP()
		if v60 and v61 then
			local v62 = v60.MoveDirection
			for v63, v64 in pairs(v57) do
				local _ = v63 == "Forwards" or v63 == "Backwards"
				if ((u1:GetCF(v61, true) * CFrame.new(v64) - v61.CFrame.p).p - v62).magnitude <= 1.05 and v62 ~= Vector3.new(0, 0, 0) then
					v56 = v56 + v64
				end
			end
		end
	end
	return CFrame.new(v56 * p55 * p54), v56
end
function u1.GetAssetImage(_, p65) 
	return "https://www.roblox.com/asset-thumbnail/image?assetId=" .. p65 .. "&width=420&height=420&format=png"
end
function u1.GetUserImage(_, p66) 
	return "https://www.roblox.com/headshot-thumbnail/image?userId=" .. p66 .. "&width=420&height=420&format=png"
end
function u1.ShowPermRankedUser(_, p67) 

	local v68 = p67[1]
	local v69 = p67[2]
	local v70 = p67[3]
	u4.PlrName.Text = v68
	u4.PlrImage.Image = u1:GetUserImage(v69)
	u4.RankedBy.TextLabel.Text = u2:GetModule("cf"):GetName(v70)
	u2:GetModule("cf"):ShowWarning("PermRank")
end
function u1.ShowBannedUser(_, p71) 

	local v72 = p71[1]
	local v73 = p71[2]
	local v74 = p71[3]
	local v75 = p71[4]
	local v76 = u3.Reason.TextLabel
	u3.PlrName.Text = v72
	u3.PlrImage.Image = u1:GetUserImage(v73)
	u3.BannedBy.TextLabel.Text = u2:GetModule("cf"):GetName(v75)
	v76.Text = "\'" .. v74 .. "\'"
	if v76.Text == "" or v76.Text == " " then
		v76.Text = "Empty"
		v76.Font = Enum.Font.SourceSansItalic
	else
		v76.Font = Enum.Font.SourceSans
	end
	u2:GetModule("cf"):ShowWarning("UnBan")
end
function u1.ShowWarning(_, p77) 

	for _, v78 in pairs(u2.warnings:GetChildren()) do
		if v78.Name == p77 then
			v78.Visible = true
			u2.warnings.Visible = true
		else
			v78.Visible = false
		end
	end
end
function u1.SetCameraSubject(_, p79) 

	local v80 = u2:GetModule("cf"):GetFace()
	if v80 then
		local v81 = v80.Transparency
		u2.camera.CameraSubject = p79
		v80.Transparency = v81
	end
end
function u1.DestroyCommandMenuFrame(_, p82) 

	if p82 then
		for v83, v84 in pairs(u2.commandMenus) do
			if v84 == p82 then
				table.remove(u2.commandMenus, v83)
			end
		end
		p82:Destroy()
	end
end
function u1.UpdateCommandMenu(_, p85, p86) 

	if p86 == nil or p86.Parent == nil then
		p86 = u2.gui:FindFirstChild("CommandMenu" .. p85)
	end
	if p86 then
		local v87 = p86.MainFrame
		if v87:FindFirstChild("Status") then
			if u2.commandsToDisableCompletely[p85] and u2.commandsAllowedToUse[p85] or u2.commandsActive[p85] then
				v87.Status.TextLabel.Text = "On"
				v87.Status.TextLabel.TextColor3 = Color3.fromRGB(0, 225, 0)
				v87.ChangeStatus.TextLabel.Text = "DISABLE"
				return
			end
			v87.Status.TextLabel.Text = "Off"
			v87.Status.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
			v87.ChangeStatus.TextLabel.Text = "ENABLE"
		end
	end
end
function u1.CreateNewCommandMenu(_, u88, u89, p90, p91, _) 

	local v92 = tonumber(p90)
	local u93 = u2:GetModule("cf"):FindValue({
		4,
		5,
		8,
		11,
		12,
		13,
		14,
		16,
		18
	}, v92)
	local v94 = u2:GetModule("cf"):FindValue({ 4 }, v92)
	local v95 = u2:GetModule("cf"):FindValue({
		17,
		5,
		6,
		7,
		9,
		12,
		13,
		14,
		16,
		18
	}, v92)
	local v96 = "CommandMenu" .. u88
	if v94 then
		v96 = "CommandMenu" .. u88 .. u7
		u7 = u7 + 1
	end
	local v97 = u2.gui:FindFirstChild(v96)
	if v97 and v95 then
		v97:Destroy()
		v97 = nil
	end
	if not v97 then
		local v98 = u5["Template" .. v92]
		local v99 = v98.MainFrame
		local u100 = v98:Clone()
		u100.Name = v96
		local v101 = u100.DragBar
		local u102 = u100.MainFrame
		local v103 = u88:gsub("(%u)", " %1"):gsub("^%s", ""):split(" ")
		for v104, v105 in pairs(v103) do
			v103[v104] = v105:lower():gsub("^%l", string.upper)
		end
		local v106 = table.concat(v103, " ")
		v101.Title.Text = v106
		u2:GetModule("InputHandler"):MakeFrameDraggable(u100)
		v101.Close.MouseButton1Down:Connect(function()

			if u93 then
				u1:DestroyCommandMenuFrame(u100)
			else
				u100.Visible = false
			end
		end)
		local u107 = u102.Position.Y.Scale
		local u108 = -(1 - v101.Size.Y.Scale - u107)
		local u109 = v101:FindFirstChild("Minimise")
		if u109 then
			u109.MouseButton1Down:Connect(function()

				if u109.TextLabel.Text == "-" then
					u2.tweenService:Create(u102, TweenInfo.new(0.5), {
						["Position"] = UDim2.new(0, 0, u108, -1)
					}):Play()
					u109.TextLabel.Text = "+"
				else
					u2.tweenService:Create(u102, TweenInfo.new(0.5), {
						["Position"] = UDim2.new(0, 0, u107, 0)
					}):Play()
					u109.TextLabel.Text = "-"
				end
			end)
		end
		local function u119(p110, p111, p112) 

			local v113 = p112[1]
			local v114 = p112[2]
			local v115 = p112[3]
			local v116 = p112[4]
			local v117 = p112[5]
			if not p110:FindFirstChild(p111) then
				p111 = v113[p110.Name]
			end
			if p110.Name == "AC Server" and (p111 == "All" and u2.pdata.Rank < u2.commandRanks.globalvote) then
				u2:GetModule("Notices"):Notice("Error", u2.hdAdminCoreName, "Must be \'" .. u2:GetModule("cf"):GetRankName(u2.commandRanks.globalvote) .. "\' to use ;globalVote")
			else
				for _, v118 in pairs(p110:GetChildren()) do
					if v118:IsA("TextButton") then
						v114(v118, p111, p110)
					end
				end
				if v116 and v117 then
					v115.CanvasSize = UDim2.new(0, 0, 0, v116.AbsolutePosition.Y - v117.AbsolutePosition.Y + v116.AbsoluteSize.Y)
				end
			end
		end
		local function v142(p120, p121, p122, u123, p124, p125, p126) 

			local u127 = false
			p122.Focused:Connect(function()

				u127 = true
			end)
			p122.FocusLost:Connect(function()

				wait()
				u127 = false
			end)
			local u128 = u127
			for v129, _ in pairs(p120) do
				local u130 = p121[v129]
				for _, u131 in pairs(u130:GetChildren()) do
					if u131:IsA("TextButton") then
						u131.MouseButton1Down:Connect(function()

							if not u128 then
								u119(u130, u131.Name, u123)
							end
						end)
					end
				end
				p124(u130)
			end
			if p125 then
				for _, u132 in pairs(p125:GetChildren()) do
					local u133 = u132:FindFirstChild("TextBox")
					if u133 then
						local u134 = u133.Text
						u133.Focused:Connect(function()

							u128 = true
						end)
						u133.FocusLost:connect(function(_)

							local v135 = u133.Text
							local v136 = tonumber(v135)
							if v136 then
								u134 = v136 < 0 and 0 or (u132.Name == "Minutes" and v136 > 60 and 60 or (u132.Name == "Hours" and v136 > 24 and 24 or (u132.Name == "Days" and v136 > 100000 and 100000 or v136)))
							end
							u133.Text = u134
							wait()
							u128 = false
						end)
					end
				end
			end
			if p126 then
				local v137 = string.lower(p126)
				for _, v138 in pairs(u2.qualifiers) do
					if v138 == v137 then
						p126 = v138
						break
					end
				end
				if not p126 then
					for _, v139 in pairs(u2.players:GetChildren()) do
						local v140 = string.lower(v139.Name)
						local v141 = #v137
						if string.sub(v140, 1, v141) == v137 then
							p126 = v139.Name
							break
						end
					end
				end
				p122.Text = p126 or ""
			end
		end
		local function v157(u143, u144, u145, u146, u147, u148) 

			local u149 = u143.FinalResult
			local v150 = u149.Frame
			local _ = v150.Example
			local u151 = v150.Loading
			local u152 = v150.Broadcast
			u149.Visible = false
			v150.CloseX.MouseButton1Down:Connect(function()

				u149.Visible = false
			end)
			u152.MouseButton1Down:Connect(function()

				u151.Visible = true
				u152.Visible = false
				local v153, v154 = u148()
				if v153 == false and v154 then
					u151.Visible = false
					u152.Visible = true
					u2:GetModule("Notices"):Notice("Error", u2.hdAdminCoreName, (("Request failed: %*"):format((tostring(v154)))))
				else
					u1:DestroyCommandMenuFrame(u143)
				end
			end)
			u144.MouseButton1Down:Connect(function()

				u145.Visible = true
				u144.Visible = false
				local v155 = u146()
				if type(v155) == "table" then
					u147(v155)
				else
					local v156 = tostring(v155) or "Error"
					u145.TextLabel.Text = v156
					wait(1)
					u145.TextLabel.Text = "Loading..."
				end
				u145.Visible = false
				u144.Visible = true
			end)
		end
		local function u169(u158, u159) 

			local v160 = u158.AnswerTemplate
			v160.Visible = false
			u158.Question.TextLabel.Text = u159.Question
			for _, v161 in pairs(u158:GetChildren()) do
				if v161:IsA("TextButton") and v161 ~= v160 then
					v161:Destroy()
				end
			end
			for u162, v163 in pairs(u159.Answers) do
				local v164 = v160:Clone()
				v164.Visible = true
				v164.Name = "Answer" .. u162
				v164.TextLabel.Text = u162 .. ". " .. v163
				v164.BackgroundColor3 = u1:GetLabelBackgroundColor(u162)
				local u165 = v164.Fade
				if u159.Remote then
					v164.MouseButton1Up:Connect(function()

						u158.Parent.Parent.Visible = false
						pcall(function()

							u159.Remote:FireServer(u162)
						end)
					end)
				end
				v164.InputBegan:Connect(function(_)

					u2.tweenService:Create(u165, TweenInfo.new(0.2), {
						["BackgroundTransparency"] = 0.8
					}):Play()
				end)
				v164.InputEnded:Connect(function(_)

					u2.tweenService:Create(u165, TweenInfo.new(0.2), {
						["BackgroundTransparency"] = 1
					}):Play()
				end)
				v164.Parent = u158
			end
			spawn(function()

				wait(0.1)
				local v166 = u158
				local v167 = u158["Answer" .. #u159.Answers]
				local v168 = u158.Question
				v166.CanvasSize = UDim2.new(0, 0, 0, v167.AbsolutePosition.Y - v168.AbsolutePosition.Y + v167.AbsoluteSize.Y)
			end)
		end
		if v92 == 1 or v92 == 17 then
			local v170 = UDim2.new(1, -255, 1, -155)
			if u2.device ~= "Mobile" and u100.Position ~= v170 then
				u100.Position = v170
				u100.Size = UDim2.new(0, 250, 0, 150)
			end
			local v171 = u89[2]
			local u172 = u88 == "dance"
			local u173 = u102:FindFirstChild("InfoFrame")
			if u173 then
				u173.Visible = false
			end
			local v174 = u102:FindFirstChild("Desc")
			if v174 then
				v174.Visible = false
			end
			u102.InputFrame.Visible = false
			local v175 = u89[1]
			if v175 == "Info" and v174 then
				u102.Desc.Text = u89[2]
				u102.Desc.Visible = true
			elseif v175 == "Input" then
				local u176 = u102.InputFrame.Frame.TextBox
				local u177 = u2.commandSpeeds[u88]
				u102.InputFrame.InputName.Text = v171 .. ":"
				u176.Text = u177
				local u178 = u2.player.Character
				if u172 and u178 then
					task.delay(0.2, function()

						local function u182() 

							local v179 = nil
							for _, v180 in pairs(u178:GetChildren()) do
								if v180:GetAttribute("HDDance") then
									v179 = v180
									break
								end
							end
							if v179 then
								local v181 = v179:GetAttribute("HDSpeed")
								if v181 then
									u176.Text = v181
								end
								v179.Destroying:Once(function()

									task.delay(0.2, function()

										if not u182() then
											u1:DestroyCommandMenuFrame(u100)
										end
									end)
								end)
							end
							return v179
						end
						u182()
					end)
				end
				if u2.infoFramesViewed[v171] and u173 then
					u2.infoFramesViewed[v171] = nil
					if v171 == "Speed" then
						local v183 = u2.device == "Computer" and {
							{ "Movement", "WASD" },
							{ "Toggle flight", "E" },
							{ "Up & Down", "R & F" }
						} or {
							{ "Movement", "Thumbstick" },
							{ "Toggle flight", "Double-jump" }
						}
						for v184 = 1, 3 do
							local v185 = u173["Info" .. v184]
							local v186 = v183[v184]
							if v186 then
								v185.Text = v186[1] .. ":"
								v185.TextLabel.Text = v186[2]
								v185.Visible = true
							else
								v185.Visible = false
							end
						end
						if not u172 then
							u173.Okay.MouseButton1Down:Connect(function()

								u173.Visible = false
							end)
							u173.Visible = true
						end
					end
				end
				local u187 = u176.Text
				u176.FocusLost:Connect(function()

					local v188 = u176.Text
					local v189 = tonumber(v188) or u177
					u176.Text = "..."
					local v190 = u2.signals.RequestCommandModification:InvokeServer(u2.pdata.Prefix .. u88 .. " me " .. v189)
					local v191 = u2.settings.CommandLimits.animations
					if u172 then
						local v192 = v191.Limit
						local v193 = v191.Minimum
						if v192 < v189 then
							v193 = v192
						elseif v189 >= v193 then
							v193 = v189
						end
						u176.Text = v193
					elseif not v190 then
						u176.Text = u187
					end
					u187 = u176.Text
				end)
				u102.InputFrame.Visible = true
			end
			u1:UpdateCommandMenu(u88, u100)
			local v194 = u102:FindFirstChild("ChangeStatus")
			local u195 = v194
			if u195 then
				u195 = v194.TextLabel
			end
			u102.ChangeStatus.MouseButton1Down:Connect(function()

				u102.Loading.Visible = true
				if u2.commandsToDisableCompletely[u88] then
					local v196 = u195 and u195.Text or "DISABLE"
					local v197
					if v196 == "DISABLE" or v196 == "STOP" then
						v197 = "!Un" .. u88
					else
						v197 = "!" .. u88
					end
					u2.signals.RequestCommandModification:InvokeServer(v197)
					if u172 then
						task.defer(function()

							u1:DestroyCommandMenuFrame(u100)
						end)
					end
					wait(1)
				elseif u2.commandsActive[u88] then
					u2.commandsActive[u88] = nil
				else
					u2:GetModule("cf"):ActivateClientCommand(u88)
					wait(0.5)
				end
				u1:UpdateCommandMenu(u88, u100)
				if u100 and u100.Parent then
					u102.Loading.Visible = false
				end
			end)
			u100.ZIndex = u100.ZIndex + 11
			local u198 = u102:FindFirstChild("GetFrame")
			if u172 and u198 then
				local u199 = u198.LinkUGC.Holder.TextBox
				local u200 = nil
				local u201 = nil
				local u202 = nil
				local function v203() 

					if u100.Parent then
						u200 = u2.player:GetAttribute("HDPrevDance")
						u199.Text = ("roblox.com/catalog/%*"):format(u200)
						if u201 then
							u201:Disconnect()
						end
						if u202 then
							u202:Disconnect()
						end
						u201 = u1:SetupUnlockUGC(u200, u198.UnlockUGC)
						u202 = u1:SetupFavoriteUGC(u200, u198.FavoriteUGC)
					end
				end
				v203()
				task.delay(0.25, v203)
				task.delay(0.5, v203)
				task.delay(1, v203)
				v101.Title.Text = "Emote"
				u199.TextSize = u102.InputFrame.Frame.TextBox.AbsoluteSize.Y
			end
		elseif v92 == 2 then
			if u88 == "cmdbar2" then
				v101.Title.Text = "Cmdbar2"
			end
			if u2.device ~= "Mobile" then
				u100.Position = UDim2.new(0, 35, 1, -105)
				u100.Size = UDim2.new(0, 315, 0, 70)
			end
			local v204 = u102.SearchFrame
			local u205 = v204.TextBox
			local v206 = {
				["maxSuggestions"] = 3,
				["suggestionPos"] = 1,
				["suggestionDisplayed"] = 0,
				["forceExecute"] = false,
				["mainParent"] = u102.Parent,
				["textBox"] = u205,
				["rframe"] = v204.ResultsFrame,
				["highlightColor"] = Color3.fromRGB(50, 50, 50),
				["otherColor"] = Color3.fromRGB(80, 80, 80),
				["suggestionLabels"] = {}
			}
			u2:GetModule("CmdBar"):SetupTextbox(u88, v206)
			local u207 = u102.Loading
			u102.Execute.MouseButton1Down:Connect(function()

				u207.Visible = true
				if #u205.Text > 1 then
					local v208 = u205.Text
					local v209 = string.sub(v208, 1, 1)
					if v209 ~= u2.settings.UniversalPrefix and (v209 ~= u2.settings.ChatPrefix and v209 ~= u2.pdata.Prefix) then
						v208 = u2.pdata.Prefix .. v208
					end
					if string.sub(v208, -1) == " " then
						v208 = string.sub(v208, 1, -1)
					end
					u2.signals.RequestCommandSilent:InvokeServer(v208)
				end
				u207.Visible = false
			end)
		elseif v92 == 3 then
			if u88 == "cmdbar2" then
				v101.Title.Text = "Cmdbar2"
			end
			if u2.device ~= "Mobile" then
				u100.Position = UDim2.new(0, 40, 1, -145)
				u100.Size = UDim2.new(0, 315, 0, 105)
			end
			local v210 = u102.PlayerFrame.SearchFrame
			local u211 = v210.TextBox
			if u89 then
				u89 = u89.TargetName
			end
			u211.Text = u89 or u2.player.Name
			local v212 = {
				["maxSuggestions"] = 3,
				["suggestionPos"] = 1,
				["suggestionDisplayed"] = 0,
				["forceExecute"] = false,
				["specificArg"] = "player",
				["mainParent"] = u102.Parent,
				["textBox"] = u211,
				["rframe"] = v210.ResultsFrame,
				["highlightColor"] = Color3.fromRGB(50, 50, 50),
				["otherColor"] = Color3.fromRGB(80, 80, 80),
				["suggestionLabels"] = {}
			}
			u2:GetModule("CmdBar"):SetupTextbox(u88, v212)
			local u213 = u102.MessageFrame.SearchFrame.TextBox
			u213.FocusLost:connect(function(p214)

				if p214 then
					local v215 = u211.Text
					if string.sub(v215, -1) == " " then
						v215 = string.sub(v215, 1, -1)
					end
					local v216 = u2.pdata.Prefix .. "talk" .. u2.pdata.SplitKey .. v215 .. u2.pdata.SplitKey .. u213.Text
					u213.Text = ""
					u2.signals.RequestCommandModification:InvokeServer(v216)
				end
			end)
		elseif v92 == 4 then
			local u217 = u89[1]
			local v218 = u89[2]
			local u219 = u102.ReplyFrame.TextBox
			local u220 = u102.Send
			v101.Title.Text = "Message from " .. u217.Name
			u102.MessageFrame.Message.Text = v218
			u219.Changed:connect(function(p221)

				if p221 == "Text" then
					if #u219.Text > 0 then
						u220.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
						u220.AutoButtonColor = true
						return
					end
					u220.TextLabel.TextColor3 = Color3.fromRGB(125, 125, 125)
					u220.AutoButtonColor = false
				end
			end)
			u220.MouseButton1Down:Connect(function()

				if u220.AutoButtonColor then
					u1:DestroyCommandMenuFrame(u100)
					u2.signals.ReplyToPrivateMessage:InvokeServer({ u217, u219.Text })
				end
			end)
		elseif v92 == 5 then
			local v222 = v99.ScrollFrame.AbsoluteSize.Y / 11
			local u223 = math.ceil(v222)
			local u224 = v99.ScrollFrame.Template
			local u225 = u223 / 3
			local u226 = u102.ScrollFrame
			local u227 = u102.LoadMore
			local u228 = u227.Displaying
			local u229 = u227.Load
			u226.Template:Destroy()
			u100.Parent = u2.gui
			local u230 = {}
			local u231 = 0
			local u232 = 0
			local function u245(p233, p234) 

				local v235 = p233 + p234 - 1
				local v236 = #u230
				u231 = math.min(v235, v236)
				for v237 = p233, u231 do
					local v238 = u230[v237]
					local v239 = v238.TextLabel
					local v240 = u2.textService
					local v241 = v239.Text
					local v242 = v239.TextSize
					local v243 = v240:GetTextSize(v241, tonumber(v242), v239.Font, Vector2.new((1 / 0), u223)).X
					if u232 < v243 then
						u232 = v243
					end
					v238.Parent = u226
				end
				u228.Text = ("%d/%d"):format(u231, #u230)
				local v244 = u231 < #u230
				u227.Visible = v244
				u226.Size = v244 and UDim2.new(1, 0, 0.84, 0) or UDim2.new(1, 0, 0.92, 0)
				u226.CanvasSize = UDim2.new(0, u232, 0, u231 * u223)
			end
			u229.MouseButton1Click:Connect(function()

				u245(u231 + 1, 20)
			end)
			local function u247() 

				u230 = {}
				for _, v246 in pairs(u226:GetChildren()) do
					if v246.Name ~= "UIListLayout" then
						v246:Destroy()
					end
				end
				u228.Text = "0/0"
				u231 = 0
				u232 = 0
				u229.Visible = true
			end
			local function u259(p248) 

				u247()
				for v249, v250 in pairs(p248) do
					local v251 = u224:Clone()
					local v252 = v251.TextLabel
					local v253 = v250.message
					local v254 = v250.timeAdded
					local v255 = os.date("*t", v254)
					local v256 = v250.speakerName
					local v257 = v255.hour
					local v258 = v255.min
					if v257 < 10 then
						v257 = "0" .. v257
					end
					if v258 < 10 then
						v258 = "0" .. v258
					end
					v252.Text = "[" .. v257 .. ":" .. v258 .. "] " .. v256 .. ": " .. v253
					v251.BackgroundColor3 = u1:GetLabelBackgroundColor(v249)
					v251.Visible = true
					v251.Name = "Record" .. v249
					v251.Size = UDim2.new(1, 0, 0, u223)
					v252.Position = UDim2.new(0, u225, 0.5, 0)
					v252.Size = UDim2.new(1, -u225 * 2, v252.Size.Y.Scale, 0)
					u230[#u230 + 1] = v251
				end
				u245(1, 20)
			end
			u259(u89)
			local u260 = true
			local u261 = u102.SearchBar.Frame.TextBox
			u261.FocusLost:connect(function(_)

				if u260 then
					u260 = false
					local v262 = string.lower(u261.Text)
					local v263 = {}
					for _, v264 in pairs(u89) do
						local v265 = string.lower
						local v266 = v264.message
						local v267 = v264.timeAdded
						local v268 = os.date("*t", v267)
						local v269 = v264.speakerName
						local v270 = v268.hour
						local v271 = v268.min
						if v270 < 10 then
							v270 = "0" .. v270
						end
						if v271 < 10 then
							v271 = "0" .. v271
						end
						local v272 = v265("[" .. v270 .. ":" .. v271 .. "] " .. v269 .. ": " .. v266)
						if string.find(v272, v262, 1, true) then
							table.insert(v263, v264)
						end
					end
					u259(v263)
					u13(u226)
					u18(u2.commandMenus, u226)
					wait(0.5)
					u260 = true
				end
			end)
		elseif v92 == 6 then
			local u273 = u102.ScrollFrame
			local u274 = {
				["AG Server"] = "All",
				["AJ Length"] = "Infinite",
				["AHB Alts Decide"] = "Yes"
			}
			local u275 = {}
			local v276 = u273["AC Target Player"].SearchFrame
			local u277 = v276.TextBox
			local v278 = u89.targetPlayer
			local u279 = u273["AJA Time"]
			local u280 = u273["AA Space"]
			local u281 = u273["AZ Space"]
			local v282 = u273["AX Ban"]
			local u283 = u273["AM Reason"].SearchFrame.TextBox
			local u284 = u273["AHA Alts Title"]
			local u285 = u273["AHB Alts Decide"]
			local u286 = u273["AHC Alts Space"]
			local u291 = {
				u274,
				function(p287, p288, p289)

					if p287.Name == p288 then
						p287.BackgroundTransparency = 0.1
						p287.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
						u275[p289.Name] = p288
						if p289.Name == "AJ Length" then
							if p287.Name == "Time" then
								u279.Visible = true
							else
								u279.Visible = false
							end
						end
						if p289.Name == "AG Server" then
							local v290 = p287.Name == "All"
							u284.Visible = v290
							u285.Visible = v290
							u286.Visible = v290
							if not u275["AHB Alts Decide"] then
								u275["AHB Alts Decide"] = u274["AHB Alts Decide"]
								return
							end
						end
					else
						p287.BackgroundTransparency = 0.8
						p287.TextLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
					end
				end,
				u273,
				u281,
				u280
			}
			v142(u274, u273, u277, u291, function(p292)

				if p292.Name == "AG Server" then
					u119(p292, u89.server, u291)
				elseif p292.Name == "AJ Length" then
					u119(p292, u89.length, u291)
				end
			end, u279, v278)
			local v293 = {
				["maxSuggestions"] = 3,
				["suggestionPos"] = 1,
				["suggestionDisplayed"] = 0,
				["forceExecute"] = false,
				["specificArg"] = "player",
				["mainParent"] = u102.Parent,
				["textBox"] = u277,
				["rframe"] = v276.ResultsFrame,
				["highlightColor"] = Color3.fromRGB(50, 50, 50),
				["otherColor"] = Color3.fromRGB(80, 80, 80),
				["suggestionLabels"] = {}
			}
			u2:GetModule("CmdBar"):SetupTextbox(u88, v293)
			local v294 = u89.timeDetails
			if v294 then
				v294:gsub("%d+%a", function(p295)

					local v296 = tonumber(p295:match("%d+"))
					if v296 then
						local v297 = p295:match("%a")
						local _, v298, v299 = u2:GetModule("cf"):GetTimeAmount(v297, v296)
						u279[v298].TextBox.Text = v299
					end
				end)
			end
			local v300 = u89.reason
			if v300 and (v300 ~= "" and v300 ~= " ") then
				u283.Text = v300
			end
			v282.MouseButton1Down:Connect(function()

				local v301 = u283.Text
				local v302 = u277.Text
				local v303 = u279.Minutes.TextBox.Text
				local v304 = u279.Hours.TextBox.Text
				local v305 = u279.Days.TextBox.Text
				local v306 = {
					["server"] = u275["AG Server"],
					["length"] = u275["AJ Length"],
					["lengthTime"] = v303 .. "m" .. v304 .. "h" .. v305 .. "d",
					["banAlts"] = u275["AHB Alts Decide"]
				}
				u1:DestroyCommandMenuFrame(u100)
				u2.signals.RequestCommandModification:InvokeServer(u2.pdata.Prefix .. "directBan" .. u2.pdata.SplitKey .. v302 .. u2.pdata.SplitKey .. v301, v306)
			end)
			spawn(function()

				wait(0.1)
				local v307 = u281
				local v308 = u280
				u273.CanvasSize = UDim2.new(0, 0, 0, v307.AbsolutePosition.Y - v308.AbsolutePosition.Y + v307.AbsoluteSize.Y)
			end)
		elseif v92 == 7 then
			local v309 = u102.ScrollFrame
			local v310 = {
				["AG DisplayFrom"] = "Enabled"
			}
			local u311 = {}
			local v312 = v309["AJ MessageColor"].SearchFrame
			local u313 = v312.TextBox
			local v314 = v309["AX Submit"]
			local v315 = v309["AZ Loading"]
			local v316 = v309["AF Title"]
			local u317 = v309["AC MessageTitle"].SearchFrame.TextBox
			local u318 = v309["AM Message"].SearchFrame.TextBox
			local u322 = { v310, function(p319, p320, p321)

					if p319.Name == p320 then
						p319.BackgroundTransparency = 0.1
						p319.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
						u311[p321.Name] = p320
					else
						p319.BackgroundTransparency = 0.8
						p319.TextLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
					end
				end, v309 }
			v316.TextLabel.Text = "Display \'From " .. u2.player.Name .. "\'"
			v142(v310, v309, u313, u322, function(p323)

				if p323.Name == "AG DisplayFrom" then
					u119(p323, "Enabled", u322)
				end
			end)
			local v324 = {
				["maxSuggestions"] = 3,
				["suggestionPos"] = 1,
				["suggestionDisplayed"] = 0,
				["forceExecute"] = false,
				["specificArg"] = "color",
				["mainParent"] = u102.Parent,
				["textBox"] = u313,
				["rframe"] = v312.ResultsFrame,
				["highlightColor"] = Color3.fromRGB(50, 50, 50),
				["otherColor"] = Color3.fromRGB(80, 80, 80),
				["suggestionLabels"] = {}
			}
			u2:GetModule("CmdBar"):SetupTextbox(u88, v324)
			local u325 = u100.FinalResult
			local u326 = u325.Frame.Example
			v157(u100, v314, v315, function()

				local v327 = u311["AG DisplayFrom"] == "Enabled"
				return u2.signals.RetrieveBroadcastData:InvokeServer({
					["Title"] = u317.Text,
					["DisplayFrom"] = v327,
					["Color"] = u313.Text,
					["Message"] = u318.Text
				})
			end, function(p328)

				u326.Title.Text = p328.Title
				local v329 = p328.DisplayFrom
				u326.Pic.Visible = v329
				u326.SubTitle.Visible = v329
				if v329 then
					u326.Pic.Image = u1:GetUserImage(p328.SenderId)
					u326.SubTitle.Text = "From " .. p328.SenderName
				end
				u326.Desc.TextColor3 = Color3.new(p328.Color[1], p328.Color[2], p328.Color[3])
				u326.Desc.Text = p328.Message
				u325.Visible = true
			end, function()

				return u2.signals.ExecuteBroadcast:InvokeServer()
			end)
		elseif v92 == 8 then
			local v330 = u89[1]
			local v331 = u89[2]
			local _ = u89[3]
			local v332 = v101.Mute
			local u333 = v332.TextLabel
			local u334 = Instance.new("Sound")
			u334.SoundId = "rbxassetid://" .. (u2.pdata.Alert2SoundId or u2.pdata.AlertSoundId)
			u334.Volume = u2.pdata.AlertVolume
			u334.Pitch = u2.pdata.AlertPitch
			u334.Looped = true
			u334.Parent = u100
			u334:Play()
			v101.Title.Text = v330
			u102.MessageFrame.Message.Text = v331
			v332.MouseButton1Down:Connect(function()

				if u333.Text == "\240\159\148\138" then
					u333.Text = "\240\159\148\135"
					u334:Pause()
				else
					u333.Text = "\240\159\148\138"
					u334:Play()
				end
			end)
		elseif v92 == 9 then
			local u335 = u102.ScrollFrame
			local u336 = {
				["AC Server"] = "Current",
				["AG ShowResultsTo"] = "You"
			}
			local u337 = {}
			local u338 = u335["AD Target Player"]
			local v339 = u338.SearchFrame
			local u340 = v339.TextBox
			local v341 = u89.targetPlayer
			local u342 = u335["AA Space"]
			local u343 = u335["AZ Space"]
			local v344 = u335["AZ Loading"]
			local v345 = u335["AX Submit"]
			local u346 = u335["AP Question"].SearchFrame.TextBox
			local u351 = {
				u336,
				function(p347, p348, p349)

					local v350 = p349.Name
					if p347.Name == p348 then
						p347.BackgroundTransparency = 0.1
						p347.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
						u337[p349.Name] = p348
						if v350 == "AC Server" then
							if p347.Name == "Current" then
								u338.Visible = true
							else
								u338.Visible = false
							end
						end
					else
						p347.BackgroundTransparency = 0.8
						p347.TextLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
					end
				end,
				u335,
				u343,
				u342
			}
			v142(u336, u335, u340, u351, function(p352)

				if p352.Name == "AC Server" then
					u119(p352, u89.server, u351)
				elseif u336[p352.Name] then
					u119(p352, u336[p352.Name], u351)
				end
			end, nil, v341)
			local v353 = {
				["maxSuggestions"] = 3,
				["suggestionPos"] = 1,
				["suggestionDisplayed"] = 0,
				["forceExecute"] = false,
				["specificArg"] = "player",
				["mainParent"] = u102.Parent,
				["textBox"] = u340,
				["rframe"] = v339.ResultsFrame,
				["highlightColor"] = Color3.fromRGB(50, 50, 50),
				["otherColor"] = Color3.fromRGB(80, 80, 80),
				["suggestionLabels"] = {}
			}
			u2:GetModule("CmdBar"):SetupTextbox(u88, v353)
			local v354 = u89.question
			if v354 and (v354 ~= "" and v354 ~= " ") then
				u346.Text = v354
			end
			local u355 = u335["AS Answer"]
			local v356 = u335["AT AddAnswer"]
			local u357 = {}
			u355.Visible = false
			local function u363(p358) 

				for v359, v360 in pairs(u357) do
					if v360 == p358 then
						table.remove(u357, v359)
						break
					end
				end
				p358:Destroy()
				local v361 = u343
				local v362 = u342
				u335.CanvasSize = UDim2.new(0, 0, 0, v361.AbsolutePosition.Y - v362.AbsolutePosition.Y + v361.AbsoluteSize.Y)
			end
			local function u368() 

				local u364 = u355:Clone()
				u364.Visible = true
				u364.Parent = u335
				u364.RemoveBox.MouseButton1Down:Connect(function()

					u363(u364)
				end)
				local v365 = u357
				table.insert(v365, u364)
				local v366 = u343
				local v367 = u342
				u335.CanvasSize = UDim2.new(0, 0, 0, v366.AbsolutePosition.Y - v367.AbsolutePosition.Y + v366.AbsoluteSize.Y)
				return u364
			end
			local v369 = u89.answers
			if type(v369) == "table" then
				for _, v370 in pairs(v369) do
					if v370 and (v370 ~= "" and v370 ~= " ") then
						u368().SearchFrame.TextBox.Text = v370
						if #u357 >= 10 then
							break
						end
					end
				end
			end
			v356.Add.MouseButton1Down:Connect(function()

				if #u357 >= 10 then
					u2:GetModule("Notices"):Notice("Error", u2.hdAdminCoreName, "Cannot exceed " .. 10 .. " answers!")
				else
					local v371 = u368()
					u335.CanvasPosition = Vector2.new(0, u335.CanvasPosition.Y + v371.AbsoluteSize.Y)
				end
			end)
			local u372 = u335["AC VoteTime"].SearchFrame.TextBox
			local u373 = u372.Text
			u372.FocusLost:connect(function(_)

				local v374 = u372.Text
				local v375 = tonumber(v374)
				local v376
				if v375 then
					v376 = v375 < 1 and 1 or (v375 > 60 and 60 or v375)
				else
					v376 = u373
				end
				u372.Text = v376
				u373 = v376
			end)
			spawn(function()

				wait(0.1)
				local v377 = u343
				local v378 = u342
				u335.CanvasSize = UDim2.new(0, 0, 0, v377.AbsolutePosition.Y - v378.AbsolutePosition.Y + v377.AbsoluteSize.Y)
			end)
			local u379 = u100.FinalResult
			local u380 = u379.Frame.Example
			v157(u100, v345, v344, function()

				local v381 = u372.Text
				local v382 = u346.Text
				local v383 = u337["AC Server"]
				local v384 = u337["AG ShowResultsTo"]
				local v385 = u340.Text:gsub(" ", function(_)
					return ""
				end)
				local v386 = {}
				for _, v387 in pairs(u357) do
					local v388 = v387.SearchFrame.TextBox.Text
					table.insert(v386, v388)
				end
				return u2.signals.RetrievePollData:InvokeServer({
					["VoteTime"] = v381,
					["Question"] = v382,
					["Answers"] = v386,
					["Server"] = v383,
					["ShowResultsTo"] = v384,
					["PlayerArg"] = v385
				})
			end, function(p389)

				u169(u380, p389)
				u379.Visible = true
			end, function()

				return u2.signals.ExecutePoll:InvokeServer()
			end)
		elseif v92 == 10 then
			u2.audio.Notice:Play()
			local v390 = u102.ScrollFrame
			local v391 = v390.Question.TextLabel
			local u392 = v101.Title
			local u393 = u89.VoteTime
			local u394 = u393 + 1
			u169(v390, u89)
			v391.Text = u89.Question
			coroutine.wrap(function()

				for v395 = 1, u393 do
					u392.Text = u89.SenderName .. "\'s Poll (" .. u394 - v395 .. ")"
					wait(1)
				end
				u1:DestroyCommandMenuFrame(u100)
			end)()
		elseif v92 == 11 then
			u2.audio.Notice:Play()
			local v396 = u2:GetModule("cf"):RandomiseTable({
				Color3.fromRGB(220, 30, 30),
				Color3.fromRGB(220, 93, 29),
				Color3.fromRGB(188, 161, 23),
				Color3.fromRGB(107, 186, 22),
				Color3.fromRGB(19, 179, 46),
				Color3.fromRGB(20, 197, 197),
				Color3.fromRGB(24, 120, 255),
				Color3.fromRGB(101, 24, 255),
				Color3.fromRGB(217, 24, 255),
				Color3.fromRGB(255, 24, 128)
			})
			local u397 = u102.ScrollFrame
			local v398 = u397.Question.TextLabel
			local _ = v101.Title
			v398.Text = u89.Question
			local v399 = u397.ResultTemplate
			v399.Visible = false
			local v400 = #u89.Results
			for v401, u402 in pairs(u89.Results) do
				local u403 = v399:Clone()
				u403.Visible = true
				u403.Name = "Answer" .. v401
				u403.Bar.BackgroundColor3 = v396[v401]
				local u404 = v401 .. ". " .. u402.Answer .. " ("
				if v401 == v400 then
					u404 = u402.Answer .. " ("
					u403.Bar.BackgroundColor3 = Color3.fromRGB(175, 175, 175)
				end
				u403.TextLabel.Text = u404 .. "0)"
				u403.BackgroundColor3 = u1:GetLabelBackgroundColor(v401)
				u403.Bar.Size = UDim2.new(0, 0, 1, 0)
				delay((v401 - 1) / 10, function()

					local v405 = TweenInfo.new(2, Enum.EasingStyle.Quart)
					local v406 = Instance.new("IntValue")
					v406.Value = 0
					u2.tweenService:Create(u403.Bar, v405, {
						["Size"] = UDim2.new(u402.Percentage, 0, 1, 0)
					}):Play()
					u2.tweenService:Create(v406, v405, {
						["Value"] = u402.Votes
					}):Play()
					v406.Changed:Connect(function(p407)

						u403.TextLabel.Text = u404 .. p407 .. ")"
					end)
					wait(2)
					v406:Destroy()
				end)
				u403.Parent = u397
			end
			spawn(function()

				wait(0.1)
				local v408 = u397
				local v409 = u397["Answer" .. #u89.Answers]
				local v410 = u397.Question
				v408.CanvasSize = UDim2.new(0, 0, 0, v409.AbsolutePosition.Y - v410.AbsolutePosition.Y + v409.AbsoluteSize.Y)
			end)
		elseif v92 == 12 then
			local v411 = u102.ScrollFrame
			local u412 = {
				["AC Server"] = "Current"
			}
			local u413 = {}
			local u414 = v411["AD Target Player"]
			local v415 = u414.SearchFrame
			local u416 = v415.TextBox
			local v417 = u89.targetPlayer
			local v418 = v411["AA Space"]
			local v419 = v411["AZ Space"]
			local u420 = v411["AX Space"]
			local v421 = v411["AZ Loading"]
			local v422 = v411["AX Submit"]
			local u423 = v411["AG MessageTitle"].SearchFrame.TextBox
			local u424 = v411["AM Message"].SearchFrame.TextBox
			local u429 = {
				u412,
				function(p425, p426, p427)

					local v428 = p427.Name
					if p425.Name == p426 then
						p425.BackgroundTransparency = 0.1
						p425.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
						u413[p427.Name] = p426
						if v428 == "AC Server" then
							if p425.Name == "Current" then
								u414.Visible = true
								u420.Visible = false
							else
								u414.Visible = false
								u420.Visible = true
							end
						end
					else
						p425.BackgroundTransparency = 0.8
						p425.TextLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
					end
				end,
				v411,
				v419,
				v418
			}
			v142(u412, v411, u416, u429, function(p430)

				if p430.Name == "AC Server" then
					u119(p430, u89.server, u429)
				elseif u412[p430.Name] then
					u119(p430, u412[p430.Name], u429)
				end
			end, nil, v417)
			local v431 = {
				["maxSuggestions"] = 3,
				["suggestionPos"] = 1,
				["suggestionDisplayed"] = 0,
				["forceExecute"] = false,
				["specificArg"] = "player",
				["mainParent"] = u102.Parent,
				["textBox"] = u416,
				["rframe"] = v415.ResultsFrame,
				["highlightColor"] = Color3.fromRGB(50, 50, 50),
				["otherColor"] = Color3.fromRGB(80, 80, 80),
				["suggestionLabels"] = {}
			}
			u2:GetModule("CmdBar"):SetupTextbox(u88, v431)
			local v432 = u89.message
			if v432 and (v432 ~= "" and v432 ~= " ") then
				u424.Text = v432
			end
			u423.Text = "Alert from " .. u2.player.Name
			local u433 = u100.FinalResult
			local u434 = u433.Frame.Example
			v157(u100, v422, v421, function()

				local v435 = {
					["Title"] = u423.Text,
					["Message"] = u424.Text,
					["Server"] = u413["AC Server"],
					["PlayerArg"] = u416.Text:gsub(" ", function(_)
						return ""
					end)
				}
				return u2.signals.RetrieveAlertData:InvokeServer(v435)
			end, function(p436)

				u434.Title.Text = p436.Title
				u434.Message.Text = p436.Message
				u433.Visible = true
			end, function()

				return u2.signals.ExecuteAlert:InvokeServer()
			end)
		elseif v92 == 13 then
			local u437 = u102.LinkFrame.TextBox
			local u438 = tostring(u89)
			local u439 = "roblox.com/game-pass/" .. u438
			local u440 = nil
			local u441 = nil
			local v442 = u102.MessageFrame.ImageLabel
			local u443 = v101.Title
			task.defer(function()

				local _, v444 = pcall(function()

					return u2.marketplaceService:GetProductInfo(u438, Enum.InfoType.GamePass).Name
				end)
				u443.Text = ("Unlock %*"):format(v444)
			end)
			u437.PlaceholderText = u439
			u437.Text = u439
			v442.Image = ("rbxthumb://type=GamePass&id=%*&w=150&h=150"):format(u438)
			u440 = u100:GetPropertyChangedSignal("Visible"):Connect(function()

				if not u100.Visible then
					u440:Disconnect()
					u441:Disconnect()
				end
			end)
			u441 = u437:GetPropertyChangedSignal("Text"):Connect(function()

				u437.Text = u439
			end)
		elseif v92 == 14 then
			u100.ClickAway.MouseButton1Click:Once(function()

				u1:DestroyCommandMenuFrame(u100)
			end)
		elseif v92 == 15 then
			u100.ClickAway.MouseButton1Click:Once(function()

				u1:DestroyCommandMenuFrame(u100)
			end)
		elseif v92 == 16 then
			u100.ZIndex = u100.ZIndex + 10
			u100.Position = u2.gui.MainFrame.Position
			u100:SetAttribute("AlsoDragMainFrame", true)
			local u445 = nil
			for _, v446 in u2.commandInfo do
				if v446 and v446.Name == "emote" then
					u445 = v446
					break
				end
			end
			if not u445 then
				return
			end
			local u447 = u100.MainFrame.ScrollFrame
			local v448 = u2:GetModule("cf"):GetEmotes()
			local _ = u2.gui.MainFrame.Pages
			local u449 = u2:GetModule("PageCommands"):GetCommandTemplate()
			local u450 = nil
			local v451 = u2.pdata.Prefix or ";"
			local u452 = u449:Clone()
			u452.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
			u452.TextLabel.Position = UDim2.new(0.04, 0, 0.5, 0)
			u452.Arrow:Destroy()
			u452.LayoutOrder = -1
			u452.TextLabel.Text = ("Type %*emotes to view"):format(v451)
			u452.Name = "TopLabel"
			u452.Visible = true
			u452.Parent = u447
			local u453 = {}
			local u454 = {}
			local u455 = {}
			local function u462(p456) 

				local v457 = p456.id
				local v458 = tostring(v457)
				local v459 = p456.name
				local v460 = u449:Clone()
				local v461 = u455
				table.insert(v461, v458)
				v460.LayoutOrder = #u455
				u453[v458] = v460
				u454[v458] = p456
				u1:SetupUnlockUGC(v457, v460.UnlockUGC)
				u1:SetupFavoriteUGC(v457, v460.FavoriteUGC)
				v460.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				v460.RunCommand.Visible = true
				v460.RunIcon.Visible = true
				v460.PendingIcon.Visible = true
				v460.Expand.Visible = false
				v460.Arrow.Visible = false
				u2:GetModule("PageCommands"):SetupUICommandRunner(v460, u445, " me " .. v459)
				v460.TextLabel.Text = v459
				v460.Name = v459
				v460.Visible = true
				v460.Parent = u447
				u450 = v460
			end
			local function u475() 

				local u463 = u2.pdata.FavoritedUGC or {}
				table.sort(u455, function(p464, p465)

					local v466 = u463[p464]
					local v467 = u463[p465]
					if v466 and v467 then
						return (v466.addedTime or 0) > (v467.addedTime or 0)
					end
					if v466 or v467 then
						if v466 then
							v466 = not v467
						end
						return v466
					end
					local v468 = u453[p464]
					local v469 = u453[p465]
					return v468.LayoutOrder < v469.LayoutOrder
				end)
				local v470 = 0
				for _, v471 in u455 do
					local v472 = u453[v471]
					v470 = v470 + 1
					v472.LayoutOrder = v470
					v472.BackgroundColor3 = u2:GetModule("cf"):GetLabelBackgroundColor(v470)
					u450 = v472
				end
				local v473 = u450
				local v474 = u452
				u447.CanvasSize = UDim2.new(0, 0, 0, v473.AbsolutePosition.Y - v474.AbsolutePosition.Y + v473.AbsoluteSize.Y)
			end
			for v476, v477 in v448 do
				u462(v477, v476)
			end
			u475()
			local u481 = u6:Connect(function(p478, p479)

				if p479 and not u453[tostring(p478)] then
					local v480 = u1:GetNameFromEmoteId(p478)
					u462({
						["id"] = tonumber(p478),
						["name"] = v480
					})
				end
				task.defer(u475)
			end)
			u100.Destroying:Once(function()

				u481:Disconnect()
			end)
			task.delay(0.1, function()

				local v482 = u450
				local v483 = u452
				u447.CanvasSize = UDim2.new(0, 0, 0, v482.AbsolutePosition.Y - v483.AbsolutePosition.Y + v482.AbsoluteSize.Y)
			end)
		elseif v92 == 18 then
			u100.ClickAway.MouseButton1Click:Once(function()

				u1:DestroyCommandMenuFrame(u100)
			end)
			local v484 = u102.Unlock
			local u485 = u89[1]
			local u486 = false
			v484.MouseButton1Click:Connect(function()

				if not u486 then
					u486 = true
					u2.signals.PurchaseAccessory:FireServer(u485)
					task.delay(1, function()

						u486 = false
					end)
				end
			end)
			local v487 = u1:GetNameFromEmoteId(u485)
			local v488 = u2:GetModule("cf"):GetAnimationId(u485)
			local v489 = u2:GetModule("cf"):denormalizeName(v487)
			local v490 = u102.ViewportFrame
			u102.Title.Text = v489
			u1:SetupAnimatedRig(v490, v488)
		end
		u13(u100, p91)
		local v491 = u2.commandMenus
		local v492 = u100
		table.insert(v491, v492)
		u18(u2.commandMenus)
		v97 = u100
	end
	v97.Parent = u2.gui
	v97.Visible = true
end
function u1.RegisterEmoteId(_, p493) 

	u6:Fire(p493, true)
end
function u1.GetNameFromEmoteId(_, p494) 

	local v495 = u2:GetModule("cf"):GetEmotes()
	local v496 = tonumber(p494)
	local v497 = "unknown"
	for _, v498 in v495 do
		local v499 = v498.id
		if tonumber(v499) == v496 then
			return v498.name
		end
	end
	return v497
end
local u500 = false
function u1.SetupFavoriteUGC(_, u501, u502) 

	u502.Visible = true
	local u503 = tostring(u501)
	local u504 = game:GetService("AvatarEditorService")
	local u505 = (u2.pdata.FavoritedUGC or {})[u503] == nil
	local function u511(p506) 

		local v507 = u1:GetNameFromEmoteId(u501)
		local v508 = ("Removed \'%*\' %* from favorites"):format(v507, u501)
		local v509 = not u505
		local v510
		if v509 then
			v508 = ("Added \'%*\' %* to favorites"):format(v507, u501)
			v510 = 101602995984924
		else
			v510 = 117947994309914
		end
		if u502.Parent then
			u502.ImageLabel.Image = "rbxassetid://" .. v510
		end
		if p506 then
			u6:Fire(u501, v509)
			u2:GetModule("Notices"):Notice("Notice", u2.hdAdminCoreName, v508, { "CallFunctionWithTime", 3 })
		end
	end
	local u514 = u6:Connect(function(p512, p513)

		if p512 == u501 then
			u505 = not p513
			u511()
		end
	end)
	u502.Destroying:Once(function()

		u514:Disconnect()
	end)
	u511()
	local function u524(u515, u516, u517) 

		local v519, v521, v521 = pcall(function()

			local v518 = { u515, u516, u517 }
			return u2.signals.FavoriteUGC:InvokeServer(v518)
		end)
		local v522
		if v519 then
			v522 = v521
		else
			v522 = false
		end
		if not v522 then
			u2:GetModule("Notices"):Notice("Error", u2.hdAdminCoreName, (tostring(v521)))
			u500 = false
		end
		if v519 and (v522 and u517) then
			local v523 = u2.pdata.FavoritedUGC
			if typeof(v521) == "table" then
				v523[u503] = v521
			end
		end
		return v522, v521
	end
	return u502.MouseButton1Click:Connect(function()

		if u500 then
			return
		else
			local v527 = u504.PromptSetFavoriteCompleted:Once(function(p525)

				if p525 ~= Enum.AvatarPromptResult.PermissionDenied then
					local v526 = u505
					u505 = not u505
					u524(u501, v526, true)
					u511(true)
				end
				u500 = false
			end)
			u500 = true
			if u524(u501, u505, false) then
				u504:PromptSetFavorite(u501, Enum.AvatarItemType.Asset, u505)
			else
				v527:Disconnect()
			end
		end
	end)
end
function u1.SetupUnlockUGC(_, u528, p529) 

	local u530 = false
	p529.Visible = true
	return p529.MouseButton1Click:Connect(function()

		if not u530 then
			u530 = true
			task.delay(1, function()

				u530 = false
			end)
			local v531 = { u528 }
			u2:GetModule("cf"):CreateNewCommandMenu("Unlock", v531, 18, true)
		end
	end)
end
function u1.GetMousePoint(_, _) 

	local v532 = u2.camera:ScreenPointToRay(u2.lastHitPosition.X, u2.lastHitPosition.Y)
	local v533 = Ray.new(v532.Origin, v532.Direction * 100)
	local v534, v535 = workspace:FindPartOnRay(v533, u2.player.Character)
	return v534, v535
end
function u1.GetLabelBackgroundColor(_, p536) 
	if p536 % 2 == 0 then
		return Color3.fromRGB(50, 50, 50)
	else
		return Color3.fromRGB(40, 40, 40)
	end
end
function u1.GenerateTagFromId(_, p537) 

	local v538 = u2.alphabet
	local v539 = #v538
	local v540 = p537 / #v538
	local v541 = math.ceil(v540)
	local v542 = p537 / (#v538) ^ 2
	local v543 = math.ceil(v542)
	local v544 = v538[p537 % v539] or v538[v539]
	local v545 = v538[v541 % v539] or v538[v539]
	return (v538[v543 % v539] or v538[v539]) .. v545 .. v544
end
function u1.ClearPage(_, p546) 
	for _, v547 in pairs(p546:GetChildren()) do
		if v547.Name == "UIListLayout" then
			::l4::
			if v547:IsA("Frame") then
				v547.Visible = false
			end
		else
			local v548 = v547.Name
			if string.sub(v548, 1, 8) == "Template" then
				goto l4
			end
			v547:Destroy()
		end
	end
end
function u1.UpdateClientData(_) 

	u2.pdata = u2.rfunction:InvokeServer("RetrievePlayerData")
end
function u1.SetupAnimatedRig(_, p549, p550) 

	local v551 = p549:FindFirstChild("ViewportCamera")
	if not v551 then
		v551 = Instance.new("Camera")
		v551.Name = "ViewportCamera"
		v551.Parent = p549
		p549.CurrentCamera = v551
	end
	local v552 = p549.ViewportWorldModel
	local u553 = u2.client.Assets.BlockyR15:Clone()
	local u554 = u553.Humanoid
	local v555 = u553.HumanoidRootPart
	local v556 = CFrame.Angles(0, 3.141592653589793, 0)
	local v557 = CFrame.new(0, -0.4, 15.75)
	v551.FieldOfView = 20
	v551.CFrame = v555.CFrame * v556 * v557
	u553.Parent = v552
	task.defer(function()

		pcall(function()

			u553.Humanoid:ApplyDescription(u2.player.Character.Humanoid:GetAppliedDescription(), Enum.AssetTypeVerification.Always)
		end)
	end)
	local u558 = Instance.new("Animation")
	u558.AnimationId = "rbxassetid://" .. p550
	u558.Parent = p549
	local u559 = nil
	local u560 = true
	local function v562(u561) 

		task.spawn(function()

			while not u559 and u560 == true do
				task.wait()
			end
			if u560 then
				u561(u559)
			end
		end)
	end
	task.defer(function()

		local v563, v564 = pcall(function()

			return u554.Animator:LoadAnimation(u558)
		end)
		u560 = v563
		u559 = v564
		if u560 then
			u559.Looped = true
			u559:Play()
		end
	end)
	return u553, v562
end
return u1