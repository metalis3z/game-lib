-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Types)

local t = {}

return function(p1) --[[ Line: 5 | Upvalues: t (copy) ]]
	t.GuiService = game:GetService("GuiService")
	t.RunService = game:GetService("RunService")
	t.UserInputService = game:GetService("UserInputService")
	t.ContextActionService = game:GetService("ContextActionService")
	t.TextService = game:GetService("TextService")
	t.ICONS = {
		RIGHT_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_right.png",
		DOWN_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_down.png",
		MULTIPLICATION_SIGN = "rbxasset://textures/AnimationEditor/icon_close.png",
		BOTTOM_RIGHT_CORNER = "\226\151\162",
		CHECK_MARK = "rbxasset://textures/AnimationEditor/icon_checkmark.png",
		ALPHA_BACKGROUND_TEXTURE = "rbxasset://textures/meshPartFallback.png"
	}
	t.GuiInset = t.GuiService:GetGuiInset()
	t.IS_STUDIO = t.RunService:IsStudio()
	function t.getTime() --[[ getTime | Line: 24 | Upvalues: t (ref) ]]
		if t.IS_STUDIO then
			return os.clock()
		end

		return time()
	end
	function t.getMouseLocation() --[[ getMouseLocation | Line: 33 | Upvalues: t (ref) ]]
		return t.UserInputService:GetMouseLocation() - t.GuiInset
	end
	function t.findBestWindowPosForPopup(p1, p2, p3, p4) --[[ findBestWindowPosForPopup | Line: 37 ]]
		local v1 = if p1.X + p2.X + 20 > p4.X then if p1.Y + p2.Y + 20 > p4.Y then p1 + Vector2.new(0, -(20 + p2.Y)) else p1 + Vector2.new(0, 20) else p1 + Vector2.new(20, 0)

		return Vector2.new(math.max(math.min(v1.X + p2.X, p4.X) - p2.X, p3.X), (math.max(math.min(v1.Y + p2.Y, p4.Y) - p2.Y, p3.Y)))
	end
	function t.isPosInsideRect(p1, p2, p3) --[[ isPosInsideRect | Line: 65 ]]
		return if p1.X > p2.X and (p1.X < p3.X and p1.Y > p2.Y) then p1.Y < p3.Y else false
	end
	function t.extend(p1, p2) --[[ extend | Line: 69 ]]
		local v1 = table.clone(p1)

		for v2, v3 in p2 do
			v1[v2] = v3
		end

		return v1
	end
	function t.UIPadding(p1, p2) --[[ UIPadding | Line: 77 ]]
		local UIPadding = Instance.new("UIPadding")

		UIPadding.PaddingLeft = UDim.new(0, p2.X)
		UIPadding.PaddingRight = UDim.new(0, p2.X)
		UIPadding.PaddingTop = UDim.new(0, p2.Y)
		UIPadding.PaddingBottom = UDim.new(0, p2.Y)
		UIPadding.Parent = p1

		return UIPadding
	end
	function t.UIListLayout(p1, p2, p3) --[[ UIListLayout | Line: 87 ]]
		local UIListLayout = Instance.new("UIListLayout")

		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = p3
		UIListLayout.FillDirection = p2
		UIListLayout.Parent = p1

		return UIListLayout
	end
	function t.UIStroke(p1, p2, p3, p4) --[[ UIStroke | Line: 96 ]]
		local UIStroke = Instance.new("UIStroke")

		UIStroke.Thickness = p2
		UIStroke.Color = p3
		UIStroke.Transparency = p4
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.LineJoinMode = Enum.LineJoinMode.Round
		UIStroke.Parent = p1

		return UIStroke
	end
	function t.UICorner(p1, p2) --[[ UICorner | Line: 107 ]]
		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(if p2 then 0 else 1, p2 or 0)
		UICorner.Parent = p1

		return UICorner
	end
	function t.UISizeConstraint(p1, p2, p3) --[[ UISizeConstraint | Line: 114 ]]
		local UISizeConstraint = Instance.new("UISizeConstraint")

		UISizeConstraint.MinSize = if p2 then p2 else UISizeConstraint.MinSize
		UISizeConstraint.MaxSize = if p3 then p3 else UISizeConstraint.MaxSize
		UISizeConstraint.Parent = p1

		return UISizeConstraint
	end
	function t.UIReference(p1, p2, p3) --[[ UIReference | Line: 122 ]]
		local v1 = Instance.new("ObjectValue")

		v1.Name = p3
		v1.Value = p2
		v1.Parent = p1

		return v1
	end
	function t.getScreenSizeForWindow(p1) --[[ getScreenSizeForWindow | Line: 131 ]]
		if p1.usesScreenGUI then
			return p1.Instance.AbsoluteSize
		end

		local v1 = p1.Instance.Parent

		if v1:IsA("GuiBase2d") then
			return v1.AbsoluteSize
		end

		if v1.Parent:IsA("GuiBase2d") then
			return v1.AbsoluteSize
		end

		return workspace.CurrentCamera.ViewportSize
	end

	local GetTextBoundsParams = Instance.new("GetTextBoundsParams")

	GetTextBoundsParams.Font = p1._config.TextFont
	GetTextBoundsParams.Size = p1._config.TextSize
	GetTextBoundsParams.Width = (1 / 0)
	function t.calculateTextSize(p1, p2) --[[ calculateTextSize | Line: 158 | Upvalues: GetTextBoundsParams (copy), t (ref) ]]
		if p2 then
			GetTextBoundsParams.Width = p2
		end

		GetTextBoundsParams.Text = p1

		local v1 = t.TextService:GetTextBoundsAsync(GetTextBoundsParams)

		if not p2 then
			return v1
		end

		GetTextBoundsParams.Width = (1 / 0)

		return v1
	end
	function t.applyTextStyle(p12) --[[ applyTextStyle | Line: 173 | Upvalues: p1 (copy) ]]
		p12.FontFace = p1._config.TextFont
		p12.TextSize = p1._config.TextSize
		p12.TextColor3 = p1._config.TextColor
		p12.TextTransparency = p1._config.TextTransparency
		p12.TextXAlignment = Enum.TextXAlignment.Left
		p12.AutoLocalize = false
		p12.RichText = false
	end
	function t.applyInteractionHighlights(p12, p2, p3) --[[ applyInteractionHighlights | Line: 184 | Upvalues: p1 (copy) ]]
		local v1 = false

		p12.MouseEnter:Connect(function() --[[ Line: 186 | Upvalues: p2 (copy), p3 (copy), v1 (ref) ]]
			p2.BackgroundColor3 = p3.ButtonHoveredColor
			p2.BackgroundTransparency = p3.ButtonHoveredTransparency
			v1 = false
		end)
		p12.MouseLeave:Connect(function() --[[ Line: 193 | Upvalues: p2 (copy), p3 (copy), v1 (ref) ]]
			p2.BackgroundColor3 = p3.ButtonColor
			p2.BackgroundTransparency = p3.ButtonTransparency
			v1 = true
		end)
		p12.InputBegan:Connect(function(p1) --[[ Line: 200 | Upvalues: p2 (copy), p3 (copy) ]]
			if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Gamepad1 then
				p2.BackgroundColor3 = p3.ButtonActiveColor
				p2.BackgroundTransparency = p3.ButtonActiveTransparency
			end
		end)
		p12.InputEnded:Connect(function(p1) --[[ Line: 213 | Upvalues: v1 (ref), p2 (copy), p3 (copy) ]]
			if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Gamepad1 then
				return
			end

			if v1 then
				return
			end

			if p1.UserInputType == Enum.UserInputType.MouseButton1 then
				p2.BackgroundColor3 = p3.ButtonHoveredColor
				p2.BackgroundTransparency = p3.ButtonHoveredTransparency
			end

			if p1.UserInputType ~= Enum.UserInputType.Gamepad1 then
				return
			end

			p2.BackgroundColor3 = p3.ButtonColor
			p2.BackgroundTransparency = p3.ButtonTransparency
		end)
		p12.SelectionImageObject = p1.SelectionImageObject
	end
	function t.applyInteractionHighlightsWithMultiHighlightee(p12, p2) --[[ applyInteractionHighlightsWithMultiHighlightee | Line: 235 | Upvalues: p1 (copy) ]]
		local v1 = false

		p12.MouseEnter:Connect(function() --[[ Line: 240 | Upvalues: p2 (copy), v1 (ref) ]]
			for v12, v2 in p2 do
				v2[1].BackgroundColor3 = v2[2].ButtonHoveredColor
				v2[1].BackgroundTransparency = v2[2].ButtonHoveredTransparency
				v1 = false
			end
		end)
		p12.MouseLeave:Connect(function() --[[ Line: 249 | Upvalues: p2 (copy), v1 (ref) ]]
			for v12, v2 in p2 do
				v2[1].BackgroundColor3 = v2[2].ButtonColor
				v2[1].BackgroundTransparency = v2[2].ButtonTransparency
				v1 = true
			end
		end)
		p12.InputBegan:Connect(function(p1) --[[ Line: 258 | Upvalues: p2 (copy) ]]
			if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Gamepad1 then
				return
			end

			for v1, v2 in p2 do
				v2[1].BackgroundColor3 = v2[2].ButtonActiveColor
				v2[1].BackgroundTransparency = v2[2].ButtonActiveTransparency
			end
		end)
		p12.InputEnded:Connect(function(p1) --[[ Line: 273 | Upvalues: v1 (ref), p2 (copy) ]]
			if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Gamepad1 then
				return
			end

			if v1 then
				return
			end

			for v12, v2 in p2 do
				if p1.UserInputType == Enum.UserInputType.MouseButton1 then
					v2[1].BackgroundColor3 = v2[2].ButtonHoveredColor
					v2[1].BackgroundTransparency = v2[2].ButtonHoveredTransparency
				end

				if p1.UserInputType == Enum.UserInputType.Gamepad1 then
					v2[1].BackgroundColor3 = v2[2].ButtonColor
					v2[1].BackgroundTransparency = v2[2].ButtonTransparency
				end
			end
		end)
		p12.SelectionImageObject = p1.SelectionImageObject
	end
	function t.applyTextInteractionHighlights(p12, p2, p3) --[[ applyTextInteractionHighlights | Line: 297 | Upvalues: p1 (copy) ]]
		local v1 = false

		p12.MouseEnter:Connect(function() --[[ Line: 303 | Upvalues: p2 (copy), p3 (copy), v1 (ref) ]]
			p2.TextColor3 = p3.ButtonHoveredColor
			p2.TextTransparency = p3.ButtonHoveredTransparency
			v1 = false
		end)
		p12.MouseLeave:Connect(function() --[[ Line: 310 | Upvalues: p2 (copy), p3 (copy), v1 (ref) ]]
			p2.TextColor3 = p3.ButtonColor
			p2.TextTransparency = p3.ButtonTransparency
			v1 = true
		end)
		p12.InputBegan:Connect(function(p1) --[[ Line: 317 | Upvalues: p2 (copy), p3 (copy) ]]
			if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Gamepad1 then
				p2.TextColor3 = p3.ButtonActiveColor
				p2.TextTransparency = p3.ButtonActiveTransparency
			end
		end)
		p12.InputEnded:Connect(function(p1) --[[ Line: 330 | Upvalues: v1 (ref), p2 (copy), p3 (copy) ]]
			if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Gamepad1 then
				return
			end

			if v1 then
				return
			end

			if p1.UserInputType == Enum.UserInputType.MouseButton1 then
				p2.TextColor3 = p3.ButtonHoveredColor
				p2.TextTransparency = p3.ButtonHoveredTransparency
			end

			if p1.UserInputType ~= Enum.UserInputType.Gamepad1 then
				return
			end

			p2.TextColor3 = p3.ButtonColor
			p2.TextTransparency = p3.ButtonTransparency
		end)
		p12.SelectionImageObject = p1.SelectionImageObject
	end
	function t.applyFrameStyle(p12, p2, p3) --[[ applyFrameStyle | Line: 352 | Upvalues: p1 (copy), t (ref) ]]
		local FramePadding = p1._config.FramePadding
		local FrameBorderSize = p1._config.FrameBorderSize
		local BorderColor = p1._config.BorderColor
		local ButtonTransparency = p1._config.ButtonTransparency
		local FrameRounding = p1._config.FrameRounding

		if FrameBorderSize > 0 and FrameRounding > 0 then
			p12.BorderSizePixel = 0

			local UIStroke = Instance.new("UIStroke")

			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.LineJoinMode = Enum.LineJoinMode.Round
			UIStroke.Transparency = ButtonTransparency
			UIStroke.Thickness = FrameBorderSize
			UIStroke.Color = BorderColor
			t.UICorner(p12, FrameRounding)
			UIStroke.Parent = p12

			if not p2 then
				t.UIPadding(p12, p1._config.FramePadding)
			end
		elseif FrameBorderSize < 1 and FrameRounding > 0 then
			p12.BorderSizePixel = 0
			t.UICorner(p12, FrameRounding)

			if not p2 then
				t.UIPadding(p12, p1._config.FramePadding)
			end
		else
			if not (FrameRounding < 1) then
				return
			end

			p12.BorderSizePixel = FrameBorderSize
			p12.BorderColor3 = BorderColor
			p12.BorderMode = Enum.BorderMode.Inset

			if not p2 then
				t.UIPadding(p12, FramePadding - Vector2.new(FrameBorderSize, FrameBorderSize))

				return
			end

			if p3 then
				return
			end

			t.UIPadding(p12, -Vector2.new(FrameBorderSize, FrameBorderSize))
		end
	end
	function t.discardState(p1) --[[ discardState | Line: 397 ]]
		for v1, v2 in p1.state do
			v2.ConnectedWidgets[p1.ID] = nil
		end
	end
	t.EVENTS = {
		hover = function(p1) --[[ hover | Line: 404 ]]
			return {
				Init = function(p12) --[[ Line: 406 | Upvalues: p1 (copy) ]]
					local v1 = p1(p12)

					v1.MouseEnter:Connect(function() --[[ Line: 408 | Upvalues: p12 (copy) ]]
						p12.isHoveredEvent = true
					end)
					v1.MouseLeave:Connect(function() --[[ Line: 411 | Upvalues: p12 (copy) ]]
						p12.isHoveredEvent = false
					end)
					p12.isHoveredEvent = false
				end,
				Get = function(p1) --[[ Line: 416 ]]
					return p1.isHoveredEvent
				end
			}
		end,
		click = function(p12) --[[ click | Line: 422 | Upvalues: p1 (copy) ]]
			return {
				Init = function(p13) --[[ Line: 424 | Upvalues: p12 (copy), p1 (ref) ]]
					local v1 = p12(p13)

					p13.lastClickedTick = -1
					v1.MouseButton1Click:Connect(function() --[[ Line: 428 | Upvalues: p13 (copy), p1 (ref) ]]
						p13.lastClickedTick = p1._cycleTick + 1
					end)
				end,
				Get = function(p12) --[[ Line: 432 | Upvalues: p1 (ref) ]]
					return p12.lastClickedTick == p1._cycleTick
				end
			}
		end,
		rightClick = function(p12) --[[ rightClick | Line: 438 | Upvalues: p1 (copy) ]]
			return {
				Init = function(p13) --[[ Line: 440 | Upvalues: p12 (copy), p1 (ref) ]]
					local v1 = p12(p13)

					p13.lastRightClickedTick = -1
					v1.MouseButton2Click:Connect(function() --[[ Line: 444 | Upvalues: p13 (copy), p1 (ref) ]]
						p13.lastRightClickedTick = p1._cycleTick + 1
					end)
				end,
				Get = function(p12) --[[ Line: 448 | Upvalues: p1 (ref) ]]
					return p12.lastRightClickedTick == p1._cycleTick
				end
			}
		end,
		doubleClick = function(p12) --[[ doubleClick | Line: 454 | Upvalues: t (ref), p1 (copy) ]]
			return {
				Init = function(p13) --[[ Line: 456 | Upvalues: p12 (copy), t (ref), p1 (ref) ]]
					local v1 = p12(p13)

					p13.lastClickedTime = -1
					p13.lastClickedPosition = Vector2.zero
					p13.lastDoubleClickedTick = -1
					v1.MouseButton1Down:Connect(function(p12, p2) --[[ Line: 462 | Upvalues: t (ref), p13 (copy), p1 (ref) ]]
						local v1 = t.getTime()
						local v2 = if v1 - p13.lastClickedTime < p1._config.MouseDoubleClickTime then true else false

						if v2 and (Vector2.new(p12, p2) - p13.lastClickedPosition).Magnitude < p1._config.MouseDoubleClickMaxDist then
							p13.lastDoubleClickedTick = p1._cycleTick + 1

							return
						end

						p13.lastClickedTime = v1
						p13.lastClickedPosition = Vector2.new(p12, p2)
					end)
				end,
				Get = function(p12) --[[ Line: 478 | Upvalues: p1 (ref) ]]
					return p12.lastDoubleClickedTick == p1._cycleTick
				end
			}
		end,
		ctrlClick = function(p12) --[[ ctrlClick | Line: 484 | Upvalues: t (ref), p1 (copy) ]]
			return {
				Init = function(p13) --[[ Line: 486 | Upvalues: p12 (copy), t (ref), p1 (ref) ]]
					local v1 = p12(p13)

					p13.lastCtrlClickedTick = -1
					v1.MouseButton1Click:Connect(function() --[[ Line: 490 | Upvalues: t (ref), p13 (copy), p1 (ref) ]]
						if not (t.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or t.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
							return
						end

						p13.lastCtrlClickedTick = p1._cycleTick + 1
					end)
				end,
				Get = function(p12) --[[ Line: 499 | Upvalues: p1 (ref) ]]
					return p12.lastCtrlClickedTick == p1._cycleTick
				end
			}
		end,
		shortcut = function(p12) --[[ shortcut | Line: 505 | Upvalues: t (ref), p1 (copy) ]]
			return {
				Init = function(p13) --[[ Line: 507 | Upvalues: p12 (copy), t (ref), p1 (ref) ]]
					local v1, v2 = p12(p13)

					p13.lastShortcutTick = -1
					t.ContextActionService:BindAction(p13.ID, function(p12, p2, p3) --[[ Line: 513 | Upvalues: v2 (copy), p13 (copy), p1 (ref) ]]
						if p2 ~= Enum.UserInputState.Begin or not p3:IsModifierKeyDown(v2) then
							return
						end

						p13.lastShortcutTick = p1._cycleTick + 1
					end, false, v1)
				end,
				Get = function(p12) --[[ Line: 524 | Upvalues: p1 (ref) ]]
					return p12.lastShortcutTick == p1._cycleTick
				end
			}
		end
	}
	require(script.Root)(p1, t)
	require(script.Window)(p1, t)
	require(script.Menu)(p1, t)
	require(script.Format)(p1, t)
	require(script.Text)(p1, t)
	require(script.Button)(p1, t)
	require(script.Checkbox)(p1, t)
	require(script.RadioButton)(p1, t)
	require(script.Tree)(p1, t)
	require(script.Input)(p1, t)
	require(script.Combo)(p1, t)
	require(script.Table)(p1, t)
end