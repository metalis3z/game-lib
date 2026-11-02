
local v1 = game.ReplicatedStorage:WaitForChild("GameData"):WaitForChild("Anomalies"):GetChildren()
local t = { game.CreatorId, 10442464072 }

for k, v in pairs(v1) do
	local v2 = script.Parent.Template:Clone()
	local v3 = game.ReplicatedStorage.NPCs.Anomalies1:FindFirstChild(v.Name):Clone()
	local v4 = require(v)
	local v5 = CFrame.new(-70.5820541, 2.07803416, -318.024048, -1, 0, -8.74227766e-8, 0, 1, 0, 8.74227766e-8, 0, -1)

	v2.Name = v.Name
	v2.text.Text = v4.Name
	v3.Parent = v2.ViewportFrame.WorldModel
	v3.HumanoidRootPart.Anchored = true
	v3:PivotTo(v5)
	v2.Visible = true
	v2.Parent = script.Parent

	if v4.Dev and not table.find(t, game.Players.LocalPlayer.UserId) then
		v2:Destroy()
	end
end