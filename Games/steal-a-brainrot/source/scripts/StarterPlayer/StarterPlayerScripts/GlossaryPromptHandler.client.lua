local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local GlossaryController
local requireOk = pcall(function()
	GlossaryController = require(ReplicatedStorage.Controllers.GlossaryController)
end)
if not requireOk then
	warn("[GlossaryPromptHandler] Failed to require GlossaryController, using direct GUI toggle")
end

local isOpen = false

local function getGui()
	local player = Players.LocalPlayer
	if not player then return nil end
	return player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("Glossary")
end

local function openGlossary()
	local gui = getGui()
	if GlossaryController then
		local ok, err = pcall(function() GlossaryController:Open() end)
		if ok then return end
		warn("[GlossaryPromptHandler] Open failed: " .. tostring(err))
	end
	if gui then gui.Enabled = true end
end

local function closeGlossary()
	local gui = getGui()
	if GlossaryController then
		local ok, err = pcall(function() GlossaryController:Close() end)
		if ok then return end
		warn("[GlossaryPromptHandler] Close failed: " .. tostring(err))
	end
	if gui then gui.Enabled = false end
end

local function setupPrompt()
	local glossary = Workspace:FindFirstChild("Glossary")
	if not glossary then return end

	local promptPart = glossary:FindFirstChild("Prompt")
	local prompt = promptPart and promptPart:FindFirstChildOfClass("ProximityPrompt")
	if not prompt then return end

	local toggleDebounce = false
	prompt.Triggered:Connect(function()
		if toggleDebounce then return end
		toggleDebounce = true
		if isOpen then
			closeGlossary()
		else
			openGlossary()
		end
		isOpen = not isOpen
		task.wait(0.5)
		toggleDebounce = false
	end)
end

task.spawn(function()
	local glossary = Workspace:WaitForChild("Glossary", 60)
	if glossary then
		setupPrompt()
	end
end)