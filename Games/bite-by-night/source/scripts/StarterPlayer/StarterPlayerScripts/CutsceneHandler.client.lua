
--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Warp = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Warp"))
local Cutscenes = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Cutscenes"))
local Maid = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Maid"))

local ClientCutscene = Warp.Client("Cutscene")

function lerp(p7, p8, p9)
	return p7 + (p8 - p7) * p9
end

warn('Test')

ClientCutscene:Connect(function(p10, p11, p_u_12, p_u_13, p14, p_u_15)
	warn('Got it.')
	
	if not p_u_12 or p_u_12 == "none" then
		p_u_12 = CFrame.new(0, 0, 0)
	end
	if p14 then
		task.wait(p14)
	end
	game:GetService("Players").LocalPlayer:AddTag("Cutscene")
	local v_u_17 = Cutscenes[p10]
	local newMaid = Maid.new()
	local currentCamera = workspace.CurrentCamera
	local cameraRig = v_u_17.CameraRig:Clone()
	cameraRig.Name = "CameraRig"
	newMaid:Mark(cameraRig)
	cameraRig:PivotTo(p11 * p_u_12)
	cameraRig.Parent = workspace.IGNORE
	cameraRig:FindFirstChild(v_u_17.RootPart)
	local cameraPart = cameraRig:FindFirstChild(v_u_17.CameraPart)
	local cameraAnim = cameraRig:FindFirstChild("AnimationController"):WaitForChild("Animator"):LoadAnimation(v_u_17.Animation)
	cameraAnim:Play(0)
	repeat
		task.wait()
	until cameraAnim.Length > 0
	if p_u_15 then
		task.spawn(function()
			local v23 = task.wait()
			cameraAnim:AdjustSpeed(0)
			task.delay(p_u_15 - v23, function()
				cameraAnim:AdjustSpeed(1)
			end)
		end)
	end
	newMaid:Mark(cameraAnim)
	currentCamera.CameraType = Enum.CameraType.Scriptable
	local v_u_24 = 0.1 - (p_u_15 and (p_u_15 * 60 or 0) or 0)
	game:GetService("TweenService"):Create(currentCamera, TweenInfo.new(0), {
		["FieldOfView"] = v_u_17.FOV[1] or currentCamera.FieldOfView
	}):Play()
	newMaid:Mark((RunService.PreSimulation:Connect(function(p25)
		if p_u_13 and p_u_13 ~= "none" then
			cameraRig:PivotTo(p_u_13.CFrame * p_u_12)
		end
		
		v_u_24 = v_u_24 + p25 * 60
		currentCamera.CFrame = cameraPart.CFrame
		if v_u_17.FOV then
			if v_u_17.FOV[math.ceil(v_u_24)] then
				currentCamera.FieldOfView = v_u_17.FOV[math.ceil(v_u_24)]
			end
		end
	end)))
	task.delay(cameraAnim.Length + (p_u_15 or 0), function()
		currentCamera.CameraType = Enum.CameraType.Custom
		game:GetService("Players").LocalPlayer:RemoveTag("Cutscene")
		newMaid:Sweep()
	end)
end)