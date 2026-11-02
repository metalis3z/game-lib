--credit to leon games studio
script.Parent.Activated:Connect(function() --[[ Line: 1 ]]
	game.Players.LocalPlayer:SetAttribute("DebugRays", not game.Players.LocalPlayer:GetAttribute("DebugRays"))

	local TextLabel = script.Parent:FindFirstChild("Text").TextLabel

	TextLabel.Text = ("Debug Rays (%*)"):format(if game.Players.LocalPlayer:GetAttribute("DebugRays") then "On" else "Off"):upper()

	local TextLabel2 = script.Parent:FindFirstChild("Text").TextLabel.TextLabel

	TextLabel2.Text = ("Debug Rays (%*)"):format(if game.Players.LocalPlayer:GetAttribute("DebugRays") then "On" else "Off"):upper()
end)