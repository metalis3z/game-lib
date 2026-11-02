local plrs = {}
local Player = game.Players.LocalPlayer
local hiding = false
script.Parent.MouseButton1Click:Connect(function()
	if not hiding then
		hiding = true
		script.Parent.Text = "On"
		local player = game.Players:GetChildren()
		for i = 1,#player do
			if player[i].Name ~= Player.Name then
				table.insert(plrs,workspace[player[i].Name])
			end
		end
		for i = 1,#plrs do
			plrs[i].Parent = nil
		end
	elseif hiding then
		hiding = false
		script.Parent.Text = "Off"
		for i = 1,#plrs do
			plrs[i].Parent = workspace
		end
		plrs = {}
	end
end)