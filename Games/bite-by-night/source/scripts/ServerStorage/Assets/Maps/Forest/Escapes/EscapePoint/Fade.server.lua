
game:GetService("RunService").RenderStepped:Connect(function()
	if game:GetService("Players").LocalPlayer:GetAttribute("Team") == "Lobby" then return end

	if script.Parent.Highlight.Enabled == true and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		script.Parent.Attachment.BillboardGui.Enabled = true
		local PlrMagnitude = (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - script.Parent.Position).Magnitude
		local Transparency = math.clamp((PlrMagnitude - 50) / (0 - PlrMagnitude), 0, 1)
		script.Parent.Highlight.OutlineTransparency = Transparency * 2
		script.Parent.Highlight.FillTransparency = Transparency + 0.5
	end
end)