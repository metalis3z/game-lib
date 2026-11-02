local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local isInZone = false

-- Get the button
local gui = script.Parent
local button = gui:WaitForChild("InteractButton")

-- Show/hide button
local function setInZone(inZone)
	if inZone == isInZone then return end
	isInZone = inZone
	button.Visible = inZone
end

-- Distance check loop (reliable on both PC and mobile)
task.spawn(function()
	while true do
		task.wait(0.3)
		local character = player.Character
		if character then
			local hrp = character:FindFirstChild("HumanoidRootPart")
			if hrp then
				local cloture = Workspace:FindFirstChild("cloture animals")
				if cloture then
					local hitbox = cloture:FindFirstChild("ClotureHitbox")
					if hitbox then
						local dist = (hrp.Position - hitbox.Position).Magnitude
						local maxDist = math.max(hitbox.Size.X, hitbox.Size.Z) / 2
						if dist <= maxDist then
							setInZone(true)
						else
							setInZone(false)
						end
					end
				end
			end
		end
	end
end)

-- Handle button click
button.MouseButton1Click:Connect(function()
	-- Flash effect on click
	button.BackgroundColor3 = Color3.fromRGB(20, 120, 50)
	task.wait(0.1)
	button.BackgroundColor3 = Color3.fromRGB(40, 180, 80)

	-- Here you can add what happens when the player interacts
	-- For example: open a gate, show a message, spawn animals, etc.
	print(player.Name .. " a interagi avec la cloture animals!")
end)
