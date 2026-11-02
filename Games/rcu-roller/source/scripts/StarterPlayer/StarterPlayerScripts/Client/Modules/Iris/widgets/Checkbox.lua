-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:32
-- Luau version 6, Types version 3
-- Time taken: 0.002773 seconds

return function(arg1, arg2) -- Line 3
	local tbl = {
		hasState = true;
		hasChildren = false;
		Args = {
			Text = 1;
		};
		Events = {
			checked = {
				Init = function(arg1_2) -- Line 13
				end;
				Get = function(arg1_3) -- Line 14
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var8
					if arg1_3.lastCheckedTick ~= arg1._cycleTick then
						var8 = false
					else
						var8 = true
					end
					return var8
				end;
			};
			unchecked = {
				Init = function(arg1_4) -- Line 19
				end;
				Get = function(arg1_5) -- Line 20
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var12
					if arg1_5.lastUncheckedTick ~= arg1._cycleTick then
						var12 = false
					else
						var12 = true
					end
					return var12
				end;
			};
			hovered = arg2.EVENTS.hover(function(arg1_6) -- Line 24
				return arg1_6.Instance
			end);
		};
	}
	function tbl.Generate(arg1_7) -- Line 28
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		local TextButton = Instance.new("TextButton")
		TextButton.Name = "Checkbox"
		TextButton.AutomaticSize = Enum.AutomaticSize.XY
		TextButton.Size = UDim2.fromOffset(0, 0)
		TextButton.BackgroundTransparency = 1
		TextButton.BorderSizePixel = 0
		TextButton.Text = ""
		TextButton.AutoButtonColor = false
		TextButton.ZIndex = arg1_7.ZIndex
		TextButton.LayoutOrder = arg1_7.ZIndex
		arg2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		local var15 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y
		local Frame = Instance.new("Frame")
		Frame.Name = "Box"
		Frame.Size = UDim2.fromOffset(var15, var15)
		Frame.BackgroundColor3 = arg1._config.FrameBgColor
		Frame.BackgroundTransparency = arg1._config.FrameBgTransparency
		arg2.applyFrameStyle(Frame, true)
		arg2.UIPadding(Frame, var15 // 10 * Vector2.one)
		arg2.applyInteractionHighlights(arg1_7, TextButton, Frame, {
			ButtonColor = arg1._config.FrameBgColor;
			ButtonTransparency = arg1._config.FrameBgTransparency;
			ButtonHoveredColor = arg1._config.FrameBgHoveredColor;
			ButtonHoveredTransparency = arg1._config.FrameBgHoveredTransparency;
			ButtonActiveColor = arg1._config.FrameBgActiveColor;
			ButtonActiveTransparency = arg1._config.FrameBgActiveTransparency;
		})
		Frame.Parent = TextButton
		local ImageLabel = Instance.new("ImageLabel")
		ImageLabel.Name = "Checkmark"
		ImageLabel.Size = UDim2.fromScale(1, 1)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.ImageColor3 = arg1._config.CheckMarkColor
		ImageLabel.ImageTransparency = arg1._config.CheckMarkTransparency
		ImageLabel.ScaleType = Enum.ScaleType.Fit
		ImageLabel.Parent = Frame
		arg2.applyButtonClick(arg1_7, TextButton, function() -- Line 75
			--[[ Upvalues[1]:
				[1]: arg1_7 (readonly)
			]]
			arg1_7.state.isChecked:set(not arg1_7.state.isChecked.value)
		end)
		local TextLabel = Instance.new("TextLabel")
		TextLabel.Name = "TextLabel"
		TextLabel.AutomaticSize = Enum.AutomaticSize.XY
		TextLabel.BackgroundTransparency = 1
		TextLabel.BorderSizePixel = 0
		TextLabel.LayoutOrder = 1
		arg2.applyTextStyle(TextLabel)
		TextLabel.Parent = TextButton
		return TextButton
	end
	function tbl.Update(arg1_8) -- Line 92
		arg1_8.Instance.TextLabel.Text = arg1_8.arguments.Text or "Checkbox"
	end
	function tbl.Discard(arg1_9) -- Line 96
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		arg1_9.Instance:Destroy()
		arg2.discardState(arg1_9)
	end
	function tbl.GenerateState(arg1_10) -- Line 100
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1_10.state.isChecked == nil then
			arg1_10.state.isChecked = arg1._widgetState(arg1_10, "checked", false)
		end
	end
	function tbl.UpdateState(arg1_11) -- Line 105
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		local Checkmark = arg1_11.Instance.Box.Checkmark
		if arg1_11.state.isChecked.value then
			Checkmark.Image = arg2.ICONS.CHECK_MARK
			arg1_11.lastCheckedTick = arg1._cycleTick + 1
		else
			Checkmark.Image = ""
			arg1_11.lastUncheckedTick = arg1._cycleTick + 1
		end
	end
	arg1.WidgetConstructor("Checkbox", tbl)
end