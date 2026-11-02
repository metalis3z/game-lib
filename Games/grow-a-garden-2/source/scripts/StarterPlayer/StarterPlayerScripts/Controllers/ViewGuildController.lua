--credit to prince games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local GuildCompetition = require(ReplicatedStorage.SharedModules.GuildCompetition)
local Asserts = require(ReplicatedStorage.SharedModules.Guild.Asserts)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local GuiController = require(LocalPlayer.PlayerScripts.Controllers.GuiController)
local NotificationController = require(LocalPlayer.PlayerScripts.Controllers.NotificationController)
local DevProductController = require(LocalPlayer.PlayerScripts.Controllers.DevProductController)
local LeaveGuildController = require(LocalPlayer.PlayerScripts.Controllers.LeaveGuildController)
local t = {
	{
		From = 20,
		To = 25,
		Key = "Guild:Guild Slots:25",
		FallbackPrice = 37
	},
	{
		From = 25,
		To = 30,
		Key = "Guild:Guild Slots:30",
		FallbackPrice = 79
	},
	{
		From = 30,
		To = 35,
		Key = "Guild:Guild Slots:35",
		FallbackPrice = 189
	},
	{
		From = 35,
		To = 40,
		Key = "Guild:Guild Slots:40",
		FallbackPrice = 279
	},
	{
		From = 40,
		To = 45,
		Key = "Guild:Guild Slots:45",
		FallbackPrice = 399
	},
	{
		From = 45,
		To = 50,
		Key = "Guild:Guild Slots:50",
		FallbackPrice = 499
	}
}

local function getSlotTierForCurrent(p1) --[[ getSlotTierForCurrent | Line: 68 | Upvalues: t (copy) ]]
	for v1, v2 in t do
		if v2.From <= p1 and p1 < v2.To then
			return v2
		end
	end

	return nil
end

local t2 = {
	StartOrder = 8
}
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = nil
local v21 = nil
local v22 = nil
local t3 = {}
local v23 = nil
local t4 = {}
local v24 = nil
local t5 = {}
local t6 = {}
local v25 = nil
local v26 = nil
local t7 = {}
local t8 = {}
local v27 = false
local v28 = false
local v29 = 0
local t9 = {}
local t10 = {}
local v30 = nil
local v31 = nil
local v32 = 0
local v33 = nil
local v34 = 0
local v35 = Color3.fromRGB(70, 255, 0)
local v36 = Color3.fromRGB(220, 60, 60)
local v37 = nil
local v38 = false

local function currentScoreFormat() --[[ currentScoreFormat | Line: 205 | Upvalues: v30 (ref) ]]
	local v1 = v30

	if typeof(v1) ~= "table" then
		return nil
	end

	local v2 = if typeof(v1.config) == "table" then v1.config else v1.lastConfig

	if typeof(v2) ~= "table" then
		return nil
	end

	if typeof(v2.scoreFormat) == "string" then
		return v2.scoreFormat
	end

	return nil
end

local function getPreferredNextReset(p1) --[[ getPreferredNextReset | Line: 219 | Upvalues: v31 (ref) ]]
	if v31 and p1 < v31 then
		return v31
	end

	return nil
end

local v39 = nil

local function fetchCompetition() --[[ fetchCompetition | Line: 236 | Upvalues: v32 (ref), Networking (copy), v30 (ref), v31 (ref), v39 (ref) ]]
	local v1 = os.clock()

	if not (v1 - v32 < 15) then
		v32 = v1
		task.spawn(function() --[[ Line: 240 | Upvalues: Networking (ref), v30 (ref), v31 (ref), v39 (ref) ]]
			local ok, result = pcall(function() --[[ Line: 241 | Upvalues: Networking (ref) ]]
				return Networking.Guild.GetCompetition:Fire()
			end)

			if not ok or typeof(result) ~= "table" then
				return
			end

			local v1 = v30
			local v2

			if typeof(v1) == "table" then
				local v3 = if typeof(v1.config) == "table" then v1.config else v1.lastConfig

				v2 = if typeof(v3) == "table" then if typeof(v3.scoreFormat) == "string" then v3.scoreFormat else nil else nil
			else
				v2 = nil
			end

			v30 = result

			if result.phase == "running" and typeof(result.endsAt) == "number" then
				v31 = result.endsAt
			else
				local v4

				if result.phase == "pending" then
					v4 = result.startsAt
					v31 = if typeof(v4) == "number" then result.startsAt else nil
				else
					v31 = nil
				end
			end

			local v5 = result
			local v6

			if typeof(v5) == "table" then
				local v7 = if typeof(v5.config) == "table" then v5.config else v5.lastConfig

				v6 = if typeof(v7) == "table" then if typeof(v7.scoreFormat) == "string" then v7.scoreFormat else nil else nil
			else
				v6 = nil
			end

			if v6 == v2 then
				return
			end

			local v8 = v39

			if not v8 then
				return
			end

			v8()
		end)
	end
end

local function getPreferredWeekProgress(p1, p2) --[[ getPreferredWeekProgress | Line: 263 ]]
	return math.clamp((p1 - (p2 - 604800)) / 604800, 0, 1)
end

local function formatTimeRemaining(p1) --[[ formatTimeRemaining | Line: 269 | Upvalues: v30 (ref) ]]
	if p1 < 0 then
		p1 = 0
	end

	local v1 = if v30 and v30.phase == "pending" then "Starts in" else "Rewards in"
	local v2 = math.floor(p1 + 0.5)

	if v2 < 3600 then
		local v3 = v2 // 60

		return string.format("%s %dm %ds", v1, v3, v2 - v3 * 60)
	end

	if v2 < 86400 then
		local v4 = v2 // 3600

		return string.format("%s %dh %dm", v1, v4, (v2 - v4 * 3600) // 60)
	end

	local v5 = v2 // 86400

	return string.format("%s %dd %dh", v1, v5, (v2 - v5 * 86400) // 3600)
end

local function color3ToHex(p1) --[[ color3ToHex | Line: 291 ]]
	return string.format("#%02X%02X%02X", math.clamp(math.floor(p1.R * 255 + 0.5), 0, 255), math.clamp(math.floor(p1.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(p1.B * 255 + 0.5), 0, 255)))
end

local function hexFromMaybe(p1) --[[ hexFromMaybe | Line: 300 ]]
	if typeof(p1) ~= "string" or p1 == "" then
		return "#FFFFFF"
	end

	if p1:sub(1, 1) == "#" then
		return p1
	end

	return "#" .. p1
end

local function buildRainbowChars(p1, p2) --[[ buildRainbowChars | Line: 308 ]]
	local v1 = utf8.len(p1) or 1

	if v1 <= 0 then
		return p1
	end

	local count = 0
	local t = {}

	for v2, v3 in utf8.codes(p1) do
		count = count + 1

		local v4 = Color3.fromHSV((p2 * 1.2 + (count - 1) / v1 * 0.6) % 1, 1, 1)

		table.insert(t, string.format("<font color=\"%s\">%s</font>", string.format("#%02X%02X%02X", math.clamp(math.floor(v4.R * 255 + 0.5), 0, 255), math.clamp(math.floor(v4.G * 255 + 0.5), 0, 255), (math.clamp(math.floor(v4.B * 255 + 0.5), 0, 255))), utf8.char(v3)))
	end

	return table.concat(t)
end

local function getOnlineName(p1) --[[ getOnlineName | Line: 324 | Upvalues: Players (copy) ]]
	local v1 = Players:GetPlayerByUserId(p1)

	if v1 then
		return v1.Name
	end

	return nil
end

local function getCachedName(p1) --[[ getCachedName | Line: 330 | Upvalues: Players (copy), t7 (copy) ]]
	local v1 = Players:GetPlayerByUserId(p1)
	local v2 = if v1 then v1.Name else nil

	if v2 then
		t7[p1] = v2

		return v2
	end

	if t7[p1] then
		return t7[p1]
	end

	return tostring(p1)
end

local function fetchName(p1, p2) --[[ fetchName | Line: 337 | Upvalues: Players (copy), t7 (copy) ]]
	local v1 = Players:GetPlayerByUserId(p1)
	local v2 = if v1 then v1.Name else nil

	if v2 then
		t7[p1] = v2
		p2(v2)

		return
	end

	if t7[p1] then
		p2(t7[p1])
	else
		task.spawn(function() --[[ Line: 345 | Upvalues: Players (ref), p1 (copy), t7 (ref), p2 (copy) ]]
			local ok, result = pcall(function() --[[ Line: 346 | Upvalues: Players (ref), p1 (ref) ]]
				return Players:GetNameFromUserIdAsync(p1)
			end)
			local v1 = if ok and typeof(result) == "string" then result else tostring(p1)

			t7[p1] = v1
			p2(v1)
		end)
	end
end

local function fetchHeadshot(p1, p2) --[[ fetchHeadshot | Line: 355 | Upvalues: t8 (copy), Players (copy) ]]
	if t8[p1] then
		p2(t8[p1])
	else
		task.spawn(function() --[[ Line: 357 | Upvalues: Players (ref), p1 (copy), t8 (ref), p2 (copy) ]]
			local ok, result = pcall(function() --[[ Line: 358 | Upvalues: Players (ref), p1 (ref) ]]
				return Players:GetUserThumbnailAsync(p1, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			end)

			if not ok or typeof(result) ~= "string" then
				return
			end

			t8[p1] = result
			p2(result)
		end)
	end
end

local function setLabelChain(p1, p2) --[[ setLabelChain | Line: 369 ]]
	if not p1 then
		return
	end

	p1.RichText = true
	p1.Text = p2

	local TextLabel = p1:FindFirstChild("TextLabel")

	if not (TextLabel and TextLabel:IsA("TextLabel")) then
		return
	end

	TextLabel.RichText = true
	TextLabel.Text = p2
end

local function setPlainLabel(p1, p2) --[[ setPlainLabel | Line: 383 ]]
	if not p1 then
		return
	end

	p1.RichText = false
	p1.Text = p2

	local TextLabel = p1:FindFirstChild("TextLabel")

	if not (TextLabel and TextLabel:IsA("TextLabel")) then
		return
	end

	TextLabel.RichText = false
	TextLabel.Text = p2
end

local function stripRichTextTags(p1) --[[ stripRichTextTags | Line: 395 ]]
	return p1:gsub("<.->", "")
end

local function setTitleLabels(p1) --[[ setTitleLabels | Line: 405 | Upvalues: v10 (ref) ]]
	if v10 then
		v10.RichText = false
		v10.TextColor3 = Color3.new(0/255, 0/255, 0/255)
		v10.Text = p1:gsub("<.->", "")
	end

	local v1 = v10 and v10:FindFirstChild("TextLabel")

	if not (v1 and v1:IsA("TextLabel")) then
		return
	end

	v1.RichText = true
	v1.Text = p1
end

local function getRankColor(p1) --[[ getRankColor | Line: 418 ]]
	if p1 == 2 then
		return "#FFBE18"
	end

	if p1 == 3 then
		return "#AAAAAA"
	end

	return "#956D4C"
end

local function findGlobalRank(p1) --[[ findGlobalRank | Line: 433 | Upvalues: LocalPlayer (copy), t3 (ref) ]]
	local v1

	if typeof(p1) == "string" and p1 ~= "" then
		v1 = p1
	else
		local v2 = LocalPlayer:GetAttribute("GuildId")

		if typeof(v2) ~= "string" then
			return nil
		end

		v1 = v2
	end

	for v3, v4 in t3 do
		if (v4.guildId or v4.GuildId) == v1 then
			local v7 = tonumber(v4.rank or v4.Rank)

			if v7 then
				return v7
			end

			return v3
		end
	end

	return nil
end

local function findGuildLeaderboardScore(p1) --[[ findGuildLeaderboardScore | Line: 455 | Upvalues: v23 (ref), t3 (ref) ]]
	if v23 ~= "weekly" then
		return nil
	end

	if typeof(p1) ~= "string" or p1 == "" then
		return nil
	end

	for v1, v2 in t3 do
		if (v2.guildId or v2.GuildId) == p1 then
			return tonumber(v2.shekels or (v2.Shekels or v2.score))
		end
	end

	return nil
end

local function stopRainbowTitle() --[[ stopRainbowTitle | Line: 467 | Upvalues: v26 (ref) ]]
	if not v26 then
		return
	end

	task.cancel(v26)
	v26 = nil
end

local function startRainbowTitle(p1, p2) --[[ startRainbowTitle | Line: 474 | Upvalues: v26 (ref), v27 (ref), buildRainbowChars (copy), setTitleLabels (copy) ]]
	if not v26 then
		v26 = task.spawn(function() --[[ Line: 476 | Upvalues: v27 (ref), p1 (copy), buildRainbowChars (ref), p2 (copy), setTitleLabels (ref) ]]
			local sum2 = 0

			while v27 do
				setTitleLabels(p1 .. " " .. buildRainbowChars(p2, sum2))
				sum2 = sum2 + task.wait(0.04)
			end
		end)

		return
	end

	task.cancel(v26)
	v26 = nil
	v26 = task.spawn(function() --[[ Line: 476 | Upvalues: v27 (ref), p1 (copy), buildRainbowChars (ref), p2 (copy), setTitleLabels (ref) ]]
		local sum2 = 0

		while v27 do
			setTitleLabels(p1 .. " " .. buildRainbowChars(p2, sum2))
			sum2 = sum2 + task.wait(0.04)
		end
	end)
end

local function applyGuildIconImage(p1) --[[ applyGuildIconImage | Line: 486 | Upvalues: v15 (ref), Asserts (copy) ]]
	if not v15 then
		return
	end

	v15.Image = Asserts.IconAssetString(if typeof(p1) == "number" then p1 else nil)
end

local function applyGuildTitle(p1) --[[ applyGuildTitle | Line: 492 | Upvalues: v23 (ref), findGlobalRank (copy), v26 (ref), v27 (ref), buildRainbowChars (copy), setTitleLabels (copy) ]]
	if not p1 then
		return
	end

	local v2 = tostring(p1.Tag or "")
	local v4 = tostring(p1.Name or "")
	local Color = p1.Color
	local v5 = if typeof(Color) == "string" and Color ~= "" then if Color:sub(1, 1) == "#" then Color else "#" .. Color else "#FFFFFF"
	local v6 = p1.TagColor or p1.Color
	local v8 = string.format("<font color=\"%s\">[%s]</font> <font color=\"%s\">%s</font>", if typeof(v6) == "string" and v6 ~= "" then if v6:sub(1, 1) == "#" then v6 else "#" .. v6 else "#FFFFFF", v2, v5, v4)
	local v10 = if v23 == "weekly" then findGlobalRank(if typeof(p1.GuildId) == "string" then p1.GuildId else nil) else nil

	if v10 == 1 then
		local v12

		if not v26 then
			v12 = "(#1)"
			v26 = task.spawn(function() --[[ Line: 476 | Upvalues: v27 (ref), v8 (copy), buildRainbowChars (ref), v12 (copy), setTitleLabels (ref) ]]
				local sum2 = 0

				while v27 do
					setTitleLabels(v8 .. " " .. buildRainbowChars(v12, sum2))
					sum2 = sum2 + task.wait(0.04)
				end
			end)

			return
		end

		task.cancel(v26)
		v26 = nil
		v12 = "(#1)"
		v26 = task.spawn(function() --[[ Line: 476 | Upvalues: v27 (ref), v8 (copy), buildRainbowChars (ref), v12 (copy), setTitleLabels (ref) ]]
			local sum2 = 0

			while v27 do
				setTitleLabels(v8 .. " " .. buildRainbowChars(v12, sum2))
				sum2 = sum2 + task.wait(0.04)
			end
		end)
	elseif v10 and v10 <= 200 then
		if v26 then
			task.cancel(v26)
			v26 = nil
		end

		setTitleLabels(v8 .. string.format(" <font color=\"%s\">(#%d)</font>", if v10 == 2 then "#FFBE18" elseif v10 == 3 then "#AAAAAA" else "#956D4C", v10))
	else
		if not v26 then
			setTitleLabels(v8)

			return
		end

		task.cancel(v26)
		v26 = nil
		setTitleLabels(v8)
	end
end

local function clearRows() --[[ clearRows | Line: 528 | Upvalues: t6 (copy), t5 (copy) ]]
	for v1, v2 in t6 do
		pcall(function() --[[ Line: 530 | Upvalues: v2 (copy) ]]
			v2:Disconnect()
		end)
	end

	table.clear(t6)

	for v3, v4 in t5 do
		if v4.Parent then
			v4:Destroy()
		end
	end

	table.clear(t5)
end

local function trackRowConn(p1) --[[ trackRowConn | Line: 539 | Upvalues: t6 (copy) ]]
	table.insert(t6, p1)
end

local function buildSortedMembers(p1, p2) --[[ buildSortedMembers | Line: 543 | Upvalues: t7 (copy) ]]
	local t = {}

	if p1 and typeof(p1.Members) == "table" then
		for v1, v2 in p1.Members do
			local v3 = tonumber(v1)

			if v3 then
				local t2 = {
					weeklyShekels = 0,
					displayName = nil,
					userId = v3
				}

				t2.role = tostring(v2.Role or "Member")
				t2.lifetimeShekels = tonumber(v2.LifetimeContribution) or 0
				t[v3] = t2
			end
		end
	end

	if typeof(p2) == "table" then
		for v5, v6 in p2 do
			local v8 = tonumber(v6.userId or v6.UserId)

			if v8 and t[v8] then
				t[v8].weeklyShekels = tonumber(v6.shekels or v6.Shekels) or 0

				if typeof(v6.name) == "string" then
					t[v8].displayName = v6.name
					t7[v8] = v6.name
				end
			end
		end
	end

	local t2 = {}

	for v11, v12 in t do
		table.insert(t2, v12)
	end

	table.sort(t2, function(p1, p2) --[[ Line: 579 ]]
		if p1.weeklyShekels == p2.weeklyShekels then
			if p1.lifetimeShekels == p2.lifetimeShekels then
				return p1.userId < p2.userId
			end

			return p1.lifetimeShekels > p2.lifetimeShekels
		end

		return p1.weeklyShekels > p2.weeklyShekels
	end)

	return t2
end

local v40 = nil

local function renderMemberRow(p1, p2, p3, p4, p5, p6) --[[ renderMemberRow | Line: 599 | Upvalues: t5 (copy), LocalPlayer (copy), Players (copy), t7 (copy), fetchName (copy), GuildCompetition (copy), v30 (ref), t8 (copy), t9 (copy), v35 (copy), v36 (copy), v17 (ref), v18 (ref), Networking (copy), NotificationController (copy), v40 (ref), t6 (copy), LeaveGuildController (copy) ]]
	local v1 = p1:Clone()

	v1.Name = ("Member_%*"):format(p4.userId)
	v1.LayoutOrder = p3
	v1.Visible = true
	v1.Parent = p2

	local v2 = t5

	table.insert(v2, v1)

	local ContainerFrame = v1:FindFirstChild("ContainerFrame")

	if not ContainerFrame then
		return
	end

	local v3 = if p4.role == "Owner" or p4.role == "Leader" then true elseif typeof(p5) == "table" then if p5.LeaderUserId == p4.userId then true else false else false
	local v4 = if p4.role == "Elder" then true else false
	local v5 = if p4.userId == LocalPlayer.UserId then true else false
	local v6 = if p6 == "Owner" then true else false
	local Username = ContainerFrame:FindFirstChild("Username")

	if Username and Username:IsA("TextLabel") then
		local userId = p4.userId
		local v7 = Players:GetPlayerByUserId(userId)
		local v8 = if v7 then v7.Name else nil
		local v9

		if v8 then
			t7[userId] = v8
			v9 = v8
		else
			v9 = t7[userId] or tostring(userId)
		end

		if Username then
			Username.RichText = true
			Username.Text = v9

			local TextLabel = Username:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = true
				TextLabel.Text = v9
			end
		end

		fetchName(p4.userId, function(p1) --[[ Line: 631 | Upvalues: Username (copy) ]]
			if not Username.Parent then
				return
			end

			local v1 = Username

			if not v1 then
				return
			end

			v1.RichText = true
			v1.Text = p1

			local TextLabel = v1:FindFirstChild("TextLabel")

			if not (TextLabel and TextLabel:IsA("TextLabel")) then
				return
			end

			TextLabel.RichText = true
			TextLabel.Text = p1
		end)
	end

	local Role_Rank = ContainerFrame:FindFirstChild("Role_Rank")

	if Role_Rank and Role_Rank:IsA("TextLabel") then
		Role_Rank.RichText = true
		Role_Rank.Text = string.format("%s | #%d", p4.role, p3)
	end

	local Contributions = ContainerFrame:FindFirstChild("Contributions")
	local v11 = if Contributions then Contributions:FindFirstChild("Weekly") else Contributions
	local v12 = if v11 then v11:FindFirstChild("TextLabel") else v11

	if v12 and v12:IsA("TextLabel") then
		v12.RichText = true

		local format = string.format
		local v14 = tonumber(p4.weeklyShekels)
		local v15 = v30
		local v16

		if typeof(v15) == "table" then
			local v172 = if typeof(v15.config) == "table" then v15.config else v15.lastConfig

			v16 = if typeof(v172) == "table" then if typeof(v172.scoreFormat) == "string" then v172.scoreFormat else nil else nil
		else
			v16 = nil
		end

		v12.Text = format("<font color=\"#F9D100\">%s</font>", GuildCompetition.FormatScore(v14, v16) .. "kg")
	end

	local PlayerDisplay = ContainerFrame:FindFirstChild("PlayerDisplay")
	local v182 = PlayerDisplay and PlayerDisplay:FindFirstChild("MemberImage")

	if v182 and v182:IsA("ImageLabel") then
		local userId = p4.userId

		local function f19(p1) --[[ Line: 660 | Upvalues: v182 (copy) ]]
			if not v182.Parent then
				return
			end

			v182.Image = p1
		end

		if t8[userId] then
			local v20 = t8[userId]

			if v182.Parent then
				v182.Image = v20
			end
		else
			task.spawn(function() --[[ Line: 357 | Upvalues: Players (ref), userId (copy), t8 (ref), f19 (copy) ]]
				local ok, result = pcall(function() --[[ Line: 358 | Upvalues: Players (ref), userId (ref) ]]
					return Players:GetUserThumbnailAsync(p1, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
				end)

				if not ok or typeof(result) ~= "string" then
					return
				end

				t8[userId] = result
				f19(result)
			end)
		end
	end

	local v21 = PlayerDisplay and PlayerDisplay:FindFirstChild("GuildOwnerIcon")

	if v21 and v21:IsA("ImageLabel") then
		v21.Visible = v3
	end

	local v22 = PlayerDisplay and PlayerDisplay:FindFirstChild("Status")

	if v22 and v22:IsA("Frame") then
		local v25 = t9[typeof(p5) == "table" and tostring(p5.GuildId or "") or ""]
		local v26 = if p4.userId == LocalPlayer.UserId then true else false
		local v27 = if Players:GetPlayerByUserId(p4.userId) == nil then false else true

		v22.BackgroundColor3 = if if v26 then v26 elseif v27 then v27 elseif v25 == nil then false elseif v25[p4.userId] == true then true else false then v35 else v36
	end

	local KickButton = ContainerFrame:FindFirstChild("KickButton")

	if KickButton and KickButton:IsA("GuiButton") then
		local v31 = if v6 then not v5 else v6

		KickButton.Visible = v31

		if v31 then
			local v32 = KickButton.MouseButton1Click:Connect(function() --[[ Line: 700 | Upvalues: v1 (copy), v17 (ref), p5 (copy), t5 (ref), v18 (ref), Networking (ref), p4 (copy), NotificationController (ref), v40 (ref), Players (ref), t7 (ref) ]]
				if not v1.Parent then
					return
				end

				v1:Destroy()

				if v17 and typeof(p5) == "table" then
					local count = 0

					for v2, v3 in t5 do
						if v3.Parent then
							count = count + 1
						end
					end

					local v5 = string.format("%d/%d", count, tonumber(p5.MaxSlots) or 0)
					local v6 = v17

					if v6 then
						v6.RichText = true
						v6.Text = v5

						local TextLabel = v6:FindFirstChild("TextLabel")

						if TextLabel and TextLabel:IsA("TextLabel") then
							TextLabel.RichText = true
							TextLabel.Text = v5
						end
					end

					if v18 then
						v18.RichText = true
						v18.Text = v5
					end
				end

				task.spawn(function() --[[ Line: 728 | Upvalues: Networking (ref), p4 (ref), NotificationController (ref), v40 (ref), Players (ref), t7 (ref) ]]
					local ok, result, result2 = pcall(function() --[[ Line: 729 | Upvalues: Networking (ref), p4 (ref) ]]
						return Networking.Guild.Kick:Fire(p4.userId)
					end)

					if ok and result then
						local format = string.format
						local userId = p4.userId
						local v3 = Players:GetPlayerByUserId(userId)
						local v4 = if v3 then v3.Name else nil
						local v5

						if v4 then
							t7[userId] = v4
							v5 = v4
						else
							v5 = t7[userId] or tostring(userId)
						end

						NotificationController:CreateNotification(format("Kicked %s", v5))
					else
						NotificationController:CreateNotification(if typeof(result2) == "string" and (result2 ~= "" and result2) then result2 else "Could not kick that member")
					end

					v40()
				end)
			end)

			table.insert(t6, v32)
		end
	end

	local function countElders() --[[ countElders | Line: 759 | Upvalues: p5 (copy) ]]
		local count = 0

		if typeof(p5) == "table" and typeof(p5.Members) == "table" then
			for v2, v3 in p5.Members do
				if v3.Role == "Elder" then
					count = count + 1
				end
			end
		end

		return count
	end

	local RankButton = ContainerFrame:FindFirstChild("RankButton")

	if RankButton and RankButton:IsA("GuiButton") then
		local v34 = if v6 then not v5 and (not v3 and not v4) else v6

		RankButton.Visible = v34

		if v34 then
			local v352 = RankButton.MouseButton1Click:Connect(function() --[[ Line: 780 | Upvalues: p5 (copy), NotificationController (ref), Networking (ref), p4 (copy), v40 (ref) ]]
				local count = 0

				if typeof(p5) == "table" and typeof(p5.Members) == "table" then
					for v2, v3 in p5.Members do
						if v3.Role == "Elder" then
							count = count + 1
						end
					end
				end

				if count >= 5 then
					NotificationController:CreateNotification(string.format("You already have %d/%d elders ranked!", 5, 5))

					return
				end

				local count2 = 0

				if typeof(p5) == "table" and typeof(p5.Members) == "table" then
					for v5, v6 in p5.Members do
						if v6.Role == "Elder" then
							count2 = count2 + 1
						end
					end
				end

				local v7 = count2

				task.spawn(function() --[[ Line: 797 | Upvalues: Networking (ref), p4 (ref), NotificationController (ref), v7 (copy), v40 (ref) ]]
					local ok, result, result2 = pcall(function() --[[ Line: 798 | Upvalues: Networking (ref), p4 (ref) ]]
						return Networking.Guild.Promote:Fire(p4.userId)
					end)

					if ok and result then
						NotificationController:CreateNotification(string.format("You ranked %d/%d elders!", math.min(v7 + 1, 5), 5))
						v40()

						return
					end

					if typeof(result2) == "string" and result2 == "elder_limit_reached" then
						NotificationController:CreateNotification(string.format("You already have %d/%d elders ranked!", 5, 5))

						return
					end

					NotificationController:CreateNotification(if typeof(result2) == "string" and (result2 ~= "" and result2) then result2 else "Could not rank that member")
				end)
			end)

			table.insert(t6, v352)
		end
	end

	local UnRankButton = ContainerFrame:FindFirstChild("UnRankButton")

	if UnRankButton and UnRankButton:IsA("GuiButton") then
		local v37 = if v6 then not v5 and v4 else v6

		UnRankButton.Visible = v37

		if v37 then
			local v38 = UnRankButton.MouseButton1Click:Connect(function() --[[ Line: 834 | Upvalues: Networking (ref), p4 (copy), NotificationController (ref), Players (ref), t7 (ref), v40 (ref) ]]
				task.spawn(function() --[[ Line: 835 | Upvalues: Networking (ref), p4 (ref), NotificationController (ref), Players (ref), t7 (ref), v40 (ref) ]]
					local ok, result, result2 = pcall(function() --[[ Line: 836 | Upvalues: Networking (ref), p4 (ref) ]]
						return Networking.Guild.Demote:Fire(p4.userId)
					end)

					if ok and result then
						local format = string.format
						local userId = p4.userId
						local v3 = Players:GetPlayerByUserId(userId)
						local v4 = if v3 then v3.Name else nil
						local v5

						if v4 then
							t7[userId] = v4
							v5 = v4
						else
							v5 = t7[userId] or tostring(userId)
						end

						NotificationController:CreateNotification(format("Unranked %s from Elder", v5))
						v40()
					else
						NotificationController:CreateNotification(if typeof(result2) == "string" and (result2 ~= "" and result2) then result2 else "Could not unrank that member")
					end
				end)
			end)

			table.insert(t6, v38)
		end
	end

	local LeaveButton = ContainerFrame:FindFirstChild("LeaveButton")

	if not (LeaveButton and LeaveButton:IsA("GuiButton")) then
		return
	end

	LeaveButton.Visible = v5

	if not v5 then
		return
	end

	local v402 = if v3 then "Disband" else "Leave"
	local TextLabel = LeaveButton:FindFirstChild("TextLabel")

	if TextLabel and (TextLabel:IsA("TextLabel") and TextLabel) then
		TextLabel.RichText = true
		TextLabel.Text = v402

		local TextLabel2 = TextLabel:FindFirstChild("TextLabel")

		if TextLabel2 and TextLabel2:IsA("TextLabel") then
			TextLabel2.RichText = true
			TextLabel2.Text = v402
		end
	end

	local v41 = LeaveButton.MouseButton1Click:Connect(function() --[[ Line: 866 | Upvalues: p5 (copy), v3 (copy), LeaveGuildController (ref) ]]
		local v2

		if typeof(p5) == "table" then
			v2 = {}
			v2.Name = if typeof(p5.Name) == "string" then p5.Name else nil
			v2.Tag = if typeof(p5.Tag) == "string" then p5.Tag else nil
			v2.Color = if typeof(p5.Color) == "string" then p5.Color else nil
			v2.IsOwner = v3
		else
			v2 = nil
		end

		LeaveGuildController:Open(v2)
	end)

	table.insert(t6, v41)
end

local function getCachedSlotsPriceText(p1) --[[ getCachedSlotsPriceText | Line: 882 | Upvalues: t (copy), DevProductController (copy) ]]
	local v1 = nil

	for v2, v3 in t do
		if v3.From <= p1 and p1 < v3.To then
			v1 = v3

			break
		end
	end

	if not v1 then
		return "MAX"
	end

	local v4 = DevProductController:GetPreloadedProductInfo(v1.Key)

	return string.format("%d R$", v4 and tonumber(v4.PriceInRobux) or v1.FallbackPrice)
end

local function renderAddSlotsFrame(p1, p2, p3) --[[ renderAddSlotsFrame | Line: 892 | Upvalues: v21 (ref), v22 (ref), t (copy), DevProductController (copy) ]]
	if not v21 then
		return
	end

	local v1 = p2 and tonumber(p2.MaxSlots) or 0
	local v3 = if p3 == "Owner" then true else false

	v21.Visible = if v3 then not (if v1 >= 50 then true else false) else v3
	v21.LayoutOrder = 1000000

	local ContainerFrame = v21:FindFirstChild("ContainerFrame")
	local v6 = if ContainerFrame then ContainerFrame:FindFirstChild("Contributions") else ContainerFrame

	if v6 then
		local AddMemberSlotsTextLabel = v6:FindFirstChild("AddMemberSlotsTextLabel")

		if AddMemberSlotsTextLabel and AddMemberSlotsTextLabel:IsA("TextLabel") then
			AddMemberSlotsTextLabel.Text = string.format("+%d MEMBER SLOTS", 5)
		end
	end

	if not v22 then
		return
	end

	local TextLabel = v22:FindFirstChild("TextLabel")

	if not (TextLabel and TextLabel:IsA("TextLabel")) then
		return
	end

	local v7 = nil

	for v8, v9 in t do
		if v9.From <= v1 and v1 < v9.To then
			v7 = v9

			break
		end
	end

	local v10

	if v7 then
		local v11 = DevProductController:GetPreloadedProductInfo(v7.Key)

		v10 = string.format("%d R$", v11 and tonumber(v11.PriceInRobux) or v7.FallbackPrice)
	else
		v10 = "MAX"
	end

	if not TextLabel then
		return
	end

	TextLabel.RichText = true
	TextLabel.Text = v10

	local TextLabel2 = TextLabel:FindFirstChild("TextLabel")

	if not (TextLabel2 and TextLabel2:IsA("TextLabel")) then
		return
	end

	TextLabel2.RichText = true
	TextLabel2.Text = v10
end

local function applyPresenceToRows(p1) --[[ applyPresenceToRows | Line: 924 | Upvalues: v27 (ref), t9 (copy), t5 (copy), LocalPlayer (copy), Players (copy), v35 (copy), v36 (copy) ]]
	if not v27 then
		return
	end

	local v1 = t9[p1]

	for v2, v3 in t5 do
		if v3.Parent then
			local ContainerFrame = v3:FindFirstChild("ContainerFrame")
			local v4 = if ContainerFrame then ContainerFrame:FindFirstChild("PlayerDisplay") else ContainerFrame
			local v5 = if v4 then v4:FindFirstChild("Status") else v4

			if v5 and v5:IsA("Frame") then
				local v6 = string.match(v3.Name, "^Member_(%d+)$")
				local v7 = if v6 then tonumber(v6) else v6

				if v7 then
					local v8 = if v7 == LocalPlayer.UserId then true else false
					local v9 = if Players:GetPlayerByUserId(v7) == nil then false else true

					v5.BackgroundColor3 = if if v8 then v8 elseif v9 then v9 elseif v1 == nil then false elseif v1[v7] == true then true else false then v35 else v36
				end
			end
		end
	end
end

local function computeOnlineMemberCount(p1, p2) --[[ computeOnlineMemberCount | Line: 954 | Upvalues: t9 (copy), LocalPlayer (copy), Players (copy) ]]
	local v1 = t9[p1]
	local t = {}
	local count = 0

	if typeof(p2) == "table" then
		for v2 in p2 do
			local v3 = tonumber(v2)

			if v3 and not t[v3] then
				local v4 = if Players:GetPlayerByUserId(v3) == nil then false else true

				if v3 == LocalPlayer.UserId or (v4 or (if v1 == nil then false elseif v1[v3] == true then true else false)) then
					t[v3] = true
					count = count + 1
				end
			end
		end
	end

	if v1 then
		for v6 in v1 do
			if not t[v6] then
				count = count + 1
			end
		end
	end

	return count
end

local function updateOnlineCount(p1, p2) --[[ updateOnlineCount | Line: 983 | Upvalues: v16 (ref), computeOnlineMemberCount (copy) ]]
	if not (v16 and v16.Parent) then
		return
	end

	local v2 = v16
	local v3 = string.format("Members (%d online)", (computeOnlineMemberCount(p1, p2)))

	if not v2 then
		return
	end

	v2.RichText = true
	v2.Text = v3

	local TextLabel = v2:FindFirstChild("TextLabel")

	if not (TextLabel and TextLabel:IsA("TextLabel")) then
		return
	end

	TextLabel.RichText = true
	TextLabel.Text = v3
end

local function fetchOnlineMembersFor(p1) --[[ fetchOnlineMembersFor | Line: 993 | Upvalues: t10 (copy), Networking (copy), t9 (copy), applyPresenceToRows (copy), v24 (ref), v16 (ref), computeOnlineMemberCount (copy) ]]
	if p1 == "" then
		return
	end

	if not t10[p1] then
		t10[p1] = true
		task.spawn(function() --[[ Line: 1001 | Upvalues: Networking (ref), p1 (copy), t10 (ref), t9 (ref), applyPresenceToRows (ref), v24 (ref), v16 (ref), computeOnlineMemberCount (ref) ]]
			local ok, result = pcall(function() --[[ Line: 1002 | Upvalues: Networking (ref), p1 (ref) ]]
				return Networking.Guild.GetOnlineMembers:Fire(p1)
			end)

			t10[p1] = nil

			if not ok or typeof(result) ~= "table" then
				return
			end

			local t2 = {}

			for v1, v2 in result do
				local v3 = tonumber(v2)

				if v3 then
					t2[v3] = true
				end
			end

			t9[p1] = t2
			applyPresenceToRows(p1)

			if not (v24 and v24.Guild) then
				return
			end

			if tostring(v24.Guild.GuildId or "") ~= p1 then
				return
			end

			local v5 = p1

			if not v16 then
				return
			end

			if not v16.Parent then
				return
			end

			local v7 = v16
			local v8 = string.format("Members (%d online)", (computeOnlineMemberCount(v5, v24.Guild.Members)))

			if not v7 then
				return
			end

			v7.RichText = true
			v7.Text = v8

			local TextLabel = v7:FindFirstChild("TextLabel")

			if not (TextLabel and TextLabel:IsA("TextLabel")) then
				return
			end

			TextLabel.RichText = true
			TextLabel.Text = v8
		end)
	end
end

local function applyCompetitionHeader() --[[ applyCompetitionHeader | Line: 1036 | Upvalues: v6 (ref), v30 (ref), v7 (ref) ]]
	if not v6 then
		return
	end

	local v1 = v30
	local v2 = if typeof(v1) == "table" then v1.phase else nil

	if v2 == "running" and (typeof(v1.config) == "table" and (typeof(v1.config.displayName) == "string" and v1.config.displayName ~= "")) then
		local v8 = v6
		local displayName2 = v1.config.displayName

		if v8 then
			v8.RichText = true
			v8.Text = displayName2

			local TextLabel = v8:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = true
				TextLabel.Text = displayName2
			end
		end
	else
		local v3, v4, v5, v62, v72

		if v2 == "pending" then
			v3 = v6

			if v6 then
				v6.RichText = true
				v6.Text = "Upcoming Competition"
				v4 = v6:FindFirstChild("TextLabel")

				if v4 and v4:IsA("TextLabel") then
					v4.RichText = true
					v4.Text = "Upcoming Competition"
				end
			end
		else
			v5 = v6
			v62 = if v1 == nil then "Loading..." else "No Active Competition"

			if v6 then
				v6.RichText = true
				v6.Text = v62
				v72 = v6:FindFirstChild("TextLabel")

				if v72 and v72:IsA("TextLabel") then
					v72.RichText = true
					v72.Text = v62
				end
			end
		end
	end

	if not v7 then
		return
	end

	if v2 == "running" and (typeof(v1.config) == "table" and typeof(v1.config.description) == "table") then
		local t = {}

		for v9, v10 in v1.config.description do
			if typeof(v10) == "string" then
				table.insert(t, v10)
			end
		end

		local v11 = v7
		local v12 = table.concat(t, "\n")

		if not v11 then
			return
		end

		v11.RichText = true
		v11.Text = v12

		local TextLabel = v11:FindFirstChild("TextLabel")

		if TextLabel and TextLabel:IsA("TextLabel") then
			TextLabel.RichText = true
			TextLabel.Text = v12
		end

		return
	end

	local v13 = v7

	if not v13 then
		return
	end

	v13.RichText = true
	v13.Text = ""

	local TextLabel = v13:FindFirstChild("TextLabel")

	if not (TextLabel and TextLabel:IsA("TextLabel")) then
		return
	end

	TextLabel.RichText = true
	TextLabel.Text = ""
end

local function renderScoreLine() --[[ renderScoreLine | Line: 1070 | Upvalues: v12 (ref), v33 (ref), v34 (ref), findGuildLeaderboardScore (copy), GuildCompetition (copy), v30 (ref), findGlobalRank (copy) ]]
	if not v12 then
		return
	end

	local v1 = v33

	if typeof(v1) == "string" and v1 ~= "" then
		local v2 = v34
		local v3 = findGuildLeaderboardScore(v1)

		if v3 and v2 < v3 then
			v2 = v3
		end

		local v4 = v30
		local v5, v6

		if typeof(v4) == "table" then
			local v7 = if typeof(v4.config) == "table" then v4.config else v4.lastConfig

			if typeof(v7) == "table" and typeof(v7.scoreFormat) == "string" then
				v5 = v7.scoreFormat
				v6 = v2
			else
				v6 = v2
				v5 = nil
			end
		else
			v6 = v2
			v5 = nil
		end

		local v8 = GuildCompetition.FormatScore(v6, v5) .. "kg"
		local v9 = findGlobalRank(v1)

		if v9 then
			local v10 = v12
			local v11 = ("Score: %s  \226\128\162  Rank #%d"):format(v8, v9)

			if not v10 then
				return
			end

			v10.RichText = true
			v10.Text = v11

			local TextLabel = v10:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = true
				TextLabel.Text = v11
			end
		else
			local v122 = v12
			local v13 = "Score: " .. v8

			if not v122 then
				return
			end

			v122.RichText = true
			v122.Text = v13

			local TextLabel = v122:FindFirstChild("TextLabel")

			if not (TextLabel and TextLabel:IsA("TextLabel")) then
				return
			end

			TextLabel.RichText = true
			TextLabel.Text = v13
		end
	else
		local v14 = v12

		if not v14 then
			return
		end

		v14.RichText = true
		v14.Text = "Score: 0"

		local TextLabel = v14:FindFirstChild("TextLabel")

		if not (TextLabel and TextLabel:IsA("TextLabel")) then
			return
		end

		TextLabel.RichText = true
		TextLabel.Text = "Score: 0"
	end
end

local function refreshHeader() --[[ refreshHeader | Line: 1094 | Upvalues: v3 (ref), v37 (ref), v32 (ref), Networking (copy), v30 (ref), v31 (ref), v39 (ref), v4 (ref), v5 (ref), formatTimeRemaining (copy), v8 (ref), applyCompetitionHeader (copy) ]]
	if v3 then
		local v1 = v3
		local v2 = if v37 then "Viewing Guild" else "My Guild"

		if v1 then
			v1.RichText = true
			v1.Text = v2

			local TextLabel = v1:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = true
				TextLabel.Text = v2
			end
		end
	end

	local v33 = os.clock()

	if not (v33 - v32 < 15) then
		v32 = v33
		task.spawn(function() --[[ Line: 240 | Upvalues: Networking (ref), v30 (ref), v31 (ref), v39 (ref) ]]
			local ok, result = pcall(function() --[[ Line: 241 | Upvalues: Networking (ref) ]]
				return Networking.Guild.GetCompetition:Fire()
			end)

			if not ok or typeof(result) ~= "table" then
				return
			end

			local v1 = v30
			local v2

			if typeof(v1) == "table" then
				local v3 = if typeof(v1.config) == "table" then v1.config else v1.lastConfig

				v2 = if typeof(v3) == "table" then if typeof(v3.scoreFormat) == "string" then v3.scoreFormat else nil else nil
			else
				v2 = nil
			end

			v30 = result

			if result.phase == "running" and typeof(result.endsAt) == "number" then
				v31 = result.endsAt
			else
				local v4

				if result.phase == "pending" then
					v4 = result.startsAt
					v31 = if typeof(v4) == "number" then result.startsAt else nil
				else
					v31 = nil
				end
			end

			local v5 = result
			local v6

			if typeof(v5) == "table" then
				local v7 = if typeof(v5.config) == "table" then v5.config else v5.lastConfig

				v6 = if typeof(v7) == "table" then if typeof(v7.scoreFormat) == "string" then v7.scoreFormat else nil else nil
			else
				v6 = nil
			end

			if v6 == v2 then
				return
			end

			local v8 = v39

			if not v8 then
				return
			end

			v8()
		end)
	end

	local v42 = os.time()
	local v52 = if v31 and v42 < v31 then v31 else nil

	if v4 then
		v4.Visible = v52 ~= nil
	end

	if not v52 then
		applyCompetitionHeader()

		return
	end

	if v5 then
		local v82 = v5
		local v9 = formatTimeRemaining(v52 - v42)

		if v82 then
			v82.RichText = true
			v82.Text = v9

			local TextLabel = v82:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = true
				TextLabel.Text = v9
			end
		end
	end

	if not v8 then
		applyCompetitionHeader()

		return
	end

	v8.Offset = Vector2.new(math.clamp((v42 - (v52 - 604800)) / 604800, 0, 1) + -0.5, 0)
	applyCompetitionHeader()
end

local function applyGuildSnapshot(p1) --[[ applyGuildSnapshot | Line: 1125 | Upvalues: v24 (ref), clearRows (copy), setTitleLabels (copy), v11 (ref), v33 (ref), v34 (ref), renderScoreLine (copy), v16 (ref), v17 (ref), v18 (ref), v21 (ref), v15 (ref), Asserts (copy), applyGuildTitle (copy), t4 (copy), computeOnlineMemberCount (copy), v13 (ref), v14 (ref), v19 (ref), v20 (ref), buildSortedMembers (copy), renderMemberRow (copy), renderAddSlotsFrame (copy), t10 (copy), Networking (copy), t9 (copy), applyPresenceToRows (copy) ]]
	v24 = p1

	if p1 and typeof(p1) == "table" then
		local Guild = p1.Guild
		local Role = p1.Role

		applyGuildTitle(Guild)

		local IconId = Guild.IconId

		if v15 then
			v15.Image = Asserts.IconAssetString(if typeof(IconId) == "number" then IconId else nil)
		end

		local v2 = v11
		local v4 = tostring(Guild.Description or "")

		if v2 then
			v2.RichText = false
			v2.Text = v4

			local TextLabel = v2:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = false
				TextLabel.Text = v4
			end
		end

		local v6 = tostring(Guild.GuildId or "")
		local v7 = t4[v6]
		local sum = 0

		if typeof(v7) == "table" then
			for v8, v9 in v7 do
				sum = sum + (tonumber(v9.shekels or v9.Shekels) or 0)
			end
		end

		v33 = v6
		v34 = sum
		renderScoreLine()

		local count = 0

		if typeof(Guild.Members) == "table" then
			for v112 in Guild.Members do
				count = count + 1
			end
		end

		local v132 = string.format("%d/%d", count, tonumber(Guild.MaxSlots) or 0)
		local v142 = v17

		if v142 then
			v142.RichText = true
			v142.Text = v132

			local TextLabel = v142:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = true
				TextLabel.Text = v132
			end
		end

		if v18 then
			v18.RichText = true
			v18.Text = v132
		end

		local Members2 = Guild.Members

		if v16 and v16.Parent then
			local v162 = v16
			local v172 = string.format("Members (%d online)", (computeOnlineMemberCount(v6, Members2)))

			if v162 then
				v162.RichText = true
				v162.Text = v172

				local TextLabel = v162:FindFirstChild("TextLabel")

				if TextLabel and TextLabel:IsA("TextLabel") then
					TextLabel.RichText = true
					TextLabel.Text = v172
				end
			end
		end

		if v13 then
			v13.Visible = Role == "Owner"
		end

		if v14 then
			v14.Visible = if Role == "Owner" then true elseif Role == "Elder" then true else false
		end

		clearRows()

		if v19 and v20 then
			for v22, v23 in buildSortedMembers(Guild, v7) do
				renderMemberRow(v20, v19, v22, v23, Guild, Role)
			end
		end

		if v19 then
			renderAddSlotsFrame(v19, Guild, Role)
		end

		if v6 == "" then
			return
		end

		if not t10[v6] then
			t10[v6] = true
			task.spawn(function() --[[ Line: 1001 | Upvalues: Networking (ref), v6 (copy), t10 (ref), t9 (ref), applyPresenceToRows (ref), v24 (ref), v16 (ref), computeOnlineMemberCount (ref) ]]
				local ok, result = pcall(function() --[[ Line: 1002 | Upvalues: Networking (ref), v6 (ref) ]]
					return Networking.Guild.GetOnlineMembers:Fire(p1)
				end)

				t10[v6] = nil

				if not ok or typeof(result) ~= "table" then
					return
				end

				local t2 = {}

				for v1, v2 in result do
					local v3 = tonumber(v2)

					if v3 then
						t2[v3] = true
					end
				end

				t9[v6] = t2
				applyPresenceToRows(v6)

				if not (v24 and v24.Guild) then
					return
				end

				if tostring(v24.Guild.GuildId or "") ~= v6 then
					return
				end

				local v5 = v6

				if not v16 then
					return
				end

				if not v16.Parent then
					return
				end

				local v7 = v16
				local v8 = string.format("Members (%d online)", (computeOnlineMemberCount(v5, v24.Guild.Members)))

				if not v7 then
					return
				end

				v7.RichText = true
				v7.Text = v8

				local TextLabel = v7:FindFirstChild("TextLabel")

				if not (TextLabel and TextLabel:IsA("TextLabel")) then
					return
				end

				TextLabel.RichText = true
				TextLabel.Text = v8
			end)
		end
	else
		clearRows()
		setTitleLabels("")

		local v242 = v11

		if v242 then
			v242.RichText = false
			v242.Text = ""

			local TextLabel = v242:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = false
				TextLabel.Text = ""
			end
		end

		v33 = nil
		v34 = 0
		renderScoreLine()

		local v25 = v16

		if v25 then
			v25.RichText = true
			v25.Text = "Members (SOON)"

			local TextLabel = v25:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = true
				TextLabel.Text = "Members (SOON)"
			end
		end

		local v26 = v17

		if v26 then
			v26.RichText = true
			v26.Text = "0/0"

			local TextLabel = v26:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = true
				TextLabel.Text = "0/0"
			end
		end

		if v18 then
			v18.RichText = true
			v18.Text = "0/0"
		end

		if v21 then
			v21.Visible = false
		end

		if v15 then
			v15.Image = Asserts.IconAssetString(nil)
		end
	end
end

local function applyExternalGuildSummary(p1) --[[ applyExternalGuildSummary | Line: 1221 | Upvalues: v24 (ref), clearRows (copy), setTitleLabels (copy), v11 (ref), v33 (ref), v34 (ref), renderScoreLine (copy), v16 (ref), v17 (ref), v18 (ref), v21 (ref), v15 (ref), Asserts (copy), applyGuildTitle (copy), t3 (ref), computeOnlineMemberCount (copy), v13 (ref), v14 (ref), v19 (ref), v20 (ref), buildSortedMembers (copy), renderMemberRow (copy), t10 (copy), Networking (copy), t9 (copy), applyPresenceToRows (copy) ]]
	if p1 and typeof(p1) == "table" then
		v24 = {
			Role = "Visitor",
			Guild = p1
		}
		applyGuildTitle(p1)

		local IconId = p1.IconId

		if v15 then
			v15.Image = Asserts.IconAssetString(if typeof(IconId) == "number" then IconId else nil)
		end

		local v2 = v11
		local v4 = tostring(p1.Description or "")

		if v2 then
			v2.RichText = false
			v2.Text = v4

			local TextLabel = v2:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = false
				TextLabel.Text = v4
			end
		end

		local v6 = tostring(p1.GuildId or "")
		local v7 = tonumber(p1.WeeklyShekels) or 0

		if v7 == 0 then
			for v8, v9 in t3 do
				if (v9.guildId or v9.GuildId) == v6 then
					v7 = tonumber(v9.shekels or v9.Shekels) or 0

					break
				end
			end
		end

		v33 = v6
		v34 = v7
		renderScoreLine()

		local v142 = string.format("%d/%d", tonumber(p1.MemberCount) or 0, tonumber(p1.MaxSlots) or 0)
		local v152 = v17

		if v152 then
			v152.RichText = true
			v152.Text = v142

			local TextLabel = v152:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = true
				TextLabel.Text = v142
			end
		end

		if v18 then
			v18.RichText = true
			v18.Text = v142
		end

		local Members = p1.Members

		if v16 and v16.Parent then
			local v172 = v16
			local v182 = string.format("Members (%d online)", (computeOnlineMemberCount(v6, Members)))

			if v172 then
				v172.RichText = true
				v172.Text = v182

				local TextLabel = v172:FindFirstChild("TextLabel")

				if TextLabel and TextLabel:IsA("TextLabel") then
					TextLabel.RichText = true
					TextLabel.Text = v182
				end
			end
		end

		if v13 then
			v13.Visible = false
		end

		if v14 then
			v14.Visible = false
		end

		if v21 then
			v21.Visible = false
		end

		clearRows()

		if v19 and v20 and typeof(p1.Members) == "table" then
			local t = {
				GuildId = p1.GuildId,
				LeaderUserId = p1.LeaderUserId,
				Members = p1.Members
			}
			local t2 = {}

			for v192, v202 in p1.Members do
				local v212 = tonumber(v192)

				if v212 then
					local t4 = {
						userId = v212
					}

					t4.shekels = tonumber(v202.WeeklyContribution) or 0
					t4.name = if typeof(v202.Name) == "string" then v202.Name else nil
					table.insert(t2, t4)
				end
			end

			for v242, v25 in buildSortedMembers(t, t2) do
				renderMemberRow(v20, v19, v242, v25, t, "Visitor")
			end
		end

		if v6 == "" then
			return
		end

		if not t10[v6] then
			t10[v6] = true
			task.spawn(function() --[[ Line: 1001 | Upvalues: Networking (ref), v6 (copy), t10 (ref), t9 (ref), applyPresenceToRows (ref), v24 (ref), v16 (ref), computeOnlineMemberCount (ref) ]]
				local ok, result = pcall(function() --[[ Line: 1002 | Upvalues: Networking (ref), v6 (ref) ]]
					return Networking.Guild.GetOnlineMembers:Fire(p1)
				end)

				t10[v6] = nil

				if not ok or typeof(result) ~= "table" then
					return
				end

				local t2 = {}

				for v1, v2 in result do
					local v3 = tonumber(v2)

					if v3 then
						t2[v3] = true
					end
				end

				t9[v6] = t2
				applyPresenceToRows(v6)

				if not (v24 and v24.Guild) then
					return
				end

				if tostring(v24.Guild.GuildId or "") ~= v6 then
					return
				end

				local v5 = v6

				if not v16 then
					return
				end

				if not v16.Parent then
					return
				end

				local v7 = v16
				local v8 = string.format("Members (%d online)", (computeOnlineMemberCount(v5, v24.Guild.Members)))

				if not v7 then
					return
				end

				v7.RichText = true
				v7.Text = v8

				local TextLabel = v7:FindFirstChild("TextLabel")

				if not (TextLabel and TextLabel:IsA("TextLabel")) then
					return
				end

				TextLabel.RichText = true
				TextLabel.Text = v8
			end)
		end
	else
		v24 = nil
		clearRows()
		setTitleLabels("")

		local v26 = v11

		if v26 then
			v26.RichText = false
			v26.Text = ""

			local TextLabel = v26:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = false
				TextLabel.Text = ""
			end
		end

		v33 = nil
		v34 = 0
		renderScoreLine()

		local v27 = v16

		if v27 then
			v27.RichText = true
			v27.Text = "Members (SOON)"

			local TextLabel = v27:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = true
				TextLabel.Text = "Members (SOON)"
			end
		end

		local v28 = v17

		if v28 then
			v28.RichText = true
			v28.Text = "0/0"

			local TextLabel = v28:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.RichText = true
				TextLabel.Text = "0/0"
			end
		end

		if v18 then
			v18.RichText = true
			v18.Text = "0/0"
		end

		if v21 then
			v21.Visible = false
		end

		if v15 then
			v15.Image = Asserts.IconAssetString(nil)
		end
	end
end

v39 = function() --[[ Line: 1312 | Upvalues: v27 (ref), v24 (ref), v37 (ref), applyExternalGuildSummary (copy), applyGuildSnapshot (copy), renderScoreLine (copy) ]]
	if not v27 then
		return
	end

	local v1 = v24

	if v37 then
		if typeof(v1) == "table" and v1.Guild then
			applyExternalGuildSummary(v1.Guild)
		end
	else
		if v1 ~= nil then
			applyGuildSnapshot(v1)

			return
		end

		renderScoreLine()
	end
end

local function fetchLeaderboard() --[[ fetchLeaderboard | Line: 1326 | Upvalues: Networking (copy), t3 (ref), v23 (ref), v27 (ref), v24 (ref), applyGuildTitle (copy), renderScoreLine (copy) ]]
	task.spawn(function() --[[ Line: 1331 | Upvalues: Networking (ref), t3 (ref), v23 (ref), v27 (ref), v24 (ref), applyGuildTitle (ref), renderScoreLine (ref) ]]
		local ok, result = pcall(function() --[[ Line: 1332 | Upvalues: Networking (ref) ]]
			return Networking.Guild.GetLeaderboard:Fire("weekly")
		end)

		if ok and (typeof(result) == "table" and #result > 0) then
			t3 = result
			v23 = "weekly"
		end

		if not (v27 and (v24 and v24.Guild)) then
			return
		end

		applyGuildTitle(v24.Guild)
		renderScoreLine()
	end)
end

v40 = function() --[[ fetchAndRender | Line: 1346 | Upvalues: v37 (ref), Networking (copy), v27 (ref), applyExternalGuildSummary (copy), v24 (ref), clearRows (copy), setTitleLabels (copy), v11 (ref), v33 (ref), v34 (ref), renderScoreLine (copy), v16 (ref), v17 (ref), v18 (ref), v21 (ref), v15 (ref), Asserts (copy), t3 (ref), v23 (ref), applyGuildTitle (copy), t4 (copy), applyGuildSnapshot (copy) ]]
	local v1 = v37

	task.spawn(function() --[[ Line: 1348 | Upvalues: v1 (copy), Networking (ref), v27 (ref), applyExternalGuildSummary (ref), v24 (ref), clearRows (ref), setTitleLabels (ref), v11 (ref), v33 (ref), v34 (ref), renderScoreLine (ref), v16 (ref), v17 (ref), v18 (ref), v21 (ref), v15 (ref), Asserts (ref), t3 (ref), v23 (ref), applyGuildTitle (ref), t4 (ref), applyGuildSnapshot (ref) ]]
		if v1 then
			local ok, result = pcall(function() --[[ Line: 1350 | Upvalues: Networking (ref), v1 (ref) ]]
				return Networking.Guild.GetGuildById:Fire(v1)
			end)

			if not v27 then
				return
			end

			if ok and result then
				applyExternalGuildSummary(result)
			else
				v24 = nil
				clearRows()
				setTitleLabels("")

				local v12 = v11

				if v12 then
					v12.RichText = false
					v12.Text = ""

					local TextLabel = v12:FindFirstChild("TextLabel")

					if TextLabel and TextLabel:IsA("TextLabel") then
						TextLabel.RichText = false
						TextLabel.Text = ""
					end
				end

				v33 = nil
				v34 = 0
				renderScoreLine()

				local v2 = v16

				if v2 then
					v2.RichText = true
					v2.Text = "Members (SOON)"

					local TextLabel = v2:FindFirstChild("TextLabel")

					if TextLabel and TextLabel:IsA("TextLabel") then
						TextLabel.RichText = true
						TextLabel.Text = "Members (SOON)"
					end
				end

				local v3 = v17

				if v3 then
					v3.RichText = true
					v3.Text = "0/0"

					local TextLabel = v3:FindFirstChild("TextLabel")

					if TextLabel and TextLabel:IsA("TextLabel") then
						TextLabel.RichText = true
						TextLabel.Text = "0/0"
					end
				end

				if v18 then
					v18.RichText = true
					v18.Text = "0/0"
				end

				if v21 then
					v21.Visible = false
				end

				if v15 then
					v15.Image = Asserts.IconAssetString(nil)
				end
			end

			task.spawn(function() --[[ Line: 1331 | Upvalues: Networking (ref), t3 (ref), v23 (ref), v27 (ref), v24 (ref), applyGuildTitle (ref), renderScoreLine (ref) ]]
				local ok, result = pcall(function() --[[ Line: 1332 | Upvalues: Networking (ref) ]]
					return Networking.Guild.GetLeaderboard:Fire("weekly")
				end)

				if ok and (typeof(result) == "table" and #result > 0) then
					t3 = result
					v23 = "weekly"
				end

				if not (v27 and (v24 and v24.Guild)) then
					return
				end

				applyGuildTitle(v24.Guild)
				renderScoreLine()
			end)
		else
			local ok, result = pcall(function() --[[ Line: 1363 | Upvalues: Networking (ref) ]]
				return Networking.Guild.GetMyGuild:Fire()
			end)

			if not v27 then
				return
			end

			if ok then
				if result and typeof(result) == "table" and (typeof(result.GuildmateContribs) == "table" and result.Guild and typeof(result.Guild.GuildId) == "string") then
					t4[result.Guild.GuildId] = result.GuildmateContribs
				end

				applyGuildSnapshot(result)
			else
				v24 = nil
				clearRows()
				setTitleLabels("")

				local v4 = v11

				if v4 then
					v4.RichText = false
					v4.Text = ""

					local TextLabel = v4:FindFirstChild("TextLabel")

					if TextLabel and TextLabel:IsA("TextLabel") then
						TextLabel.RichText = false
						TextLabel.Text = ""
					end
				end

				v33 = nil
				v34 = 0
				renderScoreLine()

				local v5 = v16

				if v5 then
					v5.RichText = true
					v5.Text = "Members (SOON)"

					local TextLabel = v5:FindFirstChild("TextLabel")

					if TextLabel and TextLabel:IsA("TextLabel") then
						TextLabel.RichText = true
						TextLabel.Text = "Members (SOON)"
					end
				end

				local v6 = v17

				if v6 then
					v6.RichText = true
					v6.Text = "0/0"

					local TextLabel = v6:FindFirstChild("TextLabel")

					if TextLabel and TextLabel:IsA("TextLabel") then
						TextLabel.RichText = true
						TextLabel.Text = "0/0"
					end
				end

				if v18 then
					v18.RichText = true
					v18.Text = "0/0"
				end

				if v21 then
					v21.Visible = false
				end

				if v15 then
					v15.Image = Asserts.IconAssetString(nil)
				end
			end

			task.spawn(function() --[[ Line: 1331 | Upvalues: Networking (ref), t3 (ref), v23 (ref), v27 (ref), v24 (ref), applyGuildTitle (ref), renderScoreLine (ref) ]]
				local ok, result = pcall(function() --[[ Line: 1332 | Upvalues: Networking (ref) ]]
					return Networking.Guild.GetLeaderboard:Fire("weekly")
				end)

				if ok and (typeof(result) == "table" and #result > 0) then
					t3 = result
					v23 = "weekly"
				end

				if not (v27 and (v24 and v24.Guild)) then
					return
				end

				applyGuildTitle(v24.Guild)
				renderScoreLine()
			end)
		end
	end)
end

local function startTimerLoop() --[[ startTimerLoop | Line: 1392 | Upvalues: v25 (ref), v27 (ref), refreshHeader (copy) ]]
	if not v25 then
		v25 = task.spawn(function() --[[ Line: 1394 | Upvalues: v27 (ref), refreshHeader (ref) ]]
			while v27 do
				refreshHeader()
				task.wait(1)
			end
		end)
	end
end

local function stopTimerLoop() --[[ stopTimerLoop | Line: 1402 | Upvalues: v25 (ref) ]]
	if not v25 then
		return
	end

	task.cancel(v25)
	v25 = nil
end

local function promptBuySlots() --[[ promptBuySlots | Line: 1410 | Upvalues: v29 (ref), NotificationController (copy), v28 (ref), v24 (ref), t (copy), DevProductController (copy), v27 (ref), Networking (copy), applyGuildSnapshot (copy) ]]
	local v1 = v29 - os.clock()

	if v1 > 0 then
		NotificationController:CreateNotification((("Purchase available in %*s"):format((math.ceil(v1)))))

		return
	end

	if v28 then
		return
	end

	if not v24 then
		NotificationController:CreateNotification("Only the guild owner can buy member slots")

		return
	end

	if v24.Role ~= "Owner" then
		NotificationController:CreateNotification("Only the guild owner can buy member slots")

		return
	end

	local v3 = tonumber(v24.Guild and v24.Guild.MaxSlots) or 0

	if v3 >= 50 then
		NotificationController:CreateNotification("Member slots are already at the maximum")

		return
	end

	local v4 = nil

	for v5, v6 in t do
		if v6.From <= v3 and v3 < v6.To then
			v4 = v6

			break
		end
	end

	if not v4 then
		NotificationController:CreateNotification("No matching slot tier")

		return
	end

	local Key = v4.Key

	v28 = true

	local v7 = nil
	local v8 = nil
	local v9 = nil

	v7 = DevProductController.PurchaseComplete:Connect(function(p1) --[[ Line: 1454 | Upvalues: Key (copy), v28 (ref), v7 (ref), v8 (ref), v9 (ref), v29 (ref), v3 (copy), v27 (ref), Networking (ref), applyGuildSnapshot (ref) ]]
		if p1 ~= Key then
			return
		end

		v28 = false

		if v7 then
			v7:Disconnect()
		end

		if v8 then
			v8:Disconnect()
		end

		if v9 then
			v9:Disconnect()
		end

		v29 = os.clock() + 9
		task.spawn(function() --[[ Line: 1467 | Upvalues: v3 (ref), v27 (ref), v29 (ref), Networking (ref), applyGuildSnapshot (ref) ]]
			local v1 = v3

			for i = 1, 6 do
				task.wait(1.5)

				if not v27 then
					break
				end

				local ok, result = pcall(function() --[[ Line: 1478 | Upvalues: Networking (ref) ]]
					return Networking.Guild.GetMyGuild:Fire()
				end)

				if ok and (result and result.Guild) then
					applyGuildSnapshot(result)

					if v1 < (tonumber(result.Guild.MaxSlots) or 0) then
						break
					end
				end
			end

			v29 = 0
		end)
	end)
	v8 = DevProductController.PurchaseFailed:Connect(function(p1) --[[ Line: 1495 | Upvalues: Key (copy), v28 (ref), v7 (ref), v8 (ref), v9 (ref) ]]
		if p1 ~= Key then
			return
		end

		v28 = false

		if v7 then
			v7:Disconnect()
		end

		if v8 then
			v8:Disconnect()
		end

		if not v9 then
			return
		end

		v9:Disconnect()
	end)
	v9 = DevProductController.PurchaseCancelled:Connect(function(p1) --[[ Line: 1503 | Upvalues: Key (copy), v28 (ref), v7 (ref), v8 (ref), v9 (ref) ]]
		if p1 ~= Key then
			return
		end

		v28 = false

		if v7 then
			v7:Disconnect()
		end

		if v8 then
			v8:Disconnect()
		end

		if not v9 then
			return
		end

		v9:Disconnect()
	end)

	local v10, v11 = DevProductController:PromptPurchase(Key)

	if v10 or v11 == "Prompted Robux" then
		return
	end

	v28 = false

	if v7 then
		v7:Disconnect()
	end

	if v8 then
		v8:Disconnect()
	end

	if not v9 then
		return
	end

	v9:Disconnect()
end

local function ResolveRefs(p1) --[[ ResolveRefs | Line: 1521 | Upvalues: v2 (ref), v3 (ref), v4 (ref), v5 (ref), v8 (ref), v9 (ref), v6 (ref), v7 (ref), v10 (ref), v11 (ref), v12 (ref), v13 (ref), v14 (ref), v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), v20 (ref), v21 (ref), v22 (ref) ]]
	local MainPage = p1:FindFirstChild("MainPage")

	if not MainPage then
		return
	end

	local Header = MainPage:FindFirstChild("Header")

	if Header then
		local ExitButton = Header:FindFirstChild("ExitButton")

		if ExitButton and ExitButton:IsA("GuiButton") then
			v2 = ExitButton
		end

		local TextLabel = Header:FindFirstChild("TextLabel")

		if TextLabel and TextLabel:IsA("TextLabel") then
			v3 = TextLabel
		end

		local WeeklyRefreshIn = Header:FindFirstChild("WeeklyRefreshIn")

		if WeeklyRefreshIn then
			if WeeklyRefreshIn:IsA("GuiObject") then
				v4 = WeeklyRefreshIn
			end

			local WeeklyTimer = WeeklyRefreshIn:FindFirstChild("WeeklyTimer")

			if WeeklyTimer and WeeklyTimer:IsA("TextLabel") then
				v5 = WeeklyTimer
			end

			local UIGradient = WeeklyRefreshIn:FindFirstChild("UIGradient")

			if UIGradient and UIGradient:IsA("UIGradient") then
				v8 = UIGradient
			end
		end

		local ExtraFrame = Header:FindFirstChild("ExtraFrame")

		if ExtraFrame then
			local ViewPlacementButton = ExtraFrame:FindFirstChild("ViewPlacementButton")

			if ViewPlacementButton and ViewPlacementButton:IsA("GuiButton") then
				v9 = ViewPlacementButton
			end
		end
	end

	local v1 = MainPage:FindFirstChild("Content")

	if not v1 then
		return
	end

	local WeeklyContributionsTitle = v1:FindFirstChild("WeeklyContributionsTitle")

	if WeeklyContributionsTitle and WeeklyContributionsTitle:IsA("TextLabel") then
		v6 = WeeklyContributionsTitle
	end

	local CompetitionDescription = v1:FindFirstChild("CompetitionDescription")

	if CompetitionDescription and CompetitionDescription:IsA("TextLabel") then
		v7 = CompetitionDescription
	end

	local GuildInfo = v1:FindFirstChild("GuildInfo")

	if GuildInfo then
		local GuildName_Rank = GuildInfo:FindFirstChild("GuildName_Rank")

		if GuildName_Rank and GuildName_Rank:IsA("TextLabel") then
			v10 = GuildName_Rank
		end

		local Description = GuildInfo:FindFirstChild("Description")

		if Description and Description:IsA("TextLabel") then
			v11 = Description
		end

		local TotalContribution = GuildInfo:FindFirstChild("TotalContribution")

		if TotalContribution and TotalContribution:IsA("TextLabel") then
			v12 = TotalContribution
		end

		local EditButton = GuildInfo:FindFirstChild("EditButton")

		if EditButton and EditButton:IsA("GuiButton") then
			v13 = EditButton
		end

		local InviteButton = GuildInfo:FindFirstChild("InviteButton")

		if InviteButton and InviteButton:IsA("GuiButton") then
			v14 = InviteButton
		end

		local BeanstalkDisplay = GuildInfo:FindFirstChild("BeanstalkDisplay")

		if BeanstalkDisplay then
			local BeanstalkSkinImage = BeanstalkDisplay:FindFirstChild("BeanstalkSkinImage")

			if BeanstalkSkinImage and BeanstalkSkinImage:IsA("ImageLabel") then
				v15 = BeanstalkSkinImage
			end
		end
	end

	local OnlineCount = v1:FindFirstChild("OnlineCount")

	if OnlineCount and OnlineCount:IsA("TextLabel") then
		v16 = OnlineCount
	end

	local MemberCountTextLabel1 = v1:FindFirstChild("MemberCountTextLabel1")

	if MemberCountTextLabel1 and MemberCountTextLabel1:IsA("TextLabel") then
		v17 = MemberCountTextLabel1

		local MemberCountTextLabel2 = MemberCountTextLabel1:FindFirstChild("MemberCountTextLabel2")

		if MemberCountTextLabel2 and MemberCountTextLabel2:IsA("TextLabel") then
			v18 = MemberCountTextLabel2
		end
	end

	local ScrollingFrame = v1:FindFirstChild("ScrollingFrame")

	if not (ScrollingFrame and ScrollingFrame:IsA("ScrollingFrame")) then
		return
	end

	v19 = ScrollingFrame

	local PlayerListTemplate = ScrollingFrame:FindFirstChild("PlayerListTemplate")

	if PlayerListTemplate and PlayerListTemplate:IsA("Frame") then
		v20 = PlayerListTemplate
		PlayerListTemplate.Visible = false
	end

	local AddMaxMembersFrame = ScrollingFrame:FindFirstChild("AddMaxMembersFrame")

	if not (AddMaxMembersFrame and AddMaxMembersFrame:IsA("Frame")) then
		return
	end

	v21 = AddMaxMembersFrame
	AddMaxMembersFrame.LayoutOrder = 1000000
	AddMaxMembersFrame.Visible = false

	local ContainerFrame = AddMaxMembersFrame:FindFirstChild("ContainerFrame")
	local v23 = if ContainerFrame then ContainerFrame:FindFirstChild("Contributions") else ContainerFrame
	local v32 = if v23 then v23:FindFirstChild("BuyMemberSlotsButton") else v23

	if not (v32 and v32:IsA("GuiButton")) then
		return
	end

	v22 = v32
end

local function BindButtons() --[[ BindButtons | Line: 1625 | Upvalues: v2 (ref), GuiController (copy), v38 (ref), v13 (ref), LocalPlayer (copy), v37 (ref), v14 (ref), v22 (ref), promptBuySlots (copy), v9 (ref) ]]
	if v2 then
		v2.MouseButton1Click:Connect(function() --[[ Line: 1627 | Upvalues: GuiController (ref), v38 (ref) ]]
			if not GuiController:IsOpen("ViewGuildPage") then
				return
			end

			local v1 = v38

			v38 = false

			if v1 then
				GuiController:Open("ViewGuildLeaderboard", nil, { "HUD" })

				if GuiController:IsOpen("ViewGuildPage") then
					GuiController:Close()
				end
			else
				GuiController:Close()
			end
		end)
	end

	if v13 then
		v13.MouseButton1Click:Connect(function() --[[ Line: 1654 | Upvalues: LocalPlayer (ref), v37 (ref), v38 (ref), GuiController (ref) ]]
			if LocalPlayer:GetAttribute("GuildRole") ~= "Owner" then
				return
			end

			if not v37 then
				GuiController:Open("EditGuild", nil, { "HUD" })
				v38 = v38
			end
		end)
	end

	if v14 then
		v14.MouseButton1Click:Connect(function() --[[ Line: 1674 | Upvalues: LocalPlayer (ref), v37 (ref), GuiController (ref) ]]
			local v1 = LocalPlayer:GetAttribute("GuildRole")

			if v1 ~= "Owner" and v1 ~= "Elder" then
				return
			end

			if not v37 then
				GuiController:Open("GuildInvite", nil, { "HUD" })
			end
		end)
	end

	if v22 then
		v22.MouseButton1Click:Connect(promptBuySlots)
	end

	if not v9 then
		return
	end

	v9.MouseButton1Click:Connect(function() --[[ Line: 1703 | Upvalues: v37 (ref), v38 (ref), LocalPlayer (ref), GuiController (ref) ]]
		local ViewGuildProgressController = require(LocalPlayer.PlayerScripts.Controllers.ViewGuildProgressController)

		if typeof(ViewGuildProgressController.SetTargetGuildId) == "function" then
			ViewGuildProgressController:SetTargetGuildId(v37 or LocalPlayer:GetAttribute("GuildId"))
		end

		GuiController:Open("ViewGuildProgress", nil, { "HUD" })
		v37 = v37
		v38 = v38
	end)
end

function t2.OpenForGuildId(p1, p2) --[[ OpenForGuildId | Line: 1722 | Upvalues: LocalPlayer (copy), v37 (ref), v38 (ref), GuiController (copy), v40 (ref) ]]
	if typeof(p2) ~= "string" or p2 == "" then
		return
	end

	v37 = if p2 == LocalPlayer:GetAttribute("GuildId") then nil else p2
	v38 = false

	if GuiController:IsOpen("ViewGuildPage") then
		v40()
	else
		GuiController:Open("ViewGuildPage", nil, { "HUD" })
	end
end
function t2.OpenForGuildIdFromLeaderboard(p1, p2) --[[ OpenForGuildIdFromLeaderboard | Line: 1747 | Upvalues: LocalPlayer (copy), v37 (ref), v38 (ref), GuiController (copy), v40 (ref) ]]
	if typeof(p2) ~= "string" or p2 == "" then
		return
	end

	v37 = if p2 == LocalPlayer:GetAttribute("GuildId") then nil else p2
	v38 = true

	if GuiController:IsOpen("ViewGuildPage") then
		v40()
	else
		GuiController:Open("ViewGuildPage", nil, { "HUD" })
	end
end
function t2.Init(p1) --[[ Init | Line: 1766 ]] end
function t2.Start(p1) --[[ Start | Line: 1768 | Upvalues: PlayerGui (copy), v1 (ref), ResolveRefs (copy), BindButtons (copy), LocalPlayer (copy), v27 (ref), v37 (ref), GuiController (copy), v40 (ref), Networking (copy), t3 (ref), v23 (ref), v24 (ref), applyGuildTitle (copy), renderScoreLine (copy), t4 (copy), applyGuildSnapshot (copy), t9 (copy), applyPresenceToRows (copy), v16 (ref), refreshHeader (copy), v25 (ref), v26 (ref), v38 (ref) ]]
	task.spawn(function() --[[ Line: 1769 | Upvalues: PlayerGui (ref), v1 (ref), ResolveRefs (ref), BindButtons (ref), LocalPlayer (ref), v27 (ref), v37 (ref), GuiController (ref), v40 (ref), Networking (ref), t3 (ref), v23 (ref), v24 (ref), applyGuildTitle (ref), renderScoreLine (ref), t4 (ref), applyGuildSnapshot (ref), t9 (ref), applyPresenceToRows (ref), v16 (ref), refreshHeader (ref), v25 (ref), v26 (ref), v38 (ref) ]]
		local ViewGuildPage = PlayerGui:WaitForChild("ViewGuildPage", 30)

		if ViewGuildPage and ViewGuildPage:IsA("ScreenGui") then
			v1 = ViewGuildPage
			ViewGuildPage.Enabled = false
			ResolveRefs(ViewGuildPage)
			BindButtons()
			LocalPlayer:GetAttributeChangedSignal("GuildId"):Connect(function() --[[ Line: 1780 | Upvalues: v27 (ref), v37 (ref), LocalPlayer (ref), GuiController (ref), v40 (ref) ]]
				if not v27 then
					return
				end

				if v37 then
					return
				end

				if LocalPlayer:GetAttribute("GuildId") == nil then
					if GuiController:IsOpen("ViewGuildPage") then
						GuiController:Close()
					end
				else
					v40()
				end
			end)
			Networking.Guild.TickUpdate.OnClientEvent:Connect(function(p1) --[[ Line: 1794 | Upvalues: t3 (ref), v23 (ref), v27 (ref), v24 (ref), applyGuildTitle (ref), renderScoreLine (ref), t4 (ref), v37 (ref), applyGuildSnapshot (ref), t9 (ref), applyPresenceToRows (ref), v16 (ref) ]]
				if typeof(p1) ~= "table" then
					return
				end

				if p1.Kind == "Leaderboard" then
					local v1 = if typeof(p1.Source) == "string" then p1.Source else nil

					if v1 == "weekly" then
						t3 = p1.TopGuilds or {}
						v23 = "weekly"
					else
						t3 = {}
						v23 = v1
					end

					if v27 and v24 then
						applyGuildTitle(v24.Guild)
						renderScoreLine()
					end
				elseif p1.Kind == "GuildmateContribs" then
					local v4 = tostring(p1.GuildId or "")

					if v4 ~= "" and typeof(p1.Members) == "table" then
						t4[v4] = p1.Members
					end

					if v27 and (v24 and not v37) then
						applyGuildSnapshot(v24)
					end
				else
					if p1.Kind ~= "GuildPresence" then
						return
					end

					local v6 = tostring(p1.GuildId or "")
					local UserIds = p1.UserIds

					if v6 == "" or typeof(UserIds) ~= "table" then
						return
					end

					local t = {}

					for v7, v8 in UserIds do
						local v9 = tonumber(v8)

						if v9 then
							t[v9] = true
						end
					end

					t9[v6] = t

					local count = 0

					for v10 in t do
						count = count + 1
					end

					if not (v27 and (v24 and v24.Guild)) then
						return
					end

					if tostring(v24.Guild.GuildId or "") ~= v6 then
						return
					end

					applyPresenceToRows(v6)

					if not (v16 and v16.Parent) then
						return
					end

					local v12 = v16
					local v13 = string.format("Members (%d online)", count)

					if not v12 then
						return
					end

					v12.RichText = true
					v12.Text = v13

					local TextLabel = v12:FindFirstChild("TextLabel")

					if not (TextLabel and TextLabel:IsA("TextLabel")) then
						return
					end

					TextLabel.RichText = true
					TextLabel.Text = v13
				end
			end)
			GuiController.GuiFocusedSignal:Connect(function(p1) --[[ Line: 1854 | Upvalues: ViewGuildPage (copy), v27 (ref), refreshHeader (ref), v25 (ref), v40 (ref) ]]
				if p1 ~= ViewGuildPage then
					return
				end

				v27 = true
				refreshHeader()

				if not v25 then
					v25 = task.spawn(function() --[[ Line: 1394 | Upvalues: v27 (ref), refreshHeader (ref) ]]
						while v27 do
							refreshHeader()
							task.wait(1)
						end
					end)
				end

				v40()
			end)
			GuiController.GuiUnfocusedSignal:Connect(function(p1) --[[ Line: 1862 | Upvalues: ViewGuildPage (copy), v27 (ref), v25 (ref), v26 (ref), v37 (ref), v38 (ref) ]]
				if p1 ~= ViewGuildPage then
					return
				end

				v27 = false

				if v25 then
					task.cancel(v25)
					v25 = nil
				end

				if v26 then
					task.cancel(v26)
					v26 = nil
				end

				v37 = nil
				v38 = false
			end)
		end
	end)
end

return t2