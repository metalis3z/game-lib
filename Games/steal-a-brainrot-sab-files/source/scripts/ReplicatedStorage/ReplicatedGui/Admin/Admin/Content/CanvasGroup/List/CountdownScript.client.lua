local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)

local UpdateCountdownRF = Net:RemoteFunction("UpdateCountdown")

local AdminFrame   = script.Parent.Countdown.Frame
local TitleInput   = AdminFrame.TitleInput
local DurationInput = AdminFrame.DurationInput
local ColorInput   = AdminFrame.ColorInput

local RobuxShopData = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData)
local GAMEPASS_ID   = RobuxShopData.GetId("Cooldown")
local COOLDOWN_TIME = 10
local player        = Players.LocalPlayer
local lastExecution = 0

local COLOR_OPTIONS = {
	["Red"]         = { DisplayName = "Red",         Color = Color3.fromRGB(255, 0,   0),   hex = "#ff0000" },
	["Blue"]        = { DisplayName = "Blue",         Color = Color3.fromRGB(0,   0,   255), hex = "#0000ff" },
	["Green"]       = { DisplayName = "Green",        Color = Color3.fromRGB(0,   255, 0),   hex = "#00ff00" },
	["Yellow"]      = { DisplayName = "Yellow",       Color = Color3.fromRGB(255, 255, 0),   hex = "#ffff00" },
	["Orange"]      = { DisplayName = "Orange",       Color = Color3.fromRGB(255, 170, 0),   hex = "#ffaa00" },
	["Purple"]      = { DisplayName = "Purple",       Color = Color3.fromRGB(170, 0,   255), hex = "#aa00ff" },
	["White"]       = { DisplayName = "White",        Color = Color3.fromRGB(255, 255, 255), hex = "#ffffff" },
	["Black"]       = { DisplayName = "Black",        Color = Color3.fromRGB(26,  26,  26),  hex = "#1a1a1a" },
	["Pink"]        = { DisplayName = "Pink",         Color = Color3.fromRGB(255, 0,   255), hex = "#ff00ff" },
	["Dark Red"]    = { DisplayName = "Dark Red",     Color = Color3.fromRGB(139, 0,   0),   hex = "#8b0000" },
	["Dark Blue"]   = { DisplayName = "Dark Blue",    Color = Color3.fromRGB(0,   0,   139), hex = "#00008b" },
	["Dark Green"]  = { DisplayName = "Dark Green",   Color = Color3.fromRGB(0,   100, 0),   hex = "#006400" },
	["Light Blue"]  = { DisplayName = "Light Blue",   Color = Color3.fromRGB(173, 216, 230), hex = "#add8e6" },
	["Light Green"] = { DisplayName = "Light Green",  Color = Color3.fromRGB(144, 238, 144), hex = "#90ee90" },
	["Gray"]        = { DisplayName = "Gray",         Color = Color3.fromRGB(128, 128, 128), hex = "#808080" },
	["Dark Gray"]   = { DisplayName = "Dark Gray",    Color = Color3.fromRGB(169, 169, 169), hex = "#a9a9a9" },
	["Gold"]        = { DisplayName = "Gold",         Color = Color3.fromRGB(255, 215, 0),   hex = "#ffd700" },
	["Silver"]      = { DisplayName = "Silver",       Color = Color3.fromRGB(192, 192, 192), hex = "#c0c0c0" },
	["Cyan"]        = { DisplayName = "Cyan",         Color = Color3.fromRGB(0,   255, 255), hex = "#00ffff" },
	["Magenta"]     = { DisplayName = "Magenta",      Color = Color3.fromRGB(255, 0,   255), hex = "#ff00ff" },
	["Crimson"]     = { DisplayName = "Crimson",      Color = Color3.fromRGB(220, 20,  60),  hex = "#dc143c" },
	["Aqua"]        = { DisplayName = "Aqua",         Color = Color3.fromRGB(0,   255, 255), hex = "#00ffff" },
	["Teal"]        = { DisplayName = "Teal",         Color = Color3.fromRGB(0,   128, 128), hex = "#008080" },
	["Maroon"]      = { DisplayName = "Maroon",       Color = Color3.fromRGB(128, 0,   0),   hex = "#800000" },
	["Navy"]        = { DisplayName = "Navy",         Color = Color3.fromRGB(0,   0,   128), hex = "#000080" },
	["Olive"]       = { DisplayName = "Olive",        Color = Color3.fromRGB(128, 128, 0),   hex = "#808000" },
	["Neon Pink"]   = { DisplayName = "Neon Pink",    Color = Color3.fromRGB(255, 110, 199), hex = "#ff6ec7" },
	["Neon Blue"]   = { DisplayName = "Neon Blue",    Color = Color3.fromRGB(31,  81,  255), hex = "#1f51ff" },
	["Neon Green"]  = { DisplayName = "Neon Green",   Color = Color3.fromRGB(57,  255, 20),  hex = "#39ff14" },
	["Cyberpunk"]   = { DisplayName = "Cyberpunk",    Color = Color3.fromRGB(252, 238, 10),  hex = "#fcee0a" },
	["Midnight"]    = { DisplayName = "Midnight",     Color = Color3.fromRGB(25,  25,  112), hex = "#191970" },
	["Mint"]        = { DisplayName = "Mint",         Color = Color3.fromRGB(152, 255, 152), hex = "#98ff98" },
	["Lavender"]    = { DisplayName = "Lavender",     Color = Color3.fromRGB(230, 230, 250), hex = "#e6e6fa" },
	["Brown"]       = { DisplayName = "Brown",        Color = Color3.fromRGB(139, 69,  19),  hex = "#8b4513" },
	["Salmon"]      = { DisplayName = "Salmon",       Color = Color3.fromRGB(250, 128, 114), hex = "#fa8072" },
	["Tan"]         = { DisplayName = "Tan",          Color = Color3.fromRGB(210, 180, 140), hex = "#d2b48c" },
	["Violet"]      = { DisplayName = "Violet",       Color = Color3.fromRGB(238, 130, 238), hex = "#ee82ee" },
	["Indigo"]      = { DisplayName = "Indigo",       Color = Color3.fromRGB(75,  0,   130), hex = "#4b0082" },
}

local selectedHex = "#ffff00"


local function checkGamepassOwnership()
	local success, ownsPass = pcall(function()
		return RobuxShopData.OwnsGamepass(player, "Cooldown")
	end)
	return success and ownsPass
end


AdminFrame.Color.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(COLOR_OPTIONS, function(selected)
		local entry = type(selected) == "table" and selected
			or COLOR_OPTIONS[selected]

		if not entry then return end

		selectedHex      = entry.hex
		ColorInput.Text  = entry.DisplayName
	end)
end)


local function doServerSpawn()
	local currentTime   = os.clock()
	local ownsGamepass  = checkGamepassOwnership()
	local isPrivateServer = false

	if not isPrivateServer and not ownsGamepass then
		local timePassed = currentTime - lastExecution
		if timePassed < COOLDOWN_TIME then
			local timeLeft = math.ceil(COOLDOWN_TIME - timePassed)
			NotificationController:Error("Wait " .. timeLeft .. "s or buy the Admin Pass to skip!")
			MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
			return
		end
	end

	local titleText = TitleInput.Text
	if titleText == "" or titleText == "Label" then
		NotificationController:Error("Please enter an event title!")
		return
	end

	local rawDuration = tonumber(DurationInput.Text)
	if not rawDuration or rawDuration <= 0 then
		NotificationController:Error("Enter a valid duration in seconds!")
		return
	end

	local targetTimestamp = workspace:GetServerTimeNow() + rawDuration

	local countdownConfig = {
		timestamp = targetTimestamp,
		title     = titleText,
		color     = selectedHex,
	}

	local success, message = UpdateCountdownRF:InvokeServer("Update", countdownConfig)

	if success then
		lastExecution = currentTime
		NotificationController:Notify("Countdown Started!", 5, "Sounds.Sfx.Success")
	else
		NotificationController:Error(message or "Failed to start countdown.")
	end
end


local SubmitButton = AnimatedButton.new(AdminFrame.StartButton)
SubmitButton:Animate()
SubmitButton.OnActivated:Connect(doServerSpawn)

local Synchronizer   = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)
kb:RegisterButton(script.Name .. "_ServerStart", AdminFrame.StartButton, doServerSpawn)
kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()