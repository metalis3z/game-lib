-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:40
-- Luau version 6, Types version 3
-- Time taken: 0.003240 seconds

return function(arg1, arg2) -- Line 3
	local tbl = {
		hasState = true;
		hasChildren = false;
		Args = {
			Text = 1;
			Index = 2;
		};
		Events = {
			selected = {
				Init = function(arg1_2) -- Line 14
				end;
				Get = function(arg1_3) -- Line 15
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var8
					if arg1_3.lastSelectedTick ~= arg1._cycleTick then
						var8 = false
					else
						var8 = true
					end
					return var8
				end;
			};
			unselected = {
				Init = function(arg1_4) -- Line 20
				end;
				Get = function(arg1_5) -- Line 21
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var12
					if arg1_5.lastUnselectedTick ~= arg1._cycleTick then
						var12 = false
					else
						var12 = true
					end
					return var12
				end;
			};
			active = {
				Init = function(arg1_6) -- Line 26
				end;
				Get = function(arg1_7) -- Line 27
					local var16
					if arg1_7.state.index.value ~= arg1_7.arguments.Index then
						var16 = false
					else
						var16 = true
					end
					return var16
				end;
			};
			hovered = arg2.EVENTS.hover(function(arg1_8) -- Line 31
				return arg1_8.Instance
			end);
		};
	}
	function tbl.Generate(arg1_9) -- Line 35
		--[[ Upvalues[2]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
		]]
		local TextButton = Instance.new("TextButton")
		TextButton.Name = "RadioButton"
		TextButton.AutomaticSize = Enum.AutomaticSize.XY
		TextButton.Size = UDim2.fromOffset(0, 0)
		TextButton.BackgroundTransparency = 1
		TextButton.BorderSizePixel = 0
		TextButton.Text = ""
		TextButton.LayoutOrder = arg1_9.ZIndex
		TextButton.AutoButtonColor = false
		TextButton.ZIndex = arg1_9.ZIndex
		TextButton.LayoutOrder = arg1_9.ZIndex
		arg2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		local var19 = arg1._config.TextSize + 2 * (arg1._config.FramePadding.Y - 1)
		local Frame_2 = Instance.new("Frame")
		Frame_2.Name = "Button"
		Frame_2.Size = UDim2.fromOffset(var19, var19)
		Frame_2.Parent = TextButton
		Frame_2.BackgroundColor3 = arg1._config.FrameBgColor
		Frame_2.BackgroundTransparency = arg1._config.FrameBgTransparency
		arg2.UICorner(Frame_2)
		arg2.UIPadding(Frame_2, math.max(1, var19 // 5) * Vector2.one)
		local Frame = Instance.new("Frame")
		Frame.Name = "Circle"
		Frame.Size = UDim2.fromScale(1, 1)
		Frame.Parent = Frame_2
		Frame.BackgroundColor3 = arg1._config.CheckMarkColor
		Frame.BackgroundTransparency = arg1._config.CheckMarkTransparency
		arg2.UICorner(Frame)
		arg2.applyInteractionHighlights(arg1_9, TextButton, Frame_2, {
			ButtonColor = arg1._config.FrameBgColor;
			ButtonTransparency = arg1._config.FrameBgTransparency;
			ButtonHoveredColor = arg1._config.FrameBgHoveredColor;
			ButtonHoveredTransparency = arg1._config.FrameBgHoveredTransparency;
			ButtonActiveColor = arg1._config.FrameBgActiveColor;
			ButtonActiveTransparency = arg1._config.FrameBgActiveTransparency;
		})
		arg2.applyButtonClick(arg1_9, TextButton, function() -- Line 79
			--[[ Upvalues[1]:
				[1]: arg1_9 (readonly)
			]]
			arg1_9.state.index:set(arg1_9.arguments.Index)
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
	function tbl.Update(arg1_10) -- Line 95
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1_10.Instance.TextLabel.Text = arg1_10.arguments.Text or "Radio Button"
		if arg1_10.state then
			arg1._widgets[arg1_10.type].UpdateState(arg1_10)
		end
	end
	function tbl.Discard(arg1_11) -- Line 104
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		arg1_11.Instance:Destroy()
		arg2.discardState(arg1_11)
	end
	function tbl.GenerateState(arg1_12) -- Line 108
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1_12.state.index == nil then
			arg1_12.state.index = arg1._widgetState(arg1_12, "index", arg1_12.arguments.Value)
		end
	end
	function tbl.UpdateState(arg1_13) -- Line 113
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local Circle = arg1_13.Instance.Button.Circle
		if arg1_13.state.index.value == arg1_13.arguments.Index then
			Circle.BackgroundTransparency = arg1._config.CheckMarkTransparency
			arg1_13.lastSelectedTick = arg1._cycleTick + 1
		else
			Circle.BackgroundTransparency = 1
			arg1_13.lastUnselectedTick = arg1._cycleTick + 1
		end
	end
	arg1.WidgetConstructor("RadioButton", tbl)
end