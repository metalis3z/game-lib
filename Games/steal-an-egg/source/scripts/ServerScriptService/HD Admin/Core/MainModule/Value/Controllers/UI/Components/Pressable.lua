--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local Platform = require(frontend.Util.Platform)
local registerSound = require(modules.AssetUtil.registerSound)
local Navigate = require(frontend.Util.Navigate)
local sharedSoundsParent: Instance? = nil
local sharedHoverSound: Sound? = nil
local sharedClickSound: Sound? = nil


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	name: UsedAs<string>?,
	size: UsedAs<UDim2>?,
	position: UsedAs<UDim2>?,
	anchorPoint: UsedAs<Vector2>?,
	backgroundColor: UsedAs<Color3>?,
	backgroundTransparency: UsedAs<number>?,
	automaticSize: UsedAs<Enum.AutomaticSize>?,
	layoutOrder: UsedAs<number>?,
	clipsDescendants: UsedAs<boolean>?,
	visible: UsedAs<boolean>?,
	zIndex: UsedAs<number>?,
	onActivate: UsedAs<(() -> ())>?,
	onHoverChanged: ((isHovered: boolean) -> ())?,
	onPressChanged: ((isPressed: boolean) -> ())?,
	darken: boolean?, -- lerp toward black instead of white
	hoverScale: number?, -- scale on hover via UIScale
	iconImage: UsedAs<string>?,
	iconColor: UsedAs<Color3>?,
	iconSize: UsedAs<number>?,
	iconTransparency: UsedAs<number>?,
	soundHover: UsedAs<string>?,
	soundActivate: UsedAs<string>?,
	interactable: UsedAs<boolean>?,
	[typeof(Children)]: any,
}


-- LOCAL FUNCTIONS
local function ensureSharedSounds()
	if sharedHoverSound then return end
	local SoundService = game:GetService("SoundService")
	local folder = SoundService:FindFirstChild("PressableSounds")
		or (function()
			local newFolder = Instance.new("Folder")
			newFolder.Name = "PressableSounds"
			newFolder.Parent = SoundService
			return newFolder
		end)()
	sharedSoundsParent = folder

	sharedHoverSound = (folder:FindFirstChild("SharedHover") :: Sound?) or (function()
		local sound = Instance.new("Sound")
		sound.Name = "SharedHover"
		sound.SoundId = "rbxassetid://10066936758"
		sound.Volume = 0.1
		sound.RollOffMaxDistance = 0
		sound.Parent = folder
		registerSound(sound, "Interface")
		return sound
	end)()

	sharedClickSound = (folder:FindFirstChild("SharedClick") :: Sound?) or (function()
		local sound = Instance.new("Sound")
		sound.Name = "SharedClick"
		sound.SoundId = "rbxassetid://16480549841"
		sound.Volume = 0.2
		sound.RollOffMaxDistance = 0
		sound.Parent = folder
		registerSound(sound, "Interface")
		return sound
	end)()
end

-- Lerps base toward black/white based on luminance so tint is visible on any theme
local function applyHighlight(use: any, base: Color3, isPressed: any, isHovered: any): Color3
	local luminance = 0.299 * base.R + 0.587 * base.G + 0.114 * base.B
	local tint = if luminance > 0.5 then Color3.new(0, 0, 0) else Color3.new(1, 1, 1)
	if use(isPressed) then
		return base:Lerp(tint, 0.20)
	elseif use(isHovered) then
		return base:Lerp(tint, 0.10)
	end
	return base
end


-- COMPONENT
local function pressable(scope: Scope, props: Props)
	debug.profilebegin("HD_Pressable")
	local hovered: Fusion.Value<boolean> = scope:Value(false)
	local pressed: Fusion.Value<boolean> = scope:Value(false)

	local hasBackground = props.backgroundColor ~= nil
	local darkenProp = props.darken
	local hoverTarget = scope:Computed(function(use)
		local base = if hasBackground
			then use(props.backgroundColor :: any)
			else Color3.new(1, 1, 1)
		local shouldDarken: boolean
		if darkenProp ~= nil then
			shouldDarken = darkenProp == true
		else
			local baseColor = base :: Color3
			local luminance = 0.299 * baseColor.R + 0.587 * baseColor.G + 0.114 * baseColor.B
			shouldDarken = luminance > 0.5
		end
		local target = if shouldDarken then Color3.new(0, 0, 0) else Color3.new(1, 1, 1)
		if use(pressed) then
			return (base :: Color3):Lerp(target, 0.20)
		elseif use(hovered) then
			return (base :: Color3):Lerp(target, 0.10)
		end
		return base
	end)
	local springColor = if Platform.isMobile then hoverTarget else scope:Spring(hoverTarget, 70, 1)

	local iconColorSpring: any = nil
	if props.iconImage ~= nil then
		local iconColorTarget = scope:Computed(function(use)
			local base: Color3 = if props.iconColor then use(props.iconColor :: any) else Color3.new(1, 1, 1)
			if use(pressed) then
				return base:Lerp(Color3.fromRGB(128, 128, 128), 0.4)
			elseif use(hovered) then
				return base:Lerp(Color3.fromRGB(128, 128, 128), 0.2)
			end
			return base
		end)
		iconColorSpring = if Platform.isMobile then iconColorTarget else scope:Spring(iconColorTarget, 70, 1)
	end

	local springScale: any = nil
	if not Platform.isMobile and props.hoverScale ~= nil then
		local hoverScaleTarget = scope:Computed(function(use)
			return if use(hovered) then (props.hoverScale :: number) else 1
		end)
		springScale = scope:Spring(hoverScaleTarget, 70, 1)
	end

	ensureSharedSounds()

	local hoverSound: Sound = sharedHoverSound :: Sound
	local clickSound: Sound = sharedClickSound :: Sound
	local customHoverSound: Sound? = nil
	local customClickSound: Sound? = nil
	if props.soundHover ~= nil then
		customHoverSound = scope:New "Sound" {
			Name = "CustomHoverSound",
			SoundId = props.soundHover,
			Volume = 0.1,
			RollOffMaxDistance = 0,
		} :: Sound
		registerSound(customHoverSound :: Sound, "Interface")
		hoverSound = customHoverSound :: Sound
	end
	if props.soundActivate ~= nil then
		customClickSound = scope:New "Sound" {
			Name = "CustomClickSound",
			SoundId = props.soundActivate,
			Volume = 0.2,
			RollOffMaxDistance = 0,
		} :: Sound
		registerSound(customClickSound :: Sound, "Interface")
		clickSound = customClickSound :: Sound
	end

	local button = scope:New "TextButton" {
		Name = props.name or "Pressable",
		AutoButtonColor = false,
		AutomaticSize = props.automaticSize,
		AnchorPoint = props.anchorPoint,
		BackgroundColor3 = springColor,
		BackgroundTransparency = if hasBackground then props.backgroundTransparency or 0 else 1,
		ClipsDescendants = props.clipsDescendants,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		LayoutOrder = props.layoutOrder,
		Position = props.position,
		Size = props.size or UDim2.fromScale(1, 1),
		Text = "",
		TextColor3 = Color3.new(),
		TextSize = 1,
		Visible = props.visible,
		Interactable = if props.interactable ~= nil then props.interactable else true,
		ZIndex = props.zIndex,

		[Fusion.OnEvent "MouseEnter"] = function()
			hovered:set(true)
			if props.onHoverChanged then props.onHoverChanged(true) end
			if not hoverSound.IsPlaying then
				hoverSound:Play()
			end
		end,
		[Fusion.OnEvent "MouseLeave"] = function()
			hovered:set(false)
			if Fusion.peek(pressed) then
				pressed:set(false)
				if props.onPressChanged then props.onPressChanged(false) end
			end
			if props.onHoverChanged then props.onHoverChanged(false) end
		end,
		[Fusion.OnEvent "MouseButton1Down"] = function()
			pressed:set(true)
			if props.onPressChanged then props.onPressChanged(true) end
		end,
		[Fusion.OnEvent "MouseButton1Up"] = function()
			pressed:set(false)
			if props.onPressChanged then props.onPressChanged(false) end
		end,
		[Fusion.OnEvent "Activated"] = function()
			clickSound:Play()
			local callback = props.onActivate
			if callback then
				local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
				if handler then handler() end
			end
		end,

		[Children] = {
			customHoverSound,
			customClickSound,
			if springScale ~= nil then scope:New "UIScale" { Scale = springScale } else nil,
			if iconColorSpring ~= nil then scope:New "ImageLabel" {
				Name = "Icon",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = props.iconImage,
				ImageColor3 = iconColorSpring,
				ImageTransparency = props.iconTransparency or 0,
				Position = UDim2.fromScale(0.5, 0.5),
				Size = scope:Computed(function(use)
					local size = if props.iconSize then use(props.iconSize :: any) :: number else 20
					return UDim2.fromOffset(size, size)
				end),
			} else nil,
			(props :: any)[Children],
		},
	}

	-- Navigate fires this directly, no mouse simulation
	Navigate.registerActivate(button, function()
		local callback = props.onActivate
		if not callback then return end
		local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
		if handler then handler() end
	end)

	debug.profileend()
	return button
end


return setmetatable({
	applyHighlight = applyHighlight,
}, {
	__call = function(_, scope: Scope, props: Props)
		return pressable(scope, props)
	end,
}) :: any
