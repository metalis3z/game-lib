

local u1 = {}
local u2 = _G.HDAdminMain
u1.cmdbarToggled = u2:GetModule("Signal").new()
u1.isOpen = false
local u3 = u2.gui.CustomTopBar
local u4 = { "Chat", "PlayerList" }
local u5 = {}
local u6 = u2.gui.CmdBar
local u7 = false
local u8 = {}
local u9 = 1
local u10 = true
local u11 = {
	["maxSuggestions"] = 5,
	["suggestionPos"] = 1,
	["suggestionDisplayed"] = 0,
	["forceExecute"] = false,
	["mainParent"] = u6,
	["textBox"] = u6.SearchFrame.TextBox,
	["rframe"] = u6.ResultsFrame,
	["highlightColor"] = Color3.fromRGB(50, 50, 50),
	["otherColor"] = Color3.fromRGB(80, 80, 80),
	["suggestionLabels"] = {}
}
local function u24(u12) 

	local v13 = ""
	local u14 = u12.suggestionLabels["Label" .. u12.suggestionPos]
	if u12.specificArg then
		local v15 = u14.Name .. " "
		u12.textBox.Text = v15
		coroutine.wrap(function()

			for _ = 1, 10 do
				u12.textBox:ReleaseFocus()
				wait()
			end
		end)()
		wait()
		u12.textBox.Text = v15
	else
		local u16 = {}
		local u17 = -1
		local v18 = u12.textBox.Text
		local v19 = string.sub(v18, 1, 1)
		u12.textBox.Text:gsub("([^" .. u2.pdata.SplitKey .. "]+)", function(p20)

			u17 = u17 + 1
			if u17 <= u14.ArgPos - 1 then
				local v21 = u16
				local v22 = p20 .. " "
				table.insert(v21, v22)
			end
		end)
		if u17 ~= 0 or v19 ~= u2.settings.UniversalPrefix and (v19 ~= u2.settings.ChatPrefix and v19 ~= u2.pdata.Prefix) then
			v19 = v13
		end
		local v23 = ((v19 .. table.concat(u16, "")) .. u14.Name) .. u2.pdata.SplitKey
		u12.textBox.Text = v23
		wait()
		u12.textBox.Text = v23
		u12.textBox.CursorPosition = #v23 + 1
	end
end
u6.Visible = false
local function u28(u25) 

	for u26 = 1, u25.maxSuggestions do
		local v27 = u25.rframe.LabelTemplate:Clone()
		v27.Name = "Label" .. u26
		v27.Visible = false
		v27.Parent = u25.rframe
		v27.MouseEnter:Connect(function()

			u25.suggestionPos = u26
		end)
		v27.MouseButton1Up:Connect(function()

			u25.suggestionPos = u26
			u24(u25)
		end)
	end
end
function u1.SetupTextbox(_, p29, u30) 

	local function u37(p31, p32, p33, p34) 

		local v35 = string.lower(p34)
		local v36 = #p32
		if string.sub(v35, 1, v36) == p32 then
			table.insert(p31, {
				["Name"] = p34,
				["ArgPos"] = p33
			})
			if #p31 == u30.maxSuggestions then
				return true
			end
		end
	end
	local u38 = u30.specificArg
	u8[p29] = u30
	u28(u30)
	u30.textBox.FocusLost:connect(function(p39)

		if u30.mainParent.Name == "CmdBar" and not u30.specificArg then
			if u30.suggestionDisplayed > 0 and (not forceExecute and u2.device ~= "Mobile") then
				u24(u30)
				return
			end
			if p39 then
				if forceExecute then
					u24(u30)
				end
				u1:CloseCmdBar()
				if #u30.textBox.Text > 1 then
					local v40 = u30.textBox.Text
					local v41 = string.sub(v40, 1, 1)
					if v41 ~= u2.settings.UniversalPrefix and (v41 ~= u2.settings.ChatPrefix and v41 ~= u2.pdata.Prefix) then
						v40 = u2.pdata.Prefix .. v40
					end
					if string.sub(v40, -1) == " " then
						v40 = string.sub(v40, 1, -1)
					end
					u2.signals.RequestCommandSilent:InvokeServer(v40)
				end
			end
		elseif u30.suggestionDisplayed > 0 then
			u24(u30, u30.specificArg)
			return
		end
	end)
	local u42 = nil
	u30.textBox.Changed:connect(function(p43)

		local v44 = u30.textBox.Text
		local v45 = string.sub(v44, 1, 1)
		if u38 or (v45 == u2.settings.UniversalPrefix or (v45 == u2.settings.ChatPrefix or v45 == u2.pdata.Prefix)) then
			if p43 == "Text" then
				local u46 = -1
				local u47 = nil
				local u48 = {}
				if u38 then
					local v49 = u30.textBox.Text
					table.insert(u48, v49)
					u46 = 1
				else
					u30.textBox.Text:gsub("([^" .. u2.pdata.SplitKey .. "]+)", function(p50)

						u46 = u46 + 1
						if u46 == 0 then
							u47 = p50
						elseif u46 > 0 then
							local v51 = u48
							table.insert(v51, p50)
						end
					end)
					if u46 > 0 and not u30.currentBarCommand then
						local v52 = string.sub(u47, 1, 1)
						if v52 == u2.settings.UniversalPrefix or (v52 == u2.settings.ChatPrefix or v52 == u2.pdata.Prefix) then
							u47 = string.sub(u47, 2)
						end
						u47 = string.lower(u47)
						for _, v53 in pairs(u2.commandInfo) do
							if string.lower(v53.Name) == u47 then
								u30.currentBarCommand = v53
							elseif v53.Aliases then
								for _, v54 in pairs(v53.Aliases) do
									if string.lower(v54) == u47 then
										u30.currentBarCommand = v53
									end
								end
							end
						end
					elseif u46 <= 0 then
						u30.currentBarCommand = nil
					end
				end
				local u55 = {}
				u30.suggestionPos = 1
				if #u30.textBox.Text > 1 or u38 and #u30.textBox.Text > 0 then
					if u46 == 0 then
						local v56 = string.lower
						local v57 = u30.textBox.Text
						local u58 = v56((string.sub(v57, 2)))
						local v59 = string.lower
						local v60 = u30.textBox.Text
						v59((string.sub(v60, 1, 1)))
						for _, u61 in pairs(u2.commandInfo) do
							if not u61.IsBooster then
								local v62 = string.lower(u61.Name)
								local _ = u61.Prefixes[1]
								local v63 = #u58
								local v64 = string.sub(v62, 1, v63) == u58
								if v64 or v62:match(u58) then
									local v65 = {
										["ArgPos"] = 0,
										["ExactMatchStart"] = v64,
										["Name"] = u61.Name,
										["Args"] = u61.Args,
										["Prefixes"] = u61.Prefixes
									}
									table.insert(u55, v65)
								end
								local v66 = u61.UnFunction
								if v66 then
									local v67 = string.lower(v66)
									local v68 = #u58
									local v69 = string.sub(v67, 1, v68) == u58
									if v69 or v66:match(u58) then
										local v70 = {
											["ArgPos"] = 0,
											["ExactMatchStart"] = v69,
											["Name"] = v66,
											["Args"] = {},
											["Prefixes"] = u61.Prefixes
										}
										table.insert(u55, v70)
									end
								end
								local function v79(p71) 

									local v72 = u61[p71]
									if v72 then
										for _, v73 in pairs(v72) do
											local v74 = string.lower(v73)
											local v75 = #u58
											local v76 = string.sub(v74, 1, v75) == u58
											if v76 or v73:match(u58) then
												local v77 = u55
												local v78 = {
													["ArgPos"] = 0,
													["ExactMatchStart"] = v76,
													["Name"] = v73,
													["Args"] = {},
													["Prefixes"] = u61.Prefixes
												}
												table.insert(v77, v78)
											end
										end
									end
								end
								v79("Aliases")
								v79("UndoAliases")
							end
						end
					elseif u30.currentBarCommand or u38 then
						local v80
						if u38 then
							v80 = u38
						else
							v80 = u30.currentBarCommand.Args[u46]
						end
						local v81 = string.lower(u48[u46])
						local v82 = u30.textBox.Text
						local v83 = string.sub(v82, -1)
						if v83 ~= " " and v83 ~= u2.pdata.SplitKey then
							if v80 == "player" or v80 == "playerarg" then
								for _, v84 in pairs(u2.qualifiers) do
									if u37(u55, v81, u46, v84) then
										break
									end
								end
								for _, v85 in pairs(u2.players:GetChildren()) do
									if u37(u55, v81, u46, v85.Name) then
										break
									end
								end
							elseif v80 == "colour" or (v80 == "color" or v80 == "color3") then
								for _, v86 in pairs(u2.colors) do
									if u37(u55, v81, u46, v86) then
										break
									end
								end
							elseif v80 == "material" then
								for _, v87 in pairs(u2.materials) do
									if u37(u55, v81, u46, v87) then
										break
									end
								end
							elseif v80 == "rank" then
								for _, v88 in pairs(u2.settings.Ranks) do
									if u37(u55, v81, u46, v88[2]) then
										break
									end
								end
							elseif v80 == "team" or v80 == "teamcolor" then
								for _, v89 in pairs(u2.teams:GetChildren()) do
									if u37(u55, v81, u46, v89.Name) then
										break
									end
								end
							elseif v80 == "morph" then
								for v90, _ in pairs(u2.morphNames) do
									if u37(u55, v81, u46, v90) then
										break
									end
								end
							elseif v80 == "tools" or (v80 == "gears" or (v80 == "tool" or v80 == "gear")) then
								for v91, _ in pairs(u2.toolNames) do
									if u37(u55, v81, u46, v91) then
										break
									end
								end
							end
						end
					end
				end
				table.sort(u55, function(p92, p93)
					local v94 = p92.ExactMatchStart
					local v95 = p93.ExactMatchStart
					if v94 and not v95 then
						return true
					elseif v95 and not v94 then
						return false
					else
						local v96 = p92.Name
						local v97 = p93.Name
						local v98 = v96 and (#v96 or 0) or 0
						local v99 = v97 and (#v97 or 0) or 0
						if v96 and (v97 and v98 == v99) then
							return v96:lower() < v97:lower()
						else
							return v98 < v99
						end
					end
				end)
				u30.suggestionDisplayed = #u55
				if u30.currentBarCommand and (#u30.currentBarCommand.Args == u46 and u30.suggestionDisplayed > 0) then
					forceExecute = true
				else
					forceExecute = false
				end
				for v100 = 1, u30.maxSuggestions do
					local v101 = u55[v100]
					local v102 = u30.rframe:FindFirstChild("Label" .. v100)
					if v102 then
						if v101 then
							local v103 = v101.Args and true or false
							local v104 = v103 and (v101.Prefixes[1] == u2.settings.UniversalPrefix or v101.Prefixes[1] == u2.settings.ChatPrefix) and true or false
							local v105 = {}
							if v103 then
								for _, v106 in pairs(v101.Args) do
									if not v104 or (v106 ~= "player" or v106 == "playerarg") then
										local v107 = "<" .. v106 .. ">"
										table.insert(v105, v107)
									end
								end
							end
							v102.TextLabel.Text = v101.Name .. " " .. table.concat(v105, " ")
							if v100 == u30.suggestionPos then
								v102.BackgroundColor3 = u30.highlightColor
							else
								v102.BackgroundColor3 = u30.otherColor
							end
							u30.suggestionLabels["Label" .. v100] = v101
							if u30.mainParent.Name ~= "CmdBar" then
								local v108 = u30.rframe.LabelTemplate.AbsoluteSize.Y
								local v109 = v108 * v100
								local v110 = u30.rframe.AbsolutePosition.Y + v109
								if u2.gui.Notices.AbsoluteSize.Y < v110 + 5 then
									if not u42 then
										u42 = u30.mainParent.Position
									end
									u30.mainParent.Position = u30.mainParent.Position - UDim2.new(0, 0, 0, v108)
								end
							end
							v102.Visible = true
						else
							v102.Visible = false
						end
					end
				end
				if u42 and #u55 < 1 then
					u30.mainParent.Position = u42
					u42 = nil
				end
				if #u55 < 1 and u30.mainParent.Name ~= "CmdBar" then
					u30.mainParent.ClipsDescendants = true
				else
					u30.mainParent.ClipsDescendants = false
				end
			end
		else
			u30.textBox.Text = u2.pdata.Prefix
			if u30.textBox.CursorPosition < 2 then
				u30.textBox.CursorPosition = 2
			end
		end
	end)
end
u1:SetupTextbox("cmdbar1", u11)
function u1.ToggleBar(_, p111) 

	if p111 == Enum.KeyCode.Quote then
		if u2.gui.CmdBar.Visible then
			u2:GetModule("CmdBar"):CloseCmdBar()
		else
			u2:GetModule("CmdBar"):OpenCmdBar()
		end
	else
		if p111 == Enum.KeyCode.Semicolon then
			local v112 = u2.settings.Cmdbar2
			if u2.pdata.Rank > 0 or v112 <= 0 then
				if u2.pdata.Rank < v112 then
					local v113 = u2:GetModule("cf"):FormatNotice("CommandBarLocked", "2", u2:GetModule("cf"):GetRankName(v112))
					u2:GetModule("Notices"):Notice("Error", v113[1], v113[2])
					return
				end
				local v114 = u8.cmdbar2
				if not v114 then
					u2:GetModule("ClientCommands").cmdbar2.Function()
					return
				end
				if v114.mainParent.Visible then
					v114.mainParent.Visible = false
					return
				end
				v114.mainParent.Visible = true
			end
		end
		return
	end
end
function u1.OpenCmdBar(_) 

	local u115 = u11
	local v116 = u2.settings.Cmdbar
	if (u2.pdata.Rank > 0 or v116 <= 0) and not u7 then
		u7 = true
		if u2.pdata.Rank >= v116 then
			local u117 = u2:GetModule("cf"):GetHumanoid()
			if u117 then
				u117 = u117.MoveDirection.Magnitude > 0
			end
			task.defer(function()

				u115.textBox.TextEditable = true
				for _ = 1, 5 do
					if u117 then
						u115.textBox:ReleaseFocus()
					else
						u115.textBox:CaptureFocus()
					end
					task.wait(0.03)
				end
			end)
			u1.isOpen = true
			u1.cmdbarToggled:Fire(true)
			for _, v118 in pairs(u4) do
				u5[v118] = u2.starterGui:GetCoreGuiEnabled(v118)
				u2.starterGui:SetCoreGuiEnabled(Enum.CoreGuiType[v118], false)
			end
			u3.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			u9 = u3.BackgroundTransparency
			u10 = u3.Visible
			u3.BackgroundTransparency = 0
			u3.Visible = true
			u115.textBox.Text = ""
			u6.Visible = true
			wait()
			u115.textBox.Text = u2.pdata.Prefix
			u115.textBox.CursorPosition = 3
			return true
		end
		local v119 = u2:GetModule("cf"):FormatNotice("CommandBarLocked", "", u2:GetModule("cf"):GetRankName(v116))
		u2:GetModule("Notices"):Notice("Error", v119[1], v119[2])
	end
	return false
end
function u1.CloseCmdBar(_) 

	if u7 then
		u7 = false
		local u120 = u11
		task.defer(function()

			for _ = 1, 5 do
				u120.textBox:ReleaseFocus()
				task.wait(0.02)
			end
			u120.textBox.TextEditable = false
		end)
		u6.Visible = false
		for _, v121 in pairs(u4) do
			local v122 = u5[v121]
			if v122 then
				u2.starterGui:SetCoreGuiEnabled(Enum.CoreGuiType[v121], v122)
			end
		end
		u1.isOpen = false
		u1.cmdbarToggled:Fire(false)
		u3.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
		u3.BackgroundTransparency = u9
		u3.Visible = u10
	end
end
function u1.PressedArrowKey(_, p123) 

	for _, v124 in pairs(u8) do
		if v124.mainParent.Visible and v124.textBox:IsFocused() then
			local v125 = v124.rframe:FindFirstChild("Label" .. v124.suggestionPos)
			if p123 == Enum.KeyCode.Down then
				v124.suggestionPos = v124.suggestionPos + 1
				if v124.suggestionPos > v124.suggestionDisplayed then
					v124.suggestionPos = 1
				end
			elseif p123 == Enum.KeyCode.Up then
				v124.suggestionPos = v124.suggestionPos - 1
				if v124.suggestionPos < 1 then
					v124.suggestionPos = v124.suggestionDisplayed
				end
			elseif p123 == Enum.KeyCode.Right then
				u24(v124)
			end
			local v126 = v124.rframe["Label" .. v124.suggestionPos]
			if v126 ~= v125 then
				v125.BackgroundColor3 = v124.otherColor
				v126.BackgroundColor3 = v124.highlightColor
			end
		end
	end
end
return u1