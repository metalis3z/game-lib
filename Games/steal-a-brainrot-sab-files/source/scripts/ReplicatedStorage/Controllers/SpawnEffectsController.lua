-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)
local EventController = require(ReplicatedStorage.Controllers.EventController)
return {
	Start = function(self)
		Net:RemoteEvent("GameService/SpawnEffect").OnClientEvent:Connect(function(effectName, duration, targetCFrame)

			if not targetCFrame then
				local roadStart = workspace.Road:FindFirstChild("Start")
				targetCFrame = roadStart and roadStart.CFrame or script.RoadStartBase.CFrame
			end

			assert(targetCFrame)

			local isAprilFools = ReplicatedStorage:GetAttribute("AprilFoolsMode")
			local isBossEventActive = EventController:IsActive("1x1x1x1")

			if isAprilFools and not isBossEventActive then
				targetCFrame = targetCFrame * CFrame.Angles(0, math.pi, 0)
			end

			local effectModel = script[effectName]:Clone()
			local alignmentPart = script.RoadStartBase:Clone()

			alignmentPart.Parent = effectModel
			effectModel.PrimaryPart = alignmentPart
			effectModel:PivotTo(targetCFrame)

			effectModel.PrimaryPart = nil
			alignmentPart:Destroy()

			effectModel.Parent = workspace

			VFX.emit(effectModel)

			for _, child in effectModel:GetDescendants() do
				if child:IsA("Sound") then
					child:Play()
				end
			end

			task.wait(duration + 5)
			effectModel:Destroy()
		end)
	end
}