local Players = game:GetService("Players")

local LoadingScreenController = {}

-- The loading screen was removed from the game entirely (user request,
-- 2026-07-17): Init destroys any leftover LoadingScreen frame and reports
-- complete immediately. LoadingFinished / IsLoadingComplete stay so any
-- future join-gated code keeps working. The old frame lives in
-- ServerStorage.__LoadingScreenBackup if it's ever wanted back.

local loadingComplete = false

LoadingScreenController.LoadingFinished = Instance.new("BindableEvent")

function LoadingScreenController.IsLoadingComplete(): boolean
	return loadingComplete
end

local function markComplete()
	if loadingComplete then
		return
	end
	loadingComplete = true
	LoadingScreenController.LoadingFinished:Fire()
end

function LoadingScreenController.Init()
	local player = Players.LocalPlayer
	local playerGui = player and player:FindFirstChildOfClass("PlayerGui")
	local gui = playerGui and playerGui:FindFirstChild("GUI")
	local folder = gui and gui:FindFirstChild("Folder")
	local screen = folder and folder:FindFirstChild("LoadingScreen")
	if screen then
		screen:Destroy()
	end
	markComplete()
end

return LoadingScreenController
