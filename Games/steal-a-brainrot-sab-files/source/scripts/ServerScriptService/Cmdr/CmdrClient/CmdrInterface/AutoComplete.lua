local Players = game:GetService("Players")
local Player = Players.LocalPlayer

return function (Cmdr)
	local AutoComplete = {
		Items = {};
		ItemOptions = {};
		SelectedItem = 0;
	}

	local Util = Cmdr.Util
	local Shorthands = Util.MakeDictionary({"me", "all", ".", "*", "others"})

	local Gui = Player:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Autocomplete")
	local AutoItem = Gui:WaitForChild("TextButton")
	local Title = Gui:WaitForChild("Title")
	local Description = Gui:WaitForChild("Description")
	local Entry = Gui.Parent:WaitForChild("Frame"):WaitForChild("Entry")
	AutoItem.Parent = nil

	local function SetText(obj, textObj, text, sizeFromContents)
		obj.Visible = text ~= nil
		textObj.Text = text or ""

		if sizeFromContents then
			textObj.Size = UDim2.new(0, Util.GetTextSize(text or "", textObj, Vector2.new(1000, 1000), 1, 0).X, obj.Size.Y.Scale, obj.Size.Y.Offset)
		end
	end

	local function UpdateInfoDisplay (options)
		SetText(Title, Title.Field, options.name, true)
		SetText(Title.Field.Type, Title.Field.Type, options.type and ": " .. options.type:sub(1, 1):upper() .. options.type:sub(2))
		SetText(Description, Description.Label, options.description)

		Description.Label.TextColor3 = options.invalid and Color3.fromRGB(255, 73, 73) or Color3.fromRGB(255, 255, 255)

		local infoWidth = Title.Field.TextBounds.X + Title.Field.Type.TextBounds.X

		local guiWidth = math.max(infoWidth, Gui.Size.X.Offset)
		Description.Size = UDim2.new(1, 0, 0, 40)

		while not Description.Label.TextFits do
			Description.Size = Description.Size + UDim2.new(0, 0, 0, 2)

			if Description.Size.Y.Offset > 500 then
				break
			end
		end

		wait()
		Gui.UIListLayout:ApplyLayout()
		Gui.Size = UDim2.new(0, guiWidth, 0, Gui.UIListLayout.AbsoluteContentSize.Y)
	end

	function AutoComplete:Show (items, options)
		options = options or {}

		for _, item in pairs(self.Items) do
			if item.gui then
				item.gui:Destroy()
			end
		end

		self.SelectedItem = 1
		self.Items = items
		self.Prefix = options.prefix or ""
		self.LastItem = options.isLast or false
		self.Command = options.command
		self.Arg = options.arg
		self.NumArgs = options.numArgs
		self.IsPartial = options.isPartial

		local autocompleteWidth = 200

		for i, item in pairs(self.Items) do
			local leftText = item[1]
			local rightText = item[2]

			if Shorthands[leftText] then
				leftText = rightText
			end

			local btn = AutoItem:Clone()
			btn.Name = leftText .. rightText
			btn.BackgroundTransparency = i == self.SelectedItem and 0.5 or 1
			btn.Typed.Text = leftText
			btn.Suggest.Text = string.rep(" ", #leftText) .. rightText:sub(#leftText + 1)
			btn.Parent = Gui
			btn.LayoutOrder = i

			local maxBounds = math.max(btn.Typed.TextBounds.X, btn.Suggest.TextBounds.X) + 20
			if maxBounds > autocompleteWidth then
				autocompleteWidth = maxBounds
			end

			item.gui = btn
		end

		Gui.UIListLayout:ApplyLayout()

		local text = Entry.TextBox.Text
		local words = Util.SplitString(text)
		if text:sub(#text, #text) == " " and not options.at then
			words[#words+1] = "e"
		end
		table.remove(words, #words)
		local extra = (options.at and options.at or (#table.concat(words, " ") + 1)) * 7

		Gui.Position = UDim2.new(0, Entry.TextBox.AbsolutePosition.X - 10 + extra, 0, Entry.TextBox.AbsolutePosition.Y + 30)
		Gui.Size = UDim2.new(0, autocompleteWidth, 0, Gui.UIListLayout.AbsoluteContentSize.Y)
		Gui.Visible = true

		UpdateInfoDisplay(self.Items[1] and self.Items[1].options or options)
	end

	function AutoComplete:GetSelectedItem ()
		if Gui.Visible == false then
			return nil
		end

		return AutoComplete.Items[AutoComplete.SelectedItem]
	end

	function AutoComplete:Hide ()
		Gui.Visible = false
	end

	function AutoComplete:IsVisible ()
		return Gui.Visible
	end

	function AutoComplete:Select (delta)
		if not Gui.Visible then return end

		self.SelectedItem = self.SelectedItem + delta

		if self.SelectedItem > #self.Items then
			self.SelectedItem = 1
		elseif self.SelectedItem < 1 then
			self.SelectedItem = #self.Items
		end

		for i, item in pairs(self.Items) do
			item.gui.BackgroundTransparency = i == self.SelectedItem and 0.5 or 1
		end

		if self.Items[self.SelectedItem] and self.Items[self.SelectedItem].options then
			UpdateInfoDisplay(self.Items[self.SelectedItem].options or {})
		end
	end

	return AutoComplete
end
