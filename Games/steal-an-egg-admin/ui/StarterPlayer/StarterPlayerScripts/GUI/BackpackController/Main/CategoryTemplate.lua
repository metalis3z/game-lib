-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/CategoryTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "CategoryTemplate", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.01, 0.02), RichText = true, Size = UDim2.fromScale(0.98, 0.09), Text = "Poops", TextColor3 = Color3.fromRGB(165, 165, 165), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "Cuc3AEP5Cuc3" })
	return I[1]
end

return build
