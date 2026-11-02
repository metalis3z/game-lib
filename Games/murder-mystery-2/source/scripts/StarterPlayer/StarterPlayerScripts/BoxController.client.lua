
local u3 = require(game.ReplicatedStorage.Modules.BoxModule);
game.ReplicatedStorage.Remotes.Shop.BoxController.Event:connect(function(p1, p2)
	_G.Unboxing = true;
	u3.OpenBox(p1, p2);
	_G.NewItem(p2, "You Unboxed...",nil, "Weapons");
	_G.Unboxing = false;
	game.ReplicatedStorage.CrateComplete:FireServer(p2);
end);
