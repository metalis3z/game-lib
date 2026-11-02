-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local PoleGameController = {}
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local DestroyGear = Net:RemoteEvent("PoleGameService/DestroyGear")
local SpawnGear = Net:RemoteEvent("PoleGameService/SpawnGear")
local PickGear = Net:RemoteEvent("PoleGameService/PickGear")
local Blink = Net:RemoteEvent("PoleGameService/Blink")
local Burst = Net:RemoteEvent("PoleGameService/Burst")

local RayParams = RaycastParams.new()
RayParams.FilterType = Enum.RaycastFilterType.Include
RayParams.FilterDescendantsInstances = {
	workspace.Map,
	workspace.Plots
}

return {
	Start = function(_)
		task.spawn(pcall, ContentProvider.PreloadAsync, ContentProvider, script:GetChildren())

		Blink.OnClientEvent:Connect(function()
			EffectController:Activate("Blink")
		end)

		Burst.OnClientEvent:Connect(function(position)
			local burstEffect = script.Burst:Clone()

			if burstEffect:IsA("BasePart") then
				burstEffect.Position = position
			elseif burstEffect:IsA("Model") and burstEffect.PrimaryPart then
				burstEffect:SetPrimaryPartCFrame(CFrame.new(position))
			end
          
			burstEffect.Parent = workspace
			VFX.emit(burstEffect)
			SoundController:PlaySound(ReplicatedStorage.Sounds.Events.PoleGame.Burst)
			Debris:AddItem(burstEffect, 7)
		end)

		local ActiveGears = {}
		SpawnGear.OnClientEvent:Connect(function(id, name, startPos, endPos, serverTime, duration)
			local gearVisual = script.GearVisuals[name]:Clone()
			gearVisual.Name = id
			ActiveGears[id] = gearVisual

			local handle = gearVisual.PrimaryPart or gearVisual:FindFirstChild("Handle")
			if handle then
				handle.Anchored = true

				local att0 = Instance.new("Attachment")
				att0.Name = "Attachment0"
				att0.Position = Vector3.new(0, 1, 0)
				att0.Parent = handle

				local att1 = Instance.new("Attachment")
				att1.Name = "Attachment1"
				att1.Position = Vector3.new(0, -1, 0)
				att1.Parent = handle

				local trail = Instance.new("Trail")
				trail.Name = "Trail"
				trail.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 119, 248)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(105, 255, 243))
				})
				trail.Attachment0 = att0
				trail.Attachment1 = att1
				trail.Lifetime = 0.35
				trail.LightInfluence = 1
				trail.Parent = gearVisual
			end

			gearVisual.Parent = workspace

			local prompt = Instance.new("ProximityPrompt")
			prompt.Name = "ProximityPrompt"
			prompt.ActionText = "Grab"
			prompt.RequiresLineOfSight = false
			prompt.Enabled = false
			prompt.Parent = handle

			local initialScale = gearVisual:GetScale()
			local raycastResult = workspace:Raycast(endPos + Vector3.new(0, 10, 0), Vector3.new(0, -30, 0), RayParams)
			local groundPos = raycastResult and raycastResult.Position or endPos

			local midPos = startPos + (groundPos - startPos) * 0.5
			local finalPos = groundPos + Vector3.new(0, gearVisual:GetExtentsSize().Y * 0.5, 0)
			local randomOffset = math.random(0, 10000)

			local connection
			connection = RunService.PostSimulation:Connect(function()
				local elapsedTime = workspace:GetServerTimeNow() - serverTime
				local alpha = duration == 0 and 1 or math.clamp(TweenService:GetValue(elapsedTime / duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 0, 1)

				local currentPos = MathUtils.quadBezier(alpha, startPos, midPos, finalPos)
				gearVisual:ScaleTo(math.lerp(initialScale * 2, initialScale, alpha))

				local wobbleTime = os.clock() + randomOffset
				local finalCFrame = CFrame.new(currentPos + Vector3.new(0, math.sin(wobbleTime * 2) + 1.5, 0)) * CFrame.Angles(0, wobbleTime % (2 * math.pi), 0)
				gearVisual:PivotTo(finalCFrame)

				if alpha >= 1 then
					prompt.Enabled = true
				end
			end)

			gearVisual.Destroying:Connect(function()
				connection:Disconnect()
			end)

			prompt.Triggered:Connect(function()
				PickGear:FireServer(id)
			end)
		end)

		DestroyGear.OnClientEvent:Connect(function(id)
			local gearVisual = ActiveGears[id]
			if gearVisual then
				gearVisual:Destroy()
				ActiveGears[id] = nil
			end
		end)
		return PoleGameController
	end
}
