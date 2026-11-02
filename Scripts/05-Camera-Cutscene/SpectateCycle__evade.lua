-- Reference copy for study. Game: evade
-- Original: ServerScriptService/Controllers/SpectateController.lua  (ModuleScript, 238 lines)
-- What it does: Spectate UI controller: keeps a list of other players and switches Camera.CameraSubject with Next / Last buttons.
-- Excerpt of lines 1-148 (of 238)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local Classes = ReplicatedStorage:WaitForChild("Classes")
local Camera = workspace.CurrentCamera

local Net = require(ReplicatedStorage.Packages.Net)
local InterfaceController = require(Controllers.InterfaceController)
local AnimatedButton = require(Classes.AnimatedButton)
local NotificationController = require(Controllers.NotificationController)
local RemoteEvent = Net:RemoteEvent("ShopService/Purchase")

local SpectateUI = Player:WaitForChild("PlayerGui"):WaitForChild("Main"):WaitForChild("Spectate")
local TrollUI = Player:WaitForChild("PlayerGui"):WaitForChild("Main"):WaitForChild("Troll")
local Playerlist = {}
local currIndex = 1

local db = false

local currentTarget = nil

local notifyIfOpen

local function UpdatePlayers()
	Playerlist = {}
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= Player then
			table.insert(Playerlist, plr)
		end
	end
	if currIndex > #Playerlist then
		currIndex = 1
	end

	if #Playerlist == 0 then
		currentTarget = nil
		Camera.CameraSubject = Player.Character:FindFirstChild("Humanoid") or Player.Character:FindFirstChildWhichIsA("BasePart")
		notifyIfOpen("No other players to spectate!")
	end
end

local function UpdateCamera(player)
	SpectateUI.Frame.PlayerName.Text = player.Name
	Camera.CameraSubject = player.Character:FindFirstChild("Humanoid") or player.Character:FindFirstChildWhichIsA("BasePart")
	currentTarget = player
end

local TrollProductIds = {
	["Kill"] = 3341181646,
	["Fling"] = 3341181173,
	["Goto"] = 3341182175,
	["ResetData"] = 3341180637,
}

notifyIfOpen = function(msg)
	local ui = InterfaceController:Get("Spectate")
	if ui and ui:IsOpened() then
		NotificationController:Error(msg)
	end
end

local SpectateController = {}

SpectateController.Start = function()
	InterfaceController:Register("Spectate", SpectateUI, "TopSpectate");
	InterfaceController:Register("Troll", TrollUI, "TopSpectate");

	local spectateUIInterface = InterfaceController:Get("Spectate")
	local trollUIInterface = InterfaceController:Get("Troll")

	local function resetCameraToSelf()
		if Player.Character then
			Camera.CameraSubject = Player.Character:FindFirstChild("Humanoid") or Player.Character:FindFirstChildWhichIsA("BasePart")
		end
	end

	if spectateUIInterface then
		if spectateUIInterface:IsOpened() then
			spectateUIInterface:Close()
		end
		spectateUIInterface.OnClose:Connect(function()
			resetCameraToSelf()
			currentTarget = nil
		end)
	end

	if trollUIInterface and trollUIInterface:IsOpened() then
		trollUIInterface:Close()
	end

	UpdatePlayers()
	Players.PlayerAdded:Connect(UpdatePlayers)
	Players.PlayerRemoving:Connect(UpdatePlayers)

	local AnimatedButton1 = AnimatedButton.new(SpectateUI.Next)
	AnimatedButton1:Animate()

	AnimatedButton1.OnActivated:Connect(function()
		if not db then
			db = true
			currIndex += 1
			if currIndex > #Playerlist then
				currIndex = 1
			end

			local selectedPlayer = Playerlist[currIndex]
			warn(selectedPlayer)
			if selectedPlayer then
				UpdateCamera(selectedPlayer)
			end

			if #Playerlist == 0 then
				notifyIfOpen("No other players to spectate!")
				db = false
				return
			end

			db = false
		end
	end)

	local AnimatedButton2 = AnimatedButton.new(SpectateUI.Last)
	AnimatedButton2:Animate()

	AnimatedButton2.OnActivated:Connect(function()
		if not db then
			db = true
			currIndex -= 1
			if currIndex < 1 then
				currIndex = #Playerlist
			end

			local selectedPlayer = Playerlist[currIndex]
			warn(selectedPlayer)
			if selectedPlayer then
				UpdateCamera(selectedPlayer)
			end

			if #Playerlist == 0 then
				notifyIfOpen("No other players to spectate!")
				db = false
				return
			end

			db = false
		end
	end)
