wait(1)

game.Workspace.INTRO_ASSETS:ClearAllChildren()

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

player.CharacterAdded:Connect(function()
	character = player.Character
	humanoid = character:WaitForChild("Humanoid")
end)

if game.ReplicatedStorage:FindFirstChild("INTRO") then return end

character:SetPrimaryPartCFrame(game.Workspace.LOADINGTP.CFrame)

local playermodel = game.ReplicatedStorage.PlayerModelIntro
local introAssets = game.Workspace.INTRO_ASSETS

print("loading")

function toggleUIs(value)
	local plrUI = game.Players.LocalPlayer.PlayerGui
	
	plrUI:WaitForChild("MoneyGui").Enabled = value
	plrUI:WaitForChild("HealthGui").Enabled = value
	plrUI:WaitForChild("Stamina").Enabled = value
	plrUI:WaitForChild("Hunger").Enabled = value

	for i,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "ToolText" then
			v.Visible = value
		end
	end
	
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All,value)
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,value)
end
toggleUIs(false)

local LocalModel = playermodel:Clone()
LocalModel.Parent = introAssets

local currentCam = game.Workspace.CurrentCamera
local camPart = game.Workspace.LOOKPART
currentCam.CameraType = Enum.CameraType.Scriptable
currentCam.CameraSubject = camPart
currentCam.CFrame = camPart.CFrame

LocalModel.Humanoid:ApplyDescription(game.Players:GetHumanoidDescriptionFromUserId(game.Players.LocalPlayer.UserId))

-- Apply to humanoid package
local humanoid2 = LocalModel.Humanoid
local desc = humanoid2:GetAppliedDescription()

desc.LeftArm = 376530220
desc.RightArm = 376531012
desc.LeftLeg = 376531300
desc.RightLeg = 376531703
desc.Torso = 376532000
desc.DepthScale = 0.9
desc.HeadScale = 1
desc.HeightScale = 1
desc.ProportionScale = 0
desc.WidthScale = 1

humanoid2:ApplyDescription(desc)

local anim = playermodel.Animation
local track = humanoid2:LoadAnimation(anim)
track:Play()

wait()
delay(1,function()
	for i,v in pairs(game.ReplicatedStorage.Glock17Hand:GetChildren()) do
		local vclo = v:Clone()
		vclo.Parent = LocalModel.RightHand
		local wc = Instance.new("WeldConstraint")
		wc.Parent = LocalModel.RightHand
		wc.Part0 = LocalModel.RightHand
		wc.Part1 = vclo		
		wait()
	end
end)

local maxTilt = 10
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local tweenInfo = TweenInfo.new(.01, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local TweenService = game:GetService("TweenService")

--game:GetService("RunService").RenderStepped:Connect(function()
	--currentCam.CFrame = camPart.CFrame * CFrame.Angles(
	--	math.rad((((mouse.Y - mouse.ViewSizeY / 2) / mouse.ViewSizeY)) * -maxTilt),
	--	math.rad((((mouse.X - mouse.ViewSizeX / 2) / mouse.ViewSizeX)) * -maxTilt),
	--	0
	--
	
--end)

local originalFOV = workspace.CurrentCamera.FieldOfView

local snd = game.ReplicatedStorage.Beat
local introBlur = game.Lighting.IntroBlur

introBlur.Enabled = true
game.ReplicatedStorage.Beat:Play()

local active = true

game:GetService("RunService").RenderStepped:Connect(function()
	if active then
		introBlur.Size = snd.PlaybackLoudness / 50
		workspace.CurrentCamera.FieldOfView = originalFOV - snd.PlaybackLoudness/50
		TweenService:Create(currentCam,tweenInfo,{CFrame = camPart.CFrame * CFrame.Angles(math.rad((((mouse.Y - mouse.ViewSizeY / 2) / mouse.ViewSizeY)) * -maxTilt),math.rad((((mouse.X - mouse.ViewSizeX / 2) / mouse.ViewSizeX)) * -maxTilt),0)}):Play()
	end		
end)

local p = game.Players.LocalPlayer
local LOADSCREEN = script.BronxLoadscreen:Clone()
LOADSCREEN.Parent = p.PlayerGui

local hover = game.ReplicatedStorage.HOVER

for i,v in pairs(LOADSCREEN.Frame:GetChildren()) do
	v.MouseEnter:Connect(function()
		hover:Play()
		v:FindFirstChild("select").Visible = true
	end)
	v.MouseLeave:Connect(function()
		v:FindFirstChild("select").Visible = false
	end)
end

local playClicked = false
local buttonsEnabled = true

local ogPosition = LOADSCREEN.Frame.Position

LOADSCREEN.Frame.rules.MouseButton1Click:Connect(function()
	if playClicked then return end
	if not buttonsEnabled then return end
	buttonsEnabled = false
	
	--tween away the gui
	local TT = LOADSCREEN.Frame
	local tween = TweenService:Create(TT, TweenInfo.new(3,Enum.EasingStyle.Quart, Enum.EasingDirection.InOut,0,false,0),{Position = UDim2.new(TT.Position.X.Scale + 5, TT.Position.Y.Scale)})
	tween:Play()
	tween.Completed:Wait()
	
	LOADSCREEN.Rules.Transparency = 1
	LOADSCREEN.Rules.Dark.Transparency = 1

	LOADSCREEN.Rules.Visible = true
	
	local tweenInfo = TweenInfo.new(
		1,Enum.EasingStyle.Linear,
		Enum.EasingDirection.Out,0,false,0)
	local tween = TweenService:Create(LOADSCREEN.Rules, tweenInfo, {Transparency = 0.25})
	local tween2 = TweenService:Create(LOADSCREEN.Rules.Dark, tweenInfo, {Transparency = 0.25})
	
	tween:Play()
	tween2:Play()

	LOADSCREEN.Rules.Dark.TextButton.Visible = false
	
	tween.Completed:Wait()
	
	LOADSCREEN.Rules.Dark.TextButton.Visible = true
	
end)

LOADSCREEN.Rules.Dark.TextButton.MouseButton1Click:Connect(function()
	print("going back")
	
	LOADSCREEN.Rules.Dark.TextButton.Visible = false
	local tweenInfo = TweenInfo.new(
		1,Enum.EasingStyle.Linear,
		Enum.EasingDirection.Out,0,false,0)
	--local tweenOut = TweenService:Create(LOADSCREEN.Rules, tweenInfo, {Transparency = 1})
	--local tween2 = TweenService:Create(LOADSCREEN.Rules.Dark, tweenInfo, {Transparency = 1})

	LOADSCREEN.Rules.Visible = false
	LOADSCREEN.Rules.Transparency = 0
	
	--tweenOut:Play()
	--tween2:Play()
	
	--tweenOut.Completed:Connect(function()
	--	LOADSCREEN.Rules.Visible = false
	--	LOADSCREEN.Rules.Transparency = 0
	--end)
	
	local TT = LOADSCREEN.Frame
	local tween = TweenService:Create(TT, TweenInfo.new(1.5,Enum.EasingStyle.Quart, Enum.EasingDirection.InOut,0,false,0),{Position = ogPosition})
	tween:Play()
	
	tween.Completed:Wait()
	
	buttonsEnabled = true
end)

LOADSCREEN.Frame.play.MouseButton1Click:Connect(function()
	if playClicked then return end
	if not buttonsEnabled then return end
	
	LocalModel:Destroy()
	LOADSCREEN:Destroy()
	introBlur.Enabled = false
	game.ReplicatedStorage.Beat:Stop()
	playClicked = true
	active = false
	toggleUIs(true)
	Instance.new("NumberValue",game.ReplicatedStorage).Name = "INTRO"
	wait(0.5)
	currentCam.CameraType = Enum.CameraType.Custom
	currentCam.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
	wait(0.001)
	game.ReplicatedStorage.SpawnCharacter:FireServer()
end)