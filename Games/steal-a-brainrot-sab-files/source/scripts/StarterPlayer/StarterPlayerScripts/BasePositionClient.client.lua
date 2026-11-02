local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local gui = PlayerGui:WaitForChild("BasePositionGUI ", 30)
if not gui then return end
local BasePositionEvent = ReplicatedStorage:WaitForChild("BasePositionEvent", 10)
if not BasePositionEvent then return end

local fp = gui:FindFirstChild("FramePrincipal")
local fb = gui:FindFirstChild("FrameBackground")
local closeBtn = fp:FindFirstChild("CloseBtn")
local confirmFrame = fp:FindFirstChild("ConfirmFrame")
local errorLabel = fp:FindFirstChild("ErrorLabel")

local selectedBase = nil

local function showGUI()
	fp.Visible = true
	fb.Visible = true
	confirmFrame.Visible = false
	errorLabel.Visible = false
	errorLabel.Text = ""
end

local function hideGUI()
	fp.Visible = false
	fb.Visible = false
	-- Signal that base position is done so InfoSettingsButton can show
	player:SetAttribute("BasePositionDone", true)
end

local function showError(msg)
	errorLabel.Text = msg
	errorLabel.Visible = true
	errorLabel.BackgroundTransparency = 0.3
	task.delay(2.5, function()
		if errorLabel then
			errorLabel.Visible = false
			errorLabel.Text = ""
		end
	end)
end

-- Close button
closeBtn.MouseButton1Click:Connect(function()
	hideGUI()
end)

-- Base buttons
local btnNames = {"BASE 1 ", "BASE 2 ", "BASE 3 ", "BASE 4", "BASE 5", "BASE 6 ", "BASE 7 ", "BASE 8 "}
for i, name in ipairs(btnNames) do
	local btn = fp:FindFirstChild(name)
	if btn then
		btn.MouseButton1Click:Connect(function()
			selectedBase = i
			confirmFrame.Visible = true
		end)
	end
end

-- Yes button
local yesBtn = confirmFrame:FindFirstChild("YesBtn")
yesBtn.MouseButton1Click:Connect(function()
	if not selectedBase then return end
	confirmFrame.Visible = false
	BasePositionEvent:FireServer(selectedBase)
end)

-- No button
local noBtn = confirmFrame:FindFirstChild("NoBtn")
noBtn.MouseButton1Click:Connect(function()
	confirmFrame.Visible = false
	selectedBase = nil
end)

-- Server response
BasePositionEvent.OnClientEvent:Connect(function(type, msg)
	if type == "error" then
		showError(msg)
	elseif type == "success" then
		hideGUI()
	end
end)

-- Show immediately on join
showGUI()