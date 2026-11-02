pcall(function()
	while true do
		wait(1);
		if game.Players.LocalPlayer.Character then
			break;
		end;	
	end;
end);
wait(2);
script.Parent.Enabled = false;
