local GroupService = game:GetService("GroupService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local groupId = tonumber(script:GetAttribute("gr")) or 599488580

local function getBoardUi()
	local lobby = workspace:WaitForChild("Lobby", 15)
	local board = lobby and lobby:WaitForChild("CodeBoard", 15)
	local screen = board and board:WaitForChild("Screen", 15)
	local surface = screen and screen:WaitForChild("Surface", 15)
	local main = surface and surface:WaitForChild("Main", 15)
	local codes = main and main:WaitForChild("Codes", 15)
	local locked = main and main:WaitForChild("Locked", 15)
	if not (surface and main and codes and locked) then
		return nil
	end
	return surface, main, codes, locked
end

local function keepBoardSizing(surface, main, codes)
	surface.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
	surface.CanvasSize = Vector2.new(650, 730)
	surface.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	surface.LightInfluence = 0

	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.Position = UDim2.fromScale(0.5, 0.5)
	main.Size = UDim2.fromScale(0.95, 0.95)
	main.ClipsDescendants = true

	local title = main:FindFirstChild("Title")
	if title and title:IsA("TextLabel") then
		title.AnchorPoint = Vector2.new(0, 0)
		title.Position = UDim2.new(0, 0, 0, 8)
		title.Size = UDim2.new(1, 0, 0.085, 0)
	end

	codes.AnchorPoint = Vector2.new(0.5, 1)
	codes.Position = UDim2.new(0.5, 0, 0.99, 9)
	codes.Size = UDim2.new(1, 0, 0.9, 0)
	codes.ClipsDescendants = true

	local holder = codes:FindFirstChild("Holder")
	if holder and holder:IsA("ScrollingFrame") then
		holder.AnchorPoint = Vector2.new(0.5, 1)
		holder.Position = UDim2.new(0.5, 0, 1, 0)
		holder.Size = UDim2.fromScale(1, 1)
		holder.Active = true
		holder.Selectable = true
		holder.ScrollingEnabled = true
		holder.ScrollingDirection = Enum.ScrollingDirection.Y
		holder.ScrollBarThickness = 10
		local container = holder:FindFirstChild("Container")
		if container then
			local rows = 0
			for _, child in ipairs(container:GetChildren()) do
				if child:IsA("Frame") and child.Name:match("^CodeRow_") then
					rows += 1
				end
			end
			container.Position = UDim2.new(0, 5, 0, 5)
			container.Size = UDim2.new(1, -20, 0, rows * 150)
			holder.CanvasSize = UDim2.fromOffset(0, rows * 150 + 10)
		end
	end
end

local function inGroup()
	local ok, result = pcall(function()
		return player:IsInGroup(groupId)
	end)
	return ok and result == true
end

local function setAccess()
	local surface, main, codes, locked = getBoardUi()
	if not codes then
		warn("[CodeBoard] Board UI missing")
		return
	end

	keepBoardSizing(surface, main, codes)
	local allowed = inGroup()
	codes.Visible = allowed
	locked.Visible = not allowed
	locked:SetAttribute("gr", tostring(groupId))
end

local surface, main, codes, locked = getBoardUi()
if codes and locked then
	keepBoardSizing(surface, main, codes)
	local joinButton = locked:FindFirstChild("Join", true) or locked:FindFirstChild("Buy", true)
	if joinButton and joinButton:IsA("GuiButton") then
		joinButton.Activated:Connect(function()
			pcall(function()
				GroupService:PromptJoinAsync(groupId)
			end)
			task.delay(2, setAccess)
			task.delay(8, setAccess)
		end)
	end
end

setAccess()
