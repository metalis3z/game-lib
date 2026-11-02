local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
-- Paid access: the server decides whether the player may open the panel
-- (they must own the Admin Panel gamepass) and shows the purchase prompt
-- when they do not.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exoremotes = ReplicatedStorage:WaitForChild("exoremotes", 10)
local requestPanel = exoremotes and exoremotes:WaitForChild("RequestPanel", 10)
local accessResult = exoremotes and exoremotes:WaitForChild("PanelAccessResult", 10)

-- Find the AdminPanel ScreenGui in PlayerGui
local function getAdminPanelGui()
	return playerGui:FindFirstChild("AdminPanel")
end

-- Find the ProximityPrompt in the workspace
local function getProximityPrompt()
	local stand = Workspace:FindFirstChild("AdminPanelStand")
	if not stand then return nil end
	local sign = stand:FindFirstChild("Sign")
	if not sign then return nil end
	return sign:FindFirstChild("AdminPanelPrompt")
end

-- Open the admin panel
local function openAdminPanel()
	local adminGui = getAdminPanelGui()
	if not adminGui then return end

	adminGui.Enabled = true

	-- Make sure the Info sub-frame is hidden when opening
	local main = adminGui:FindFirstChild("Main")
	if main then
		local info = main:FindFirstChild("Info")
		if info then
			info.Visible = false
		end
	end
end

-- Ask the server for permission instead of opening the panel directly.
local function requestOpenAdminPanel()
	if requestPanel then
		requestPanel:FireServer()
	else
		-- Remotes unavailable (server handler missing): fall back to direct open.
		openAdminPanel()
	end
end

-- The server grants access when the gamepass is owned or has just been purchased.
if accessResult then
	accessResult.OnClientEvent:Connect(function(granted)
		if granted then
			openAdminPanel()
		end
	end)
end

-- Close the admin panel
local function closeAdminPanel()
	local adminGui = getAdminPanelGui()
	if not adminGui then return end
	adminGui.Enabled = false
end

-- Connect the ProximityPrompt
local function connectPrompt()
	local prompt = getProximityPrompt()
	if not prompt then return false end

	prompt.Triggered:Connect(function()
		requestOpenAdminPanel()
	end)

	return true
end

-- Connect the Header close button to close the panel
local function connectCloseButton()
	local adminGui = getAdminPanelGui()
	if not adminGui then return false end

	local main = adminGui:FindFirstChild("Main")
	if not main then return false end

	local header = main:FindFirstChild("Header")
	if not header then return false end

	local closeBtnFrame = header:FindFirstChild("CloseBtnFrame")
	if not closeBtnFrame then return false end

	local btnFrame = closeBtnFrame:FindFirstChild("BtnFrame")
	if not btnFrame then return false end

	local button = btnFrame:FindFirstChild("Button")
	if not button then return false end

	button.MouseButton1Click:Connect(function()
		closeAdminPanel()
	end)

	return true
end

-- Connect the Tools "Admin Panel" button to open the panel
local function connectAdminButton()
	local elements = playerGui:FindFirstChild("Elements")
	if not elements then return false end

	local left = elements:FindFirstChild("Left")
	if not left then return false end

	local tools = left:FindFirstChild("Tools")
	if not tools then return false end

	local adminPanelFrame = tools:FindFirstChild("AdminPanel")
	if not adminPanelFrame then return false end

	local button = adminPanelFrame:FindFirstChild("Button")
	if not button then return false end

	button.MouseButton1Click:Connect(function()
		requestOpenAdminPanel()
	end)

	return true
end

-- Wait for the AdminPanel GUI to be available in PlayerGui
local adminGui = playerGui:WaitForChild("AdminPanel", 10)
if adminGui then
	-- Ensure it starts disabled
	adminGui.Enabled = false

	-- Connect the close button
	connectCloseButton()
end

-- Try to connect the prompt, retry if the stand isn't loaded yet
local connected = connectPrompt()
if not connected then
	-- Listen for the stand being added later
	Workspace.ChildAdded:Connect(function(child)
		if child.Name == "AdminPanelStand" then
			task.wait(0.5)
			connectPrompt()
		end
	end)
end

-- Also re-connect the close button if the GUI gets re-parented
playerGui.ChildAdded:Connect(function(child)
	if child.Name == "AdminPanel" then
		task.wait(0.5)
		connectCloseButton()
	end
end)

-- Connect the Tools "Admin Panel" button to open the panel
local adminButtonConnected = connectAdminButton()
if not adminButtonConnected then
	-- Retry if the Elements GUI isn't loaded yet
	playerGui.ChildAdded:Connect(function(child)
		if child.Name == "Elements" then
			task.wait(0.5)
			connectAdminButton()
		end
	end)
end