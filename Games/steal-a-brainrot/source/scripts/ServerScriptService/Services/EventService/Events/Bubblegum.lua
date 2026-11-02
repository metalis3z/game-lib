local Bubblegum = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local NotificationService = require(ServerScriptService.Services.NotificationService)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local RollAnimation = Net:RemoteEvent("EventService/Bubblegum/RollAnimation")
local EmitBurst = Net:RemoteEvent("EventService/Bubblegum/EmitBurst")

local SoundsFolder = ReplicatedStorage:WaitForChild("Sounds"):WaitForChild("Sfx"):WaitForChild("Bubblegum Machine")

local MACHINE = workspace:WaitForChild("Events"):WaitForChild("Bubblegum"):WaitForChild("Machine")
local REGION_MODEL = MACHINE:WaitForChild("Model")

local COOLDOWN = 7.5
local TWEEN_TIME = 1
local TRAIT_DELAY = 6

local isActive = false
local isProcessing = false
local endTime
local timerConn
local lastTraitTime = 0

local function playSound(name)
	local template = SoundsFolder:FindFirstChild(name)
	if not template then return end

	local sound = template:Clone()
	sound.Parent = MACHINE
	sound:Play()

	Debris:AddItem(sound, sound.TimeLength + 1)
end

local function getTraits(instance)
	local json = instance:GetAttribute("Traits")
	if not json then return {} end

	local ok, decoded = pcall(function()
		return HttpService:JSONDecode(json)
	end)

	return ok and decoded or {}
end

local function hasTrait(animal)
	for _, trait in ipairs(getTraits(animal)) do
		if trait == "Bubblegum" then
			return true
		end
	end
	return false
end

local function applyTrait(animal)
	local traits = getTraits(animal)

	if table.find(traits, "Bubblegum") then
		return
	end

	table.insert(traits, "Bubblegum")

	animal:SetAttribute(
		"Traits",
		HttpService:JSONEncode(traits)
	)
end

local function tween(part, targetCFrame, duration)

	local rotation = part.CFrame - part.Position

	local info = TweenInfo.new(
		duration,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out
	)

	local t = TweenService:Create(part, info, {
		CFrame = CFrame.new(targetCFrame.Position) * rotation
	})

	t:Play()
	return t
end

local function getRegionPart()
	return REGION_MODEL:FindFirstChild("Meshes/gumbballmachine_Cube (1)")
end

local function fmtTime(sec)
	sec = math.max(0, math.floor(sec))
	local m = math.floor(sec / 60)
	local s = sec % 60
	return string.format("%dm %02ds", m, s)
end

local function startTimerUi()

	local gui = MACHINE:FindFirstChild("Tank") and MACHINE.Tank:FindFirstChild("BillboardGui")
	local label = gui and gui:FindFirstChild("DisplayText")

	if timerConn then
		timerConn:Disconnect()
	end

	if not label then return end

	timerConn = RunService.Heartbeat:Connect(function()

		if not isActive then
			label.Text = "0/10"
			return
		end

		local left = endTime - workspace:GetServerTimeNow()

		label.Text = fmtTime(left)

	end)
end

local function stopTimerUi()

	if timerConn then
		timerConn:Disconnect()
	end

	local gui = MACHINE:FindFirstChild("Tank") and MACHINE.Tank:FindFirstChild("BillboardGui")
	local label = gui and gui:FindFirstChild("DisplayText")

	if label then
		label.Text = "0/10"
	end

end

local function runEvent()

	local VFXFolder = MACHINE:WaitForChild("Vfx")
	local topVfxGoal = VFXFolder:FindFirstChild("Goal")

	task.spawn(function()

		while isActive and workspace:GetServerTimeNow() < endTime do

			for _, animal in ipairs(workspace.MovingAnimals:GetChildren()) do

				if not isActive then break end
				if not animal:IsA("Model") or not animal.PrimaryPart then continue end
				if isProcessing then continue end

				local regionPart = getRegionPart()
				if not regionPart then break end

				local rel = regionPart.CFrame:PointToObjectSpace(animal.PrimaryPart.Position)

				local within =
					math.abs(rel.X) <= regionPart.Size.X/2 and
					math.abs(rel.Z) <= regionPart.Size.Z/2

				if within then

					if workspace:GetServerTimeNow() - lastTraitTime < TRAIT_DELAY then
						continue
					end

					lastTraitTime = workspace:GetServerTimeNow()

					isProcessing = true

					if hasTrait(animal) then
						isProcessing = false
						continue
					end

					animal:SetAttribute("ForceIdle", true)

					playSound("Pickup")

					tween(
						animal.PrimaryPart,
						CFrame.new(MACHINE.InMachine.Position),
						TWEEN_TIME
					).Completed:Wait()

					playSound("Crank")

					RollAnimation:FireAllClients(MACHINE)

					applyTrait(animal)

					playSound("ApplyBrainrot")

					EmitBurst:FireAllClients(MACHINE)

					playSound("Apply")

					task.wait(2)

					local root = animal.PrimaryPart

					local goalPos =
						MACHINE.Goal.Position + Vector3.new(0,2,0)

					tween(root, CFrame.new(goalPos), TWEEN_TIME).Completed:Wait()

					local dropTween = TweenService:Create(
						root,
						TweenInfo.new(
							0.6,
							Enum.EasingStyle.Quad,
							Enum.EasingDirection.In
						),
						{
							CFrame = CFrame.new(MACHINE.Goal.Position)
						}
					)

					dropTween:Play()
					dropTween.Completed:Wait()

					animal:SetAttribute("ForceIdle", nil)

					task.wait(COOLDOWN)

					isProcessing = false
				end
			end

			task.wait(0.3)
		end

		isActive = false
		stopTimerUi()

		if topVfxGoal then
			for _, obj in topVfxGoal:GetDescendants() do
				if obj:IsA("ParticleEmitter") then
					obj.Enabled = false
				end
			end
		end

		MACHINE:SetAttribute("Hidden", true)

	end)
end

function Bubblegum.OnStart(duration)

	MACHINE:PivotTo(
		CFrame.new(-410.631, -4.336, -55.155)
			* CFrame.Angles(0, math.rad(90), 0)
	)

	if isActive then return end

	isActive = true

	duration = duration or 600

	endTime = workspace:GetServerTimeNow() + duration

	MACHINE:SetAttribute("Hidden", false)

	startTimerUi()

	runEvent()

	VFX.emit(MACHINE.Vfx.Goal)

	for _, player in ipairs(Players:GetPlayers()) do

		NotificationService.Notify(
			player,
			"<font color='#ff55ff'><b>Bubblegum Machine</b></font> has been activated!",
			15,
			"Sounds.Sfx.Success"
		)

	end

	RollAnimation:FireAllClients(MACHINE)

end

function Bubblegum.OnStop()

	if not isActive then return end

	isActive = false

	stopTimerUi()

	MACHINE:SetAttribute("Hidden", true)

	MACHINE:PivotTo(CFrame.new(0,10000,0))

end

return Bubblegum