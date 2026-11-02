local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FriendBoostController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local BoostRemotes = Remotes:WaitForChild("FriendBoostService")
local FriendBoostUpdateEvent = BoostRemotes:WaitForChild("FriendBoostUpdate")
local GetFriendBoostFunction = BoostRemotes:WaitForChild("GetFriendBoost")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local friendBoostLabel = nil

local function setLabelText(text)
	if not friendBoostLabel then
		return
	end
	friendBoostLabel.Text = text
	for _, descendant in ipairs(friendBoostLabel:GetDescendants()) do
		if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
			descendant.Text = text
		end
	end
end

local function updateLabel(_friendCount, percent)
	local pct = math.floor(tonumber(percent) or 0)
	setLabelText("+" .. pct .. "%")
end

local function findHudFriendBoost()
	local gui = playerGui:WaitForChild("GUI", 10)
	if not gui then return nil end
	local hud = gui:WaitForChild("HUD", 10)
	if not hud then return nil end
	local rds = hud:WaitForChild("RightDownSide", 10)
	if not rds then return nil end
	return rds:WaitForChild("FriendBoost", 10)
end

function FriendBoostController.Init()
	local frame = findHudFriendBoost()
	if not frame then
		return
	end
	local button = frame:FindFirstChild("Button")
	if button then
		friendBoostLabel = button:FindFirstChild("Boost")
	end
	if not friendBoostLabel then
		warn("[FriendBoostController] Boost label missing under HUD.RightDownSide.FriendBoost.Button")
		return
	end

	frame.Visible = true
	setLabelText("+0%")

	FriendBoostUpdateEvent.OnClientEvent:Connect(function(friendCount, percent)
		updateLabel(friendCount, percent)
	end)

	task.spawn(function()
		for _ = 1, 20 do
			local ok, friendCount, percent = pcall(function()
				return GetFriendBoostFunction:InvokeServer()
			end)
			if ok and friendCount ~= nil then
				updateLabel(friendCount, percent)
				return
			end
			task.wait(0.5)
		end
	end)
end

return FriendBoostController