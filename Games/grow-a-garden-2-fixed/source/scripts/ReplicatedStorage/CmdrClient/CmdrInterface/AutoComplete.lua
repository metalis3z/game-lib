--credit to leon games studio
local LocalPlayer = game:GetService("Players").LocalPlayer

return function(p1) --[[ Line: 5 | Upvalues: LocalPlayer (copy) ]]
	local t = {
		SelectedItem = 0,
		Items = {},
		ItemOptions = {}
	}
	local Util = p1.Util
	local Autocomplete = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Autocomplete")
	local TextButton = Autocomplete:WaitForChild("TextButton")
	local Title = Autocomplete:WaitForChild("Title")
	local Description = Autocomplete:WaitForChild("Description")
	local Entry = Autocomplete.Parent:WaitForChild("Frame"):WaitForChild("Entry")

	TextButton.Parent = nil

	local ScrollBarThickness = Autocomplete.ScrollBarThickness

	local function SetText(p1, p2, p3, p4) --[[ SetText | Line: 24 | Upvalues: Util (copy) ]]
		p1.Visible = if p3 == nil then false else true
		p2.Text = p3 or ""

		if not p4 then
			return
		end

		p2.Size = UDim2.new(0, Util.GetTextSize(p3 or "", p2, Vector2.new(1000, 1000), 1, 0).X, p1.Size.Y.Scale, p1.Size.Y.Offset)
	end

	local function UpdateContainerSize() --[[ UpdateContainerSize | Line: 38 | Upvalues: Autocomplete (copy), Title (copy) ]]
		Autocomplete.Size = UDim2.new(0, math.max(Title.Field.TextBounds.X + Title.Field.Type.TextBounds.X, Autocomplete.Size.X.Offset), 0, (math.min(Autocomplete.UIListLayout.AbsoluteContentSize.Y, Autocomplete.Parent.AbsoluteSize.Y - Autocomplete.AbsolutePosition.Y - 10)))
	end

	local function UpdateInfoDisplay(p1) --[[ UpdateInfoDisplay | Line: 48 | Upvalues: SetText (copy), Title (copy), Description (copy), Autocomplete (copy), UpdateContainerSize (copy), ScrollBarThickness (copy) ]]
		SetText(Title, Title.Field, p1.name, true)

		local v1 = p1.type and ": " .. p1.type:sub(1, 1):upper() .. p1.type:sub(2)

		Title.Field.Type.Visible = if v1 == nil then false else true
		Title.Field.Type.Text = v1 or ""

		local Label = Description.Label
		local description = p1.description

		Description.Visible = description ~= nil
		Label.Text = description or ""
		Description.Label.TextColor3 = p1.invalid and Color3.fromRGB(255, 73, 73) or Color3.fromRGB(255, 255, 255)
		Description.Size = UDim2.new(1, 0, 0, 40)

		repeat
			if Description.Label.TextFits then
				break
			end

			Description.Size = Description.Size + UDim2.new(0, 0, 0, 2)
		until Description.Size.Y.Offset > 500

		task.wait()
		Autocomplete.UIListLayout:ApplyLayout()
		UpdateContainerSize()
		Autocomplete.ScrollBarThickness = ScrollBarThickness
	end

	function t.Show(p1, p2, p3) --[[ Show | Line: 88 | Upvalues: Autocomplete (copy), TextButton (copy), Entry (copy), Util (copy), UpdateInfoDisplay (copy) ]]
		local v2 = if p3 then p3 else {}

		for k, v in pairs(p1.Items) do
			if v.gui then
				v.gui:Destroy()
			end
		end

		p1.SelectedItem = 1
		p1.Items = p2
		p1.Prefix = v2.prefix or ""
		p1.LastItem = v2.isLast or false
		p1.Command = v2.command
		p1.Arg = v2.arg
		p1.NumArgs = v2.numArgs
		p1.IsPartial = v2.isPartial
		Autocomplete.ScrollBarThickness = 0

		local v3 = 200

		for k, v in pairs(p1.Items) do
			local v4 = v[1]
			local v5 = v[2]
			local v6 = TextButton:Clone()

			v6.Name = v4 .. v5
			v6.BackgroundTransparency = if k == p1.SelectedItem then 0.5 else 1

			local v8, v9 = string.find(v5:lower(), v4:lower(), 1, true)

			v6.Typed.Text = string.rep(" ", v8 - 1) .. v4
			v6.Suggest.Text = string.sub(v5, 0, v8 - 1) .. string.rep(" ", #v4) .. string.sub(v5, v9 + 1)
			v6.Parent = Autocomplete
			v6.LayoutOrder = k

			local v10 = math.max(v6.Typed.TextBounds.X, v6.Suggest.TextBounds.X) + 20

			if v3 < v10 then
				v3 = v10
			end

			v.gui = v6
		end

		Autocomplete.UIListLayout:ApplyLayout()

		local Text = Entry.TextBox.Text
		local v11 = Util.SplitString(Text)

		if Text:sub(#Text, #Text) == " " and not v2.at then
			v11[#v11 + 1] = "e"
		end

		table.remove(v11, #v11)
		Autocomplete.Position = UDim2.new(0, Entry.TextBox.AbsolutePosition.X - 10 + (v2.at and v2.at or #table.concat(v11, " ") + 1) * 7, 0, Entry.TextBox.AbsolutePosition.Y + 30)
		Autocomplete.Size = UDim2.new(0, v3, 0, Autocomplete.UIListLayout.AbsoluteContentSize.Y)
		Autocomplete.Visible = true
		UpdateInfoDisplay(if p1.Items[1] then p1.Items[1].options or v2 else v2)
	end
	function t.GetSelectedItem(p1) --[[ GetSelectedItem | Line: 161 | Upvalues: Autocomplete (copy), t (copy) ]]
		if Autocomplete.Visible == false then
			return nil
		end

		return t.Items[t.SelectedItem]
	end
	function t.Hide(p1) --[[ Hide | Line: 170 | Upvalues: Autocomplete (copy) ]]
		Autocomplete.Visible = false
	end
	function t.IsVisible(p1) --[[ IsVisible | Line: 175 | Upvalues: Autocomplete (copy) ]]
		return Autocomplete.Visible
	end
	function t.Select(p1, p2) --[[ Select | Line: 180 | Upvalues: Autocomplete (copy), Title (copy), Description (copy), TextButton (copy), UpdateInfoDisplay (copy) ]]
		if not Autocomplete.Visible then
			return
		end

		p1.SelectedItem = p1.SelectedItem + p2

		if p1.SelectedItem > #p1.Items then
			p1.SelectedItem = 1
		elseif p1.SelectedItem < 1 then
			p1.SelectedItem = #p1.Items
		end

		for k, v in pairs(p1.Items) do
			v.gui.BackgroundTransparency = if k == p1.SelectedItem then 0.5 else 1
		end

		Autocomplete.CanvasPosition = Vector2.new(0, (math.max(0, Title.Size.Y.Offset + Description.Size.Y.Offset + p1.SelectedItem * TextButton.Size.Y.Offset - Autocomplete.Size.Y.Offset)))

		if not (p1.Items[p1.SelectedItem] and p1.Items[p1.SelectedItem].options) then
			return
		end

		UpdateInfoDisplay(p1.Items[p1.SelectedItem].options or {})
	end
	Autocomplete.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateContainerSize)

	return t
end