-- Generated from ui/ReplicatedStorage/ReplicatedGui/VersionLabel.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "VersionLabel", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_2cf3854369" })
		I[2] = new("TextButton", I[1], "VersionLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0, 12), Selectable = false, Size = UDim2.fromOffset(200, 16), Text = "Version: 6767", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, Visible = false }, { ["ViralWorkerRef"] = "vw_6813b37347" })
			I[3] = new("UIStroke", I[2], "UIStroke", nil, { ["ViralWorkerRef"] = "vw_ed7ea4d4ed" })
	return I[1]
end

return build
