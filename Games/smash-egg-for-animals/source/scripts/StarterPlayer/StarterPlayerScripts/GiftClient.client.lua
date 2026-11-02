-- Fenêtre CADEAU (bouton cadeau de la boutique) :
--   1) choisir à qui : liste de ses amis (en ligne d'abord) ou taper un @pseudo en haut
--   2) choisir quoi offrir : tous les passes en vente et les lots d'œufs (ShopConfig.GiftItems)
--   3) payer : GiftServer ouvre l'achat Robux, puis livre le cadeau au joueur (même hors ligne)
-- Ouverture : ReplicatedStorage.ShopSystem.OpenGift:Fire(cléDuCadeauAMettreEnPremier)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local shopSystem = ReplicatedStorage:WaitForChild("ShopSystem")
local ShopConfig = require(shopSystem:WaitForChild("ShopConfig"))
local remotes = shopSystem:WaitForChild("Remotes")
local requestRemote = remotes:WaitForChild("GiftRequest")
local resultRemote = remotes:WaitForChild("GiftResult")
local openEvent = shopSystem:WaitForChild("OpenGift")

local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local BOLD = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
local GIFT_ICON = "rbxassetid://98725504330944"
local STUDS = "rbxassetid://7447638591"

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function round(o, r) return new("UICorner", {CornerRadius = UDim.new(0, r or 12)}, o) end
local function stroke(o, t, c) return new("UIStroke", {Thickness = t or 2.5, Color = c or BLACK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, o) end
local function text(parent, props, outline)
	local l = new("TextLabel", {BackgroundTransparency = 1, FontFace = FONT, TextColor3 = WHITE, TextScaled = true, ZIndex = (parent.ZIndex or 1) + 1}, parent)
	for k, v in props do l[k] = v end
	if outline ~= false then new("UIStroke", {Thickness = outline or 2.5, Color = BLACK}, l) end
	return l
end
local function button(parent, top, bottom, props)
	local b = new("TextButton", {Text = "", AutoButtonColor = true, BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = (parent.ZIndex or 1) + 2}, parent)
	for k, v in props do b[k] = v end
	new("UIGradient", {Name = "Fill", Rotation = 90, Color = ColorSequence.new(top, bottom)}, b)
	round(b, 10)
	stroke(b, 2.5, bottom:Lerp(BLACK, 0.55))
	return b
end

---------------------------------------------------------------- fenêtre
local gui = new("ScreenGui", {Name = "GiftGui", ResetOnSpawn = false, DisplayOrder = 30, Enabled = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, player:WaitForChild("PlayerGui"))
local main = new("Frame", {Name = "Main", Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(600, 520),
	BackgroundColor3 = rgb(44, 46, 54), BorderSizePixel = 0, ZIndex = 2}, gui)
round(main, 18)
stroke(main, 3, rgb(14, 15, 20))
new("ImageLabel", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = STUDS, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(34, 34), ImageTransparency = 0.88, ZIndex = 2}, main)

local header = new("Frame", {Name = "Header", BackgroundColor3 = WHITE, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 0, 64), ZIndex = 3}, main)
new("UIGradient", {Color = ColorSequence.new(rgb(255, 150, 250), rgb(200, 50, 226))}, header)
round(header, 14)
stroke(header, 2.5, rgb(90, 16, 110))
new("ImageLabel", {BackgroundTransparency = 1, Image = GIFT_ICON, ScaleType = Enum.ScaleType.Fit, Position = UDim2.fromOffset(12, 6), Size = UDim2.fromOffset(52, 52), ZIndex = 5}, header)
local title = text(header, {Text = "Send a Gift", TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(72, 10), Size = UDim2.new(1, -160, 1, -20), ZIndex = 5}, 3.5)
local close = button(header, rgb(255, 70, 70), rgb(190, 14, 30), {Name = "Close", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(56, 50), ZIndex = 5})
text(close, {Text = "X", Size = UDim2.fromScale(1, 1), ZIndex = 7}, 3)

local status = text(main, {Name = "Status", Text = "", TextSize = 16, TextScaled = false, Position = UDim2.new(0, 16, 1, -34), Size = UDim2.new(1, -32, 0, 24), ZIndex = 6}, 2)

---------------------------------------------------------------- étape 1 : à qui ?
local step1 = new("Frame", {Name = "Who", BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 82), Size = UDim2.new(1, -32, 1, -122), ZIndex = 3}, main)
local box = new("TextBox", {Text = "", PlaceholderText = "@username of any player", ClearTextOnFocus = false, FontFace = BOLD, TextSize = 20, TextColor3 = rgb(30, 26, 44),
	PlaceholderColor3 = rgb(140, 140, 160), TextXAlignment = Enum.TextXAlignment.Left, BackgroundColor3 = WHITE, BorderSizePixel = 0, Size = UDim2.new(1, -140, 0, 46), ZIndex = 4}, step1)
round(box, 10)
stroke(box, 2, rgb(150, 148, 170))
new("UIPadding", {PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)}, box)
local nextButton = button(step1, rgb(190, 255, 60), rgb(60, 214, 40), {Name = "Next", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.fromOffset(128, 46), ZIndex = 4})
text(nextButton, {Text = "NEXT", Position = UDim2.fromScale(0.1, 0.18), Size = UDim2.fromScale(0.8, 0.64), ZIndex = 6}, 2.5)
text(step1, {Text = "Your friends", TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(2, 56), Size = UDim2.fromOffset(300, 26), ZIndex = 4}, 2.5)
local friendList = new("ScrollingFrame", {Name = "Friends", BackgroundColor3 = rgb(30, 32, 40), BorderSizePixel = 0, Position = UDim2.fromOffset(0, 88), Size = UDim2.new(1, 0, 1, -88),
	CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 6, ScrollBarImageColor3 = rgb(200, 200, 220), ZIndex = 4}, step1)
round(friendList, 12)
new("UIGridLayout", {CellSize = UDim2.fromOffset(122, 140), CellPadding = UDim2.fromOffset(10, 10), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center}, friendList)
new("UIPadding", {PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6)}, friendList)
local emptyLabel = text(friendList, {Text = "Loading your friends...", TextSize = 18, TextScaled = false, Size = UDim2.fromOffset(500, 40), LayoutOrder = 99999, ZIndex = 5}, 2)

---------------------------------------------------------------- étape 2 : quoi ?
local step2 = new("Frame", {Name = "What", Visible = false, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 82), Size = UDim2.new(1, -32, 1, -122), ZIndex = 3}, main)
local back = button(step2, rgb(220, 224, 236), rgb(150, 154, 176), {Name = "Back", Size = UDim2.fromOffset(96, 46), ZIndex = 4})
text(back, {Text = "◀ BACK", Position = UDim2.fromScale(0.08, 0.2), Size = UDim2.fromScale(0.84, 0.6), ZIndex = 6}, 2)
local whoHead = new("ImageLabel", {BackgroundColor3 = rgb(70, 74, 90), Position = UDim2.fromOffset(108, 0), Size = UDim2.fromOffset(46, 46), ZIndex = 4}, step2)
round(whoHead, 23)
local whoLabel = text(step2, {Text = "", TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(164, 6), Size = UDim2.new(1, -164, 0, 34), ZIndex = 4}, 2.5)
local itemList = new("ScrollingFrame", {Name = "Items", BackgroundColor3 = rgb(30, 32, 40), BorderSizePixel = 0, Position = UDim2.fromOffset(0, 58), Size = UDim2.new(1, 0, 1, -58),
	CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 6, ScrollBarImageColor3 = rgb(200, 200, 220), ZIndex = 4}, step2)
round(itemList, 12)
new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center}, itemList)
new("UIPadding", {PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10)}, itemList)

---------------------------------------------------------------- logique
local target = nil      -- {Name, UserId}
local firstItem = nil   -- cadeau mis en premier (celui dont on a cliqué le bouton cadeau)
local waiting = false

local function say(message, good)
	status.Text = message
	status.TextColor3 = good and rgb(150, 255, 130) or rgb(255, 200, 120)
end
local function headshot(userId) return "rbxthumb://type=AvatarHeadShot&id=" .. userId .. "&w=150&h=150" end

local function showItems()
	for _, c in itemList:GetChildren() do if c:IsA("Frame") then c:Destroy() end end
	for order, item in ShopConfig.GiftItems() do
		local row = new("Frame", {Name = item.Key, BackgroundColor3 = WHITE, BorderSizePixel = 0, Size = UDim2.new(1, -20, 0, 70), LayoutOrder = item.Key == firstItem and 0 or order, ZIndex = 5}, itemList)
		new("UIGradient", {Rotation = 90, Color = item.Kind == "Pass" and ColorSequence.new(rgb(140, 220, 255), rgb(50, 130, 236)) or ColorSequence.new(rgb(255, 238, 120), rgb(245, 160, 20))}, row)
		round(row, 12)
		stroke(row, item.Key == firstItem and 4 or 2.5, item.Key == firstItem and rgb(255, 255, 255) or rgb(20, 30, 60))
		local badge = new("Frame", {BackgroundColor3 = rgb(30, 32, 40), BackgroundTransparency = 0.3, Position = UDim2.fromOffset(8, 8), Size = UDim2.fromOffset(54, 54), ZIndex = 6}, row)
		round(badge, 10)
		if item.Icon then
			new("ImageLabel", {BackgroundTransparency = 1, Image = item.Icon, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 7}, badge)
		end
		text(badge, {Text = item.Kind == "Pass" and (item.Badge or "") or ("x" .. item.Count), AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.45), ZIndex = 8}, 2.5)
		text(row, {Text = item.Name, TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(74, 10), Size = UDim2.new(1, -240, 0, 30), ZIndex = 6}, 2.5)
		text(row, {Text = item.ProductId > 0 and "Gift it to @" .. target.Name or "Coming soon", TextXAlignment = Enum.TextXAlignment.Left, FontFace = BOLD, Position = UDim2.fromOffset(74, 40), Size = UDim2.new(1, -240, 0, 20), ZIndex = 6}, 2)
		local pay = button(row, rgb(190, 255, 60), rgb(60, 214, 40), {Name = "Pay", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(140, 50), ZIndex = 6})
		text(pay, {Text = utf8.char(0xE002) .. " " .. tostring(item.Price), FontFace = Font.fromEnum(Enum.Font.GothamBold), Position = UDim2.fromScale(0.08, 0.16), Size = UDim2.fromScale(0.84, 0.68), ZIndex = 8}, 2.5)
		pay.Activated:Connect(function()
			if waiting or not target then return end
			waiting = true
			say("Opening payment...", true)
			requestRemote:FireServer(target.Name, item.Key)
			task.delay(3, function() waiting = false end)
		end)
	end
end

local function choose(name, userId)
	target = {Name = name, UserId = userId}
	whoHead.Image = userId and headshot(userId) or ""
	whoLabel.Text = "Gift to @" .. name
	step1.Visible, step2.Visible = false, true
	title.Text = "What do you gift?"
	say("")
	showItems()
end

local friendsLoaded = false
local function loadFriends()
	if friendsLoaded then return end
	friendsLoaded = true
	task.spawn(function()
		local list = {}
		local ok = pcall(function()
			local pages = Players:GetFriendsAsync(player.UserId)
			for _ = 1, 10 do
				for _, f in pages:GetCurrentPage() do table.insert(list, f) end
				if pages.IsFinished then break end
				pages:AdvanceToNextPageAsync()
			end
		end)
		table.sort(list, function(a, b)
			if a.IsOnline ~= b.IsOnline then return a.IsOnline end
			return string.lower(a.Username) < string.lower(b.Username)
		end)
		for order, f in list do
			local card = new("TextButton", {Name = f.Username, Text = "", AutoButtonColor = true, BackgroundColor3 = rgb(60, 64, 80), BorderSizePixel = 0, LayoutOrder = order, ZIndex = 5}, friendList)
			round(card, 12)
			stroke(card, 2, f.IsOnline and rgb(90, 220, 90) or rgb(20, 20, 30))
			local head = new("ImageLabel", {BackgroundColor3 = rgb(90, 94, 112), Image = headshot(f.Id), AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.fromOffset(80, 80), ZIndex = 6}, card)
			round(head, 40)
			text(card, {Text = f.DisplayName, Position = UDim2.fromOffset(4, 92), Size = UDim2.new(1, -8, 0, 22), ZIndex = 6}, 2)
			text(card, {Text = "@" .. f.Username, FontFace = BOLD, TextColor3 = rgb(200, 205, 225), Position = UDim2.fromOffset(4, 114), Size = UDim2.new(1, -8, 0, 18), ZIndex = 6}, 1.5)
			card.Activated:Connect(function() choose(f.Username, f.Id) end)
		end
		emptyLabel.Text = not ok and "Could not load your friends. Type an @username above." or #list == 0 and "No friends yet. Type an @username above." or ""
		emptyLabel.Visible = emptyLabel.Text ~= ""
	end)
end

local function open(itemKey)
	firstItem = itemKey
	target = nil
	step1.Visible, step2.Visible = true, false
	title.Text = "Send a Gift"
	say("")
	main.Visible = true
	local scale = main:FindFirstChild("Pop") or new("UIScale", {Name = "Pop"}, main)
	scale.Scale = 0.85
	TweenService:Create(scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	loadFriends()
end

local function goNext()
	local name = string.gsub(string.gsub(box.Text, "^%s*@", ""), "%s", "")
	if name == "" then say("Type an @username first") return end
	if string.lower(name) == string.lower(player.Name) then say("You can't gift yourself!") return end
	choose(name, nil)
	-- avatar du pseudo tapé (s'il existe)
	task.spawn(function()
		local ok, id = pcall(function() return Players:GetUserIdFromNameAsync(name) end)
		if ok and id and target and target.Name == name then
			target.UserId = id
			whoHead.Image = headshot(id)
		elseif target and target.Name == name then
			say("Player @" .. name .. " not found")
		end
	end)
end
nextButton.Activated:Connect(goNext)
box.FocusLost:Connect(function(enter) if enter then goNext() end end)
back.Activated:Connect(function()
	step1.Visible, step2.Visible = true, false
	title.Text = "Send a Gift"
	say("")
end)
close.Activated:Connect(function() main.Visible = false end)
openEvent.Event:Connect(open)

resultRemote.OnClientEvent:Connect(function(ok, message)
	waiting = false
	say(tostring(message), ok)
	if ok then task.delay(2.5, function() main.Visible = false end) end
end)
