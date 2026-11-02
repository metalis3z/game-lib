-- Generated from ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Okarun/ImpactFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ImpactFrame", { ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "12", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://78763104556656"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 12 })
		I[3] = new("ImageLabel", I[1], "11", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132420679501671"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 11 })
		I[4] = new("ImageLabel", I[1], "10", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://89674561028573"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 10 })
		I[5] = new("ImageLabel", I[1], "9", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103944192409286"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 9 })
		I[6] = new("ImageLabel", I[1], "8", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://139940866052330"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 8 })
		I[7] = new("ImageLabel", I[1], "7", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://78495232404115"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 7 })
		I[8] = new("ImageLabel", I[1], "6", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://138947560998260"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 6 })
		I[9] = new("ImageLabel", I[1], "5", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://88862266822200"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 5 })
		I[10] = new("ImageLabel", I[1], "4", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74441221186084"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 4 })
		I[11] = new("ImageLabel", I[1], "3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74209217411871"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
		I[12] = new("ImageLabel", I[1], "2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://94014436522480"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
		I[13] = new("ImageLabel", I[1], "1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://71483084640351"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[14] = new("ImageLabel", I[1], "13", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://108479301896613"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 13 })
		I[15] = new("ImageLabel", I[1], "14", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://95332498499217"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 14 })
		I[16] = new("ImageLabel", I[1], "15", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://140564552209702"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 15 })
		I[17] = new("ImageLabel", I[1], "16", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://82605653708665"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 16 })
		I[18] = new("ImageLabel", I[1], "17", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://95072541631781"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 17 })
		I[19] = new("ImageLabel", I[1], "18", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://124984259380591"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 18 })
		I[20] = new("ImageLabel", I[1], "19", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://94387416367832"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 19 })
		I[21] = new("ImageLabel", I[1], "20", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://84611255438546"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 20 })
		I[22] = new("ImageLabel", I[1], "21", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://71703707570349"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 21 })
		I[23] = new("ImageLabel", I[1], "22", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://119593524262851"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 22 })
		I[24] = new("ImageLabel", I[1], "23", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81021874587803"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 23 })
		I[25] = new("ImageLabel", I[1], "24", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://139708882431462"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 24 })
	return I[1]
end

return build
