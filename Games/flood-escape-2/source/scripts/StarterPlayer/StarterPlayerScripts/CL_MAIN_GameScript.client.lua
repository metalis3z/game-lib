game.StarterGui:SetCoreGuiEnabled(1, false)
local notifyFunc = function()
	--print("No function set for notifyFunc")
end
local SFX = script.Parent.SFX_Folder
local riseList = {}
local riseVal = 0
local tempAir = 0
local lowestAir = 100
local wParticles, wParticlesP = nil
local FE2Library = require(game.ReplicatedStorage.SharedModules.FE2Library)
local QS = require(game.ReplicatedStorage.SharedModules.QS)
local MarketplaceService = game:GetService("MarketplaceService")
local camAngles = require(game.Workspace.Lobby.CamAngles).getAngles()
local cam = workspace.CurrentCamera
local chartick = tick()
local airDrainRate = 8
local r2 = nil
local ts = game:GetService("TweenService")
local Local_Player = game.Players.LocalPlayer
local GameGUI = Local_Player.PlayerGui:WaitForChild("GameGui")
local HUD = GameGUI:WaitForChild("HUD")
local showRebirth = false
local hasMoveInGame = false
local touchJump = nil
HUD.Main.MenuButtons.BackgroundColor3 = FE2Library.getThemeColor() 
local TestService = game:GetService("TestService")
local Main = HUD.Main
local MenuButtons = Main.MenuButtons
local camWater = nil
local lastSurfaced = tick()
local lastAcid = tick()
local Player_Character = nil
local hum = nil
local tankAir = 0
local maxTankAir = 0
local basicAir = 100
local humRtPt = nil
local SwimVelocity = nil
local angle = 1
local gameState = "Lobby"
local CurrentState = "Playing"
local IsSwimming
local StartTime = nil
local GUI_Functions = {}
local GUI_Buttons = {}	
local Admins = {}
local rem = game.ReplicatedStorage.Remote
local Player_Data = rem.ReqPlayerData:InvokeServer()
local waitcam
local SwimDownButton = nil
local SlideButton = nil
local NewTime = 0
local Main_2 = game.Players.LocalPlayer.PlayerGui.GameGui.Loading.Main
local popupInfo = TweenInfo.new(0.25)
local count = 0
local waitingCount = 0
local isDone = false
local BGM = nil
local swimmables = workspace:WaitForChild("Lobby"):WaitForChild("Waters"):GetChildren()
local Lighting = game:GetService("Lighting")
local MenuGUI = Local_Player.PlayerGui:WaitForChild("MenuGui")
local alerts = GameGUI:WaitForChild("Alerts")
local Data = Player_Data and Player_Data.OptionsData
repeat
	task.wait()
	Player_Data = rem.ReqPlayerData:InvokeServer()
	Data = Player_Data and Player_Data.OptionsData
until Data ~= nil
local autoSlide = Data.Main.autoSlide.Property.Value
local locatorOn = Data.Main.locatorEnabled.Property.Value
local lastLocatorValue = locatorOn
--print(autoSlide)
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local IsSwimmingUp = false
local GUI_ButtonIDS = {
	{"Menu_PlayMenu", 12812989387},
	{"Menu_Shop", 1055077607},
	{"Menu_Goals" , 12734627378},
	{"Menu_Social" , 1055077521},
	{"Menu_Options", 1055077259},
}
local PlayButtons_States = {
	["Exit"] = {ImageColor3 = Color3.fromRGB(255, 152, 141), Image = "rbxassetid://12876483821"},
	["Playing"] = {ImageColor3 = Color3.fromRGB(46, 204, 113), Image = "rbxassetid://12812989387"}
}
local GUI_ButtonFunctions = {
	["Menu_PlayMenu"] = function()
		if CurrentState == "Playing" then
			gameState = "Waiting"
			updBgm(1841647093, 0, 0.5) -- lift music
			for index, item in next, PlayButtons_States.Exit do
				GUI_Buttons["Menu_PlayMenu"].Icon[index] = item
			end
			rem.ClientJoinedLift:FireServer()
			CurrentState = "Exit"
			script.AddWaiting:Fire()
		elseif CurrentState == "Exit" then
			for index, item in next, PlayButtons_States.Playing do
				GUI_Buttons["Menu_PlayMenu"].Icon[index] = item
			end
			CurrentState = "Playing"
			local UI = game.Players.LocalPlayer.PlayerGui.GameGui.Waiting.UI
			local UI2 = game.Players.LocalPlayer.PlayerGui.GameGui.VoteMap
			local Content = UI.Content
			UI.Visible = false
			UI2.Visible = false
			rem.ClientLeftLift:FireServer()
			updBgm(game.ReplicatedStorage.Config:GetAttribute("LobbyMusic"))
			game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
			Local_Player.PlayerGui.LiftWaitVisual.Enabled = false
			gameState = "Lobby"
		end
	end,
	["Menu_Social"] = function()end,
	["Menu_Options"] = function()end,
	["Menu_Goals"] = function()end,
	["Menu_Shop"] = function()end,
}
local HUD_Types = {
	["Ingame"] = Main.GameStats.Ingame,
	["Stats"] = Main.GameStats.Stats
}
local function doEmote(Name, State)
	if State == Enum.UserInputState.Begin then
		if Player_Character then
			if Player_Character:FindFirstChild("Animate") then
				Player_Character.Animate.EmoteFire:Fire()
			end
		end
	end
end
function ValidateIsWater(item)
	if item:IsA("BasePart") and item.Name:find("_Water") then
		return true
	else
		return false
	end
end
function updWater()
	swimmables = {}
	local function findWater(item)
		for i, c in pairs(item:GetChildren()) do
			if ValidateIsWater(c) then
				table.insert(swimmables, c)
				if not c:FindFirstChild("BlockMesh") then
					local mesh = Instance.new("SpecialMesh")
					mesh.Name = "BlockMesh"
					mesh.MeshType = Enum.MeshType.Brick
					mesh.Scale = Vector3.new(1, 0, 1)
					mesh.Offset = Vector3.new(0, (c.Size.Y * 0.5), 0)
					mesh.Parent = c
				end
			else
				findWater(c)
			end
		end
	end
	if gameState == "Playing" then
		findWater(game.Workspace.Multiplayer.Map)
	else
		findWater(game.Workspace.Lobby.Waters)
	end
end
local function screenFade(p14, p15, p16, p17, p18)
	local v307
	if p14 == "In" then
		v307 = 1
	else
		v307 = 0
	end
	local v310 = math.abs(v307 - 1)
	Lighting.Fade_Blur.Enabled = true
	Lighting.Fade_ColorCorrection.Enabled = true
	if p14 == "In" then
		local v314 = Enum.EasingDirection.In
		if not v314 then
			v314 = Enum.EasingDirection.Out
		end
		local v315 = TweenInfo.new(p15, Enum.EasingStyle.Sine, v314)
		game:GetService("TweenService"):Create(Lighting.Fade_Blur, v315, {
			Size = (v310) * 70
		}):Play()
		game:GetService("TweenService"):Create(Lighting.Fade_ColorCorrection, v315, {
			Brightness = -v310
		}):Play()
		delay(p15, function()
			Lighting.Fade_Blur.Enabled = p16
			Lighting.Fade_ColorCorrection.Enabled = p16
		end)
		return 
	end
end
function showMenu(frame : Frame)
	if frame == nil then
		for _, frame in next, MenuGUI:GetChildren() do
			if frame:IsA("Frame") then
				frame.Visible = false
			end
		end
	end
	for _, frame in next, MenuGUI:GetChildren() do
		if frame:IsA("Frame") then
			frame.Visible = false
		end
	end
	if frame then
		local UIScale = frame:FindFirstChild("UIScale")
		if UIScale then
			UIScale.Scale = 0
			game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.325, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Scale = 1}):Play()
		end
		frame.Visible = true
		MenuGUI.MenuOpened:Fire(frame)
	end
end
local Player_Keybinds = {}
local BreathRecoveryRate = 20 --/s
local BreathRecoveryCooldown = 1--seconds
local CanTakeAir = false
local AurasDisabled = Data.Main.AurasEnabled.Property.Value
local BGMenabled = Data.Main.BGMenabled.Property.Value
local boomboxEnabled = Data.Main.boomboxEnabled.Property.Value
local BreathRecoveryWait = 0
local charState = 0
local alertList = {}
local u2 = false
local foundSlide = false
local slideDiving = false
local par = nil
local playAnim2 = nil
local playAnim = nil
local riding = false
local canJump = false
local jumpedOff = false
local JumpFix = false
local Superfix = false
local animation = nil

function lerp(a, b, c)
	return a + (b - a) * c
end

function switchAir(type_, bool_1)
	if type_ == "tank" then
		if not bool_1 then
			SFX.GetAir:Play()
		end
		Main.GameStats.Ingame.Info.Air.Count.TextColor3 = Color3.new(1,1,1)
	end
	if bool_1 then
		SFX.LoseAir:Play()
	end
end

function sort(tab)
	table.sort(tab, function(a, b)
		local na, nb = tonumber(a.Name:match("%d+$")), tonumber(b.Name:match("%d+$"))
		return na < nb
	end)
	return tab
end

function sortVector3(tab)
	table.sort(tab, function(Left, Right)
		return Left.X + Left.Z < Right.X + Right.Z 
	end)
	return tab
end

function distance(points)
	local total = 0

	for i = 1, #points - 1 do
		total = total + (points[i] - points[i + 1]).Magnitude
	end

	return math.ceil(total * 2)
end

function position(t, ...)
	local points = {...}

	while #points > 1 do
		for i = 1, #points - 1 do
			points[i] = lerp(points[i], points[i + 1], t)
		end

		points[#points] = nil
	end

	return points[1]
end

function createLookup(...)
	local distSum = 0

	local sums = {}
	local step = 1 / (math.floor(distance({...}) / 8.75))

	for i = 0, 1, step do
		local firstPoint = position(i, ...)
		local secondPoint = position(i + step, ...)

		local dist = (secondPoint - firstPoint).Magnitude
		table.insert(sums, distSum)

		distSum += dist
	end

	return sums 
end

function remap(n, oldMin, oldMax, min, max)
	return (min + ((max-min) * ((n - oldMin) / (oldMax - oldMin))))
end

function getAdjustedT(t, ...)
	local lookup = createLookup(...)

	local arcLength = lookup[#lookup]
	local targetDist = arcLength * t

	for i, dist in next, lookup do
		local nextDist = lookup[i + 1]

		if dist and nextDist and targetDist >= dist and targetDist < nextDist then
			return remap(targetDist, dist, nextDist, i / #lookup, (i + 1) / #lookup)
		end
	end
end

local function RideZipline(parent : Model)
	local humanoid = hum
	local Humanoid = hum
	local rootpart = humRtPt
	local character = Player_Character
	if parent.Name == "_Rope" and parent:IsA("Model") and not riding then
		local points = {}
		local pointPositions = {}
		local bezierPositions = {}

		riding = true
		humanoid:ChangeState("Physics")
		Humanoid.AutoRotate = false
		SFX.Wall_Jump:Play()
		SFX.Ziplining:Play()
		animation:Play()
		rem.Challenges.RideZipline:FireServer(rem.ReqPlayerData:InvokeServer())
		for i,v in next, parent:GetChildren() do
			if v:IsA("BasePart") and string.sub(v.Name,1,5) == "Point" then
				table.insert(points, v)
			end
		end

		canJump = false--riding

		sort(points)
		for i, v in ipairs(points) do
			table.insert(pointPositions, v.Position)
		end

		local bodyPosition = Instance.new("BodyPosition")
		bodyPosition.Name = "ZiplinePosition"
		bodyPosition.MaxForce = Vector3.new(10000, 10000, 10000)
		bodyPosition.Position = pointPositions[1]
		bodyPosition.P = 10000
		bodyPosition.Parent = rootpart

		local sparklePart = Instance.new("Part")
		sparklePart.Name = "SparklePart"
		sparklePart.Anchored = true
		sparklePart.CanCollide = false
		sparklePart.Size = Vector3.new(1, 1, 1)
		sparklePart.Transparency = 1
		sparklePart.Parent = character

		local sparkles = Instance.new("Sparkles")
		sparkles.SparkleColor = Color3.fromRGB(255, 180, 5)
		sparkles.Parent = sparklePart

		local step = 1 / math.floor(distance(pointPositions) / 8.75)

		for i = 0, 1, step do
			table.insert(bezierPositions, position(math.clamp(i, 0, 1), unpack(pointPositions)))
		end

		local elapsed = 0
		local total = 0
		local lastCFrame = CFrame.new()

		for i = 1, #bezierPositions - 1 do
			total += (bezierPositions[i] - bezierPositions[i + 1]).Magnitude
		end

		local speed = total / (parent:GetAttribute("RopeSpeed") or 40)

		local lastVelocity = CFrame.identity
		local currentCFrameValue = 0

		task.delay(0.15,function()
			if canJump then
				UserInputService.JumpRequest:Wait()
				jumpedOff = true
			end
		end)

		while elapsed < speed and humanoid.Health > 0 do
			if jumpedOff and canJump then 
				canJump = false
				jumpedOff = false
				local r = 0.9
				local m = 1.1
				local s = parent:GetAttribute("RopeSpeed") or 40
				if humanoid.MoveDirection.Magnitude > 0 then
					rootpart.Velocity = Vector3.new(s*humanoid.MoveDirection.X*r,humanoid.JumpPower,s*humanoid.MoveDirection.Z*r)*m
				else
					rootpart.Velocity = Vector3.new(s*lastCFrame.LookVector.X*r,humanoid.JumpPower,s*lastCFrame.LookVector.Z*r)*m
				end
				break 
			end			
			local t = math.min(1, elapsed / speed)
			local adjustedT = getAdjustedT(t, unpack(pointPositions))
			if adjustedT then				
				local bezierPoint = position(adjustedT, unpack(pointPositions))
				local nextBezierPoint = position(adjustedT + step, unpack(pointPositions))

				local velocity = CFrame.new(bezierPoint, nextBezierPoint)

				local rotateLookVector = (velocity.LookVector.X < 0 and 1 or -1)
				local rotation = math.floor((velocity.LookVector.Z - lastVelocity.LookVector.Z) * 400) * 40

				currentCFrameValue = currentCFrameValue + (math.clamp(rotateLookVector * rotation, -100, 100) - currentCFrameValue) * 0.04
				lastVelocity = velocity

				local newCFrame = velocity * CFrame.Angles(0, 0, math.rad(currentCFrameValue)) * CFrame.new(0, -rootpart.Size.Y - 0.57, 0)
				lastCFrame = newCFrame

				rootpart.CFrame = newCFrame
				bodyPosition.Position = rootpart.Position
				sparklePart.CFrame = velocity
			end
			elapsed += game:GetService("RunService").Heartbeat:Wait()
		end

		if not jumpedOff then
			if parent:GetAttribute("VelocityInheritance") then
				local m = parent:GetAttribute("VelocityInheritance") or 0
				local n = parent:GetAttribute("RopeSpeed") or 40
				rootpart.Velocity = Vector3.new(n*m,n*m,n*m) * lastCFrame.LookVector
			else
				rootpart.Velocity = Vector3.new()
			end
		end

		sparkles.Enabled = false
		game.Debris:AddItem(sparklePart, 2)

		humanoid:SetStateEnabled("Physics", false)
		humanoid:ChangeState("Freefall")
		Humanoid.AutoRotate = true
		bodyPosition:Destroy()

		SFX.Wall_Latch:Play()
		SFX.Ziplining:Stop()
		animation:Stop()

		riding = false
		jumpedOff = false
		canJump = false
	end
end

function endSlide(foundSlide)
	repeat task.wait() until humRtPt ~= nil
	if par ~= nil then
		par.Enabled = false
	end
	hum:MoveTo(humRtPt.Position)
	--script.Sound:Stop()
	playAnim2:Stop()
	--script.Sound2:Stop()
	par.Enabled = false
	slideDiving = false
	playAnim:Stop()
	humRtPt.Size = Vector3.new(2, 2, 1)
	hum.HipHeight = 0
	--print(foundSlide)
	if foundSlide then
		game.ReplicatedStorage.Remote.Challenges.SlideCheck:FireServer()
	end
	--RootPart = script.Parent:WaitForChild("HumanoidRootPart")
end

local function runSlide(p3, p4, p5)
	--RootPart = script.Parent:WaitForChild("BoundingBox")
	repeat task.wait() until humRtPt ~= nil
	if charState == 1 then return end
	if riding then return end
	if u2 == false and p4 == Enum.UserInputState.Begin then
		--print(Humanoid.RootPart.Velocity.Y <= (Humanoid.JumpPower) * 1.5)
		if hum:GetState() == Enum.HumanoidStateType.Freefall then
			humRtPt.Velocity = Vector3.new(humRtPt.Velocity.X, (-hum.JumpPower) * 1.5, humRtPt.Velocity.Z)
			playAnim2:Play()
			SFX.AirDive:Play()
			SFX.Slide:Stop()
			par.Enabled = true
			slideDiving = true
			delay(0.25, function()
				if not u2 then
					playAnim2:Stop()
					SFX.AirDive:Stop()
					par.Enabled = false
					slideDiving = false
				end
			end)
			--repeat task.wait() until hum:GetState() == Enum.HumanoidStateType.Landed or hum:GetState() == Enum.HumanoidStateType.Running or hum:GetState() == Enum.HumanoidStateType.RunningNoPhysics	
		end
		u2 = true
		foundSlide = false
		while true do
			if hum:GetState() == Enum.HumanoidStateType.Running then
				break
			end
			if hum:GetState() == Enum.HumanoidStateType.RunningNoPhysics then
				break
			end
			game:GetService("RunService").Heartbeat:Wait()
		end
		if charState == 1 then
			endSlide(foundSlide)
		end
		par.Enabled = true
		delay(0.1, function()
			if u2 then
				SFX.Slide:Play()
			end
		end)
		playAnim:Play()
		humRtPt.Size = Vector3.new(2, 1, 1)
		humRtPt.Velocity = Vector3.new(humRtPt.Velocity.X, -35, humRtPt.Velocity.Z)
		hum.HipHeight = -1.5
		local t = time()
		local move = 0
		local rayCastP = RaycastParams.new(Player_Character:GetChildren(), Enum.RaycastFilterType.Blacklist, true, "Default", true)
		if 0 < hum.MoveDirection.Magnitude then
			move = hum.MoveDirection * 20
		else
			move = humRtPt.CFrame.LookVector * 20
		end;
		while u2 == true do
			--r2 = workspace:Raycast(move, Vector3.new(0, 5, 0) - (Humanoid.MoveDirection) * 0.5, rayCastP)
			local rayOrigin = humRtPt.Position
			local rayDirection = move / 2.5
			r2 = workspace:Raycast(rayOrigin, rayDirection, rayCastP)
			if r2 then
				local s = r2.Instance.Name
				if s == "SlideBeam" then
					foundSlide = true
				end
			end
			game:GetService("RunService").RenderStepped:Wait();
			hum:MoveTo(humRtPt.Position + move);
			hum:GetPropertyChangedSignal("Jump"):connect(function()
				u2 = false;
			end);
			hum.Climbing:connect(function()
				u2 = false;
			end);
			if 0.5 <= time() - t then
				u2 = false;
			end;
		end
		u2 = false
		endSlide(foundSlide)
	elseif p4 == Enum.UserInputState.End then
		u2 = false
		endSlide(foundSlide)
	end
end
function toggleParticle(part)
	local blacklist = {"Bubbles", "SlideParticles"}
	if part:IsA("ParticleEmitter") then
		local allowed = true
		for _, n in next, blacklist, nil do
			if part.Name == n then
				allowed = false
			end
		end
		if allowed and not part:FindFirstChild("_IgnoreAura") then
			part.Enabled = (AurasDisabled == 1)
		end
	end
end
function updAuraVisible(char)
	local waitList = {
		"Left Arm",
		"Right Arm",
		"Left Leg",
		"Right Leg",
		"Torso",
		"HumanoidRootPart",
		"Head"
	}
	local pBlacklist = {"Bubbles","SlideParticles"}
	local hasAll
	repeat
		hasAll = true
		for _, p in next, waitList, nil do
			if not char:FindFirstChild(p) then
				hasAll = false
				wait()
				break
			end
		end
	until hasAll
	for _, obj in next, char:GetDescendants() do
		if obj:IsA("ParticleEmitter") then
			toggleParticle(obj)
		else
			obj.ChildAdded:connect(function(newObj)
				if newObj:IsA("ParticleEmitter") then
					toggleParticle(newObj)
				end
			end)
		end
	end
end
function updBoomboxes()
	if boomboxEnabled == 1 then
		game.SoundService.Boomboxes.Volume = 0
	elseif boomboxEnabled == 2 then
		if gameState == "Lobby" then
			game.SoundService.Boomboxes.Volume = 1
		elseif gameState == "Playing" then
			game.SoundService.Boomboxes.Volume = 0
		end
	elseif boomboxEnabled == 3 then
		game.SoundService.Boomboxes.Volume = 1
	end
end
function setMapToLowDetail(Model : Model) 
	for _, MapDetail in next, Model:GetDescendants() do
		if not MapDetail.Name:find("_Water") then
			if MapDetail.Name == "_Detail" or MapDetail:GetAttribute("FE2_Detail") == "Cosmetic" or MapDetail.Parent and not MapDetail.Parent.Name:find("_Water") and (MapDetail:IsA("Texture") or MapDetail:IsA("Decal")) then
				if MapDetail.Parent == nil then
					continue
				end
				if not (MapDetail.Parent:IsA("BasePart") and MapDetail.Parent.Transparency >= 0.9) then
					MapDetail:Destroy()
				end
			elseif MapDetail:IsA("BasePart") then
				MapDetail.Material = Enum.Material.SmoothPlastic
			elseif MapDetail:IsA("ParticleEmitter") or MapDetail:IsA("Smoke") or MapDetail:IsA("Fire") or MapDetail:IsA("Sparkles") or MapDetail:IsA("Trail") then
				MapDetail:Destroy()
			end
		end
	end
	print("Set", Model.Name, "to Low Detail")
end
local function updIsHighDetail(arg1 : boolean)
	game.Lighting.GlobalShadows = arg1
	for i, item in pairs(Local_Player:GetDescendants()) do
		if item:IsA("UIGradient") then
			item.Enabled = arg1
		elseif item:IsA("UICorner") then
			local OriginalRadius = item:GetAttribute("OriginalRadius")
			if OriginalRadius == nil then
				item:SetAttribute("OriginalRadius", item.CornerRadius)
				OriginalRadius = item:GetAttribute("OriginalRadius")
			end
			if arg1 then
				item.CornerRadius = OriginalRadius
			else
				item.CornerRadius = UDim.new()
			end
		end
	end
	for i, item in pairs(game.Lighting:GetChildren()) do
		if string.find(item.Name, "Standard_") then
			item.Enabled = arg1
		end
	end
end
local function applyOptions()
	autoSlide = Data.Main.autoSlide.Property.Value
	locatorOn = Data.Main.locatorEnabled.Property.Value
	AurasDisabled = Data.Main.AurasEnabled.Property.Value
	BGMenabled = Data.Main.BGMenabled.Property.Value
	boomboxEnabled = Data.Main.boomboxEnabled.Property.Value
	if lastLocatorValue ~= locatorOn then
		Local_Player.PlayerGui.Locator.CL_Buttons.UpdEnabled:Fire(locatorOn)
	end
	lastLocatorValue = locatorOn
	script.Parent.CL_GhostPlayers.UpdHidden:Fire(Data.Main.ghostState.Property.Value)
	updBoomboxes()
	updIsHighDetail(Data.Main.isHighDetail.Property.Value)
	if Data.Others.FOV_Input.Property.Value ~= 70 and Data.Others.FOV_Input.Property.Value ~= nil and tonumber(Data.Others.FOV_Input.Property.Value) then
		game:GetService("TweenService"):Create(workspace.CurrentCamera, TweenInfo.new(0.25), {FieldOfView = Data.Others.FOV_Input.Property.Value}):Play()
	else
		if Data.Main.camFXEnabled.Property.Value then
			game:GetService("TweenService"):Create(workspace.CurrentCamera, TweenInfo.new(0.25), {FieldOfView = 90}):Play()
		else
			game:GetService("TweenService"):Create(workspace.CurrentCamera, TweenInfo.new(0.25), {FieldOfView = 70}):Play()
		end
	end
	for tableIndex, item in next, Data.Controls do
		if not Player_Keybinds[tableIndex] then
			Player_Keybinds[tableIndex] = {}
		end
		for Type, KeyTypes in next, item.KeyString do
			Player_Keybinds[tableIndex][Type] = Enum.KeyCode[KeyTypes]
		end
	end
	bindSwimActions()
	bindSlideActions()
	if UserInputService.GamepadEnabled then
		ContextActionService:BindAction("EMOTE", doEmote, false, Player_Keybinds.EMOTE.GamePad)
	else
		ContextActionService:BindAction("EMOTE", doEmote, false, Player_Keybinds.EMOTE.Keyboard) 
	end
	if AurasDisabled == 1 then
		for _, plr in next, game.Players:GetPlayers() do
			updAuraVisible(plr.Character)
		end
	elseif AurasDisabled == 2 then
		for _, plr in next, game.Players:GetPlayers() do
			if plr.Character ~= Player_Character then
				updAuraVisible(plr.Character)
			end
		end
	elseif AurasDisabled == 3 then
		for _, plr in next, game.Players:GetPlayers() do
			updAuraVisible(plr.Character)
		end
	end
	--repeat task.wait() until humRtPt ~= nil
end
local function loadGui(p2)
	local v82 = game.ReplicatedStorage:FindFirstChild("GuiBackup")
	if v82 then
		local v84 = v82:FindFirstChild(p2)
		if v84 then
			v84:Clone().Parent = Local_Player.PlayerGui
		end
	end
end
function swimJump(action, uiState)
	if SwimVelocity and hum and charState == 1 then
		if uiState == Enum.UserInputState.Begin then
			SwimVelocity.Velocity = Vector3.new(0, hum.WalkSpeed, 0)
		elseif uiState == Enum.UserInputState.End and 0 < SwimVelocity.Velocity.Y then
			SwimVelocity.Velocity = Vector3.new(0, 0, 0)
		end
	end
end
function swimDive(action, uiState)
	if SwimVelocity and hum and charState == 1 then
		if uiState == Enum.UserInputState.Begin then
			SwimVelocity.Velocity = Vector3.new(0, -hum.WalkSpeed, 0)
		elseif uiState == Enum.UserInputState.End and 0 > SwimVelocity.Velocity.Y then
			SwimVelocity.Velocity = Vector3.new(0, 0, 0)
		end
	end
end
local v3593 = false

local function toggleMenuList(p96)
	local v4153 = p96
	if not v4153 then
		v4153 = not v3593
	end
	v3593 = v4153
	local v4154 = v3593
	if p96 == nil then
		p96 = true
	end
	GameGUI.MenuFrame.Visible = p96
	if p96 then
		local v4156 = GameGUI.MenuFrame:FindFirstChild("UIScale")
		if v4156 then
			v4156.Scale = 0
			local targetScale = { Scale = 1 }
			local tweenInfo = TweenInfo.new(0.325, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
			game:GetService("TweenService"):Create(GameGUI.MenuFrame.UIScale, tweenInfo, targetScale):Play()
		end
		showMenu()
	else
		local v4156 = GameGUI.MenuFrame:FindFirstChild("UIScale")
		if v4156 then
			local targetScale = { Scale = 0 }
			local tweenInfo = TweenInfo.new(0.325, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
			game:GetService("TweenService"):Create(GameGUI.MenuFrame.UIScale, tweenInfo, targetScale):Play()
		end
		showMenu()
	end

	local arrowRotation = (p96 == true and 90.1) or -89.9
	local rotationInfo = { Rotation = arrowRotation }
	local tweenInfo = TweenInfo.new(0.325, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	game:GetService("TweenService"):Create(HUD.Main.MenuButtons.Content.OpenList.ArrowImg, tweenInfo, rotationInfo):Play()
end
function addMenu(p92)
	local v3993 = script.Resources.MenuButton:Clone()
	v3993.Icon.Image = "rbxassetid://" .. p92.IconID.Value
	v3993.Desc.Text = p92.ListName.Value
	v3993.Desc.TextTransparency = 0
	v3993.BackgroundColor3 = FE2Library.getThemeColor()
	v3993.LayoutOrder = p92.LayoutOrder
	v3993.Parent = HUD.Parent.MenuFrame.Content
	v3993.Activated:connect(function()
		showMenu(p92)
		toggleMenuList(false)
	end)
	local v4007 = math.ceil((#HUD.Parent.MenuFrame.Content:GetChildren() - 1) * 0.5)
	HUD.Parent.MenuFrame.Size = UDim2.new(0.8, 0, (v4007) * 0.075, 0)
	HUD.Parent.MenuFrame.Content.GridLayout.CellSize = UDim2.new(0.49, 0, (0.96) / v4007, 0)
end
local function updLighting(newLighting)
	--print(newLighting)
	local propsToFind = {}
	propsToFind[1] = "Ambient"
	propsToFind[2] = "Brightness"
	propsToFind[3] = "ColorShift_Bottom"
	propsToFind[4] = "ColorShift_Top"
	propsToFind[5] = "OutdoorAmbient"
	propsToFind[6] = "TimeOfDay"
	propsToFind[7] = "FogColor"
	propsToFind[8] = "FogEnd"
	propsToFind[9] = "FogStart"
	propsToFind[10] = "ExposureCompensation"
	local New = {
		Ambient = Color3.fromRGB(127, 127, 127), Brightness = 1, OutdoorAmbient = Color3.fromRGB(127, 127, 127), ColorShift_Bottom = Color3.new(), ColorShift_Top = Color3.new(), TimeOfDay = "14:00:00", ExposureCompensation = 0.25, FogColor = Color3.fromRGB(191, 191, 191), 
		FogEnd = 100000, FogStart = 0
	}
	for _, v in pairs(Lighting:GetChildren()) do
		if string.match(v.Name, "Map_") then
			v:Destroy()
		end
	end
	if newLighting ~= nil then
		--print(newLighting:IsA("Configuration") or newLighting:IsA("Folder"))
		if newLighting:IsA("Configuration") or newLighting:IsA("Folder") then
			for _, item in ipairs(newLighting:GetChildren()) do
				if item:IsA("NumberValue") or item:IsA("IntValue") or
					item:IsA("Color3Value") or item:IsA("StringValue") or
					item:IsA("BoolValue") then
					if table.find(propsToFind, item.Name) then
						New[item.Name] = item.Value
					end
				end
			end
			for name, item in pairs(newLighting:GetAttributes()) do
				New[name] = item
			end
		end
	end

	if Player_Data.OptionsData.Main.isHighDetail.Property.Value == true then
		if newLighting ~= nil then
			for _, item in pairs(newLighting:GetDescendants()) do
				if item:IsA("PostEffect") then
					item.Enabled = true
					item.Name = "Map_" .. item.Name
					item.Parent = Lighting
				elseif item:IsA("Atmosphere") then
					item.Name = "Map_" .. item.Name
					item.Parent = Lighting
				elseif item:IsA("Clouds") then
					item.Name = "Map_" .. item.Name
					item.Parent = Lighting
				end
			end
		end
	end
	for _, a in pairs(propsToFind) do
		Lighting[a] = New[a]
	end
end

local v150 = HUD.Parent:WaitForChild("Alerts")
local v138 = {}
local function RemoveAlert(Alert, Tween, Position)
	Alert.ZIndex = 0
	table.remove(v138, Position)

	if Alert:FindFirstChild("Alert_Shadow") and Alert.Alert_Shadow then
		ts:Create(Alert.Alert_Shadow, Tween, {
			ImageTransparency = 1
		}):Play()
	end

	ts:Create(Alert.Alert, Tween, {
		TextTransparency = 1.1, 
		TextStrokeTransparency = 1
	}):Play()

	delay(0.3, function()
		Alert:Destroy()
	end)

	return
end

function handleAlert(QueuePos, Alert, IsForced)
	if Alert.Parent == GameGUI.Alerts then
		local newPos
		local TweenStyle
		local TimeoutPosition = (4 < QueuePos)
		if not TimeoutPosition then
			newPos = IsForced and QueuePos or QueuePos - 1

			TweenStyle = IsForced and "In" or "Out"
		else
			newPos = QueuePos or QueuePos - 1

			TweenStyle = "In"
		end

		local AlertTween = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)

		if not (4 < QueuePos) then
			if IsForced then
				RemoveAlert(Alert, AlertTween, QueuePos)
			else
				Alert:TweenPosition(UDim2.new(0.5, 0, newPos, 0), TweenStyle, "Sine", 0.325, true)
			end
		else
			RemoveAlert(Alert, AlertTween, QueuePos)
		end
	end
end
local v4731 = UserInputService.TouchEnabled
if v4731 then
	v4731 = HUD.Main.Emote_Container
	v4731.Visible = true
	v4731 = HUD.Main.AimLock
	v4731.Visible = true
	v4731 = HUD.Main.Emote_Container.Emote.MouseButton1Click
	v4731:connect(function()
		doEmote(true, Enum.UserInputState.Begin)
	end)
end
local v127 = HUD
function updMapEventInfo(text, color, timer)
	--PendingRescueTextProcess += 1
	text = text or ""
	color = color or HUD.MapEventInfo.TextColor3
	timer = timer or 0
	HUD.MapEventInfo.Text = text
	HUD.MapEventInfo.TextColor3 = color
	HUD.MapEventInfo.TextStrokeTransparency = 0.625
	HUD.MapEventInfo.TextTransparency = 0
	HUD.MapEventInfo:TweenSize(UDim2.new(1, 0, 0.8, 0), "Out", "Quint", 0.5, true)
	local setTime = tick() + timer
	while true do
		if tick() > setTime then
			break
		end
		HUD.MapEventInfo.TextColor3 = color:lerp(Color3.new(1, 0, 0), math.abs(math.sin(tick() * 3)))
		wait()
	end
	HUD.MapEventInfo.TextColor3 = color
	HUD.MapEventInfo.TextStrokeTransparency = 1
	HUD.MapEventInfo.TextTransparency = 0.3
	HUD.MapEventInfo:TweenSize(UDim2.new(1.2, 0, 0.5, 0), "Out", "Quint", 0.3, true)
	--PendingRescueTextProcess -= 1
end
function newAlert(text, color, duration, type, isLocalized, priority)
	duration = duration or 4.5
	local frameText = text
	local isPrompt = frameText == "swimprompt"
	if type == "event" then
		spawn(function()
			updMapEventInfo(text, color, duration)
		end)
		return
	elseif type == "prompt" then
		if frameText == "swimprompt" then
			frameText = (UserInputService.KeyboardEnabled and 
				("Press '" .. Player_Keybinds.SWIMDIVE.Keyboard.Name .. "' to Dive, Press '" .. Player_Keybinds.SWIMJUMP.Keyboard.Name .. "' to Surface")) or (UserInputService.GamepadEnabled and 
				("Press '" .. Player_Keybinds.SWIMDIVE.GamePad.Name .. "' to Dive, Press '" .. Player_Keybinds.SWIMJUMP.GamePad.Name .. "' to Surface")) or
				"Use Touch Controls to Dive and Surface"	
		end
	end

	local frame = Instance.new("Frame")
	local shadow = Instance.new("ImageLabel")
	local label = Instance.new("TextLabel")

	local function createAlert()
		if isLocalized then
			label.AutoLocalize = false
		end

		frame.Name = "Alert_Frame"
		frame.Size = UDim2.new(1, 0, 1, 0)
		frame.Position = UDim2.new(0.5, 0, -1, 0)
		frame.AnchorPoint = Vector2.new(0.5, 0)
		frame.BackgroundTransparency = 1
		frame:SetAttribute("Priority", priority)

		local scale = Instance.new("UIScale")
		scale.Scale = 0
		scale.Parent = frame

		shadow.Name = "Alert_Shadow"
		shadow.BackgroundTransparency = 1
		shadow.Image = "rbxassetid://1057492965"
		shadow.ImageTransparency = 0.5
		shadow.Size = UDim2.new(1, 0, 1, 0)
		shadow.Parent = frame

		label.Name = "Alert"
		label.ZIndex = 3
		label.Text = frameText
		label.TextColor3 = color or Color3.new(1, 1, 1)
		label.TextScaled = true
		label.Font = "Ubuntu"
		label.TextStrokeTransparency = 0
		label.BackgroundTransparency = 1
		label.BackgroundColor3 = Color3.new()
		label.BorderSizePixel = 0
		label.Size = UDim2.new(1, 0, 1, 0)

		if type == "prompt" then
			label.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		end

		local gradient = Instance.new("UIGradient")
		gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(159, 159, 159))
		gradient.Rotation = 90
		gradient.Parent = label

		label.Parent = frame
		frame.Parent = v150

		if duration >= 8 and not isPrompt then
			local subFrame = Instance.new("Frame", label)
			subFrame.BorderSizePixel = 0
			subFrame.BackgroundColor3 = color or Color3.new(1, 1, 1)
			subFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			subFrame.Position = UDim2.new(0.5)
			subFrame.Size = UDim2.new(1, 0, 0.1, 0)
			subFrame:TweenSize(UDim2.new(0, 0, 0.1, 0), "Out", "Linear", duration)

			local subImage = Instance.new("ImageLabel", subFrame)
			subImage.Image = "rbxassetid://156579757"
			subImage.Size = UDim2.new(1, 0, 1, 0)
			subImage.BackgroundTransparency = 1
			subImage.ImageTransparency = 0.5
		end

		if type == "rainbow" then
			spawn(function()
				while true do
					task.wait()
					local t = 5
					local hue = tick() % t / t
					label.TextColor3 = Color3.fromHSV(hue, 1, 1)
				end
			end)
		end

		local priorityIndex = 1
		for i, alert in ipairs(v138) do
			if alert:GetAttribute("Priority") == true then
				break
			end
			priorityIndex = i + 1
			break
		end

		table.insert(v138, priorityIndex, frame)
		for i, alert in ipairs(v138) do
			handleAlert(i, alert)
		end

		local tweenInfo = TweenInfo.new(0.325, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		game:GetService("TweenService"):Create(frame.UIScale, tweenInfo, { Scale = 1 }):Play()
		game:GetService("TweenService"):Create(label, tweenInfo, { TextTransparency = 0, TextStrokeTransparency = 0 }):Play()
		if not isPrompt then
			if duration ~= 0 then
				wait(duration)
			end
		else
			repeat task.wait() until charState == 0
		end

		if label.TextTransparency < 0 then
			handleAlert(4, frame, true)
		else
			handleAlert(priorityIndex, frame, true)
		end

		for i, alert in ipairs(v138) do
			handleAlert(i, alert)
		end
	end

	delay(0, createAlert)
	return label
end
function countAllVisibleButtons(p93)
	local v4044 = 0
	local v4047, v4048 = p93:GetChildren()
	for v4053, v4051 in next, v4047, v4048 do
		local v4052 = v4051:IsA("GuiButton")
		if v4052 then
			v4052 = v4051.Visible
			if v4052 then
				v4044 = v4044 + 1
			end
		end
	end
	return v4044
end
local Notif = {}
local IsTextData = {
	["Img"] = {
		Position = UDim2.new(0.3, 0, 0, 0);
		Size = UDim2.new(0.7, 0, 1, 0)
	};
	["NoImg"] = {
		Position = UDim2.new(0, 0, 0, 0);
		Size = UDim2.new(1, 0,1, 0)
	}
}
local CurrentIndex = 1



local function CreateButtonMenu(Object_Name, Object_Image, func : () -> ())
	local Object = script:WaitForChild("Resources").QuickMenu:Clone()
	Object.Name = Object_Name
	--MenuButtons.Content.UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 5)
	--[[
	]]
	MenuButtons.Content.UIGridLayout.CellSize = UDim2.new((1) / countAllVisibleButtons(v127.Main.MenuButtons.Content), 0, 1, 0)
	Object.Parent = MenuButtons.Content
	local Icon = Object:WaitForChild("Icon")
	if (Object_Name == "Menu_PlayMenu") then
		Icon.ImageColor3 = Color3.fromRGB(46, 204, 113)
	end
	--MenuButtons:TweenSize(UDim2.new(math.clamp((countAllVisibleButtons(MenuButtons.Content)) * 0.075, 0, math.huge), 0, 1, 0), "Out", "Quint", 0.325, true)
	MenuButtons:TweenSize(UDim2.new(math.clamp((countAllVisibleButtons(MenuButtons.Content)) * 0.075, 0, math.huge), 0, 1, 0), "Out", "Quint", 0.325, true)
	Icon.Image = `rbxassetid://{tostring(Object_Image)}`
	GUI_Buttons[Object_Name] = Object
	if Object_Name == "Menu_PlayMenu" then
		GUI_Functions[Object] = Object.Activated:Connect(function()
			if Object.Visible then
				func()
			end
		end)
	else
		Object.Activated:Connect(function()
			local Frame = nil
			for _, frame in next, MenuGUI:GetChildren() do
				if frame:IsA("Frame") then
					if string.match(Object_Name, frame.Name) then
						Frame = frame
						break
					end
				end
			end
			showMenu(Frame)
		end)
	end
end
local function RemoveButtonMenu(ObjectName)
	local Object = GUI_Buttons[ObjectName]
	--MenuButtons.Content.UIGridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
	Object.Visible = false
	MenuButtons:TweenSize(UDim2.new(math.clamp((countAllVisibleButtons(MenuButtons.Content)) * 0.075, 0, math.huge), 0, 1, 0), "Out", "Quint", 0.325, true)
	MenuButtons.Content.UIGridLayout.CellSize = UDim2.new((1) / countAllVisibleButtons(v127.Main.MenuButtons.Content), 0, 1, 0)	
end
function curWaitCam()
	local now = time()
	local multinow = now * 2
	local wave = QS.s(now * 2) --huh!?
	waitcam = waitcam:lerp(Vector3.new(Player_Character.HumanoidRootPart.Position.X, Player_Character.HumanoidRootPart.Position.Y - 4, 187), 0.16)  -- 148 >> 187
	return CFrame.new(camAngles[angle] * CFrame.Angles(QS.s(multinow * 1.666) * 0.01, wave * 0.04, QS.s(multinow * 0.1) * 0.01) * CFrame.new(wave, math.noise(wave, QS.s(now * 2.222), QS.s(now * 1.666) + QS.s(multinow * 1.666) * 0.02), 0).Position, waitcam)
end 
local function CheckGamePasses()
	local ListOfPass = {}
	ListOfPass.CFC = false
	ListOfPass.VIP = false
	ListOfPass.Boost = false
	if MarketplaceService:UserOwnsGamePassAsync(Local_Player.UserId, 14784835) then
		ListOfPass.CFC = true
	end
	if MarketplaceService:UserOwnsGamePassAsync(Local_Player.UserId, 4223166) then
		ListOfPass.VIP = true
	end
	if MarketplaceService:UserOwnsGamePassAsync(Local_Player.UserId, 14432092) then
		ListOfPass.Boost = true
	end
	return ListOfPass
end

local function AirTankPickedUp(AirTank : Model)
	if gameState == "Playing" then
		for i, item in pairs(AirTank:GetDescendants()) do
			if item:IsA("BasePart") then
				item.CanCollide = false
				local tween = game:GetService("TweenService"):Create(item, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {Transparency = 1})
				game.Debris:AddItem(tween, 1)
				tween:Play()
			elseif item:IsA("ParticleEmitter") then
				item.Enabled = false
			end
		end
		switchAir("tank")
		AirTank:Destroy()
		local TankCapacity = (AirTank:GetAttribute("TankCapacity") ~= nil and AirTank:GetAttribute("TankCapacity")) or 300
		newAlert("Got Air Bubble (+" .. TankCapacity .. "% O2)", Color3.fromRGB(135, 186, 219), 2)	
		maxTankAir = TankCapacity
		tankAir += TankCapacity
	end
end
local function inPart(pos, item)
	return FE2Library.inPart(pos, item, swimmables)
end
local ContentProvider = game:GetService("ContentProvider")
function updBgm(id, TimePos, Pitch, SoundGroup)
	for _, ost in pairs(script.Parent.BGM_Folder:GetChildren()) do
		ost.Name = "oldBGM"
		game:GetService("TweenService"):Create(ost, TweenInfo.new(1, Enum.EasingStyle.Linear), {Volume = 0}):Play()
		delay(1, function()
			ost:Destroy()
		end)
	end
	BGM = Instance.new("Sound")
	local Split_1 = string.find(id, "_")
	if Split_1 then
		id = string.sub(id, 1, Split_1 - 1)
	end
	BGM.Name = "BGM"
	BGM.SoundId = "rbxassetid://" .. tostring(id)
	BGM.Looped = true
	BGM.Pitch = Pitch or 1
	BGM.Volume = 0
	BGM.TimePosition = 0
	BGM.SoundGroup = SoundGroup or nil
	BGM.Parent = script.Parent.BGM_Folder
	spawn(function()
		ContentProvider:Preload(BGM.SoundId)
		while true do
			if BGM.IsLoaded then
				break
			end
			wait()
		end
		BGM.TimePosition = TimePos or 0
		BGM:Play()
		if BGMenabled == true then
			local shouldCancel = false
			local t_sound = game:GetService("TweenService"):Create(BGM, TweenInfo.new(1, Enum.EasingStyle.Linear), {Volume = 1})
			t_sound:Play()
			t_sound.Completed:Connect(function()
				shouldCancel = true
			end)
			while true do
				if BGMenabled == false then
					break
				end
				if BGM.Name == "oldBGM" then
					break
				end
				wait()
			end
			if not shouldCancel then
				t_sound:Cancel()
				if not BGMenabled then
					BGM.Volume = 0
				end
			else
				if not BGMenabled then
					BGM.Volume = 0
				end
			end
		end
	end)
end
local v141 = {}
local v137 = Local_Player.PlayerGui.NotifGui.Notification
function closeNotif()
	game.Lighting.Notification_Blur.Enabled = false
	game:GetService("GuiService").SelectedObject = nil
	v137.Visible = false
	if #v141 > 0 then
		local v3366 = v141[1]
		newNotification(v3366.info, v3366.title, v3366.func, v3366.img)
		table.remove(v141, 1)
	end
	Local_Player.PlayerScripts.SFX_Folder.Notif_Close:Play()
end
function newNotification(info, title, callback, imageId)
	showMenu()
	if v137.Visible then
		table.insert(v141, { info = info, title = title, func = callback, img = imageId })
		return
	end

	game.Lighting.Notification_Blur.Enabled = true
	Local_Player.PlayerScripts.SFX_Folder.Notif_Open:Play()

	v137.Visible = true
	v137.Window.Content.Info.Text = info
	v137.Window.Title.Text = title or "Notification"
	local hasChoices = callback ~= nil
	v137.Window.Choices.Visible = hasChoices
	v137.Window.Confirm.Visible = not hasChoices
	v137.Window.Content.Img.Visible = imageId ~= nil

	if imageId then
		v137.Window.Content.Img.Image = "rbxassetid://" .. imageId
		v137.Window.Content.Info.Size = UDim2.new(0.7, 0, 1, 0)
		v137.Window.Content.Info.Position = UDim2.new(0.3, 0, 0, 0)
	else
		v137.Window.Content.Info.Size = UDim2.new(1, 0, 1, 0)
		v137.Window.Content.Info.Position = UDim2.new(0, 0, 0, 0)
	end
	notifyFunc = callback or function()
		--print("Blank")
	end
	if UserInputService.GamepadEnabled then
		if hasChoices then
			game:GetService("GuiService").SelectedObject = v137.Window.Choices.No
		else
			game:GetService("GuiService").SelectedObject = v137.Window.Confirm
		end
	end

	v137.Window.Position = UDim2.new(0.5, 0, 0.7, 0)
	v137.Window:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Elastic", 0.55, true)
end
local function UpdateStats()
	Player_Data = rem.ReqPlayerData:InvokeServer()
	local GameStats_Stats = HUD.Main.GameStats.Stats
	GameStats_Stats.Currency.CoinAmt.Amount.Text = FE2Library.abbreviateNumber(Player_Data.coins)
	GameStats_Stats.Currency.GemAmt.Amount.Text = FE2Library.abbreviateNumber(Player_Data.gems)
	GameStats_Stats.XPStats.Icon.Info.Text = Player_Data.level
	GameStats_Stats.XPStats.ProgressBar.Percentage.Size = UDim2.new(Player_Data.xp/FE2Library.calcLevelXP(Player_Data.level), 0, 1, 0)
	GameStats_Stats.XPStats.XP.Text = `{tostring(Player_Data.xp)}/{tostring(FE2Library.calcLevelXP(Player_Data.level))} XP`
	local t_1, t_2 = FE2Library.getLoginBonus(Player_Data.dailylogins)
	if t_2 == 0 then
		t_2 = "Coins"
	else
		t_2 = "Gems"
	end
	if Player_Data.rebirths > 0 then
		GameStats_Stats.XPStats.Rebirth.Visible = true
		GameStats_Stats.XPStats.Rebirth.Info.Text = "x" .. tostring(Player_Data.rebirths)
	else
		GameStats_Stats.XPStats.Rebirth.Visible = false
	end
	GameStats_Stats.LoginStats.Icon.Info.Text = `{t_1} {t_2}`
	GameStats_Stats.LoginStats.Days.Text = `{tostring(Player_Data.dailylogins)}/7 days`
	GameStats_Stats.LoginStats.ProgressBar.Percentage.Size = UDim2.new(math.clamp(Player_Data.dailylogins, 1, 7)/7, 0, 1, 0)
	--print(Player_Data)
	showRebirth = ((Player_Data.level == 100 and FE2Library.calcLevelXP(Player_Data.level) <= Player_Data.xp) or Player_Data.level > 100) and Player_Data.rebirths < 30
	Main.GameStats.Stats.XPStats.Visible = not showRebirth
	Main.GameStats.Stats:WaitForChild("Rebirth").Visible = showRebirth	
end

function takeAir(amount)
	local amt = amount
	if tankAir > 0 then
		tankAir = tankAir - amt
		if tankAir < 0 then
			amt = math.abs(tankAir)
		else
			amt = 0
		end
	else
		basicAir = basicAir - amt
		basicAir = math.clamp(basicAir, 0, 100)
		if basicAir < 0 then
			basicAir = 0
		end
	end
end
local function CharacterAdded(Char : Model)
	updWater()
	touchJump = Local_Player.PlayerGui:findFirstChild("JumpButton", true)
	updLighting()
	updMapEventInfo()
	chartick = tick()
	Player_Character = Char
	maxTankAir = 0
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	workspace.CurrentCamera.CameraSubject = Char:WaitForChild("Humanoid")
	par = script.Resources:WaitForChild("SlideParticles"):Clone()
	par.Parent = Player_Character:WaitForChild("Head")
	par.Enabled = false
	hum = Char:WaitForChild("Humanoid") :: Humanoid
	swimmables = workspace.Lobby.Waters:GetChildren()
	hum.Health = 100
	hum.WalkSpeed = 20
	hum.MaxSlopeAngle = 89
	hum.MaxHealth = 100
	hum.JumpPower = 50
	local Animator = hum:WaitForChild("Animator") :: Animator
	local animation_slide = Instance.new("Animation")
	animation_slide.AnimationId = "http://www.roblox.com/asset/?id=" .. game.ReplicatedStorage.Animations:WaitForChild("AnimIDs").Slide.Value
	local animation_dive = Instance.new("Animation")
	animation_dive.AnimationId = "http://www.roblox.com/asset/?id=" .. game.ReplicatedStorage.Animations:WaitForChild("AnimIDs").AirDive.Value
	playAnim = Animator:LoadAnimation(animation_slide)
	playAnim2 = Animator:LoadAnimation(animation_dive)
	local swing = Instance.new("Animation")
	swing.AnimationId = "rbxassetid://" .. tostring(game.ReplicatedStorage.Animations.AnimIDs.Swing.Value)
	animation = Player_Character:WaitForChild("Humanoid"):FindFirstChild("Animator"):LoadAnimation(swing)
	animation.Priority = Enum.AnimationPriority.Action
	swing:Destroy()
	animation_slide:Destroy()
	animation_dive:Destroy()
	SwimVelocity = Instance.new("BodyVelocity")
	SwimVelocity.Name = "SwimVel"
	SwimVelocity.P = 8000
	SwimVelocity.MaxForce = Vector3.new(0, 0, 0)
	SwimVelocity.Velocity = Vector3.new(1, 0, 1)
	SwimVelocity.Parent = Player_Character:WaitForChild("HumanoidRootPart")
	hum.Touched:Connect(function(touchingPart)
		if touchingPart.Parent == nil then
			return
		end
		if touchingPart.Parent.Name == "AirTank" and touchingPart.Name == "Hitbox" then
			AirTankPickedUp(touchingPart.Parent)
		end
	end)
	if game.Workspace.Multiplayer:FindFirstChild("Map") then
		local Map = game.Workspace.Multiplayer:WaitForChild("Map")
		for index, item in pairs(Map:GetDescendants()) do
			if item.Name == "Marker" and item:IsA("BillboardGui") then
				item:Destroy()
			end
		end
	end
	local d = nil
	repeat 
		task.wait()
		d = Player_Character:FindFirstChild("PlrInfo")
	until d ~= nil
	if d ~= nil then
		if d.Name == "PlrInfo" and d:IsA("BillboardGui") then
			d.Enabled = false
		end
	end
	UpdateStats()
	Player_Character:WaitForChild("Humanoid"):GetPropertyChangedSignal("Jump"):Connect(function()
		if charState == 1 then
			if Player_Character.Humanoid.Jump then
				SwimVelocity.Velocity = Vector3.new(0, Player_Character.Humanoid.WalkSpeed, 0)
			elseif not Player_Character.Humanoid.Jump and 0 < SwimVelocity.Velocity.Y then
				SwimVelocity.Velocity = Vector3.new(0, 0, 0)
			end
		end
	end)
	hum.Touched:Connect(function(arg1)
		if arg1.Parent then
			if arg1.Name == "StartOrb" then
				RideZipline(arg1.Parent)
			end
		end
	end)
	hum.Died:Connect(function()
		local humCheck = hum
		ContextActionService:UnbindAction("swimDive")
		ContextActionService:UnbindAction("swimJump")
		local PhysList = {}
		for _, c in pairs(Char:GetChildren()) do
			if c:IsA("BasePart") then
				local BodyPos = Instance.new("BodyPosition", c)
				BodyPos.P = 10000
				BodyPos.MaxForce = Vector3.new()
				table.insert(PhysList, BodyPos)
			end
		end
		spawn(function()
			local maxTime = tick() + 5
			while maxTime > tick() and game["Run Service"].RenderStepped:wait() do
				for _, bodypos in pairs(PhysList) do
					if bodypos.Parent then
						local force = inPart(bodypos.Parent.Position, swimmables) and 1100 or 0
						bodypos.Position = bodypos.Parent.Position
						bodypos.MaxForce = Vector3.new(force * 0.05, force, force * 0.05)
					else
						bodypos:Destroy()
					end
				end
			end
		end)
		wait(1)
		if hum == humCheck then
			updBgm(0)
			screenFade("Out", 1, true, false)
		end
	end)
	if gameState == "Playing" then
		gameState = "Waiting"
		rem.ClientJoinedLift:FireServer()
		Player_Character:MoveTo(game.Workspace.Lobby.WaitingArea.WaitTeleport.Position + Vector3.new(0, 3, 0))
		script.AddWaiting:Fire()	
	else
		gameState = "Lobby"
	end
	wParticles = script.Resources.WaterParticles:Clone()
	wParticlesP = Instance.new("Part")
	wParticlesP.Size = Vector3.new(30, 30, 30)
	wParticlesP.Anchored = true
	wParticlesP.CanCollide = false
	wParticlesP.Transparency = 1
	wParticlesP.Parent = game.Workspace
	Player_Data = rem.ReqPlayerData:InvokeServer()
	humRtPt = Player_Character:WaitForChild("HumanoidRootPart") :: BasePart?
	script.Bubbles:Clone().Parent = Player_Character.Head
	local timeThing = 0
	local isOff = false
	if UserInputService.TouchEnabled then
		touchJump.Changed:Connect(function()
			touchJump.Visible = true
		end)
		hum:GetPropertyChangedSignal("MoveDirection"):Connect(function()
			if gameState == "Playing" then
				if hum.MoveDirection.Magnitude > 0 then
					hasMoveInGame = true
				end
			end
			if hum.MoveDirection.Magnitude > 0 then
				wait(0.2)
				game:GetService("TweenService"):Create(v127.Main.Emote_Container.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0), {
					Scale = 0
				}):Play()
				game:GetService("TweenService"):Create(v127.Main.MenuButtons.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0), {
					Scale = 0
				}):Play()
			else
				wait(0.2)
				game:GetService("TweenService"):Create(v127.Main.Emote_Container.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0), {
					Scale = 1
				}):Play()
				game:GetService("TweenService"):Create(v127.Main.MenuButtons.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0), {
					Scale = 1
				}):Play()
			end
		end)
	end
end
local showDB = false
local function CharacterRemoving(character)
	ContextActionService:UnbindAction("swimDive")
	ContextActionService:UnbindAction("swimJump")
	if hasMoveInGame and gameState == "Playing" then
		showDB = false
		if game.Workspace.Multiplayer:FindFirstChild("Map") then
			local Map = game.Workspace.Multiplayer:WaitForChild("Map")
			for index, item in pairs(Map:GetDescendants()) do
				if item.Name == "Marker" and item:IsA("BillboardGui") then
					item:Destroy()
				end
			end
		end
		updMapEventInfo()
		UpdateStats()
		CurrentState = "Exit"
		for index, item in next, PlayButtons_States.Exit do
			GUI_Buttons["Menu_PlayMenu"].Icon[index] = item
		end
		local Humanoid = character.Humanoid :: Humanoid
		Humanoid.Health = 100
		Humanoid.WalkSpeed = 20
		Humanoid.MaxSlopeAngle = 89
		Humanoid.MaxHealth = 100
		Humanoid.JumpPower = 50
		IsSwimming = false
		CanTakeAir = false
		GUI_Buttons["Menu_PlayMenu"].Visible = true
		MenuButtons.Content.UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 5)
		MenuButtons.Content.UIGridLayout.CellSize = UDim2.new((1) / countAllVisibleButtons(v127.Main.MenuButtons.Content), 0, 1, 0)
		MenuButtons:TweenSize(UDim2.new(math.clamp((countAllVisibleButtons(MenuButtons.Content)) * 0.075, 0, math.huge), 0, 1, 0), "Out", "Quint", 0.325, true)
		HUD.Main.MenuButtons.Content.OpenList.Visible = false
		HUD.Main.GameStats.Ingame.Visible = false
		HUD.Main.GameStats.Stats.Visible = true
		updBgm(1841647093, 0, 0.5) -- lift music
		Player_Data = rem.ReqPlayerData:InvokeServer()
		Data = Player_Data and Player_Data.OptionsData
		charState = 0
		gameState = "Waiting"
	else
		gameState = "Lobby"
		showDB = false
		if game.Workspace.Multiplayer:FindFirstChild("Map") then
			local Map = game.Workspace.Multiplayer:WaitForChild("Map")
			for index, item in pairs(Map:GetDescendants()) do
				if item.Name == "Marker" and item:IsA("BillboardGui") then
					item:Destroy()
				end
			end
		end
		updMapEventInfo()
		UpdateStats()
		CurrentState = "Playing"
		local Humanoid = character.Humanoid :: Humanoid
		Humanoid.Health = 100
		Humanoid.WalkSpeed = 20
		Humanoid.MaxSlopeAngle = 89
		Humanoid.MaxHealth = 100
		Humanoid.JumpPower = 50
		for index, item in next, PlayButtons_States.Playing do
			GUI_Buttons["Menu_PlayMenu"].Icon[index] = item
		end
		IsSwimming = false
		CanTakeAir = false
		GUI_Buttons["Menu_PlayMenu"].Visible = true
		MenuButtons.Content.UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 5)
		MenuButtons.Content.UIGridLayout.CellSize = UDim2.new((1) / countAllVisibleButtons(v127.Main.MenuButtons.Content), 0, 1, 0)
		MenuButtons:TweenSize(UDim2.new(math.clamp((countAllVisibleButtons(MenuButtons.Content)) * 0.075, 0, math.huge), 0, 1, 0), "Out", "Quint", 0.325, true)
		HUD.Main.MenuButtons.Content.OpenList.Visible = false
		HUD.Main.GameStats.Ingame.Visible = false
		HUD.Main.GameStats.Stats.Visible = true
		updBgm(game.ReplicatedStorage.Config:GetAttribute("LobbyMusic"))
		Player_Data = rem.ReqPlayerData:InvokeServer()
		Data = Player_Data and Player_Data.OptionsData
		charState = 0	
	end
	screenFade("In", 1, false)
end

function formatTime(timeInSeconds)
	-- Extract minutes
	local minutes = math.floor(timeInSeconds / 60)
	-- Extract remaining seconds
	local seconds = math.floor(timeInSeconds % 60)
	-- Extract milliseconds
	local milliseconds = math.floor((timeInSeconds % 1) * 1000)

	-- Format as a string
	local formattedTime = string.format("%02d:%02d.%03d", minutes, seconds, milliseconds)

	return formattedTime
end
for index, item in ipairs(Local_Player.PlayerGui:WaitForChild("MenuGui"):GetDescendants()) do
	if item:IsA("TextButton") and item.Name == "Close" then
		local Parent = item.Parent.Parent.Parent
		item.MouseButton1Click:Connect(function()
			Parent.Visible = not Parent.Visible
		end)
	end
end
task.spawn(function()
	for tableIndex, item in next, Data.Controls do
		if not Player_Keybinds[tableIndex] then
			Player_Keybinds[tableIndex] = {}
		end
		for Type, KeyTypes in next, item.KeyString do
			Player_Keybinds[tableIndex][Type] = Enum.KeyCode[KeyTypes]
		end
	end
	--print(Player_Keybinds)
	--print(runSlide)
	Local_Player.PlayerGui.GameGui.HUD.Visible = true
	if table.find(Admins, Local_Player.UserId) then
		table.insert(GUI_ButtonIDS, {"Menu_MapTest", 4895383464})
		GUI_ButtonFunctions["Menu_Loader"] = function()end
	end
	HUD.Main.MenuButtons.Content.OpenList.Visible = false
	for index, item in ipairs(GUI_ButtonIDS) do
		CreateButtonMenu(item[1], item[2], GUI_ButtonFunctions[item[1]])		
		MenuButtons.Content.UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 5)
		MenuButtons.Content.UIGridLayout.CellSize = UDim2.new((1) / countAllVisibleButtons(v127.Main.MenuButtons.Content), 0, 1, 0)
		MenuButtons:TweenSize(UDim2.new(math.clamp((countAllVisibleButtons(MenuButtons.Content)) * 0.075, 0, math.huge), 0, 1, 0), "Out", "Quint", 0.325, true)	
	end
	for _, v in next, MenuGUI:GetChildren() do
		if v:IsA("Frame") then
			addMenu(v)
		end
	end
	HUD.Main.GameStats.Ingame.Visible = false
	HUD.Main.GameStats.Stats.Visible = true
	updBgm(game.ReplicatedStorage.Config:GetAttribute("LobbyMusic"))
	CharacterAdded(Local_Player.Character)
end)
local step = 0
local showedTip = false
local IngameStats = Main.GameStats.Ingame
local de_Tween = false
local lighting = game.Lighting
local LastGameState = gameState
local function TrackTime()
	local startTick = tick()
	NewTime = 0
	while gameState == "Playing" and task.wait() do
		NewTime = (tick() - startTick) --woah
		HUD.Main.GameStats.Ingame.Info.Time.Current.Count.Text = formatTime(NewTime)
	end
end
local function CoreLoop()
	if Player_Character == nil then
		repeat task.wait() until Player_Character ~= nil and Player_Character:FindFirstChild("Head") and Player_Character:FindFirstChild("Head"):FindFirstChild("Bubbles")
	end
	local inFirstPerson	
	local humCamOffset = Vector3.new()	
	local newCam = FE2Library.CheckIsSwimming(cam.CFrame.p, swimmables)
	local newR, newG, newB
	if newCam then
		newR, newG, newB = newCam.BrickColor.r + (1 - newCam.BrickColor.r) * 0.33, newCam.BrickColor.g + (1 - newCam.BrickColor.g) * 0.33, newCam.BrickColor.b + (1 - newCam.BrickColor.b) * 0.33
	end
	if newCam ~= camWater then
		camWater = newCam
		for _, c in pairs(lighting:GetChildren()) do
			if c.Name:find("Water_") then
				c.Enabled = newCam
			end
		end
		lighting.Water_ColorCorrection.TintColor = newCam and Color3.new(newR, newG, newB) or lighting.Water_ColorCorrection.TintColor
		for _, v in pairs(script.Parent.BGM_Folder:GetChildren()) do
			v.SoundGroup = newCam and game.SoundService.Underwater
		end
		SFX.Splash_water.SoundGroup = newCam and game.SoundService.Underwater
		SFX.Splash_lava.SoundGroup = newCam and game.SoundService.Underwater
		SFX.Splash_acid.SoundGroup = newCam and game.SoundService.Underwater
		SFX.Splash_.SoundGroup = newCam and game.SoundService.Underwater
		wParticles.Parent = wParticlesP
	end
	if newCam and lighting.Water_ColorCorrection.Enabled and lighting.Water_ColorCorrection.TintColor ~= Color3.new(newR, newG, newB) then
		lighting.Water_ColorCorrection.TintColor = lighting.Water_ColorCorrection.TintColor:lerp(Color3.new(newR, newG, newB), 0.05)
	end
	if camWater then
		hum.CameraOffset = Vector3.new(math.sin(tick() * 3) * 0.2, math.sin(tick() * 3.21) * 0.2, math.sin(tick() * 3.73) * 0.2)
	elseif camWater and not newCam then
		hum.CameraOffset = Vector3.new()
	end
	if newCam and cam.CameraSubject:IsA("Humanoid") and cam.CameraSubject.Torso ~= nil then
		local yLimit = 0
		wParticlesP.CFrame = CFrame.new(cam.CameraSubject.Torso.Position.X, cam.CameraSubject.Torso.Position.Y, cam.CameraSubject.Torso.Position.Z)
	end
	if LastGameState ~= gameState then
		--print(gameState)
		if gameState == "Playing" then
			updWater()
			spawn(TrackTime)
		elseif gameState == "Waiting" then
			spawn(function()
				for i = 0, 1, 0.016666666666667 do
					workspace.Lobby.WaitingArea.Lift.Lift.SndPart.Lift.PlaybackSpeed = i
					workspace.Lobby.WaitingArea.Lift.Particles.AirParticles.Speed = NumberRange.new(12 + (i * 36))
					workspace.Lobby.WaitingArea.Lift.BGFog.FogTexture.TextureSpeed = (-i) * 0.3
					workspace.Lobby.WaitingArea.Lift.FGFog.FogTexture.TextureSpeed = (-i) * 0.3
					for _, Descendant in next, workspace.Lobby.WaitingArea.Lift.Trusses:GetDescendants(), nil do
						if Descendant:IsA("Beam") then
							Descendant.TextureSpeed = i * 2
						end
					end
					wait(0.1)
				end
			end)
			if gameState == "Waiting" then
				if cam.CameraSubject ~= hum then
					cam.CameraType = "Custom"
				else
					cam.CameraType = "Scriptable"
				end
				waitcam = Player_Character.HumanoidRootPart.Position 
				angle = math.random(1, #camAngles) 
				Local_Player.PlayerGui.LiftWaitVisual.Enabled = true
				spawn(function()
					local camfr = cam.CFrame 
					local camstart = tick() 
					local chareffect = 0.5 <= tick() - chartick 
					while true do
						if cam.CameraSubject == hum then
							local estcam = tick() + 0.1 - camstart 
							local newcam
							if chareffect then
								if estcam <= 1.3 then
									newcam = camfr:lerp(curWaitCam(), math.sin(3.1415926535898 * (estcam / 1.3 * 0.5))) 
								else
									newcam = curWaitCam() 
								end 
							else
								newcam = curWaitCam() 
							end 
							ts:Create(workspace.CurrentCamera, TweenInfo.new(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
								CFrame = newcam
							}):Play()
						end 
						wait(0.1) 
						if gameState ~= "Waiting" then
							Local_Player.PlayerGui.LiftWaitVisual.Enabled = false
							break 
						end             
					end 
					return
				end) 
			end
		elseif gameState == "Lobby" then
			spawn(function()
				for i = 0, 1, 0.016666666666667 do
					workspace.Lobby.WaitingArea.Lift.Lift:WaitForChild("SndPart").Lift.PlaybackSpeed = i
					workspace.Lobby.WaitingArea.Lift.Particles.AirParticles.Speed = NumberRange.new(12 + (i * 36))
					workspace.Lobby.WaitingArea.Lift.BGFog.FogTexture.TextureSpeed = (-i) * 0.3
					workspace.Lobby.WaitingArea.Lift.FGFog.FogTexture.TextureSpeed = (-i) * 0.3
					for _, Descendant in next, workspace.Lobby.WaitingArea.Lift.Trusses:GetDescendants(), nil do
						if Descendant:IsA("Beam") then
							Descendant.TextureSpeed = i * 0.3
						end
					end
					wait(0.1)
				end
			end)
		end
		LastGameState = gameState
	end
	if riseVal ~= 0 then
		local dist = riseVal * (step * 2) + 0.015
		if riseVal < 0.05 then
			dist = riseVal
		end
		riseVal = riseVal - dist
		for _, i in pairs(riseList) do
			i:TranslateBy(Vector3.new(0, dist, 0))
		end
	end
	if Player_Character:FindFirstChild("Head") then
		local WaterBody
		if gameState == "Playing" or gameState == "Won" then
			WaterBody = FE2Library.CheckIsSwimming(Player_Character.Head.Position, swimmables)
		else
			WaterBody = FE2Library.CheckIsSwimming(Player_Character.Head.Position, swimmables)
		end
		local StateValue = ""
		if WaterBody then
			if WaterBody:FindFirstChild("State") or WaterBody:FindFirstChild("WaterState") then
				local c = WaterBody:FindFirstChild("State") or WaterBody:FindFirstChild("WaterState")
				StateValue = string.lower(c.Value)
			end
		end
		local newState = WaterBody and 1 or 0
		if newState ~= charState then
			charState = newState
			if Player_Character ~= nil then
				if Player_Character:FindFirstChild("Animate") then
					Player_Character.Animate.ToggleSwim:Fire(charState)
				end
			end
			SFX["Splash_" .. StateValue]:Play()
			local s = true
			local data = u2
			if data == false or s == false then
				if charState == 0 then
					Main.GameStats.Ingame.Info.Air.Icons.DrainCount.Visible = false
					Main.GameStats.Ingame.Info.Air.Icons.Danger.Visible = false
					Main.GameStats.Ingame.Info.Air.Icons.Standard.Visible = true
					lastSurfaced = tick()
					bindSlideActions()
					if SlideButton ~= nil then
						SlideButton.Visible = true
					end
					SwimVelocity.MaxForce = Vector3.new(1, 0, 1)
					SwimVelocity.Velocity = Vector3.new(0, 0, 0)
					local rpv = Player_Character.Humanoid.RootPart.Velocity -- Root Part Velocity
					Player_Character.Humanoid.RootPart.Velocity = Vector3.new(rpv.X, Player_Character.Humanoid.JumpPower * 1.2, rpv.Z)
					if Player_Character.Head:FindFirstChild("Bubbles") then
						Player_Character.Head.Bubbles.Enabled = false
					end
					showedTip = false
					de_Tween = false
				elseif charState == 1 then
					Player_Character.Head.Bubbles.Enabled = true
					local State = WaterBody and (WaterBody:FindFirstChild("State") or WaterBody:FindFirstChild("WaterState"))
					if State ~= nil then
						if State:GetAttribute("NoSwim") or (State:GetAttribute("NoSwim") and State:GetAttribute("NoSwim") == false) then
							SwimVelocity.MaxForce = Vector3.new(1, 0, 1)
							SwimVelocity.Velocity = Vector3.new(0, 0, 0)
							if Player_Character ~= nil then
								if Player_Character:FindFirstChild("Animate") then
									Player_Character.Animate.ToggleSwim:Fire(0)
								end
							end
						else
							SwimVelocity.MaxForce = Vector3.new(0, 8000, 0)
							bindSwimActions()
						end
					else
						SwimVelocity.MaxForce = Vector3.new(0, 8000, 0)
						bindSwimActions()
					end
					local stateValue = (State and string.lower(State.Value)) or "water"
					if stateValue == "acid" then
						takeAir(tempAir)
						tempAir = 0
					end
					if stateValue ~= "lava" and charState == 1 then
						if Data.Main.controlPrompts.Property.Value == true and showedTip == false then
							newAlert("swimprompt", nil, nil, "prompt")
							showedTip = true
						end
					end
				end
			end
		end
		local State = WaterBody and (WaterBody:FindFirstChild("State") or WaterBody:FindFirstChild("WaterState"))
		local stateValue = (State and string.lower(State.Value)) or "water"
		if charState == 0 or gameState ~= "Playing" then
			if lastSurfaced < tick() - 1 then
				if basicAir < 100 then
					basicAir = basicAir + 16 * step
				else
					basicAir = 100
				end
			end
		elseif charState == 1 and gameState == "Playing" then
			lowestAir = basicAir < lowestAir and basicAir or lowestAir
			airDrainRate = (stateValue == "lava" and 75) or (stateValue == "acid" and 30) or 8
			--print(airDrainRate)
			local drainMultiplier = (State and State:GetAttribute("DrainMultiplier")) or 1
			airDrainRate = airDrainRate * drainMultiplier
			takeAir(airDrainRate * step)
			Main.GameStats.Ingame.Info.Air.Icons.Danger.Visible = (stateValue == "lava") or (stateValue == "acid")
			Main.GameStats.Ingame.Info.Air.Icons.Standard.Visible = not ((stateValue == "lava") or (stateValue == "acid"))
			local Color = Color3.new(0, 1, 0)
			if drainMultiplier > 0 then
				Color = Color3.new(1,0,0)
			end
			Main.GameStats.Ingame.Info.Air.Icons.DrainCount.TextColor3 = Color
			Main.GameStats.Ingame.Info.Air.Icons.DrainCount.Visible = true
			local str = ""
			if airDrainRate > 0 then
				str = tostring(airDrainRate)
			else
				str = tostring(airDrainRate * -1)
			end
			Main.GameStats.Ingame.Info.Air.Icons.DrainCount.Text = str .. "/s"
			if stateValue == "acid" then
				lastAcid = tick()
			end
			if (not (stateValue ~= "lava") or basicAir <= 0) and gameState == "Playing" then
				hum.Health = 0
				switchAir()
				if not showDB then
					showDB = true
					newAlert("You've Drowned!", Color3.fromRGB(231, 76, 60), 3)
				end
			end
		end
		local basicTemp = 0
		if tankAir - tempAir <= 0 then
			if tankAir > 0 then
				basicTemp = math.abs(tankAir - tempAir)
			else
				basicTemp = tempAir
			end
		end
		HUD.Main.GameStats.Ingame.Info.Air.Count.Text = math.floor(basicAir + tankAir)
		game:GetService("TweenService"):Create(IngameStats.AirBars.TankBar.Percentage, TweenInfo.new(0.1), {Size = UDim2.new(math.clamp((tankAir - tempAir)/400, 0, 1), 0, 1, 0)}):Play()
		game:GetService("TweenService"):Create(IngameStats.AirBars.BasicBar.Percentage, TweenInfo.new(0.1), {Size = UDim2.new((basicAir - basicTemp)/100, 0, 1, 0)}):Play()
		game:GetService("TweenService"):Create(IngameStats.AirBars.TankBar.Temp, TweenInfo.new(0.1), {Size = UDim2.new(math.clamp((tankAir - 0.1)/400, 0, 1), 0, 1, 0)}):Play()
		game:GetService("TweenService"):Create(IngameStats.AirBars.BasicBar.Temp, TweenInfo.new(0.1), {Size = UDim2.new((basicAir - 0.1)/100, 0, 1, 0)}):Play()
		if lastAcid < tick() - 1 and tempAir > 0 then
			tempAir = tempAir - 5 * step
		end
		if stateValue == "acid" then
			if tempAir < 20 then
				tempAir = tempAir + 20 * step
			end
		end
		--HandleBreath(Player_Character, WaterBody, gameState)
	end
	if humRtPt ~= nil and autoSlide == true then
		local ray = workspace:Raycast(humRtPt.Position + Vector3.new(0, 1, 0), Vector3.new(0, -1, 0) + (hum.MoveDirection) * 2, RaycastParams.new(Player_Character, Enum.RaycastFilterType.Blacklist, true, "Default", true))
		if ray then
			local s = ray.Instance
			if s.Name == "SlideBeam" then
				runSlide(nil, Enum.UserInputState.Begin, true)
			end
		end
	end
	if showRebirth then
		local S = Main.GameStats.Stats

		if S.Visible then
			local t_144 = time()
			local math_sin_t_144 = math.sin(t_144)
			local increment = math_sin_t_144 + 1
			local scaledIncrement = increment * 0.5
			local rebirthGlow = Main.GameStats.Stats.Rebirth.BG.Glow

			local colorFactor1 = 0.9 * scaledIncrement
			local colorFactor2 = 0.5 * scaledIncrement
			local colorFactor3 = 0.13 * scaledIncrement
			--print(colorFactor1, colorFactor2, colorFactor3)
			rebirthGlow.BackgroundColor3 = Color3.new(colorFactor1, colorFactor2, colorFactor3)
		end
	end
end
task.spawn(function() -- This is where I changed the error output to instead coreloop again which fixes it all.
	while true do
		
		local s, e = pcall(CoreLoop)
		if not s then
			CoreLoop()
		end
		
		--CoreLoop()
		step = game:GetService("RunService").Heartbeat:wait()
	end
end)
script.GetPlayerData.OnInvoke = function()
	return {
		PlayerState = gameState,
		Passes = CheckGamePasses(),
		Character = Player_Character,
	}
end
script.Notify.Event:Connect(newNotification)
rem.Notify.OnClientEvent:Connect(newNotification)
rem.UpdPlayerData.OnClientEvent:Connect(function(newData)
	Player_Data = newData
	UpdateStats()
end)
script.isSwimming.OnInvoke = function()
	return charState == 1
end
local lastCounter = 0
rem.UpdIngameStatus.OnClientEvent:Connect(function(data)
	if gameState == "Playing" then
		local plrCount = data.plrCount
		local btnCount = data.btnCount
		local IngameStats = Main.GameStats.Ingame
		if lastCounter ~= data.btnCount then
			lastCounter = data.btnCount
			spawn(function()
				IngameStats.Info.Buttons.ButtonIcon.Middle.ImageRectOffset = Vector2.new(128, 0)
				delay(0.25, function()
					IngameStats.Info.Buttons.ButtonIcon.Middle.ImageRectOffset = Vector2.new(0, 0)
				end)
				IngameStats.Info.Buttons.ButtonIcon.Border.ImageColor3 = Color3.new(0, 1, 0)
				IngameStats.Info.Buttons.ButtonIcon.Middle.ImageColor3 = Color3.new(0, 1, 0)
				IngameStats.Info.Buttons.Count.TextColor3 = Color3.new(0, 1, 0)
				for i = 0, 1.1, 0.016666666666667 do
					IngameStats.Info.Buttons.Count.TextColor3 = Color3.new(IngameStats.Info.Buttons.Count.TextColor3.r + 0.016666666666667, 1, 				IngameStats.Info.Buttons.Count.TextColor3.B + 0.016666666666667)
					IngameStats.Info.Buttons.ButtonIcon.Border.ImageColor3 = IngameStats.Info.Buttons.Count.TextColor3
					IngameStats.Info.Buttons.ButtonIcon.Middle.ImageColor3 = IngameStats.Info.Buttons.Count.TextColor3
					wait()	
				end	
			end)
		end
		IngameStats.Info.Buttons.Count.Text = btnCount
		IngameStats.Info.PlayerCount.Count.Text = plrCount
	end
end)
script.UpdateCurrentState.Event:Connect(function(new_state : string)
	gameState = new_state
	UpdateStats()
	if gameState == "Lobby" then
		if MenuButtons.Content:FindFirstChild("Menu_PlayMenu") then
			MenuButtons.Content.Menu_PlayMenu.Visible = true
			updBgm(game.ReplicatedStorage.Config:GetAttribute("LobbyMusic"))
			updLighting()
			CurrentState = "Playing"
			for index, item in next, PlayButtons_States.Playing do
				GUI_Buttons["Menu_PlayMenu"].Icon[index] = item
			end
			HUD.Main.GameStats.Ingame.Visible = false
			HUD.Main.GameStats.Stats.Visible = true
			CanTakeAir = false
			--HUD.Main.MenuButtons.Content.OpenList.Visible = true
			GUI_Buttons["Menu_PlayMenu"].Visible = true
			MenuButtons.Content.UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 5)
			MenuButtons.Content.UIGridLayout.CellSize = UDim2.new((1) / countAllVisibleButtons(v127.Main.MenuButtons.Content), 0, 1, 0)
			MenuButtons:TweenSize(UDim2.new(math.clamp((countAllVisibleButtons(MenuButtons.Content)) * 0.075, 0, math.huge), 0, 1, 0), "Out", "Quint", 0.325, true)
			HUD.Main.MenuButtons.Content.OpenList.Visible = false	
		end
	end
end)
Local_Player.CharacterAdded:Connect(CharacterAdded)
Local_Player.CharacterRemoving:Connect(CharacterRemoving)
script.Alert.Event:Connect(newAlert)
script.GetOptions.OnInvoke = function()
	return Data
end
rem.Alert.OnClientEvent:Connect(newAlert)
rem.GameStarted.OnClientEvent:Connect(function()
	local UI = game.Players.LocalPlayer.PlayerGui.GameGui.Waiting.UI
	local UI2 = game.Players.LocalPlayer.PlayerGui.GameGui.VoteMap
	UI.Visible = false
	UI2.Visible = false
	hasMoveInGame = false
	swimmables = workspace.Lobby.Waters:GetChildren()
	gameState = "Playing"
	updBoomboxes()
	tankAir = 0
	tempAir = 0
	maxTankAir = 0
	basicAir = 100
	lowestAir = basicAir
	local Settings = game.Workspace.Multiplayer:WaitForChild("Map"):WaitForChild("Settings")
	local MapUI = Settings:FindFirstChildWhichIsA("ScreenGui")
	if MapUI then
		MapUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MapUI_Folder")
	end
	--MenuButtons.Content.UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 5)
	local Map = game.Workspace.Multiplayer:WaitForChild("Map")
	riseList = {}
	riseVal = 30
	if Data.Main.isHighDetail.Property.Value == true then
		if Map:findFirstChild("Intro") then
			table.insert(riseList, Map.Intro)
		end
		for _, i in pairs(riseList) do
			i:TranslateBy(Vector3.new(0, -riseVal, 0))
		end
	end
	CanTakeAir = true
	HUD.Main.GameStats.Ingame.Visible = true
	local Time = (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("MaxTime")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("MaxTime") and Map:FindFirstChild("Settings"):FindFirstChild("MaxTime").Value) or 90
	HUD.Main.GameStats.Ingame.Info.Time.Record.Count.Text = formatTime(Time)
	HUD.Main.GameStats.Stats.Visible = false
	if locatorOn then
		Local_Player.PlayerGui.Locator.Locater.Visible = true
	else
		Local_Player.PlayerGui.Locator.Locater.Visible = false
	end
	script.Parent.Misc.CL_WaterColors.InitMap:Fire()
	local s = Map:WaitForChild("Settings")
	local l = s:WaitForChild("Lighting")
	--print(l)
	updLighting(l)
	updWater()
	script.Parent.Misc.CL_LocalEventWrapper.InitLocalEventScript:Fire()
	local map = Map
	local MapName = map.Settings:GetAttribute("MapName") or (map.Settings:FindFirstChild("MapName") and map.Settings.MapName.Value) or 0
	pcall(function()
		local soundID = map.Settings:GetAttribute("BGM") or (map.Settings:FindFirstChild("BGM") and map.Settings.BGM.Value) or 0
		updBgm(soundID, 0)
	end)
	for name, _ in next, l:GetAttributes() do
		l:GetAttributeChangedSignal(name):Connect(function()
			updLighting(l) --ur way of updating lighting
		end)
	end
	--HUD.Main.MenuButtons.Content.OpenList.Visible = true
	HUD.Main.MenuButtons.Content.OpenList.Visible = false
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	local v123 = HUD.Parent
	local v147 = HUD.Parent.MapIntro
	v147.Info.MapInfo.Visible = false
	v123.MapIntro.Info.MapInfo.Visible = true
	v123.MapIntro.Info.MapInfo.Text = Main_2.Info.MapInfo.Text
	v123.MapIntro.Info.MapInfo.TextColor3 = Main_2.Info.MapInfo.TextColor3
	v123.MapIntro.Info.MapInfo.Position = UDim2.new(0.5, 0, 0.1, 0)
	v123.MapIntro.Info.MapInfo.TextTransparency = 0
	v123.MapIntro.Info.MapInfo.TextStrokeTransparency = 0.625
	game:GetService("TweenService"):Create(v123.MapIntro.Info.MapInfo, TweenInfo.new(3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
		TextTransparency = 1, TextStrokeTransparency = 1, Position = UDim2.new(0.5, 0, 0, 0)
	}):Play()
end)
HUD.Main.MenuButtons.Content.OpenList.MouseButton1Click:Connect(function()
	v3593 = not v3593
	toggleMenuList(v3593)
end)
script.ViewMenu.Event:Connect(showMenu)
script.UpdSpectateCamera.Event:Connect(function(NewPlr : Player | nil)
	if NewPlr == nil then
		if workspace.CurrentCamera.CameraSubject ~= hum then
			workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
			workspace.CurrentCamera.CameraSubject = hum
			updBgm(game.ReplicatedStorage.Config:GetAttribute("LobbyMusic"))
			updLighting()
		end	
	else
		newAlert("Now Spectating")
		local map = game.Workspace.Multiplayer:FindFirstChild("Map")
		if map then
			local soundID = map.Settings:GetAttribute("BGM") or (map.Settings:FindFirstChild("BGM") and map.Settings.BGM.Value) or 0
			updLighting(map:FindFirstChild("Settings"):FindFirstChild("Lighting"))
			pcall(function()
				updBgm(soundID, game.ReplicatedStorage.Flags.ServerTime.Value - StartTime, 1, game.SoundService.Spectate_BGM)
			end)
			--workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
			local newText = NewPlr.Name
			if NewPlr.Name == NewPlr.DisplayName then
				newText = "@" .. NewPlr.DisplayName
			else
				newText = NewPlr.DisplayName .. "(@" .. NewPlr.Name .. ")"
			end
			newAlert(newText, nil, nil, nil, true)
			workspace.CurrentCamera.CameraSubject = NewPlr.Character:WaitForChild("Humanoid")
			NewPlr.Character.Humanoid.Died:connect(function()
				if cam.CameraSubject == NewPlr.Character.Humanoid then
					wait(1.5)
					if hum then
						cam.CameraSubject = hum
						if gameState ~= "Playing" then
							updLighting()
						end
						if gameState == "Waiting" then
							cam.CameraType = Enum.CameraType.Scriptable
						else
							cam.CameraType = "Custom"
						end
					end
				end
			end)
		else
			newAlert("Couldn't spectate", nil, nil, nil, true)
		end	
	end
end)
local LastSave = Player_Keybinds
rem.UpdOptions.OnClientEvent:Connect(function(arg1, arg2, arg3, arg4)
	if arg3 == "Controls" then
		Data.Controls[arg1].KeyString[arg4] = arg2
	elseif arg3 == "Others" then
		if Data.Others[arg1].Property.Type == "boolean" then
			Data.Others[arg1].Property.Value = not Data.Others[arg1].Property.Value
		elseif Data.Others[arg1].Property.Type == "cycle" then
			local data = Data.Others[arg1]
			local newIndex = nil
			if data.Property.Cycles[data.Property.Value + 1] == nil then
				newIndex = 1
			else
				newIndex = data.Property.Value + 1
			end
			data.Property.Value = newIndex
		elseif Data.Others[arg1].Property.Type == "manual" then
			Data.Others[arg1].Property.Value = arg4
		end
	else
		if Data.Main[arg1].Property.Type == "boolean" then
			Data.Main[arg1].Property.Value = not Data.Main[arg1].Property.Value
		elseif Data.Main[arg1].Property.Type == "cycle" then
			local data = Data.Main[arg1]
			local newIndex = nil
			if data.Property.Cycles[data.Property.Value + 1] == nil then
				newIndex = 1
			else
				newIndex = data.Property.Value + 1
			end
			data.Property.Value = newIndex
		elseif Data.Main[arg1].Property.Type == "manual" then
			Data.Main[arg1].Property.Value = arg4
		end
	end

	--Player_Data.Keybinds = Player_Keybinds
	Player_Data.OptionsData = Data
	for tableIndex, item in next, Data.Controls do
		if not Player_Keybinds[tableIndex] then
			Player_Keybinds[tableIndex] = {}
		end
		for Type, KeyTypes in next, item.KeyString do
			Player_Keybinds[tableIndex][Type] = KeyTypes
		end
	end
	rem.UpdateData:FireServer(Player_Data)
	--print(Data)
	script.RefreshOptions:Fire(Data)
	for tableIndex, item in next, Data.Controls do
		if not Player_Keybinds[tableIndex] then
			Player_Keybinds[tableIndex] = {}
		end
		for Type, KeyTypes in next, item.KeyString do
			Player_Keybinds[tableIndex][Type] = Enum.KeyCode[KeyTypes]
		end
	end
	applyOptions()
end)
rem.StartVoting.OnClientEvent:Connect(function()
	Local_Player.PlayerGui.GameGui.Waiting.CL_Waiting.IsVoting:Fire(gameState == "Won")
end)
rem.UpdateBar.OnClientEvent:Connect(function(newSize)
	game:GetService("TweenService"):Create(Local_Player.PlayerGui.GameGui.HUD.TimeBar.Percent, TweenInfo.new(0.1), {Size = UDim2.new(newSize,0,1,0)}):Play()
end)
rem.StartLoading.OnClientEvent:Connect(function(MapInfo, NumberOfPlayersLoading)
	RemoveButtonMenu("Menu_PlayMenu")
	updMapEventInfo()
	--print(gameState)
	script.CancelVoting:Fire()
	Local_Player.PlayerGui.LiftWaitVisual.Enabled = false
	Main_2 = game.Players.LocalPlayer.PlayerGui.GameGui.Loading.Main
	count = NumberOfPlayersLoading
	local UI = game.Players.LocalPlayer.PlayerGui.GameGui.Waiting.UI
	local UI2 = game.Players.LocalPlayer.PlayerGui.GameGui.VoteMap
	local Content = UI.Content
	UI.Visible = false
	UI2.Visible = false
	Main_2.Visible = true
	Main_2.Parent.Background.Size = UDim2.new(0,0,0,0)
	local MapImage = MapInfo.MapImage
	Main_2.Parent.Background.ImageTransparency = 0
	Main_2.Parent.Background.BackgroundTransparency = 0
	if MapImage == 0 then
		Main_2.Parent.Background.Image = ""
		Main_2.Parent.Background.ImageTransparency = 0
	else
		Main_2.Parent.Background.Image = "rbxassetid://" .. MapImage
		Main_2.Parent.Background.ImageTransparency = 0
	end
	local Map = game.Workspace.Multiplayer:WaitForChild("Map")
	if Data.Main.isHighDetail.Property.Value == false then
		setMapToLowDetail(game.Workspace.Multiplayer:WaitForChild("Map"))
	end
	local t = game:GetService("TweenService"):Create(Main_2.UIScale, popupInfo, {Scale = 1})
	local t_2 = game:GetService("TweenService"):Create(Main_2.Parent.Background, popupInfo, {Size = UDim2.new(1, 0, 1, 0)})
	t:Play() t_2:Play()
	local Map = MapInfo.Map
	local MapName = MapInfo.MapName
	local Creator = MapInfo.Creator
	local DifficultyFloor = math.floor(MapInfo.Difficulty)
	local NumberOfButtons = #MapInfo.Buttons
	Main_2.Info.LoadStatus.Bars.LoadingBar.Size = UDim2.new(0, 0, 1, 0)
	Main_2.Info.MapInfo.TextColor3 = FE2Library.Difficulties[DifficultyFloor][2]
	Main_2.Info.MapInfo.Text = `{MapName} [{FE2Library.Difficulties[DifficultyFloor][1]}] by {Creator}`
	Main_2.Info.LoadStatus.Bars.LoadingBar.BackgroundColor3 = FE2Library.Difficulties[DifficultyFloor][2]
	Main_2.Info.LoadStatus.LoadInfo.Text = "Loading Map Assets"
	Main_2.Info.LoadStatus.Anim.ImageColor3 = FE2Library.Difficulties[DifficultyFloor][2]
	Main_2.Info.Logo.ImageColor3 = FE2Library.Difficulties[DifficultyFloor][2]
	Main_2.Info.LoadStatus.Button.Count.Text = MapInfo.buttonCount
	Main_2.Info.LoadStatus.StarRating.RatingNumber.Text = MapInfo.Difficulty
	spawn(function()
		game:GetService("TweenService"):Create(Main_2.Info.LoadStatus.Anim, TweenInfo.new(0.25), {Rotation = 720}):Play()
		game:GetService("TweenService"):Create(Main_2.Info.LoadStatus.Bars.LoadingBar, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 1, 0)}):Play()
	end)
	local assetCount = #Map:GetDescendants()
	for index, item in ipairs(Map:GetDescendants()) do end
	--game:GetService("ContentProvider"):PreloadAsync({item})
	--local p = index/assetCount
	--game:GetService("TweenService"):Create(Main_2.Info.LoadStatus.Bars.LoadingBar, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.fromScale(p, 1)}):Play()
	--task.wait()	
	isDone = true
	Main_2.Info.LoadStatus.LoadInfo.Text = `Waiting for players {tostring(waitingCount)}/{tostring(count)}`
	game.ReplicatedStorage.Remote.PlayerFinishedLoading:FireServer()
end)
rem.UpdateLoadingCount.OnClientEvent:Connect(function(num)
	if num == 0 then
		--script.Parent.Visible = false
		local c = 3
		repeat
			Main_2.Info.LoadStatus.LoadInfo.Text = "Get Ready: " .. tostring(c)
			c -= 1
			wait(1)
		until c <= 0
		game:GetService("TweenService"):Create(Main_2.UIScale, popupInfo, {Scale = 0}):Play()
		Main_2.Parent.Background.ImageTransparency = 1
		Main_2.Parent.Background.BackgroundTransparency = 1
		count = 0
		isDone = false
		Main_2.Parent.Background.Image = ""
		Main_2.Parent.Background.ImageTransparency = 1
---- (MEEE go in cl main to read why)
hum.WalkSpeed = 20
hum.JumpPower = 50
----
	else
		if isDone then
			Main_2.Info.LoadStatus.LoadInfo.Text = `Waiting for players {tostring(num)}/{tostring(count)}`
		else
			waitingCount = num
		end
	end
end)
rem.ExitWon.OnClientEvent:Connect(function()
	for _, item in ipairs(workspace.Multiplayer:WaitForChild("Map"):GetDescendants()) do
		if item.Name == "ExitBlock" and item:IsA("BasePart") then
			item.CanCollide = true
		end
	end
	gameState = "Won"
	Local_Player.PlayerGui.Locator.Locater.Visible = false
	if Local_Player.PlayerGui.MapUI_Folder:FindFirstChildWhichIsA("ScreenGui") then
		Local_Player.PlayerGui.MapUI_Folder:FindFirstChildWhichIsA("ScreenGui"):Destroy()
	end
end)
function adjustActionButton(Button)
	if touchJump and Button then
		Button.Position = touchJump.Position - UDim2.new(UDim.new(0, 0), touchJump.Size.Y + UDim.new(0, 10))
		Button.Size = touchJump.Size
		local title = Button:findFirstChild("ActionTitle")
		if title then
			title.Size = UDim2.new(0.75, 0, 0.75, 0)
			title.Position = UDim2.new(0.125, 0, 0.125, 0)
			title.TextXAlignment = "Center"
			title.TextYAlignment = "Center"
			title.TextScaled = true
		end	
	end
end
function bindSlideActions()
	if charState == 0 then
		ContextActionService:UnbindAction("swimJump")
		ContextActionService:UnbindAction("swimDive")
		if UserInputService.GamepadEnabled then
			ContextActionService:BindAction("runSlide", runSlide, true, 3000, Player_Keybinds.RUNSLIDE.GamePad)    
		else
			ContextActionService:BindAction("runSlide", runSlide, true, Player_Keybinds.RUNSLIDE.Keyboard)      	
		end
		local slide = ContextActionService:GetButton("runSlide")
		ContextActionService:SetTitle("runSlide", "Slide")
		adjustActionButton(slide)
	end
end
function bindSwimActions()
	if charState == 1 then
		ContextActionService:UnbindAction("runSlide")
		if UserInputService.GamepadEnabled then
			ContextActionService:BindAction("swimJump", swimJump, false, Player_Keybinds.SWIMJUMP.GamePad)
			ContextActionService:BindAction("swimDive", swimDive, true, Player_Keybinds.SWIMDIVE.GamePad)
		else
			ContextActionService:BindAction("swimJump", swimJump, false, Player_Keybinds.SWIMJUMP.Keyboard)
			ContextActionService:BindAction("swimDive", swimDive, true, Player_Keybinds.SWIMDIVE.Keyboard)
		end
		ContextActionService:SetTitle("swimDive", "Dive")
		local dive = ContextActionService:GetButton("swimDive")
		adjustActionButton(dive)
	end
end
rem.TweenLobby.OnClientEvent:Connect(function()
	gameState = "Waiting"
	updBgm(1841647093, 0, 0.5) -- lift music
	CurrentState = "Exit"
	for index, item in next, PlayButtons_States.Exit do
		GUI_Buttons["Menu_PlayMenu"].Icon[index] = item
	end
	Player_Character:MoveTo(game.Workspace.Lobby.WaitingArea.WaitTeleport.Position + Vector3.new(0, 3, 0))
	script.AddWaiting:Fire()
end)
rem.ReqPlayerState.OnClientInvoke = function()
	return gameState
end
script.TelePrompt.Event:connect(function(p111)
	local v4453 = p111.promptText
	if not v4453 then
		v4453 = "You are requesting to teleport to " .. p111.frm.Name .. ". Are you sure?"
	end
	local v4454 = "Game Teleport"
	local v4455 = function()
		print("Teleporting to", p111.ID)
		rem.ReqTele:FireServer(p111.ID, p111)
	end
	newNotification(v4453, v4454, v4455)
end)
UserInputService.GamepadConnected:Connect(applyOptions)
rem.MapAdded.OnClientEvent:Connect(function()
	StartTime = time()
end)
local lastIndex = 0

local scoller_msg = Local_Player.PlayerGui:WaitForChild("Chat").Frame.ChatChannelParentFrame.Frame_MessageLogDisplay.Scroller :: ScrollingFrame
local ChatAlerts = {}
rem.ChatAlert.OnClientEvent:Connect(function(tab, message)
	local f = nil
	repeat
		task.wait()
		local c = scoller_msg:GetChildren()
		for i, v in ipairs(c) do
			local text = v:FindFirstChildWhichIsA("TextLabel")
			if text then
				if string.match(text.Text, message) then
					local sel
					for _, x in next, ChatAlerts do
						if x.TextLable == text then
							sel = x
						end
					end
					if sel ~= nil then
						if sel.Index == v.LayoutOrder then
							continue
						end
					end
					table.insert(ChatAlerts, {Text = text.Text, Index = v.LayoutOrder, TextLable = text})
					f = v
					break
				end
			end
		end
	until f ~= nil
	local c = scoller_msg:GetChildren()
	local frame = f:Clone() :: Frame
	if frame:FindFirstChild("TextLabel"):FindFirstChildWhichIsA("TextButton") then
		local btn = frame:FindFirstChild("TextLabel"):FindFirstChildWhichIsA("TextButton")
		btn:Destroy()
	end
	frame.Parent = scoller_msg
	frame.LayoutOrder = f.LayoutOrder - 1
	local t = frame:FindFirstChildWhichIsA("TextLabel")
	t.RichText = true
	t.Text = tab.Text
	t.TextColor3 = tab.Color or Color3.new(1, 1, 1)
	spawn(function()
		while wait() do
			if not f:FindFirstChild("TextLabel") then
				t:Destroy()
				break
			end
			t.TextTransparency = f:FindFirstChild("TextLabel").TextTransparency
		end
	end)
end)
rem.LvlUp.OnClientEvent:Connect(function(gemAmount)
	spawn(function()
		local sfxFolder = Local_Player.PlayerScripts.SFX_Folder
		local lvlUpSFX = sfxFolder.LvlUp

		ContentProvider:Preload("rbxassetid://6993345156")
		ContentProvider:Preload("rbxassetid://983016958")

		while v137.Visible do
			wait()
		end

		lvlUpSFX:Play()

		local lvlUpUI = GameGUI.LvlUp
		lvlUpUI.Award.Text = "+" .. gemAmount .. " Gems"
		lvlUpUI.Award.TextTransparency = 0
		lvlUpUI.Award.TextStrokeTransparency = 0.65
		lvlUpUI.Info.TextTransparency = 0
		lvlUpUI.Info.TextStrokeTransparency = 0
		lvlUpUI.Fade.ImageTransparency = 0
		lvlUpUI.Fade.UIScale.Scale = 0
		lvlUpUI.Visible = true

		local tweenService = game:GetService("TweenService")
		local fadeTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local fadeOutTweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local textFadeOutTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

		tweenService:Create(lvlUpUI.Fade.UIScale, fadeTweenInfo, { Scale = 2 }):Play()
		tweenService:Create(lvlUpUI.Fade, fadeOutTweenInfo, { ImageTransparency = 1 }):Play()

		wait(4)

		tweenService:Create(lvlUpUI.Info, textFadeOutTweenInfo, { TextTransparency = 1, TextStrokeTransparency = 1 }):Play()
		tweenService:Create(lvlUpUI.Award, textFadeOutTweenInfo, { TextTransparency = 1, TextStrokeTransparency = 1 }):Play()
		tweenService:Create(lvlUpUI.Fade, textFadeOutTweenInfo, { ImageTransparency = 1 }):Play()

		wait(1)

		lvlUpUI.Visible = false
	end)
end)
Main.GameStats.Stats.Rebirth.MouseButton1Click:connect(function()
	local function newFunc()
		rem.ReqRebirth:FireServer()
		--print("Sent Rebirth Request")
	end
	newNotification("By rebirthing you will return to level 1 and be able to earn gems by levelling up again. The Rebirth cap is 30. Are you sure you want to Rebirth?", "Rebirth", newFunc)
end)
rem.ReqRescue.OnClientInvoke = function()
	local bool_1 = (workspace.CurrentCamera:FindFirstChild("NPC") and true) or false
	return bool_1
end
v137.Window.Confirm.MouseButton1Click:connect(closeNotif)
v137.Window.Choices.No.MouseButton1Click:connect(function()
	function notifyFunc()
	end
	closeNotif()
end)
v137.Window.Choices.Yes.MouseButton1Click:connect(function()
	notifyFunc()
	function notifyFunc()
	end
	closeNotif()
end)
UserInputService.GamepadDisconnected:Connect(applyOptions)
local v4811 = Local_Player.PlayerGui
local v4814 = v4811:WaitForChild("MenuGui"):FindFirstChild("PlayMenu")
if not v4814 then
	v4811 = script.Resources
	v4814 = v4811.PlayMenu
	v4811 = Local_Player.PlayerGui.MenuGui
	v4814:Clone().Parent = v4811
end
applyOptions()
function intAuraUpd(plr)
	if plr.Character then
		updAuraVisible(plr.Character)
	end
	plr.CharacterAdded:connect(updAuraVisible)
end
for _, p in pairs(game.Players:GetPlayers()) do
	intAuraUpd(p)
end

function setupMouseLockController()
	local v4825 = ((game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):WaitForChild("CameraModule")):WaitForChild("MouseLockController")
	local v4827 = Instance.new("StringValue")
	v4827.Name = "CursorImage"
	v4827.Value = "rbxassetid://7090151616"
	v4827.Parent = v4825
	local v4830 = Instance.new("Vector3Value")
	v4830.Name = "CameraOffset"
	v4830.Value = Vector3.new(1.75, 0, 0)
	v4830.Parent = v4825
	local v4837 = v4825:FindFirstChild("BoundKeys")
	if v4837 then
		v4837 = v4825.BoundKeys
		v4837.Value = v4825.BoundKeys.Value .. ",ButtonR1"
		print("Added ButtonR1 To MouseLockController's BoundKeys")
	end
	print("Set Up Mouse Lock Controller")
end
setupMouseLockController()
print(script.Name, "initialised")
script.isSliding.OnInvoke = function()
	return u2
end

script.isSlideDiving.OnInvoke = function()
	return slideDiving
end