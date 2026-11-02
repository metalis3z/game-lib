



script.Parent.Activated:Connect(function()
	local plr = game.Players:FindFirstChild(script.Parent.Parent.Name)
	local val = script.Parent.val
	
	if script.Parent.Cashed.Value == true then return end
	script.Parent.Cashed.Value = true
	plr:FindFirstChild('stored'):FindFirstChild('Money').Value = plr:FindFirstChild('stored'):FindFirstChild('Money').Value + val.Value
	game.ReplicatedStorage.server:FireClient(plr,"money", val.Value, true)
	wait(.1)
	
	
	script.Parent:Destroy()
	
end)


