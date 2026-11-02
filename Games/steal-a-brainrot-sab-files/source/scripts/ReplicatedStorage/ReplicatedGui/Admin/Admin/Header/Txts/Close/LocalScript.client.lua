local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local IsAdmin = require(ReplicatedStorage.Shared.IsAdmin)
local AdminScript = script.Admin

local localPlayer = Players.LocalPlayer
local isAdmin = IsAdmin(localPlayer.UserId)

local AdminInterface = InterfaceController:Register("Admin", script.Parent.Parent.Parent.Parent, "TopQuint")
AdminInterface:AttachCloseButton(script.Parent)
AdminInterface:Close()

if isAdmin then
	AdminScript.Parent = script.Parent.Parent.Parent.Parent.Parent.Parent.LeftCenter.LeftCenter.Buttons
else
	-- Hide the admin button and disable the entire Admin ScreenGui for non-admins
	AdminScript.Visible = false
	local screenGui = script:FindFirstAncestorOfClass("ScreenGui")
	if screenGui then
		screenGui.Enabled = false
	end
end

local GradientScroll = require(script.Parent.Parent.Parent.Parent.Content.CanvasGroup.List.GradientScroll)
GradientScroll(script.Parent.Parent.Parent.Parent.Main.UIGradient, 3)
if AdminScript:FindFirstChild("UIGradient") then
	GradientScroll(AdminScript.UIGradient, 3)
end

if isAdmin then
	local AdminButtonAnimation = AnimatedButton.new(AdminScript)
	AdminButtonAnimation:Animate()

	AdminButtonAnimation.OnActivated:Connect(function()
		InterfaceController:Toggle("Admin", true)
	end)

	local AdminCommand = TextChatService:WaitForChild("Modded"):WaitForChild("Admin")
	local commandConn

	local function onCommandTriggered()
		if script:IsDescendantOf(game) then
			AdminScript.Visible = not AdminScript.Visible
		else
			if commandConn then
				commandConn:Disconnect()
				commandConn = nil
			end
		end
	end

	commandConn = AdminCommand.Triggered:Connect(onCommandTriggered)

	script.Destroying:Connect(function()
		if commandConn then
			commandConn:Disconnect()
			commandConn = nil
		end
	end)
end