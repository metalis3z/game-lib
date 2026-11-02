local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")

local Synchronizer   = require(ReplicatedStorage.Packages.Synchronizer)
local Net            = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)

local PlayerMorphRemote = Net:RemoteEvent("AdminService/PlayerMorph")
local SaveKeyRemote     = Net:RemoteEvent("AdminService/SaveKey")

local MorphFrame   = script.Parent.PlrMorph.Frame
local InputName    = MorphFrame.mainName
local InputMutation= MorphFrame.mainMutation
local InputBase    = MorphFrame.mainBase
local InputHead    = MorphFrame.mainHead
local InputVerify  = MorphFrame.mainVerify
local NotificationController = require(game.ReplicatedStorage.Controllers.NotificationController)
local PlayerData = Synchronizer:Wait(Players.LocalPlayer)
assert(PlayerData)

local function PerformPlayerMorph()
	local ok, err = pcall(function()
		PlayerMorphRemote:FireServer(
			InputName.Text,
			InputMutation.Text,
			InputBase.Text,
			InputHead.Text,
			InputVerify.Text
		)
	end)
	if not ok then
		NotificationController:Error(tostring(err))
	end
end

local MorphBtn = AnimatedButton.new(MorphFrame.Morph)
MorphBtn:Animate()
MorphBtn.OnActivated:Connect(PerformPlayerMorph)

local VerifyOptions = {
	["Yes"] = {
		["Color"]       = Color3.fromRGB(85, 170, 0),
		["DisplayName"] = "Yes",
	},
	["No"] = {
		["Color"]       = Color3.fromRGB(255, 0, 0),
		["DisplayName"] = "No",
	},
}

MorphFrame.verifytext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(VerifyOptions, function(SelectedValue)
		InputVerify.Text = SelectedValue
	end)
end)


local kb = KeybindManager.new(SaveKeyRemote, PlayerData)
kb:RegisterButton(script.Name .. "_MorphButton", MorphFrame.Morph, PerformPlayerMorph)
kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()