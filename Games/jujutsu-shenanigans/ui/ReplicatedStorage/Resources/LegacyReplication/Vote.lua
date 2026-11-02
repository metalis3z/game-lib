-- Generated from ui/ReplicatedStorage/Resources/LegacyReplication/Vote.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Vote", { DisplayOrder = 125125 })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(0.864486, 0.6804512), ZIndex = 14 })
			I[3] = new("VideoFrame", I[2], "VideoFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Looped = true, Playing = true, Position = UDim2.fromScale(0.5, 0.5837938), Size = UDim2.fromScale(0.5405405, 0.626151), VideoContent = Content.fromUri("rbxassetid://18334186832") })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 1.7647059 })
			I[5] = new("TextButton", I[2], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9392265), Size = UDim2.fromScale(0.5405405, 0.063), Text = "I ALREADY VOTED", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeTransparency = 0, TextWrapped = true })
				I[6] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 25 })
			I[7] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -0.0128914), RichText = true, Size = UDim2.fromScale(1, 0.2707182), Text = "<font size=\"45\">The Strongest Battlegrounds is a part of </font> <font size=\"45\" color='rgb(255, 240, 157)'>2024 Innovation Awards 🤯</font>\n<font size=\"35\">If The Strongest Battlegrounds wins any award, we promise</font> <font size=\"35\" color='rgb(158, 255, 174)'>good things!</font>\nPLEASE VOTE US FOR - \n<font color='rgb(255, 240, 157)'>\"PEOPLE'S CHOICE\"</font> <font size=\"20\">(GO TO RDC VOTING)</font>\n<font color='rgb(255, 240, 157)'>\"BEST FIGHTING\"</font> <font size=\"20\">(CLICK BUTTON AT THE TOP)</font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 23, TextStrokeTransparency = 0, TextWrapped = true })
				I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint", { AspectRatio = 7.5510197 })
			I[9] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.044199 })
	return I[1]
end

return build
