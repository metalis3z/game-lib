local Module = {};
local LocalPlayer = game.Players.LocalPlayer;
Module.FriendsOnline = {};
Module.GetFriendsOnline = function(_)
	if os.clock() - -10 >= 10 and LocalPlayer.UserId > 0 then
        pcall(function()
			Module.FriendsOnline = LocalPlayer:GetFriendsOnline();
        end);
    end;
	return Module.FriendsOnline;
end;
return Module;