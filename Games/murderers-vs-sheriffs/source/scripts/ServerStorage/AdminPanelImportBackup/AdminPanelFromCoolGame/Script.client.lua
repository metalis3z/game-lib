-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ===== Customization =====
local MAX_ITEMS = 6
local SHOW_TIME = 5
local TWEEN_IN_TIME = 0.5
local TWEEN_OUT_TIME = 0.5
local ANNOUNCEMENT_HEIGHT = 60
local FONT_SIZE = 22
local CARD_WIDTH = 0.7
local CORNER_RADIUS = 10
local CARD_COLOR = Color3.fromRGB(20,20,20)
local CARD_TRANSPARENCY = 0.50
local STROKE_COLOR = Color3.fromRGB(210,210,210)
local STROKE_THICKNESS = 2
local PFP_SIZE = 42
local PFP_CORNER_RADIUS = 1
local DEFAULT_PFP = "rbxthumb://type=AvatarHeadShot&id=1&w=100&h=100"
local TEXT_COLOR = Color3.new(1,1,1)
local TEXT_PADDING = 8
local TOP_OFFSET = 0.07
local CARD_FADE_IN = true
local LABEL_FADE_IN = true
local PFP_FADE_IN = true

-- Tween info
local TWEEN_IN = TweenInfo.new(TWEEN_IN_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local TWEEN_OUT = TweenInfo.new(TWEEN_OUT_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.In)

local layoutCounter = 0
local AnnouncementEvent = ReplicatedStorage:WaitForChild("AnnouncementEvent")

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "AnnouncementGUI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = playerGui

local holder = Instance.new("Frame")
holder.Name = "Holder"
holder.AnchorPoint = Vector2.new(0.5, 0)
holder.Position = UDim2.new(0.5, 0,0.1, 44)
holder.Size = UDim2.new(0.8, 0, 0.7, 0)
holder.BackgroundTransparency = 1
holder.Parent = gui

local layout = Instance.new("UIListLayout")
layout.Name = "List"
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top
layout.Parent = holder

-- Trim old announcements
local function trimOld()
	local slots = {}
	for _, c in ipairs(holder:GetChildren()) do
		if c:IsA("Frame") and c.Name == "AnnouncementSlot" then
			table.insert(slots, c)
		end
	end
	if #slots <= MAX_ITEMS then return end
	table.sort(slots, function(a,b) return (a.LayoutOrder or 0) < (b.LayoutOrder or 0) end)
	slots[1]:Destroy()
end

-- Create Announcement
local function createAnnouncementItem(userId, text)
	layoutCounter = layoutCounter + 1

	local slot = Instance.new("Frame")
	slot.Name = "AnnouncementSlot"
	slot.Size = UDim2.new(1,0,0,ANNOUNCEMENT_HEIGHT)
	slot.BackgroundTransparency = 1
	slot.LayoutOrder = layoutCounter
	slot.Parent = holder

	local card = Instance.new("Frame")
	card.Name = "Card"
	card.AnchorPoint = Vector2.new(0.5,0)
	card.Position = UDim2.new(0.5,0,0,-8)
	card.Size = UDim2.new(CARD_WIDTH,0,1,0)
	card.BackgroundColor3 = CARD_COLOR
	card.BackgroundTransparency = CARD_FADE_IN and 1 or (1 - CARD_TRANSPARENCY)
	card.Parent = slot

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,CORNER_RADIUS)
	corner.Parent = card

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = STROKE_THICKNESS
	stroke.Color = STROKE_COLOR
	stroke.Transparency = 1
	stroke.Parent = card

	local content = Instance.new("Frame")
	content.AnchorPoint = Vector2.new(0.5,0.5)
	content.Position = UDim2.new(0.5,0,0.5,0)
	content.Size = UDim2.new(1,0,1,0)
	content.BackgroundTransparency = 1
	content.Parent = card

	local pfp = Instance.new("ImageLabel")
	pfp.Size = UDim2.new(0,PFP_SIZE,0,PFP_SIZE)
	pfp.AnchorPoint = Vector2.new(0,0.5)
	pfp.Position = UDim2.new(0,0,0.5,0)
	pfp.BackgroundTransparency = 1
	pfp.Image = DEFAULT_PFP
	pfp.Visible = true
	pfp.Parent = content

	local round = Instance.new("UICorner")
	round.CornerRadius = UDim.new(PFP_CORNER_RADIUS,0)
	round.Parent = pfp

	local label = Instance.new("TextLabel")
	label.Text = text
	label.Font = Enum.Font.GothamBold
	label.TextSize = FONT_SIZE
	label.TextColor3 = TEXT_COLOR
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.BackgroundTransparency = 1
	label.AutomaticSize = Enum.AutomaticSize.X
	label.Parent = content

	-- Center PFP + text
	task.defer(function()
		local totalWidth = pfp.AbsoluteSize.X + TEXT_PADDING + label.AbsoluteSize.X
		local startX = (content.AbsoluteSize.X - totalWidth)/2
		pfp.Position = UDim2.new(0, startX, 0.5, 0)
		label.Position = UDim2.new(0, startX + pfp.AbsoluteSize.X + TEXT_PADDING, 0.5, 0)
	end)

	-- Fetch user thumbnail
	if type(userId) == "number" and userId > 0 then
		local ok, result = pcall(function()
			return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
		end)
		if ok and result ~= "" then
			pfp.Image = result
		end
	end

	-- Tweens
	if CARD_FADE_IN then
		TweenService:Create(card,TWEEN_IN,{BackgroundTransparency=1-CARD_TRANSPARENCY}):Play()
	end
	if LABEL_FADE_IN then
		label.TextTransparency = 1
		TweenService:Create(label,TWEEN_IN,{TextTransparency=0}):Play()
	end
	if PFP_FADE_IN then
		pfp.ImageTransparency = 1
		TweenService:Create(pfp,TWEEN_IN,{ImageTransparency=0}):Play()
	end
	TweenService:Create(stroke,TWEEN_IN,{Transparency=0}):Play()

	task.delay(SHOW_TIME,function()
		local t1 = TweenService:Create(label,TWEEN_OUT,{TextTransparency=1})
		local t2 = TweenService:Create(card,TWEEN_OUT,{BackgroundTransparency=1})
		local t3 = TweenService:Create(stroke,TWEEN_OUT,{Transparency=1})
		local t4 = TweenService:Create(pfp,TWEEN_OUT,{ImageTransparency=1})
		t1:Play(); t2:Play(); t3:Play(); t4:Play()
		task.delay(TWEEN_OUT_TIME,function()
			if slot and slot.Parent then slot:Destroy() end
		end)
	end)

	trimOld()
end

-- Connect RemoteEvent
AnnouncementEvent.OnClientEvent:Connect(function(userId,text)
	if typeof(text) == "string" and text:match("%S") then
		createAnnouncementItem(userId,text)
	end
end)