script.Parent.RemoteEvent.OnServerEvent:Connect(function(p,target)
	if p.Name ~= script.Parent.Parent.Name then
		return print("ownership denied")
	end
	
	local name = "ninesix_docile"
	
	if p.Character.PrimaryPart:FindFirstChild(name) then
		p.Character.PrimaryPart:FindFirstChild(name):Destroy()
	else
		local sound = script.Parent:FindFirstChild(name)
		local lol = sound:Clone() lol.Parent = p.Character.PrimaryPart
		lol:Play()
	end
	
end)