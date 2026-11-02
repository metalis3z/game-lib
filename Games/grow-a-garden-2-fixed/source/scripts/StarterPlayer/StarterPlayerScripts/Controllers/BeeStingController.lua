--credit to prince games studio
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local t = {}
local v1 = false
local v2 = 0
local v3 = 0
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = (-1 / 0)
local v9 = 0
local v10 = 0
local v11 = nil

local function getControls() --[[ getControls | Line: 94 | Upvalues: v11 (ref), LocalPlayer (copy) ]]
	if v11 then
		return v11
	end

	local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")

	if not PlayerScripts then
		return nil
	end

	local PlayerModule = PlayerScripts:FindFirstChild("PlayerModule")

	if not PlayerModule then
		return nil
	end

	local ok, result = pcall(function() --[[ Line: 100 | Upvalues: PlayerModule (copy) ]]
		return require(PlayerModule)
	end)

	if not (ok and result) then
		return nil
	end

	local ok2, result2 = pcall(function() --[[ Line: 104 | Upvalues: result (copy) ]]
		return result:GetControls()
	end)

	if ok2 and result2 then
		v11 = result2

		return result2
	end

	return nil
end

local v12 = nil
local v13 = nil
local v14 = false

local function getCameraInput() --[[ getCameraInput | Line: 123 | Upvalues: v12 (ref), LocalPlayer (copy) ]]
	if v12 then
		return v12
	end

	local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")

	if not PlayerScripts then
		return nil
	end

	local PlayerModule = PlayerScripts:FindFirstChild("PlayerModule")

	if not PlayerModule then
		return nil
	end

	local CameraModule = PlayerModule:FindFirstChild("CameraModule")

	if not CameraModule then
		return nil
	end

	local CameraInput = CameraModule:FindFirstChild("CameraInput")

	if not CameraInput then
		return nil
	end

	local ok, result = pcall(function() --[[ Line: 133 | Upvalues: CameraInput (copy) ]]
		return require(CameraInput)
	end)

	if ok and result then
		v12 = result

		return result
	end

	return nil
end

local function buildGui() --[[ buildGui | Line: 141 | Upvalues: LocalPlayer (copy), Lighting (copy), v5 (ref), v6 (ref), v7 (ref) ]]
	local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

	if PlayerGui then
		local BeeStingScreenEffect = Instance.new("ScreenGui")

		BeeStingScreenEffect.Name = "BeeStingScreenEffect"
		BeeStingScreenEffect.IgnoreGuiInset = true
		BeeStingScreenEffect.ResetOnSpawn = false
		BeeStingScreenEffect.DisplayOrder = 1000
		BeeStingScreenEffect.Parent = PlayerGui

		local RedFlash = Instance.new("Frame")

		RedFlash.Name = "RedFlash"
		RedFlash.Size = UDim2.fromScale(1, 1)
		RedFlash.BackgroundColor3 = Color3.fromRGB(255, 55, 55)
		RedFlash.BackgroundTransparency = 1
		RedFlash.BorderSizePixel = 0
		RedFlash.ZIndex = 10
		RedFlash.Parent = BeeStingScreenEffect

		local BeeStingBlur = Instance.new("BlurEffect")

		BeeStingBlur.Name = "BeeStingBlur"
		BeeStingBlur.Size = 1
		BeeStingBlur.Enabled = true
		BeeStingBlur.Parent = Lighting
		v5 = BeeStingScreenEffect
		v6 = RedFlash
		v7 = BeeStingBlur
	end
end

local function teardownGui() --[[ teardownGui | Line: 174 | Upvalues: v5 (ref), v6 (ref), v7 (ref) ]]
	if v5 then
		v5:Destroy()
		v5 = nil
		v6 = nil
	end

	if not v7 then
		return
	end

	v7:Destroy()
	v7 = nil
end

local function smoothResetCamera() --[[ smoothResetCamera | Line: 186 | Upvalues: LocalPlayer (copy), TweenService (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if Humanoid then
		TweenService:Create(Humanoid, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CameraOffset = Vector3.new(0, 0, 0)
		}):Play()
	end
end

local function startInversion() --[[ startInversion | Line: 202 | Upvalues: RunService (copy), getControls (copy), LocalPlayer (copy) ]]
	RunService:BindToRenderStep("BeeStingInvertMovement", Enum.RenderPriority.Input.Value + 1, function() --[[ Line: 203 | Upvalues: getControls (ref), LocalPlayer (ref) ]]
		local v1 = getControls()

		if not v1 then
			return
		end

		local Character = LocalPlayer.Character
		local v2 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

		if v2 then
			v2:Move(-v1:GetMoveVector(), true)
		end
	end)
end

local function stopInversion() --[[ stopInversion | Line: 216 | Upvalues: RunService (copy) ]]
	pcall(function() --[[ Line: 217 | Upvalues: RunService (ref) ]]
		RunService:UnbindFromRenderStep("BeeStingInvertMovement")
	end)
end

local function startCameraInversion() --[[ startCameraInversion | Line: 226 | Upvalues: v14 (ref), getCameraInput (copy), v13 (ref) ]]
	if v14 then
		return
	end

	local v1 = getCameraInput()

	if not v1 then
		return
	end

	if typeof(v1.getRotation) == "function" then
		pcall(function() --[[ Line: 232 | Upvalues: v13 (ref), v1 (copy) ]]
			v13 = v1.getRotation
			function v1.getRotation(...) --[[ Line: 234 | Upvalues: v13 (ref) ]]
				local v1 = v13(...)

				if typeof(v1) == "Vector2" then
					return -v1
				end

				return v1
			end
		end)
		v14 = true
	end
end

local function stopCameraInversion() --[[ stopCameraInversion | Line: 245 | Upvalues: v13 (ref), v12 (ref), v14 (ref) ]]
	if not (v13 and v12) then
		v13 = nil
		v14 = false

		return
	end

	pcall(function() --[[ Line: 247 | Upvalues: v12 (ref), v13 (ref) ]]
		v12.getRotation = v13
	end)
	v13 = nil
	v14 = false
end

local function stop() --[[ stop | Line: 255 | Upvalues: v1 (ref), v4 (ref), RunService (copy), v13 (ref), v12 (ref), v14 (ref), smoothResetCamera (copy), v5 (ref), v6 (ref), v7 (ref) ]]
	if not v1 then
		return
	end

	v1 = false

	if v4 then
		v4:Disconnect()
		v4 = nil
	end

	pcall(function() --[[ Line: 217 | Upvalues: RunService (ref) ]]
		RunService:UnbindFromRenderStep("BeeStingInvertMovement")
	end)

	if v13 and v12 then
		pcall(function() --[[ Line: 247 | Upvalues: v12 (ref), v13 (ref) ]]
			v12.getRotation = v13
		end)
	end

	v13 = nil
	v14 = false
	smoothResetCamera()

	if v5 then
		v5:Destroy()
		v5 = nil
		v6 = nil
	end

	if not v7 then
		return
	end

	v7:Destroy()
	v7 = nil
end

local function start() --[[ start | Line: 270 | Upvalues: v5 (ref), v6 (ref), v7 (ref), buildGui (copy), v1 (ref), v2 (ref), RunService (copy), getControls (copy), LocalPlayer (copy), v14 (ref), getCameraInput (copy), v13 (ref), v4 (ref), v3 (ref), v12 (ref), smoothResetCamera (copy), v8 (ref), v9 (ref), v10 (ref) ]]
	if v5 then
		v5:Destroy()
		v5 = nil
		v6 = nil
	end

	if v7 then
		v7:Destroy()
		v7 = nil
	end

	buildGui()

	if not v6 then
		return
	end

	v1 = true
	v2 = tick()
	RunService:BindToRenderStep("BeeStingInvertMovement", Enum.RenderPriority.Input.Value + 1, function() --[[ Line: 203 | Upvalues: getControls (ref), LocalPlayer (ref) ]]
		local v1 = getControls()

		if not v1 then
			return
		end

		local Character = LocalPlayer.Character
		local v2 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

		if v2 then
			v2:Move(-v1:GetMoveVector(), true)
		end
	end)

	if v14 then
		v4 = RunService.RenderStepped:Connect(function() --[[ Line: 285 | Upvalues: v3 (ref), v1 (ref), v4 (ref), RunService (ref), v13 (ref), v12 (ref), v14 (ref), smoothResetCamera (ref), v5 (ref), v6 (ref), v7 (ref), LocalPlayer (ref), v2 (ref), v8 (ref), v9 (ref), v10 (ref) ]]
			local v15 = tick()

			if v3 <= v15 then
				if not v1 then
					return
				end

				v1 = false

				if v4 then
					v4:Disconnect()
					v4 = nil
				end

				pcall(function() --[[ Line: 217 | Upvalues: RunService (ref) ]]
					RunService:UnbindFromRenderStep("BeeStingInvertMovement")
				end)

				if v13 and v12 then
					pcall(function() --[[ Line: 247 | Upvalues: v12 (ref), v13 (ref) ]]
						v12.getRotation = v13
					end)
				end

				v13 = nil
				v14 = false
				smoothResetCamera()

				if v5 then
					v5:Destroy()
					v5 = nil
					v6 = nil
				end

				if not v7 then
					return
				end

				v7:Destroy()
				v7 = nil
			else
				local Character = LocalPlayer.Character
				local v22 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

				if v22 then
					local v32 = v15 - v2
					local sum2 = math.sin(v32 * 4) * 1.65 + math.sin(v32 * 7.3) * 0.49499999999999994
					local sum22 = math.cos(v32 * 5.2) * 1.35 + math.sin(v32 * 9.1) * 0.3375
					local v42 = v15 - v8

					if v42 >= 0 and v42 < 0.35 then
						local v52 = (1 - v42 / 0.35) ^ 3

						sum2 = sum2 + v9 * 3 * v52
						sum22 = sum22 + v10 * 3 * v52
					end

					v22.CameraOffset = Vector3.new(sum2, sum22, 0)
				end

				local v82 = math.max(0, (math.sin((v15 - v2) * 2.5)))
				local v92 = 0.8 - v82 * 0.2
				local v102 = v15 - v8
				local v11 = if v102 >= 0 and v102 < 0.28 then 0.05 + 0.95 * (v102 / 0.28) else 1

				if v6 then
					v6.BackgroundTransparency = math.min(v92, v11)
				end

				if not v7 then
					return
				end

				v7.Size = v82 * 4 + 1
			end
		end)

		return
	end

	local v15 = getCameraInput()

	if not v15 then
		v4 = RunService.RenderStepped:Connect(function() --[[ Line: 285 | Upvalues: v3 (ref), v1 (ref), v4 (ref), RunService (ref), v13 (ref), v12 (ref), v14 (ref), smoothResetCamera (ref), v5 (ref), v6 (ref), v7 (ref), LocalPlayer (ref), v2 (ref), v8 (ref), v9 (ref), v10 (ref) ]]
			local v15 = tick()

			if v3 <= v15 then
				if not v1 then
					return
				end

				v1 = false

				if v4 then
					v4:Disconnect()
					v4 = nil
				end

				pcall(function() --[[ Line: 217 | Upvalues: RunService (ref) ]]
					RunService:UnbindFromRenderStep("BeeStingInvertMovement")
				end)

				if v13 and v12 then
					pcall(function() --[[ Line: 247 | Upvalues: v12 (ref), v13 (ref) ]]
						v12.getRotation = v13
					end)
				end

				v13 = nil
				v14 = false
				smoothResetCamera()

				if v5 then
					v5:Destroy()
					v5 = nil
					v6 = nil
				end

				if not v7 then
					return
				end

				v7:Destroy()
				v7 = nil
			else
				local Character = LocalPlayer.Character
				local v22 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

				if v22 then
					local v32 = v15 - v2
					local sum2 = math.sin(v32 * 4) * 1.65 + math.sin(v32 * 7.3) * 0.49499999999999994
					local sum22 = math.cos(v32 * 5.2) * 1.35 + math.sin(v32 * 9.1) * 0.3375
					local v42 = v15 - v8

					if v42 >= 0 and v42 < 0.35 then
						local v52 = (1 - v42 / 0.35) ^ 3

						sum2 = sum2 + v9 * 3 * v52
						sum22 = sum22 + v10 * 3 * v52
					end

					v22.CameraOffset = Vector3.new(sum2, sum22, 0)
				end

				local v82 = math.max(0, (math.sin((v15 - v2) * 2.5)))
				local v92 = 0.8 - v82 * 0.2
				local v102 = v15 - v8
				local v11 = if v102 >= 0 and v102 < 0.28 then 0.05 + 0.95 * (v102 / 0.28) else 1

				if v6 then
					v6.BackgroundTransparency = math.min(v92, v11)
				end

				if not v7 then
					return
				end

				v7.Size = v82 * 4 + 1
			end
		end)

		return
	end

	if typeof(v15.getRotation) ~= "function" then
		v4 = RunService.RenderStepped:Connect(function() --[[ Line: 285 | Upvalues: v3 (ref), v1 (ref), v4 (ref), RunService (ref), v13 (ref), v12 (ref), v14 (ref), smoothResetCamera (ref), v5 (ref), v6 (ref), v7 (ref), LocalPlayer (ref), v2 (ref), v8 (ref), v9 (ref), v10 (ref) ]]
			local v15 = tick()

			if v3 <= v15 then
				if not v1 then
					return
				end

				v1 = false

				if v4 then
					v4:Disconnect()
					v4 = nil
				end

				pcall(function() --[[ Line: 217 | Upvalues: RunService (ref) ]]
					RunService:UnbindFromRenderStep("BeeStingInvertMovement")
				end)

				if v13 and v12 then
					pcall(function() --[[ Line: 247 | Upvalues: v12 (ref), v13 (ref) ]]
						v12.getRotation = v13
					end)
				end

				v13 = nil
				v14 = false
				smoothResetCamera()

				if v5 then
					v5:Destroy()
					v5 = nil
					v6 = nil
				end

				if not v7 then
					return
				end

				v7:Destroy()
				v7 = nil
			else
				local Character = LocalPlayer.Character
				local v22 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

				if v22 then
					local v32 = v15 - v2
					local sum2 = math.sin(v32 * 4) * 1.65 + math.sin(v32 * 7.3) * 0.49499999999999994
					local sum22 = math.cos(v32 * 5.2) * 1.35 + math.sin(v32 * 9.1) * 0.3375
					local v42 = v15 - v8

					if v42 >= 0 and v42 < 0.35 then
						local v52 = (1 - v42 / 0.35) ^ 3

						sum2 = sum2 + v9 * 3 * v52
						sum22 = sum22 + v10 * 3 * v52
					end

					v22.CameraOffset = Vector3.new(sum2, sum22, 0)
				end

				local v82 = math.max(0, (math.sin((v15 - v2) * 2.5)))
				local v92 = 0.8 - v82 * 0.2
				local v102 = v15 - v8
				local v11 = if v102 >= 0 and v102 < 0.28 then 0.05 + 0.95 * (v102 / 0.28) else 1

				if v6 then
					v6.BackgroundTransparency = math.min(v92, v11)
				end

				if not v7 then
					return
				end

				v7.Size = v82 * 4 + 1
			end
		end)

		return
	end

	pcall(function() --[[ Line: 232 | Upvalues: v13 (ref), v15 (copy) ]]
		v13 = v15.getRotation
		function v15.getRotation(...) --[[ Line: 234 | Upvalues: v13 (ref) ]]
			local v1 = v13(...)

			if typeof(v1) == "Vector2" then
				return -v1
			end

			return v1
		end
	end)
	v14 = true
	v4 = RunService.RenderStepped:Connect(function() --[[ Line: 285 | Upvalues: v3 (ref), v1 (ref), v4 (ref), RunService (ref), v13 (ref), v12 (ref), v14 (ref), smoothResetCamera (ref), v5 (ref), v6 (ref), v7 (ref), LocalPlayer (ref), v2 (ref), v8 (ref), v9 (ref), v10 (ref) ]]
		local v15 = tick()

		if v3 <= v15 then
			if not v1 then
				return
			end

			v1 = false

			if v4 then
				v4:Disconnect()
				v4 = nil
			end

			pcall(function() --[[ Line: 217 | Upvalues: RunService (ref) ]]
				RunService:UnbindFromRenderStep("BeeStingInvertMovement")
			end)

			if v13 and v12 then
				pcall(function() --[[ Line: 247 | Upvalues: v12 (ref), v13 (ref) ]]
					v12.getRotation = v13
				end)
			end

			v13 = nil
			v14 = false
			smoothResetCamera()

			if v5 then
				v5:Destroy()
				v5 = nil
				v6 = nil
			end

			if not v7 then
				return
			end

			v7:Destroy()
			v7 = nil
		else
			local Character = LocalPlayer.Character
			local v22 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

			if v22 then
				local v32 = v15 - v2
				local sum2 = math.sin(v32 * 4) * 1.65 + math.sin(v32 * 7.3) * 0.49499999999999994
				local sum22 = math.cos(v32 * 5.2) * 1.35 + math.sin(v32 * 9.1) * 0.3375
				local v42 = v15 - v8

				if v42 >= 0 and v42 < 0.35 then
					local v52 = (1 - v42 / 0.35) ^ 3

					sum2 = sum2 + v9 * 3 * v52
					sum22 = sum22 + v10 * 3 * v52
				end

				v22.CameraOffset = Vector3.new(sum2, sum22, 0)
			end

			local v82 = math.max(0, (math.sin((v15 - v2) * 2.5)))
			local v92 = 0.8 - v82 * 0.2
			local v102 = v15 - v8
			local v11 = if v102 >= 0 and v102 < 0.28 then 0.05 + 0.95 * (v102 / 0.28) else 1

			if v6 then
				v6.BackgroundTransparency = math.min(v92, v11)
			end

			if not v7 then
				return
			end

			v7.Size = v82 * 4 + 1
		end
	end)
end

local function onSting(p1) --[[ onSting | Line: 348 | Upvalues: v8 (ref), v9 (ref), v10 (ref), v1 (ref), v3 (ref), start (copy) ]]
	local v12 = tick()

	v8 = v12

	local v2 = math.random() * math.pi * 2

	v9 = math.cos(v2)
	v10 = math.sin(v2)
	v3 = v12 + (if typeof(p1) == "number" and p1 > 0 then p1 else 3.5)

	if v1 then
	else
		start()
	end
end

function t.Init(p1) --[[ Init | Line: 379 | Upvalues: Networking (copy), onSting (copy) ]]
	Networking.Bee.Sting.OnClientEvent:Connect(onSting)
end

return t