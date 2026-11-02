local TS = game:GetService('TweenService')
local RNS = game["Run Service"]

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
Player:GetPropertyChangedSignal('Character'):Connect(function()
	Character = Player.Character
end)

local CameraTableAnims = require(script.Parent.CameraTableAnims)
local Camera = workspace.CurrentCamera
local CamAnims = script.Animations
local CameraRig = script.CameraRig
local rad = math.rad
workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function()
	Camera = workspace.CurrentCamera
end)


local getCframe = 
	{
		["Instance"] = function(point)
			return point.CFrame
		end,

		["CFrame"] = function(point)
			return point
		end,
	}


local AnimTracks = {}
local module = {}
module.__index = module

local function CameraSmoothOut()
	local CamCF = Camera.CFrame
	local startClock = os.clock()
	local bindName = 'CutsceneCameraSmoothOut'..startClock..Player.UserId
	
	local easeStyle = Enum.EasingStyle.Exponential
	local easeDirection = Enum.EasingDirection.Out
	
	RNS:BindToRenderStep(bindName, Enum.RenderPriority.Camera.Value + 1, function()
		Camera.CFrame = CamCF:Lerp(Camera.CFrame, TS:GetValue((os.clock() - startClock) / .6, easeStyle, easeDirection))
	end)
	
	TS:Create(Camera, TweenInfo.new(.6, easeStyle, easeDirection), { FieldOfView = 70; }):Play()
	
	task.delay(.6, function()
		RNS:UnbindFromRenderStep(bindName)
	end)
end

local function finalCameraPart(MainPart, NMG)
	module:StopAnims()
	CameraTableAnims:StopAnimations()

	if NMG == true then
		Camera.CFrame = CFrame.new((MainPart.CFrame * CFrame.new(0, 24, -100)).Position, MainPart.Position)
	end
	Camera.CameraType = Enum.CameraType.Custom

	CameraSmoothOut()
end


function module:PlayCameraAnimation(AnimationName: string, MainPart: Part, smoothInTime: number, doSmoothOut: boolean): AnimationTrack
	if not Character or (Character and Character:FindFirstChild('CameraRig')) then return end

	local Animation = CamAnims:FindFirstChild(AnimationName)
	if Animation then
		if typeof(MainPart) == 'CFrame' then
			CameraRig.RootPart.Anchored = true
			CameraRig.RootPart.CFrame = MainPart.CFrame * Animation:GetAttribute('C0')
		else
			CameraRig.RootPart.Anchored = false
			CameraRig.RootPart.Weld.Part0 = MainPart
			CameraRig.RootPart.Weld.C0 = Animation:GetAttribute('C0')
			CameraRig.RootPart.Weld.C1 = Animation:GetAttribute('C1')
		end
		if Animation:GetAttribute("Size") then
			CameraRig.Cam.Size = Animation:GetAttribute("Size")
		end
		CameraRig.Parent = workspace.Thrown

		Camera.CameraType = Enum.CameraType.Scriptable


		smoothInTime = smoothInTime or .5
		local AnimTrack = AnimTracks[Animation]
		local startTick = tick()
		AnimTrack:Play()

		local AnimC: RBXScriptConnection
		AnimC = RNS.RenderStepped:Connect(function(deltaTime)
			if AnimTrack.IsPlaying == true and Character.Parent then
				if tick() - startTick < smoothInTime then
					Camera.CFrame = Camera.CFrame:Lerp(CameraRig.Cam.CFrame, (1 - smoothInTime)/2)
				else
					Camera.CFrame = Camera.CFrame:Lerp(CameraRig.Cam.CFrame, 0.9)
				end
			else
				AnimC:Disconnect()
				
				CameraRig.RootPart.Weld.Part0 = nil
				CameraRig.RootPart.CFrame = CFrame.new(0,0,0) * CFrame.Angles(0,0,0)
				if AnimationName ~= 'NMG' then
					Camera.CameraType = Enum.CameraType.Custom
				end
				CameraRig.Parent = script
			end
		end)
		
		if doSmoothOut ~= false then
			local delayTime, isNMG = AnimTrack.Length, false
			if AnimationName == 'NMG' then
				delayTime = 15.583
				isNMG = true
			end

			task.delay(delayTime, finalCameraPart, isNMG)
		end
		
		return AnimTrack
	end
end

function module:StopAnims()
	for _,v in AnimTracks do
		v:Stop()
	end

	CameraRig.RootPart.Weld.Part0 = nil
	CameraRig.RootPart.CFrame = CFrame.new(0,0,0) * CFrame.Angles(0,0,0)
	CameraRig.Parent = script
end

task.spawn(function()
	for _, Animation: Animation in CamAnims:GetChildren() do
		if Animation:IsA('Animation') then
			AnimTracks[Animation] = CameraRig.AnimationController.Animator:LoadAnimation(Animation)
		end
	end
end)

return module