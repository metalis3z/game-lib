-- Generated from ui/ServerScriptService/Players/Player/Explorer.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Explorer")
		I[2] = new("Frame", I[1], "ExplorerPanel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(191, 191, 191), Position = UDim2.new(1, -308, 0, 160), Size = UDim2.new(0, 300, 1, -168) })
			I[3] = new("BindableEvent", I[2], "SelectionChanged")
			I[4] = new("BindableFunction", I[2], "SetOption")
			I[5] = new("BindableFunction", I[2], "SetSelection")
			I[6] = new("BindableFunction", I[2], "GetOption")
			I[7] = new("BindableFunction", I[2], "GetSelection")
	return I[1]
end

return build
