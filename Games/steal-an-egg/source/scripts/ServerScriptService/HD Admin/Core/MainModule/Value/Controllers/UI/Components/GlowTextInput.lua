--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local OnChange = Fusion.OnChange
local OnEvent = Fusion.OnEvent
local registerSound = require(modules.AssetUtil.registerSound)
local Navigate = require(frontend.Util.Navigate)


-- SOUNDS
local _focusSound: Sound? = nil
local function ensureFocusSound()
	if _focusSound then return end
	local SoundService = game:GetService("SoundService")
	local folder = SoundService:FindFirstChild("PressableSounds")
		or (function()
			local newFolder = Instance.new("Folder")
			newFolder.Name = "PressableSounds"
			newFolder.Parent = SoundService
			return newFolder
		end)()
	_focusSound = (folder:FindFirstChild("SharedFocus") :: Sound?) or (function()
		local sound = Instance.new("Sound")
		sound.Name = "SharedFocus"
		sound.SoundId = Fusion.peek(Theme.Sound.Focus)
		sound.Volume = 0.2
		sound.RollOffMaxDistance = 0
		sound.Parent = folder
		registerSound(sound, "Interface")
		return sound
	end)()
end


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	name: UsedAs<string>?,
	placeholderText: UsedAs<string>?,
	text: Fusion.Value<string>?,
	textSize: UsedAs<number>?,
	layoutOrder: UsedAs<number>?,
	flexMode: Enum.UIFlexMode?,
	backgroundColor: UsedAs<Color3>?,
	onFocus: (() -> ())?,
	onFocusLost: (() -> ())?,
	clearTextOnFocus: UsedAs<boolean>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local isFocused = scope:Value(false)

	local function clearText()
		if props.text then
			(props.text :: Fusion.Value<string>):set("")
		end
	end

	local strokeColor = scope:Spring(
		scope:Computed(function(use)
			return if use(isFocused) then use(Theme.Color.Primary) else use(Theme.Color.NeutralStroke)
		end),
		40, 1
	)

	local glowTransparency = scope:Spring(
		scope:Computed(function(use)
			return if use(isFocused) then 0.92 else 1
		end),
		40, 1
	)

	ensureFocusSound()

	return scope:New "Frame" {
		Name = props.name or "GlowTextInput",
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = Theme.Color.Neutral,
		BackgroundTransparency = 0,
		LayoutOrder = props.layoutOrder,
		Size = UDim2.new(0, 0, 0, 36),

		[Children] = {
			scope:New "UICorner" {
				CornerRadius = UDim.new(0, 6),
			},
			scope:New "UIPadding" {
				PaddingTop = UDim.new(0, 8),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
			},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = strokeColor,
				Thickness = 1,
			},
			if props.flexMode ~= nil then scope:New "UIFlexItem" { FlexMode = props.flexMode } else nil,

			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.None,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 6),
			},
			scope:New "ImageLabel" {
				Name = "SearchIcon",
				BackgroundTransparency = 1,
				Image = "rbxassetid://101445923461783",
				ImageColor3 = Theme.Color.NeutralContentDark,
				Size = UDim2.fromOffset(16, 16),
				LayoutOrder = 0,
			},
			scope:New "TextBox" {
				Name = "Input",
				AutoLocalize = false,
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				ClearTextOnFocus = props.clearTextOnFocus or false,
				ClipsDescendants = true,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
				end),
				PlaceholderColor3 = Theme.Color.NeutralContentDark,
				PlaceholderText = props.placeholderText or "",
				Text = props.text or "",
				TextColor3 = Theme.Color.BaseContent,
				TextSize = props.textSize or Theme.TextSize.Subtitle,
				TextTransparency = 0,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				LayoutOrder = 1,

				[OnChange("Text")] = function(newText: string)
					if props.text then
						(props.text :: Fusion.Value<string>):set(newText)
					end
				end,
				[OnEvent "Focused"] = function()
					isFocused:set(true)
					if _focusSound then
						_focusSound.TimePosition = 0
						_focusSound:Play()
					end
					if props.onFocus then props.onFocus() end
				end,
				[OnEvent "FocusLost"] = function()
					isFocused:set(false)
					if props.onFocusLost then props.onFocusLost() end
				end,

				[Children] = {
					scope:New "UIFlexItem" {
						FlexMode = Enum.UIFlexMode.Fill,
					},
				},
			},
			Navigate.makeActivatable(scope:New "ImageButton" {
				Name = "ClearButton",
				BackgroundTransparency = 1,
				Image = "rbxassetid://80218226919142",
				ImageColor3 = Theme.Color.NeutralContentDark,
				Size = UDim2.fromOffset(16, 16),
				LayoutOrder = 2,
				Visible = scope:Computed(function(use)
					return #use(props.text or scope:Value("")) > 0
				end),
				[OnEvent "Activated"] = clearText,
			}, clearText),
		},
	}
end
