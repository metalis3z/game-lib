--wip fr

delay(10, function()
	for _, v in next, game.ReplicatedFirst:GetChildren() do
		v:Destroy()
	end
end)

local function WaitForChild(parent, object) --better WaitForChild
	local item = nil
	repeat task.wait() item = parent:FindFirstChild(object) until item ~= nil
	return item
end

local Local_Player = game.Players.LocalPlayer
local FE2Library = require(game.ReplicatedStorage.SharedModules.FE2Library)
local TweenService = game:GetService("TweenService")
local HasPressed = false
local v25 = nil
local v21 = false
local v26 = nil
local v42 = game.ReplicatedStorage.TitleScreenResources.TitleBackgrounds:GetChildren()
local v32 = nil
local v19 = game.ReplicatedStorage.Remote
local v36
local v35
local v20 = FE2Library.getModeInfo()
function doCamFX(p2)
	v21 = true
	workspace.CurrentCamera.CameraType = "Scriptable"
	workspace.CurrentCamera.FieldOfView = 35
	local v93 = game
	local v95 = v93.Lighting:FindFirstChild("TitleBlur")
	if not v95 then
		v95 = Instance.new
		v93 = "BlurEffect"
		v25 = v95(v93)
		v25.Name = "TitleBlur"
		v25.Size = 10
		v25.Parent = game.Lighting
		local v27 = Instance.new("ColorCorrectionEffect")
		v27.Saturation = -0.3
		v27.Name = "TitleSaturation"
		v27.Parent = game.Lighting
	end
	local v99 = math.sin
	while true do
		local v98 = game
		local v100 = v98:GetService("RunService").RenderStepped
		local v103 = v100:wait()
		v103 = v21
		v103 = (tick()) * 0.5
		workspace.CurrentCamera.CFrame = (((p2:FindFirstChild("CamRef").CFrame) * CFrame.Angles((v99((v103) * 1.666)) * 0.01, (v99(v103)) * 0.04, (v99((v103) * 0.1)) * 0.01)) * CFrame.new(v99((v103) * 1), (v99((v103) * 1.666)) * 0.02, 0)) * CFrame.Angles(0, 0, 0)
	end
	local v103 = workspace.CurrentCamera
	local v104 = "Custom"
	v103.CameraType = v104
end
local function generateJoinFriends_1()
	local v256 = next
	local v258 = v35.Content
	local v260, v258 = v258.Holder:GetChildren()
	for v257, v262 in v256, v260, v258 do
		if not v262.Name:find("UI_") then
			v262:Destroy()
		end
	end
	v258 = v35
	v260 = v258.Content
	v256 = v260.Loading
	v260 = true
	v256.Visible = v260
	v260 = game.Players
	v260 = v35.Content.Loading
	v260.Visible = false
	v260 = 0
	local v331 = next
	local v332 = v260.LocalPlayer:GetFriendsOnline()
	local v262 = nil
	for v322, v267 in v331, v332, v262 do
		if v267.IsOnline == true then
			local v268 = game
			local v270 = v268.Players:FindFirstChild(v267.UserName)
			if not v270 then
				v270 = nil
				v268 = nil
				local v271 = next
				local v273 = v20.allowedRetro
				local v274
				for v272, v276 in v271, v273, v274 do
					if v267.PlaceId == v276 then
						v270 = "Retro"
						v268 = Color3.fromRGB(0, 85, 255)
					end
				end
				v271 = next
				v273 = v20.allowedPro
				v274 = nil
				for v272, v276 in v271, v273, v274 do
					local v280 = v267.PlaceId
					if v280 == v276 then
						v270 = "Pro"
						v280 = Color3.fromRGB
						v268 = v280(142, 68, 173)
					end
				end
				v271 = next
				v273 = v20.allowedChaos
				v274 = nil
				for v272, v276 in v271, v273, v274 do
					local v284 = v267.PlaceId
					if v284 == v276 then
						v270 = "Chaos"
						v284 = Color3.fromRGB
						v268 = v284(231, 76, 60)
					end
				end
				v271 = next
				local v335 = v20
				v273 = v335.allowedChill
				v274 = nil
				for v272, v276 in v271, v273, v274 do
					local v288 = v267.PlaceId
					if v288 == v276 then
						v270 = "Chill"
						v288 = Color3.fromRGB
						v268 = v288(52, 152, 219)
					end
				end
				if not v270 then
					v271 = v267.PlaceId
					v274 = v20
					v273 = v274.startPlace
					if v271 == v273 then
						v270 = "Normal"
						v271 = Color3.fromRGB
						v273 = 52
						v274 = 152
						v335 = 219
						v268 = v271(v273, v274, v335)
					end
				end
				if v270 then
					v260 = v260 + 1
					local v294 = script
					local v293 = v294.PlayerButton
					local v295 = v293:Clone()
					local v276 = (v260) * 0.5
					if (v260) * 0.5 == math.floor(v276) then
						v294 = 0.8
					else
						v294 = 1
					end
					local v292 = 140
					v292 = (141) * v294
					v295.BackgroundColor3 = Color3.fromRGB((127) * v294, (v292) * v294, v292)
					v295.Friend.Text = v267.DisplayName
					v295.Desc.Text = v270
					v295.Desc.TextColor3 = v268
					v295.MouseButton1Click:connect(function()
						local v304 = {
							ID = v267.PlaceId, Name = v267.DisplayName, UserId = v267.VisitorId
						}
						Local_Player.PlayerScripts.CL_MAIN_GameScript.TelePrompt:Fire(v304)
						v19.ReqTele:FireServer(v304.ID, v304.UserId)
					end)
					v295.Parent = v35.Content.Holder
				end
			end
		end
	end
	local v322 = v35
	v262 = v322.Content
	v332 = v262.Holder
	v331 = v332.UIGridLayout
	v262 = 1
	v322 = 0
	local v268 = 1
	local v270 = (v268) / v260
	v268 = 0
	local v295 = 0.2
	local v267 = math.clamp
	v331.CellSize = UDim2.new(v262, v322, v267(v270, v268, v295), 0)
end
local function PlayGame(p1)
	if p1 then
		script.EnterGame:Play()
		local v54 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		local v57 = game:GetService("TweenService")
		v57:Create(v26.Fade, v54, {
			BackgroundTransparency = -0.1
		}):Play()
		v57:Create(script.TitleMusic, v54, {
			Volume = 0
		}):Play()
		v57:Create(workspace.CurrentCamera, v54, {
			FieldOfView = 2
		}):Play()
		v57:Create(script.TitleMusic, v54, {
			Volume = 0
		})
		wait(1)
	end
	game.StarterGui:SetCoreGuiEnabled(3, true)
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	workspace.CurrentCamera.FieldOfView = 70
	workspace.CurrentCamera.DiagonalFieldOfView = 141.932
	game.Lighting.TitleBlur.Enabled = false
	script.TitleMusic:Stop()
	game.Lighting.TitleSaturation.Enabled = false
	if workspace.CurrentCamera:FindFirstChild("TitleBackground") then
		workspace.CurrentCamera.TitleBackground:Destroy()
	end
	--workspace.CurrentCamera.CameraSubject = Local_Player.Character:WaitForChild("Humanoid")
	for _, v in ipairs(Local_Player.PlayerGui:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name ~= "EntryGui" and v.Name ~= "LiftWaitVisual" then
			v.Enabled = true
		end
	end
	workspace.CurrentCamera.FieldOfView = 70
	workspace.CurrentCamera.DiagonalFieldOfView = 141.932
	WaitForChild(Local_Player.PlayerGui, "GameGui").HUD.Visible = true
end

local function CreatePlayerButton(ClonedGUI : ScreenGui, PlayerData)
	if PlayerData.PlayerName == nil or PlayerData.Desc == nil then
		return
	else
		local FriendContent = ClonedGUI.EntryFrame.WindowDisplays.Window2.Content.Holder
		local PlayerButton = script.PlayerButton:Clone()
		PlayerButton.Parent = FriendContent
		PlayerButton.Friend.Text = PlayerData.PlayerName
		PlayerButton.Desc.Text = PlayerData.Desc
	end
end
local v37 = 0
function updateBackground()
	local v158 = game
	local v162 = v158.ReplicatedStorage.TitleScreenResources.TitleBackgrounds:FindFirstChild("DefaultTitle")
	if v32 then
		v36 = v32
	end
	local v188 = v36
	if not v188 then
		if v162 then
			v32 = v162
		else
			v188 = v37 - 1
			v37 = v188
			v188 = v37
			if 1 >= v188 then
				v188 = #v42
				v37 = v188
			end
			v158 = v37
			v188 = v42[v158]
			v32 = v188
		end
		while true do
			v158 = v26
			local v163 = v158.BackgroundFade
			v188 = v163.BackgroundTransparency
			v163 = 0
			if v188 >= v163 then
				break
			end
			v163 = v26
			v188 = v163.BackgroundFade
			v158 = v26.BackgroundFade.BackgroundTransparency
			v163 = v158 - 0.033333333333333
			v188.BackgroundTransparency = v163
			v188 = wait
			v188()
		end
		local v166 = v36
		if v166 then
			v166 = v36
			v158 = "Model"
			local v167 = v166:IsA(v158)
			if v167 then
				v167 = v36
				v167:Destroy()
			end
		end
		v32 = v32:Clone()
		local v163 = "TitleBackground"
		v32.Name = v163
		v163 = workspace.CurrentCamera
		v32.Parent = v163
		v21 = false
		local v165 = true
		local v171 = v32:FindFirstChild("Humanoid", v165)
		if v171 then
			v163 = v171.Parent
			local v173 = v163:FindFirstChild("Animation")
			if v173 then
				local v164 = v173
				v171:LoadAnimation(v164):Play()
			end
		end
		wait()
		local v175 = 0
		delay(0, function()
			doCamFX(v32)
		end)
		while 1 >= v26.BackgroundFade.BackgroundTransparency do
			v26.BackgroundFade.BackgroundTransparency = v26.BackgroundFade.BackgroundTransparency + 0.033333333333333
			wait()
		end
		return 
	end
end
local function Init()
	WaitForChild(Local_Player.PlayerGui, "GameGui").HUD.Visible = false
	local TitleUI = script.EntryGui:Clone()
	TitleUI.EntryFrame.BuildVersion.Text = "Build Ver: " .. game.ReplicatedStorage.Config:GetAttribute("BuildVersion")
	v26 = TitleUI
	local CurrentPlace = game.PlaceId
	v35 = TitleUI.EntryFrame.WindowDisplays.Window2
	TitleUI.Parent = Local_Player.PlayerGui
	TweenService:Create(TitleUI.BackgroundFade, TweenInfo.new(5), {BackgroundTransparency = 1}):Play()
	game.StarterGui:SetCoreGuiEnabled(3, false)
	task.spawn(function()
		for index, Button in ipairs(TitleUI.EntryFrame.PlayFrame:GetChildren()) do
			if Button:IsA("TextButton") then
				Button.MouseButton1Click:Connect(function()
					if HasPressed then
						return
					end
					HasPressed = true
				end)
			end
		end
	end)
	script.TitleMusic:Play()
	local a = delay(0, function()
		while true do
			updateBackground()
			local v231
			if v36 then
				v231 = 20
			else
				v231 = 40
			end
			wait(v231)
			if HasPressed then
				break
			end
		end
	end)
	delay(0, function()
		while true do
			pcall(function()
				generateJoinFriends_1()
			end)
			wait(15)
		end
	end)
	task.spawn(function()
		local TitleScreenTick = tick()
		while HasPressed == false do
			task.wait()
			for _, v in ipairs(Local_Player.PlayerGui:GetChildren()) do
				if v:IsA("ScreenGui") and v.Name ~= "EntryGui" then
					v.Enabled = false
				end
			end
		end 
		PlayGame(true)
		TitleUI:Destroy()
		script:Destroy()
		Local_Player.PlayerScripts.CL_MAIN_GameScript.Disabled = false
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom	
		game.ReplicatedStorage.Remote.StartedGame:FireServer()	
	end)
end
local Counter = 0
Init()

game.ReplicatedStorage.Remote.Alert.OnClientEvent:connect(function(p3, p4, p5, p6, p7)
	Counter = Counter + 1
	local Text = Instance.new("TextLabel")
	Text.LayoutOrder = Counter
	Text.Text = p3
	if not p4 then
		p4 = Color3.new(1, 1, 1)
	end
	Text.TextColor3 = p4
	Text.TextScaled = true
	Text.TextXAlignment = "Left"
	Text.Font = "Ubuntu"
	Text.TextStrokeTransparency = 0.625
	Text.BackgroundTransparency = 1
	Text.Parent = v26.EntryFrame.AlertFrame.Content
	game:GetService("Debris"):AddItem(Text, 30)
end)