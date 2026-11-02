local EVENT_ID = "509394308042981999"
local Players = game:GetService("Players")
local SocialService = game:GetService("SocialService")
local player = Players.LocalPlayer

local function findEventPart()
	local p = workspace:FindFirstChild("EventPrompt")
	if p then return p end
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name == "EventPart" then return obj end
	end
end

local function setupPrompt()
	if not player.Character then player.CharacterAdded:Wait() end
	task.wait(2)
	local part = findEventPart()
	if not part then return end

	local prompt = part:FindFirstChildOfClass("ProximityPrompt") or part:WaitForChild("ProximityPrompt", 5)
	if not prompt then return end

	prompt.Triggered:Connect(function()
		task.spawn(pcall, SocialService.PromptRsvpToEventAsync, SocialService, EVENT_ID)
	end)
end

setupPrompt()
