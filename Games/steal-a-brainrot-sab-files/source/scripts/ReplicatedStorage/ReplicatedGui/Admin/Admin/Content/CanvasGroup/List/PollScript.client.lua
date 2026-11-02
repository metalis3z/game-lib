
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local Players            = game:GetService("Players")

local AnimatedButton         = require(ReplicatedStorage.Classes.AnimatedButton)
local Net                    = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local Synchronizer           = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager         = require(ReplicatedStorage.Modules.KeybindManager)

local CreatePollRemote = Net:RemoteFunction("AdminService/CreatePoll")
local SaveKeyRemote    = Net:RemoteEvent("AdminService/SaveKey")

local LocalPlayer   = Players.LocalPlayer
local PollFrame     = script.Parent.Poll.Frame
local InputQuestion = PollFrame.mainQuestion
local InputOption1  = PollFrame.mainOption1
local InputOption2  = PollFrame.mainOption2
local InputDuration = PollFrame.mainDuration
local InputColor1   = PollFrame.MainColor1
local InputColor2   = PollFrame.MainColor2

local InputFakeVotes1, InputFakeVotes2
for _, child in ipairs(PollFrame:GetChildren()) do
	if child:IsA("TextBox") then
		if child.Name == "Fake votes 1" then
			InputFakeVotes1 = child
		elseif child.Name == "Fake votes 2" then
			InputFakeVotes2 = child
		end
	end
end

local RobuxShopData = require(game:GetService("ReplicatedStorage").Datas.RobuxShopData)
local GAMEPASS_ID    = RobuxShopData.GetId("Cooldown")
local COOLDOWN_TIME  = 10
local MAX_DURATION   = 3600
local MAX_FAKE_VOTES = 999999999999

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
local selectedColor1Hex = "00ff00"
local selectedColor2Hex = "ff0000"


local function ownsGamepass()
	local ok, result = pcall(function()
		return RobuxShopData.OwnsGamepass(LocalPlayer, "Cooldown")
	end)
	return ok and result
end

local function isPrivateServer()
	return false
end

local function readInt(textbox, default, min, max)
	local val = tonumber(textbox and textbox.Text) or default
	return math.clamp(val, min, max)
end

local PlayerData = Synchronizer:Wait(LocalPlayer)
assert(PlayerData, "PlayerData failed to load")


PollFrame.Color1.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(COLOR_OPTIONS, function(selected)
		local entry = type(selected) == "table" and selected
			or COLOR_OPTIONS[selected]

		if not entry then return end

		selectedColor1Hex  = entry.hex
		InputColor1.Text   = entry.DisplayName
	end)
end)

PollFrame.Color2.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(COLOR_OPTIONS, function(selected)
		local entry = type(selected) == "table" and selected
			or COLOR_OPTIONS[selected]

		if not entry then return end

		selectedColor2Hex  = entry.hex
		InputColor2.Text   = entry.DisplayName
	end)
end)


local function PerformCreatePoll()
	local now = os.clock()

	if not isPrivateServer() and not ownsGamepass() then
		local elapsed = now - lastExecution
		if elapsed < COOLDOWN_TIME then
			local remaining = math.ceil(COOLDOWN_TIME - elapsed)
			NotificationController:Error("Cooldown! Wait " .. remaining .. "s.")
			MarketplaceService:PromptGamePassPurchase(LocalPlayer, GAMEPASS_ID)
			return
		end
	end

	local question = InputQuestion.Text
	if question == "" or question == "Label" then
		NotificationController:Error("You must enter a question!")
		return
	end

	local opt1 = InputOption1.Text ~= "" and InputOption1.Text or "Yes"
	local opt2 = InputOption2.Text ~= "" and InputOption2.Text or "No"

	local duration   = readInt(InputDuration,   30, 5, MAX_DURATION)
	local fakeVotes1 = readInt(InputFakeVotes1,  0, 0, MAX_FAKE_VOTES)
	local fakeVotes2 = readInt(InputFakeVotes2,  0, 0, MAX_FAKE_VOTES)

	local pollConfig = {
		text            = question,
		option1         = opt1,
		option2         = opt2,
		option1colorHex = selectedColor1Hex,
		option2colorHex = selectedColor2Hex,
		duration        = duration,
		allowSwitch     = true,
		startVotesA     = fakeVotes1,
		startVotesB     = fakeVotes2,
	}

	local success, message = CreatePollRemote:InvokeServer(pollConfig)

	if success then
		lastExecution = now
		NotificationController:Notify("Poll broadcasted!", 5, "Sounds.Sfx.Success")
	else
		NotificationController:Error(message or "Failed to start poll.")
	end
end


local SubmitBtn = AnimatedButton.new(PollFrame.Spawn)
SubmitBtn:Animate()
SubmitBtn.OnActivated:Connect(PerformCreatePoll)

local kb = KeybindManager.new(SaveKeyRemote, PlayerData)
kb:RegisterButton(script.Name .. "_SubmitButton", PollFrame.Spawn, PerformCreatePoll)
kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()