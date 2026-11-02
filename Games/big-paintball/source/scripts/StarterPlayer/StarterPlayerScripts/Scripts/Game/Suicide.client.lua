-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
if not v1.RunService:IsStudio() then
	return;
end;
v1.UserInputService.InputEnded:Connect(function(p1, p2)
	if p2 then
		return;
	end;
	if v1.Variables.Typing then
		return;
	end;
	if p1.KeyCode == Enum.KeyCode.M then
		v1.Player.Get("Humanoid").Health = 0;
		for v2 = 1, 10 do
			v1.UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
			v1.UserInputService.MouseIconEnabled = true;
			v1.GUI.ToggleCursor(true);
			game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic;
			game.Players.LocalPlayer.CameraMaxZoomDistance = 400;
			game.Players.LocalPlayer.CameraMinZoomDistance = 0.5;
			wait();
		end;
	end;
end);
