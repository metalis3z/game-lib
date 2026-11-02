--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Remotes = require(ReplicatedStorage.Shared.Remotes)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 15)

local function findDescendant(parent: Instance, names: {string}): Instance?
	local current = parent
	for _, name in ipairs(names) do
		current = current:WaitForChild(name, 15)
		if not current then return nil end
	end
	return current
end

local codesGui = playerGui:WaitForChild("CodesGui", 15)
if not codesGui then
	warn("[CodesController] CodesGui not found in PlayerGui")
	return
end

local codesBTN = findDescendant(playerGui, {"HUD", "GameHUD", "LeftControls", "CodesBTN"})
if not codesBTN then
	warn("[CodesController] CodesBTN not found")
	return
end

local frame = codesGui:WaitForChild("Frame", 15)
if not frame then
	warn("[CodesController] Frame not found in CodesGui")
	return
end

local codesbar = frame:WaitForChild("codesbar", 15)
local redeemBTN = frame:WaitForChild("redeemBTN", 15)
local closeBTN = frame:WaitForChild("CloseBTN", 15)
local xdLabel = frame:WaitForChild("xd", 15)

if not codesbar or not redeemBTN or not closeBTN then
	warn("[CodesController] Missing codesbar/redeemBTN/closeBTN")
	return
end

print("[CodesController] All UI references found, connecting events")

codesGui.Enabled = true
frame.Visible = false

local originalXdText = xdLabel and xdLabel.Text or ""
local resetTimer: number? = nil

local function showFeedback(message: string)
	if not xdLabel then return end
	xdLabel.Text = message
	if resetTimer then
		task.cancel(resetTimer)
	end
	resetTimer = task.delay(5, function()
		xdLabel.Text = originalXdText
		resetTimer = nil
	end)
end

codesBTN.Activated:Connect(function()
	frame.Visible = not frame.Visible
	print("[CodesController] CodesBTN clicked, frame.Visible =", frame.Visible)
end)

closeBTN.Activated:Connect(function()
	frame.Visible = false
end)

redeemBTN.Activated:Connect(function()
	local code = codesbar.Text
	if code == "" then
		showFeedback("Please enter a code.")
		return
	end
	Remotes.Codes.AskRedeem:FireServer(code)
end)

Remotes.Codes.Verdict.OnClientEvent:Connect(function(success: boolean, message: string)
	print("[CodesController] Verdict received:", success, message)
	showFeedback(message)
	if success then
		codesbar.Text = ""
	end
end)