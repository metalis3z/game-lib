--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare		Space to handbrake thing v1.4 by VanillaEdge
 													https://www.youtube.com/@vanillaedge
]]

-- Installation: 
-- Shove me in your Plugins folder because I'm a local script.
-- Configure the settings below to suit your wants and needs.

-- Settings:
TOGGLE_JUMP_KEY		= Enum.KeyCode.F 		-- Keyboard
TOGGLE_JUMP_KEY2	= Enum.KeyCode.ButtonY 	-- Controller
HANDBRAKE_KEY		= Enum.KeyCode.Space	-- Keyboard
HANDBRAKE_KEY2		= Enum.KeyCode.ButtonA	-- Controller

-----------------------------------------------------------------------------------

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")

local car = script.Parent.Car.Value :: Model
local driveSeat = car.DriveSeat :: VehicleSeat

local tune = nil
for _, module in car:GetChildren() do
	if not module:IsA("ModuleScript") then continue end
	tune = require(module)
end

-- Functions
local function handleSeat()
	local state = not driveSeat.Occupant
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, state)
end

local function onInputBegan(input: InputObject, gameProcessed: boolean)
	if gameProcessed then return end
	if input.KeyCode == TOGGLE_JUMP_KEY or input.KeyCode == TOGGLE_JUMP_KEY2 then
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
		humanoid.Sit = false
	end
end

-- Connections
UserInputService.InputBegan:Connect(onInputBegan)
driveSeat:GetPropertyChangedSignal("Occupant"):Connect(handleSeat)

-- Initialise
handleSeat()
tune.Controls.PBrake = HANDBRAKE_KEY
tune.Controls.ContlrPBrake = HANDBRAKE_KEY2
