do 
	local Surface = script.Elite:Clone();
	Surface.Parent = script.Parent.Parent;
	Surface.Adornee = game.Workspace.Lobby.EliteBoard.Screen;
	
	Surface.Frame.Frame.Buy.MouseButton1Click:connect(function()
		game.ReplicatedStorage.GetElite:FireServer();
	end)
end;


do 
	local Surface = script.Radio:Clone();
	Surface.Parent = script.Parent.Parent;
	pcall(function() Surface.Adornee = game.Workspace.Lobby.RadioBoard.Screen; end);
	
	Surface.Frame.Frame.Buy.MouseButton1Click:connect(function()
		game.ReplicatedStorage.GetRadio:FireServer();
	end)
end;

