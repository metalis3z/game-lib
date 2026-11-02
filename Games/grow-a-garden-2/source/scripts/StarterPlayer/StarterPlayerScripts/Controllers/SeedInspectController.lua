--credit to prince games studio
local t = {}
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local v1 = script.Player:Clone()

v1.Parent = game.Workspace

local LocalPlayer = game.Players.LocalPlayer

if LocalPlayer and LocalPlayer.UserId then
	task.spawn(function() --[[ Line: 18 | Upvalues: Players (copy), LocalPlayer (copy), v1 (copy) ]]
		local ok, result = pcall(Players.GetHumanoidDescriptionFromUserIdAsync, Players, LocalPlayer.UserId)

		if not (ok and result) then
			return
		end

		v1.Humanoid:ApplyDescriptionResetAsync(result)
	end)
end

task.spawn(function() --[[ Line: 29 | Upvalues: v1 (copy) ]]
	task.wait(0.5)
	v1.Parent = script.FakePlot
end)

local Trove = require(game.ReplicatedStorage.ClientModules.Trove)
local DisplayPlantGrowthController = require(script.Parent:WaitForChild("DisplayPlantGrowthController"))
local GuiController = require(script.Parent:WaitForChild("GuiController"))
local LocalPlayer2 = Players.LocalPlayer
-- MODDED: NO bloquear el require. LimitedShop/RobuxShopClient requieren este
-- controller ANTES de que spawnee el personaje (PlayerGui vacío) → "Infinite yield"
-- en CinematicBars. Se resuelve en segundo plano cuando StarterGui clona a PlayerGui.
local CinematicBars, BottomBar, TopBar, Prizes
task.spawn(function()
	local pg = LocalPlayer2:WaitForChild("PlayerGui")
	local cb
	repeat
		cb = pg:FindFirstChild("CinematicBars")
		if not cb then task.wait() end
	until cb
	CinematicBars = cb
	BottomBar = cb:WaitForChild("BottomBar")
	TopBar = cb:WaitForChild("TopBar")
	Prizes = cb:WaitForChild("PrizesUI"):WaitForChild("Prizes")
end)
local FakePlot = script.FakePlot
local v2 = Trove.new()
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local t2 = {
	"http://www.roblox.com/asset/?id=182435998",
	"http://www.roblox.com/asset/?id=182491037",
	"http://www.roblox.com/asset/?id=182491065",
	"http://www.roblox.com/asset/?id=182436842",
	"http://www.roblox.com/asset/?id=182491248",
	"http://www.roblox.com/asset/?id=182491277",
	"http://www.roblox.com/asset/?id=182436935",
	"http://www.roblox.com/asset/?id=182491368",
	"http://www.roblox.com/asset/?id=182491423"
}

local function startSporadicDancer(p1, p2) --[[ startSporadicDancer | Line: 83 | Upvalues: t2 (copy) ]]
	local v1 = p1:FindFirstChildOfClass("Animator") or p1:WaitForChild("Animator", 5)

	local function preload(p1) --[[ preload | Line: 86 | Upvalues: v1 (copy) ]]
		local Animation = Instance.new("Animation")

		Animation.AnimationId = p1

		local v12 = v1:LoadAnimation(Animation)

		Animation:Destroy()

		return v12
	end

	local Animation = Instance.new("Animation")

	Animation.AnimationId = "http://www.roblox.com/asset/?id=180435571"

	local v2 = v1:LoadAnimation(Animation)

	Animation:Destroy()

	local v3 = v2
	local Animation2 = Instance.new("Animation")

	Animation2.AnimationId = "http://www.roblox.com/asset/?id=125750702"

	local v4 = v1:LoadAnimation(Animation2)

	Animation2:Destroy()

	local v5 = v4
	local Animation3 = Instance.new("Animation")

	Animation3.AnimationId = "http://www.roblox.com/asset/?id=180436148"

	local v6 = v1:LoadAnimation(Animation3)

	Animation3:Destroy()

	local v7 = v6
	local list = {}

	for i, v in ipairs(t2) do
		local Animation4 = Instance.new("Animation")

		Animation4.AnimationId = v

		local v8 = v1:LoadAnimation(Animation4)

		Animation4:Destroy()
		list[i] = v8
	end

	local v9 = "dance"
	local v10 = nil

	local function stopAll() --[[ stopAll | Line: 107 | Upvalues: v3 (copy), v5 (copy), v7 (copy), list (copy) ]]
		v3:Stop(0)
		v5:Stop(0)
		v7:Stop(0)

		for i, v in ipairs(list) do
			v:Stop(0)
		end
	end

	local function pickNewDanceIndex() --[[ pickNewDanceIndex | Line: 116 | Upvalues: list (copy), v10 (ref) ]]
		local v1 = math.random(1, #list)

		while v1 == v10 and #list > 1 do
			v1 = math.random(1, #list)
		end

		v10 = v1

		return v1
	end

	local function startDance() --[[ startDance | Line: 125 | Upvalues: stopAll (copy), list (copy), pickNewDanceIndex (copy) ]]
		stopAll()
		list[pickNewDanceIndex()]:Play(0.1)
	end

	for i, v in ipairs(list) do
		v.KeyframeReached:Connect(function(p1) --[[ Line: 131 | Upvalues: v (copy) ]]
			if p1 ~= "End" or not v.IsPlaying then
				return
			end

			v:Play(0)
		end)
	end

	v3.KeyframeReached:Connect(function(p1) --[[ Line: 138 | Upvalues: v3 (copy) ]]
		if p1 ~= "End" or not v3.IsPlaying then
			return
		end

		v3:Play(0)
	end)
	p1.Jumping:Connect(function() --[[ Line: 144 | Upvalues: v9 (ref), v7 (copy), v3 (copy), v5 (copy) ]]
		if v9 == "jumping" then
			v7:Stop(0)
			v3:Stop(0)
			v5:Play(0)
		end
	end)
	p1.FreeFalling:Connect(function() --[[ Line: 151 | Upvalues: v9 (ref), v5 (copy), v7 (copy) ]]
		if v9 == "jumping" then
			v5:Stop(0)
			v7:Play(0.1)
		end
	end)
	p1.StateChanged:Connect(function(p1, p2) --[[ Line: 157 | Upvalues: v9 (ref), v5 (copy), v7 (copy), v3 (copy) ]]
		if v9 ~= "jumping" then
			return
		end

		if p2 ~= Enum.HumanoidStateType.Landed then
			return
		end

		v5:Stop(0)
		v7:Stop(0)
		v3:Play(0.1)
	end)

	local function doJumpBurst() --[[ doJumpBurst | Line: 166 | Upvalues: v9 (ref), stopAll (copy), v3 (copy), p2 (copy), p1 (copy) ]]
		v9 = "jumping"
		stopAll()
		v3:Play(0)

		for i = 1, math.random(4, 10) do
			if not p2.Parent then
				return
			end

			p1.Jump = true
			task.wait(math.random(8, 25) / 100)
		end

		task.wait(0.3)
	end

	local function doDancePhase() --[[ doDancePhase | Line: 179 | Upvalues: v9 (ref), stopAll (copy), p2 (copy), list (copy), pickNewDanceIndex (copy) ]]
		v9 = "dance"
		stopAll()

		local v1 = math.random(6, 14)
		local sum = 0

		while sum < v1 and p2.Parent do
			stopAll()
			list[pickNewDanceIndex()]:Play(0.1)

			local v2 = math.random(20, 50) / 10

			if v1 < sum + v2 then
				v2 = v1 - sum
			end

			task.wait(v2)
			sum = sum + v2
		end
	end

	stopAll()
	list[pickNewDanceIndex()]:Play(0.1)
	task.wait(math.random(4, 8))

	while p2.Parent do
		doJumpBurst()

		if not p2.Parent then
			break
		end

		doDancePhase()

		if not p2.Parent then
			break
		end

		task.wait(math.random(3, 10) / 10)
	end

	stopAll()
end

local function HideBars() --[[ HideBars | Line: 212 | Upvalues: TweenService (copy), BottomBar (copy), TopBar (copy), Prizes (copy) ]]
	TweenService:Create(BottomBar, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		AnchorPoint = Vector2.new(0, 0)
	}):Play()
	TweenService:Create(TopBar, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		AnchorPoint = Vector2.new(0, 1)
	}):Play()
	TweenService:Create(Prizes, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		AnchorPoint = Vector2.new(1, 0.5)
	}):Play()
end

local function ShowBars() --[[ ShowBars | Line: 219 | Upvalues: TweenService (copy), BottomBar (copy), TopBar (copy), Prizes (copy) ]]
	TweenService:Create(BottomBar, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		AnchorPoint = Vector2.new(0, 1)
	}):Play()
	TweenService:Create(TopBar, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		AnchorPoint = Vector2.new(0, 0)
	}):Play()
	TweenService:Create(Prizes, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		AnchorPoint = Vector2.new(0, 0.5)
	}):Play()
end

function t.Stop(p1) --[[ Stop | Line: 226 | Upvalues: v5 (ref), v2 (copy), HideBars (copy), v6 (ref), v3 (ref), v4 (ref) ]]
	if v5 then
		v5(true)
		v5 = nil
	end

	if v2 then
		v2:Clean()
	end

	if not p1 then
		return
	end

	HideBars()

	if v6 then
		local CurrentCamera = game.Workspace.CurrentCamera

		CurrentCamera.CameraType = v6.CameraType
		CurrentCamera.CameraSubject = v6.CameraSubject
		CurrentCamera.FieldOfView = v6.FieldOfView
		CurrentCamera.CFrame = v6.CFrame
		v6 = nil
	end

	v3 = nil
	v4 = nil
end
function t.Start(p1) --[[ Start | Line: 261 ]] end
function t.Init(p1) --[[ Init | Line: 265 ]] end
function t.Inspect(p1, p2, p3) --[[ Inspect | Line: 270 | Upvalues: v4 (ref), v6 (ref), t (copy), FakePlot (copy), startSporadicDancer (copy), v2 (copy), GuiController (copy), v3 (ref), LocalPlayer2 (copy), StarterGui (copy), ShowBars (copy), TopBar (copy), DisplayPlantGrowthController (copy), v5 (ref) ]]
	local SeedName = p1.SeedName

	v4 = SeedName

	if not v6 then
		local CurrentCamera = game.Workspace.CurrentCamera

		v6 = {
			CameraType = CurrentCamera.CameraType,
			CameraSubject = CurrentCamera.CameraSubject,
			FieldOfView = CurrentCamera.FieldOfView,
			CFrame = CurrentCamera.CFrame
		}
	end

	t.Stop(false)

	local v22 = FakePlot:Clone()

	v22.Parent = game.Workspace

	local Player = v22:WaitForChild("Player")
	local Humanoid = Player:WaitForChild("Humanoid")

	task.spawn(function() --[[ Line: 305 | Upvalues: Player (copy), startSporadicDancer (ref), Humanoid (copy) ]]
		Player.HumanoidRootPart.Anchored = false
		startSporadicDancer(Humanoid, Player)
	end)
	v2:Add(v22)
	GuiController:Close()

	if p2 then
		v3 = p2
	end

	local t2, v32 = {}, if p3 then p3 else {}

	for v42, v52 in LocalPlayer2.PlayerGui:GetChildren() do
		if v52:IsA("ScreenGui") and v52.Name ~= "CinematicBars" then
			t2[v52] = v52.Enabled
			v52.Enabled = false
		end
	end

	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
	v2:Add(function() --[[ Line: 338 | Upvalues: StarterGui (ref), t2 (copy) ]]
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

		for v1, v2 in t2 do
			if v1 then
				v1.Enabled = v2
			end
		end
	end)
	ShowBars()
	TopBar.NameLabel.Text = ("%* SEED"):format((string.upper(SeedName)))
	TopBar.NameLabel.TextLabel.Text = ("%* SEED"):format((string.upper(SeedName)))
	v2:Add(TopBar.ExitButton.Activated:Connect(function() --[[ Line: 356 | Upvalues: v3 (ref), t (ref) ]]
		local v1 = v3

		t.Stop(true)

		if not v1 then
			return
		end

		v1()
	end))
	math.randomseed(os.clock() * 1000)

	local t3 = {
		duration = v32.duration or 10,
		fruitDuration = v32.fruitDuration or 30,
		idleDuration = v32.idleDuration or 10,
		startAge = v32.startAge or 0,
		endAge = v32.endAge or 75,
		intense = v32.intense or true
	}

	t3.easingStyle = v32.easingStyle or Enum.EasingStyle.Quad
	t3.easingDirection = v32.easingDirection or Enum.EasingDirection.InOut
	t3.camera = game.Workspace.CurrentCamera
	t3.seed = v32.seed or math.random(0, 2147483647)
	t3.position = v22.PrimaryPart.Position + Vector3.new(0, v22.PrimaryPart.Size.Y / 2, 0)
	t3.parent = v22
	t3.onStep = v32.onStep
	t3.onComplete = v32.onComplete
	t3.onCancelled = v32.onCancelled
	v5 = DisplayPlantGrowthController.GrowPlant(SeedName, t3)
end

return t