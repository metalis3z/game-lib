local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

require(ReplicatedStorage.Shared.EventTypes)
local BaseIndexController = require(ReplicatedStorage.Controllers.BaseIndexController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local WorldBrainrotController = require(ReplicatedStorage.Controllers.WorldBrainrotController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)

local CandyMerchantUI = require(script.CandyMerchantUI)
local GalaxyDoorVisuals = require(script.GalaxyDoorVisuals)
local VolcanoCraftingUI = require(script.VolcanoCraftingUI)
local JumpShopUI = require(script.JumpShopUI)
local CloudVisuals = require(script.CloudVisuals)
local CoinVisuals = require(script.CoinVisuals)
local UFOVisuals = require(script.UFOVisuals)
local VolcanoVisuals = require(script.VolcanoVisuals)
local CageVisuals = require(script.CageVisuals)
local HarpVisuals = require(script.HarpVisuals)
local JumpShopTutorial = require(script.JumpShopTutorial)

local EVENT_NAME = script.Name
local module = {}
local trove = Trove.new()

local function emitAttachment(attachment)
	if not attachment then return end
	local emitter = attachment:FindFirstChildOfClass("ParticleEmitter")
	if not emitter then return end
	local count = attachment:GetAttribute("EmitCount") or emitter:GetAttribute("EmitCount") or 10
	emitter.Enabled = true
	emitter:Emit(count)
	task.delay(1, function()
		if emitter and emitter.Parent then
			emitter.Enabled = false
		end
	end)
end

function module.OnStart(_)
	local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
	local NoFlyRemote = Net:RemoteEvent("EventService/EggrotHunt/NoFly")

	local ok, eventData = pcall(function()
		return EventController:GetActiveEventData(EVENT_NAME)
	end)
	if not ok or not eventData then return end

	trove:Add(function()
		EffectController:Activate("Blink")
		CycleController:Update()
		SoundController:UpdateOST()
		SoundController:UpdateAmbience()
	end)
	EffectController:Activate("Blink")
	CycleController:Update()
	SoundController:UpdateOST()
	SoundController:UpdateAmbience()

	trove:Add(BaseIndexController:Register({
		Id = "Easter",
		IndexName = "Easter",
		SkinName = "Easter",
		ScreenGuiName = "EasterBase",
		FramePath = "EasterBase",
		MotorTag = "EasterBaseMotor",
		PromptTag = "EasterBasePrompt",
	}))

	trove:Add(Observers.observeTag("HideInEggrotHunt", function(obj)
		local parent = obj.Parent
		obj.Parent = script
		return function() obj.Parent = parent end
	end))

	local ok2 = pcall(function()
		trove:Add(CloudVisuals:Start())
		trove:Add(UFOVisuals:Start())
		trove:Add(CandyMerchantUI:Start())
		trove:Add(GalaxyDoorVisuals:Start())
		trove:Add(JumpShopUI:Start())
		trove:Add(JumpShopTutorial:Start())
	end)
	if not ok2 then end

	local renderedBrainrots = {}
	local ok3 = pcall(function()
		local cageTrove, cageOnRendered = CageVisuals:Start(renderedBrainrots)
		trove:Add(cageTrove)
		trove:Add(WorldBrainrotController:RenderPool({
			PoolId = "EggrotHunt/Brainrots",
			ShowTimer = true,
			ShowDropButton = true,
			GrabHoldDuration = 2,
			GrabMaxDistance = 10,
			RenderedBrainrots = renderedBrainrots,
			OnRendered = function(id)
				local entry = renderedBrainrots[id]
				if entry and entry.prompt then cageOnRendered(id) end
			end,
		}))
		trove:Add(VolcanoVisuals:Start(renderedBrainrots))
		trove:Add(VolcanoCraftingUI:Start())
		trove:Add(HarpVisuals:Start(renderedBrainrots))
	end)
	if not ok3 then end

	local LocalPlayer = Players.LocalPlayer
	trove:Add(RunService.Heartbeat:Connect(function()
		local char = LocalPlayer.Character
		if not char then return end
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			local speed = hum:GetAttribute("_speed")
			if speed and hum.WalkSpeed < speed then hum.WalkSpeed = speed end
		end
	end))

	local lastTrampolineHit = 0
	trove:Add(Observers.observeTag("JumpPad", function(part)
		if not part:IsA("BasePart") then return nil end
		local conn = part.Touched:Connect(function(hit)
			if not hit or not hit.Parent then return end
			local player = Players:GetPlayerFromCharacter(hit.Parent)
			if player ~= LocalPlayer then return end
			local now = os.clock()
			if now - lastTrampolineHit < 0.3 then return end
			lastTrampolineHit = now
			SoundController:PlaySound("Sounds.Events.Easter.Trampoline", part.Position, false)
			local hrp = hit.Parent:FindFirstChild("HumanoidRootPart")
			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			if hrp and hum then
				local impulseY = math.sqrt(2 * workspace.Gravity * 65)
				local v = hrp.AssemblyLinearVelocity
				hrp.AssemblyLinearVelocity = Vector3.new(v.X, impulseY, v.Z)
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end
			local shockwave = part:FindFirstChild("Shockwave")
			if shockwave then
				emitAttachment(shockwave)
				emitAttachment(shockwave:FindFirstChild("Vertical"))
			end
		end)
		return function() conn:Disconnect() end
	end, {workspace}))

	trove:Add(NoFlyRemote.OnClientEvent:Connect(function()
		NotificationController:Notify(
			'<font color="#FF1111"><b>Flying gears cannot be used beyond this point</b></font>',
			4, "Sounds.Sfx.Error"
		)
	end))
end

function module.OnStop(_)
	trove:Destroy()
end

function module.OnLoad(_)
	CoinVisuals:OnLoad()
end

return module