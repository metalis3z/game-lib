-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Gamepad, time of decompilation: Sun May  3 10:09:33 2026 ]]
local GamepadService = game:GetService("GamepadService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local DPadUp = Enum.KeyCode.DPadUp
local Gamepad = Enum.PreferredInput.Gamepad
local t1 = {}
local u7 = nil

function t1.start(p1) -- line: 26
	-- upvalues: u7 (ref), DPadUp (copy), GuiService (copy), UserInputService (copy), Gamepad (copy), t1 (copy), GamepadService (copy)
	u7 = p1
	u7.highlightKey = if u7.highlightKey == nil then DPadUp else u7.highlightKey
	u7.highlightIcon = false
	task.delay(1, function() -- line: 35
		-- upvalues: u7 (ref), GuiService (copy), DPadUp (copy), UserInputService (copy), Gamepad (copy), t1 (copy), GamepadService (copy)
		local iconsDictionary = u7.iconsDictionary
		local u19 = nil
		local u20 = DPadUp ~= u7.highlightKey
		local u21 = DPadUp ~= u7.highlightKey
		local Selection = require(script.Parent.Parent.Elements.Selection)

		local function updateSelectedObject() -- line: 50
			-- upvalues: GuiService (copy), iconsDictionary (copy), UserInputService (copy), Gamepad (copy), Selection (copy), u7 (ref), u19 (ref), u21 (ref), u20 (ref), t1 (copy)
			local SelectedObject = GuiService.SelectedObject
			local v31 = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")
			local v32 = v31 and iconsDictionary[v31]
			local v33 = UserInputService.PreferredInput == Gamepad

			if v32 then
				if v33 then
					local v34 = v32:getInstance("ClickRegion")
					local selection = v32.selection

					if not selection then
						selection = v32.janitor:add(Selection(u7))
						selection:SetAttribute("IgnoreVisibilityUpdater", true)
						selection.Parent = v32.widget
						v32.selection = selection
						v32:refreshAppearance(selection)
					end

					v34.SelectionImageObject = selection.Selection
				end

				if u19 and v32 ~= u19 then
					u19:setIndicator()
				end

				local v36 = if not v33 or (u21 or v32.parentIconUID) then nil else Enum.KeyCode.ButtonB

				u19 = v32
				u7.lastHighlightedIcon = v32
				v32:setIndicator(v36)

				return
			end

			local v37 = if not v33 or u20 then nil else u7.highlightKey

			if not u19 then
				u19 = t1.getIconToHighlight()
			end

			if v37 == u7.highlightKey then
				u20 = true
			end

			if u19 then
				u19:setIndicator(v37)
			end
		end

		GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(updateSelectedObject)
		UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ preferredInputChanged ]] -- line: 93
			-- upvalues: UserInputService (copy), Gamepad (copy), u20 (ref), u21 (ref), updateSelectedObject (copy)
			if UserInputService.PreferredInput ~= Gamepad then
				u20 = false
				u21 = false
			end

			updateSelectedObject()
		end)

		if UserInputService.PreferredInput ~= Gamepad then
			u20 = false
			u21 = false
		end

		updateSelectedObject()
		UserInputService.InputBegan:Connect(function(input, _) -- line: 109
			-- upvalues: GuiService (copy), iconsDictionary (copy), u7 (ref), t1 (copy), GamepadService (copy)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				local SelectedObject = GuiService.SelectedObject
				local v41 = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")

				if v41 and iconsDictionary[v41] then
					GuiService.SelectedObject = nil
				end

				return
			end

			if input.KeyCode ~= u7.highlightKey then
				return
			end

			local v42 = t1.getIconToHighlight()

			if v42 then
				if GamepadService.GamepadCursorEnabled then
					task.wait(0.2)
					GamepadService:DisableGamepadCursor()
				end

				GuiService.SelectedObject = v42:getInstance("ClickRegion")
			end
		end)
	end)
end
function t1.getIconToHighlight() -- line: 136
	-- upvalues: u7 (ref)
	local iconsDictionary = u7.iconsDictionary
	local v10 = u7.highlightIcon or u7.lastHighlightedIcon

	if not v10 then
		local AbsolutePositionX = nil

		for _, v in pairs(iconsDictionary) do
			if not v.parentIconUID then
				local AbsolutePositionX2 = v.widget.AbsolutePosition.X

				if not AbsolutePositionX or AbsolutePositionX2 < AbsolutePositionX then
					v10 = v
					AbsolutePositionX = v10.widget.AbsolutePosition.X
				end
			end
		end
	end

	return v10
end
function t1.registerButton(p3) -- line: 158
	-- upvalues: UserInputService (copy), GamepadService (copy), GuiService (copy)
	local u16 = false

	p3.InputBegan:Connect(function(_) -- line: 164
		-- upvalues: u16 (ref)
		u16 = true
		task.wait()
		task.wait()
		u16 = false
	end)

	local connection = UserInputService.InputBegan:Connect(function(input) -- line: 173
		-- upvalues: u16 (ref), GamepadService (copy), GuiService (copy), p3 (copy)
		task.wait()

		if input.KeyCode == Enum.KeyCode.ButtonA and u16 then
			task.wait(0.2)
			GamepadService:DisableGamepadCursor()
			GuiService.SelectedObject = p3

			return
		end

		local v26 = GuiService.SelectedObject == p3
		local KeyCodeName = input.KeyCode.Name

		if table.find({
			"ButtonB",
			"ButtonSelect"
		}, KeyCodeName) and v26 and (KeyCodeName ~= "ButtonSelect" or GamepadService.GamepadCursorEnabled) then
			GuiService.SelectedObject = nil
		end
	end)

	p3.Destroying:Once(function() -- line: 194
		-- upvalues: connection (copy)
		connection:Disconnect()
	end)
end

return t1
