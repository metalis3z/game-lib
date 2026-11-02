local v0 = "rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json"
local UserInputService = game:GetService("UserInputService")

if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
	local v2 = require(script.Parent)
	local v3 = require(script.Parent.Parent.topbarplus).new()

	v3:modifyTheme({
		{ "IconLabelContainer", "TargetWidth", 0 },
		{ "IconLabel", "AutoLocalize", false }
	})
	v3:setLabel("backpack")
	v3:setOrder(-1)
	v3:setTextSize(24)
	v3:setTextFont(v0, Enum.FontWeight.Bold, Enum.FontStyle.Normal, "Selected")
	v3:setTextFont(v0, Enum.FontWeight.Regular, Enum.FontStyle.Normal, "Deselected")
	v3:bindToggleKey(Enum.KeyCode.Backquote)
	v3:autoDeselect(false)
	v3:setCaption("Inventory")
	v2.StateChanged.Event:Connect(function(p1) --[[ Line: 34 | Upvalues: v3 (copy) ]]
		if p1 then
			v3:select()
		else
			v3:deselect()
		end
	end)
	v3.toggled:Connect(function(p1, p2) --[[ Line: 42 | Upvalues: v2 (copy) ]]
		if p2 ~= "User" or not v2.OpenClose then
			return
		end

		v2.OpenClose()
	end)
end