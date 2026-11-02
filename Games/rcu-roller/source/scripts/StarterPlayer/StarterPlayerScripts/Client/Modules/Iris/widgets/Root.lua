-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:41
-- Luau version 6, Types version 3
-- Time taken: 0.002607 seconds

return function(arg1, arg2) -- Line 3
	local var2_upvw = 0
	arg1.WidgetConstructor("Root", {
		hasState = false;
		hasChildren = true;
		Args = {};
		Events = {};
		Generate = function(arg1_2) -- Line 12, Named "Generate"
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: arg2 (readonly)
			]]
			local ScreenGui = Instance.new("ScreenGui")
			ScreenGui.Name = "Root"
			ScreenGui.ResetOnSpawn = false
			if arg1._config.UseScreenGUIs then
				local ScreenGui_2 = Instance.new("ScreenGui")
				ScreenGui_2.ResetOnSpawn = false
				ScreenGui_2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				ScreenGui_2.DisplayOrder = arg1._config.DisplayOrderOffset
				ScreenGui_2.IgnoreGuiInset = arg1._config.IgnoreGuiInset
			else
				local Frame_2 = Instance.new("Frame")
				Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
				Frame_2.Size = UDim2.new(1, 0, 1, 0)
				Frame_2.BackgroundTransparency = 1
				Frame_2.ZIndex = arg1._config.DisplayOrderOffset
			end
			Frame_2.Name = "PseudoWindowScreenGui"
			Frame_2.Parent = ScreenGui
			if arg1._config.UseScreenGUIs then
				local ScreenGui_3 = Instance.new("ScreenGui")
				ScreenGui_3.ResetOnSpawn = false
				ScreenGui_3.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				ScreenGui_3.DisplayOrder = arg1._config.DisplayOrderOffset + 1024
				ScreenGui_3.IgnoreGuiInset = arg1._config.IgnoreGuiInset
			else
				local Frame = Instance.new("Frame")
				Frame.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
				Frame.Size = UDim2.new(1, 0, 1, 0)
				Frame.BackgroundTransparency = 1
				Frame.ZIndex = arg1._config.DisplayOrderOffset + 1024
			end
			Frame.Name = "PopupScreenGui"
			Frame.Parent = ScreenGui
			local Frame_3 = Instance.new("Frame")
			Frame_3.Name = "TooltipContainer"
			Frame_3.AutomaticSize = Enum.AutomaticSize.XY
			Frame_3.Size = UDim2.fromOffset(0, 0)
			Frame_3.BackgroundTransparency = 1
			Frame_3.BorderSizePixel = 0
			arg2.UIListLayout(Frame_3, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.PopupBorderSize))
			Frame_3.Parent = Frame
			local Frame_4 = Instance.new("Frame")
			Frame_4.Name = "MenuBarContainer"
			Frame_4.AutomaticSize = Enum.AutomaticSize.Y
			Frame_4.Size = UDim2.fromScale(1, 0)
			Frame_4.BackgroundTransparency = 1
			Frame_4.BorderSizePixel = 0
			Frame_4.Parent = Frame
			local Frame_5 = Instance.new("Frame")
			Frame_5.Name = "PseudoWindow"
			Frame_5.Size = UDim2.new(0, 0, 0, 0)
			Frame_5.Position = UDim2.fromOffset(0, 22)
			Frame_5.AutomaticSize = Enum.AutomaticSize.XY
			Frame_5.BackgroundTransparency = arg1._config.WindowBgTransparency
			Frame_5.BackgroundColor3 = arg1._config.WindowBgColor
			Frame_5.BorderSizePixel = arg1._config.WindowBorderSize
			Frame_5.BorderColor3 = arg1._config.BorderColor
			Frame_5.Selectable = false
			Frame_5.SelectionGroup = true
			Frame_5.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
			Frame_5.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
			Frame_5.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
			Frame_5.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
			Frame_5.Visible = false
			arg2.UIPadding(Frame_5, arg1._config.WindowPadding)
			arg2.UIListLayout(Frame_5, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.Y))
			Frame_5.Parent = Frame_2
			return ScreenGui
		end;
		Update = function(arg1_3) -- Line 99, Named "Update"
			--[[ Upvalues[1]:
				[1]: var2_upvw (read and write)
			]]
			if 0 < var2_upvw then
				arg1_3.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = true
			end
		end;
		Discard = function(arg1_4) -- Line 107, Named "Discard"
			--[[ Upvalues[1]:
				[1]: var2_upvw (read and write)
			]]
			var2_upvw = 0
			arg1_4.Instance:Destroy()
		end;
		ChildAdded = function(arg1_5, arg2_2) -- Line 111, Named "ChildAdded"
			--[[ Upvalues[1]:
				[1]: var2_upvw (read and write)
			]]
			local Instance = arg1_5.Instance
			if arg2_2.type == "Window" then
				return arg1_5.Instance
			end
			if arg2_2.type == "Tooltip" then
				return Instance.PopupScreenGui.TooltipContainer
			end
			if arg2_2.type == "MenuBar" then
				return Instance.PopupScreenGui.MenuBarContainer
			end
			local PseudoWindow = Instance.PseudoWindowScreenGui.PseudoWindow
			var2_upvw += 1
			PseudoWindow.Visible = true
			return PseudoWindow
		end;
		ChildDiscarded = function(arg1_6, arg2_3) -- Line 130, Named "ChildDiscarded"
			--[[ Upvalues[1]:
				[1]: var2_upvw (read and write)
			]]
			if arg2_3.type ~= "Window" and arg2_3.type ~= "Tooltip" and arg2_3.type ~= "MenuBar" then
				var2_upvw -= 1
				if var2_upvw == 0 then
					arg1_6.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = false
				end
			end
		end;
	})
end