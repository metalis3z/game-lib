-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:31
-- Luau version 6, Types version 3
-- Time taken: 0.001868 seconds

return function(arg1, arg2) -- Line 3
	local tbl_upvr = {
		hasState = false;
		hasChildren = false;
		Args = {
			Text = 1;
		};
		Events = {
			clicked = arg2.EVENTS.click(function(arg1_2) -- Line 11
				return arg1_2.Instance
			end);
			rightClicked = arg2.EVENTS.rightClick(function(arg1_3) -- Line 14
				return arg1_3.Instance
			end);
			doubleClicked = arg2.EVENTS.doubleClick(function(arg1_4) -- Line 17
				return arg1_4.Instance
			end);
			ctrlClicked = arg2.EVENTS.ctrlClick(function(arg1_5) -- Line 20
				return arg1_5.Instance
			end);
			hovered = arg2.EVENTS.hover(function(arg1_6) -- Line 23
				return arg1_6.Instance
			end);
		};
	}
	local function Generate(arg1_7) -- Line 27
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		local TextButton = Instance.new("TextButton")
		TextButton.Size = UDim2.fromOffset(0, 0)
		TextButton.BackgroundColor3 = arg1._config.ButtonColor
		TextButton.BackgroundTransparency = arg1._config.ButtonTransparency
		TextButton.AutoButtonColor = false
		arg2.applyTextStyle(TextButton)
		TextButton.AutomaticSize = Enum.AutomaticSize.XY
		arg2.applyFrameStyle(TextButton)
		arg2.applyInteractionHighlights(arg1_7, TextButton, TextButton, {
			ButtonColor = arg1._config.ButtonColor;
			ButtonTransparency = arg1._config.ButtonTransparency;
			ButtonHoveredColor = arg1._config.ButtonHoveredColor;
			ButtonHoveredTransparency = arg1._config.ButtonHoveredTransparency;
			ButtonActiveColor = arg1._config.ButtonActiveColor;
			ButtonActiveTransparency = arg1._config.ButtonActiveTransparency;
		})
		TextButton.ZIndex = arg1_7.ZIndex
		TextButton.LayoutOrder = arg1_7.ZIndex
		return TextButton
	end
	tbl_upvr.Generate = Generate
	function tbl_upvr.Update(arg1_8) -- Line 53
		arg1_8.Instance.Text = arg1_8.arguments.Text or "Button"
	end
	function tbl_upvr.Discard(arg1_9) -- Line 57
		arg1_9.Instance:Destroy()
	end
	arg2.abstractButton = tbl_upvr
	local tbl = {}
	local function Generate(arg1_10) -- Line 65
		--[[ Upvalues[1]:
			[1]: tbl_upvr (readonly)
		]]
		local any_Generate_result1 = tbl_upvr.Generate(arg1_10)
		any_Generate_result1.Name = "Button"
		return any_Generate_result1
	end
	tbl.Generate = Generate
	arg1.WidgetConstructor("Button", arg2.extend(tbl_upvr, tbl))
	arg1.WidgetConstructor("SmallButton", arg2.extend(tbl_upvr, {
		Generate = function(arg1_11) -- Line 76, Named "Generate"
			--[[ Upvalues[1]:
				[1]: tbl_upvr (readonly)
			]]
			local any_Generate_result1_2 = tbl_upvr.Generate(arg1_11)
			any_Generate_result1_2.Name = "SmallButton"
			local UIPadding = any_Generate_result1_2.UIPadding
			UIPadding.PaddingLeft = UDim.new(0, 2)
			UIPadding.PaddingRight = UDim.new(0, 2)
			UIPadding.PaddingTop = UDim.new(0, 0)
			UIPadding.PaddingBottom = UDim.new(0, 0)
			return any_Generate_result1_2
		end;
	}))
end