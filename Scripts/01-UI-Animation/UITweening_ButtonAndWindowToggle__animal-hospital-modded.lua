-- Reference copy for study. Game: Animal Hospital (modded) (animal-hospital-modded)
-- Original: ReplicatedStorage/Modules/UITweening.lua  (luau, 218 lines)
-- Categories: ui-animation 36.5
-- What it does: Button hover/press size tweens (original size stored as an attribute), keyboard-key press feedback, and a window toggle that grows from 5% with Back-out plus a camera FOV punch.

local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local SoundService      = game:GetService("SoundService")
local Players           = game:GetService("Players")

local ENTER_MULTI = 1.1
local DOWN_MULTI  = 0.8

local InterfaceSounds = SoundService:WaitForChild("SFX")
local HoverSound      = InterfaceSounds:WaitForChild("UiEnter")
local ClickSound      = InterfaceSounds:WaitForChild("UiClick")

local PlaySoundRemote = game.ReplicatedStorage.Remotes:WaitForChild("PlaySound")

local Player = Players.LocalPlayer
local MainUI = Player.PlayerGui:WaitForChild("MainUI")


local AnimationModule = {}

local ToggleDebounce = false

local function getOriginalSize(button: GuiButton): UDim2
	local stored = button:GetAttribute("OriginalSize")
	if stored then
		return stored
	end

	button:SetAttribute("OriginalSize", button.Size)
	return button.Size
end

local function playSound(player: Player, sound: Sound)
	if RunService:IsServer() then
		PlaySoundRemote:FireClient(player, sound)
	else
		sound:Play()
	end
end

local function tweenSize(button: GuiButton, size: UDim2, time: number)
	TweenService:Create(
		button,
		TweenInfo.new(time),
		{ Size = size }
	):Play()
end


local function onEnter(button: GuiButton, player: Player)
	local size = getOriginalSize(button)

	tweenSize(button, UDim2.new(
		size.X.Scale * ENTER_MULTI,
		size.X.Offset,
		size.Y.Scale * ENTER_MULTI,
		size.Y.Offset
		), 0.1)

	playSound(player, HoverSound)
end

local function onLeave(button: GuiButton)
	local size = getOriginalSize(button)
	tweenSize(button, size, 0.1)
end

local function onDown(button: GuiButton)
	local size = getOriginalSize(button)

	tweenSize(button, UDim2.new(
		size.X.Scale * DOWN_MULTI,
		size.X.Offset,
		size.Y.Scale * DOWN_MULTI,
		size.Y.Offset
		), 0.1)
end

local function onUp(button: GuiButton, player: Player)
	local size = getOriginalSize(button)

	tweenSize(button, UDim2.new(
		size.X.Scale * ENTER_MULTI,
		size.X.Offset,
		size.Y.Scale * ENTER_MULTI,
		size.Y.Offset
		), 0.1)

	playSound(player, ClickSound)
end


function AnimationModule.Animate(button: GuiButton, player: Player)
	if not button:IsA("GuiButton") then return end

	getOriginalSize(button)

	local HoverEnabled = true
	local MouseInside = false

	button.MouseEnter:Connect(function()
		MouseInside = true
		if not HoverEnabled then return end
		onEnter(button, player)
	end)

	button.MouseLeave:Connect(function()
		MouseInside = false
		HoverEnabled = true
		onLeave(button)
	end)

	button.MouseButton1Down:Connect(function()
		onDown(button)
	end)

	button.MouseButton1Up:Connect(function()
		onLeave(button)
		HoverEnabled = false
		playSound(player, ClickSound)
	end)
end



function AnimationModule.KeyBoardAnimate(button: GuiButton, key: Enum.KeyCode, player: Player)
	if not button:IsA("GuiButton") then return end

	getOriginalSize(button)

	UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if button.Visible and input.KeyCode == key then
			onDown(button)
		end
	end)

	UserInputService.InputEnded:Connect(function(input, processed)
		if processed then return end
		if button.Visible and input.KeyCode == key then
			onUp(button, player)
		end
	end)
end

function AnimationModule.ToggleFrame(player: Player, frame: Frame)
	if ToggleDebounce then return end
	ToggleDebounce = true

	local camera = workspace.CurrentCamera
	local framesFolder = player.PlayerGui.MainUI.Frames

	if not frame:GetAttribute("OriginalSize") then
		frame:SetAttribute("OriginalSize", frame.Size)
	end

	local ORIGINAL_SIZE: UDim2 = frame:GetAttribute("OriginalSize")

	frame.AnchorPoint = Vector2.new(0.5, 0.5)

	for _, other in ipairs(framesFolder:GetChildren()) do
		if other:IsA("Frame") and other ~= frame and other.Visible then
			if other:GetAttribute("OriginalSize") then
				other.Size = other:GetAttribute("OriginalSize")
			end
			other.Visible = false
		end
	end

	TweenService:Create(frame, TweenInfo.new(0), { Size = frame.Size }):Cancel()

	if not frame.Visible then
		frame.Visible = true
		frame.Position = UDim2.fromScale(0.5, 0.5)
		frame.Size = UDim2.fromScale(0.05, 0.05)

		TweenService:Create(
			camera,
			TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
			{ FieldOfView = 65 }
		):Play()
		
		
		TweenService:Create(
			frame,
			TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{ Size = ORIGINAL_SIZE }
		):Play()


	else
		TweenService:Create(
			frame,
			TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
			{ Size = UDim2.fromScale(0.05, 0.05) }
		):Play()

		TweenService:Create(
			camera,
			TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ FieldOfView = 75 }
		):Play()
		

		task.delay(0.3, function()
			frame.Visible = false
			frame.Size = ORIGINAL_SIZE
		end)
	end

	task.delay(0.4, function()
		ToggleDebounce = false
	end)
end


return AnimationModule