-- Generated from ui/ReplicatedStorage/Misc/Error.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Error", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.95) })
		I[2] = new("TextLabel", I[1], "header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 252), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6, 0.3), Size = UDim2.fromScale(0.85, 0.15), Text = "Ė̵͕̌̌̍͋̄̅͠R̶̡̛̟̞̤̝̯͆͛͆̏́̓̌Ŗ̵̨̱̗̦̺͈̮̯͍͙́̍͊̾̇̅̋͐̅̔ͅǪ̸̟̣̰̱̰̝̱͗̌̋̇̈́̓̏̔̽ͅͅR̵̢̙̟̤̰̗͓͇̬̉̄̌͋̑̀̊͒̈́̂͊͛͜͜͠\n̶̛̩͇̥̘̺͐̿͑͗͆̇̚͜ͅ", TextColor3 = Color3.fromRGB(255, 3, 0), TextSize = 75, TextWrapped = true })
		I[3] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.15) })
			I[4] = new("Frame", I[3], "Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(222, 2, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, 3, 0.5, 0), Size = UDim2.new(1, -6, 1, -6) })
			I[5] = new("UIStroke", I[3], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Enabled = false, LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 8 })
		I[6] = new("TextLabel", I[1], "header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 252), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3, 0.8), Size = UDim2.fromScale(0.85, 0.15), Text = "Ė̵͕̌̌̍͋̄̅͠R̶̡̛̟̞̤̝̯͆͛͆̏́̓̌Ŗ̵̨̱̗̦̺͈̮̯͍͙́̍͊̾̇̅̋͐̅̔ͅǪ̸̟̣̰̱̰̝̱͗̌̋̇̈́̓̏̔̽ͅͅR̵̢̙̟̤̰̗͓͇̬̉̄̌͋̑̀̊͒̈́̂͊͛͜͜͠\n̶̛̩͇̥̘̺͐̿͑͗͆̇̚͜ͅ", TextColor3 = Color3.fromRGB(255, 3, 0), TextSize = 75, TextWrapped = true })
	return I[1]
end

return build
