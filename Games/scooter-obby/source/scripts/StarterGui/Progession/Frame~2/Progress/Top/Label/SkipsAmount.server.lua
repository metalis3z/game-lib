local player = game.Players.LocalPlayer
while wait(.334) do
	local skips = game:GetService("ReplicatedStorage").RemoteFunctions.fetchSkips:InvokeServer(player)
	script.Parent.Text = skips
end