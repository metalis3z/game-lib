local speedBoost = 2 -- Speed boost multiplier when ice cream is licked
local lickCount = 0 -- Counter for number of licks
local lickThreshold = 3 -- Number of licks needed for a speed boost
local parent = game.ServerStorage.ToysDatabase.Toys.IceCream.IceCreamConeBrainfreezeGui -- Getting the GUI

local brainFreezeTime = 5 -- Duration of brainfreeze effect
local brainFreezeGui = parent.IceCreamBrainfreezeGui -- Brainfreeze GUI to show to player

local function onIceCreamLicked()
	lickCount = lickCount + 1

	-- Check if player has licked ice cream too many times
	if lickCount >= lickThreshold then
		local humanoid = script.Parent:FindFirstChildOfClass("Humanoid")
		if humanoid then
			-- Apply brainfreeze effect
			humanoid:TakeDamage(5)
			local player = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
			if player and brainFreezeGui then
				local gui = brainFreezeGui:Clone()
				gui.Parent = player.PlayerGui
				gui.Enabled = true
				wait(brainFreezeTime)
				gui:Destroy()
			end
		end
		lickCount = 0
	else
		-- Apply speed boost
		local humanoid = script.Parent:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = humanoid.WalkSpeed * speedBoost
		end
	end
end

script.Parent.Activated:Connect(onIceCreamLicked)

