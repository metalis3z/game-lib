-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Workspace")
local v4 = v2:WaitForChild("Packages")
local v5 = v2:WaitForChild("Utils")
local v6 = require(v4.Net)
local v_u_7 = require(v4.FFlags)
local v_u_8 = require(v5.NumberUtils)
local v_u_9 = require(v2.Datas.ServerData)
local v_u_10 = v3.Map
local v_u_11 = {}
local v_u_12 = {}
local ContentProvider = game:GetService("ContentProvider")
local isFakeActive = false
local function v_u_15(p13)
	if not p13 or #p13 ~= 2 then
		return ""
	end
	local v14 = string.upper(p13)
	return utf8.char(string.byte(v14, 1) + 127397) .. utf8.char(string.byte(v14, 2) + 127397)
end
local v_u_16 = {}
local v_u_17 = Color3.fromRGB(255, 213, 0)
local v_u_18 = Color3.fromRGB(116, 116, 116)
local v_u_19 = Color3.fromRGB(143, 87, 35)
local v_u_20 = Color3.fromRGB(255, 255, 255)
local v_u_21 = Color3.fromRGB(81, 158, 86)
local v_u_22 = Color3.fromRGB(115, 152, 172)
local v_u_23 = v6:RemoteFunction("Leaderboard/GetTopPlayers")
local v_u_24 = v6:RemoteFunction("Leaderboard/GetTopFriends")
local v_u_25 = v6:RemoteFunction("Leaderboard/GetDisplayNames")
local v_u_26 = v6:RemoteEvent("Leaderboard/ReplicateUpdate")
local v_u_27 = v6:RemoteEvent("Leaderboard/ReplicateDisplayNames")
local v_u_28 = v6:RemoteFunction("Leaderboard/GetCountryLeaderboard")
local v_u_29 = v6:RemoteEvent("Leaderboard/ReplicateCountryUpdate")

local function formatValue(boardName, value)
	local formatted = v_u_8:ToString(value, 2)
	if boardName == "Generation" then
		formatted = formatted .. "/s"
	end
	return formatted
end

local function v_u_34(p30)
	local v31 = p30:GetAttribute("UserId")
	if v31 then
		local v32 = v_u_12[v31]
		if v32 then
			local v33 = table.find(v32, p30)
			if v33 then
				table.remove(v32, v33)
				if #v32 == 0 then
					v_u_12[v31] = nil
				end
			end
		else
			return
		end
	else
		return
	end
end
local v35 = {}
local function v_u_63(p36)
	local v37 = v_u_16[p36]
	if v37 then
		local v38 = v37.Container
		local v39 = v37.Template
		local v40 = v37.ActiveTab or "Global"
		local v41
		if v40 == "Friends" then
			v41 = v37.FriendsData
		elseif v40 == "Country" then
			v41 = v37.CountryData
		else
			v41 = v37.PlayerData
		end
		local v42 = v37.Lines or {}
		local v43 = #v41
		local v44 = {}
		for v45 = 1, math.min(100, v43) do
			local v46 = v41[v45]
			local v47 = v46.UserId
			if not v44[v47] then
				local v48 = v42[v47]
				if v48 then
					v42[v47] = nil
				else
					v48 = v39:Clone()
					v48.Visible = true
					v48.Parent = v38
					v48:SetAttribute("UserId", v47)
					if v_u_12[v47] then
						if not table.find(v_u_12[v47], v48) then
							local v49 = v_u_12[v47]
							table.insert(v49, v48)
						end
					else
						v_u_12[v47] = { v48 }
					end
				end
				v48.LayoutOrder = v45
				local v50 = v46.Rank
				local v51
				if v50 == 1 then
					v51 = v_u_17
				elseif v50 == 2 then
					v51 = v_u_18
				elseif v50 == 3 then
					v51 = v_u_19
				else
					v51 = v_u_20
				end
				local v52 = v48:FindFirstChild("PositionLabel")
				if v52 then
					local v53 = v46.Rank
					v52.Text = tostring(v53) .. "."
					v52.TextColor3 = v51
				end
				local v54 = v48:FindFirstChild("NameLabel")
				if v54 then
					v54.AutoLocalize = false
					local v55 = not v46.Country and "" or " " .. v_u_15(v46.Country)
					v54.Text = (v_u_11[v46.UserId] or "Loading...") .. v55
					v54:SetAttribute("Flag", v55)
					v54.TextColor3 = v51
				end
				local v56 = v48:FindFirstChild(p36 .. "Label")
				if v56 then
					v56.Text = formatValue(p36, v46.Value)
					v56.TextColor3 = v51
				end
				local v60 = v48:FindFirstChild("AvatarImage")
				if v60 then
					v60.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=100&h=100", v46.UserId)
					local v61 = v60:FindFirstChild("UIStroke")
					if v61 then
						v61.Color = v51
					end
				end
				v44[v47] = v48
			end
		end
		for _, v62 in v42 do
			v_u_34(v62)
			v62:Destroy()
		end
		v37.Lines = v44
	end
end
local function v_u_74(p64, p65)
	local v66 = v_u_16[p64]
	if v66 then
		v66.ActiveTab = p65
		local v67 = v66.Gui:WaitForChild("MainFrame"):WaitForChild("Buttons")
		local v68 = v67:FindFirstChild("Global")
		local v69 = v67:FindFirstChild("Friends")
		local v70 = v67:FindFirstChild("Country")
		if v68 then
			local v71
			if p65 == "Global" then
				v71 = v_u_21
			else
				v71 = v_u_22
			end
			v68.BackgroundColor3 = v71
		end
		if v69 then
			local v72
			if p65 == "Friends" then
				v72 = v_u_21
			else
				v72 = v_u_22
			end
			v69.BackgroundColor3 = v72
		end
		if v70 then
			local v73
			if p65 == "Country" then
				v73 = v_u_21
			else
				v73 = v_u_22
			end
			v70.BackgroundColor3 = v73
		end
		v_u_63(p64)
	end
end
local function v_u_88(p_u_75)
	if isFakeActive then return end
	local v76 = v_u_16[p_u_75]
	if v76 and not v76.FriendsFetched then
		v76.FriendsFetched = true
		local v_u_77 = nil
		local v_u_78 = nil
		pcall(function()
			local v79, v80 = v_u_24:InvokeServer(p_u_75)
			v_u_77 = v79
			v_u_78 = v80
		end)
		if v_u_77 then
			local v81 = v_u_78
			if type(v81) == "table" then
				table.sort(v_u_78, function(p82, p83)
					return (p82.Amount or 0) > (p83.Amount or 0)
				end)
				local v84 = {}
				for v85, v86 in v_u_78 do
					v_u_11[v86.Id] = v86.DisplayName or v86.Username
					local v87 = {
						UserId = v86.Id,
						Value = v86.Amount or 0,
						Rank = v85,
						Country = v86.Country
					}
					table.insert(v84, v87)
				end
				v76.FriendsData = v84
				if v76.ActiveTab == "Friends" then
					v_u_63(p_u_75)
				end
				return
			end
		end
		v76.FriendsFetched = nil
	end
end
local function v_u_96(p_u_89)
	if isFakeActive then return end
	local v90 = v_u_16[p_u_89]
	if v90 and not v90.CountryFetched then
		v90.CountryFetched = true
		local v_u_91 = nil
		local v_u_92 = nil
		pcall(function()
			local v93, v94 = v_u_28:InvokeServer(p_u_89)
			v_u_91 = v93
			v_u_92 = v94
		end)
		local v95 = v_u_91
		if type(v95) == "table" and #v95 > 0 then
			v90.CountryData = v_u_91
			v90.CountryCode = v_u_92
			if v90.ActiveTab == "Country" then
				v_u_63(p_u_89)
			end
		else
			v90.CountryFetched = nil
		end
	end
end
local function v_u_99(p_u_97, p_u_98)
	if isFakeActive then return end
	if not p_u_98 then
		pcall(function()
			p_u_98 = v_u_23:InvokeServer(p_u_97)
		end)
	end
	if type(p_u_98) == "table" then
		v_u_16[p_u_97].PlayerData = p_u_98
		if (v_u_16[p_u_97].ActiveTab or "Global") == "Global" then
			v_u_63(p_u_97)
		end
	end
end
local function v_u_101(p100)
	v_u_11[p100.UserId] = p100.DisplayName
end
function v35.Start(_)
	if not (v_u_9.IsDuelsServer() or v_u_9.IsTsunamiServer()) then
		local v102 = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
		local v103 = {
			Generation = {
				Model = v_u_10:WaitForChild("GenerationBoard", 30),
				PlayerData = {},
				FriendsData = {},
				CountryData = {},
				ActiveTab = "Global",
				Lines = {}
			},
			Steals = {
				Model = v_u_10:WaitForChild("StealsBoard", 30),
				PlayerData = {},
				FriendsData = {},
				CountryData = {},
				ActiveTab = "Global",
				Lines = {}
			}
		}
		v_u_16 = v103
		for v_u_104, v105 in v_u_16 do
			local v106 = v105.Model:WaitForChild("Main")
			local v107 = v106:WaitForChild("SurfaceGui")
			v107.Adornee = v106
			v107.Parent = v102
			v105.Gui = v107
			local v108 = v107:WaitForChild("MainFrame")
			v105.Container = v108:WaitForChild("ScrollingFrame")
			v105.Template = v105.Container:WaitForChild("LeaderboardTemplate")
			local v109 = v108:WaitForChild("Buttons")
			local v110 = v109:FindFirstChild("Global")
			local v111 = v109:FindFirstChild("Friends")
			local v112 = v109:FindFirstChild("Country")
			v105.ButtonsFrame = v109
			v105.GlobalBtn = v110
			v105.FriendsBtn = v111
			v105.CountryBtn = v112
			v105.OriginalContainerSize = v105.Container.Size
			if v110 then
				v110.Activated:Connect(function()
					if not v_u_7:GetInstant("Leaderboard/GlobalDisabled", false) then
						v_u_74(v_u_104, "Global")
					end
				end)
			end
			if v111 then
				v111.Activated:Connect(function()
					if not v_u_7:GetInstant("Leaderboard/FriendsDisabled", false) then
						v_u_74(v_u_104, "Friends")
						task.spawn(v_u_88, v_u_104)
					end
				end)
			end
			if v112 then
				v112.Activated:Connect(function()
					if not v_u_7:GetInstant("Leaderboard/CountryDisabled", false) then
						v_u_74(v_u_104, "Country")
						task.spawn(v_u_96, v_u_104)
					end
				end)
			end
		end
		local function v124()
			local v113 = v_u_7:GetInstant("Leaderboard/GlobalDisabled", false)
			local v114 = v_u_7:GetInstant("Leaderboard/FriendsDisabled", false)
			local v115 = v_u_7:GetInstant("Leaderboard/CountryDisabled", false)
			for v116, v117 in v_u_16 do
				local v118 = v117.GlobalBtn
				local v119 = v117.FriendsBtn
				local v120 = v117.CountryBtn
				if v118 then
					v118.Visible = not v113
				end
				if v119 then
					v119.Visible = not v114
				end
				if v120 then
					v120.Visible = not v115
				end
				local v121 = 0
				if v118 and not v113 then
					v121 = v121 + 1
				end
				if v119 and not v114 then
					v121 = v121 + 1
				end
				if v120 and not v115 then
					v121 = v121 + 1
				end
				if v121 <= 1 then
					v117.ButtonsFrame.Visible = false
					v117.Container.Size = UDim2.new(v117.OriginalContainerSize.X.Scale, v117.OriginalContainerSize.X.Offset, 0.9, 0)
				else
					v117.ButtonsFrame.Visible = true
					v117.Container.Size = v117.OriginalContainerSize
				end
				local v122 = v117.ActiveTab
				local v123
				if v122 == "Global" and v113 then
					v123 = v113
				elseif v122 == "Friends" and v114 then
					v123 = v114
				elseif v122 == "Country" then
					v123 = v115
				else
					v123 = false
				end
				if v123 then
					v_u_74(v116, v113 and (v114 and (v115 and "Global" or "Country") or "Friends") or "Global")
				end
			end
		end
		task.spawn(v124)
		v_u_7:OnUpdate(v124)

		local FAKE_GUI_NAMES = {
			Generation = "FakeGeneration",
			Steals     = "FakeSteal",
		}

		local function applyFakeGuis()
			isFakeActive = true
			for boardName, boardState in v_u_16 do
				if boardState.Gui then
					boardState.Gui.Enabled = false
				end
				local fakeGuiName = FAKE_GUI_NAMES[boardName]
				if fakeGuiName then
					local fakeGui = script:FindFirstChild(fakeGuiName)
					if fakeGui then
						fakeGui.ResetOnSpawn = false
						fakeGui.Parent = v102
						fakeGui.Enabled = true
					end
				end
			end
		end

		local function restoreRealGuis()
			isFakeActive = false
			for boardName, boardState in v_u_16 do
				local fakeGuiName = FAKE_GUI_NAMES[boardName]
				if fakeGuiName then
					local fakeGui = v102:FindFirstChild(fakeGuiName)
						or script:FindFirstChild(fakeGuiName)
					if fakeGui then
						fakeGui.Enabled = false
						fakeGui.Parent = script
					end
				end
				if boardState.Gui then
					boardState.Gui.Enabled = true
				end
				boardState.PlayerData   = {}
				boardState.FriendsData  = {}
				boardState.CountryData  = {}
				boardState.FriendsFetched  = nil
				boardState.CountryFetched  = nil
			end
			for boardName, boardState in v_u_16 do
				local tab = boardState.ActiveTab or "Global"
				if tab == "Friends" then
					task.spawn(v_u_88, boardName)
				elseif tab == "Country" then
					task.spawn(v_u_96, boardName)
				else
					task.spawn(v_u_99, boardName)
				end
			end
		end

		local function onRealLeaderboardsChanged()
			local attrValue = v2:GetAttribute("RealLeaderboards")
			if attrValue then
				applyFakeGuis()
			else
				restoreRealGuis()
			end
		end

		onRealLeaderboardsChanged()
		v2:GetAttributeChangedSignal("RealLeaderboards"):Connect(onRealLeaderboardsChanged)
		for _, v125 in v_u_1:GetPlayers() do
			task.spawn(v_u_101, v125)
		end
		v_u_1.PlayerAdded:Connect(v_u_101)
		local function v133(p126)
			if type(p126) == "table" then
				for v127, v128 in p126 do
					local v129 = tonumber(v127)
					if v129 then
						v_u_11[v129] = v128
						local v130 = v_u_12[v129]
						if type(v130) == "table" then
							for _, v131 in v130 do
								local v132 = v131:FindFirstChild("NameLabel")
								if v132 and v132:IsA("TextLabel") then
									v132.Text = v128 .. (v132:GetAttribute("Flag") or "")
								end
							end
						end
					end
				end
			end
		end
		v_u_26.OnClientEvent:Connect(function(p134, p135)
			if isFakeActive then return end
			v_u_99(p134, p135)
		end)
		v_u_29.OnClientEvent:Connect(function(p136, p137, p_countryCode)
			if isFakeActive then return end
			local v138 = v_u_16[p136]
			if v138 then
				v138.CountryData = p137
				v138.CountryCode = p_countryCode
				v138.CountryFetched = (type(p137) == "table" and #p137 > 0) or nil
				if v138.ActiveTab == "Country" then
					v_u_63(p136)
				end
			end
		end)
		v_u_27.OnClientEvent:Connect(v133)
		v133(v_u_25:InvokeServer())
		for v139, v140 in v_u_16 do
			if v140.ActiveTab == "Global" then
				task.spawn(v_u_99, v139)
			elseif v140.ActiveTab == "Friends" then
				task.spawn(v_u_88, v139)
			elseif v140.ActiveTab == "Country" then
				task.spawn(v_u_96, v139)
			end
		end
	end
end
v35.Load = function()
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetDescendants())
	end)
end
return v35