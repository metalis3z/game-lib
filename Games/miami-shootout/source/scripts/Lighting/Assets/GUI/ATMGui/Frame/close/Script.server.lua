script.Parent.OnServerEvent:Connect(function(p)
	print(script.Parent.Parent.Parent.Parent.Parent.Name)
	if p.Name == script.Parent.Parent.Parent.Parent.Parent.Name then
		script.Parent.Parent:Destroy()
	end
end)