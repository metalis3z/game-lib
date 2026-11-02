-- Firebase sez: 404: Not Found (Retrying until success)

while not require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library")).Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
return function(p1, p2, p3)
	p1.Chance.Text = tostring(p3) .. "% chance!";
end;
