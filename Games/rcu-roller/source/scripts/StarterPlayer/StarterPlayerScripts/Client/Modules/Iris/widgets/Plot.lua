-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:39
-- Luau version 6, Types version 3
-- Time taken: 0.003163 seconds

return function(arg1, arg2) -- Line 3
	local tbl = {
		hasState = true;
		hasChildren = false;
		Args = {
			Text = 1;
			Format = 2;
		};
		Events = {
			hovered = arg2.EVENTS.hover(function(arg1_2) -- Line 14
				return arg1_2.Instance
			end);
			changed = {
				Init = function(arg1_3) -- Line 18
				end;
				Get = function(arg1_4) -- Line 19
					--[[ Upvalues[1]:
						[1]: arg1 (readonly)
					]]
					local var9
					if arg1_4.lastNumberChangedTick ~= arg1._cycleTick then
						var9 = false
					else
						var9 = true
					end
					return var9
				end;
			};
		};
	}
	function tbl.Generate(arg1_5) -- Line 24
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		local Frame_2 = Instance.new("Frame")
		Frame_2.Name = "ProgressBar"
		Frame_2.Size = UDim2.new(arg1._config.ItemWidth, UDim.new())
		Frame_2.BackgroundTransparency = 1
		Frame_2.AutomaticSize = Enum.AutomaticSize.Y
		Frame_2.LayoutOrder = arg1_5.ZIndex
		arg2.UIListLayout(Frame_2, Enum.FillDirection.Horizontal, UDim.new(0, arg1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
		local Frame = Instance.new("Frame")
		Frame.Name = "Bar"
		Frame.Size = UDim2.new(arg1._config.ContentWidth, arg1._config.ContentHeight)
		Frame.BackgroundColor3 = arg1._config.FrameBgColor
		Frame.BackgroundTransparency = arg1._config.FrameBgTransparency
		Frame.BorderSizePixel = 0
		Frame.AutomaticSize = Enum.AutomaticSize.Y
		Frame.ClipsDescendants = true
		arg2.applyFrameStyle(Frame, true)
		Frame.Parent = Frame_2
		local TextLabel_3 = Instance.new("TextLabel")
		TextLabel_3.Name = "Progress"
		TextLabel_3.AutomaticSize = Enum.AutomaticSize.Y
		TextLabel_3.Size = UDim2.new(UDim.new(0, 0), arg1._config.ContentHeight)
		TextLabel_3.BackgroundColor3 = arg1._config.PlotHistogramColor
		TextLabel_3.BackgroundTransparency = arg1._config.PlotHistogramTransparency
		TextLabel_3.BorderSizePixel = 0
		arg2.applyTextStyle(TextLabel_3)
		arg2.UIPadding(TextLabel_3, arg1._config.FramePadding)
		arg2.UICorner(TextLabel_3, arg1._config.FrameRounding)
		TextLabel_3.Text = ""
		TextLabel_3.Parent = Frame
		local TextLabel = Instance.new("TextLabel")
		TextLabel.Name = "Value"
		TextLabel.AutomaticSize = Enum.AutomaticSize.XY
		TextLabel.Size = UDim2.new(UDim.new(0, 0), arg1._config.ContentHeight)
		TextLabel.BackgroundTransparency = 1
		TextLabel.BorderSizePixel = 0
		TextLabel.ZIndex = 1
		arg2.applyTextStyle(TextLabel)
		arg2.UIPadding(TextLabel, arg1._config.FramePadding)
		TextLabel.Parent = Frame
		local TextLabel_2 = Instance.new("TextLabel")
		TextLabel_2.Name = "TextLabel"
		TextLabel_2.AutomaticSize = Enum.AutomaticSize.XY
		TextLabel_2.AnchorPoint = Vector2.new(0, 0.5)
		TextLabel_2.BackgroundTransparency = 1
		TextLabel_2.BorderSizePixel = 0
		TextLabel_2.LayoutOrder = 1
		arg2.applyTextStyle(TextLabel_2)
		arg2.UIPadding(TextLabel, arg1._config.FramePadding)
		TextLabel_2.Parent = Frame_2
		return Frame_2
	end
	function tbl.GenerateState(arg1_6) -- Line 91
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1_6.state.progress == nil then
			arg1_6.state.progress = arg1._widgetState(arg1_6, "Progress", 0)
		end
	end
	function tbl.Update(arg1_7) -- Line 96
		local Instance = arg1_7.Instance
		if arg1_7.arguments.Format ~= nil and typeof(arg1_7.arguments.Format) == "string" then
			Instance.Bar.Value.Text = arg1_7.arguments.Format
		end
		Instance.TextLabel.Text = arg1_7.arguments.Text or "Progress Bar"
	end
	function tbl.UpdateState(arg1_8) -- Line 108
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local Bar = arg1_8.Instance.Bar
		local Progress = Bar.Progress
		local Value = Bar.Value
		local clamped = math.clamp(arg1_8.state.progress.value, 0, 1)
		if Bar.AbsoluteSize.X * (1 - clamped) < Value.AbsoluteSize.X then
			Value.AnchorPoint = Vector2.xAxis
			Value.Position = UDim2.fromScale(1, 0)
		else
			Value.AnchorPoint = Vector2.zero
			Value.Position = UDim2.new(clamped, 0, 0, 0)
		end
		Progress.Size = UDim2.new(UDim.new(clamped, 0), Progress.Size.Height)
		if arg1_8.arguments.Format ~= nil and typeof(arg1_8.arguments.Format) == "string" then
			Value.Text = arg1_8.arguments.Format
		else
			Value.Text = string.format("%d%%", clamped * 100)
		end
		arg1_8.lastNumberChangedTick = arg1._cycleTick + 1
	end
	function tbl.Discard(arg1_9) -- Line 134
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		arg1_9.Instance:Destroy()
		arg2.discardState(arg1_9)
	end
	arg1.WidgetConstructor("ProgressBar", tbl)
end