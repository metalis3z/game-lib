-- Reference copy for study. Game: Pet RNG (pet-rng)
-- Original: ReplicatedStorage/Engine/Modules/UiModule.lua  (luau, 101 lines)
-- Categories: ui-animation 20.2
-- What it does: Simple Size-based hover (1.1x) / press (0.8x) module with hover+click sounds, random icon tilt on hover, and keyboard-key press animation.

local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local inputService = game:GetService("UserInputService")
local soundService = game:GetService('SoundService')

local enterMulti = 1.1
local downMulti = 0.8

local InterfaceSounds = soundService:WaitForChild("Main"):WaitForChild('Interface')
local hoverSound = InterfaceSounds:WaitForChild("UiEnter")
local clickSound = InterfaceSounds:WaitForChild("UiClick")
local playSound = game.ReplicatedStorage.Engine.RemotesEvents.PlaySound
local debounce = false

local AnimationModule = {}

local function enter(Button, size, player)
	if Button.Name == "Day5" then
		enterMulti = 1.03
	end
	tweenService:Create(Button, TweenInfo.new(.1), {Size = UDim2.new(size.X.Scale * enterMulti, size.X.Offset, size.Y.Scale * enterMulti, size.Y.Offset)}):Play()
	if runService:IsServer() then
		playSound:FireClient(player, hoverSound)
	else
		hoverSound:Play()
	end
	if Button:FindFirstChild("ImageLabel") then
		tweenService:Create(Button.ImageLabel, TweenInfo.new(.1), {Rotation = math.random(10,25)}):Play()
	end
	enterMulti = 1.1
end
local function leave(Button, size)
	if Button.Name == "Day5" then
		enterMulti = 1.03
	end
	tweenService:Create(Button, TweenInfo.new(.1), {Size = size}):Play()
	if Button:FindFirstChild("ImageLabel") then
		tweenService:Create(Button.ImageLabel, TweenInfo.new(.1), {Rotation = 0}):Play()
	end
	enterMulti = 1.1
end
local function down(Button, size)
	if Button.Name == "Day5" then
		enterMulti = 1.03
	end
	tweenService:Create(Button, TweenInfo.new(.1), {Size = UDim2.new(size.X.Scale * downMulti, size.X.Offset, size.Y.Scale * downMulti, size.Y.Offset)}):Play()
	enterMulti = 1.1
end
local function up(Button, size, player)
	if Button.Name == "Day5" then
		enterMulti = 1.03
	end
	tweenService:Create(Button, TweenInfo.new(.1), {Size = UDim2.new(size.X.Scale * enterMulti, size.X.Offset, size.Y.Scale * enterMulti, size.Y.Offset)}):Play()
	enterMulti = 1.1
	if runService:IsServer() then
		playSound:FireClient(player, clickSound)
	else
		clickSound:Play()
	end
end

AnimationModule.Animate = function(Button, player)
	if Button:IsA("GuiButton") then
		local size = Button.Size
		
		Button.MouseEnter:Connect(function()
			enter(Button, size, player)
		end)
		Button.MouseLeave:Connect(function()
			leave(Button, size)
		end)
		Button.MouseButton1Down:Connect(function()
			down(Button, size)
		end)
		Button.MouseButton1Up:Connect(function()
			up(Button, size, player)
		end)
	end
end
AnimationModule.KeyBoardAnimate = function(Button, key, player)
	if Button:IsA("GuiButton") then
		local size = Button.Size
		inputService.InputBegan:Connect(function(input, processed)
			if Button.Visible == true then
				if input.KeyCode == key then
					down(Button, size)
				end
			end
		end)
		inputService.InputEnded:Connect(function(input, processed)
			if Button.Visible == true then
				if input.KeyCode == key then
					up(Button, size, player)
				end
			end
		end)
	end
end

return AnimationModule
