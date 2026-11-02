local v1 = require(game.ReplicatedStorage.Modules.FadeModule);
repeat wait(); until game.Players.LocalPlayer.Character ~= nil;
repeat wait(); until game.Players.LocalPlayer.Character:WaitForChild("Humanoid") ~= nil;
game.Players.LocalPlayer.Character.Humanoid.Died:connect(function()
	v1.DeathFlash()
end)