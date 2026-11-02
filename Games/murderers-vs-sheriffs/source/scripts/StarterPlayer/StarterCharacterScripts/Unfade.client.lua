local v0 = require(game.ReplicatedStorage.Modules.FadeModule);
local v1 = false;
spawn(function()
	while true do
		wait();
		if not (v1 ~= true) then
			break;
		end;
	end;
	wait(1);
	_G.ShowResults();
end);
v0.SpawnFade();
v1 = true;