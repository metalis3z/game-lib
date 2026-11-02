-- Generated from ui/ServerScriptService/RadioService/Assets/ClientController/MessageTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "MessageTemplate", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.0075, 0), Size = UDim2.fromScale(1, 0) })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder })
		I[3] = new("UICorner", I[1], "UICorner")
		I[4] = new("TextLabel", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(1, 0.2906455), Text = "CLIENTSCRIPTS", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[5] = new("UIPadding", I[4], "UIPadding", { PaddingLeft = UDim.new(0, 5), PaddingTop = UDim.new(0, 5) })
		I[6] = new("TextLabel", I[1], "Message", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0, 0.3293375), Size = UDim2.fromScale(1, 0.6706625), Text = "This is a testing message. This message created in studio and does not accurately reflect how the UI will look in game. I do not know what else I should put inside this text box.", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
			I[7] = new("UIPadding", I[6], "UIPadding", { PaddingLeft = UDim.new(0, 5) })
	return I[1]
end

return build
