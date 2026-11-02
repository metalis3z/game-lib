-- Generated from ui/StarterGui/Countdown.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Countdown", { DisplayOrder = 5, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Container", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0, 14), Size = UDim2.fromOffset(460, 0), Visible = false })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
			I[4] = new("TextLabel", I[2], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 28), Text = "", TextColor3 = Color3.fromRGB(255, 215, 0), TextSize = 22, Visible = false })
				I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 3.5 })
			I[6] = new("TextLabel", I[2], "Time", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 54), Text = "0:00", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 46 })
				I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 5 })
	return I[1]
end

return build
