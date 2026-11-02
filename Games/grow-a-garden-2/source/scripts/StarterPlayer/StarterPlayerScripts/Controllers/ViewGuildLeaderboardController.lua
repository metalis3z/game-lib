--credit to quartz games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local GuildCompetition = require(ReplicatedStorage.SharedModules.GuildCompetition)
local Asserts = require(ReplicatedStorage.SharedModules.Guild.Asserts)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local GuiController = require(LocalPlayer.PlayerScripts.Controllers.GuiController)
local ViewGuildController = require(LocalPlayer.PlayerScripts.Controllers.ViewGuildController)
local ViewGuildProgressController = require(LocalPlayer.PlayerScripts.Controllers.ViewGuildProgressController)
local t = { "RainbowGradient", "GoldGradient", "SilverGradient", "BronzeGradient" }
local t2 = {
	StartOrder = 9
}
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = false
local v10 = nil
local v11 = 0
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}
local v12 = nil
local v13 = nil
local v14 = (-1 / 0)
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil

local function currentScoreFormat() --[[ currentScoreFormat | Line: 85 | Upvalues: v12 (ref) ]]
	local v1 = v12

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

local function fetchCompetition() --[[ fetchCompetition | Line: 98 | Upvalues: v14 (ref), Networking (copy), v12 (ref), v13 (ref), v16 (ref) ]]
	local v1 = os.clock()

	if not (v1 - v14 < 15) then
		v14 = v1
		task.spawn(function() --[[ Line: 102 | Upvalues: Networking (ref), v12 (ref), v13 (ref), v16 (ref) ]]
			local ok, result = pcall(function() --[[ Line: 103 | Upvalues: Networking (ref) ]]
				return Networking.Guild.GetCompetition:Fire()
			end)

			if not ok or typeof(result) ~= "table" then
				return
			end

			local v1 = v12
			local v2

			if typeof(v1) == "table" then
				local v3 = if typeof(v1.config) == "table" then v1.config else v1.lastConfig

				v2 = if typeof(v3) == "table" then if typeof(v3.scoreFormat) == "string" then v3.scoreFormat else nil else nil
			else
				v2 = nil
			end

			v12 = result

			if result.phase == "running" and typeof(result.endsAt) == "number" then
				v13 = result.endsAt
			else
				local v4

				if result.phase == "pending" then
					v4 = result.startsAt
					v13 = if typeof(v4) == "number" then result.startsAt else nil
				else
					v13 = nil
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

			local v8 = v16

			if not v8 then
				return
			end

			v8()
		end)
	end
end

local function getPreferredNextReset(p1) --[[ getPreferredNextReset | Line: 127 | Upvalues: v13 (ref) ]]
	if v13 and p1 < v13 then
		return v13
	end

	return nil
end

local function formatTimeRemaining(p1) --[[ formatTimeRemaining | Line: 134 | Upvalues: v12 (ref) ]]
	if p1 < 0 then
		p1 = 0
	end

	local v1 = if v12 and v12.phase == "pending" then "Starts in" else "Ends in"
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

local function hexToRgbToken(p1) --[[ hexToRgbToken | Line: 158 ]]
	local v1 = if typeof(p1) == "string" then p1 else ""

	if #v1 > 0 and v1:sub(1, 1) == "#" then
		v1 = v1:sub(2)
	end

	if #v1 ~= 6 then
		return "rgb(255,255,255)"
	end

	local v4 = tonumber(v1:sub(1, 2), 16)
	local v6 = tonumber(v1:sub(3, 4), 16)
	local v8 = tonumber(v1:sub(5, 6), 16)

	if v4 and (v6 and v8) then
		return string.format("rgb(%d,%d,%d)", v4, v6, v8)
	end

	return "rgb(255,255,255)"
end

local function escapeRichText(p1) --[[ escapeRichText | Line: 169 ]]
	return p1:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;")
end

local function trackCardConn(p1) --[[ trackCardConn | Line: 179 | Upvalues: t4 (copy) ]]
	table.insert(t4, p1)
end

local function clearScrolling() --[[ clearScrolling | Line: 183 | Upvalues: t4 (copy), t3 (copy), v15 (ref), v18 (ref) ]]
	for v1, v2 in t4 do
		pcall(function() --[[ Line: 185 | Upvalues: v2 (copy) ]]
			v2:Disconnect()
		end)
	end

	table.clear(t4)

	for v3, v4 in t3 do
		if v4.Parent then
			v4:Destroy()
		end
	end

	table.clear(t3)
	v15 = nil
	v18 = nil
end

local function buildNameRich(p1, p2, p3) --[[ buildNameRich | Line: 205 ]]
	return string.format("<font color=\"%s\">%s</font> <font color=\"%s\">[%s]</font>", p3, p1:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;"), p3, (p2:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;")))
end

local function setNameLabel(p1, p2, p3, p4) --[[ setNameLabel | Line: 212 | Upvalues: hexToRgbToken (copy) ]]
	local v1 = hexToRgbToken(p4)

	p1.RichText = true
	p1.Text = string.format("<font color=\"%s\">%s</font> <font color=\"%s\">[%s]</font>", "rgb(0,0,0)", p2:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;"), "rgb(0,0,0)", (p3:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;")))

	local GuildTextLabelName2 = p1:FindFirstChild("GuildTextLabelName2")

	if not (GuildTextLabelName2 and GuildTextLabelName2:IsA("TextLabel")) then
		return
	end

	GuildTextLabelName2.RichText = true
	GuildTextLabelName2.Text = string.format("<font color=\"%s\">%s</font> <font color=\"%s\">[%s]</font>", v1, p2:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;"), v1, (p3:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;")))
end

local function setRankText(p1, p2) --[[ setRankText | Line: 224 ]]
	p1.RichText = false
	p1.Text = p2

	local RankTextLabel2 = p1:FindFirstChild("RankTextLabel2")

	if not (RankTextLabel2 and RankTextLabel2:IsA("TextLabel")) then
		return
	end

	RankTextLabel2.RichText = false
	RankTextLabel2.Text = p2
end

local function gradientNameForRank(p1) --[[ gradientNameForRank | Line: 234 ]]
	if p1 == 1 then
		return "RainbowGradient"
	end

	if p1 == 2 then
		return "GoldGradient"
	end

	if p1 == 3 then
		return "SilverGradient"
	end

	return "BronzeGradient"
end

local function applyGradient(p1, p2) --[[ applyGradient | Line: 249 | Upvalues: t (copy) ]]
	if not p1 then
		return
	end

	local v1 = if p2 == 1 then "RainbowGradient" elseif p2 == 2 then "GoldGradient" elseif p2 == 3 then "SilverGradient" else "BronzeGradient"

	for v2, v3 in t do
		local v4 = p1:FindFirstChild(v3)

		if v4 and v4:IsA("UIGradient") then
			if v3 == v1 then
				v4.Enabled = true

				continue
			end

			v4:Destroy()
		end
	end
end

local function applyIconImage(p1, p2) --[[ applyIconImage | Line: 266 | Upvalues: Asserts (copy) ]]
	local GuildImage = p1:FindFirstChild("GuildImage")

	if not GuildImage then
		return
	end

	local GuildSkinImage = GuildImage:FindFirstChild("GuildSkinImage")

	if not (GuildSkinImage and GuildSkinImage:IsA("ImageLabel")) then
		return
	end

	GuildSkinImage.Image = Asserts.IconAssetString(if typeof(p2) == "number" then p2 else nil)
end

local function applySummaryToCard(p1, p2) --[[ applySummaryToCard | Line: 275 | Upvalues: setNameLabel (copy), applyIconImage (copy) ]]
	if typeof(p2) ~= "table" then
		return
	end

	local GuildTextLabelName1 = p1:FindFirstChild("GuildTextLabelName1")

	if GuildTextLabelName1 and GuildTextLabelName1:IsA("TextLabel") then
		setNameLabel(GuildTextLabelName1, tostring(p2.Name or ""), tostring(p2.Tag or ""), p2.Color)
	end

	applyIconImage(p1, p2.IconId)
end

local function fetchSummaryAndApply(p1, p2) --[[ fetchSummaryAndApply | Line: 287 | Upvalues: t5 (copy), applySummaryToCard (copy), t6 (copy), Networking (copy) ]]
	local v1 = t5[p2]

	if v1 then
		applySummaryToCard(p1, v1)

		return
	end

	if not t6[p2] then
		t6[p2] = true
		task.spawn(function() --[[ Line: 295 | Upvalues: Networking (ref), p2 (copy), t6 (ref), t5 (ref), p1 (copy), applySummaryToCard (ref) ]]
			local ok, result = pcall(function() --[[ Line: 296 | Upvalues: Networking (ref), p2 (ref) ]]
				return Networking.Guild.GetGuildById:Fire(p2)
			end)

			t6[p2] = nil

			if not ok or typeof(result) ~= "table" then
				return
			end

			t5[p2] = result

			if not p1.Parent then
				return
			end

			applySummaryToCard(p1, result)
		end)
	end
end

local function buildCard(p1, p2) --[[ buildCard | Line: 311 | Upvalues: v3 (ref), v2 (ref), t3 (copy), applyGradient (copy), GuildCompetition (copy), v12 (ref), setNameLabel (copy), applyIconImage (copy), t5 (copy), applySummaryToCard (copy), t6 (copy), Networking (copy), ViewGuildController (copy), t4 (copy) ]]
	if not (v3 and v2) then
		return
	end

	local v1 = v3:Clone()

	v1.Name = string.format("PlayerCard_Rank%d", p1)
	v1.Visible = true
	v1.LayoutOrder = p1
	v1.Parent = v2
	table.insert(t3, v1)

	local RankTextLabel1 = v1:FindFirstChild("RankTextLabel1")

	if RankTextLabel1 and RankTextLabel1:IsA("TextLabel") then
		local v32 = "#" .. tostring(p1)

		RankTextLabel1.RichText = false
		RankTextLabel1.Text = v32

		local RankTextLabel2 = RankTextLabel1:FindFirstChild("RankTextLabel2")

		if RankTextLabel2 and RankTextLabel2:IsA("TextLabel") then
			RankTextLabel2.RichText = false
			RankTextLabel2.Text = v32
		end

		applyGradient(RankTextLabel1:FindFirstChild("RankTextLabel2"), p1)
	end

	local TotalContribution = v1:FindFirstChild("TotalContribution")

	if TotalContribution and TotalContribution:IsA("TextLabel") then
		local v5 = tonumber(p2.shekels or (p2.Shekels or p2.score))

		TotalContribution.RichText = false

		local v7 = v12
		local v8, v9

		if typeof(v7) == "table" then
			local v10 = if typeof(v7.config) == "table" then v7.config else v7.lastConfig

			if typeof(v10) == "table" and typeof(v10.scoreFormat) == "string" then
				v8 = v10.scoreFormat
				v9 = v5
			else
				v9 = v5
				v8 = nil
			end
		else
			v9 = v5
			v8 = nil
		end

		TotalContribution.Text = "Score: " .. GuildCompetition.FormatScore(v9, v8) .. "kg"
	end

	local SheckleImage = v1:FindFirstChild("SheckleImage")

	if SheckleImage and SheckleImage:IsA("GuiObject") then
		SheckleImage.Visible = false
	end

	local v11 = p2.name or p2.Name
	local GuildTextLabelName1 = v1:FindFirstChild("GuildTextLabelName1")

	if GuildTextLabelName1 and GuildTextLabelName1:IsA("TextLabel") then
		setNameLabel(GuildTextLabelName1, tostring(v11 or "?"), tostring(p2.tag or p2.Tag or "?"), p2.color or p2.Color)
	end

	applyIconImage(v1, p2.iconId or p2.IconId)

	local v19 = p2.guildId or p2.GuildId
	local v20 = if typeof(v11) == "string" then v11 ~= "" else false

	if typeof(v19) == "string" and (v19 ~= "" and not v20) then
		local v21 = t5[v19]

		if v21 then
			applySummaryToCard(v1, v21)
		elseif not t6[v19] then
			t6[v19] = true
			task.spawn(function() --[[ Line: 295 | Upvalues: Networking (ref), v19 (copy), t6 (ref), t5 (ref), v1 (copy), applySummaryToCard (ref) ]]
				local ok, result = pcall(function() --[[ Line: 296 | Upvalues: Networking (ref), v19 (ref) ]]
					return Networking.Guild.GetGuildById:Fire(p2)
				end)

				t6[v19] = nil

				if not ok or typeof(result) ~= "table" then
					return
				end

				t5[v19] = result

				if not v1.Parent then
					return
				end

				applySummaryToCard(v1, result)
			end)
		end
	end

	local ViewButton = v1:FindFirstChild("ViewButton")

	if not (ViewButton and ViewButton:IsA("GuiButton")) then
		return
	end

	local v222 = ViewButton.MouseButton1Click:Connect(function() --[[ Line: 374 | Upvalues: v19 (copy), ViewGuildController (ref) ]]
		if typeof(v19) == "string" and v19 ~= "" then
			ViewGuildController:OpenForGuildIdFromLeaderboard(v19)
		end
	end)

	table.insert(t4, v222)
end

local function setStatus(p1) --[[ setStatus | Line: 386 | Upvalues: v7 (ref) ]]
	if not v7 then
		return
	end

	v7.Text = p1
	v7.Visible = p1 ~= ""
end

local function computeSignature(p1) --[[ computeSignature | Line: 395 | Upvalues: v12 (ref) ]]
	local t = {}
	local v1 = v12
	local v2

	if typeof(v1) == "table" then
		local v3 = if typeof(v1.config) == "table" then v1.config else v1.lastConfig

		v2 = if typeof(v3) == "table" then if typeof(v3.scoreFormat) == "string" then v3.scoreFormat else nil else nil
	else
		v2 = nil
	end

	t[1] = tostring(v2)

	for v4, v5 in p1 do
		if typeof(v5) == "table" then
			local format = string.format
			local v9 = tostring(v5.guildId or v5.GuildId or "")
			local v11 = tostring(v5.rank or v5.Rank or "")
			local v13 = tostring(v5.shekels or v5.Shekels or v5.score or "")

			t[#t + 1] = format("%s:%s:%s:%s:%s:%s:%s", v9, v11, v13, tostring(v5.name or v5.Name or ""), tostring(v5.tag or v5.Tag or ""), tostring(v5.color or v5.Color or ""), (tostring(v5.iconId or v5.IconId or "")))
		end
	end

	return table.concat(t, "|")
end

local function rebuildBoard(p1) --[[ rebuildBoard | Line: 411 | Upvalues: computeSignature (copy), v18 (ref), t3 (copy), v15 (ref), v7 (ref), clearScrolling (copy), buildCard (copy) ]]
	local v1 = computeSignature(p1)

	v15 = p1

	if v1 == v18 and #t3 > 0 then
		if not v7 then
			return #t3
		end

		v7.Text = ""
		v7.Visible = false

		return #t3
	end

	clearScrolling()
	v18 = v1

	local count = 0

	if p1 then
		for i = 1, math.min(#p1, 200) do
			local v2 = p1[i]

			if typeof(v2) == "table" and not ((tonumber(v2.shekels or v2.Shekels) or 0) <= 0) then
				buildCard(tonumber(v2.rank or v2.Rank) or i, v2)
				count = count + 1
			end
		end
	end

	if not (count > 0) then
		return count
	end

	if not v7 then
		return count
	end

	v7.Text = ""
	v7.Visible = false

	return count
end

v16 = function() --[[ Line: 453 | Upvalues: v9 (ref), v15 (ref), rebuildBoard (copy) ]]
	if not v9 then
		return
	end

	local v1 = v15

	if not v1 then
		return
	end

	rebuildBoard(v1)
end

local function fetchLeaderboard() --[[ fetchLeaderboard | Line: 472 | Upvalues: v11 (ref), v9 (ref), Networking (copy), v17 (ref), rebuildBoard (copy), t3 (copy), v7 (ref) ]]
	v11 = v11 + 1

	local v1 = v11

	task.spawn(function() --[[ Line: 475 | Upvalues: v9 (ref), v1 (copy), v11 (ref), Networking (ref), v17 (ref), rebuildBoard (ref), t3 (ref), v7 (ref) ]]
		for i = 1, 12 do
			if not v9 or v1 ~= v11 then
				return
			end

			local ok, result = pcall(function() --[[ Line: 480 | Upvalues: Networking (ref) ]]
				return Networking.Guild.GetLeaderboard:Fire("weekly")
			end)

			if not v9 or v1 ~= v11 then
				return
			end

			local v12 = if ok and typeof(result) == "table" then result else {}

			if #v12 > 0 then
				v17 = v12

				if rebuildBoard(v12) > 0 then
					return
				end
			elseif #t3 > 0 then
				return
			end

			if v7 then
				v7.Text = "Loading..."
				v7.Visible = true
			end

			task.wait(2)
		end

		if not v9 or v1 ~= v11 then
			return
		end

		if not v7 then
			return
		end

		v7.Text = "No guilds have scored yet"
		v7.Visible = true
	end)
end

local function refreshTimer() --[[ refreshTimer | Line: 509 | Upvalues: v6 (ref), v14 (ref), Networking (copy), v12 (ref), v13 (ref), v16 (ref), v5 (ref), formatTimeRemaining (copy) ]]
	if not v6 then
		return
	end

	local v1 = os.clock()

	if not (v1 - v14 < 15) then
		v14 = v1
		task.spawn(function() --[[ Line: 102 | Upvalues: Networking (ref), v12 (ref), v13 (ref), v16 (ref) ]]
			local ok, result = pcall(function() --[[ Line: 103 | Upvalues: Networking (ref) ]]
				return Networking.Guild.GetCompetition:Fire()
			end)

			if not ok or typeof(result) ~= "table" then
				return
			end

			local v1 = v12
			local v2

			if typeof(v1) == "table" then
				local v3 = if typeof(v1.config) == "table" then v1.config else v1.lastConfig

				v2 = if typeof(v3) == "table" then if typeof(v3.scoreFormat) == "string" then v3.scoreFormat else nil else nil
			else
				v2 = nil
			end

			v12 = result

			if result.phase == "running" and typeof(result.endsAt) == "number" then
				v13 = result.endsAt
			else
				local v4

				if result.phase == "pending" then
					v4 = result.startsAt
					v13 = if typeof(v4) == "number" then result.startsAt else nil
				else
					v13 = nil
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

			local v8 = v16

			if not v8 then
				return
			end

			v8()
		end)
	end

	local v2 = os.time()
	local v3 = if v13 and v2 < v13 then v13 else nil

	if v5 then
		v5.Visible = v3 ~= nil
	end

	v6.Text = if v3 then formatTimeRemaining(v3 - v2) else ""
end

local function startTimerLoop() --[[ startTimerLoop | Line: 522 | Upvalues: v10 (ref), v9 (ref), v6 (ref), v14 (ref), Networking (copy), v12 (ref), v13 (ref), v16 (ref), v5 (ref), formatTimeRemaining (copy) ]]
	if not v10 then
		v10 = task.spawn(function() --[[ Line: 524 | Upvalues: v9 (ref), v6 (ref), v14 (ref), Networking (ref), v12 (ref), v13 (ref), v16 (ref), v5 (ref), formatTimeRemaining (ref) ]]
			while v9 do
				local v1

				if v6 then
					local v2 = os.clock()

					if not (v2 - v14 < 15) then
						v14 = v2
						task.spawn(function() --[[ Line: 102 | Upvalues: Networking (ref), v12 (ref), v13 (ref), v16 (ref) ]]
							local ok, result = pcall(function() --[[ Line: 103 | Upvalues: Networking (ref) ]]
								return Networking.Guild.GetCompetition:Fire()
							end)

							if not ok or typeof(result) ~= "table" then
								return
							end

							local v1 = v12
							local v2

							if typeof(v1) == "table" then
								local v3 = if typeof(v1.config) == "table" then v1.config else v1.lastConfig

								v2 = if typeof(v3) == "table" then if typeof(v3.scoreFormat) == "string" then v3.scoreFormat else nil else nil
							else
								v2 = nil
							end

							v12 = result

							if result.phase == "running" and typeof(result.endsAt) == "number" then
								v13 = result.endsAt
							elseif result.phase == "pending" then
								local v4

								v4 = result.startsAt
								v13 = if typeof(v4) == "number" then result.startsAt else nil
							else
								v13 = nil
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

							local v8 = v16

							if not v8 then
								return
							end

							v8()
						end)
					end

					local v3 = os.time()

					v1 = if v13 and v3 < v13 then v13 else nil

					if v5 then
						v5.Visible = v1 ~= nil
					end

					v6.Text = if v1 then formatTimeRemaining(v1 - v3) else ""
				end

				task.wait(1)
			end
		end)
	end
end

local function stopTimerLoop() --[[ stopTimerLoop | Line: 532 | Upvalues: v10 (ref) ]]
	if not v10 then
		return
	end

	task.cancel(v10)
	v10 = nil
end

local function resolveRefs(p1) --[[ resolveRefs | Line: 541 | Upvalues: v4 (ref), v5 (ref), v6 (ref), v8 (ref), v7 (ref), v2 (ref), v3 (ref) ]]
	local ContributionLeaderboard = p1:FindFirstChild("ContributionLeaderboard")

	if not ContributionLeaderboard then
		return
	end

	local Header = ContributionLeaderboard:FindFirstChild("Header")

	if Header then
		local ExitButton = Header:FindFirstChild("ExitButton")

		if ExitButton and ExitButton:IsA("GuiButton") then
			v4 = ExitButton
		end

		local RefreshIn = Header:FindFirstChild("RefreshIn")

		if RefreshIn then
			if RefreshIn:IsA("GuiObject") then
				v5 = RefreshIn
			end

			local Timer = RefreshIn:FindFirstChild("Timer")

			if Timer and Timer:IsA("TextLabel") then
				v6 = Timer
			end
		end

		local ExtraFrame = Header:FindFirstChild("ExtraFrame")

		if ExtraFrame then
			local ViewPlacementButton = ExtraFrame:FindFirstChild("ViewPlacementButton")

			if ViewPlacementButton and ViewPlacementButton:IsA("GuiButton") then
				v8 = ViewPlacementButton
			end
		end
	end

	local v1 = ContributionLeaderboard:FindFirstChild("Content")

	if not v1 then
		return
	end

	local StatusLabel = v1:FindFirstChild("StatusLabel")

	if StatusLabel and StatusLabel:IsA("TextLabel") then
		v7 = StatusLabel
	end

	local ScrollingFrame = v1:FindFirstChild("ScrollingFrame")

	if not ScrollingFrame then
		return
	end

	if not ScrollingFrame:IsA("ScrollingFrame") then
		return
	end

	v2 = ScrollingFrame

	local PlayerCard_Template_Rank1 = ScrollingFrame:FindFirstChild("PlayerCard_Template_Rank1")

	if not PlayerCard_Template_Rank1 then
		return
	end

	if PlayerCard_Template_Rank1:IsA("ImageButton") then
		v3 = PlayerCard_Template_Rank1
		PlayerCard_Template_Rank1.Visible = false
	end
end

local function bindButtons() --[[ bindButtons | Line: 594 | Upvalues: v4 (ref), GuiController (copy), v8 (ref), ViewGuildProgressController (copy) ]]
	if v4 then
		v4.MouseButton1Click:Connect(function() --[[ Line: 596 | Upvalues: GuiController (ref) ]]
			if not GuiController:IsOpen("ViewGuildLeaderboard") then
				return
			end

			GuiController:Close()
		end)
	end

	if not v8 then
		return
	end

	v8.MouseButton1Click:Connect(function() --[[ Line: 603 | Upvalues: ViewGuildProgressController (ref), GuiController (ref) ]]
		ViewGuildProgressController:SetReturnGui("ViewGuildLeaderboard")
		GuiController:Open("ViewGuildProgress", nil, { "HUD" })
	end)
end

function t2.Init(p1) --[[ Init | Line: 614 ]] end
function t2.Start(p1) --[[ Start | Line: 616 | Upvalues: v14 (ref), Networking (copy), v12 (ref), v13 (ref), v16 (ref), v17 (ref), PlayerGui (copy), v1 (ref), resolveRefs (copy), bindButtons (copy), v9 (ref), rebuildBoard (copy), v11 (ref), GuiController (copy), v6 (ref), v5 (ref), formatTimeRemaining (copy), v10 (ref), clearScrolling (copy), v7 (ref), t3 (copy) ]]
	task.spawn(function() --[[ Line: 617 | Upvalues: v14 (ref), Networking (ref), v12 (ref), v13 (ref), v16 (ref), v17 (ref), PlayerGui (ref), v1 (ref), resolveRefs (ref), bindButtons (ref), v9 (ref), rebuildBoard (ref), v11 (ref), GuiController (ref), v6 (ref), v5 (ref), formatTimeRemaining (ref), v10 (ref), clearScrolling (ref), v7 (ref), t3 (ref) ]]
		local v15 = os.clock()

		if not (v15 - v14 < 15) then
			v14 = v15
			task.spawn(function() --[[ Line: 102 | Upvalues: Networking (ref), v12 (ref), v13 (ref), v16 (ref) ]]
				local ok, result = pcall(function() --[[ Line: 103 | Upvalues: Networking (ref) ]]
					return Networking.Guild.GetCompetition:Fire()
				end)

				if not ok or typeof(result) ~= "table" then
					return
				end

				local v1 = v12
				local v2

				if typeof(v1) == "table" then
					local v3 = if typeof(v1.config) == "table" then v1.config else v1.lastConfig

					v2 = if typeof(v3) == "table" then if typeof(v3.scoreFormat) == "string" then v3.scoreFormat else nil else nil
				else
					v2 = nil
				end

				v12 = result

				if result.phase == "running" and typeof(result.endsAt) == "number" then
					v13 = result.endsAt
				else
					local v4

					if result.phase == "pending" then
						v4 = result.startsAt
						v13 = if typeof(v4) == "number" then result.startsAt else nil
					else
						v13 = nil
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

				local v8 = v16

				if not v8 then
					return
				end

				v8()
			end)
		end

		task.spawn(function() --[[ Line: 624 | Upvalues: Networking (ref), v17 (ref) ]]
			local ok, result = pcall(function() --[[ Line: 625 | Upvalues: Networking (ref) ]]
				return Networking.Guild.GetLeaderboard:Fire("weekly")
			end)

			if not ok or (typeof(result) ~= "table" or (not (#result > 0) or v17)) then
				return
			end

			v17 = result
		end)

		local ViewGuildLeaderboard = PlayerGui:WaitForChild("ViewGuildLeaderboard", 30)

		if ViewGuildLeaderboard and ViewGuildLeaderboard:IsA("ScreenGui") then
			v1 = ViewGuildLeaderboard
			ViewGuildLeaderboard.Enabled = false
			resolveRefs(ViewGuildLeaderboard)
			bindButtons()
			Networking.Guild.TickUpdate.OnClientEvent:Connect(function(p1) --[[ Line: 645 | Upvalues: v17 (ref), v9 (ref), rebuildBoard (ref), v11 (ref) ]]
				if typeof(p1) ~= "table" then
					return
				end

				if p1.Kind ~= "Leaderboard" then
					return
				end

				local TopGuilds = p1.TopGuilds

				if typeof(TopGuilds) == "table" and #TopGuilds > 0 then
					v17 = TopGuilds
				end

				if not v9 then
					return
				end

				if typeof(TopGuilds) ~= "table" or not (rebuildBoard(TopGuilds) > 0) then
					return
				end

				v11 = v11 + 1
			end)
			GuiController.GuiFocusedSignal:Connect(function(p1) --[[ Line: 667 | Upvalues: ViewGuildLeaderboard (copy), v9 (ref), v6 (ref), v14 (ref), Networking (ref), v12 (ref), v13 (ref), v16 (ref), v5 (ref), formatTimeRemaining (ref), v10 (ref), v17 (ref), rebuildBoard (ref), clearScrolling (ref), v7 (ref), v11 (ref), t3 (ref) ]]
				if p1 ~= ViewGuildLeaderboard then
					return
				end

				v9 = true

				if v6 then
					local v1 = os.clock()

					if not (v1 - v14 < 15) then
						v14 = v1
						task.spawn(function() --[[ Line: 102 | Upvalues: Networking (ref), v12 (ref), v13 (ref), v16 (ref) ]]
							local ok, result = pcall(function() --[[ Line: 103 | Upvalues: Networking (ref) ]]
								return Networking.Guild.GetCompetition:Fire()
							end)

							if not ok or typeof(result) ~= "table" then
								return
							end

							local v1 = v12
							local v2

							if typeof(v1) == "table" then
								local v3 = if typeof(v1.config) == "table" then v1.config else v1.lastConfig

								v2 = if typeof(v3) == "table" then if typeof(v3.scoreFormat) == "string" then v3.scoreFormat else nil else nil
							else
								v2 = nil
							end

							v12 = result

							if result.phase == "running" and typeof(result.endsAt) == "number" then
								v13 = result.endsAt
							else
								local v4

								if result.phase == "pending" then
									v4 = result.startsAt
									v13 = if typeof(v4) == "number" then result.startsAt else nil
								else
									v13 = nil
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

							local v8 = v16

							if not v8 then
								return
							end

							v8()
						end)
					end

					local v2 = os.time()
					local v3 = if v13 and v2 < v13 then v13 else nil

					if v5 then
						v5.Visible = v3 ~= nil
					end

					v6.Text = if v3 then formatTimeRemaining(v3 - v2) else ""
				end

				if not v10 then
					v10 = task.spawn(function() --[[ Line: 524 | Upvalues: v9 (ref), v6 (ref), v14 (ref), Networking (ref), v12 (ref), v13 (ref), v16 (ref), v5 (ref), formatTimeRemaining (ref) ]]
						while v9 do
							local v1

							if v6 then
								local v2 = os.clock()

								if not (v2 - v14 < 15) then
									v14 = v2
									task.spawn(function() --[[ Line: 102 | Upvalues: Networking (ref), v12 (ref), v13 (ref), v16 (ref) ]]
										local ok, result = pcall(function() --[[ Line: 103 | Upvalues: Networking (ref) ]]
											return Networking.Guild.GetCompetition:Fire()
										end)

										if not ok or typeof(result) ~= "table" then
											return
										end

										local v1 = v12
										local v2

										if typeof(v1) == "table" then
											local v3 = if typeof(v1.config) == "table" then v1.config else v1.lastConfig

											v2 = if typeof(v3) == "table" then if typeof(v3.scoreFormat) == "string" then v3.scoreFormat else nil else nil
										else
											v2 = nil
										end

										v12 = result

										if result.phase == "running" and typeof(result.endsAt) == "number" then
											v13 = result.endsAt
										elseif result.phase == "pending" then
											local v4

											v4 = result.startsAt
											v13 = if typeof(v4) == "number" then result.startsAt else nil
										else
											v13 = nil
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

										local v8 = v16

										if not v8 then
											return
										end

										v8()
									end)
								end

								local v3 = os.time()

								v1 = if v13 and v3 < v13 then v13 else nil

								if v5 then
									v5.Visible = v1 ~= nil
								end

								v6.Text = if v1 then formatTimeRemaining(v1 - v3) else ""
							end

							task.wait(1)
						end
					end)
				end

				local v8 = v17

				if not (v8 and rebuildBoard(v8) > 0) then
					clearScrolling()

					if v7 then
						v7.Text = "Loading..."
						v7.Visible = true
					end
				end

				v11 = v11 + 1

				local v92 = v11

				task.spawn(function() --[[ Line: 475 | Upvalues: v9 (ref), v92 (copy), v11 (ref), Networking (ref), v17 (ref), rebuildBoard (ref), t3 (ref), v7 (ref) ]]
					for i = 1, 12 do
						if not v9 or v92 ~= v11 then
							return
						end

						local ok, result = pcall(function() --[[ Line: 480 | Upvalues: Networking (ref) ]]
							return Networking.Guild.GetLeaderboard:Fire("weekly")
						end)

						if not v9 or v92 ~= v11 then
							return
						end

						local v12 = if ok and typeof(result) == "table" then result else {}

						if #v12 > 0 then
							v17 = v12

							if rebuildBoard(v12) > 0 then
								return
							end
						elseif #t3 > 0 then
							return
						end

						if v7 then
							v7.Text = "Loading..."
							v7.Visible = true
						end

						task.wait(2)
					end

					if not v9 or v92 ~= v11 then
						return
					end

					if not v7 then
						return
					end

					v7.Text = "No guilds have scored yet"
					v7.Visible = true
				end)
			end)
			GuiController.GuiUnfocusedSignal:Connect(function(p1) --[[ Line: 685 | Upvalues: ViewGuildLeaderboard (copy), v9 (ref), v10 (ref) ]]
				if p1 ~= ViewGuildLeaderboard then
					return
				end

				v9 = false

				if not v10 then
					return
				end

				task.cancel(v10)
				v10 = nil
			end)
		end
	end)
end

return t2