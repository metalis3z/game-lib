local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local TikfinityModules = ReplicatedStorage:FindFirstChild("TikfinityModules")

local COLORS = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 100, 255),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(255, 0, 255),
	Color3.fromRGB(0, 255, 255),
	Color3.fromRGB(255, 128, 0),
}

local FLASH_INTERVAL = 0.15
local activeDisco = nil

local function runDisco(duration)
	-- Si un disco est deja en cours, on le stoppe d'abord
	if activeDisco and activeDisco.Parent then
		activeDisco:Destroy()
	end

	local effect = Instance.new("ColorCorrectionEffect")
	effect.Name = "TikfinityDisco"
	effect.Parent = Lighting
	activeDisco = effect

	task.spawn(function()
		local startTime = os.clock()
		local colorIndex = 1
		while os.clock() - startTime < duration do
			effect.TintColor = COLORS[colorIndex]
			colorIndex = colorIndex % #COLORS + 1
			task.wait(FLASH_INTERVAL)
		end
		if effect and effect.Parent then
			effect:Destroy()
		end
		if activeDisco == effect then
			activeDisco = nil
		end
	end)
end

return function(context, duration)
	duration = duration or 15
	local sender = context.Executor

	runDisco(duration)

	return string.format("Disco event lance par %s pour %d secondes !", sender.Name, duration)
end