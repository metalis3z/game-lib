game.Players.PlayerAdded:Connect(function(plr)
	local template = script.Parent.Parent.Parent.Parent.Template.player
	local newbttn = template:Clone()
	newbttn.Name = plr.Name
	newbttn.Text = plr.Name
	newbttn.Parent = script.Parent
	newbttn.Visible = true
end)

game.Players.PlayerRemoving:Connect(function(plr)
	script.Parent:FindFirstChild(plr.Name):Destroy()
end)

function destroy()
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:IsA("TextButton") then
			destroy()
		end
	end
end

wait(2)
destroy()
for i,v in pairs(game.Players:GetChildren()) do
	local cl = script.Parent.Parent.Parent.Parent.Template.player:Clone()
	cl.Name = v.Name
	cl.Text = v.Name
	cl.Parent = script.Parent
	cl.Visible = true
end