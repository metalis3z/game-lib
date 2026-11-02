--credit to leon games studio
require(script.Parent.Parent.Types)

return function(p1, p2) --[[ Line: 3 ]]
	local v1 = 0

	p1.WidgetConstructor("Root", {
		hasState = false,
		hasChildren = true,
		Args = {},
		Events = {},
		Generate = function(p12) --[[ Generate | Line: 12 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_Root = Instance.new("Folder")

			Iris_Root.Name = "Iris_Root"

			local PseudoWindowScreenGui

			if p1._config.UseScreenGUIs then
				local ScreenGui = Instance.new("ScreenGui")

				ScreenGui.ResetOnSpawn = false
				ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				ScreenGui.ScreenInsets = p1._config.ScreenInsets
				ScreenGui.IgnoreGuiInset = p1._config.IgnoreGuiInset
				ScreenGui.DisplayOrder = p1._config.DisplayOrderOffset
				PseudoWindowScreenGui = ScreenGui
			else
				local Frame = Instance.new("Frame")

				Frame.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame.Position = UDim2.fromScale(0.5, 0.5)
				Frame.Size = UDim2.fromScale(1, 1)
				Frame.BackgroundTransparency = 1
				Frame.ZIndex = p1._config.DisplayOrderOffset
				PseudoWindowScreenGui = Frame
			end

			PseudoWindowScreenGui.Name = "PseudoWindowScreenGui"
			PseudoWindowScreenGui.Parent = Iris_Root

			local PopupScreenGui

			if p1._config.UseScreenGUIs then
				local ScreenGui = Instance.new("ScreenGui")

				ScreenGui.ResetOnSpawn = false
				ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				ScreenGui.DisplayOrder = p1._config.DisplayOrderOffset + 1024
				ScreenGui.ScreenInsets = p1._config.ScreenInsets
				ScreenGui.IgnoreGuiInset = p1._config.IgnoreGuiInset
				PopupScreenGui = ScreenGui
			else
				local Frame = Instance.new("Frame")

				Frame.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame.Position = UDim2.fromScale(0.5, 0.5)
				Frame.Size = UDim2.fromScale(1, 1)
				Frame.BackgroundTransparency = 1
				Frame.ZIndex = p1._config.DisplayOrderOffset + 1024
				PopupScreenGui = Frame
			end

			PopupScreenGui.Name = "PopupScreenGui"
			PopupScreenGui.Parent = Iris_Root

			local TooltipContainer = Instance.new("Frame")

			TooltipContainer.Name = "TooltipContainer"
			TooltipContainer.AutomaticSize = Enum.AutomaticSize.XY
			TooltipContainer.Size = UDim2.fromOffset(0, 0)
			TooltipContainer.BackgroundTransparency = 1
			TooltipContainer.BorderSizePixel = 0
			p2.UIListLayout(TooltipContainer, Enum.FillDirection.Vertical, UDim.new(0, p1._config.PopupBorderSize))
			TooltipContainer.Parent = PopupScreenGui

			local MenuBarContainer = Instance.new("Frame")

			MenuBarContainer.Name = "MenuBarContainer"
			MenuBarContainer.AutomaticSize = Enum.AutomaticSize.Y
			MenuBarContainer.Size = UDim2.fromScale(1, 0)
			MenuBarContainer.BackgroundTransparency = 1
			MenuBarContainer.BorderSizePixel = 0
			MenuBarContainer.Parent = PopupScreenGui

			local PseudoWindow = Instance.new("Frame")

			PseudoWindow.Name = "PseudoWindow"
			PseudoWindow.AutomaticSize = Enum.AutomaticSize.XY
			PseudoWindow.Size = UDim2.new(0, 0, 0, 0)
			PseudoWindow.Position = UDim2.fromOffset(0, 22)
			PseudoWindow.BackgroundTransparency = p1._config.WindowBgTransparency
			PseudoWindow.BackgroundColor3 = p1._config.WindowBgColor
			PseudoWindow.BorderSizePixel = p1._config.WindowBorderSize
			PseudoWindow.BorderColor3 = p1._config.BorderColor
			PseudoWindow.Selectable = false
			PseudoWindow.SelectionGroup = true
			PseudoWindow.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
			PseudoWindow.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
			PseudoWindow.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
			PseudoWindow.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
			PseudoWindow.Visible = false
			p2.UIPadding(PseudoWindow, p1._config.WindowPadding)
			p2.UIListLayout(PseudoWindow, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y))
			PseudoWindow.Parent = PseudoWindowScreenGui

			return Iris_Root
		end,
		Update = function(p1) --[[ Update | Line: 100 | Upvalues: v1 (ref) ]]
			if not (v1 > 0) then
				return
			end

			p1.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = true
		end,
		Discard = function(p1) --[[ Discard | Line: 108 | Upvalues: v1 (ref) ]]
			v1 = 0
			p1.Instance:Destroy()
		end,
		ChildAdded = function(p1, p2) --[[ ChildAdded | Line: 112 | Upvalues: v1 (ref) ]]
			local v12 = p1.Instance

			if p2.type == "Window" then
				return p1.Instance
			end

			if p2.type == "Tooltip" then
				return v12.PopupScreenGui.TooltipContainer
			end

			if p2.type == "MenuBar" then
				return v12.PopupScreenGui.MenuBarContainer
			end

			local PseudoWindow = v12.PseudoWindowScreenGui.PseudoWindow

			v1 = v1 + 1
			PseudoWindow.Visible = true

			return PseudoWindow
		end,
		ChildDiscarded = function(p1, p2) --[[ ChildDiscarded | Line: 131 | Upvalues: v1 (ref) ]]
			if p2.type == "Window" or (p2.type == "Tooltip" or p2.type == "MenuBar") then
				return
			end

			v1 = v1 - 1

			if v1 ~= 0 then
				return
			end

			p1.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = false
		end
	})
end