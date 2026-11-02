-- Client entry point, in place of ReplicatedFirst.Root (obfuscated; it no longer compiles).
--
-- It plays the intro, Root.LoadingScreen (the module survived, its gui was rebuilt as its
-- LoadingScreen child): the Nosniy Games monogram spins in and fills with the loading
-- progress, the device picker shows when the device is ambiguous, the game logo pops before the
-- client starts, and closing it tells the server (Data.LoadingScreenDone), which only then
-- spawns the character. Along the way it fetches the server's constants, records the device,
-- waits for the player's data and requires PlayerScripts.Client (every controller).
--
-- If the loading screen cannot run, the client still starts and the server is still told.

local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

pcall(function()
	ReplicatedFirst:RemoveDefaultLoadingScreen()
end)

local player = Players.LocalPlayer
local playerScripts = player:WaitForChild("PlayerScripts")

-- Seconds each progress step takes to fill in.
local PROGRESS_TWEEN = 0.6

local loadingScreen = nil
local updateConnection = nil
local ok, err = pcall(function()
	loadingScreen = require(ReplicatedFirst:WaitForChild("Root"):WaitForChild("LoadingScreen"))
	loadingScreen:Activate()
	task.spawn(loadingScreen.PlayLogoAnimation, loadingScreen, 1)
	updateConnection = RunService.RenderStepped:Connect(function(dt)
		loadingScreen:Update(dt)
	end)
end)
if not ok then
	warn("[Bootstrap] loading screen unavailable: " .. tostring(err))
	loadingScreen = nil
end

local function progress(fraction: number)
	if loadingScreen then
		pcall(loadingScreen.SetProgress, loadingScreen, fraction, PROGRESS_TWEEN)
	end
end

if not game:IsLoaded() then
	game.Loaded:Wait()
end
progress(0.3)

local Modules = ReplicatedStorage:WaitForChild("Modules")

-- What the player is playing on. Desktop, Mobile or Console, asked on the loading screen when
-- more than one fits (a touch laptop, a controller plugged into a computer); VR from the headset.
local function deviceChoices(): { string }
	if UserInputService.VREnabled then
		return { "VR" }
	end
	if GuiService:IsTenFootInterface() then
		return { "Console" }
	end
	local choices = {}
	if UserInputService.KeyboardEnabled then
		table.insert(choices, "Desktop")
	end
	if UserInputService.GamepadEnabled and UserInputService.KeyboardEnabled then
		table.insert(choices, "Console")
	end
	if UserInputService.TouchEnabled then
		table.insert(choices, "Mobile")
	end
	if #choices == 0 then
		table.insert(choices, "Desktop")
	end
	return choices
end

local CONSTANTS = require(Modules:WaitForChild("CONSTANTS"))
CONSTANTS.INIT()
progress(0.45)

local choices = deviceChoices()
local device = choices[1]
if #choices > 1 and loadingScreen then
	local picked, chosen = pcall(loadingScreen.PickDevice, loadingScreen, choices)
	if picked and chosen then
		device = chosen
	end
end
CONSTANTS.DEVICE = device

-- Several controllers read the player's data as they load, so it has to be here first:
-- PlayerDataController asks for it on require, and everything else waits for the answer.
local dataOk, dataErr = pcall(function()
	local PlayerDataController = require(playerScripts:WaitForChild("Controllers"):WaitForChild("PlayerDataController"))
	PlayerDataController:WaitUntilLoaded()
end)
if not dataOk then
	warn("[Bootstrap] player data failed: " .. tostring(dataErr))
end
progress(0.75)

-- The monogram fills up and splits away; the game logo shows while the controllers load.
progress(1)
if loadingScreen then
	task.wait(PROGRESS_TWEEN)
	pcall(loadingScreen.SplitLogo, loadingScreen)
	pcall(loadingScreen.PreRequireClient, loadingScreen)
end

local clientOk, clientErr = pcall(require, playerScripts:WaitForChild("Client"))
if not clientOk then
	warn("[Bootstrap] client failed to start: " .. tostring(clientErr))
end

-- Whatever happened above, the player still gets a character and a camera on it: without the
-- LoadingScreenDone the server never spawns one and the camera sits at the world origin.
local camera = workspace.CurrentCamera
local function followCharacter(character: Model)
	local humanoid = character:WaitForChild("Humanoid", 10)
	if humanoid then
		camera.CameraType = Enum.CameraType.Custom
		camera.CameraSubject = humanoid
	end
end

player.CharacterAdded:Connect(followCharacter)
if player.Character then
	task.spawn(followCharacter, player.Character)
end

-- Close() fires LoadingScreenDone itself and fades the screen out.
local closed = false
if loadingScreen then
	if updateConnection then
		updateConnection:Disconnect()
	end
	closed = pcall(loadingScreen.Close, loadingScreen)
end
camera.CameraType = Enum.CameraType.Custom
if not closed then
	ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Data"):WaitForChild("LoadingScreenDone"):FireServer()
end
