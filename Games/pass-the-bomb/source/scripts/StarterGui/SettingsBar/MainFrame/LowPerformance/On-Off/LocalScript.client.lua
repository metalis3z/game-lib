local things = {}
local button = script.Parent
script.Parent.Activated:Connect(function()
	if script.Parent.Text == "Off" then
		script.Parent.Text = "On"
		for i, child in pairs(workspace:GetDescendants()) do
			if child:IsA("BasePart") then
				--task.wait()
				child.CastShadow = false
				things[child.Name] = child.Material.Name
				child.Material = Enum.Material.Plastic
			end
		end
		game.Lighting.Bloom.Enabled = false
		game.Lighting.ColorCorrection.Enabled = false
		game.Lighting.SunRays.Enabled = false
	else
		script.Parent.Text = "Off"
		for i, child in pairs(workspace:GetDescendants()) do
			if child:IsA("BasePart") then
				--task.wait()
				child.CastShadow = true
				child.Material = Enum.Material[things[child.Name]]
			end
		end
		game.Lighting.Bloom.Enabled = true
		game.Lighting.ColorCorrection.Enabled = true
		game.Lighting.SunRays.Enabled = true
	end
end)