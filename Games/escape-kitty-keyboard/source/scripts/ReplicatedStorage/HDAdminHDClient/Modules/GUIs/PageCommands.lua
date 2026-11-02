

local u1 = {}
local u2 = _G.HDAdminMain
local v3 = u2.gui.MainFrame.Pages
local u4 = v3.Commands
local u5 = {
	["commands"] = u4.Commands,
	["morphs"] = u4.Morphs,
	["details"] = v3.About.Details
}
local u6 = u5.commands.TemplateOne
local u7 = u5.commands.TemplateTwo
local u8 = u5.commands.TemplateGamepass
local u9 = u5.morphs.Template
local u10 = {
	"Aliases",
	"Undo",
	"Desc",
	"Rank",
	"Loop",
	"Tags"
}
local u11 = {
	"Aliases",
	"UnFunction",
	"Description",
	"Rank",
	"Loopable",
	"Tags",
	"Contributors"
}
local v12 = u4.SearchBar.Frame
local u13 = v12.TextBox
local u14 = v12.CancelButton
u14.MouseButton1Click:Connect(function()

	u13.Text = ""
	local v15 = u13.Text
	local v16 = u14
	local v17
	if v15 == "" then
		v17 = false
	else
		v17 = v15 ~= " "
	end
	v16.Visible = v17
	task.spawn(function()

		local v18 = u5.commands
		u1["Create" .. v18.Name]()
		v18.CanvasPosition = Vector2.new(0, 0)
	end)
end)
u13:GetPropertyChangedSignal("Text"):Connect(function() 

	local v19 = u13.Text
	local v20 = u14
	local v21
	if v19 == "" then
		v21 = false
	else
		v21 = v19 ~= " "
	end
	v20.Visible = v21
end)
u13.FocusLost:Connect(function(p22)

	if not p22 then
		task.wait(0.1)
	end
	task.spawn(function()

		local v23 = u5.commands
		u1["Create" .. v23.Name]()
		v23.CanvasPosition = Vector2.new(0, 0)
	end)
end)
function u1.SetSearchText(_, p24) 

	u13.Text = p24
	local v25 = u13.Text
	local v26 = u14
	local v27
	if v25 == "" then
		v27 = false
	else
		v27 = v25 ~= " "
	end
	v26.Visible = v27
	task.spawn(function()

		local v28 = u5.commands
		u1["Create" .. v28.Name]()
		v28.CanvasPosition = Vector2.new(0, 0)
	end)
end
function u1.GetSearchText(_, _) 

	return u13.Text
end
function u1.GetCommandTemplate(_) 

	return u6, u9
end
local u29 = false
local u30 = false
local u31 = u2:GetModule("Signal").new()
local u32 = TweenInfo.new(0.2, Enum.EasingStyle.Circular)
local u33 = {}
local u34 = false
local function u56(p35) 

	local v36 = {}
	local v37 = nil
	if p35 then
		if u34 then
			return
		else
			u34 = true
			for v40, v39 in p35 do
				v39._pos = v40
				if v39.SortRandomToTop then
					if v37 ~= nil then
						local v40 = v37
					end
					table.insert(v36, v39)
					v37 = v40
				end
			end
			if v37 then
				local v41 = u2.player.UserId
				local v42 = os.time() / 43200
				local v43 = math.floor(v42) * v41
				u2:GetModule("cf"):SetSeed(v43)
				local v44 = v36[math.random(1, #v36)].Name
				local u45 = tostring(v44):lower()
				table.sort(p35, function(p46, p47)

					local v48 = p46.Override
					local v49 = p47.Override
					local v50 = v48 and v48:sub(2) or p46.Name
					local v51 = v49 and v49:sub(2) or p47.Name
					local v52 = tostring(v50):lower()
					local v53 = tostring(v51):lower()
					local v54 = p46.SortRandomToTop or p46.EmoteId
					local v55 = p47.SortRandomToTop or p47.EmoteId
					if v52 == u45 and v55 then
						return true
					elseif v53 == u45 and v54 then
						return false
					else
						return (p46._pos or 9999) < (p47._pos or 9999)
					end
				end)
			end
		end
	else
		return
	end
end
function u1.UpdateRunCommandIndicator(_, p57, p58) 

	local v59 = p58 or {}
	local v60 = nil
	for v61, v62 in pairs(u33) do
		if v61.Name == p57 then
			v60 = v62
		end
		local v63 = v61.Groups
		if v63 then
			for _, v64 in pairs(v59) do
				if table.find(v63, v64) then
					v61.ShowRevoke = nil
					v60 = v62
					break
				end
			end
		end
	end
	if v60 then
		v60(nil, true)
	end
end
local u65 = 0
function u1.SetupCommands(_, p66, u67, p68) 

	local v69 = u2.pdata.Rank or 0
	u65 = u65 + 1
	local v70 = u65
	local v71 = u6.TextLabel.TextBounds.Y
	for v72, u73 in p66 do
		if v72 % 20 == 0 then
			task.wait()
		end
		if u65 ~= v70 then
			return
		end
		local v74 = u73.Name
		local v75 = u73.Override
		if v75 then
			v74 = v75:sub(2)
		end
		local v76 = u73.Rank or 5
		p68 = p68 + 1
		local u77
		if u67.Name == "Buy" then
			u77 = "AE Command" .. p68
		else
			u77 = u2:GetModule("cf"):GenerateTagFromId(p68)
		end
		local u78 = u6:Clone()
		u78.BackgroundColor3 = u2:GetModule("cf"):GetLabelBackgroundColor(v72)
		u78.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		local u79 = false
		local v80 = u73.Prefixes
		if v80 and (v80[1] == u2.settings.UniversalPrefix or v80[1] == u2.settings.ChatPrefix) then
			u78.TextLabel.Text = u2.settings.ChatPrefix .. v74
			u79 = true
		else
			u78.TextLabel.Text = u2.pdata.Prefix .. v74
		end
		local v81 = u78.TextLabel
		local v82 = u2.textService:GetTextSize(v81.Text, v71, Enum.Font.Roboto, v81.AbsoluteSize)
		task.defer(function()

			local v83 = u73.EmoteId
			if u73.IsBooster and v83 then
				local v84 = u2:GetModule("cf")
				if v84:GetEmotesDict()[tostring(v83)] then
					v84:SetupUnlockUGC(v83, u78.UnlockUGC)
					v84:SetupFavoriteUGC(v83, u78.FavoriteUGC)
				end
			end
		end)
		if u73.SpecialColor then
			local v85 = u73.OriginalName
			local v86 = ("<font color=\"#%*\">%*</font>"):format(u73.SpecialColor:ToHex(), u73.SpecialColorName)
			v81.RichText = true
			v81.Text = v85 .. v86
		end
		local v87 = v81:Clone()
		v87.Position = v81.Position + UDim2.new(0, v82.X + 5, 0, 0)
		v87.TextColor3 = Color3.fromRGB(175, 175, 175)
		v87.Name = "DetailsLabel"
		local v88 = {}
		for _, v89 in pairs(u73.Args) do
			if (not u73.IsBooster or v89 ~= "player") and v89 ~= "details" then
				local v90 = "<" .. (v89 == "playerarg" and "player" or (v89 == "userid" and "userId/username" or v89)) .. ">"
				table.insert(v88, v90)
			end
		end
		v87.Text = u73.IsBooster and "" or table.concat(v88, "  ")
		v87.Parent = u78
		u78.Name = u77
		u78.Arrow.Rotation = 90
		u78.Visible = true
		local u91 = {}
		local function u121() 

			if #u91 > 0 then
				u67.CanvasSize = u67.CanvasSize - UDim2.new(0, 0, 0, #u91 * u7.AbsoluteSize.Y)
				for _, v92 in pairs(u91) do
					v92:Destroy()
				end
				u91 = {}
			end
			if u78.Arrow.Rotation == 90 then
				local v93 = u78.Arrow
				u2.tweenService:Create(v93, u32, {
					["Rotation"] = 0
				}):Play()
				local v94 = u73.UndoAliases
				local v95 = 0
				for v96, v97 in pairs(u10) do
					local v98 = u73[u11[v96]]
					if v98 and (type(v98) ~= "table" and type(v98) ~= "string" or #v98 > 0) then
						v95 = v95 + 1
						local v99 = u7:Clone()
						v99.Name = u77 .. " Info" .. u2.alphabet[v95]
						v99.Title.Text = v97 .. ":"
						if v95 % 2 == 0 then
							v99.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
						else
							v99.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
						end
						local v100 = v99.TextLabel
						v99.Parent = u67
						local v101 = u2.pdata.Prefix
						if u79 then
							v101 = u2.settings.ChatPrefix
						end
						if v97 == "Loop" then
							if v98 == true then
								v100.Text = "Yes"
							else
								v100.Text = "No"
							end
						elseif v97 == "Undo" and not v94 then
							v100.Text = v101 .. u73.UnFunction
						elseif v97 == "Alias" or (v97 == "Undos" or v94 and v97 == "Undo") then
							local v102 = {}
							if v97 == "Undo" then
								v98 = v94
							end
							for _, v103 in pairs(v98) do
								local v104 = v101 .. v103
								table.insert(v102, v104)
							end
							local v105 = v97 == "Undo" and u73.UnFunction
							if v105 then
								local v106 = v101 .. v105
								table.insert(v102, v106)
							end
							v100.Text = table.concat(v102, " | ")
						elseif type(v98) == "table" then
							v100.Text = table.concat(v98, ", ")
						elseif v97 == "Rank" then
							if u73.RankName == "Booster" then
								v100.Text = u73.Rank
							else
								v100.Text = u73.Rank .. " (" .. u73.RankName .. ")"
							end
						else
							v100.Text = v98
							if v97 == "Desc" then
								local v107 = v99.Title.AbsoluteSize
								local v108 = v99.AbsoluteSize
								local _ = (v99.Title.AbsolutePosition.Y - v99.AbsolutePosition.Y) / 2
								local v109 = v100.AbsoluteSize
								local v110 = v109.Y
								local _ = v100.Font
								local v111 = Vector2.new(v109.X, v109.Y * 100)
								local v112 = u2.textService:GetTextSize(v98, v110, Enum.Font.Roboto, v111)
								v99.UIAspectRatioConstraint:Destroy()
								v100.Size = UDim2.new(0, v112.X, 0, v112.Y)
								v99.Title.Size = UDim2.new(0, v107.X, 0, v107.Y)
								local v113 = UDim2.new
								local v114 = v108.X
								local v115 = v108.Y
								local v116 = v112.Y
								local v117 = v109.Y
								v99.Size = v113(0, v114, 0, v115 + (v116 - math.ceil(v117)))
								v99.Title.Position = UDim2.new(v99.Title.Position.X.Scale, 0, 0.5, 0)
								v99.TextLabel.Position = UDim2.new(v99.TextLabel.Position.X.Scale, 0, 0.5, 0)
							end
						end
						v99.Visible = true
						local v118 = u91
						table.insert(v118, v99)
					end
				end
				local v119 = #u91 * u7.AbsoluteSize.Y
				u67.CanvasSize = u67.CanvasSize + UDim2.new(0, 0, 0, v119)
				if u78.AbsolutePosition.Y > u67.AbsolutePosition.Y + u67.AbsoluteSize.Y - v119 / 1.5 then
					u67.CanvasPosition = u67.CanvasPosition + Vector2.new(0, v119)
					return
				end
			else
				local v120 = u78.Arrow
				u2.tweenService:Create(v120, u32, {
					["Rotation"] = 90
				}):Play()
			end
		end
		local v122 = u78.Expand
		if u73.IsBooster then
			v122.Visible = false
			u78.Arrow.Visible = false
		end
		if u2.device == "Mobile" then
			v122.MouseButton1Click:Connect(function()

				u121()
			end)
		else
			v122.MouseButton1Click:Connect(function()

				u121()
			end)
		end
		local v123 = u78.RunCommand
		local v124 = u78.RunIcon
		local v125 = u78.PendingIcon
		local _ = u78.RevokeIcon
		u2:GetModule("PageCommands"):SetupUICommandRunner(u78, u73)
		local v126 = 0
		local v127 = v76 <= v69 or u73.IsBooster
		if v127 then
			v127 = not u73.DisabledByOwner
		end
		local v128 = not v127 and 0.5 or v126
		v124.ImageTransparency = v128
		v125.ImageTransparency = v128
		v81.TextTransparency = v128
		v87.TextTransparency = v128
		local v129 = v81.Position + UDim2.new(0, v82.X, 0, 0)
		local v130 = UDim2.new(v129.X.Scale, v129.X.Offset + 3, 0.9, 0)
		v123.Size = v130
		v123.Position = UDim2.new(0, 0, 0.5, 0)
		v123.AnchorPoint = Vector2.new(0, 0.5)
		v122.Size = UDim2.new(1 - v130.X.Scale, -v130.X.Offset, 0.9, 0)
		v122.AnchorPoint = Vector2.new(1, 0.5)
		v122.Position = UDim2.new(1, 0, 0.5, 0)
		u1:UpdateRunCommandIndicator(u73.Name)
		u78.Parent = u67
	end
	return p68
end
function u1.SetupUICommandRunner(_, p131, u132, p133) 

	local u134 = p131.RunCommand
	local u135 = p131.RunIcon
	local u136 = p131.PendingIcon
	local u137 = p131.RevokeIcon
	local u138 = p133 or ""
	u135.Visible = true
	u136.Visible = true
	local u139 = u132.Name
	local u140 = u132.Groups or {}
	local v141 = #u140
	local u142 = nil
	u142 = function(p143, u144, p145)

		if p143 or p145 then
			u132.ShowRevoke = nil
		end
		local v146 = u144 and true or u137.Visible
		if p143 ~= nil then
			v146 = p143
		end
		if p143 ~= nil or (v146 or not u30) then
			local v147
			if u30 or u144 then
				v147 = false
			else
				u30 = true
				v147 = true
			end
			if v146 then
				u33[u132] = nil
			end
			u135.Visible = false
			u134.Visible = false
			u137.Visible = false
			u136.Visible = true
			task.defer(function()

				if not u144 then
					repeat
						local v148 = u136
						v148.Rotation = v148.Rotation + 15
						task.wait(0.001)
					until u135.Visible or (u137.Visible or not u136.Visible)
					u136.Rotation = 0
				end
			end)
			local v149 = v146 and "un" or ""
			local v150 = u132.Prefixes[1]
			local v151 = u2.pdata.Prefix
			if v150 and (v150 == u2.settings.ChatPrefix or v150 == u2.settings.UniversalPrefix) then
				v151 = v150
			end
			local v152 = v151 .. v149 .. u139 .. u138
			local v153 = u2.textChatService:FindFirstChild("TextChannels")
			if v153 then
				local _ = v153.RBXGeneral
			end
			if p143 == nil then
				for _, v154 in pairs(u140) do
					u31:Fire(v154)
				end
			end
			local v155 = (p143 == true or u144) and true or u2.signals.RequestCommand:InvokeServer(v152)
			if p143 ~= true and not u144 then
				task.wait(0.5)
			end
			if not (v155 or u144) then
				v146 = not v146
			end
			if u132.CanUndo and not v146 then
				u132.ShowRevoke = u138
				u136.Visible = false
				u137.Visible = true
				u33[u132] = u142
			else
				u135.Visible = true
				u33[u132] = nil
			end
			u134.Visible = true
			if v147 then
				u30 = false
			end
		end
	end
	u134.MouseButton1Click:Connect(function()

		if u132.ShowRevoke == u138 and u137.Visible == true then
			u142(nil, nil, true)
		else
			u142()
		end
	end)
	task.defer(function()

		for _ = 1, 20 do
			if u132.ShowRevoke == u138 then
				u136.Visible = false
				u137.Visible = true
				u33[u132] = u142
				return
			end
			task.wait(0.1)
		end
	end)
	if v141 > 0 then
		u31:Connect(function(p156)

			for _, v157 in pairs(u140) do
				if p156 == v157 and u137.Visible then
					u142(true)
					return
				end
			end
		end)
	end
end
local u158 = nil
local u159 = 0
function u1.CreateCommands(_) 

	if not u29 then
		u29 = true
		u56(u2.commandInfo)
		u159 = u5.commands.CanvasPosition.Y
		u2:GetModule("cf"):ClearPage(u5.commands)
		local v160 = u2:GetModule("cf"):GetGamepasses()
		local _ = u4.SearchBar.Frame.TextBox
		local v161 = u4.SearchBar.Frame.TextBox.Text
		local v162 = false
		local v163 = {}
		local v164 = {}
		local v165 = 0
		for _, v166 in pairs(u2.settings.Ranks) do
			if v166[2] == "Booster" then
				v162 = true
			end
		end
		if not v162 then
			local v167 = u2.settings.Ranks
			table.insert(v167, {
				5.1,
				"Booster",
				{}
			})
		end
		for v168, v169 in pairs(u2.settings.Ranks) do
			local v170 = v169[1]
			local v171 = v169[2]
			table.insert(v163, {
				v170,
				v171,
				{}
			})
			v164[v171] = v168
		end
		for _, v172 in pairs(u2.commandInfo) do
			if not v172.IgnoreDisplay and (not v172.IsBooster or tostring(v161):lower() == "booster") then
				local v173 = string.lower(v172.Name)
				local v174 = v172.IsBooster and "Booster" or (v172.RankName or "Unknown")
				local v175 = string.lower(v174) == string.lower(v161) and true or false
				if #v161 > 0 then
					local v176 = v172.Aliases
					if typeof(v176) == "table" then
						for _, v177 in v176 do
							local v178 = string.lower
							local v179 = #v177
							if v178((string.sub(v161, 1, v179))) == v177 then
								v175 = true
								break
							end
						end
					end
				end
				if string.match(v173, v161) or v175 then
					local v180 = v164[v172.IsBooster and "Booster" or (v172.RankName or "Unknown")]
					if not v180 then
						local v181 = v172.Rank
						for _, v182 in pairs(u2.settings.Ranks) do
							local v183 = v182[1]
							local v184 = v182[2]
							if v181 < v183 then
								v180 = v164[v184]
								break
							end
						end
					end
					if v180 then
						local v185 = v163[v180][3]
						table.insert(v185, v172)
					end
				end
			end
		end
		local _ = u2.pdata.Rank or 0
		for _, v186 in pairs(v163) do
			local v187 = v186[1]
			local v188 = v186[2]
			local v189 = v186[3]
			local v190 = true
			local v191 = v160[tostring(v187)]
			local v192 = u2.settings.ShowOnlyUsableAndBuyableCommands
			if v192 or u2.settings.OnlyShowUsableCommands then
				if u2.pdata.Rank < v187 and (v188 ~= "Booster" and not (v192 and v191)) then
					v190 = false
				end
			end
			if #v189 > 0 and v190 then
				local v193 = u6:Clone()
				v193.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
				v193.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				if v187 == 5 then
					v193.TextLabel.Text = v188
				elseif v188 == "Booster" then
					v193.TextLabel.Text = "Type /commands to view"
				else
					v193.TextLabel.Text = v188 .. " +"
				end
				local v194 = v165 + 1
				v193.Name = u2:GetModule("cf"):GenerateTagFromId(v194)
				v193.TextLabel.Position = UDim2.new(0.04, 0, 0.5, 0)
				v193.Arrow:Destroy()
				v193.Visible = true
				v193.Parent = u5.commands
				if v191 then
					for v195, v196 in pairs(v191) do
						local u197 = tonumber(v195)
						local v198 = u8:Clone()
						v198.Name = u2:GetModule("cf"):GenerateTagFromId(v194)
						v198.Parent = u5.commands
						v194 = v194 + 1
						v198.ItemTitle.Text = v196.Name
						v198.ItemImage.Image = "rbxassetid://" .. v196.IconImageAssetId
						v198.ItemDesc.Text = ("Unlock %* commands"):format(v188)
						v198.Unlock.Visible = true
						v198.Visible = true
						local u199 = v198.Unlock
						local u200 = v198.Unlocked
						local u201 = false
						local function v203(p202) 

							u199.Visible = false
							u200.Visible = true
							if p202 == nil then
								p202 = u2.marketplaceService:UserOwnsGamePassAsync(u2.player.UserId, u197)
							end
							u199.Visible = not p202
							u200.Visible = p202
							if not (p202 or u201) then
								u201 = true
								u199.MouseButton1Click:Connect(function()

									u2:GetModule("cf"):PromptGamepass(u2.player, u197)
								end)
							end
						end
						task.spawn(v203)
					end
				end
				v165 = u1:SetupCommands(v189, u5.commands, v194)
			end
		end
		if u158 == v161 and u159 then
			local function v204() 

				u5.commands.CanvasPosition = Vector2.new(0, u159)
			end
			u5.commands.CanvasPosition = Vector2.new(0, u159)
			task.defer(v204)
		end
		u158 = v161
		coroutine.wrap(function()

			wait(0.5)
			u29 = false
		end)()
	end
end
function u1.CreateVoiceChat(_) 
 end
function u1.CreateMorphs(_) 

	u2:GetModule("cf"):ClearPage(u5.morphs)
	local v205 = u4.SearchBar.Frame.TextBox.Text
	local v206 = {}
	for v207, _ in pairs(u2.morphNames) do
		local v208 = string.lower(v207)
		if string.match(v208, v205) then
			table.insert(v206, v207)
		end
	end
	table.sort(v206)
	local v209 = u2.pdata.Prefix .. "morph <player> <morphName>"
	table.insert(v206, 1, v209)
	for v210, v211 in pairs(v206) do
		local v212 = u9:Clone()
		if v210 == 1 then
			v212.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
			v212.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		else
			v212.BackgroundColor3 = u2:GetModule("cf"):GetLabelBackgroundColor(v210)
			v212.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
		v212.TextLabel.Text = v211
		v212.Name = v211
		v212.Visible = true
		v212.Parent = u5.morphs
	end
	u5.morphs.CanvasSize = UDim2.new(0, 0, 0, #v206 * u9.AbsoluteSize.Y)
end
local u213 = {
	{
		{ 0, "Colors" }
	},
	{
		{ 0, "Qualifiers (select certain players)" },
		{ "Me" },
		{ "All" },
		{ "Random" },
		{ "Admins/NonAdmins" },
		{ "Friends/NonFriends" },
		{ "NBC/BC/TBC/OBC/Premium(prem)" },
		{ "R6/R15" },
		{ "Rthro/NonRthro" },
		{ "@(RankName)" },
		{ "%(TeamName)" }
	},
	{
		{ 0, "Shortcuts" },
		{ "\' (Quote) to toggle cmdbar (computer)" },
		{ "; (Semicolon) to toggle cmdbar2 (computer)" }
	},
	{
		{ 0, "Tips" },
		{ "/e for silent commands   (/e ;jump me)" },
		{ "Batch commands   (;jump me ;kill me)" },
		{ "Select multiple players   (;jump me,bc,r15)" },
		{ "Shorten names   (;jump ForeverHD = ;jump for)" },
		{ "Cases do not matter   (;jUmP mE = ;jump me)" }
	}
}
local v214 = nil
for v215, v216 in pairs(u213) do
	if v216[1][1] == 0 and v216[1][2] == "Colors" then
		v214 = v215
	end
end
for _, v217 in pairs(u2.settings.Colors) do
	local v218 = v217[1]
	local v219 = v217[2]
	local v220 = { v219 .. " (" .. v218 .. ")" }
	local v221 = u213[v214]
	table.insert(v221, v220)
	local v222 = u2.colors
	table.insert(v222, v219)
end
function u1.CreateDetails(_) 

	u2:GetModule("cf"):ClearPage(u5.details)
	local v223 = 0
	for _, v224 in pairs(u213) do
		for v225, v226 in pairs(v224) do
			local v227 = u9:Clone()
			if v225 == 1 then
				v227.BackgroundTransparency = 0.93
				v227.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				v227.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				v227.TextLabel.Text = v226[2]
			else
				v227.BackgroundTransparency = 1
				if v225 % 2 == 0 then
					v227.BackgroundTransparency = v227.BackgroundTransparency - 0.01
				end
				v227.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				v227.TextLabel.Text = v226[1]
			end
			v227.Visible = true
			v227.Parent = u5.details
			v223 = v223 + 1
		end
	end
	u5.details.CanvasSize = UDim2.new(0, 0, 0, v223 * u9.AbsoluteSize.Y)
end
return u1