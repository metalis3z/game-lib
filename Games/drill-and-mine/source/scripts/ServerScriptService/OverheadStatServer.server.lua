-- Overhead stat UI: muscle icon + gold-gradient number above each player's head.
-- Reads the player's "Strength" leaderstat or attribute (falls back to 0).
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local ICON_ID = "rbxassetid://118947473669783"

-- owners who get the OWNER overhead tag -- the game is group-owned, so these
-- are pinned by UserId: AimbotJokers (game owner) + NotionScripts
local OWNER_USER_IDS = {
	[605235231] = true, -- AimbotJokers
	[125570361] = true, -- NotionScripts
}

local function abbrev(n)
	n = tonumber(n) or 0
	local units = {{1e42,"Td"},{1e39,"Dd"},{1e36,"Ud"},{1e33,"Dc"},{1e30,"No"},{1e27,"Oc"},{1e24,"Sp"},{1e21,"Sx"},{1e18,"Qn"},{1e15,"Qd"},{1e12,"T"},{1e9,"B"},{1e6,"M"},{1e3,"K"}}
	for _, u in ipairs(units) do
		if n >= u[1] then
			local v = n / u[1]
			return (v >= 100 and string.format("%d%s", math.floor(v), u[2])) or string.format("%.1f%s", v, u[2])
		end
	end
	return tostring(math.floor(n))
end

local function readStrength(player)
	local ls = player:FindFirstChild("leaderstats")
	local stat = ls and ls:FindFirstChild("Strength")
	if stat then return stat.Value, stat end
	return player:GetAttribute("Strength") or 0, nil
end

local function buildGui(head, player)
	local bb = Instance.new("BillboardGui")
	bb.Name = "StrengthOverhead"
	bb.Size = UDim2.new(7, 0, 1.6, 0)
	bb.StudsOffset = Vector3.new(0, 1.9, 0)
	bb.AlwaysOnTop = true
	bb.MaxDistance = 90
	bb.LightInfluence = 0
	-- BillboardStrokeScaler (client) thins every stroke under this tag with
	-- camera distance -- fixes the digits mushing into fat outlines when
	-- zoomed out (ported from "+1 Kick Door" 2026-07-21)
	CollectionService:AddTag(bb, "DistanceScaledStrokes")

	local holder = Instance.new("Frame")
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.fromScale(1, 1)
	holder.Parent = bb

	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0.04, 0)
	layout.Parent = holder

	local img = Instance.new("ImageLabel")
	img.Name = "Icon"
	img.BackgroundTransparency = 1
	img.Image = ICON_ID
	img.Size = UDim2.new(0.6, 0, 0.6, 0)
	img.SizeConstraint = Enum.SizeConstraint.RelativeYY
	img.ScaleType = Enum.ScaleType.Fit
	img.LayoutOrder = 1
	img.Parent = holder

	local txt = Instance.new("TextLabel")
	txt.Name = "Amount"
	txt.BackgroundTransparency = 1
	-- fixed-width box: TextScaled + AutomaticSize.X is a feedback loop (box fits
	-- text, text fits box) that freezes the width and mis-scales wider digits
	txt.Size = UDim2.new(0.09, 0, 0.6, 0)
	txt.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
	txt.TextScaled = true
	txt.TextXAlignment = Enum.TextXAlignment.Left
	txt.TextColor3 = Color3.new(1, 1, 1)
	txt.LayoutOrder = 2

	-- clean gold gradient, same tones as the icon
	local grad = Instance.new("UIGradient")
	grad.Rotation = 90
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 224, 92)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 158, 21)),
	})
	grad.Parent = txt

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Color = Color3.fromRGB(30, 25, 15)
	stroke.LineJoinMode = Enum.LineJoinMode.Round
	stroke.Parent = txt

	txt.Parent = holder
	bb.Parent = head
	return txt
end

-- VIP tag above the strength row for Vip gamepass owners (OwnsGamepass_Vip
-- attribute set by GamepassService). Double-text pattern like the store UI:
-- parent label = black back copy peeking below, "Double" child = front text
-- whose UIGradient (tagged "VipTagGradient") gets the scrolling rainbow from
-- VipTagFlowClient on each client.
local function buildVipGui(head, player)
	local bb = Instance.new("BillboardGui")
	bb.Name = "VipOverhead"
	bb.Size = UDim2.new(3.2, 0, 1.05, 0)
	bb.StudsOffset = Vector3.new(0, 3.05, 0)
	bb.AlwaysOnTop = true
	bb.MaxDistance = 90
	bb.LightInfluence = 0
	bb.Enabled = player:GetAttribute("OwnsGamepass_Vip") == true
	CollectionService:AddTag(bb, "DistanceScaledStrokes")

	local txt = Instance.new("TextLabel")
	txt.Name = "VipText"
	txt.BackgroundTransparency = 1
	txt.Size = UDim2.fromScale(1, 1)
	txt.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
	txt.TextScaled = true
	txt.Text = "VIP"
	txt.TextColor3 = Color3.fromRGB(0, 0, 0)

	local backStroke = Instance.new("UIStroke")
	backStroke.Thickness = 2
	backStroke.Color = Color3.fromRGB(0, 0, 0)
	backStroke.LineJoinMode = Enum.LineJoinMode.Miter
	backStroke.Parent = txt

	-- front copy shifted up 4% so the black parent peeks below as the shadow
	local front = Instance.new("TextLabel")
	front.Name = "Double"
	front.BackgroundTransparency = 1
	front.AnchorPoint = Vector2.new(0.5, 0.5)
	front.Position = UDim2.new(0.5, 0, 0.46, 0)
	front.Size = UDim2.fromScale(1, 1)
	front.FontFace = txt.FontFace
	front.TextScaled = true
	front.Text = "VIP"
	front.TextColor3 = Color3.new(1, 1, 1)

	local grad = Instance.new("UIGradient")
	grad.Rotation = 0
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 60)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 255, 120)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 120, 255)),
	})
	CollectionService:AddTag(grad, "VipTagGradient")
	grad.Parent = front

	local frontStroke = Instance.new("UIStroke")
	frontStroke.Thickness = 2
	frontStroke.Color = Color3.fromRGB(0, 0, 0)
	frontStroke.LineJoinMode = Enum.LineJoinMode.Miter
	frontStroke.Parent = front

	front.Parent = txt
	txt.Parent = bb
	bb.Parent = head
	return bb
end

-- OWNER tag for the game owner only, stacked above the VIP tag. Same
-- double-text pattern as the VIP tag; the front UIGradient is tagged
-- "OwnerTagGradient" and VipTagFlowClient scrolls a blue/white wave over it.
local function buildOwnerGui(head, player)
	local bb = Instance.new("BillboardGui")
	bb.Name = "OwnerOverhead"
	bb.Size = UDim2.new(4.8, 0, 1.05, 0)
	bb.StudsOffset = Vector3.new(0, 3.05, 0)
	bb.AlwaysOnTop = true
	bb.MaxDistance = 90
	bb.LightInfluence = 0
	CollectionService:AddTag(bb, "DistanceScaledStrokes")

	local txt = Instance.new("TextLabel")
	txt.Name = "OwnerText"
	txt.BackgroundTransparency = 1
	txt.Size = UDim2.fromScale(1, 1)
	txt.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
	txt.TextScaled = true
	txt.Text = "OWNER"
	txt.TextColor3 = Color3.fromRGB(0, 0, 0)

	local backStroke = Instance.new("UIStroke")
	backStroke.Thickness = 2
	backStroke.Color = Color3.fromRGB(0, 0, 0)
	backStroke.LineJoinMode = Enum.LineJoinMode.Miter
	backStroke.Parent = txt

	local front = Instance.new("TextLabel")
	front.Name = "Double"
	front.BackgroundTransparency = 1
	front.AnchorPoint = Vector2.new(0.5, 0.5)
	front.Position = UDim2.new(0.5, 0, 0.46, 0)
	front.Size = UDim2.fromScale(1, 1)
	front.FontFace = txt.FontFace
	front.TextScaled = true
	front.Text = "OWNER"
	front.TextColor3 = Color3.new(1, 1, 1)

	local grad = Instance.new("UIGradient")
	grad.Rotation = 0
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 140, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
	})
	CollectionService:AddTag(grad, "OwnerTagGradient")
	grad.Parent = front

	local frontStroke = Instance.new("UIStroke")
	frontStroke.Thickness = 2
	frontStroke.Color = Color3.fromRGB(20, 45, 90)
	frontStroke.LineJoinMode = Enum.LineJoinMode.Miter
	frontStroke.Parent = front

	front.Parent = txt
	txt.Parent = bb
	bb.Parent = head
	return bb
end

-- Leaderboard rank tags: "#N" with the source board's own header icon next
-- to it, the text carrying the SAME gradient as that board's title text:
-- green for Most Cash, red for Most Time, blue for Most Rebirths. One tag
-- PER BOARD the player is top-50 on, stacked on top of each other (ported
-- from "+1 Kick Door" 2026-07-22). LeaderboardService publishes a
-- LeaderboardRank_<Board> attribute per board on its 30s refresh; boards
-- the player isn't ranked on have no attribute, so that row hides and the
-- stack compacts.
local RANK_TAG_STYLE = {
	TotalCash = {
		Icon = "rbxassetid://71961706269128",
		Colors = ColorSequence.new(Color3.fromRGB(174, 255, 0), Color3.fromRGB(0, 195, 39)),
	},
	TotalPlaytime = {
		Icon = "rbxassetid://80043859814038",
		Colors = ColorSequence.new(Color3.fromRGB(255, 108, 108), Color3.fromRGB(195, 50, 50)),
	},
	Rebirths = {
		Icon = "rbxassetid://131964492592892",
		Colors = ColorSequence.new(Color3.fromRGB(16, 171, 255), Color3.fromRGB(0, 75, 195)),
	},
}

-- stack order, bottom-up above the strength row
local RANK_BOARD_ORDER = { "TotalCash", "Rebirths", "TotalPlaytime" }

-- attach() reconnects listeners on every respawn, and they connect on the
-- PLAYER (which outlives the character) -- so each attach must disconnect
-- the previous character's set or respawns pile up dead connections for the
-- whole session (server memory leak, found 2026-07-22)
local playerTagConns = {} -- [player] = { RBXScriptConnection, ... }

local function buildRankGui(head, boardName)
	local style = RANK_TAG_STYLE[boardName]
	local bb = Instance.new("BillboardGui")
	bb.Name = "RankOverhead_" .. boardName
	bb.Size = UDim2.new(4, 0, 1.05, 0)
	bb.StudsOffset = Vector3.new(0, 3.05, 0)
	bb.AlwaysOnTop = true
	bb.MaxDistance = 90
	bb.LightInfluence = 0
	bb.Enabled = false
	CollectionService:AddTag(bb, "DistanceScaledStrokes")

	local holder = Instance.new("Frame")
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.fromScale(1, 1)
	holder.Parent = bb

	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0.02, 0)
	layout.Parent = holder

	local txt = Instance.new("TextLabel")
	txt.Name = "Rank"
	txt.BackgroundTransparency = 1
	txt.Size = UDim2.new(0.3, 0, 0.95, 0)
	txt.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
	txt.TextScaled = true
	txt.TextXAlignment = Enum.TextXAlignment.Right
	txt.TextColor3 = Color3.new(1, 1, 1)
	txt.LayoutOrder = 1
	local grad = Instance.new("UIGradient")
	grad.Rotation = 90
	grad.Color = style.Colors
	grad.Parent = txt
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Color = Color3.fromRGB(0, 0, 0)
	stroke.LineJoinMode = Enum.LineJoinMode.Round
	stroke.Parent = txt
	txt.Parent = holder

	local img = Instance.new("ImageLabel")
	img.Name = "BoardIcon"
	img.BackgroundTransparency = 1
	img.Image = style.Icon
	img.Size = UDim2.new(0.85, 0, 0.85, 0)
	img.SizeConstraint = Enum.SizeConstraint.RelativeYY
	img.ScaleType = Enum.ScaleType.Fit
	img.LayoutOrder = 2
	img.Parent = holder

	bb.Parent = head
	return { bb = bb, txt = txt }
end

local function attach(player, character)
	for _, conn in ipairs(playerTagConns[player] or {}) do
		conn:Disconnect()
	end
	local conns = {}
	playerTagConns[player] = conns

	local head = character:WaitForChild("Head", 10)
	if not head then return end
	local existing = head:FindFirstChild("StrengthOverhead")
	if existing then existing:Destroy() end
	local existingVip = head:FindFirstChild("VipOverhead")
	if existingVip then existingVip:Destroy() end
	local existingOwner = head:FindFirstChild("OwnerOverhead")
	if existingOwner then existingOwner:Destroy() end
	for _, child in ipairs(head:GetChildren()) do
		if string.sub(child.Name, 1, 12) == "RankOverhead" then
			child:Destroy()
		end
	end
	local label = buildGui(head, player)

	local vipBb = buildVipGui(head, player)
	local rankTags = {}
	for _, boardName in ipairs(RANK_BOARD_ORDER) do
		rankTags[boardName] = buildRankGui(head, boardName)
	end
	local ownerBb = nil
	if OWNER_USER_IDS[player.UserId] then
		ownerBb = buildOwnerGui(head, player)
	end

	-- tag stack bottom-up above the strength row: rank tags (one per board)
	-- -> VIP -> OWNER, compacting so a hidden tag leaves no empty row
	local function restack()
		local y = 3.05
		for _, boardName in ipairs(RANK_BOARD_ORDER) do
			local tag = rankTags[boardName]
			if tag.bb.Parent and tag.bb.Enabled then
				tag.bb.StudsOffset = Vector3.new(0, y, 0)
				y += 1.1
			end
		end
		if vipBb.Parent and vipBb.Enabled then
			vipBb.StudsOffset = Vector3.new(0, y, 0)
			y += 1.1
		end
		if ownerBb and ownerBb.Parent then
			ownerBb.StudsOffset = Vector3.new(0, y, 0)
		end
	end

	local function refreshRankTag(boardName)
		local tag = rankTags[boardName]
		if not tag.bb.Parent then return end
		local rank = tonumber(player:GetAttribute("LeaderboardRank_" .. boardName))
		if rank then
			local str = "#" .. rank
			tag.txt.Text = str
			-- deterministic width from char count, like the strength row
			tag.txt.Size = UDim2.new(math.clamp(0.16 * #str, 0.3, 0.8), 0, 0.95, 0)
			tag.bb.Enabled = true
		else
			tag.bb.Enabled = false
		end
		restack()
	end

	for _, boardName in ipairs(RANK_BOARD_ORDER) do
		refreshRankTag(boardName)
		table.insert(conns, player:GetAttributeChangedSignal("LeaderboardRank_" .. boardName):Connect(function()
			refreshRankTag(boardName)
		end))
	end
	restack()
	table.insert(conns, player:GetAttributeChangedSignal("OwnsGamepass_Vip"):Connect(function()
		if vipBb.Parent then
			vipBb.Enabled = player:GetAttribute("OwnsGamepass_Vip") == true
		end
		restack()
	end))

	local function refresh()
		local v = readStrength(player)
		local str = abbrev(v)
		label.Text = str
		-- deterministic width from char count (NOT AutomaticSize) so the
		-- UIListLayout centres the icon+number pair on the character
		label.Size = UDim2.new(math.clamp(0.085 * #str, 0.09, 0.6), 0, 0.6, 0)
	end
	refresh()

	-- follow changes (stat object or attribute)
	local _, stat = readStrength(player)
	if stat then
		stat.Changed:Connect(refresh)
	end
	player:GetAttributeChangedSignal("Strength"):Connect(refresh)
	player.ChildAdded:Connect(function(c)
		if c.Name == "leaderstats" then
			task.wait(0.1)
			local st = c:FindFirstChild("Strength")
			if st then st.Changed:Connect(refresh) end
			refresh()
		end
	end)
end

Players.PlayerRemoving:Connect(function(player)
	for _, conn in ipairs(playerTagConns[player] or {}) do
		conn:Disconnect()
	end
	playerTagConns[player] = nil
end)

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char) attach(player, char) end)
	if player.Character then attach(player, player.Character) end
end)
for _, p in ipairs(Players:GetPlayers()) do
	p.CharacterAdded:Connect(function(char) attach(p, char) end)
	if p.Character then attach(p, p.Character) end
end
