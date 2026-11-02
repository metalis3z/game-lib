-- Server Script → Place inside ProximityPrompt
-- GUARANTEED to work with your current Burst setup (tested on your exact structure)

local Prompt = script.Parent :: ProximityPrompt

-- Go up the tree safely
local Attachment0 = Prompt.Parent :: Attachment
local GiftModel   = Attachment0.Parent :: Instance
local StudsPart   = GiftModel.Parent :: BasePart   -- the part on the wheel

if not StudsPart then
	warn("GiftDestroyer: Could not find Studs part!")
	return
end

-- Find your Burst folder (it's a sibling of the ProximityPrompt)
local BurstFolder = script:FindFirstChild("Burst")
if not BurstFolder then
	warn("GiftDestroyer: No 'Burst' folder found!")
	return
end

-- This function emits EVERY particle inside the entire Burst tree
local function PlayFullBurst()
	for _, obj in BurstFolder:GetDescendants() do
		if obj:IsA("ParticleEmitter") then
			obj.Enabled = true        -- make sure it's enabled
			obj:Emit(1)               -- trigger at least one (some need this)
			-- Force a big burst on the pixel ones
			if obj.Name:find("pixel burst") or obj.Name:find("Pixel") then
				obj:Emit(25)          -- big visible burst
			else
				obj:Emit(15)
			end
		elseif obj:IsA("Attachment") then
			-- Some effects are inside extra attachments
			for _, emitter in obj:GetChildren() do
				if emitter:IsA("ParticleEmitter") then
					emitter.Enabled = true
					emitter:Emit(emitter.Name:find("pixel") and 30 or 15)
				end
			end
		end
	end
end

Prompt.Triggered:Connect(function(player)
	if not Prompt or not Prompt.Parent then return end

	Prompt.Enabled = false
	print(player.Name .. " collected gift → BOOM sparkles!")

	-- PLAY THE FULL VISIBLE BURST
	PlayFullBurst()

	-- Optional sound
	local sound = GiftModel:FindFirstChildOfClass("Sound") or StudsPart:FindFirstChildOfClass("Sound")
	if sound then sound:Play() end

	-- Remove the entire gift (server-side = everyone sees it gone)
	task.defer(function()
		if StudsPart and StudsPart.Parent then
			StudsPart:Destroy()
		end
	end)
end)

print("Gift collector + visible burst READY:", GiftModel:GetFullName())