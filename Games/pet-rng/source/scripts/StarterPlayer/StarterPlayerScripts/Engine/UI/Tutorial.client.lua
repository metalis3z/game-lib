--fruskle is the bEST and I LOVE FRUSKLE ALAN ALAN ALAN ALAN ALAN ALAN ALAN ALAN ALAN ALAN ALAN ALAN KRAZURA ALAN KRAZURA ALAN KRAZURA

local plr = game.Players.LocalPlayer
local frame = plr.PlayerGui:WaitForChild("GUI"):WaitForChild("Frames"):WaitForChild("Tutorial")
local nextButton = frame["Arrow Right"]
local backButton = frame["Arrow Left"]
local img = frame.Img
local desc = frame.Description
local descShadow = frame["Description Shadow"]
local stages = require(game:GetService("ReplicatedStorage").DataModules.TutorialStages)
local toggle = plr.PlayerGui.GUI.Left.Tutorial

local currentStage = 0

local function checkForFirstTime()
	repeat wait() until plr:FindFirstChild("logInTimes")
	if plr.logInTimes.Value > 1 then
	return true
	else
	return false
	end
end

local function refresh(data)
	desc.Text = data.desc
	descShadow.Text = data.desc
	img.Image = data.img
end

nextButton.MouseButton1Down:Connect(function()
	if currentStage >= stages.maxStage then
		frame.Visible = false
	else
		currentStage += 1
		refresh(stages[currentStage])
	end
end)

backButton.MouseButton1Down:Connect(function()
	if currentStage >= stages.maxStage then
		frame.Visible = false
	elseif currentStage >= 1 then
		currentStage -= 1
		refresh(stages[currentStage])
	end
end)

if checkForFirstTime() then
	frame.Visible = true
	refresh(stages[currentStage])
end
toggle.MouseButton1Down:Connect(function()
	currentStage = 0
	refresh(stages[currentStage])
end)