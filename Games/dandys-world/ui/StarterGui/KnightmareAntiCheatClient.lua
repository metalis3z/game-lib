-- Generated from ui/StarterGui/KnightmareAntiCheatClient.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "KnightmareAntiCheatClient", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "KMDebugFrame", { AnchorPoint = Vector2.new(1, 1), BackgroundTransparency = 0.5, Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0.35, 0.35), Visible = false })
			I[3] = new("Frame", I[2], "FrameFPS", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 0.5, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromOffset(100, 30) })
				I[4] = new("TextLabel", I[3], "CurrentFPSTextLabel", { BackgroundTransparency = 1, Position = UDim2.fromScale(0.25, 0), Size = UDim2.fromScale(0.5, 1), Text = "🐞6 FPS", TextColor3 = Color3.fromRGB(171, 255, 255) })
				I[5] = new("TextButton", I[3], "DownTextButton", { Size = UDim2.fromScale(0.25, 1), Text = "-" })
				I[6] = new("UICorner", I[3], "UICorner")
				I[7] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder })
				I[8] = new("UISizeConstraint", I[3], "UISizeConstraint")
				I[9] = new("TextButton", I[3], "UpTextButton", { Position = UDim2.fromScale(0.75, 0), Size = UDim2.fromScale(0.25, 1), Text = "+" })
			I[10] = new("TextLabel", I[2], "KMDebugTextOutputLabel", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -30), Text = "", TextColor3 = Color3.fromRGB(171, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
	return I[1]
end

return build
