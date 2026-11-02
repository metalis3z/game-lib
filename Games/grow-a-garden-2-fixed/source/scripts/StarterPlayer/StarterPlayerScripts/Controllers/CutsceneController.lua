--credit to quartz games studio
local t = {}
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local v1 = false
local t2 = {}
local t3 = {}
local t4 = {}

function lerp(p1, p2, p3) --[[ lerp | Line: 18 ]]
	return p1 + (p2 - p1) * p3
end

local function CleanupScene() --[[ CleanupScene | Line: 22 | Upvalues: t3 (ref), t4 (ref) ]]
	for v1, v2 in t3 do
		v2:Destroy()
	end

	t3 = {}

	for v3, v4 in t4 do
		v3.Enabled = v4
	end

	t4 = {}
end

function t.Play(p1) --[[ PlayCutscene | Line: 37 | Upvalues: ContentProvider (copy), CleanupScene (copy), t3 (ref), LocalPlayer (copy), t4 (ref), t2 (copy), v1 (ref), RunService (copy) ]]
	local Animations = require(p1.Animations)
	local Markers = require(p1.Markers)
	local FoV = require(p1.FoV)
	local t = {}
	local t5 = {}

	for v12, v2 in Animations do
		if p1.Rigs:FindFirstChild(v12) then
			local Animation = Instance.new("Animation")

			Animation.AnimationId = v2
			t[v12] = Animation
			table.insert(t5, Animation)
		end
	end

	ContentProvider:PreloadAsync(t5)

	repeat
		task.wait(0.25)
	until ContentProvider.RequestQueueSize == 0

	CleanupScene()
	table.insert(t3, p1)

	for v4, v5 in LocalPlayer.PlayerGui:GetChildren() do
		if v5:IsA("ScreenGui") or v5:IsA("BillboardGui") then
			t4[v5] = v5.Enabled
			v5.Enabled = false
		end
	end

	for v6, v7 in t do
		local v8 = p1.Rigs:FindFirstChild(v6)

		if v8 then
			local v9 = v8:FindFirstChildOfClass("AnimationController") or v8:FindFirstChildOfClass("Humanoid")

			if v9 then
				t2[v6] = v9:LoadAnimation(v7)

				if v6 == "Camera" then
					for v10, v11 in Markers do
						t2.Camera:GetMarkerReachedSignal(v10):Connect(function() --[[ Line: 94 | Upvalues: v11 (copy), p1 (copy), t2 (ref) ]]
							v11(p1, t2)
						end)
					end
				end
			end
		end
	end

	local function EndCutscene() --[[ EndCutscene | Line: 102 | Upvalues: v1 (ref), Markers (copy), p1 (copy), t2 (ref), CleanupScene (ref) ]]
		if v1 then
			Markers.EndState(p1)
		end

		v1 = false

		for v12, v2 in t2 do
			v2:Stop(0)
			v2:Destroy()
		end

		CleanupScene()
	end

	t2.Camera.Stopped:Once(EndCutscene)

	for v12, v13 in t2 do
		v13.Looped = false
		v13.Priority = Enum.AnimationPriority.Action4
		v13:Play(0)
	end

	v1 = true

	local DefaultCamera = p1.DefaultCamera.Value
	local CurrentCamera = workspace.CurrentCamera

	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	CurrentCamera.CameraSubject = DefaultCamera

	local v14 = 0
	local v15, v16

	if not LocalPlayer.Character then
		game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
		v15 = function() --[[ ResetCamera | Line: 141 | Upvalues: RunService (ref), LocalPlayer (ref), CurrentCamera (copy) ]]
			RunService:UnbindFromRenderStep("Cutscene_Track")
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
			game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)

			if not LocalPlayer.Character then
				CurrentCamera.CameraType = Enum.CameraType.Custom
				CurrentCamera.FieldOfView = 70
				CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid

				return
			end

			LocalPlayer.Character.Humanoid.AutoRotate = true
			CurrentCamera.CameraType = Enum.CameraType.Custom
			CurrentCamera.FieldOfView = 70
			CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
		end
		v16 = FoV[1]
		CurrentCamera.FieldOfView = v16
		RunService:BindToRenderStep("Cutscene_Track", Enum.RenderPriority.Camera.Value - 1, function(p13) --[[ Line: 158 | Upvalues: v1 (ref), v15 (copy), CurrentCamera (copy), DefaultCamera (copy), v14 (ref), FoV (copy), v16 (ref) ]]
			if not v1 then
				return v15()
			end

			CurrentCamera.CFrame = DefaultCamera.CFrame
			CurrentCamera.Focus = CurrentCamera.CFrame * CFrame.new(0, 0, -5)
			v14 = v14 + p13 * 24

			if not FoV[math.ceil(v14)] then
				return
			end

			if not (math.ceil(v14) < #FoV) then
				return
			end

			local v4 = FoV[math.ceil(v14)]

			CurrentCamera.FieldOfView = v16
			v16 = lerp(v16, v4, p13 * 11)
		end)
		task.spawn(function() --[[ Line: 177 | Upvalues: v1 (ref), CleanupScene (ref) ]]
			repeat
				task.wait(0.025)
			until v1 == false

			CleanupScene()
		end)

		return
	end

	LocalPlayer.Character.Humanoid.AutoRotate = false
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	v15 = function() --[[ ResetCamera | Line: 141 | Upvalues: RunService (ref), LocalPlayer (ref), CurrentCamera (copy) ]]
		RunService:UnbindFromRenderStep("Cutscene_Track")
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)

		if not LocalPlayer.Character then
			CurrentCamera.CameraType = Enum.CameraType.Custom
			CurrentCamera.FieldOfView = 70
			CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid

			return
		end

		LocalPlayer.Character.Humanoid.AutoRotate = true
		CurrentCamera.CameraType = Enum.CameraType.Custom
		CurrentCamera.FieldOfView = 70
		CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
	end
	v16 = FoV[1]
	CurrentCamera.FieldOfView = v16
	RunService:BindToRenderStep("Cutscene_Track", Enum.RenderPriority.Camera.Value - 1, function(p13) --[[ Line: 158 | Upvalues: v1 (ref), v15 (copy), CurrentCamera (copy), DefaultCamera (copy), v14 (ref), FoV (copy), v16 (ref) ]]
		if not v1 then
			return v15()
		end

		CurrentCamera.CFrame = DefaultCamera.CFrame
		CurrentCamera.Focus = CurrentCamera.CFrame * CFrame.new(0, 0, -5)
		v14 = v14 + p13 * 24

		if not FoV[math.ceil(v14)] then
			return
		end

		if not (math.ceil(v14) < #FoV) then
			return
		end

		local v4 = FoV[math.ceil(v14)]

		CurrentCamera.FieldOfView = v16
		v16 = lerp(v16, v4, p13 * 11)
	end)
	task.spawn(function() --[[ Line: 177 | Upvalues: v1 (ref), CleanupScene (ref) ]]
		repeat
			task.wait(0.025)
		until v1 == false

		CleanupScene()
	end)
end
function t.Preload(p1, p2) --[[ Preload | Line: 187 | Upvalues: ContentProvider (copy) ]]
	local t = {}

	for v1, v2 in require(p1.Animations) do
		if p1.Rigs:FindFirstChild(v1) then
			local Animation = Instance.new("Animation")

			Animation.AnimationId = v2
			table.insert(t, Animation)
		end
	end

	for v3, v4 in p1:GetDescendants() do
		if v4:HasTag("Preload") then
			table.insert(t, v4)
		end
	end

	task.spawn(function() --[[ Line: 207 | Upvalues: t (copy), p2 (copy), ContentProvider (ref) ]]
		for i = 1, #t do
			ContentProvider:PreloadAsync({ t[i] })
			task.wait(p2 / #t + Random.new():NextNumber())
		end
	end)
end
function t.IsPlaying() --[[ IsPlaying | Line: 216 | Upvalues: v1 (ref) ]]
	return v1
end
function t.Stop() --[[ Stop | Line: 220 | Upvalues: v1 (ref) ]]
	v1 = false
end
Networking.PlayCutscene.OnClientEvent:Connect(function(p1) --[[ Line: 224 | Upvalues: t (copy), LocalPlayer (copy) ]]
	local v1 = game.ReplicatedStorage.Assets.Cutscenes:FindFirstChild(p1)

	if not v1 then
		return
	end

	if not t.IsPlaying() then
		LocalPlayer:RequestStreamAroundAsync(v1:GetPivot().p)

		local v2 = v1:Clone()

		v2.Parent = workspace
		t.Play(v2)
	end
end)

return t