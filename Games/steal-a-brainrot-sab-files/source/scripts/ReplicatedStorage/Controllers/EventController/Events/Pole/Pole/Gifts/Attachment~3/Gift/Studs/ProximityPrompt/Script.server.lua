
local Prompt = script.Parent :: ProximityPrompt

local Attachment0 = Prompt.Parent :: Attachment
local GiftModel   = Attachment0.Parent :: Instance
local StudsPart   = GiftModel.Parent :: BasePart

if not StudsPart then
	warn("GiftDestroyer: Could not find Studs part!")
	return
end

local BurstFolder = script:FindFirstChild("Burst")
if not BurstFolder then
	warn("GiftDestroyer: No 'Burst' folder found!")
	return
end

local function PlayFullBurst()
	for _, obj in BurstFolder:GetDescendants() do
		if obj:IsA("ParticleEmitter") then
			obj.Enabled = true
			obj:Emit(1)
			if obj.Name:find("pixel burst") or obj.Name:find("Pixel") then
				obj:Emit(25)
			else
				obj:Emit(15)
			end
		elseif obj:IsA("Attachment") then
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

	PlayFullBurst()

	local sound = GiftModel:FindFirstChildOfClass("Sound") or StudsPart:FindFirstChildOfClass("Sound")
	if sound then sound:Play() end

	task.defer(function()
		if StudsPart and StudsPart.Parent then
			StudsPart:Destroy()
		end
	end)
end)

print("Gift collector + visible burst READY:", GiftModel:GetFullName())