local dss = game:GetService("DataStoreService")
local data = dss:GetDataStore("grosmots")

script.Parent.MouseButton1Click:Connect(function()
	for i,v in pairs(script.Parent.Parent.ScrollingFrame:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end
	
	local grosmots = data:GetAsync("list")
	
	for i, v in pairs(grosmots) do
		local boutton = game.ReplicatedStorage.TadashyConfig.TextButton:Clone()
		boutton.Parent = script.Parent.Parent.ScrollingFrame
		boutton.Text = v
		print(i)
	end
	print("success")
end)