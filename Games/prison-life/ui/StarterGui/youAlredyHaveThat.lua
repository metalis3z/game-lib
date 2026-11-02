-- Generated from ui/StarterGui/youAlredyHaveThat.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "youAlredyHaveThat")
		I[2] = new("Frame", I[1], "Frame", { Active = true, BackgroundColor3 = Color3.fromRGB(0, 69, 118), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 53, 88), BorderSizePixel = 0, Position = UDim2.fromOffset(530, 475), Size = UDim2.fromOffset(305, 23), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[3] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://267232285"), ImageTransparency = 0.8, Position = UDim2.fromScale(-0.0040649, 0), Size = UDim2.fromScale(1.0040652, 1) })
			I[4] = new("TextLabel", I[2], "TextLabel", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0040649, 0.125), Size = UDim2.fromScale(1.0040652, 0.75), Text = "You alredy have that!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
	return I[1]
end

return build
