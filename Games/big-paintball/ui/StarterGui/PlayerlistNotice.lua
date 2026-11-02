-- Generated from ui/StarterGui/PlayerlistNotice.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PlayerlistNotice", { DisplayOrder = 5, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(-0.02, -25, 0, 0), Size = UDim2.new(1, 0, 0, 20), Text = "TAB for Leaderboard", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextTransparency = 0.75, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
		I[3] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0.01, 4), PaddingLeft = UDim.new(0.01, 4), PaddingRight = UDim.new(0.01, 4), PaddingTop = UDim.new(0.01, 3) })
		I[4] = new("Frame", I[1], "Xbox", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(1, 0), Size = UDim2.fromOffset(250, 42), Visible = false })
			I[5] = new("ImageLabel", I[4], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://4448384554"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0, 42, 1, 0) })
			I[6] = new("TextLabel", I[4], "TextLabel", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0), Size = UDim2.new(1, -54, 1, 0), Text = "Leaderboard", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
	return I[1]
end

return build
