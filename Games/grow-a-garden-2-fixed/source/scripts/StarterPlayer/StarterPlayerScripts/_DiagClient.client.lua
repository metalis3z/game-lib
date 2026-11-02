--credit to prince games studio
-- TEMPORAL: diagnóstico del lado cliente. Bórrame cuando todo funcione.
local function report(label)
	local HttpService = game:GetService("HttpService")
	local p = game.Players.LocalPlayer
	local pg = p:FindFirstChild("PlayerGui")
	local replica
	pcall(function()
		local PlayerStateClient = require(game.ReplicatedStorage.ClientModules.PlayerStateClient)
		replica = PlayerStateClient:GetLocalReplica()
	end)
	local char = p.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	warn(label .. " " .. HttpService:JSONEncode({
		controllersStarted = p:HasTag("ControllersStarted"),
		backpackGui = pg and pg:FindFirstChild("BackpackGui") ~= nil,
		replica = replica and "OK" or "NO LLEGO",
		replicaSheckles = replica and replica.Data.Sheckles or -1,
		plotIdAttr = p:GetAttribute("PlotId"),
		-- cámara / loading
		loadingActive = p:GetAttribute("LoadingScreenActive"),
		loadingDone = p:GetAttribute("LoadingScreenDone"),
		cameraType = tostring(workspace.CurrentCamera.CameraType),
		hrpAnchored = hrp and hrp.Anchored,
		gardenLoadingTotal = p:GetAttribute("GardenLoadingTotal"),
	}))
end

task.delay(20, report, "[DIAG-C20]")
task.delay(45, report, "[DIAG-C45]")