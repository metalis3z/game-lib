local availableTools = {"Glock19","Five-Seven","Handcuffs","Taser","Baton","Remington","M4A1","RiotShield","BatteringRam","Ammo Box","PepperSpray","Donut","Flash","Smoke"}
--PDG2C REMOVED

script.Parent.Frame.close.MouseButton1Click:Connect(function()
	script.Parent:Destroy()
end)

function refresh()

	local toolsFrame = script.Parent.Frame.Tools.ScrollingFrame
	for i,v in pairs(toolsFrame:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end

	for i,v in pairs(availableTools) do
		if not game.Players.LocalPlayer.Backpack:FindFirstChild(v) and not game.Players.LocalPlayer.Character:FindFirstChild(v) then
			local button = game.ReplicatedStorage.PDLOCKERBUTTON:Clone()
			button.Name = v 
			button.Text = v 
			button.MouseButton1Click:Connect(function()
				game.ReplicatedStorage.Locka:FireServer(v)
			end)
			button.Parent = toolsFrame
		end
	end

end

local interval = 2.5

game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function()
	refresh()
end)

game.Players.LocalPlayer.Backpack.ChildRemoved:Connect(function()
	refresh()
end)

refresh()
while wait(interval) do
	refresh()
end
