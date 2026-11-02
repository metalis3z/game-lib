local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Looking for GameFrame directly in PlayerGui
local gameFrame = playerGui:FindFirstChild("GameFrame", true) 
local mainFrame = gameFrame and gameFrame:FindFirstChild("MainFrame")
local showHideBtn = mainFrame and mainFrame:FindFirstChild("Show/Hide") or script.Parent

-- Store positions
local originalPosition = mainFrame and mainFrame.Position or UDim2.new(0.333, 0, 0, 0)
local hiddenPosition = UDim2.new(0.333, 0, -0.292, 0) 

local isHidden = false

local function toggleMainFrame()
	isHidden = not isHidden

	if mainFrame then
		if isHidden then
			-- Move the frame to the hidden position
			mainFrame.Position = hiddenPosition
			if showHideBtn:IsA("TextButton") then showHideBtn.Text = "Show" end
		else
			-- Move the frame back to original position
			mainFrame.Position = originalPosition
			if showHideBtn:IsA("TextButton") then showHideBtn.Text = "Hide" end
		end
	end
end

if showHideBtn and showHideBtn:IsA("GuiButton") then
	showHideBtn.MouseButton1Click:Connect(toggleMainFrame)
end