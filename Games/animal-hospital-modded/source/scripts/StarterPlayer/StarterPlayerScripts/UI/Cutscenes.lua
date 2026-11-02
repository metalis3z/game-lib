local t = {}
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local v1 = Lib.Data.Get("Dialogue")
local LocalPlayer = game.Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local black = Lib.UI.Get("blackscreen").black
local cams = game.workspace:WaitForChild("cams")

workspace:WaitForChild("Misc")
Random.new()

local sound = Lib.MusicService.Get("BOOP", "talk").sound
local textframe = Lib.UI.Get("Dialogue"):WaitForChild("Frame"):WaitForChild("textframe")
local black2 = textframe.Parent:WaitForChild("black")
local v2 = false

local function ChangeGroupTransparency(p1, p2, p3) --[[ ChangeGroupTransparency | Line: 20 | Upvalues: v2 (ref), black2 (copy), Lib (copy) ]]
	local v1 = if p2 < 1 then true else false

	v2 = if v1 then if p1 == black2 then true else false else v1

	for i, v in ipairs(p1:GetChildren()) do
		local v3

		if v:IsA("GuiObject") then
			v:SetAttribute("OriginalTransparency", v:GetAttribute("OriginalTransparency") or v.ImageTransparency)
			v3 = v1 and math.max(v:GetAttribute("OriginalTransparency") or 0, p2) or 1

			if v1 then
				v.ImageTransparency = 1
			end

			Lib.TS:Create(v, TweenInfo.new(p3), {
				ImageTransparency = v3
			}):Play()
		end
	end

	task.spawn(function() --[[ Line: 33 | Upvalues: v1 (copy), p3 (copy), p1 (copy) ]]
		if not v1 then
			task.wait(p3)
		end

		p1.Visible = v1
	end)
end

local function dialogName(p1) --[[ dialogName | Line: 41 ]]
	local v1 = p1:GetAttribute("DisplayDialogName")

	return if v1 == "" then p1.Name or v1 else v1
end

local function talkSound(p1) --[[ talkSound | Line: 46 | Upvalues: Lib (copy), sound (copy) ]]
	if p1:GetAttribute("Voice") then
		return Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound
	end

	return sound
end

local function isPlayerNearVisitor(p1, p2) --[[ isPlayerNearVisitor | Line: 53 | Upvalues: LocalPlayer (copy), Lib (copy), v2 (ref) ]]
	if p2 then
		return true
	end

	if not (p1 and p1.PrimaryPart) then
		return false
	end

	if LocalPlayer:HasTag("DeadPlayer") then
		return false
	end

	if Lib.CS:GetTagged("DoubleCheckInEnabled")[1] and not p1:GetAttribute("DisplayDialogName") then
		return false
	end

	if v2 then
		return false
	end

	return LocalPlayer:DistanceFromCharacter(p1.PrimaryPart.Position) < 30
end

local function SetCamera(p1, p2, p3) --[[ SetCamera | Line: 64 | Upvalues: CurrentCamera (copy), LocalPlayer (copy) ]]
	if not p1 then
		CurrentCamera.CameraSubject = LocalPlayer.Character:WaitForChild("Humanoid", 3)
		CurrentCamera.CameraType = Enum.CameraType.Custom

		return
	end

	CurrentCamera.CameraSubject = p1
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	CurrentCamera.Focus = if p2 then p2 else p1.CFrame
	CurrentCamera.CFrame = if p3 then p3 else p1.CFrame
end

t.SetCamera = SetCamera
Lib.Inject("SetCamera", SetCamera)

local function blackscreenPartial(p1) --[[ blackscreenPartial | Line: 78 | Upvalues: black (copy) ]]
	local v1 = p1 or 2.5

	if black.Transparency <= 0.001 then
		for i = 1, 5 do
			local v2 = black

			v2.BackgroundTransparency = v2.BackgroundTransparency + 0.2
			task.wait(v1 / 5)
		end

		black.BackgroundTransparency = 1
	else
		for j = 1, 5 do
			local v3 = black

			v3.BackgroundTransparency = v3.BackgroundTransparency - 0.2
			task.wait(v1 / 5)
		end

		black.BackgroundTransparency = 0
	end

	return v1
end

local function blackscreen(p1, p2) --[[ blackscreen | Line: 96 | Upvalues: Lib (copy), black (copy) ]]
	local v1 = p2 or 2.5
	local v3 = TweenInfo.new(v1)
	local t = {}

	t.BackgroundTransparency = if p1 then 0 else 1
	Lib.TS:Create(black, v3, t):Play()

	local v6 = TweenInfo.new(v1)
	local t2 = {}

	t2.ImageTransparency = if p1 then 0.8 else 1
	Lib.TS:Create(black, v6, t2):Play()
	task.wait(v1)

	return v1
end

t.Blackscreen = blackscreen
Lib.Inject("BlackscreenTransition", blackscreen)
function t.DoctorArrivesFirstTime(p1) --[[ DoctorArrivesFirstTime | Line: 108 | Upvalues: blackscreen (copy), cams (copy), CurrentCamera (copy), LocalPlayer (copy), Lib (copy) ]]
	blackscreen(true, 0.75)

	local v1 = cams:WaitForChild(p1 or "arrivalCam")

	if v1 then
		CurrentCamera.CameraSubject = v1
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		CurrentCamera.Focus = v1.CFrame
		CurrentCamera.CFrame = v1.CFrame
	else
		CurrentCamera.CameraSubject = LocalPlayer.Character:WaitForChild("Humanoid", 3)
		CurrentCamera.CameraType = Enum.CameraType.Custom
	end

	Lib.TS:Create(CurrentCamera, TweenInfo.new(4), {
		CFrame = CurrentCamera.CFrame + CurrentCamera.CFrame.LookVector * 3
	}):Play()
	blackscreen(false, 0.75)
	task.wait(3)
	blackscreen(true, 0.75)
	CurrentCamera.CameraSubject = LocalPlayer.Character:WaitForChild("Humanoid", 3)
	CurrentCamera.CameraType = Enum.CameraType.Custom
	blackscreen(false, 0.75)
end
function t.ShopOpensFirstTime() --[[ ShopOpensFirstTime | Line: 122 | Upvalues: t (copy) ]]
	t.DoctorArrivesFirstTime("shopCam")
end
function t.VisitorArrived(p1, p2, p3) --[[ VisitorArrived | Line: 127 | Upvalues: isPlayerNearVisitor (copy), Lib (copy), ChangeGroupTransparency (copy), black2 (copy), textframe (copy), v1 (copy), sound (copy) ]]
	local v12 = isPlayerNearVisitor(p1, p2)
	local v2 = p1:GetAttribute("IsPatient")
	local v3 = p1:GetAttribute("IsVisitor")
	local v4 = p1:GetAttribute("VisitingName")

	Lib.MusicService.Get("horror_ambience")

	if v12 then
		ChangeGroupTransparency(black2, 0, 0.1)

		local nameframe = textframe.Parent:WaitForChild("nameframe")
		local v5 = p1:GetAttribute("DisplayDialogName")

		nameframe.Text = v5 == "" and p1.Name or v5 or p1.Name

		local v7 = p1:GetAttribute("DisplayDialogName")

		textframe.Parent.nameframe.Visible = v7 == "" and p1.Name or v7
	end

	if not (p3 or p1:GetAttribute("DisplayDialogName")) then
		local v10 = v1.GetFromVGroup(p1:GetAttribute("CustomGreeting") or "Greeting", { p1.Name })

		if v12 then
			Lib.Talk.Typewriter(v10, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
		end

		task.spawn(Lib.DisplayBubble, p1.Head, v10)
		task.wait(2)
	end

	if v2 then
		local v15 = v1.GetFromVGroup(p1:GetAttribute("CustomPatientIntro") or "Patient", { p1.Name })

		if v12 then
			Lib.Talk.Typewriter(v15, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
		end

		task.spawn(Lib.DisplayBubble, p1.Head, v15)
		task.wait(2)
	elseif v3 then
		local v19 = "I came to visit " .. v4 .. ""

		if v12 then
			Lib.Talk.Typewriter(v19, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
		end

		task.spawn(Lib.DisplayBubble, p1.Head, v19)
		task.wait(2)
	end

	task.wait(0.5)

	if not v12 then
		return
	end

	textframe.Text = ""
	ChangeGroupTransparency(black2, 1, 0.5)
	textframe.Parent.nameframe.Visible = false
end
function t.VisitorCheckedIn(p1, p2, p3) --[[ VisitorCheckedIn | Line: 179 | Upvalues: isPlayerNearVisitor (copy), ChangeGroupTransparency (copy), black2 (copy), textframe (copy), v1 (copy), Lib (copy), sound (copy) ]]
	local v12 = isPlayerNearVisitor(p1, p3)

	if v12 then
		ChangeGroupTransparency(black2, 0, 0.1)

		local nameframe = textframe.Parent:WaitForChild("nameframe")
		local v2 = p1:GetAttribute("DisplayDialogName")

		nameframe.Text = v2 == "" and p1.Name or v2 or p1.Name

		local v4 = p1:GetAttribute("DisplayDialogName")

		textframe.Parent.nameframe.Visible = v4 == "" and p1.Name or v4
	end

	local v7 = v1.GetFromVGroup(p1:GetAttribute("CustomRoomAssigned") or "RoomAssigned", { p2 or "?" })

	if v12 then
		Lib.Talk.Typewriter(v7, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v7)
	task.wait(2)
	task.wait(0.5)

	if not v12 then
		return
	end

	textframe.Text = ""
	ChangeGroupTransparency(black2, 1, 0.5)
	textframe.Parent.nameframe.Visible = false
end
function t.VisitorRejected(p1, p2) --[[ VisitorRejected | Line: 201 | Upvalues: isPlayerNearVisitor (copy), ChangeGroupTransparency (copy), black2 (copy), textframe (copy), Lib (copy), sound (copy) ]]
	local v1 = isPlayerNearVisitor(p1, p2)

	if v1 then
		ChangeGroupTransparency(black2, 0, 0.1)

		local nameframe = textframe.Parent:WaitForChild("nameframe")
		local v2 = p1:GetAttribute("DisplayDialogName")

		nameframe.Text = v2 == "" and p1.Name or v2 or p1.Name

		local v4 = p1:GetAttribute("DisplayDialogName")

		textframe.Parent.nameframe.Visible = v4 == "" and p1.Name or v4
	end

	if v1 then
		Lib.Talk.Typewriter("WHAT!? No service?", textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, "WHAT!? No service?")
	task.wait(1)

	if v1 then
		Lib.Talk.Typewriter("I\'m leaving! \240\159\152\161", textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, "I\'m leaving! \240\159\152\161")
	task.wait(1)
	task.wait(0.5)

	if not v1 then
		return
	end

	textframe.Text = ""
	ChangeGroupTransparency(black2, 1, 0.5)
	textframe.Parent.nameframe.Visible = false
end
function t.CoffeeDay1Arrival(p1, p2) --[[ CoffeeDay1Arrival | Line: 228 | Upvalues: isPlayerNearVisitor (copy), ChangeGroupTransparency (copy), black2 (copy), textframe (copy), v1 (copy), Lib (copy), sound (copy) ]]
	local v12 = isPlayerNearVisitor(p1, p2)

	if v12 then
		ChangeGroupTransparency(black2, 0, 0.1)

		local nameframe = textframe.Parent:WaitForChild("nameframe")
		local v2 = p1:GetAttribute("DisplayDialogName")

		nameframe.Text = v2 == "" and p1.Name or v2 or p1.Name

		local v4 = p1:GetAttribute("DisplayDialogName")

		textframe.Parent.nameframe.Visible = v4 == "" and p1.Name or v4
	end

	local v6 = v1.GetFromVGroup("CoffeeDay1Arrival", { p1.Name })

	if v12 then
		Lib.Talk.Typewriter(v6, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v6)
	task.wait(2)

	local v10 = v1.GetFromVGroup("CoffeeDay1Arrival2", {})

	if v12 then
		Lib.Talk.Typewriter(v10, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v10)
	task.wait(2.5)

	if not v12 then
		return
	end

	textframe.Text = ""
	ChangeGroupTransparency(black2, 1, 0.5)
	textframe.Parent.nameframe.Visible = false
end
function t.OfferSuitcase(p1, p2) --[[ OfferSuitcase | Line: 254 | Upvalues: isPlayerNearVisitor (copy), ChangeGroupTransparency (copy), black2 (copy), textframe (copy), v1 (copy), Lib (copy), sound (copy), LocalPlayer (copy) ]]
	local v12 = isPlayerNearVisitor(p1, p2)

	if v12 then
		ChangeGroupTransparency(black2, 0, 0.1)

		local nameframe = textframe.Parent:WaitForChild("nameframe")
		local v2 = p1:GetAttribute("DisplayDialogName")

		nameframe.Text = v2 == "" and p1.Name or v2 or p1.Name

		local v4 = p1:GetAttribute("DisplayDialogName")

		textframe.Parent.nameframe.Visible = v4 == "" and p1.Name or v4
	end

	local v6 = v1.GetFromVGroup("CoffeeDay2PosCoffee", { p1.Name })

	if v12 then
		Lib.Talk.Typewriter(v6, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v6)
	task.wait(2)

	local v10 = v1.GetFromVGroup("CoffeeDay2PosCoffee2", { p1.Name, LocalPlayer.DisplayName })

	if v12 then
		Lib.Talk.Typewriter(v10, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v10)
	task.wait(2.5)

	if not v12 then
		return
	end

	textframe.Text = ""
	ChangeGroupTransparency(black2, 1, 0.5)
	textframe.Parent.nameframe.Visible = false
end
function t.VisitorSaysOneLine(p1, p2, p3) --[[ VisitorSaysOneLine | Line: 280 | Upvalues: isPlayerNearVisitor (copy), ChangeGroupTransparency (copy), black2 (copy), textframe (copy), v1 (copy), LocalPlayer (copy), Lib (copy), sound (copy) ]]
	local v12 = isPlayerNearVisitor(p1, p3)

	if v12 then
		ChangeGroupTransparency(black2, 0, 0.1)

		local nameframe = textframe.Parent:WaitForChild("nameframe")
		local v2 = p1:GetAttribute("DisplayDialogName")

		nameframe.Text = v2 == "" and p1.Name or v2 or p1.Name

		local v4 = p1:GetAttribute("DisplayDialogName")

		textframe.Parent.nameframe.Visible = v4 == "" and p1.Name or v4
	end

	local v6 = v1.GetFromVGroup(p2, { p1.Name, LocalPlayer.DisplayName })

	if v12 then
		Lib.Talk.Typewriter(v6, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v6)
	task.wait(2)

	if not v12 then
		return
	end

	textframe.Text = ""
	ChangeGroupTransparency(black2, 1, 0.5)
	textframe.Parent.nameframe.Visible = false
end
function t.VisitorSays2Lines(p1, p2, p3) --[[ VisitorSays2Lines | Line: 300 | Upvalues: isPlayerNearVisitor (copy), ChangeGroupTransparency (copy), black2 (copy), textframe (copy), v1 (copy), LocalPlayer (copy), Lib (copy), sound (copy) ]]
	local v12 = isPlayerNearVisitor(p1, p3)

	if v12 then
		ChangeGroupTransparency(black2, 0, 0.1)

		local nameframe = textframe.Parent:WaitForChild("nameframe")
		local v2 = p1:GetAttribute("DisplayDialogName")

		nameframe.Text = v2 == "" and p1.Name or v2 or p1.Name

		local v4 = p1:GetAttribute("DisplayDialogName")

		textframe.Parent.nameframe.Visible = v4 == "" and p1.Name or v4
	end

	local v6 = v1.GetFromVGroup(p2, { p1.Name, LocalPlayer.DisplayName })

	if v12 then
		Lib.Talk.Typewriter(v6, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v6)
	task.wait(2)

	local v10 = v1.GetFromVGroup(p2 .. "2", {})

	if v12 then
		Lib.Talk.Typewriter(v10, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v10)
	task.wait(2.5)

	if not v12 then
		return
	end

	textframe.Text = ""
	ChangeGroupTransparency(black2, 1, 0.5)
	textframe.Parent.nameframe.Visible = false
end
function t.VisitorSays3Lines(p1, p2, p3) --[[ VisitorSays3Lines | Line: 326 | Upvalues: isPlayerNearVisitor (copy), ChangeGroupTransparency (copy), black2 (copy), textframe (copy), v1 (copy), LocalPlayer (copy), Lib (copy), sound (copy) ]]
	local v12 = isPlayerNearVisitor(p1, p3)

	if v12 then
		ChangeGroupTransparency(black2, 0, 0.1)

		local nameframe = textframe.Parent:WaitForChild("nameframe")
		local v2 = p1:GetAttribute("DisplayDialogName")

		nameframe.Text = v2 == "" and p1.Name or v2 or p1.Name

		local v4 = p1:GetAttribute("DisplayDialogName")

		textframe.Parent.nameframe.Visible = v4 == "" and p1.Name or v4
	end

	local v6 = v1.GetFromVGroup(p2, { p1.Name, LocalPlayer.DisplayName })

	if v12 then
		Lib.Talk.Typewriter(v6, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v6)
	task.wait(2.5)

	local v10 = v1.GetFromVGroup(p2 .. "2", { p1.Name, LocalPlayer.DisplayName })

	if v12 then
		Lib.Talk.Typewriter(v10, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v10)
	task.wait(2.5)

	local v14 = v1.GetFromVGroup(p2 .. "3", { p1.Name, LocalPlayer.DisplayName })

	if v12 then
		Lib.Talk.Typewriter(v14, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v14)
	task.wait(2.5)

	if not v12 then
		return
	end

	textframe.Text = ""
	ChangeGroupTransparency(black2, 1, 0.5)
	textframe.Parent.nameframe.Visible = false
end

local v3 = nil

function t.AmbulanceNotice(p1, p2) --[[ AmbulanceNotice | Line: 359 | Upvalues: isPlayerNearVisitor (copy), ChangeGroupTransparency (copy), black2 (copy), textframe (copy), v1 (copy), LocalPlayer (copy), Lib (copy), sound (copy) ]]
	local v12 = isPlayerNearVisitor(p1, p2)
	local Screen = workspace:WaitForChild("Misc"):WaitForChild("CheckInCounter"):WaitForChild("Screen")
	local News = Screen:WaitForChild("UI"):WaitForChild("News")

	if v12 then
		ChangeGroupTransparency(black2, 0, 0.1)

		local nameframe = textframe.Parent:WaitForChild("nameframe")
		local v2 = p1:GetAttribute("DisplayDialogName")

		nameframe.Text = v2 == "" and p1.Name or v2 or p1.Name

		local v4 = p1:GetAttribute("DisplayDialogName")

		textframe.Parent.nameframe.Visible = v4 == "" and p1.Name or v4
	end

	Screen:WaitForChild("breaking1"):Play()
	News.Image = workspace.Misc:WaitForChild("NewsImages"):WaitForChild("1"):WaitForChild("Image").ColorMap
	News.Visible = true

	local v6 = v1.GetFromVGroup("AmbulanceVisit", { p1.Name, LocalPlayer.DisplayName })

	if v12 then
		Lib.Talk.Typewriter(v6, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v6)
	task.wait(2.5)
	Screen:WaitForChild("Sound"):Play()
	News.Image = workspace.Misc:WaitForChild("NewsImages"):WaitForChild("2"):WaitForChild("Image").ColorMap

	local v10 = v1.GetFromVGroup("AmbulanceVisit2", { p1.Name, LocalPlayer.DisplayName })

	if v12 then
		Lib.Talk.Typewriter(v10, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v10)
	task.wait(2.5)
	Screen:WaitForChild("Sound"):Play()
	News.Image = workspace.Misc:WaitForChild("NewsImages"):WaitForChild("3"):WaitForChild("Image").ColorMap

	local v14 = v1.GetFromVGroup("AmbulanceVisit3", { p1.Name, LocalPlayer.DisplayName })

	if v12 then
		Lib.Talk.Typewriter(v14, textframe, nil, if p1:GetAttribute("Voice") then Lib.MusicService.Get(p1:GetAttribute("Voice"), "talk").sound else sound)
	end

	task.spawn(Lib.DisplayBubble, p1.Head, v14)
	task.wait(2.5)
	Screen:WaitForChild("Sound"):Play()

	if not v12 then
		News.Visible = false

		return
	end

	textframe.Text = ""
	ChangeGroupTransparency(black2, 1, 0.5)
	textframe.Parent.nameframe.Visible = false
	News.Visible = false
end
function t.AmbulanceArrives() --[[ AmbulanceArrives | Line: 407 | Upvalues: v3 (ref), Lib (copy) ]]
	v3 = Lib.CS:GetTagged("Ambulance")[1]

	if v3 then
		local MovePoints = workspace:WaitForChild("MovePoints")

		v3:SetPrimaryPartCFrame(MovePoints.Ambulance1.CFrame)
		v3.Parent = workspace.Misc
		Lib.TS:Create(v3.PrimaryPart, TweenInfo.new(3), {
			CFrame = MovePoints.Ambulance2.CFrame
		}):Play()
		v3.PrimaryPart.Siren:Play()
	end
end
function t.AmbulanceLeaves() --[[ AmbulanceLeaves | Line: 418 | Upvalues: v3 (ref), Lib (copy) ]]
	v3 = Lib.CS:GetTagged("Ambulance")[1]

	if v3 then
		print("leaving now")

		local MovePoints = workspace:WaitForChild("MovePoints")

		Lib.TS:Create(v3.PrimaryPart, TweenInfo.new(3), {
			CFrame = MovePoints.Ambulance3.CFrame
		}):Play()
		task.wait(3)
		v3.PrimaryPart.Siren:Stop()
		v3.Parent = game.ReplicatedStorage.Misc
		v3:SetPrimaryPartCFrame(MovePoints.Ambulance1.CFrame)
	end
end
function t.ThreePatientsDiedEnding() --[[ ThreePatientsDiedEnding | Line: 430 | Upvalues: Lib (copy), t (copy) ]]
	Lib.PlayerControlsEnabled(false)
	game.Players:AddTag("GameOver")
	Lib.MusicService.Get("Why did you leave me here | Silent Hill 2"):Broadcast()
	t.Activate3rdPerson()
	Lib.TS:Create(game.Lighting:FindFirstChildOfClass("BlurEffect") or Instance.new("BlurEffect", game.Lighting), TweenInfo.new(2), {
		Size = 15
	}):Play()
	Lib.ShowGameOverScreen("GAME OVER", "Too many patients died")
end
function t.ReviveAllAfterPatientsDiedEnding() --[[ ReviveAllAfterPatientsDiedEnding | Line: 443 | Upvalues: Lib (copy), t (copy) ]]
	Lib.HideDeathScreen()
	Lib.TS:Create(game.Lighting:FindFirstChildOfClass("BlurEffect") or Instance.new("BlurEffect", game.Lighting), TweenInfo.new(2), {
		Size = 0
	}):Play()
	Lib.PlayerControlsEnabled(true)
	t.Deactivate3rdPerson()
	game.Players:RemoveTag("GameOver")
end
function t.InventoryFull() --[[ InventoryFull | Line: 452 | Upvalues: Lib (copy) ]]
	local Frame = Lib.UI.Get("InventoryFull"):WaitForChild("Frame")

	Lib.MusicService.Get("Failed sound effect"):Play()
	Frame.Visible = true

	local v1 = Frame:WaitForChild("err"):Clone()

	v1.Parent = Frame
	v1.Visible = true

	local v2 = UDim2.new(v1.Size.X.Scale * 1.3, v1.Size.X.Offset, v1.Size.Y.Scale * 1.3, v1.Size.Y.Offset)

	Lib.TS:Create(v1, TweenInfo.new(0.5), {
		BackgroundTransparency = 1,
		Size = v2
	}):Play()
	task.wait(0.5)
	v1:Destroy()
	Frame.Visible = false
end

local v4 = nil
local v5 = nil
local v6 = nil

task.spawn(function() --[[ Line: 469 | Upvalues: v4 (ref), v5 (ref), v6 (ref) ]]
	v4 = workspace:WaitForChild("Misc"):WaitForChild("JumpscareDummy")
	v5 = game.ReplicatedStorage:WaitForChild("Animations"):WaitForChild("Jumpscare")
	v6 = v4:WaitForChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(v5)
end)
function t.JumpscareRobux() --[[ JumpscareRobux | Line: 475 | Upvalues: v6 (ref), cams (copy), CurrentCamera (copy), LocalPlayer (copy), Lib (copy) ]]
	print("Attempting to play jumpscare")

	if not v6 then
		print("jumpscare not ready")

		return
	end

	print("Playing jumpscare animation")
	v6:Play(0, 1, 1.5)
	task.wait(0.1)

	local jumpscare = cams.jumpscare

	if jumpscare then
		CurrentCamera.CameraSubject = jumpscare
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		CurrentCamera.Focus = jumpscare.CFrame
		CurrentCamera.CFrame = jumpscare.CFrame
	else
		CurrentCamera.CameraSubject = LocalPlayer.Character:WaitForChild("Humanoid", 3)
		CurrentCamera.CameraType = Enum.CameraType.Custom
	end

	Lib.MusicService.Get("horror jumpscare", "jumpscare").sound:Play()
	task.wait(1.2)
	CurrentCamera.CameraSubject = LocalPlayer.Character:WaitForChild("Humanoid", 3)
	CurrentCamera.CameraType = Enum.CameraType.Custom
	v6:Stop()
end

local t2 = {}

function t.Activate3rdPerson() --[[ Activate3rdPerson | Line: 495 | Upvalues: t2 (copy), LocalPlayer (copy) ]]
	t2.MaxZoomDistance = LocalPlayer.CameraMaxZoomDistance
	t2.MinZoomDistance = LocalPlayer.CameraMinZoomDistance
	LocalPlayer.CameraMaxZoomDistance = 10
	LocalPlayer.CameraMinZoomDistance = 10
	LocalPlayer.CameraMode = Enum.CameraMode.Classic
end
function t.Deactivate3rdPerson() --[[ Deactivate3rdPerson | Line: 507 | Upvalues: LocalPlayer (copy), t2 (copy) ]]
	LocalPlayer.CameraMaxZoomDistance = t2.MaxZoomDistance or 128
	LocalPlayer.CameraMinZoomDistance = t2.MinZoomDistance or 0.5
	LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
end
function t.Start() --[[ Start | Line: 514 | Upvalues: LocalPlayer (copy), black (copy) ]]
	if not LocalPlayer.Character then
		LocalPlayer.CharacterAdded:Wait()
	end

	local TweenService = game:GetService("TweenService")
	local v1 = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)

	TweenService:Create(black, v1, {
		BackgroundTransparency = 1
	}):Play()

	for i, v in ipairs(black:GetDescendants()) do
		TweenService:Create(v, v1, {
			BackgroundTransparency = 1,
			TextTransparency = 1
		}):Play()
	end
end
function t.loading(p1) --[[ loading | Line: 529 ]] end
game:GetService("GuiService").MenuOpened:Connect(function() --[[ Line: 534 ]] end)
function PlayCutscene(p1, ...) --[[ PlayCutscene | Line: 538 | Upvalues: Lib (copy), t (copy), textframe (copy), ChangeGroupTransparency (copy), black2 (copy) ]]
	Lib.CS:AddTag(workspace.CurrentCamera, "InCutscene")
	os.time()

	local ok, result = pcall(t[p1], ...)

	if not ok then
		task.spawn(error, "Cutscenes - " .. result)
		textframe.Text = ""
		textframe.Parent.nameframe.Visible = false
		ChangeGroupTransparency(black2, 1, 0.5)
	end

	Lib.CS:RemoveTag(workspace.CurrentCamera, "InCutscene")
end
-- Paciente impaciente: burbuja de queja mientras espera a que lo atiendan.
function t.Complain(p1)
	if not (p1 and p1:FindFirstChild("Head")) then return end
	local lines = {
		"How long is this going to take?",
		"Hello? I need a doctor!",
		"Ugh, I'm in pain here...",
		"Am I being helped or not?",
		"WHAT!? No service?",
	}
	task.spawn(Lib.DisplayBubble, p1.Head, lines[math.random(1, #lines)])
end
t.PlayCutscene = PlayCutscene
Lib.Network:BindEvents({
	PlayCutscene = PlayCutscene,
	ShakeCamera = t.ShakeCamera,
	Blackscreen = blackscreen,
	PlayerRevived = function() --[[ PlayerRevived | Line: 566 | Upvalues: t (copy) ]]
		t.Deactivate3rdPerson()
	end
})
cams.Parent = game.ReplicatedStorage
Lib.Inject("PlayCutscene", PlayCutscene)
task.delay(10, function() --[[ Line: 575 | Upvalues: LocalPlayer (copy) ]]
	if game.Players.LocalPlayer.Name ~= "Roytt" then
		return
	end

	LocalPlayer.CameraMode = Enum.CameraMode.Classic
end)
LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 581 ]]
	local CurrentCamera = workspace.CurrentCamera

	CurrentCamera.CameraSubject = p1:WaitForChild("Humanoid")
	CurrentCamera.CameraType = Enum.CameraType.Custom
end)

return t