-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = {}
local NotificationInstance = require(script.Parent.NotificationInstance)
local Functions = require(game.ReplicatedStorage.Library.Functions)
local ItemUI = require(game.ReplicatedStorage.Library.Client.UI.ItemUI)
local Audio = require(game.ReplicatedStorage.Library.Audio)
local Asserts = require(game.ReplicatedStorage.Library.Asserts)
local AddDebris = require(ReplicatedStorage.Library.Functions.AddDebris)
local Rarity = require(ReplicatedStorage.Directory.Rarity)
local Item2 = game.ReplicatedStorage.Assets.UI.Notifications.Bottom.Item2
local Items = game.ReplicatedStorage.Assets.UI.Items
local t2 = {}
local v1 = Functions.Debounce()

local function animateItemNotification(p1, p2) --[[ animateItemNotification | Line: 27 | Upvalues: v1 (copy), Rarity (copy), Audio (copy), Functions (copy), AddDebris (copy), RunService (copy) ]]
	v1(0.15, function() --[[ Line: 29 | Upvalues: p2 (copy), Rarity (ref), Audio (ref) ]]
		local Item = p2.Item

		if Item and Item:GetRarity().RarityNumber >= Rarity.Rarities.Cosmic.RarityNumber then
			Audio.Play("rbxassetid://73352992887992", script, 1, 1)
		else
			Audio.Play("rbxassetid://140330605945074", script, 1, 2)
		end
	end)

	local v12 = nil

	if v12 and tick() - v12 < 2 then
		return
	end

	tick()
	p1.Glow.ImageTransparency = 0
	Functions.Tween(p1.Glow, {
		ImageTransparency = 1
	}, { 2, "Sine", "InOut" })
	p1.Glow.UIScale.Scale = 3
	Functions.Tween(p1.Glow.UIScale, {
		Scale = 1
	}, { 2, "Expo", "Out" })

	local ImageTransparency = p1.Frame.ItemHolder.glow.ImageTransparency

	p1.Frame.ItemHolder.glow.ImageTransparency = 1
	Functions.Tween(p1.Frame.ItemHolder.glow, {
		ImageTransparency = ImageTransparency
	}, { 1.5, "Sine", "Out" })

	local Frame = p1:FindFirstChild("Frame")

	if Frame then
		local function createItemEcho() --[[ createItemEcho | Line: 65 | Upvalues: p1 (copy), Frame (copy), Functions (ref), AddDebris (ref), RunService (ref) ]]
			if not (p1 and Frame) then
				return
			end

			local AbsoluteSize = p1.Frame.ItemHolder.AbsoluteSize
			local v1 = game.ReplicatedStorage.Assets.UI.OTHER.ItemEcho:Clone()

			v1.AnchorPoint = Vector2.new(0.5, 0.5)
			v1.ZIndex = 1
			v1.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
			v1.Size = UDim2.new(0, AbsoluteSize.X * 1.2, 0, AbsoluteSize.Y * 1.2)

			if p1 and Frame then
				v1.Parent = p1.Frame:FindFirstAncestorOfClass("ScreenGui")

				local v2 = Functions.Tween(v1, {
					ImageTransparency = 1,
					Size = UDim2.new(0, AbsoluteSize.X * 2.2, 0, AbsoluteSize.Y * 2.2)
				}, { 0.4, "Sine", "Out" })

				v2.Completed:Connect(function() --[[ Line: 86 | Upvalues: AddDebris (ref), v1 (copy) ]]
					AddDebris(v1)
				end)
				task.spawn(function() --[[ Line: 90 | Upvalues: p1 (ref), v1 (copy), Frame (ref), v2 (copy), RunService (ref) ]]
					local AbsolutePosition = p1.Frame.ItemHolder.AbsolutePosition
					local AbsoluteSize = p1.Frame.ItemHolder.AbsoluteSize

					while v1 and v1.Parent do
						if not (p1 and Frame) then
							v2:Cancel()

							return
						end

						if p1 and p1.Parent then
							AbsolutePosition = p1.Frame.ItemHolder.AbsolutePosition
							AbsoluteSize = p1.Frame.ItemHolder.AbsoluteSize
						end

						v1.Position = UDim2.new(0, AbsolutePosition.X + AbsoluteSize.X / 2, 0, AbsolutePosition.Y + AbsoluteSize.Y / 2 * 1.75)
						RunService.RenderStepped:Wait()
					end
				end)
			end
		end

		local v2 = nil

		Frame.Destroying:Once(function() --[[ Line: 118 | Upvalues: v2 (ref) ]]
			if v2 then
				task.cancel(v2)
			end
		end)
		v2 = task.spawn(function() --[[ Line: 126 | Upvalues: createItemEcho (copy), p1 (copy), Frame (copy) ]]
			task.wait(0.1)
			createItemEcho()
			task.wait(0.1)
			createItemEcho()
			task.wait(0.1)
			createItemEcho()
			task.wait(0.1)
			task.wait(1)

			if p1 and Frame then
				createItemEcho()
			end
		end)
	end
end

local function createEntry(p1) --[[ createEntry | Line: 145 | Upvalues: Item2 (copy), Items (copy), ReplicatedStorage (copy), ItemUI (copy), Functions (copy) ]]
	local Item = p1.Item
	local v1 = p1.RarityOverride or Item:GetRarity()
	local v2 = Item:IsA("PowerUp")
	local v3 = Item2.Entry:Clone()

	v3.Frame.ItemHolder:FindFirstChild("Item"):Destroy()
	v3.Frame.ItemHolder:FindFirstChildOfClass("UIGradient"):Destroy()
	v3.Frame.ItemHolder.glow:FindFirstChildOfClass("UIGradient"):Destroy()
	v3.TextLabel.Text = if v2 then "NEW POWER UP!" elseif Item:GetAmount() > 1 then "New Items!" else "New Item!"
	v3.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

	if v2 then
		v3.TextLabel.Size = UDim2.fromScale(2, 0.275)
		v3.TextLabel.FontFace = Font.fromEnum(Enum.Font.LuckiestGuy)
		v3.TextLabel.FontFace.Weight = Enum.FontWeight.Bold
	end

	local Gradient = v1.Gradient
	local v6

	if v1.DisplayName == "Basic" then
		Gradient = ReplicatedStorage.Assets.UI.Gradients.LightGreyGradient
		v6 = true
	else
		v6 = false
	end

	local t = {
		NoActionMenu = true,
		HideQuantity = false,
		HideStrength = true,
		NoButtonFX = true,
		ShowCurrencyBag = true,
		NoLoadingAnimation = true,
		NoScribble = v6
	}

	if Item:GetAmount() == 1 and not Item:IsA("Currency") then
		t.HideQuantity = true
	end

	local v7 = ItemUI.Create(Item, t)

	Instance.new("UIAspectRatioConstraint").Parent = v7
	v7.Size = UDim2.new(1, 0, 1, 0)
	v7.Parent = v3.Frame.ItemHolder
	Gradient:Clone().Parent = v3.Frame.ItemHolder
	Gradient:Clone().Parent = v3.Frame.ItemHolder.coreImage
	Gradient:Clone().Parent = v3.Frame.ItemHolder.glow

	local UIScale = Instance.new("UIScale")

	UIScale.Scale = 1.35
	UIScale.Parent = v3
	v3.AnchorPoint = Vector2.new(0.5, 0.5)
	Functions.Tween(UIScale, {
		Scale = 1
	}, { 0.35, "Back", "Out" })

	return v3
end

local function processBottomQueue() --[[ processBottomQueue | Line: 210 | Upvalues: t2 (copy), Item2 (copy), createEntry (copy), Functions (copy), animateItemNotification (copy), NotificationInstance (copy) ]]
	local v2 = math.min(4, #t2)
	local v3 = Item2:Clone()

	v3.Entry:Destroy()

	local t = {}
	local v4 = nil
	local v5 = false

	for i = 1, v2 do
		local v6 = t2[1]

		table.remove(t2, 1)

		local v7 = createEntry(v6.config)

		v7.Parent = v3
		table.insert(t, {
			frame = v7,
			config = v6.config
		})

		if v6.superConfig and (v6.superConfig.Time and (not v4 or v6.superConfig.Time < 0)) then
			v4 = v6.superConfig
		end

		if v6.superConfig and v6.superConfig.Force then
			v4 = v6.superConfig
			v5 = true
		end
	end

	if v4 then
		local v8 = Functions.DeepCopyUnsafe(v4)

		v8.Force = v5
		v4 = v8
	end

	local function triggerAnimations() --[[ triggerAnimations | Line: 245 | Upvalues: t (copy), animateItemNotification (ref) ]]
		for i, v in ipairs(t) do
			animateItemNotification(v.frame, v.config)
		end
	end

	NotificationInstance.new(NotificationInstance.Locations.Bottom, v3, triggerAnimations, v4)
end

function t.pushToFrame(p1, p2) --[[ pushToFrame | Line: 254 | Upvalues: createEntry (copy), animateItemNotification (copy) ]]
	local v1 = createEntry(p1.config)

	p2.created = tick()
	v1.Parent = p2.frame
	animateItemNotification(v1, p1.config)
end

local function tryAppendToBottom(p1) --[[ tryAppendToBottom | Line: 264 | Upvalues: NotificationInstance (copy), createEntry (copy), animateItemNotification (copy) ]]
	local list = {}

	for i, v in ipairs((NotificationInstance.GetBottomRenders())) do
		if v.created and not v.tweening then
			table.insert(list, {
				data = v,
				sort = v.created
			})
		end
	end

	table.sort(list, function(p1, p2) --[[ Line: 274 ]]
		return p1.sort < p2.sort
	end)

	for i, v in ipairs(list) do
		local data = v.data

		if data.frame.Name == "Item2" then
			local count = 0

			for i2, v2 in ipairs(data.frame:GetChildren()) do
				if v2:IsA("GuiObject") then
					count = count + 1
				end
			end

			if count < 4 then
				data.created = tick()

				local v2 = createEntry(p1.config)

				v2.Parent = data.frame
				animateItemNotification(v2, p1.config)

				return true
			end
		end
	end

	return false
end

function t.Bottom(p1, p2) --[[ Bottom | Line: 300 | Upvalues: Asserts (copy), tryAppendToBottom (copy), t2 (copy) ]]
	Asserts.table(p1)
	Asserts.table(p1.Item)

	local t = {
		config = p1,
		superConfig = p2
	}

	if tryAppendToBottom(t) or #t2 >= 16 then
		return nil
	end

	table.insert(t2, t)

	return nil
end
task.spawn(function() --[[ Line: 316 | Upvalues: t2 (copy), processBottomQueue (copy) ]]
	while true do
		while #t2 == 0 do
			task.wait()
		end

		processBottomQueue()
		task.wait(0.25)
	end
end)

return t