
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("ContentProvider")

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

require(ReplicatedStorage.Shared.EventTypes)

local t1 = {}
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)

require(ReplicatedStorage.Controllers.AnimalController)

local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Observers = require(ReplicatedStorage.Packages.Observers)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)

require(ReplicatedStorage.Packages.FFlags)

local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)

require(ReplicatedStorage.Packages.Spr)
require(ReplicatedStorage.Shared.VFX)

local scriptName = script.Name
local v18 = Net:RemoteEvent(`EventService/{ scriptName }/DestroyCandyCane`)
local v19 = Net:RemoteEvent(`EventService/{ scriptName }/SpawnCandyCane`)
local v20 = Net:RemoteEvent(`EventService/{ scriptName }/ClaimCandyCane`)
local v21 = Net:RemoteEvent(`EventService/{ scriptName }/Burst`)
local raycastParams = RaycastParams.new()

raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { workspace.Map }

local v23 = Trove.new()

function t1.OnStart(_)
	assert((EventController:GetActiveEventData(scriptName)))

	local Cartoon = Lighting:FindFirstChild("Cartoon")

	if Cartoon then
		Cartoon.Parent = script
		v23:Add(function()
			Cartoon.Parent = Lighting
		end)
	end

	v23:Clone(script.CartoonSky).Parent = Lighting
	EffectController:Run("WinterHourEvent", "GrassRecolor")
	v23:Add(function()
		EffectController:Stop("WinterHourEvent", "GrassRecolor")
	end)
	EffectController:Run("WinterHourEvent", "WallRecolor")
	v23:Add(function()
		EffectController:Stop("WinterHourEvent", "WallRecolor")
	end)
	EffectController:Run("WinterHourEvent", "WallBottomRecolor")
	v23:Add(function()
		EffectController:Stop("WinterHourEvent", "WallBottomRecolor")
	end)
	v23:Clone(script.Map).Parent = workspace
	v23:Add(function()
		EffectController:Activate("Blink")
	end)
	v23:Add(Observers.observeTag("HideInWinterHour", function(p2)
		local p2Parent = p2.Parent

		p2.Parent = script

		return function()
			pcall(function()
				p2.Parent = p2Parent
			end)
		end
	end, {
		workspace,
		script
	}))
	CycleController:Update()
	SoundController:UpdateOST()
	EffectController:Activate("Blink")
	v23:Add(function()
		CycleController:Update()
		SoundController:UpdateOST()
	end)
end
function t1.OnStop(_)
	v23:Destroy()
end
function t1.OnLoad(_)
	v21.OnClientEvent:Connect(function(s1: string)
		ClientEventUtils.playBurst(script.Burst, s1, { ReplicatedStorage.Sounds.Events["Winter Hour"].Hit })
	end)

	local t2 = {}

	local function playCharacterAnimation(p5, p6)
		local Character = p5.Character

		if not Character then
			return
		end

		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return
		end

		local clone = script.Reward:Clone()

		clone.CurrencyCandyCane.Text = `+{ p6 }`
		clone.Parent = HumanoidRootPart
		TweenService:Create(clone, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			StudsOffset = Vector3.new(0, 2.5, 2.200000047683716)
		}):Play()
		TweenService:Create(clone.ImageLabel.ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
			ImageTransparency = 1
		}):Play()
		TweenService:Create(clone.CurrencyCandyCane, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
			TextTransparency = 1
		}):Play()
		TweenService:Create(clone.CurrencyCandyCane.UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
			Transparency = 1
		}):Play()
		task.delay(5, function()
			clone:Destroy()
		end)
	end
	local function playScreenCandyCaneAnimation(p7)
		local random = Random.new()

		for _ = 1, math.min(p7, 30) do
			local clone = script.Image:Clone()

			clone.Position = UDim2.fromScale(random:NextNumber(-0.25, 1.25), -(0.25 - random:NextNumber(0, 0.125)))
			clone.Rotation = random:NextNumber(-120, 120)

			local v43 = random:NextNumber(0.15, 0.2)

			clone.Size = UDim2.fromScale(v43, v43)
			clone.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Effects")
			CreateTween(clone, TweenInfo.new(random:NextNumber(0.75, 1.3), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Position = clone.Position + UDim2.fromScale(0, 1.5),
				Rotation = clone.Rotation + random:NextInteger(-3, 3) * 10
			}, true).Completed:Once(function()
				task.wait(1)
				clone:Destroy()
			end)
		end
	end

	v20.OnClientEvent:Connect(function(s2: string, p8, n1: number)
		local v47 = t2[s2]

		if not v47 then
			return
		end

		local clone = v47:Clone()

		v47:Destroy()
		clone.Parent = workspace

		local Position = clone:GetPivot().Position
		local n2 = 0
		local _ = clone.Size
		local u52 = nil

		u52 = v23:Add(RunService.PostSimulation:Connect(function(n3: number)
			debug.profilebegin("Winter Hour:UpdateCandyAnimation")
			n2 += n3

			local v71 = p8.Character and p8.Character:GetPivot().Position or Vector3.new(0, 0, 0)
			local v72 = Position + (v71 - Position) * 0.25 + Vector3.new(0, 10, 0)
			local Value = TweenService:GetValue(n2 / 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In)

			clone:PivotTo(CFrame.new(MathUtils.quadBezier(Value, Position, v72, v71)))

			if Value >= 1 and u52 then
				v23:Remove(u52)
				u52 = nil
				clone:Destroy()
				task.spawn(function()
					SoundController:PlaySound(ReplicatedStorage.Sounds.Events["North Pole"].CandyCane2, v71)
				end)

				if p8 == Players.LocalPlayer then
					playScreenCandyCaneAnimation(n1)
				end

				playCharacterAnimation(p8, n1)
			end

			debug.profileend()
		end))
	end)
	v19.OnClientEvent:Connect(function(s3: string, vector3: Vector3, vector3_2: Vector3, n4: number, n5: number)
		local clone = script.Drop:Clone()

		clone.Name = s3
		t2[s3] = clone
		clone.Parent = workspace

		local ProximityPrompt = Instance.new("ProximityPrompt")

		ProximityPrompt.Name = "ProximityPrompt"
		ProximityPrompt.ActionText = ""
		ProximityPrompt.RequiresLineOfSight = false
		ProximityPrompt.Enabled = false
		ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
		ProximityPrompt:SetAttribute("CustomStyleDisabled", true)
		ProximityPrompt.Parent = clone

		local raycastResult = workspace:Raycast(vector3_2 + Vector3.new(0, 10, 0), Vector3.new(-0, -30, -0), raycastParams)
		local v61 = raycastResult and raycastResult.Position or vector3_2
		local v62 = vector3 + (v61 - vector3) * 0.5
		local v63 = v61
		local v64 = math.random(0, 10000)
		local u65 = false
		local n6 = 0
		local connection = RunService.PostSimulation:Connect(function(_: number)
			local v75 = workspace:GetServerTimeNow() - n4
			local v76 = if n5 ~= 0 then math.clamp(v75 / n5, 0, 1) else 1
			local Value = TweenService:GetValue(v76, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
			local v78 = MathUtils.quadBezier(Value, vector3, v62, v63)
			local v79 = os.clock() + v64

			clone:PivotTo(CFrame.new(v78 + Vector3.new(0, math.sin(v79 * 4) * 0.5 + 4, 0)))

			if Value >= 1 then
				ProximityPrompt.Enabled = true

				local elapsed = os.clock()

				if u65 and elapsed - n6 > 0.2 then
					n6 = elapsed
					v20:FireServer(s3)
				end
			end
		end)

		clone.Destroying:Connect(function()
			connection:Disconnect()
		end)
		ProximityPrompt.PromptShown:Connect(function()
			u65 = true
		end)
		ProximityPrompt.PromptHidden:Connect(function()
			u65 = false
		end)
	end)
	v18.OnClientEvent:Connect(function(s4: string)
		local v69 = t2[s4]

		if not v69 then
			return
		end

		v69:Destroy()
		t2[s4] = nil
	end)
end

return t1
