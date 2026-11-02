local prompt = script.Parent:FindFirstChild("AdminGamepassPrompt")
if prompt then
	prompt:Destroy()
end

-- Purchase is handled by StarterPlayerScripts.AdminBoardPurchaseClient so the board button owns the interaction.
