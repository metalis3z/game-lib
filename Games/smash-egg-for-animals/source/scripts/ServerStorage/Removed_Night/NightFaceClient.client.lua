-- La nuit, NightServer pose les joueurs en rangs devant le mur. Ici : plan fixe sur l'écran du mur (compte à rebours),
-- pris de derrière les joueurs, pendant le compte à rebours. Dès que le joueur bouge, il reprend sa caméra
-- (tournée vers le mur).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local SHOT_TIME = 10   -- durée du plan fixe au plus (le compte à rebours du mur)
local SHOT_BACK = 80   -- recul de la caméra par rapport au mur
local token = 0
ReplicatedStorage:WaitForChild("NightFace").OnClientEvent:Connect(function(target)
	if typeof(target) ~= "Vector3" then return end
	token += 1
	local mine = token
	local camera = workspace.CurrentCamera
	-- une cinématique (intro...) tient la caméra : on attend qu'elle la rende (4 s au plus)
	local waitUntil = os.clock() + 4
	while camera.CameraType ~= Enum.CameraType.Custom and os.clock() < waitUntil do task.wait(0.1) end
	if mine ~= token or camera.CameraType ~= Enum.CameraType.Custom then return end
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not root then return end
	local flat = Vector3.new(target.X - root.Position.X, 0, target.Z - root.Position.Z)
	local dir = flat.Magnitude > 0.1 and flat.Unit or Vector3.new(1, 0, 0)
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CFrame = CFrame.lookAt(target - dir * SHOT_BACK + Vector3.new(0, 4, 0), target)
	local stop = os.clock() + SHOT_TIME
	while os.clock() < stop and mine == token do
		if humanoid and humanoid.MoveDirection.Magnitude > 0.1 then break end -- il bouge : on lui rend la caméra
		task.wait(0.1)
	end
	if mine ~= token or camera.CameraType ~= Enum.CameraType.Scriptable then return end
	-- caméra rendue, derrière le joueur et tournée vers le mur
	root = character and character:FindFirstChild("HumanoidRootPart")
	if root then camera.CFrame = CFrame.lookAt(root.Position - dir * 12 + Vector3.new(0, 5, 0), root.Position + dir * 30 + Vector3.new(0, 3, 0)) end
	camera.CameraType = Enum.CameraType.Custom
end)
