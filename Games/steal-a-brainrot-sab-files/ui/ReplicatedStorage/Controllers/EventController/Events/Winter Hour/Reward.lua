-- Generated from ui/ReplicatedStorage/Controllers/EventController/Events/Winter Hour/Reward.rbxm by _tools/rbxm2lua.luau
-- UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("BillboardGui", nil, "Reward", { Active = true, ClipsDescendants = true, LightInfluence = 1.5, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(4.5, 2), StudsOffset = Vector3.new(0, 0, 2.2), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "dGH2OY1ndGH2" })
		I[2] = new("TextLabel", I[1], "CurrencyCandyCane", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 1), Text = "+10", TextColor3 = Color3.fromRGB(255, 64, 64), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "TPuIK1qwTPuI" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "olhlrjX1olhl" })
		I[4] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(-0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "9kmvoHoQ9kmv" })
		I[5] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81083444361233"), ImageTransparency = 1, Position = UDim2.fromScale(0.02, 0), Rotation = -25, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["_lemonadeUniqueId"] = "gfFJ7HwsgfFJ" })
			I[6] = new("ImageLabel", I[5], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81083444361233"), Position = UDim2.fromScale(0.5, 0.5), Rotation = -25, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["_lemonadeUniqueId"] = "4YS3VtNb4YS3" })
	return I[1]
end

return build
