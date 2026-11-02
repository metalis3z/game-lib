-- Reference copy for study. Game: steal-a-brainrot
-- Original: ServerScriptService/Services/StealService.lua
-- Excerpt of lines 1285-1390 (code unchanged; gaps marked with "-- [...]")
-- What it does: The server's Steal remote handler (type-checks args, rejects if already stealing, confirms
--   the thief's HumanoidRootPart is inside the victim plot's StealHitbox with GetPartBoundsInBox) plus a
--   10-second janitor loop that clears 'Steal' flags left behind by crashed or abandoned steals so podiums
--   never stay locked forever.

-- [lines 1285-1390]
StealRemote.OnServerEvent:Connect(function(player, time, key, plotName, podiumIndex)

	if typeof(plotName) ~= "string" then return end
	if typeof(podiumIndex) ~= "number" then return end
	if player:GetAttribute("Stealing") then return end

	-- Validate player is inside victim's plot StealHitbox
	local victimPlotChannel = Synchronizer:Get(plotName)
	if not victimPlotChannel then return end

	local victimOwner = victimPlotChannel:Get("Owner")
	if not victimOwner then return end

	-- Find the victim's plot model
	local victimPlot = nil
	for _, plot in ipairs(workspace.Plots:GetChildren()) do
		if plot.Name == plotName then
			victimPlot = plot
			break
		end
	end

	if not victimPlot then return end

	local stealHitbox = victimPlot:FindFirstChild("StealHitbox")
	if not stealHitbox then return end

	local character = player.Character
	if not character then return end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then return end

	-- Check if player is inside the StealHitbox
	local overlapParams = OverlapParams.new()
	overlapParams.FilterDescendantsInstances = {stealHitbox}
	overlapParams.FilterType = Enum.RaycastFilterType.Include
	overlapParams.MaxParts = 1

	local hrpPosition = humanoidRootPart.Position
	local partsInBox = workspace:GetPartBoundsInBox(
		CFrame.new(hrpPosition),
		humanoidRootPart.Size,
		overlapParams
	)

	if #partsInBox == 0 then
		-- Player is NOT inside the StealHitbox, reject the steal
		return
	end

	StealService:StartSteal(player, plotName, podiumIndex)

end)

-- Periodic cleanup of stale Steal flags on all plots
-- This prevents brainrots from becoming permanently locked when steal processes fail,
-- players disconnect mid-steal, or CancelSteal doesn't fully clean up.
-- Without this, the client blocks all prompts (Grab AND Steal) when it sees a stuck
-- Steal flag, and the server never gets a chance to clear it on-demand.
task.spawn(function()
	while task.wait(10) do
		local plotsFolder = workspace:FindFirstChild("Plots")
		if not plotsFolder then continue end

		for _, plot in ipairs(plotsFolder:GetChildren()) do
			local plotChannel = Synchronizer:Get(plot.Name)
			if not plotChannel then continue end

			local animalList = plotChannel:Get("AnimalList")
			if not animalList or typeof(animalList) ~= "table" then continue end

			for podiumIndex, animalData in pairs(animalList) do
				if typeof(animalData) == "table"
					and animalData.Steal
					and animalData.Steal ~= false
					and animalData.Steal ~= "FuseMachine"
				then
					local stealingUserId = animalData.Steal
					local numericPodiumIndex = tonumber(podiumIndex)

					-- Check if this steal is actually still active
					local stealTarget = activeStealTargets[stealingUserId]
					local isStale = true

					if stealTarget
						and stealTarget.VictimPlotUID == plot.Name
						and stealTarget.PodiumIndex == numericPodiumIndex
					then
						isStale = false
					end

					if isStale then
						warn(string.format(
							"[StealService] Periodic cleanup: Clearing stale Steal flag on plot %s podium %s (was UserId %s)",
							plot.Name, tostring(podiumIndex), tostring(stealingUserId)
						))
						plotChannel:Set(string.format("AnimalList.%s.Steal", tostring(podiumIndex)), false)
						plotChannel:Set(string.format("AnimalList.%s.Stolen", tostring(podiumIndex)), false)
					end
				end
			end
		end
	end
end)

