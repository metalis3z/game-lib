wait(0.5)
plr = game.Players.LocalPlayer
mouse = plr:GetMouse()
repeat wait() until plr:FindFirstChild("PlayerGui") and plr.PlayerGui:FindFirstChild("Menu") == nil
repeat wait() until plr.Character and plr.Character.Parent and plr.Character:FindFirstChild("HumanoidRootPart") and plr:FindFirstChild("Selector") == nil or plr.Character and plr.Character.Parent and plr.Character:FindFirstChild("HumanoidRootPart") and plr:FindFirstChild("Selector") and plr:FindFirstChild("Selector").Value == false and plr:FindFirstChild("Backpack")
char = plr.Character
hmr = char.HumanoidRootPart
human = char.Humanoid
cam = workspace.CurrentCamera
event = script.Parent.RemoteEvent
userInputService = game:GetService("UserInputService")

local oldchat = game.Players.LocalPlayer.PlayerGui.Chat -- Location of Roblox's chat
oldchat.Frame.ChatChannelParentFrame.Visible = false -- Makes the old chat invisible, but not the bar
oldchat.Frame.ChatBarParentFrame.Position = UDim2.new(0,0,0,0) -- Sets the position of the bar to the top left

cam.CameraType = "Custom"
plr.CameraMode = "Classic"

recoil = plr:FindFirstChild("Recoil")
if recoil == nil then
	recoil = Instance.new("NumberValue")
	recoil.Name = "Recoil"
	recoil.Parent = plr
	recoil2 = Instance.new("IntValue")
	recoil2.Name = "Recoil2"
	recoil2.Value = 1
	recoil2.Parent = recoil
end

--[[human.JumpPower = 25
basespeed = 12
runspeed = 18]]

local camPar = cam:FindFirstChild("DeathFocus")
if camPar then
	camPar:Destroy()
end
camPar = Instance.new("Part")
camPar.Name = "DeathFocus"
camPar.Size = Vector3.new(1, 1, 1)
camPar.Anchored = true
camPar.Transparency = 1
camPar.Position = Vector3.new(0, 5000000, 0)
camPar.Parent = cam

cam.CameraSubject = human

plr.CameraMaxZoomDistance = game.StarterPlayer.CameraMaxZoomDistance
plr.CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance

inthird = true
userInputService.MouseIconEnabled = true
mouse.Icon = ""

game.Workspace.CurrentCamera.FieldOfView = 70

mouseSens = plr:FindFirstChild("MouseSensitivityValue")
if not mouseSens then
	mouseSens = Instance.new("NumberValue")
	mouseSens.Name = "MouseSensitivityValue"
	mouseSens.Value  = 1
	mouseSens.Parent = plr
end
gui = script.Parent.MainGui
speech = gui.Speech

--human.WalkSpeed = basespeed

oldsens = mouseSens:FindFirstChild("OldValue")
if oldsens == nil then
	oldsens = Instance.new("NumberValue")
	oldsens.Name = "OldValue"
	oldsens.Value  = userInputService.MouseDeltaSensitivity
	oldsens.Parent = mouseSens
end

mouse.Icon = ""

local WorldToCellFunction = game.Workspace.Terrain.WorldToCellPreferSolid
local GetCellFunction = game.Workspace.Terrain.GetCell

function RayIgnoreCheck4(hit, pos)
	if hit then
		if hit.Transparency >= 1 or string.lower(hit.Name) == "water" or
				hit.Name == "Effect" or hit.Name == "Rocket" or hit.Name == "Bullet" or
				hit.Name == "Handle" or hit:IsDescendantOf(char) or hit:IsDescendantOf(workspace.CurrentCamera) or hit.CanCollide == false or hit.Parent:FindFirstChild("Humanoid") or hit.Name == "Shell" or hit.Parent:IsA("Tool") then
			return true
		elseif hit:IsA('Terrain') and pos then
			local cellPos = WorldToCellFunction(game.Workspace.Terrain, pos)
			if cellPos then
				local cellMat = GetCellFunction(game.Workspace.Terrain, cellPos.x, cellPos.y, cellPos.z)
				if cellMat and cellMat == Enum.CellMaterial.Water then
					return true
				end
			end
		end
	end
	return false
end

-- @preconditions: vec should be a unit vector, and 0 < rayLength <= 1000
function RayCast4(startPos, vec, rayLength)
	local hitObject, hitPos, surface, material = game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(startPos + (vec * .01), vec * rayLength), ignores, false, true)
	if hitObject and hitPos then
		local distance = rayLength - (hitPos - startPos).magnitude
		if RayIgnoreCheck4(hitObject, hitPos) and distance > 0 then
			table.insert(ignores, hitObject)
			-- there is a chance here for potential infinite recursion
			return RayCast4(startPos, vec, rayLength)
		end
	end
	if hitObject then
		--print(hitObject.Name)
	end
	return hitObject, hitPos, surface, material
end

mouse.KeyDown:connect(function(key)
	--[[if string.byte(key) == 48 and char:FindFirstChild("Downed") == nil and char:FindFirstChild("Grabbing") == nil then
		human.WalkSpeed = runspeed
	end]]
	--[[if key == "p" and not viewcool then
		viewcool = true
		if not inthird then
			inthird = true
			plr.CameraMode = "Classic"
			plr.CameraMaxZoomDistance = game.StarterPlayer.CameraMaxZoomDistance
			plr.CameraMinZoomDistance = 5
			game:GetService("UserInputService").MouseIconEnabled = true
			event:FireServer(mouse.Hit.p, mouse.Origin.p, OldNeckC0, OldNeckC1, OldShoulderC0, OldShoulderC1, OldShoulder2C0, OldShoulder2C1, inthird)
		else
			inthird = false
			plr.CameraMode = "LockFirstPerson"
			plr.CameraMaxZoomDistance = 0.5
			plr.CameraMinZoomDistance = 0.5
			
			if char:FindFirstChildOfClass("Tool") and human.Health > 0 then
				if char:FindFirstChildOfClass("Tool"):FindFirstChild("FireScript") then
					game:GetService("UserInputService").MouseIconEnabled = true
				end
			end
			
			if char:FindFirstChild("GUNAIMVALUE") then
				--invis()
			else
				for i=1, 20 do
					wait()
					vis()
				end
			end
			
			event:FireServer(mouse.Hit.p, mouse.Origin.p, OldNeckC0, OldNeckC1, OldShoulderC0, OldShoulderC1, OldShoulder2C0, OldShoulder2C1, inthird)
		end
		
		viewcool = false
	end]]
end)

--[[mouse.KeyUp:connect(function(key)
	if string.byte(key) == 48 and char:FindFirstChild("Downed") == nil and char:FindFirstChild("Grabbing") == nil then
		human.WalkSpeed = basespeed
	end
end)]]

oldval = math.random()*9999999
--print(oldval)
mouse.WheelForward:connect(function()
	if not inthird and not viewcool and char:FindFirstChild("GUNAIMVALUE") then
	if mouseSens.Value < 4.95 then
		mouseSens.Value = mouseSens.Value + 0.05
	end
	
	speech.Text = mouseSens.Value
	speech.Visible = true
	
	oldval = math.random()*9999999
	local older = oldval
	delay(1, function()
		if older == oldval then
			speech.Visible = false
		end
	end)
	end
end)

mouse.WheelBackward:connect(function()
	if not inthird and not viewcool and char:FindFirstChild("GUNAIMVALUE") then
	if mouseSens.Value > 0.15 then
		mouseSens.Value = mouseSens.Value - 0.05
	else
		mouseSens.Value = 0.1
		end
	
	speech.Text = mouseSens.Value
	speech.Visible = true
	
	oldval = math.random()*9999999
	local older = oldval
	delay(1, function()
		if older == oldval then
			speech.Visible = false
		end
	end)
	end
end)

local WorldToCellFunction = game.Workspace.Terrain.WorldToCellPreferSolid
local GetCellFunction = game.Workspace.Terrain.GetCell

function RayIgnoreCheck2(hit, pos)
	if hit then
		if hit.Transparency >= 1 or string.lower(hit.Name) == "water" or
				hit.Name == "Effect" or hit.Name == "Rocket" or hit.Name == "Bullet" or
				hit.Name == "Handle" or hit:IsDescendantOf(char) or hit:IsDescendantOf(workspace.CurrentCamera) or hit.CanCollide == false and hit.Parent:FindFirstChild("Humanoid") == nil or hit.Name == "Shell" or hit.Parent:IsA("Tool") then
			return true
		elseif hit:IsA('Terrain') and pos then
			local cellPos = WorldToCellFunction(game.Workspace.Terrain, pos)
			if cellPos then
				local cellMat = GetCellFunction(game.Workspace.Terrain, cellPos.x, cellPos.y, cellPos.z)
				if cellMat and cellMat == Enum.CellMaterial.Water then
					return true
				end
			end
		end
	end
	return false
end

-- @preconditions: vec should be a unit vector, and 0 < rayLength <= 1000
function RayCast2(startPos, vec, rayLength, list)
	local hitObject, hitPos, surface, material = game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(startPos + (vec * .01), vec * rayLength), list, false, true)
	if hitObject and hitPos then
		local distance = rayLength - (hitPos - startPos).magnitude
		if RayIgnoreCheck2(hitObject, hitPos) and distance > 0 then
			table.insert(list, hitObject)
			-- there is a chance here for potential infinite recursion
			return RayCast2(startPos, vec, rayLength, list)
		end
	end
	if hitObject then
		--print(hitObject.Name)
	end
	return hitObject, hitPos, surface, material
end

function SetMouseSensitivity(Sensitivity)
	--[[local Camera = cam
	if MouseSensivityConnection then
		MouseSensivityConnection:disconnect()
	end
	local function EulerAnglesYX(cframe)
		local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:components(cframe)
		return -math.asin(R12), ((math.abs(R12) > 0.99999 and -math.atan2(-R20, R00)) or -math.atan2(-R02, R22))
	end	
	local DirectionX, DirectionY = EulerAnglesYX(Camera.CoordinateFrame)	
	local function UpdateSensitivity()
		local CFrameX, CFrameY = EulerAnglesYX(Camera.CoordinateFrame)
		DirectionX = (DirectionX * (1 - Sensitivity) + (CFrameX + (math.pi * 2) * math.floor((DirectionX - CFrameX) / (math.pi * 2) + 0.5)) * Sensitivity)
		DirectionY = (DirectionY * (1 - Sensitivity) + (CFrameY + (math.pi * 2) * math.floor((DirectionY - CFrameY) / (math.pi * 2) + 0.5)) * Sensitivity)
		Camera.CoordinateFrame = (CFrame.Angles(0, DirectionY, 0) * CFrame.Angles(DirectionX, 0, 0) * CFrame.new(0, 0, 0.5) + Camera.Focus.p)
	end
	MouseSensivityConnection = game["Run Service"].RenderStepped:connect(UpdateSensitivity)]]
	userInputService.MouseDeltaSensitivity = Sensitivity
end	

--game:GetService("UserInputService").MouseIconEnabled = false

torso = char:FindFirstChild("UpperTorso")
head = char:FindFirstChild("Head")
Neck = head["Neck"]
OldNeckC0 = Neck.C0
OldNeckC1 = Neck.C1
rua = char:FindFirstChild("RightUpperArm")
lua = char:FindFirstChild("LeftUpperArm")
Shoulder = rua["RightShoulder"]
Shoulder2 = lua["LeftShoulder"]
OldShoulderC0 = Shoulder.C0
OldShoulderC1 = Shoulder.C1
OldShoulder2C0 = Shoulder2.C0
OldShoulder2C1 = Shoulder2.C1

xAngle = 0
yAngle = 0

local uis = game:GetService('UserInputService')
runService = game:GetService("RunService")
inputloop = userInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		xAngle = xAngle-input.Delta.x*0.4
		--Clamp the vertical axis so it doesn't go upside down or glitch.
		yAngle = math.clamp(yAngle-input.Delta.y*0.4,-80,80)
	end
end)

userInputService.MouseBehavior = Enum.MouseBehavior.Default

oldstate = nil
human.StateChanged:connect(function()
	if human:GetState() ~= Enum.HumanoidStateType.Seated and oldstate ==  Enum.HumanoidStateType.Seated then
		oldstate = human:GetState()
		--for i=1 ,10 do
			wait()
			changeVisible(char, "fps")
		--end
	end
	
	if human:GetState() == Enum.HumanoidStateType.Seated then
		oldstate = human:GetState()
		--for i=1 ,10 do
			wait()
			changeVisible(char, "fps")
		--end
	end
	
	oldstate = human:GetState()
end)

game["Run Service"].RenderStepped:connect(function()
	if human.Health <= 0 or char.Parent == nil then
		inuse = false
		cam.CameraType = Enum.CameraType.Custom
		human.AutoRotate = true
		--[[gui.ScreenFree.Visible = true
		if camPar then
			cam.CFrame = camPar.CFrame
		end
		if not hasDied then
			hasDied = true
			script.DeathSound:Play()
		end]]
		return
	end
	
	if not inuse and char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("SwordGui") and char:FindFirstChildOfClass("Tool"):FindFirstChild("Ready") and char:FindFirstChildOfClass("Tool"):FindFirstChild("Ready").Value == true then
		inuse = true
		uis.MouseIconEnabled = false
		lastpos = hmr.Position
		cam.CameraType = Enum.CameraType.Scriptable
		cnt = 0
		for i=1 ,10 do
			wait()
			changeVisible(char, "vis", true)
		end
		
	elseif inuse and not (char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("SwordGui") and char:FindFirstChildOfClass("Tool"):FindFirstChild("Ready") and char:FindFirstChildOfClass("Tool"):FindFirstChild("Ready").Value == true) then
		inuse = false
		cam.CameraType = Enum.CameraType.Custom
		human.AutoRotate = true
		game:GetService("UserInputService").MouseIconEnabled = true
	end
	
	if char.Parent and human.Health > 0 and char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("SwordGui") and char:FindFirstChildOfClass("Tool"):FindFirstChild("Ready") and char:FindFirstChildOfClass("Tool"):FindFirstChild("Ready").Value == true then
		lastpos = lastpos:Lerp(hmr.Position, 0.1)
		local cameraPos = Vector3.new(0, 0, 10)
		local cammain = cameraPos
	
		
		userInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		local startCFrame = CFrame.new((lastpos + Vector3.new(0,2,0)))*CFrame.Angles(0, math.rad(xAngle), 0)*CFrame.Angles(math.rad(yAngle), 0, 0)
		
	--Set camera focus and cframe
		local cameraCFrame = startCFrame + startCFrame:vectorToWorldSpace(Vector3.new(cameraPos.X,cameraPos.Y,cameraPos.Z))
		local cameraFocus = startCFrame + startCFrame:vectorToWorldSpace(Vector3.new(cameraPos.X,cameraPos.Y,-50000))
		
		
		ignores = {}
		--shootDirection = (mouse.Hit.p - mouse.Origin.p).unit
		local rot = cam.CFrame - cam.CFrame.p
		local hit, position1, surface, material = RayCast2((hmr.CFrame * rot).p, cam.CFrame.LookVector, 1000, ignores)
		
		if human:GetState() ~= Enum.HumanoidStateType.Seated and human:GetState() ~= Enum.HumanoidStateType.Swimming then
			hmr.CFrame = hmr.CFrame:Lerp(CFrame.new(hmr.Position, hmr.Position + (Vector3.new(position1.x, hmr.Position.Y, position1.z)-hmr.Position).unit), cnt/50)
		end	
		
		human.AutoRotate = false
		
		if cnt < 50 then
			cnt = cnt + 1
			cam.CFrame = cam.CFrame:Lerp(CFrame.new(cameraCFrame.p,cameraFocus.p), cnt/50) 
		else
			cam.CFrame = cam.CFrame:Lerp(CFrame.new(cameraCFrame.p,cameraFocus.p), 1)
		end
	end
	
	
	if (cam.CFrame.p - cam.Focus.p).magnitude <= 0.6 then
		if inthird then
			--print("a")
			inthird = false
			--mouse.Icon = "http://www.roblox.com/asset/?id=93533362"
			human.CameraOffset = Vector3.new(human.CameraOffset.x, human.CameraOffset.y, -1)
			for i=1, 10 do
				wait()
				changeVisible(char, "fps")
			end
		end
		
	else
		if not inthird then
			inthird = true
			human.CameraOffset = Vector3.new(human.CameraOffset.x, human.CameraOffset.y, 0)
			changeVisible(char, "vis", true)
		end
	end
	
	recoil.Value = recoil.Value * 0.6
	if char and char:FindFirstChild("CameraCenterValue") then
		cam.CameraType = "Scriptable"
		local ccv = char:FindFirstChild("CameraCenterValue")
		local icf = ccv.InstantFrame
		
		if not ccv.Value then
			cam.Focus = icf.Value
			cam.CFrame = icf.Value
		else
			cam.Focus = ccv.Value.CFrame
			cam.CFrame = cam.CFrame:Lerp(ccv.Value.CFrame, 0.01)
		end
		
		hasValued = true
	else
		if hasValued then
			cam.CameraType = "Custom"
			hasValued = false
		end
	end
	--mouse.TargetFilter = workspace
	if cam:FindFirstChild("UpperTorso") and char:FindFirstChildOfClass("Tool") == nil then
		if char:FindFirstChild("GUNAIMVALUE") then
			char:FindFirstChild("GUNAIMVALUE"):Destroy()
		end
		
		if cam:FindFirstChild("UpperTorso") then
			cam:FindFirstChild("UpperTorso"):Destroy()
			faketorso = nil
			
			Shoulder.C0 = OldShoulderC0
			Shoulder.C1 = OldShoulderC1
			Shoulder2.C0 = OldShoulder2C0
			Shoulder2.C1 = OldShoulder2C1
			Shoulder.Part0 = torso
			Shoulder2.Part0 = torso
		end
	end
	
	if char == nil or char.Parent == nil or human == nil or human.Health <= 0 then
		return
	end
	
	if (cam.CFrame.p - cam.Focus.p).magnitude <= 0.6 then
		if char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("GunScript") then
			mouse.Icon = "http://www.roblox.com/asset/?id=423604832"
		else
			mouse.Icon = "http://www.roblox.com/asset/?id=93533362"
		end
	end
	
	--game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	if char:FindFirstChild("GUNAIMVALUE") then
		SetMouseSensitivity(mouseSens.Value * cam.FieldOfView/70)
		plr.CameraMode = "LockFirstPerson"
	else
		SetMouseSensitivity(oldsens.Value)
		plr.CameraMode = "Classic"
		if MouseSensivityConnection then
			MouseSensivityConnection:disconnect()
		end
		end
	
	if char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues") and not lv then
		lv = true
		invis()
	elseif not (char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues")) and lv then
		lv = false
		
		vis()
	end
	
	local humO = (torso.Position - hmr.Position)
	
	if human and human.RootPart and char:FindFirstChild("Downed") == nil then
			ws = human.WalkSpeed
			
			local now = tick()
	if human.MoveDirection.Magnitude > 0 then -- Are we walking?
		local velocity = human.RootPart.Velocity
		local bobble_X = math.cos(now * 9) / 5
		local bobble_Y = math.abs(math.sin(now * 12)) / 5
		
		local wsBob = 16/human.WalkSpeed
		if char:FindFirstChild("GUNAIMVALUE") then
			wsBob = 50 * (70/cam.FieldOfView)
		end
		if human:GetState() == Enum.HumanoidStateType.Seated or (cam.CFrame.p - cam.Focus.p).magnitude > 0.6 then
			wsBob = 9000
		end
		
		local bobble = Vector3.new(bobble_X,bobble_Y,0) * math.min(1, velocity.Magnitude / (wsBob))
		local offs = humO
		if char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues") then
			offs = char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues").Offset.Value
		end
		human.CameraOffset = human.CameraOffset:lerp(Vector3.new(bobble.x, offs.y + bobble.y, human.CameraOffset.z),.25)
	else
		-- Scale down the CameraOffset so that it shifts back to its regular position.
		local offs = humO
		if char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues") then
			offs = char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues").Offset.Value
		end
		
		human.CameraOffset = Vector3.new(human.CameraOffset.x * 0.75, (offs.y * 0.25) + (human.CameraOffset.y * 0.75), human.CameraOffset.z)
	end
	
	if char:FindFirstChild("Head") and char:FindFirstChild("UpperTorso") and char:FindFirstChildOfClass("Tool") and not inthird then
		--mouse.Icon = "http://www.roblox.com/asset/?id=423604832"
		
	--char.Torso.Neck.C1 = CFrame.new() --Sets the C1 to a blank CFrame so the head doesn't glitch.
 	--[[char.Torso["Right Shoulder"].C1 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 1.5, 0)
	char.Torso["Right Shoulder"].C0 = CFrame.new(1.2, 0.5, -1) * CFrame.Angles(math.asin((mouse.Origin.p - cam.CFrame.p).unit.y), 1.5, 0)
	char.Torso["Left Shoulder"].C1 = CFrame.new(0, 0, 0) * CFrame.Angles(0, -1.5, 0)
char.Torso["Left Shoulder"].C0 = CFrame.new(-1.2, 0.5, -1) * CFrame.Angles(math.asin((mouse.Hit.p - mouse.Origin.p).unit.y), -1.5, 0)]]

	if not faketorso then
		faketorso = torso:Clone()
		faketorso:ClearAllChildren()
		faketorso.CanCollide = false
		faketorso.Transparency = 1
		faketorso.Anchored = true
		faketorso.Parent = cam
	end
	
	--[[local ignores = {}
	local og = mouse.Origin.p
	local hit, position, surface, material = RayCast2(mouse.Origin.p,  cam.CFrame.LookVector, 5, ignores)]]
	local dist = 0
	--[[if hit then
		dist = (5/((position - hmr.Position).Magnitude))-1
		print(dist)
	end]]
	
	Shoulder.C0 = OldShoulderC0
	Shoulder.C1 = OldShoulderC1
	Shoulder2.C0 = OldShoulder2C0
	Shoulder2.C1 = OldShoulder2C1
	
	if not tweening then
		tweening = true
		aimtween = 0
	end
	
	if char:FindFirstChild("GUNAIMVALUE") then
		--oldgv = char:FindFirstChild("GUNAIMVALUE").Value
		if offaim then
			offaim = false
			aimtween = 0
			oldgv = char:FindFirstChild("GUNAIMVALUE").Value
		end
		
		if not oldgv or oldgv ~= char:FindFirstChild("GUNAIMVALUE").Value then
			oldgv = char:FindFirstChild("GUNAIMVALUE").Value
			aimtween = 0.2
		end
		
		aimtween = aimtween + 0.1
		if aimtween > 1 then
			aimtween = 1
		end
		
		onaim = true
		
		local offs = 0
		if char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues") then
			offs = char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues").Offset.Value.y
		end
		
		local tool = char:FindFirstChildOfClass("Tool")
		local am = tool.Aim
		
		tool.Aim.CFrame = tool.Aim.CFrame:Lerp(cam.CFrame * CFrame.new(human.CameraOffset.x/50, (-offs + human.CameraOffset.y)/50 + (math.abs(recoil.Value/4)*(1 * (cam.FieldOfView/70))), -0.5+(2*dist)+(2*math.abs(recoil.Value)*(1 * (cam.FieldOfView/70)))) * CFrame.Angles(math.pi*(math.abs(recoil.Value)*(0.1* (cam.FieldOfView/70))), math.pi*(math.abs(recoil.Value)*0), math.pi*oldgv), aimtween)
		
		--tool.Aim.CFrame = tool.Aim.CFrame:Lerp(cam.CFrame * CFrame.new(human.CameraOffset.x/5, (-offs + human.CameraOffset.y)/5 - (math.abs(recoil.Value)*(1 * (cam.FieldOfView/70))), -0.5+(2*dist)) * CFrame.Angles(math.pi*(math.abs(recoil.Value)*(0.1* (cam.FieldOfView/70))), math.pi*(math.abs(recoil.Value)*0), math.pi*oldgv), aimtween)
		--faketorso.CFrame = faketorso.CFrame:Lerp(cam.CFrame * CFrame.new(human.CameraOffset.x - (1 * (game.Workspace.CurrentCamera.FieldOfView / 70)), (-offs + human.CameraOffset.y) + -1.5, -(1 * (70 / game.Workspace.CurrentCamera.FieldOfView)) +(2*dist)), aimtween)
		
		--local cfVal = am.CFrame:ToObjectSpace(faketorso.CFrame)
		--local cfVal2 = tool.Flash.CFrame:toObjectSpace(am.CFrame)
		--print(cfVal2)
		--faketorso.CFrame = faketorso.CFrame:Lerp(cam.CFrame * CFrame.new(human.CameraOffset.x + cfVal.x, (-offs + human.CameraOffset.y) + cfVal.y, (2*dist)), aimtween)
	else
		oldgv = 0
		if onaim then
			onaim = false
			aimtween = 0
		end
		aimtween = aimtween + 0.05
		if aimtween > 1 then
			aimtween = 1
		end
		
		offaim = true
		
		local offs = 0
		if char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues") then
			offs = char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues").Offset.Value.y
		end
		
		local tool = char:FindFirstChildOfClass("Tool")
		--tool.Aim.CFrame = tool.Aim.CFrame:Lerp((tool.Aim.CFrame), aimtween)
		--faketorso.CFrame = faketorso.CFrame:Lerp(cam.CFrame * CFrame.new(human.CameraOffset.x, (-offs + human.CameraOffset.y) + (math.abs(recoil.Value/20)*(1 * (cam.FieldOfView/70)))-1.5, -0.5+(2*dist)+(2*math.abs(recoil.Value)*(1 * (cam.FieldOfView/70)))) * CFrame.Angles(math.pi*(math.abs(recoil.Value)*(0.1* (cam.FieldOfView/70))), math.pi*(math.abs(recoil.Value)*0), math.pi*oldgv), aimtween)
		faketorso.CFrame = faketorso.CFrame:Lerp(cam.CFrame * CFrame.new(human.CameraOffset.x, (-offs + human.CameraOffset.y) + -1.5, -0.5+(2*dist)), aimtween)
		end
	
	if char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("GunScript") == nil then
		Shoulder.Part0 = torso
		Shoulder2.Part0 = torso
		--mouse.Icon = "http://www.roblox.com/asset/?id=93533362"
	else
		--mouse.Icon = "http://www.roblox.com/asset/?id=93533362"
		Shoulder.Part0 = faketorso
		Shoulder2.Part0 = faketorso
	end
	
	if char:FindFirstChild("GUNAIMVALUE") then
		mouse.Icon = "http://www.roblox.com/asset/?id=423604832"
	end
	
	Shoulder.C0 = OldShoulderC0
	Shoulder.C1 = OldShoulderC1
	Shoulder2.C0 = OldShoulder2C0
	Shoulder2.C1 = OldShoulder2C1

    --char.Torso.Neck.C0 = CFrame.new(0, 1.5, 0) * CFrame.Angles(math.asin((mouse.Hit.p - mouse.Origin.p).unit.y), 0, 0) --Moves the head up by 1.5 studs and then sets the angle of your character's neck looking up towards the mouse using inverse trigonometry (A grade maths) and unit vectors (so you only get the direction.)
	elseif char:FindFirstChild("Head") and char:FindFirstChild("Torso") and char:FindFirstChild("Torso"):FindFirstChild("Neck") and char:FindFirstChildOfClass("Tool") == nil or inthird then
		--mouse.Icon = "http://www.roblox.com/asset/?id=93533362"
		
		if faketorso then
			faketorso:Destroy()
			faketorso = nil
			
			Shoulder.C0 = OldShoulderC0
			Shoulder.C1 = OldShoulderC1
			Shoulder2.C0 = OldShoulder2C0
			Shoulder2.C1 = OldShoulder2C1
			Shoulder.Part0 = torso
			Shoulder2.Part0 = torso
		end
		
		tweening = false
		onaim = false
		offaim = false
		oldgv = 0
		
		--char['Torso'].Neck.C0 = OldNeckC0
		--char['Torso'].Neck.C1 = OldNeckC1
		Shoulder.C0 = OldShoulderC0
		Shoulder.C1 = OldShoulderC1
		Shoulder2.C0 = OldShoulder2C0
		Shoulder2.C1 = OldShoulder2C1
		
		if char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues") then
			local offr = char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues").RightArm.Value
			local offl = char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues").LeftArm.Value
			--local offh = char:FindFirstChildOfClass("Tool"):FindFirstChild("LimbValues").Head.Value
		
			Shoulder.C0 = Shoulder.C0 * offr
			Shoulder2.C0 = Shoulder2.C0 * offl
			--char.Torso["Neck"].C0 = char.Torso["Neck"].C0 * offh
		end
		
		end
	end
	
	if inthird then
		if char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool"):FindFirstChild("GunScript") then
			mouse.Icon = "http://www.roblox.com/asset/?id=423604832"
		else
			mouse.Icon = ""
		end
	end
	
	--[[if (cam.CFrame.p - cam.Focus.p).magnitude > 1 then
		ignores = {}
		local looker = CFrame.new(head.Position, cam.CFrame.p)
		local Hit, Position, Normal = RayCast4(head.Position, looker.LookVector, (cam.CFrame.p - head.Position).Magnitude)
		cam.CFrame = (cam.CFrame - (cam.CFrame.Position - Position)) + (char.Head.Position - cam.CFrame.Position).Unit
	end]]
end)

function populateparts(mdl)
	if mdl:IsA("BasePart") then
		table.insert(parts,mdl)
	end
	for i2,mdl2 in ipairs(mdl:GetChildren()) do
		--if not mdl2:IsA("Tool") then
		populateparts(mdl2)
		--end
	end
end

char.ChildRemoved:connect(function(item)
	if item:IsA("Tool") and human.Health > 0 then
		game:GetService("UserInputService").MouseIconEnabled = true
		event:FireServer(mouse.Hit.p, mouse.Origin.p, OldNeckC0, OldNeckC1, OldShoulderC0, OldShoulderC1, OldShoulder2C0, OldShoulder2C1)
		--invis()
		--changeVisible(char, "fps")
	end
	if item.Name == "GUNAIMVALUE" then
		game:GetService("UserInputService").MouseIconEnabled = true
	end
	if item.Name == "GUNAIMVALUE" and char:FindFirstChildOfClass("Tool") or item.Name == "Downed" then
		--vis()
	end
	if item.Name == "Downed" then
		--changeVisible(char, "fps")
		--human.CameraOffset = Vector3.new(0, -3, -2.5)
	end
	if item:IsA("Model") then
		--for i=1, 20 do
					wait()
					--changeVisible(char, "fps")
				--end
	end
end)

char.ChildAdded:connect(function(item)
	if item:IsA("Model") then
		--for i=1, 20 do
					wait()
					changeVisible(char, "fps")
				--end
	end
	if item:IsA("Tool") and human.Health > 0 then
		if item:FindFirstChild("FireScript") and not inthird then
			game:GetService("UserInputService").MouseIconEnabled = true
		end
		changeVisible(char, "fps")
	end
	if item.Name == "GUNAIMVALUE" then
		game:GetService("UserInputService").MouseIconEnabled = false
		--invis()
	end
	if item.Name == "Downed" then
		changeVisible(char, "fps")
		human.CameraOffset = Vector3.new(0, -3, -2.5)
	end
end)

local immuneParts = {
	"RightUpperArm",
	"RightLowerArm",
	"RightHand",
	"LeftUpperArm",
	"LeftLowerArm",
	"LeftHand",
	"UpperTorso",
	"LowerTorso",
	"RightUpperLeg",
	"RightLowerLeg",
	"RightFoot",
	"LeftUpperLeg",
	"LeftLowerLeg",
	"LeftFoot",
}


function changeVisible(par, mode, mod)
	for i,v in pairs(par:GetDescendants()) do
		if v:IsA("BasePart") and (not (v.Parent:IsA("Tool") and v.Parent.Parent == char) or mod) then
			v.LocalTransparencyModifier = nil
			
			if (game.Workspace.CurrentCamera.CoordinateFrame.p - game.Workspace.CurrentCamera.Focus.p).magnitude < 1 then
				if mode == "invis" then
					v.LocalTransparencyModifier = 1
				elseif mode == "fps" then
					if not table.find(immuneParts, v.Name) then
						v.LocalTransparencyModifier = 1
					end
				end
			end
		end
	end
end

cam.Changed:connect(function()
	if not cooling then
		cooling = true
		delay(0.05, function()
			cooling = false
		end)
		
		ignores = {}
		--shootDirection = (mouse.Hit.p - mouse.Origin.p).unit
		local rot = cam.CFrame - cam.CFrame.p
		local hit, position1, surface, material = RayCast2((hmr.CFrame * rot).p, cam.CFrame.LookVector, 1000, ignores)
		
		event:FireServer(position1, mouse.Origin.p, OldNeckC0, OldNeckC1, OldShoulderC0, OldShoulderC1, OldShoulder2C0, OldShoulder2C1, inthird)
	end
end)

human.CameraOffset = Vector3.new(human.CameraOffset.x, human.CameraOffset.y, 0)

--[[wait(0.5)
vis()]]