

local v1 = script.Surface:Clone();
v1.Parent = script.Parent.Parent;
pcall(function()
	v1.Adornee = game.Workspace.Lobby.RadioBoard.Screen;
end);
v1.Frame.Frame.Buy.MouseButton1Click:connect(function()
	game.ReplicatedStorage.GetRadio:FireServer();
end);
