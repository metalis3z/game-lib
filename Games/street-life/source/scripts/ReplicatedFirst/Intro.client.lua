if not game:IsLoaded() then game.Loaded:Wait() end

local player = game.Players.LocalPlayer
task.spawn(function()
	script.Song.TimePosition = 0
	--script.Song:Play()
end)
local YEAH = false
task.spawn(function()
	for _ = 1, 100 do
		script.Song.Volume += .1
		task.wait(.02)
	end
	task.wait(15)
	YEAH = true
	task.wait(45)
	local plrUI = game.Players.LocalPlayer.PlayerGui
	script.Song:Stop()
	if plrUI:FindFirstChild('LoadingScreen') then plrUI:FindFirstChild('LoadingScreen'):Destroy() end
	plrUI:WaitForChild("Stats").Enabled = true
	plrUI:WaitForChild('RStore').Enabled = true
	plrUI:WaitForChild('Gang').Enabled = true
	plrUI:WaitForChild('Info').Enabled = true
	plrUI:WaitForChild('PlayTime').Enabled = true

	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All,true)
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,true)
	game.Players.LocalPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = false
	game:FindFirstChild('Lighting'):FindFirstChild('IntroBlur').Enabled = false
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
	task.wait(1)
	workspace.Map.INTRO:Destroy()
	workspace:FindFirstChild('INTRO_ASSETS'):Destroy()
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	script.Song:Stop()
	if plrUI:FindFirstChild('LoadingScreen') then plrUI:FindFirstChild('LoadingScreen'):Destroy() end
	script:Destroy()
end)
local LOADSCREEN = script:FindFirstChildOfClass('ScreenGui'):Clone()
LOADSCREEN:WaitForChild('Frame')
LOADSCREEN.Parent = player.PlayerGui
LOADSCREEN.Logo.Visible = true
repeat task.wait(.1) until player.PlayerGui:FindFirstChild('Stats')
player.PlayerGui:WaitForChild("Stats").Enabled = false
player.PlayerGui:WaitForChild('RStore').Enabled = false
player.PlayerGui:WaitForChild('Gang').Enabled = false
player.PlayerGui:WaitForChild('PlayTime').Enabled = false
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

local playermodel = game.ReplicatedStorage:WaitForChild('PlayerModelIntro')
local introAssets = workspace:WaitForChild('INTRO_ASSETS')

function toggleUIs(value)
	local plrUI = game.Players.LocalPlayer.PlayerGui

	plrUI:WaitForChild("Stats").Enabled = value
	plrUI:WaitForChild('RStore').Enabled = value
	plrUI:WaitForChild('Gang').Enabled = value
	plrUI:WaitForChild('Info').Enabled = value
	plrUI:WaitForChild('PlayTime').Enabled = value
	
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All,value)
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,value)
end
toggleUIs(false)
task.wait(.5)
toggleUIs(false)

local LocalModel = playermodel:Clone()
LocalModel.Parent = introAssets

local currentCam = workspace.CurrentCamera

function TweenCamera(CFrame1)
	local Tween = game:GetService('TweenService'):Create(workspace.CurrentCamera, TweenInfo.new(.6, Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0), {CFrame = CFrame1})
	Tween:Play()
end
local function TweenPos(Frame, Kind, Val)
	local Tween = game:GetService('TweenService'):Create(Frame, TweenInfo.new(.3, Enum.EasingStyle.Bounce), {[Kind] = Val})
	Tween:Play()
end

LocalModel.Humanoid:ApplyDescription(game.Players:GetHumanoidDescriptionFromUserId(player.UserId))

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
track:AdjustSpeed(2.5)
track:Play()

local maxTilt = 15
local mouse = player:GetMouse()
local tweenInfo = TweenInfo.new(.01, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local TweenService = game:GetService("TweenService")
local originalFOV = workspace.CurrentCamera.FieldOfView

local snd = script.Song
local introBlur = game.Lighting.IntroBlur
introBlur.Enabled = true

local active = true
local DONE = false

local camPart = workspace.LOOKPART
currentCam.CameraType = Enum.CameraType.Scriptable
currentCam.CameraSubject = workspace['1']
currentCam.CFrame = workspace['1'].CFrame
task.spawn(function()
	game:GetService("RunService").RenderStepped:connect(function() 
		task.wait(.1)
		if active then
			introBlur.Size = snd.PlaybackLoudness / 10
			if DONE == true then
				workspace.CurrentCamera.FieldOfView = originalFOV - snd.PlaybackLoudness / 4
				TweenService:Create(currentCam,tweenInfo,{CFrame = camPart.CFrame * CFrame.Angles(math.rad((((mouse.Y - mouse.ViewSizeY / 2) / mouse.ViewSizeY)) * -maxTilt),math.rad((((mouse.X - mouse.ViewSizeX / 2) / mouse.ViewSizeX)) * -maxTilt),0)}):Play()
			else
				workspace.CurrentCamera.FieldOfView = originalFOV - snd.PlaybackLoudness / 10
			end
		end		
		task.wait(.01)
	end)
end)

local hover = game.ReplicatedStorage.HOVER
local ERROR = game.ReplicatedStorage.ERROR

for i,v in pairs(LOADSCREEN.Frame:GetChildren()) do
	if v:IsA('TextButton') then
		v.MouseEnter:Connect(function()
			hover:Play()
			v.UIStroke.Thickness += v.UIStroke.Thickness
		end)
		v.MouseLeave:Connect(function()
			v.UIStroke.Thickness -= v.UIStroke.Thickness / 2
		end)
	end
end

script.Song:Play()
repeat 
	if LOADSCREEN.Loading.Text == '' then LOADSCREEN.Loading.Text = 'LOADING' end
	task.wait(.2) 
	if LOADSCREEN.Loading.Text == 'LOADING' then
		LOADSCREEN.Loading.Text = 'LOADING.'
	elseif LOADSCREEN.Loading.Text == 'LOADING.' then
		LOADSCREEN.Loading.Text = 'LOADING..'
	elseif LOADSCREEN.Loading.Text == 'LOADING..' then
		LOADSCREEN.Loading.Text = 'LOADING...'
	elseif LOADSCREEN.Loading.Text == 'LOADING...' then
		LOADSCREEN.Loading.Text = 'LOADING'
	end
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
until (script.Song.IsPlaying and script.Song.TimePosition > 1) or YEAH == true

LOADSCREEN.Yeah.Visible = true
LOADSCREEN.Yeah1.Visible = true
task.spawn(function() for _ = 1, 10 do LOADSCREEN.Loading.TextTransparency += .1 task.wait(.01) end end)
for _ = 1, 100 do LOADSCREEN.Cover.BackgroundTransparency += .01 task.wait(.0075) end
task.wait(1)
TweenCamera(workspace['2'].CFrame)
task.wait(1)
TweenCamera(camPart.CFrame)
task.wait(1)
DONE = true
LOADSCREEN.Street.ZIndex = 3
TweenPos(LOADSCREEN.Street, 'Position', UDim2.new(0.5, 0,0.1, 0))
task.wait(.25)
LOADSCREEN.Life.ZIndex = 3
TweenPos(LOADSCREEN.Life, 'Position', UDim2.new(0.5, 0,0.15, 0))
task.wait(1)
local Character = player.Character or player.CharacterAdded:Wait()
Character:WaitForChild("Humanoid")
Character:WaitForChild('HumanoidRootPart').Anchored = true
LOADSCREEN.Frame.Visible = true
task.spawn(function()
	for _ = 1, 75 do 
		LOADSCREEN.ChangeFrame.Transparency -= .01 
		LOADSCREEN.ChangeFrame.UIStroke.Transparency -= .01
		task.wait(.01) 
	end
	for _ = 1, 100 do 
		LOADSCREEN.ChangeFrame.CHANGE.TextTransparency -= .01
		LOADSCREEN.ChangeFrame.CHANGE.UIStroke.Transparency -= .01
		LOADSCREEN.ChangeFrame.Main.TextTransparency -= .01
		LOADSCREEN.ChangeFrame.Main.UIStroke.Transparency -= .01
		LOADSCREEN.ChangeFrame.Time.TextTransparency -= .01
		LOADSCREEN.ChangeFrame.Time.UIStroke.Transparency -= .01
		task.wait(.0075)
	end
	task.wait(.1)
	for _,v in next, LOADSCREEN.ChangeFrame:GetChildren() do
		if v.Name == 'Info' then
			task.spawn(function()
				for _ = 1, 100 do
					if v and v:FindFirstChild('UIStroke') then
						v.TextTransparency -= .01
						v.UIStroke.Transparency -= .01
					end
					task.wait(.0025)
				end
			end)
		end
	end
end)
task.wait(.2)
for _,v in ipairs(LOADSCREEN.Frame:GetChildren()) do
	if v:IsA('TextButton') then
		task.spawn(function()
			for _ = 1, 100 do 
				v.TextTransparency -= .01
				v.UIStroke.Transparency -= .01
				task.wait(.0025)
			end
		end)
	end
end
task.wait(.2)

game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

local playClicked = false
local buttonsEnabled = false
LOADSCREEN.Frame.Play.MouseButton1Click:Connect(function()
	if playClicked then return end
	if buttonsEnabled or not Character:FindFirstChild('HumanoidRootPart') then return end
	task.spawn(function() for _ = 1, 100 do 
			if LOADSCREEN then
				LOADSCREEN.Cover.BackgroundTransparency -= .01 
				LOADSCREEN.Street.TextTransparency += .01 
				LOADSCREEN.Street.UIStroke.Transparency += .01
				LOADSCREEN.Life.TextTransparency += .01 
				LOADSCREEN.Life.UIStroke.Transparency += .01
				task.wait(.0075) 
			end
		end 
	end)
	task.wait(1)
	task.spawn(function() for _ = 1, 100 do snd.Volume -= .1 task.wait(.0075) end end)
	task.wait(2)
	playClicked = true
	active = false
	toggleUIs(true)
	wait(0.5)
	Character:WaitForChild('HumanoidRootPart').Anchored = false
	introBlur.Enabled = false
	LocalModel:Destroy()
	if LOADSCREEN then
		LOADSCREEN:Destroy()
	end
	currentCam.CameraType = Enum.CameraType.Custom
	currentCam.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
	task.wait(1)
	workspace.Map.INTRO:Destroy()
	introAssets:Destroy()
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	script:Destroy()
end)

LOADSCREEN.Frame.Help.MouseButton1Click:Connect(function()
	if playClicked or buttonsEnabled then return end
	buttonsEnabled = true
	LOADSCREEN.Frame.Visible = false
	LOADSCREEN.HelpFrame.Visible = true
	task.wait(.5)
	buttonsEnabled = false
end)

LOADSCREEN.HelpFrame.Close.MouseButton1Click:Connect(function()
	if playClicked or buttonsEnabled then return end
	buttonsEnabled = true
	LOADSCREEN.Frame.Visible = true
	LOADSCREEN.HelpFrame.Visible = false
	task.wait(.5)
	buttonsEnabled = false
end)

LOADSCREEN.Frame.Credits.MouseButton1Click:Connect(function()
	if playClicked or buttonsEnabled then return end
	buttonsEnabled = true
	LOADSCREEN.Frame.Visible = false
	LOADSCREEN.CreditsFrame.Visible = true
	task.wait(.5)
	buttonsEnabled = false
end)

LOADSCREEN.Frame.Free.MouseButton1Click:Connect(function()
	if playClicked or buttonsEnabled then return end
	buttonsEnabled = true
	LOADSCREEN.Frame.Visible = false
	LOADSCREEN.FreeFrame.Visible = true
	task.wait(.5)
	buttonsEnabled = false
end)

LOADSCREEN.FreeFrame.Close.MouseButton1Click:Connect(function()
	if playClicked or buttonsEnabled then return end
	buttonsEnabled = true
	LOADSCREEN.Frame.Visible = true
	LOADSCREEN.FreeFrame.Visible = false
	task.wait(.5)
	buttonsEnabled = false
end)

LOADSCREEN.CreditsFrame.Close.MouseButton1Click:Connect(function()
	if playClicked or buttonsEnabled then return end
	buttonsEnabled = true
	LOADSCREEN.Frame.Visible = true
	LOADSCREEN.CreditsFrame.Visible = false
	task.wait(.5)
	buttonsEnabled = false
end)

while task.wait(.001) do
	if player.PlayerGui:FindFirstChild('LoadingScreen') then
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		player.PlayerGui:FindFirstChild('LoadingScreen').Frame.Play.UIGradient.Rotation += 5
		player.PlayerGui:FindFirstChild('LoadingScreen').Frame.Free.UIGradient.Rotation += 1
	else
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	end
end