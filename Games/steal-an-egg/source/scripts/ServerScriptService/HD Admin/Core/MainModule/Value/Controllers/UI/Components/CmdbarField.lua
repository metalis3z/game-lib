--!strict
-- CONFIG
local BAR_HEIGHT = 42


-- LOCAL 
local UserInputService = game:GetService("UserInputService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local Pressable = require(frontend.Components.Pressable)
local Icons = require(frontend.Config.Icons)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	text: Fusion.Value<string>,
	cursorPosition: Fusion.Value<number>,
	focused: Fusion.Value<boolean>,
	boxRef: Fusion.Value<TextBox?>,
	placeholder: UsedAs<string>?,
	onSubmit: () -> (),
	onRun: (() -> ())?,
	onNavigate: (delta: number) -> (),
	onAccept: () -> (),
	onClose: () -> (),
	layoutOrder: UsedAs<number>?,
	active: UsedAs<boolean>?,
	wasDeletion: Fusion.Value<boolean>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local boxFocused = false
	local previousText = "" -- tells typing apart from backspacing
	local box = scope:New "TextBox" {
		Name = "Input",
		LayoutOrder = 2,
		AutoLocalize = false,
		BackgroundTransparency = 1,
		ClearTextOnFocus = false,
		ClipsDescendants = true,
		FontFace = scope:Computed(function(use)
			return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
		end),
		PlaceholderColor3 = Theme.Color.NeutralContentDark,
		PlaceholderText = props.placeholder or "Run a command",
		Text = props.text,
		TextColor3 = Theme.Color.BaseContent,
		TextSize = Theme.TextSize.Subtitle,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		Size = UDim2.fromScale(0, 1),

		[Fusion.OnEvent "Focused"] = function()
			boxFocused = true
			props.focused:set(true)
		end,
		[Fusion.OnEvent "FocusLost"] = function(enterPressed: boolean)
			boxFocused = false
			props.focused:set(false)
			props.cursorPosition:set(-1)
			if enterPressed then
				props.onSubmit()
			end
		end,
		[Fusion.OnChange "Text"] = function(newText: string)
			local cleaned = (newText:gsub("[\r\n]", ""))
			if cleaned ~= newText then
				local currentBox = Fusion.peek(props.boxRef)
				if currentBox then
					currentBox.Text = cleaned
				end
			end
			if props.wasDeletion then
				props.wasDeletion:set(#cleaned < #previousText)
			end
			previousText = cleaned
			props.text:set(cleaned)
		end,
		[Fusion.OnChange "CursorPosition"] = function(position: number)
			props.cursorPosition:set(position)
		end,

		[Children] = {
			scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
		},
	}
	props.boxRef:set(box)

	-- InputController's keybind handler goes silent while any TextBox holds focus
	local keyConnection = UserInputService.InputBegan:Connect(function(input: InputObject)
		-- Checked bar-open not focus, a brief blur can't strand the arrow keys
		local barOpen = props.active ~= nil and Fusion.peek(props.active) == true
		if not (boxFocused or barOpen) then
			return
		end
		local keyCode = input.KeyCode
		if keyCode == Enum.KeyCode.Up then
			props.onNavigate(-1)
		elseif keyCode == Enum.KeyCode.Down then
			props.onNavigate(1)
		elseif keyCode == Enum.KeyCode.Tab then
			props.onAccept()
		elseif keyCode == Enum.KeyCode.Escape then
			props.onClose()
		elseif boxFocused and (keyCode == Enum.KeyCode.Quote or keyCode == Enum.KeyCode.Semicolon) then
			if #Fusion.peek(props.text) <= 1 then
				props.onClose()
			end
		end
	end)
	table.insert(scope, keyConnection)

	return scope:New "Frame" {
		Name = "CmdbarField",
		BackgroundColor3 = Theme.Color.Neutral,
		LayoutOrder = props.layoutOrder,
		Size = UDim2.new(1, 0, 0, BAR_HEIGHT),

		[Children] = {
			scope:New "UICorner" {
				CornerRadius = UDim.new(0, 10),
			},
			scope:New "UIStroke" {
				Color = scope:Spring(scope:Computed(function(use): Color3
					return if use(props.active or props.focused) then use(Theme.Color.Primary) else use(Theme.Color.NeutralStroke)
				end), 40, 1),
				Thickness = 1.5,
			},
			scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 8),
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalFlex = Enum.UIFlexAlignment.None,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 8),
			},

			scope:New "ImageLabel" {
				Name = "Glyph",
				LayoutOrder = 1,
				BackgroundTransparency = 1,
				Image = Icons.TerminalFill,
				ImageColor3 = scope:Computed(function(use): Color3
					return if use(props.active or props.focused) then use(Theme.Color.Primary) else use(Theme.Color.NeutralContentMain)
				end),
				Size = UDim2.fromOffset(20, 20),
			},

			box,

			Pressable(scope, {
				name = "Run",
				layoutOrder = 3,
				size = UDim2.fromOffset(30, 30),
				backgroundColor = Theme.Color.Neutral,
				iconImage = Icons.RunCommand,
				iconColor = Theme.Color.Primary,
				iconSize = 18,
				onActivate = props.onRun or props.onSubmit,
				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 8) },
				},
			}),
		},
	}
end
