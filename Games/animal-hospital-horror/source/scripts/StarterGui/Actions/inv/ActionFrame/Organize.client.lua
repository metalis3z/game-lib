for k, v in pairs((game.ReplicatedStorage:WaitForChild("GameData"):WaitForChild("Actions"):WaitForChild("Animations"):GetChildren())) do
	local v2 = script.Parent.Template:Clone()
	local v3 = require(v)

	v2.Parent = script.Parent
	v2.Visible = true
	v2.Name = v.Name
	v2.text.Text = v3.Name
end