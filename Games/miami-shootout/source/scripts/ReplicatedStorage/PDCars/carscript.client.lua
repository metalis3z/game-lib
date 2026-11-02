local availableTools = {"Police Explorer","Police Sedan","Police Impala","Police Fusion","Unmarked Explorer","Unmarked Sedan", "SP Vic", "SP Sedan"}

local add = {
	["Police Explorer"] = "PD, Probationary Officer",
	["Police Sedan"] = "PD, Officer",
	["Police Impala"] = "PD, Officer",
	["Police Fusion"] = "PD, Sergeant",
	["Unmarked Explorer"] = "PD/FBI/DB, Officer",
	["Unmarked Sedan"] = "PD/FBI/DB, Officer",
	["SP Sedan"] = "SP, Trooper",
	["SP Vic"] = "SP, Trooper"
}

script.Parent.Frame.close.MouseButton1Click:Connect(function()
	script.Parent:Destroy()
end)

function refresh()

	local toolsFrame = script.Parent.Frame.Cars.ScrollingFrame
	for i,v in pairs(toolsFrame:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end

	for i,v in pairs(availableTools) do
		--if not game.Players.LocalPlayer.Backpack:FindFirstChild(v) and not game.Players.LocalPlayer.Character:FindFirstChild(v) then
			local button = game.ReplicatedStorage.PDLOCKERBUTTON:Clone()
			button.Name = v 
			button.Text = v.." - "..add[v]
			button.MouseButton1Click:Connect(function()
				game.ReplicatedStorage.Cara:FireServer(v)
				script.Parent:Destroy()
			end)
		button.Parent = toolsFrame
		--end
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
