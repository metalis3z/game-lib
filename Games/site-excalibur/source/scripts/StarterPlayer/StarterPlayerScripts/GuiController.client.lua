local plr = game.Players.LocalPlayer
local plrgui = plr.PlayerGui

local PS = game:GetService("ProximityPromptService")

local CustomPrompt = game.ReplicatedStorage.Prompt

local function createPrompt(prompt, inputType, gui)
	local promptUI = CustomPrompt:Clone()
	promptUI.Adornee = prompt.Parent
	promptUI.Parent = gui
end

local function deletePrompt(prompt, gui)
	local UIs = gui:GetChildren()
	for i, v in pairs(UIs) do
		if v.Name == "Prompt" then
			if v.Adornee == prompt.Parent then
				v:Destroy()
			end
		end
	end
end

local function getScreenGui()
	local screenGui = plrgui:FindFirstChild("ProximityPrompts")
	if screenGui == nil then
		local gui1 = Instance.new("ScreenGui")
		gui1.Name = "ProximityPrompts"
		gui1.ResetOnSpawn = false
		gui1.Parent = plrgui
	end
	screenGui = plrgui:FindFirstChild("ProximityPrompts")
	return screenGui
end

PS.PromptShown:Connect(function(prompt, inputType)
	if prompt.Style == Enum.ProximityPromptStyle.Default then
		return
	end
	
	local gui = getScreenGui()
	createPrompt(prompt, inputType, gui)	
end)

PS.PromptHidden:Connect(function(prompt, inputType)
	if prompt.Style == Enum.ProximityPromptStyle.Default then
		return
	end

	local gui = getScreenGui()
	deletePrompt(prompt, gui)	
end)

PS.PromptTriggered:Connect(function(prompt, plr)
	local UIs = plr.PlayerGui:FindFirstChild("ProximityPrompts"):GetChildren()
	for i, v in pairs(UIs) do
		if v.Name == "Prompt" then
			if v.Adornee == prompt.Parent then
				local UI = v.Frame
				UI.TopBar.ButtonImage.ImageColor3 = Color3.fromRGB(190, 190, 190)
				UI.TopBar.ActionText.TextColor3 = Color3.fromRGB(190, 190, 190)
				UI.TopBar.ButtonText.TextColor3 = Color3.fromRGB(190, 190, 190)
			end
		end
	end
end)

PS.PromptTriggerEnded:Connect(function(prompt, plr)
	local UIs = plr.PlayerGui:FindFirstChild("ProximityPrompts"):GetChildren()
	for i, v in pairs(UIs) do
		if v.Name == "Prompt" then
			if v.Adornee == prompt.Parent then
				local UI = v.Frame
				UI.TopBar.ButtonImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
				UI.TopBar.ActionText.TextColor3 = Color3.fromRGB(255, 255, 255)
				UI.TopBar.ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
		end
	end
end)