-- PollClient : carte du sondage global (centrée, juste sous la barre Burn Power). Bouton OUI à gauche, NON à droite, score en direct de tous les serveurs.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local voteRemote = remotes:WaitForChild("PollVote")
local updateRemote = remotes:WaitForChild("PollUpdate")

local rgb = Color3.fromRGB
local WHITE, BLACK, INK = Color3.new(1, 1, 1), Color3.new(0, 0, 0), rgb(30, 26, 44)
local HEAVY = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local BOLD = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
local STUD = "rbxassetid://7447638591"
local GREEN, RED, BLUE = {rgb(140, 240, 90), rgb(40, 180, 50)}, {rgb(255, 110, 100), rgb(210, 24, 40)}, {rgb(130, 215, 255), rgb(40, 125, 245)}

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function gradient(o, colors, rotation)
	o.BackgroundColor3 = WHITE
	return new("UIGradient", {Color = ColorSequence.new(colors[1], colors[2]), Rotation = rotation or 90}, o)
end
local function studs(o, tile) -- (texture retirée : carte lisse)
	return new("ImageLabel", {Visible = false, BackgroundTransparency = 1, Image = STUD, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(tile or 24, tile or 24), Size = UDim2.fromScale(1, 1), ImageTransparency = 0.25}, o)
end
local function round(o, r) return new("UICorner", {CornerRadius = UDim.new(0, r or 12)}, o) end
local LINE = rgb(28, 26, 40)
-- reflet blanc en biais qui traverse un bouton de temps en temps
local gleams = {}
local GLEAM_BAND = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.42, 1), NumberSequenceKeypoint.new(0.5, 0.5),
	NumberSequenceKeypoint.new(0.58, 1), NumberSequenceKeypoint.new(1, 1)})
local function gleam(o, radius, phase)
	local layer = new("Frame", {Name = "Gleam", BackgroundColor3 = WHITE, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = o.ZIndex + 2}, o)
	round(layer, radius)
	table.insert(gleams, {Gradient = new("UIGradient", {Rotation = 20, Transparency = GLEAM_BAND, Offset = Vector2.new(-1.2, 0)}, layer), Phase = phase})
end
local function text(parent, str, pos, size, color, stroke, align, font)
	local l = new("TextLabel", {BackgroundTransparency = 1, Text = str, Position = pos, Size = size, FontFace = font or HEAVY, TextScaled = true, TextColor3 = color or WHITE,
		TextXAlignment = align or Enum.TextXAlignment.Center, ZIndex = 4}, parent)
	if stroke then new("UIStroke", {Thickness = stroke, Color = BLACK}, l) end
	return l
end

---------------------------------------------------------------- carte
local gui = new("ScreenGui", {Name = "GlobalPollGui", ResetOnSpawn = false, DisplayOrder = 15, IgnoreGuiInset = false}, player:WaitForChild("PlayerGui"))
local GAP = 5 -- espace entre le bas de la barre Burn et le haut du sondage (pixels)
local HIDDEN = UDim2.new(1, 420, 0, 12) -- rangé à droite, hors de l'écran
local function shownPosition() -- en haut à droite : ne cache ni le tutoriel ni le milieu de l'écran
	return UDim2.new(1, -14, 0, 12)
end
local card = new("Frame", {Name = "Poll", AnchorPoint = Vector2.new(1, 0), Position = HIDDEN, Size = UDim2.fromOffset(340, 214), BorderSizePixel = 0, Visible = false}, gui)
gradient(card, {WHITE, rgb(228, 232, 246)})
new("UIStroke", {Thickness = 2.5, Color = LINE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, card)
round(card, 16)
-- ombre douce sous la carte
local shadow = new("Frame", {Name = "Shadow", BackgroundColor3 = BLACK, BackgroundTransparency = 0.7, BorderSizePixel = 0, Position = UDim2.fromOffset(4, 6), Size = UDim2.fromScale(1, 1), ZIndex = 0}, card)
round(shadow, 16)
studs(card, 28)
local scale = new("UIScale", {}, card)
local function refit()
	local view = workspace.CurrentCamera.ViewportSize
	scale.Scale = math.clamp(math.min(view.X / 1280, view.Y / 760), 0.5, 1) -- même échelle que le reste (UIScaler)
end
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(refit)
refit()

-- bandeau du haut : GLOBAL POLL + temps restant
local band = new("Frame", {BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 34), ZIndex = 2}, card)
gradient(band, BLUE, 0)
round(band, 16)
local bandFlat = new("Frame", {BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, -14), Size = UDim2.new(1, 0, 0, 14), ZIndex = 2}, band)
gradient(bandFlat, BLUE, 0)
gleam(band, 16, 0)
local heading = text(band, "GLOBAL POLL", UDim2.fromOffset(10, 5), UDim2.new(0.6, 0, 1, -10), WHITE, 2.5, Enum.TextXAlignment.Left)
local timer = text(band, "", UDim2.new(0.6, 0, 0, 6), UDim2.new(0.4, -10, 1, -12), rgb(255, 240, 150), 2.5, Enum.TextXAlignment.Right)

local byLabel = text(card, "", UDim2.fromOffset(12, 40), UDim2.new(1, -24, 0, 14), WHITE, 1.5, Enum.TextXAlignment.Left, BOLD)
local question = text(card, "", UDim2.fromOffset(12, 56), UDim2.new(1, -24, 0, 44), WHITE, 2.5, Enum.TextXAlignment.Center, HEAVY)
question.TextWrapped = true
new("UITextSizeConstraint", {MaxTextSize = 22}, question)

-- boutons OUI (gauche) / NON (droite)
local function voteButton(label, colors, x)
	local b = new("TextButton", {Text = "", AutoButtonColor = false, BorderSizePixel = 0, Position = UDim2.new(x, x == 0 and 12 or 6, 0, 106), Size = UDim2.new(0.5, -18, 0, 62), ZIndex = 3}, card)
	gradient(b, colors)
	local stroke = new("UIStroke", {Thickness = 2, Color = colors[2]:Lerp(BLACK, 0.5), ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, b)
	round(b, 12)
	gleam(b, 12, x * 1.6)
	local big = text(b, label, UDim2.fromOffset(6, 5), UDim2.new(1, -12, 0, 30), WHITE, 3)
	local count = text(b, "0 votes · 0%", UDim2.fromOffset(6, 37), UDim2.new(1, -12, 0, 18), WHITE, 2, nil, BOLD)
	local check = text(b, "✔", UDim2.new(1, -26, 0, 4), UDim2.fromOffset(20, 20), rgb(255, 240, 120), 2)
	check.Visible = false
	local pop = new("UIScale", {}, b)
	return {Button = b, Stroke = stroke, Count = count, Check = check, Pop = pop, Big = big}
end
local yes = voteButton("YES", GREEN, 0)
local no = voteButton("NO", RED, 0.5)

-- barre de répartition : vert = oui, rouge = non
local bar = new("Frame", {BorderSizePixel = 0, BackgroundColor3 = rgb(225, 50, 60), Position = UDim2.fromOffset(12, 178), Size = UDim2.new(1, -24, 0, 14), ZIndex = 3}, card)
new("UIStroke", {Thickness = 1.5, Color = LINE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, bar)
round(bar, 7)
local fill = new("Frame", {BorderSizePixel = 0, BackgroundColor3 = rgb(70, 210, 80), Size = UDim2.fromScale(0.5, 1), ZIndex = 4}, bar)
round(fill, 7)
local footer = text(card, "", UDim2.fromOffset(12, 195), UDim2.new(1, -24, 0, 14), WHITE, 1.5, nil, BOLD)

---------------------------------------------------------------- état
local poll -- dernier état reçu
local myVote
local hideToken = 0

local function clock(s)
	s = math.max(0, math.ceil(s))
	local m, sec = s // 60, s % 60
	return m >= 60 and string.format("%d:%02d:%02d", m // 60, m % 60, sec) or string.format("%02d:%02d", m, sec)
end

local function wordOf(choice) -- le mot affiché pour une réponse (choisi par l'admin)
	local options = poll and poll.Options
	return string.upper(options and options[choice] or (choice == "Yes" and "YES" or "NO"))
end
local function render()
	if not poll then return end
	yes.Big.Text, no.Big.Text = wordOf("Yes"), wordOf("No")
	local total = poll.Yes + poll.No
	local votesText = total .. (total == 1 and " vote" or " votes")
	local ratio = total > 0 and poll.Yes / total or 0.5
	local pYes = total > 0 and math.floor(ratio * 100 + 0.5) or 0
	local pNo = total > 0 and 100 - pYes or 0
	yes.Count.Text = poll.Yes .. (poll.Yes == 1 and " vote" or " votes") .. " · " .. pYes .. "%"
	no.Count.Text = poll.No .. (poll.No == 1 and " vote" or " votes") .. " · " .. pNo .. "%"
	TweenService:Create(fill, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Size = UDim2.fromScale(ratio, 1)}):Play()
	for choice, b in {Yes = yes, No = no} do
		local mine = myVote == choice
		b.Check.Visible = mine
		b.Stroke.Thickness = mine and 3.5 or 2
		b.Stroke.Color = mine and rgb(255, 220, 60) or b.Stroke:GetAttribute("Base") or b.Stroke.Color
		if not b.Stroke:GetAttribute("Base") then b.Stroke:SetAttribute("Base", b.Stroke.Color) end
		b.Button.Active = not poll.Ended
		b.Button.AutoButtonColor = false
	end
	if poll.Ended then
		heading.Text = "POLL RESULTS"
		timer.Text = "ENDED"
		if total == 0 then
			footer.Text = "Nobody voted..."
		elseif poll.Yes == poll.No then
			footer.Text = "It's a tie! " .. votesText
		else
			footer.Text = wordOf(poll.Yes > poll.No and "Yes" or "No") .. " wins! (" .. votesText .. " in all servers)"
		end
		for _, b in {yes, no} do b.Button.BackgroundTransparency = 0 end
		local loser = poll.Yes > poll.No and no or poll.No > poll.Yes and yes or nil
		if loser then loser.Button.BackgroundTransparency = 0.5 end
	else
		heading.Text = "GLOBAL POLL"
		footer.Text = myVote and ("You voted " .. wordOf(myVote) .. " · you can change your vote") or (votesText .. " in all servers · vote now!")
		for _, b in {yes, no} do b.Button.BackgroundTransparency = 0 end
	end
end

local shown = false
local function show()
	if shown then return end
	shown = true
	card.Visible = true
	TweenService:Create(card, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = shownPosition()}):Play()
end
local function hide()
	shown = false
	local t = TweenService:Create(card, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = HIDDEN})
	t:Play()
	t.Completed:Once(function() if not shown then card.Visible = false end end)
end
task.spawn(function() -- suit la barre Burn si elle bouge ou si l'écran change de taille
	while true do
		task.wait(0.6)
		if shown then
			local target = shownPosition()
			if math.abs(card.Position.Y.Offset - target.Y.Offset) > 1 then
				TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Position = target}):Play()
			end
		end
	end
end)

updateRemote.OnClientEvent:Connect(function(state, vote)
	if type(state) ~= "table" then return end
	if not poll or poll.Id ~= state.Id then myVote = vote end -- nouveau sondage
	poll = state
	question.Text = state.Question
	byLabel.Text = "Asked by " .. tostring(state.By)
	hideToken += 1
	render()
	show()
	if state.Ended then
		local token = hideToken
		task.delay(12, function() if hideToken == token then hide() end end)
	end
end)

local function vote(choice, b)
	if not poll or poll.Ended or myVote == choice then return end
	if poll.EndsAt - workspace:GetServerTimeNow() <= 0 then return end
	local prev = myVote
	myVote = choice
	-- affichage immédiat (le serveur renverra le vrai total)
	poll.Yes += (choice == "Yes" and 1 or 0) - (prev == "Yes" and 1 or 0)
	poll.No += (choice == "No" and 1 or 0) - (prev == "No" and 1 or 0)
	render()
	b.Pop.Scale = 0.88
	TweenService:Create(b.Pop, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	voteRemote:FireServer(poll.Id, choice)
end
yes.Button.Activated:Connect(function() vote("Yes", yes) end)
no.Button.Activated:Connect(function() vote("No", no) end)

-- temps restant
task.spawn(function()
	while true do
		if poll and not poll.Ended and card.Visible then
			local left = poll.EndsAt - workspace:GetServerTimeNow()
			timer.Text = clock(left)
			timer.TextColor3 = left <= 10 and rgb(255, 120, 110) or rgb(255, 240, 150)
		end
		task.wait(0.25)
	end
end)

-- reflets : un passage toutes les 3 s
task.spawn(function()
	while true do
		if card.Visible then
			local t = os.clock()
			for _, g in gleams do
				local k = ((t + g.Phase) % 3) / 0.8
				g.Gradient.Offset = Vector2.new(k <= 1 and (-1.2 + k * 2.4) or 1.3, 0)
			end
		end
		task.wait(0.03)
	end
end)
