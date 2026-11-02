-- Prompts.lua v3.4 by VanillaEdge
-- Place in StarterCharacterScripts

local ProximityPromptService = game:GetService("ProximityPromptService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local drivePrompt = script:WaitForChild("DrivePrompt")
local sitPrompt = script:WaitForChild("SitPrompt")

-- Functions
local function trackPrompt(prompt: ProximityPrompt)
	local seat = prompt.Parent
	prompt.Triggered:Connect(function(player: Player)
		if seat.Occupant then return end
		seat:Sit(humanoid)
	end)

	seat:GetPropertyChangedSignal("Occupant"):Connect(function()
		prompt.Enabled = not seat.Occupant
	end)
end

local function createPrompts(child: Instance)
	if child.Name ~= "DriveSeat" then return end
	local car = child.Parent :: Model
	
	for _, descendant in car:GetDescendants() do
		if descendant:IsA("VehicleSeat") then
			local prompt = descendant:FindFirstChild("DrivePrompt")
			if not prompt then
				prompt = drivePrompt:Clone()
				prompt.Parent = descendant
			end
			prompt.Enabled = not descendant.Occupant
			trackPrompt(prompt)
		elseif descendant:IsA("Seat") then
			local prompt = descendant:FindFirstChild("SitPrompt")
			if not prompt then
				prompt = sitPrompt:Clone()
				prompt.Parent = descendant
			end
			prompt.Enabled = not descendant.Occupant
			trackPrompt(prompt)
		end
	end
end

-- Connections
humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
	ProximityPromptService.MaxPromptsVisible = humanoid.Sit and 0 or math.huge
end)

workspace.DescendantAdded:Connect(function(child: Instance)
	createPrompts(child)
end)

-- Initialise
ProximityPromptService.MaxPromptsVisible = math.huge
for _, child in workspace:GetDescendants() do
	createPrompts(child)
end
