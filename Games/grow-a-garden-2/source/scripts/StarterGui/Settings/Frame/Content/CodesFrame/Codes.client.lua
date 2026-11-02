--credit to quartz games studio
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local NotificationController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.NotificationController)
local ClaimButton = script.Parent.ClaimButton
local TextBox = script.Parent:WaitForChild("CodeBar"):WaitForChild("TextBox")
local v1 = false

local function submitCode() --[[ submitCode | Line: 9 | Upvalues: v1 (ref), TextBox (copy), NotificationController (copy), ClaimButton (copy), Networking (copy) ]]
	if v1 then
		return
	end

	local v12 = TextBox.Text:match("^%s*(.-)%s*$") or ""

	if v12 == "" then
		NotificationController:CreateNotification("Please enter a code!")

		return
	end

	v1 = true
	ClaimButton.Active = false
	ClaimButton.AutoButtonColor = false

	local ok, result = pcall(function() --[[ Line: 23 | Upvalues: Networking (ref), v12 (copy) ]]
		return Networking.Settings.SubmitCode:Fire(v12)
	end)

	v1 = false
	ClaimButton.Active = true
	ClaimButton.AutoButtonColor = true

	if not ok then
		NotificationController:CreateNotification("Something went wrong, try again.")

		return
	end

	if typeof(result) == "string" then
		NotificationController:CreateNotification(result)

		if result == "Code Successful!" then
			TextBox.Text = ""
		end
	else
		NotificationController:CreateNotification("Unexpected response from server.")
	end
end

ClaimButton.Activated:Connect(submitCode)
TextBox.FocusLost:Connect(function(p1) --[[ Line: 48 | Upvalues: submitCode (copy) ]]
	if not p1 then
		return
	end

	submitCode()
end)