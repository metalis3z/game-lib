local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local WorldBrainrotController = require(ReplicatedStorage.Controllers.WorldBrainrotController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)

local BreakRemote = Net:RemoteEvent("EggrotCandyCage/Break")

local BREAK_TWEEN_IN = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In)
local BOUNCE_TWEEN = TweenInfo.new(0.8, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)

return table.freeze({
	Start = function(_, renderedBrainrots)
		local trove = Trove.new()
		local poolCompat = WorldBrainrotController.get("EggrotHunt/Brainrots")

		trove:Add(BreakRemote.OnClientEvent:Connect(function(brainrotId, cagePosition, targetCFrame)
			SoundController:PlaySound("Sounds.Events.Easter.CageBreak", cagePosition, false)

			local entry = renderedBrainrots[brainrotId]
			if entry and entry.prompt then
				entry.prompt.Enabled = true
			end

			local originCF = nil
			local conn = nil
			local startTime = os.clock()

			conn = RunService.PostSimulation:Connect(function()
				local e = renderedBrainrots[brainrotId]
				if not e or not e.model then return end

				if not originCF then
					originCF = e.model:GetPivot()
				end

				local t = math.clamp((os.clock() - startTime) / 0.8, 0, 1)
				local bounced = TweenService:GetValue(t, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
				e.model:PivotTo(originCF:Lerp(targetCFrame, bounced))

				if t >= 1 then
					conn:Disconnect()
					conn = nil
				end
			end)

			trove:Add(function()
				if conn then conn:Disconnect() end
			end)
		end))

		return trove, function(id)
			local entry = renderedBrainrots[id]
			if not entry or not entry.prompt then return end
			local data = poolCompat:TryIndex({"brainrots", id})
			if data and data.caged then
				entry.prompt.Enabled = false
			end
		end
	end,
})