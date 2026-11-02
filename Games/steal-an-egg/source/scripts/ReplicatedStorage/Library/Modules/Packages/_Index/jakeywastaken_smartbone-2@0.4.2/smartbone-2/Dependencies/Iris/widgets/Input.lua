-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

return function(p1, p2) --[[ Line: 3 ]]
	local t = {
		Init = function(p1) --[[ Line: 5 ]] end,
		Get = function(p12) --[[ Line: 6 | Upvalues: p1 (copy) ]]
			return p12.lastNumberChangedTick == p1._cycleTick
		end
	}

	local function getValueByIndex(p1, p2, p3) --[[ getValueByIndex | Line: 11 ]]
		if typeof(p1) == "number" then
			return p1
		end

		if typeof(p1) == "Vector2" then
			if p2 == 1 then
				return p1.X
			end

			if p2 == 2 then
				return p1.Y
			end
		elseif typeof(p1) == "Vector3" then
			if p2 == 1 then
				return p1.X
			end

			if p2 == 2 then
				return p1.Y
			end

			if p2 == 3 then
				return p1.Z
			end
		elseif typeof(p1) == "UDim" then
			if p2 == 1 then
				return p1.Scale
			end

			if p2 == 2 then
				return p1.Offset
			end
		elseif typeof(p1) == "UDim2" then
			if p2 == 1 then
				return p1.X.Scale
			end

			if p2 == 2 then
				return p1.X.Offset
			end

			if p2 == 3 then
				return p1.Y.Scale
			end

			if p2 == 4 then
				return p1.Y.Offset
			end
		elseif typeof(p1) == "Color3" then
			local v1 = p3.UseHSV and { p1:ToHSV() } or { p1.R, p1.G, p1.B }

			if p2 == 1 then
				return v1[1]
			end

			if p2 == 2 then
				return v1[2]
			end

			if p2 == 3 then
				return v1[3]
			end
		elseif typeof(p1) == "Rect" then
			if p2 == 1 then
				return p1.Min.X
			end

			if p2 == 2 then
				return p1.Min.Y
			end

			if p2 == 3 then
				return p1.Max.X
			end

			if p2 == 4 then
				return p1.Max.Y
			end
		elseif typeof(p1) == "table" then
			return p1[p2]
		end

		error((("Incorrect datatype or value: %* %* %*"):format(p1, typeof(p1), p2)))
	end

	local function updateValueByIndex(p1, p2, p3, p4) --[[ updateValueByIndex | Line: 70 ]]
		if typeof(p1) == "number" then
			return p3
		end

		if typeof(p1) == "Vector2" then
			if p2 == 1 then
				return Vector2.new(p3, p1.Y)
			end

			if p2 == 2 then
				return Vector2.new(p1.X, p3)
			end
		elseif typeof(p1) == "Vector3" then
			if p2 == 1 then
				return Vector3.new(p3, p1.Y, p1.Z)
			end

			if p2 == 2 then
				return Vector3.new(p1.X, p3, p1.Z)
			end

			if p2 == 3 then
				return Vector3.new(p1.X, p1.Y, p3)
			end
		elseif typeof(p1) == "UDim" then
			if p2 == 1 then
				return UDim.new(p3, p1.Offset)
			end

			if p2 == 2 then
				return UDim.new(p1.Scale, p3)
			end
		elseif typeof(p1) == "UDim2" then
			if p2 == 1 then
				return UDim2.new(UDim.new(p3, p1.X.Offset), p1.Y)
			end

			if p2 == 2 then
				return UDim2.new(UDim.new(p1.X.Scale, p3), p1.Y)
			end

			if p2 == 3 then
				return UDim2.new(p1.X, UDim.new(p3, p1.Y.Offset))
			end

			if p2 == 4 then
				return UDim2.new(p1.X, UDim.new(p1.Y.Scale, p3))
			end
		elseif typeof(p1) == "Rect" then
			if p2 == 1 then
				return Rect.new(Vector2.new(p3, p1.Min.Y), p1.Max)
			end

			if p2 == 2 then
				return Rect.new(Vector2.new(p1.Min.X, p3), p1.Max)
			end

			if p2 == 3 then
				return Rect.new(p1.Min, Vector2.new(p3, p1.Max.Y))
			end

			if p2 == 4 then
				return Rect.new(p1.Min, Vector2.new(p1.Max.X, p3))
			end
		elseif typeof(p1) == "Color3" then
			if p4.UseHSV then
				local v1, v2, v3 = p1:ToHSV()

				if p2 == 1 then
					return Color3.fromHSV(p3, v2, v3)
				end

				if p2 == 2 then
					return Color3.fromHSV(v1, p3, v3)
				end

				if p2 == 3 then
					return Color3.fromHSV(v1, v2, p3)
				end
			end

			if p2 == 1 then
				return Color3.new(p3, p1.G, p1.B)
			end

			if p2 == 2 then
				return Color3.new(p1.R, p3, p1.B)
			end

			if p2 == 3 then
				return Color3.new(p1.R, p1.G, p3)
			end
		end

		error((("Incorrect datatype or value %* %* %*"):format(p1, typeof(p1), p2)))
	end

	local t2 = {
		Num = { 1 },
		Vector2 = { 1, 1 },
		Vector3 = { 1, 1, 1 },
		UDim = { 0.01, 1 },
		UDim2 = { 0.01, 1, 0.01, 1 },
		Color3 = { 1, 1, 1 },
		Color4 = { 1, 1, 1, 1 },
		Rect = { 1, 1, 1, 1 }
	}
	local t3 = {
		Num = { 0 },
		Vector2 = { 0, 0 },
		Vector3 = { 0, 0, 0 },
		UDim = { 0, 0 },
		UDim2 = { 0, 0, 0, 0 },
		Rect = { 0, 0, 0, 0 }
	}
	local t4 = {
		Num = { 100 },
		Vector2 = { 100, 100 },
		Vector3 = { 100, 100, 100 },
		UDim = { 1, 960 },
		UDim2 = { 1, 960, 1, 960 },
		Rect = { 960, 960, 960, 960 }
	}
	local t5 = {
		Num = { "" },
		Vector2 = { "X: ", "Y: " },
		Vector3 = { "X: ", "Y: ", "Z: " },
		UDim = { "", "" },
		UDim2 = { "", "", "", "" },
		Color3_RGB = { "R: ", "G: ", "B: " },
		Color3_HSV = { "H: ", "S: ", "V: " },
		Color4_RGB = { "R: ", "G: ", "B: ", "T: " },
		Color4_HSV = { "H: ", "S: ", "V: ", "T: " },
		Rect = { "X: ", "Y: ", "X: ", "Y: " }
	}
	local t6 = {
		Num = { 0 },
		Vector2 = { 0, 0 },
		Vector3 = { 0, 0, 0 },
		UDim = { 3, 0 },
		UDim2 = { 3, 0, 3, 0 },
		Color3 = { 0, 0, 0 },
		Color4 = { 0, 0, 0, 0 },
		Rect = { 0, 0, 0, 0 }
	}

	local function generateButtons(p12, p22, p3, p4) --[[ generateButtons | Line: 199 | Upvalues: p1 (copy), p2 (copy), getValueByIndex (copy) ]]
		local v1 = p3 + (2 * p1._config.ItemInnerSpacing.X + p4 * 2)
		local SubButton = p2.abstractButton.Generate(p12)

		SubButton.Name = "SubButton"
		SubButton.ZIndex = p12.ZIndex + 5
		SubButton.LayoutOrder = p12.ZIndex + 5
		SubButton.TextXAlignment = Enum.TextXAlignment.Center
		SubButton.Text = "-"
		SubButton.Size = UDim2.fromOffset(p1._config.TextSize + 2 * p1._config.FramePadding.Y, p1._config.TextSize)
		SubButton.Parent = p22
		SubButton.MouseButton1Click:Connect(function() --[[ Line: 217 | Upvalues: p2 (ref), p12 (copy), getValueByIndex (ref), p1 (ref) ]]
			local v1 = p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			local v4 = p12.state.number.value - (p12.arguments.Increment and getValueByIndex(p12.arguments.Increment, 1, p12.arguments) or 1) * (if v1 then 100 else 1)

			if p12.arguments.Min ~= nil then
				v4 = math.max(v4, getValueByIndex(p12.arguments.Min, 1, p12.arguments))
			end

			if p12.arguments.Max ~= nil then
				v4 = math.min(v4, getValueByIndex(p12.arguments.Max, 1, p12.arguments))
			end

			p12.state.number:set(v4)
			p12.lastNumberChangedTick = p1._cycleTick + 1
		end)

		local AddButton = p2.abstractButton.Generate(p12)

		AddButton.Name = "AddButton"
		AddButton.ZIndex = p12.ZIndex + 6
		AddButton.LayoutOrder = p12.ZIndex + 6
		AddButton.TextXAlignment = Enum.TextXAlignment.Center
		AddButton.Text = "+"
		AddButton.Size = UDim2.fromOffset(p1._config.TextSize + 2 * p1._config.FramePadding.Y, p1._config.TextSize)
		AddButton.Parent = p22
		AddButton.MouseButton1Click:Connect(function() --[[ Line: 246 | Upvalues: p2 (ref), p12 (copy), getValueByIndex (ref), p1 (ref) ]]
			local v1 = p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			local v4 = p12.state.number.value + (p12.arguments.Increment and getValueByIndex(p12.arguments.Increment, 1, p12.arguments) or 1) * (if v1 then 100 else 1)

			if p12.arguments.Min ~= nil then
				v4 = math.max(v4, getValueByIndex(p12.arguments.Min, 1, p12.arguments))
			end

			if p12.arguments.Max ~= nil then
				v4 = math.min(v4, getValueByIndex(p12.arguments.Max, 1, p12.arguments))
			end

			p12.state.number:set(v4)
			p12.lastNumberChangedTick = p1._cycleTick + 1
		end)

		return v1
	end

	local function generateInputScalar(p12, p22, p3) --[[ generateInputScalar | Line: 268 | Upvalues: t (copy), p2 (copy), p1 (copy), generateButtons (copy), getValueByIndex (copy), updateValueByIndex (copy), t6 (copy), t5 (copy) ]]
		return {
			hasState = true,
			hasChildren = false,
			Args = {
				Text = 1,
				Increment = 2,
				Min = 3,
				Max = 4,
				Format = 5
			},
			Events = {
				numberChanged = t,
				hovered = p2.EVENTS.hover(function(p1) --[[ Line: 281 ]]
					return p1.Instance
				end)
			},
			Generate = function(p13) --[[ Generate | Line: 285 | Upvalues: p12 (copy), p2 (ref), p1 (ref), p22 (copy), generateButtons (ref), getValueByIndex (ref), updateValueByIndex (ref) ]]
				local Frame = Instance.new("Frame")

				Frame.Name = "Iris_Input" .. p12
				Frame.Size = UDim2.fromScale(1, 0)
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				Frame.ZIndex = p13.ZIndex
				Frame.LayoutOrder = p13.ZIndex
				Frame.AutomaticSize = Enum.AutomaticSize.Y
				p2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X))

				local v1 = 0
				local v2 = p1._config.TextSize + 2 * p1._config.FramePadding.Y

				if p22 == 1 then
					v1 = generateButtons(p13, Frame, v1, v2)
				end

				local v4 = UDim.new(p1._config.ContentWidth.Scale / p22, (p1._config.ContentWidth.Offset - p1._config.ItemInnerSpacing.X * (p22 - 1) - v1) / p22)
				local v5 = UDim.new(v4.Scale * (p22 - 1), v4.Offset * (p22 - 1) + p1._config.ItemInnerSpacing.X * (p22 - 1) + v1)
				local v6 = p1._config.ContentWidth - v5

				for i = 1, p22 do
					local TextBox = Instance.new("TextBox")

					TextBox.Name = "InputField" .. tostring(i)
					TextBox.ZIndex = p13.ZIndex + i
					TextBox.LayoutOrder = p13.ZIndex + i

					if i == p22 then
						TextBox.Size = UDim2.new(v6, UDim.new())
					else
						TextBox.Size = UDim2.new(v4, UDim.new())
					end

					TextBox.AutomaticSize = Enum.AutomaticSize.Y
					TextBox.BackgroundColor3 = p1._config.FrameBgColor
					TextBox.BackgroundTransparency = p1._config.FrameBgTransparency
					TextBox.ClearTextOnFocus = false
					TextBox.TextTruncate = Enum.TextTruncate.AtEnd
					TextBox.ClipsDescendants = true
					p2.applyFrameStyle(TextBox)
					p2.applyTextStyle(TextBox)
					p2.UISizeConstraint(TextBox, Vector2.new(1, 0))
					TextBox.Parent = Frame
					TextBox.FocusLost:Connect(function() --[[ Line: 351 | Upvalues: TextBox (copy), p13 (copy), getValueByIndex (ref), i (copy), updateValueByIndex (ref), p1 (ref) ]]
						local v1 = tonumber(TextBox.Text:match("-?%d*%.?%d*"))

						if v1 ~= nil then
							if p13.arguments.Min ~= nil then
								v1 = math.max(v1, getValueByIndex(p13.arguments.Min, i, p13.arguments))
							end

							if p13.arguments.Max ~= nil then
								v1 = math.min(v1, getValueByIndex(p13.arguments.Max, i, p13.arguments))
							end

							if p13.arguments.Increment then
								local v8 = v1 / getValueByIndex(p13.arguments.Increment, i, p13.arguments)

								v1 = math.round(v8) * getValueByIndex(p13.arguments.Increment, i, p13.arguments)
							end

							p13.state.number:set(updateValueByIndex(p13.state.number.value, i, v1, p13.arguments))
							p13.lastNumberChangedTick = p1._cycleTick + 1
						end

						local v9 = p13.arguments.Format[i] or p13.arguments.Format[1]

						if p13.arguments.Prefix then
							v9 = p13.arguments.Prefix[i] .. v9
						end

						TextBox.Text = string.format(v9, getValueByIndex(p13.state.number.value, i, p13.arguments))
						p13.state.editingText:set(0)
					end)
					TextBox.Focused:Connect(function() --[[ Line: 404 | Upvalues: TextBox (copy), p13 (copy), i (copy) ]]
						TextBox.CursorPosition = #TextBox.Text + 1
						TextBox.SelectionStart = 1
						p13.state.editingText:set(i)
					end)
				end

				local TextLabel = Instance.new("TextLabel")

				TextLabel.Name = "TextLabel"
				TextLabel.Size = UDim2.fromOffset(0, v2)
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				TextLabel.ZIndex = p13.ZIndex + 7
				TextLabel.LayoutOrder = p13.ZIndex + 7
				TextLabel.AutomaticSize = Enum.AutomaticSize.X
				p2.applyTextStyle(TextLabel)
				TextLabel.Parent = Frame

				return Frame
			end,
			Update = function(p1) --[[ Update | Line: 428 | Upvalues: p12 (copy), p22 (copy), t6 (ref), getValueByIndex (ref), t5 (ref) ]]
				local v1 = p1.Instance

				v1.TextLabel.Text = p1.arguments.Text or ("Input %*"):format(p12)

				if p22 == 1 then
					v1.SubButton.Visible = not p1.arguments.NoButtons
					v1.AddButton.Visible = not p1.arguments.NoButtons
				end

				if p1.arguments.Format and typeof(p1.arguments.Format) ~= "table" then
					p1.arguments.Format = { p1.arguments.Format }

					return
				end

				local t = {}

				for i = 1, p22 do
					local v3 = t6[p12][i]

					if p1.arguments.Increment then
						local v4 = getValueByIndex(p1.arguments.Increment, i, p1.arguments)

						v3 = math.max(v3, math.ceil(-math.log10(if v4 == 0 then 1 else v4)), v3)
					end

					if p1.arguments.Max then
						local v9 = getValueByIndex(p1.arguments.Max, i, p1.arguments)

						v3 = math.max(v3, math.ceil(-math.log10(if v9 == 0 then 1 else v9)), v3)
					end

					if p1.arguments.Min then
						local v14 = getValueByIndex(p1.arguments.Min, i, p1.arguments)

						v3 = math.max(v3, math.ceil(-math.log10(if v14 == 0 then 1 else v14)), v3)
					end

					if v3 > 0 then
						t[i] = ("%%.%*f"):format(v3)

						continue
					end

					t[i] = "%d"
				end

				p1.arguments.Format = t
				p1.arguments.Prefix = t5[p12]
			end,
			Discard = function(p1) --[[ Discard | Line: 476 | Upvalues: p2 (ref) ]]
				p1.Instance:Destroy()
				p2.discardState(p1)
			end,
			GenerateState = function(p12) --[[ GenerateState | Line: 480 | Upvalues: p1 (ref), p3 (copy) ]]
				if p12.state.number == nil then
					p12.state.number = p1._widgetState(p12, "number", p3)
				end

				if p12.state.editingText ~= nil then
					return
				end

				p12.state.editingText = p1._widgetState(p12, "editingText", 0)
			end,
			UpdateState = function(p1) --[[ UpdateState | Line: 488 | Upvalues: p22 (copy), getValueByIndex (ref) ]]
				local v1 = p1.Instance

				for i = 1, p22 do
					local v2 = v1:FindFirstChild("InputField" .. tostring(i))
					local v3 = p1.arguments.Format[i] or p1.arguments.Format[1]

					if p1.arguments.Prefix then
						v3 = p1.arguments.Prefix[i] .. v3
					end

					v2.Text = string.format(v3, getValueByIndex(p1.state.number.value, i, p1.arguments))
				end
			end
		}
	end

	local v1 = 0
	local v2 = false
	local v3 = nil
	local v4 = 0
	local v5 = ""

	local function updateActiveDrag() --[[ updateActiveDrag | Line: 519 | Upvalues: p2 (copy), v1 (ref), v2 (ref), v3 (ref), v5 (ref), v4 (ref), getValueByIndex (copy), t2 (copy), updateValueByIndex (copy), p1 (copy) ]]
		local X = p2.getMouseLocation().X
		local v12 = X - v1

		v1 = X

		if v2 == false then
			return
		end

		if v3 == nil then
			return
		end

		local number = v3.state.number

		if v5 == "Color3" or v5 == "Color4" then
			number = v3.state.color

			if v4 == 4 then
				number = v3.state.transparency
			end
		end

		local v22 = v3.arguments.Increment and getValueByIndex(v3.arguments.Increment, v4, v3.arguments) or t2[v5][v4]
		local v42 = v22 * (if p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then 10 else 1)
		local v6 = v42 * (if p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then 0.1 else 1)
		local v8 = getValueByIndex(number.value, v4, v3.arguments) + v12 * (v6 * (if v5 == "Color3" or v5 == "Color4" then 5 else 1))

		if v3.arguments.Min ~= nil then
			v8 = math.max(v8, getValueByIndex(v3.arguments.Min, v4, v3.arguments))
		end

		if v3.arguments.Max ~= nil then
			v8 = math.min(v8, getValueByIndex(v3.arguments.Max, v4, v3.arguments))
		end

		number:set(updateValueByIndex(number.value, v4, v8, v3.arguments))
		v3.lastNumberChangedTick = p1._cycleTick + 1
	end

	local function DragMouseDown(p12, p22, p3, p4, p5) --[[ DragMouseDown | Line: 566 | Upvalues: p2 (copy), p1 (copy), v2 (ref), v3 (ref), v4 (ref), v5 (ref), updateActiveDrag (copy) ]]
		local v1 = p2.getTime()
		local v22 = if v1 - p12.lastClickedTime < p1._config.MouseDoubleClickTime then true else false
		local v32 = p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)

		if not (v22 and (Vector2.new(p4, p5) - p12.lastClickedPosition).Magnitude < p1._config.MouseDoubleClickMaxDist or v32) then
			p12.lastClickedTime = v1
			p12.lastClickedPosition = Vector2.new(p4, p5)
			v2 = true
			v3 = p12
			v4 = p3
			v5 = p22
			updateActiveDrag()

			return
		end

		p12.state.editingText:set(p3)
	end

	p2.UserInputService.InputChanged:Connect(updateActiveDrag)
	p2.UserInputService.InputEnded:Connect(function(p1) --[[ Line: 599 | Upvalues: v2 (ref), v3 (ref), v4 (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseButton1 or not v2 then
			return
		end

		v2 = false
		v3 = nil
		v4 = 0
	end)

	local function generateDragScalar(p12, p22, p3) --[[ generateDragScalar | Line: 607 | Upvalues: t (copy), p2 (copy), p1 (copy), getValueByIndex (copy), updateValueByIndex (copy), DragMouseDown (copy), t6 (copy), t5 (copy) ]]
		return {
			hasState = true,
			hasChildren = false,
			Args = {
				Text = 1,
				Increment = 2,
				Min = 3,
				Max = 4,
				Format = 5
			},
			Events = {
				numberChanged = t,
				hovered = p2.EVENTS.hover(function(p1) --[[ Line: 620 ]]
					return p1.Instance
				end)
			},
			Generate = function(p13) --[[ Generate | Line: 624 | Upvalues: p12 (copy), p2 (ref), p1 (ref), p22 (copy), getValueByIndex (ref), updateValueByIndex (ref), DragMouseDown (ref) ]]
				p13.lastClickedTime = -1
				p13.lastClickedPosition = Vector2.zero

				local Frame = Instance.new("Frame")

				Frame.Name = "Iris_Drag" .. p12
				Frame.Size = UDim2.fromScale(1, 0)
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				Frame.ZIndex = p13.ZIndex
				Frame.LayoutOrder = p13.ZIndex
				Frame.AutomaticSize = Enum.AutomaticSize.Y
				p2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X))

				local sum = 0
				local v1 = p1._config.TextSize + 2 * p1._config.FramePadding.Y

				if p12 == "Color3" or p12 == "Color4" then
					sum = sum + (p1._config.ItemInnerSpacing.X + v1)

					local ColorBox = Instance.new("ImageLabel")

					ColorBox.Name = "ColorBox"
					ColorBox.BorderSizePixel = 0
					ColorBox.Size = UDim2.fromOffset(v1, v1)
					ColorBox.ZIndex = p13.ZIndex + 5
					ColorBox.LayoutOrder = p13.ZIndex + 5
					ColorBox.Image = p2.ICONS.ALPHA_BACKGROUND_TEXTURE
					ColorBox.ImageTransparency = 1
					p2.applyFrameStyle(ColorBox, true, true)
					ColorBox.Parent = Frame
				end

				local v2 = UDim.new(p1._config.ContentWidth.Scale / p22, (p1._config.ContentWidth.Offset - p1._config.ItemInnerSpacing.X * (p22 - 1) - sum) / p22)
				local v3 = UDim.new(v2.Scale * (p22 - 1), v2.Offset * (p22 - 1) + p1._config.ItemInnerSpacing.X * (p22 - 1) + sum)
				local v4 = p1._config.ContentWidth - v3

				for i = 1, p22 do
					local TextButton = Instance.new("TextButton")

					TextButton.Name = "DragField" .. tostring(i)
					TextButton.ZIndex = p13.ZIndex + i
					TextButton.LayoutOrder = p13.ZIndex + i

					if i == p22 then
						TextButton.Size = UDim2.new(v4, UDim.new())
					else
						TextButton.Size = UDim2.new(v2, UDim.new())
					end

					TextButton.AutomaticSize = Enum.AutomaticSize.Y
					TextButton.BackgroundColor3 = p1._config.FrameBgColor
					TextButton.BackgroundTransparency = p1._config.FrameBgTransparency
					TextButton.AutoButtonColor = false
					TextButton.Text = ""
					TextButton.ClipsDescendants = true
					p2.applyFrameStyle(TextButton)
					p2.applyTextStyle(TextButton)
					p2.UISizeConstraint(TextButton, Vector2.new(1, 0))
					TextButton.TextXAlignment = Enum.TextXAlignment.Center
					TextButton.Parent = Frame
					p2.applyInteractionHighlights(TextButton, TextButton, {
						ButtonColor = p1._config.FrameBgColor,
						ButtonTransparency = p1._config.FrameBgTransparency,
						ButtonHoveredColor = p1._config.FrameBgHoveredColor,
						ButtonHoveredTransparency = p1._config.FrameBgHoveredTransparency,
						ButtonActiveColor = p1._config.FrameBgActiveColor,
						ButtonActiveTransparency = p1._config.FrameBgActiveTransparency
					})

					local InputField = Instance.new("TextBox")

					InputField.Name = "InputField"
					InputField.ZIndex = p13.ZIndex + 5
					InputField.LayoutOrder = p13.ZIndex + 2
					InputField.Size = UDim2.new(1, 0, 1, 0)
					InputField.BackgroundTransparency = 1
					InputField.ClearTextOnFocus = false
					InputField.TextTruncate = Enum.TextTruncate.AtEnd
					InputField.ClipsDescendants = true
					InputField.Visible = false
					p2.applyFrameStyle(InputField, true)
					p2.applyTextStyle(InputField)
					InputField.Parent = TextButton
					InputField.FocusLost:Connect(function() --[[ Line: 732 | Upvalues: InputField (copy), p13 (copy), p12 (ref), i (copy), getValueByIndex (ref), updateValueByIndex (ref), p1 (ref) ]]
						local v1 = tonumber(InputField.Text:match("-?%d*%.?%d*"))
						local number = p13.state.number

						if p12 == "Color4" and i == 4 then
							number = p13.state.transparency
						elseif p12 == "Color3" or p12 == "Color4" then
							number = p13.state.color
						end

						if v1 ~= nil then
							if p12 == "Color3" or p12 == "Color4" and not p13.arguments.UseFloats then
								v1 = v1 / 255
							end

							if p13.arguments.Min ~= nil then
								v1 = math.max(v1, getValueByIndex(p13.arguments.Min, i, p13.arguments))
							end

							if p13.arguments.Max ~= nil then
								v1 = math.min(v1, getValueByIndex(p13.arguments.Max, i, p13.arguments))
							end

							if p13.arguments.Increment then
								local v8 = v1 / getValueByIndex(p13.arguments.Increment, i, p13.arguments)

								v1 = math.round(v8) * getValueByIndex(p13.arguments.Increment, i, p13.arguments)
							end

							number:set(updateValueByIndex(number.value, i, v1, p13.arguments))
							p13.lastNumberChangedTick = p1._cycleTick + 1
						end

						local v9 = getValueByIndex(number.value, i, p13.arguments)

						if p12 == "Color3" or p12 == "Color4" and not p13.arguments.UseFloats then
							v9 = math.round(v9 * 255)
						end

						local v11 = p13.arguments.Format[i] or p13.arguments.Format[1]

						if p13.arguments.Prefix then
							v11 = p13.arguments.Prefix[i] .. v11
						end

						InputField.Text = string.format(v11, v9)
						p13.state.editingText:set(0)
						InputField:ReleaseFocus(true)
					end)
					InputField.Focused:Connect(function() --[[ Line: 794 | Upvalues: InputField (copy), p13 (copy), i (copy) ]]
						InputField.CursorPosition = #InputField.Text + 1
						InputField.SelectionStart = 1
						p13.state.editingText:set(i)
					end)
					TextButton.MouseButton1Down:Connect(function(p1, p2) --[[ Line: 802 | Upvalues: DragMouseDown (ref), p13 (copy), p12 (ref), i (copy) ]]
						DragMouseDown(p13, p12, i, p1, p2)
					end)
				end

				local TextLabel = Instance.new("TextLabel")

				TextLabel.Name = "TextLabel"
				TextLabel.Size = UDim2.fromOffset(0, v1)
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				TextLabel.ZIndex = p13.ZIndex + 5
				TextLabel.LayoutOrder = p13.ZIndex + 5
				TextLabel.AutomaticSize = Enum.AutomaticSize.X
				p2.applyTextStyle(TextLabel)
				TextLabel.Parent = Frame

				return Frame
			end,
			Update = function(p1) --[[ Update | Line: 822 | Upvalues: p12 (copy), p22 (copy), t6 (ref), getValueByIndex (ref), t5 (ref) ]]
				p1.Instance.TextLabel.Text = p1.arguments.Text or ("Drag %*"):format(p12)

				if p1.arguments.Format and typeof(p1.arguments.Format) ~= "table" then
					p1.arguments.Format = { p1.arguments.Format }

					return
				end

				if p1.arguments.Format then
					return
				end

				local t = {}

				for i = 1, p22 do
					local v2 = t6[p12][i]

					if p1.arguments.Increment then
						local v3 = getValueByIndex(p1.arguments.Increment, i, p1.arguments)

						v2 = math.max(v2, math.ceil(-math.log10(if v3 == 0 then 1 else v3)), v2)
					end

					if p1.arguments.Max then
						local v8 = getValueByIndex(p1.arguments.Max, i, p1.arguments)

						v2 = math.max(v2, math.ceil(-math.log10(if v8 == 0 then 1 else v8)), v2)
					end

					if p1.arguments.Min then
						local v13 = getValueByIndex(p1.arguments.Min, i, p1.arguments)

						v2 = math.max(v2, math.ceil(-math.log10(if v13 == 0 then 1 else v13)), v2)
					end

					if v2 > 0 then
						t[i] = ("%%.%*f"):format(v2)

						continue
					end

					t[i] = "%d"
				end

				p1.arguments.Format = t
				p1.arguments.Prefix = t5[p12]
			end,
			Discard = function(p1) --[[ Discard | Line: 865 | Upvalues: p2 (ref) ]]
				p1.Instance:Destroy()
				p2.discardState(p1)
			end,
			GenerateState = function(p12) --[[ GenerateState | Line: 869 | Upvalues: p1 (ref), p3 (copy) ]]
				if p12.state.number == nil then
					p12.state.number = p1._widgetState(p12, "number", p3)
				end

				if p12.state.editingText ~= nil then
					return
				end

				p12.state.editingText = p1._widgetState(p12, "editingText", false)
			end,
			UpdateState = function(p13) --[[ UpdateState | Line: 877 | Upvalues: p22 (copy), p12 (copy), getValueByIndex (ref), p1 (ref) ]]
				local v1 = p13.Instance

				for i = 1, p22 do
					local number = p13.state.number

					if p12 == "Color3" or p12 == "Color4" then
						number = p13.state.color

						if i == 4 then
							number = p13.state.transparency
						end
					end

					local v2 = v1:FindFirstChild("DragField" .. tostring(i))
					local InputField = v2.InputField
					local v3 = getValueByIndex(number.value, i, p13.arguments)

					if (p12 == "Color3" or p12 == "Color4") and not p13.arguments.UseFloats then
						v3 = math.round(v3 * 255)
					end

					local v5 = p13.arguments.Format[i] or p13.arguments.Format[1]

					if p13.arguments.Prefix then
						v5 = p13.arguments.Prefix[i] .. v5
					end

					v2.Text = string.format(v5, v3)
					InputField.Text = tostring(v3)

					if p13.state.editingText.value == i then
						InputField.Visible = true
						InputField:CaptureFocus()
						v2.TextTransparency = 1

						continue
					end

					InputField.Visible = false
					v2.TextTransparency = p1._config.TextTransparency
				end

				if p12 ~= "Color3" and p12 ~= "Color4" then
					return
				end

				local ColorBox = v1.ColorBox

				ColorBox.BackgroundColor3 = p13.state.color.value

				if p12 ~= "Color4" then
					return
				end

				ColorBox.ImageTransparency = 1 - p13.state.transparency.value
			end
		}
	end

	local function generateColorDragScalar(p12, ...) --[[ generateColorDragScalar | Line: 925 | Upvalues: generateDragScalar (ref), p2 (copy), t5 (copy), p1 (copy) ]]
		local t = { ... }

		return p2.extend(generateDragScalar(p12, if p12 == "Color4" then 4 else 3, t[1]), {
			Args = {
				Text = 1,
				UseFloats = 2,
				UseHSV = 3,
				Format = 4
			},
			Update = function(p13) --[[ Update | Line: 937 | Upvalues: p12 (copy), t5 (ref), p1 (ref) ]]
				p13.Instance.TextLabel.Text = p13.arguments.Text or ("Drag %*"):format(p12)

				local v2, v3, v4, v5

				if p13.arguments.Format then
					if typeof(p13.arguments.Format) == "table" then
						if p13.arguments.UseFloats then
							p13.arguments.Format = { "%.3f" }
						else
							p13.arguments.Format = { "%d" }
						end

						v2 = p13.arguments
						v3 = t5
						v4 = p12
						v5 = if p13.arguments.UseHSV then "_HSV" else "_RGB"
						v2.Prefix = t5[p12 .. v5]
					else
						p13.arguments.Format = { p13.arguments.Format }
					end
				else
					if p13.arguments.UseFloats then
						p13.arguments.Format = { "%.3f" }
					else
						p13.arguments.Format = { "%d" }
					end

					v2 = p13.arguments
					v3 = t5
					v4 = p12
					v5 = if p13.arguments.UseHSV then "_HSV" else "_RGB"
					v2.Prefix = t5[p12 .. v5]
				end

				p13.arguments.Min = { 0, 0, 0, 0 }
				p13.arguments.Max = { 1, 1, 1, 1 }
				p13.arguments.Increment = { 0.001, 0.001, 0.001, 0.001 }

				if not p13.state then
					return
				end

				p1._widgets[p13.type].UpdateState(p13)
			end,
			GenerateState = function(p13) --[[ GenerateState | Line: 965 | Upvalues: p1 (ref), t (copy), p12 (copy) ]]
				if p13.state.color == nil then
					p13.state.color = p1._widgetState(p13, "color", t[1])
				end

				if p12 == "Color4" and p13.state.transparency == nil then
					p13.state.transparency = p1._widgetState(p13, "transparency", t[2])
				end

				if p13.state.editingText ~= nil then
					return
				end

				p13.state.editingText = p1._widgetState(p13, "editingText", false)
			end
		})
	end

	local v6 = false
	local v7 = nil
	local v8 = 0
	local v9 = ""

	local function updateActiveSlider() --[[ updateActiveSlider | Line: 994 | Upvalues: v6 (ref), v7 (ref), v8 (ref), getValueByIndex (copy), t2 (copy), v9 (ref), t3 (copy), t4 (copy), p1 (copy), p2 (copy), updateValueByIndex (copy) ]]
		if v6 == false then
			return
		end

		if v7 == nil then
			return
		end

		local v2 = v7.Instance:FindFirstChild("SliderField" .. tostring(v8))
		local v3 = v7.arguments.Increment and getValueByIndex(v7.arguments.Increment, v8, v7.arguments) or t2[v9][v8]
		local v4 = v7.arguments.Min and getValueByIndex(v7.arguments.Min, v8, v7.arguments) or t3[v9][v8]
		local v5 = v7.arguments.Max and getValueByIndex(v7.arguments.Max, v8, v7.arguments) or t4[v9][v8]
		local X = p1._config.FramePadding.X
		local v72 = math.floor(((if v3 < 1 then 0 else 1) + v5 - v4) / v3)

		v7.state.number:set(updateValueByIndex(v7.state.number.value, v8, math.clamp(math.floor((p2.getMouseLocation().X - (v2.AbsolutePosition.X + X)) / (v2.AbsoluteSize.X - X * 2) * v72) * v3 + v4, v4, v5), v7.arguments))
		v7.lastNumberChangedTick = p1._cycleTick + 1
	end

	local function SliderMouseDown(p1, p22, p3) --[[ SliderMouseDown | Line: 1030 | Upvalues: p2 (copy), v6 (ref), v7 (ref), v8 (ref), v9 (ref), updateActiveSlider (copy) ]]
		if p2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or p2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
			p1.state.editingText:set(p3)
		else
			v6 = true
			v7 = p1
			v8 = p3
			v9 = p22
			updateActiveSlider()
		end
	end

	p2.UserInputService.InputChanged:Connect(updateActiveSlider)
	p2.UserInputService.InputEnded:Connect(function(p1) --[[ Line: 1046 | Upvalues: v6 (ref), v7 (ref), v8 (ref), v9 (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseButton1 or not v6 then
			return
		end

		v6 = false
		v7 = nil
		v8 = 0
		v9 = ""
	end)

	local function generateSliderScalar(p12, p22, p3, ...) --[[ generateSliderScalar | Line: 1055 | Upvalues: t (copy), p2 (copy), p1 (copy), getValueByIndex (copy), updateValueByIndex (copy), SliderMouseDown (copy), t6 (copy), t5 (copy), t2 (copy), t3 (copy), t4 (copy) ]]
		return {
			hasState = true,
			hasChildren = false,
			Args = {
				Text = 1,
				Increment = 2,
				Min = 3,
				Max = 4,
				Format = 5
			},
			Events = {
				numberChanged = t,
				hovered = p2.EVENTS.hover(function(p1) --[[ Line: 1068 ]]
					return p1.Instance
				end)
			},
			Generate = function(p13) --[[ Generate | Line: 1072 | Upvalues: p12 (copy), p2 (ref), p1 (ref), p22 (copy), getValueByIndex (ref), updateValueByIndex (ref), SliderMouseDown (ref) ]]
				local Frame = Instance.new("Frame")

				Frame.Name = "Iris_Slider" .. p12
				Frame.Size = UDim2.fromScale(1, 0)
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				Frame.ZIndex = p13.ZIndex
				Frame.LayoutOrder = p13.ZIndex
				Frame.AutomaticSize = Enum.AutomaticSize.Y
				p2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X))

				local v1 = p1._config.TextSize + 2 * p1._config.FramePadding.Y
				local v2 = UDim.new(p1._config.ContentWidth.Scale / p22, (p1._config.ContentWidth.Offset - p1._config.ItemInnerSpacing.X * (p22 - 1)) / p22)
				local v3 = UDim.new(v2.Scale * (p22 - 1), v2.Offset * (p22 - 1) + p1._config.ItemInnerSpacing.X * (p22 - 1))
				local v4 = p1._config.ContentWidth - v3

				for i = 1, p22 do
					local TextButton = Instance.new("TextButton")

					TextButton.Name = "SliderField" .. tostring(i)
					TextButton.ZIndex = p13.ZIndex + i
					TextButton.LayoutOrder = p13.ZIndex + i

					if i == p22 then
						TextButton.Size = UDim2.new(v4, UDim.new())
					else
						TextButton.Size = UDim2.new(v2, UDim.new())
					end

					TextButton.AutomaticSize = Enum.AutomaticSize.Y
					TextButton.BackgroundColor3 = p1._config.FrameBgColor
					TextButton.BackgroundTransparency = p1._config.FrameBgTransparency
					TextButton.AutoButtonColor = false
					TextButton.Text = ""
					TextButton.ClipsDescendants = true
					p2.applyFrameStyle(TextButton)
					p2.applyTextStyle(TextButton)
					p2.UISizeConstraint(TextButton, Vector2.new(1, 0))
					TextButton.Parent = Frame

					local OverlayText = Instance.new("TextLabel")

					OverlayText.Name = "OverlayText"
					OverlayText.Size = UDim2.fromScale(1, 1)
					OverlayText.BackgroundTransparency = 1
					OverlayText.BorderSizePixel = 0
					OverlayText.ZIndex = p13.ZIndex + 10
					OverlayText.ClipsDescendants = true
					p2.applyTextStyle(OverlayText)
					OverlayText.TextXAlignment = Enum.TextXAlignment.Center
					OverlayText.Parent = TextButton
					p2.applyInteractionHighlights(TextButton, TextButton, {
						ButtonColor = p1._config.FrameBgColor,
						ButtonTransparency = p1._config.FrameBgTransparency,
						ButtonHoveredColor = p1._config.FrameBgHoveredColor,
						ButtonHoveredTransparency = p1._config.FrameBgHoveredTransparency,
						ButtonActiveColor = p1._config.FrameBgActiveColor,
						ButtonActiveTransparency = p1._config.FrameBgActiveTransparency
					})

					local InputField = Instance.new("TextBox")

					InputField.Name = "InputField"
					InputField.ZIndex = p13.ZIndex + 5
					InputField.LayoutOrder = p13.ZIndex + 2
					InputField.Size = UDim2.new(1, 0, 1, 0)
					InputField.BackgroundTransparency = 1
					InputField.ClearTextOnFocus = false
					InputField.TextTruncate = Enum.TextTruncate.AtEnd
					InputField.ClipsDescendants = true
					InputField.Visible = false
					p2.applyFrameStyle(InputField, true)
					p2.applyTextStyle(InputField)
					InputField.Parent = TextButton
					InputField.FocusLost:Connect(function() --[[ Line: 1166 | Upvalues: InputField (copy), p13 (copy), getValueByIndex (ref), i (copy), updateValueByIndex (ref), p1 (ref) ]]
						local v1 = tonumber(InputField.Text:match("-?%d*%.?%d*"))

						if v1 ~= nil then
							if p13.arguments.Min ~= nil then
								v1 = math.max(v1, getValueByIndex(p13.arguments.Min, i, p13.arguments))
							end

							if p13.arguments.Max ~= nil then
								v1 = math.min(v1, getValueByIndex(p13.arguments.Max, i, p13.arguments))
							end

							if p13.arguments.Increment then
								local v8 = v1 / getValueByIndex(p13.arguments.Increment, i, p13.arguments)

								v1 = math.round(v8) * getValueByIndex(p13.arguments.Increment, i, p13.arguments)
							end

							p13.state.number:set(updateValueByIndex(p13.state.number.value, i, v1, p13.arguments))
							p13.lastNumberChangedTick = p1._cycleTick + 1
						end

						local v9 = p13.arguments.Format[i] or p13.arguments.Format[1]

						if p13.arguments.Prefix then
							v9 = p13.arguments.Prefix[i] .. v9
						end

						InputField.Text = string.format(v9, getValueByIndex(p13.state.number.value, i, p13.arguments))
						p13.state.editingText:set(0)
						InputField:ReleaseFocus(true)
					end)
					InputField.Focused:Connect(function() --[[ Line: 1222 | Upvalues: InputField (copy), p13 (copy), i (copy) ]]
						InputField.CursorPosition = #InputField.Text + 1
						InputField.SelectionStart = 1
						p13.state.editingText:set(i)
					end)
					TextButton.MouseButton1Down:Connect(function() --[[ Line: 1230 | Upvalues: SliderMouseDown (ref), p13 (copy), p12 (ref), i (copy) ]]
						SliderMouseDown(p13, p12, i)
					end)

					local GrabBar = Instance.new("Frame")

					GrabBar.Name = "GrabBar"
					GrabBar.ZIndex = p13.ZIndex + 5
					GrabBar.LayoutOrder = p13.ZIndex + 5
					GrabBar.AnchorPoint = Vector2.new(0, 0.5)
					GrabBar.Position = UDim2.new(0, 0, 0.5, 0)
					GrabBar.BorderSizePixel = 0
					GrabBar.BackgroundColor3 = p1._config.SliderGrabColor
					GrabBar.Transparency = p1._config.SliderGrabTransparency

					if p1._config.GrabRounding > 0 then
						p2.UICorner(GrabBar, p1._config.GrabRounding)
					end

					GrabBar.Parent = TextButton
				end

				local TextLabel = Instance.new("TextLabel")

				TextLabel.Name = "TextLabel"
				TextLabel.Size = UDim2.fromOffset(0, v1)
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderSizePixel = 0
				TextLabel.ZIndex = p13.ZIndex + 5
				TextLabel.LayoutOrder = p13.ZIndex + 5
				TextLabel.AutomaticSize = Enum.AutomaticSize.X
				p2.applyTextStyle(TextLabel)
				TextLabel.Parent = Frame

				return Frame
			end,
			Update = function(p13) --[[ Update | Line: 1265 | Upvalues: p12 (copy), p22 (copy), t6 (ref), getValueByIndex (ref), t5 (ref), t2 (ref), t3 (ref), t4 (ref), p1 (ref) ]]
				local v1 = p13.Instance

				v1.TextLabel.Text = p13.arguments.Text or ("Slider %*"):format(p12)

				local v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19

				if p13.arguments.Format then
					if typeof(p13.arguments.Format) == "table" then
						v3 = {}

						for i = 1, p22 do
							v4 = t6[p12][i]

							if p13.arguments.Increment then
								v5 = getValueByIndex(p13.arguments.Increment, i, p13.arguments)
								v6 = if v5 == 0 then 1 else v5
								v7 = -math.log10(v6)
								v8 = math.ceil(v7)
								v9 = math.max(v4, v8, v4)
								v4 = v9
							end

							if p13.arguments.Max then
								v10 = getValueByIndex(p13.arguments.Max, i, p13.arguments)
								v11 = if v10 == 0 then 1 else v10
								v12 = -math.log10(v11)
								v13 = math.ceil(v12)
								v14 = math.max(v4, v13, v4)
								v4 = v14
							end

							if p13.arguments.Min then
								v15 = getValueByIndex(p13.arguments.Min, i, p13.arguments)
								v16 = if v15 == 0 then 1 else v15
								v17 = -math.log10(v16)
								v18 = math.ceil(v17)
								v19 = math.max(v4, v18, v4)
								v4 = v19
							end

							if v4 > 0 then
								v3[i] = ("%%.%*f"):format(v4)

								continue
							end

							v3[i] = "%d"
						end

						p13.arguments.Format = v3
						p13.arguments.Prefix = t5[p12]
					else
						p13.arguments.Format = { p13.arguments.Format }
					end
				else
					v3 = {}

					for i = 1, p22 do
						v4 = t6[p12][i]

						if p13.arguments.Increment then
							v5 = getValueByIndex(p13.arguments.Increment, i, p13.arguments)
							v6 = if v5 == 0 then 1 else v5
							v7 = -math.log10(v6)
							v8 = math.ceil(v7)
							v9 = math.max(v4, v8, v4)
							v4 = v9
						end

						if p13.arguments.Max then
							v10 = getValueByIndex(p13.arguments.Max, i, p13.arguments)
							v11 = if v10 == 0 then 1 else v10
							v12 = -math.log10(v11)
							v13 = math.ceil(v12)
							v14 = math.max(v4, v13, v4)
							v4 = v14
						end

						if p13.arguments.Min then
							v15 = getValueByIndex(p13.arguments.Min, i, p13.arguments)
							v16 = if v15 == 0 then 1 else v15
							v17 = -math.log10(v16)
							v18 = math.ceil(v17)
							v19 = math.max(v4, v18, v4)
							v4 = v19
						end

						if v4 > 0 then
							v3[i] = ("%%.%*f"):format(v4)

							continue
						end

						v3[i] = "%d"
					end

					p13.arguments.Format = v3
					p13.arguments.Prefix = t5[p12]
				end

				for j = 1, p22 do
					local v20 = v1:FindFirstChild("SliderField" .. tostring(j))
					local v21 = p13.arguments.Increment and getValueByIndex(p13.arguments.Increment, j, p13.arguments) or t2[p12][j]
					local v22 = p13.arguments.Min and getValueByIndex(p13.arguments.Min, j, p13.arguments) or t3[p12][j]

					v20.GrabBar.Size = UDim2.new(math.max(1 / math.floor(((p13.arguments.Max and getValueByIndex(p13.arguments.Max, j, p13.arguments) or t4[p12][j]) + 1 - v22) / v21), p1._config.GrabMinSize / v20.AbsoluteSize.X), 0, 1, 0)
				end
			end,
			Discard = function(p1) --[[ Discard | Line: 1330 | Upvalues: p2 (ref) ]]
				p1.Instance:Destroy()
				p2.discardState(p1)
			end,
			GenerateState = function(p12) --[[ GenerateState | Line: 1334 | Upvalues: p1 (ref), p3 (copy) ]]
				if p12.state.number == nil then
					p12.state.number = p1._widgetState(p12, "number", p3)
				end

				if p12.state.editingText ~= nil then
					return
				end

				p12.state.editingText = p1._widgetState(p12, "editingText", false)
			end,
			UpdateState = function(p13) --[[ UpdateState | Line: 1342 | Upvalues: p22 (copy), getValueByIndex (ref), t2 (ref), p12 (copy), t3 (ref), t4 (ref), p1 (ref) ]]
				local v1 = p13.Instance

				for i = 1, p22 do
					local v2 = v1:FindFirstChild("SliderField" .. tostring(i))
					local InputField = v2.InputField
					local OverlayText = v2.OverlayText
					local GrabBar = v2.GrabBar
					local v3 = getValueByIndex(p13.state.number.value, i, p13.arguments)
					local v4 = p13.arguments.Format[i] or p13.arguments.Format[1]

					if p13.arguments.Prefix then
						v4 = p13.arguments.Prefix[i] .. v4
					end

					OverlayText.Text = string.format(v4, v3)
					InputField.Text = tostring(v3)

					local v5 = p13.arguments.Increment and getValueByIndex(p13.arguments.Increment, i, p13.arguments) or t2[p12][i]
					local v6 = p13.arguments.Min and getValueByIndex(p13.arguments.Min, i, p13.arguments) or t3[p12][i]
					local v7 = p13.arguments.Max and getValueByIndex(p13.arguments.Max, i, p13.arguments) or t4[p12][i]
					local v9 = math.floor(((if v5 < 1 then 0 else 1) + v7 - v6) / v5)

					GrabBar.Position = UDim2.new(math.clamp(math.floor((v3 - v6) / (v7 - v6) * v9) / v9, 0, 1 - GrabBar.AbsoluteSize.X / (v2.AbsoluteSize.X - p1._config.FramePadding.X * 2)), 0, 0.5, 0)

					if p13.state.editingText.value == i then
						InputField.Visible = true
						OverlayText.Visible = false
						GrabBar.Visible = false
						InputField:CaptureFocus()

						continue
					end

					InputField.Visible = false
					OverlayText.Visible = true
					GrabBar.Visible = true
				end
			end
		}
	end

	local function generateEnumSliderScalar(p12, p22) --[[ generateEnumSliderScalar | Line: 1399 | Upvalues: generateSliderScalar (ref), p2 (copy), p1 (copy) ]]
		local v1 = generateSliderScalar("Enum", 1, p22.Value)
		local t = { string }

		for v2, v3 in p12:GetEnumItems() do
			t[v3.Value] = v3.Name
		end

		return p2.extend(v1, {
			Args = {
				Text = 1
			},
			Update = function(p13) --[[ Update | Line: 1411 | Upvalues: p12 (copy), p1 (ref) ]]
				local v1 = p13.Instance

				v1.TextLabel.Text = p13.arguments.Text or "Input Enum"
				p13.arguments.Increment = 1
				p13.arguments.Min = 0
				p13.arguments.Max = #p12:GetEnumItems() - 1

				local SliderField1 = v1:FindFirstChild("SliderField1")

				SliderField1.GrabBar.Size = UDim2.new(math.max(1 / math.floor(#p12:GetEnumItems()), p1._config.GrabMinSize / SliderField1.AbsoluteSize.X), 0, 1, 0)
			end,
			GenerateState = function(p12) --[[ GenerateState | Line: 1430 | Upvalues: p1 (ref), p22 (copy) ]]
				if p12.state.number == nil then
					p12.state.number = p1._widgetState(p12, "number", p22.Value)
				end

				if p12.state.enumItem == nil then
					p12.state.enumItem = p1._widgetState(p12, "enumItem", p22)
				end

				if p12.state.editingText ~= nil then
					return
				end

				p12.state.editingText = p1._widgetState(p12, "editingText", false)
			end
		})
	end

	local v10 = generateInputScalar("Num", 1, 0)

	v10.Args.NoButtons = 6
	p1.WidgetConstructor("InputNum", v10)
	p1.WidgetConstructor("InputVector2", generateInputScalar("Vector2", 2, Vector2.zero))
	p1.WidgetConstructor("InputVector3", generateInputScalar("Vector3", 3, Vector3.new(0, 0, 0)))
	p1.WidgetConstructor("InputUDim", generateInputScalar("UDim", 2, UDim.new()))
	p1.WidgetConstructor("InputUDim2", generateInputScalar("UDim2", 4, UDim2.new()))
	p1.WidgetConstructor("InputRect", generateInputScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
	p1.WidgetConstructor("DragNum", generateDragScalar("Num", 1, 0))
	p1.WidgetConstructor("DragVector2", generateDragScalar("Vector2", 2, Vector2.zero))
	p1.WidgetConstructor("DragVector3", generateDragScalar("Vector3", 3, Vector3.new(0, 0, 0)))
	p1.WidgetConstructor("DragUDim", generateDragScalar("UDim", 2, UDim.new()))
	p1.WidgetConstructor("DragUDim2", generateDragScalar("UDim2", 4, UDim2.new()))
	p1.WidgetConstructor("DragRect", generateDragScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
	p1.WidgetConstructor("InputColor3", generateColorDragScalar("Color3", Color3.fromRGB(0, 0, 0)))
	p1.WidgetConstructor("InputColor4", generateColorDragScalar("Color4", Color3.fromRGB(0, 0, 0), 0))
	p1.WidgetConstructor("SliderNum", generateSliderScalar("Num", 1, 0))
	p1.WidgetConstructor("SliderVector2", generateSliderScalar("Vector2", 2, Vector2.zero))
	p1.WidgetConstructor("SliderVector3", generateSliderScalar("Vector3", 3, Vector3.new(0, 0, 0)))
	p1.WidgetConstructor("SliderUDim", generateSliderScalar("UDim", 2, UDim.new()))
	p1.WidgetConstructor("SliderUDim2", generateSliderScalar("UDim2", 4, UDim2.new()))
	p1.WidgetConstructor("SliderRect", generateSliderScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
	p1.WidgetConstructor("InputText", {
		hasState = true,
		hasChildren = false,
		Args = {
			Text = 1,
			TextHint = 2
		},
		Events = {
			textChanged = {
				Init = function(p1) --[[ Line: 1485 ]]
					p1.lastTextchangeTick = 0
				end,
				Get = function(p12) --[[ Line: 1488 | Upvalues: p1 (copy) ]]
					return p12.lastTextchangeTick == p1._cycleTick
				end
			},
			hovered = p2.EVENTS.hover(function(p1) --[[ Line: 1492 ]]
				return p1.Instance
			end)
		},
		Generate = function(p12) --[[ Generate | Line: 1496 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_InputText = Instance.new("Frame")

			Iris_InputText.Name = "Iris_InputText"
			Iris_InputText.Size = UDim2.new(p1._config.ContentWidth, UDim.new(0, 0))
			Iris_InputText.BackgroundTransparency = 1
			Iris_InputText.BorderSizePixel = 0
			Iris_InputText.ZIndex = p12.ZIndex
			Iris_InputText.LayoutOrder = p12.ZIndex
			Iris_InputText.AutomaticSize = Enum.AutomaticSize.Y
			p2.UIListLayout(Iris_InputText, Enum.FillDirection.Horizontal, UDim.new(0, p1._config.ItemInnerSpacing.X))

			local InputField = Instance.new("TextBox")

			InputField.Name = "InputField"
			InputField.Size = UDim2.new(1, 0, 0, 0)
			InputField.AutomaticSize = Enum.AutomaticSize.Y
			InputField.BackgroundColor3 = p1._config.FrameBgColor
			InputField.BackgroundTransparency = p1._config.FrameBgTransparency
			InputField.Text = ""
			InputField.PlaceholderColor3 = p1._config.TextDisabledColor
			InputField.TextTruncate = Enum.TextTruncate.AtEnd
			InputField.ClearTextOnFocus = false
			InputField.ZIndex = p12.ZIndex + 1
			InputField.LayoutOrder = p12.ZIndex + 1
			InputField.ClipsDescendants = true
			p2.applyFrameStyle(InputField)
			p2.applyTextStyle(InputField)
			p2.UISizeConstraint(InputField, Vector2.new(1, 0))
			InputField.Parent = Iris_InputText
			InputField.FocusLost:Connect(function() --[[ Line: 1532 | Upvalues: p12 (copy), InputField (copy), p1 (ref) ]]
				p12.state.text:set(InputField.Text)
				p12.lastTextchangeTick = p1._cycleTick + 1
			end)

			local v1 = p1._config.TextSize + p1._config.FramePadding.Y * 2
			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = "TextLabel"
			TextLabel.Size = UDim2.fromOffset(0, v1)
			TextLabel.AutomaticSize = Enum.AutomaticSize.X
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.ZIndex = p12.ZIndex + 4
			TextLabel.LayoutOrder = p12.ZIndex + 4
			p2.applyTextStyle(TextLabel)
			TextLabel.Parent = Iris_InputText

			return Iris_InputText
		end,
		Update = function(p1) --[[ Update | Line: 1554 ]]
			local v1 = p1.Instance

			v1.TextLabel.Text = p1.arguments.Text or "Input Text"
			v1.InputField.PlaceholderText = p1.arguments.TextHint or ""
		end,
		Discard = function(p1) --[[ Discard | Line: 1562 | Upvalues: p2 (copy) ]]
			p1.Instance:Destroy()
			p2.discardState(p1)
		end,
		GenerateState = function(p12) --[[ GenerateState | Line: 1566 | Upvalues: p1 (copy) ]]
			if p12.state.text ~= nil then
				return
			end

			p12.state.text = p1._widgetState(p12, "text", "")
		end,
		UpdateState = function(p1) --[[ UpdateState | Line: 1571 ]]
			p1.Instance.InputField.Text = p1.state.text.value
		end
	})
end