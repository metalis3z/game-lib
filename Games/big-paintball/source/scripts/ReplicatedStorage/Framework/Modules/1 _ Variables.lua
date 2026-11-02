-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
v1.MinSentrySpawnPlace = 75;
v1.CurMap = "Bridge 2019";
if not game:GetService("RunService"):IsServer() then
	v1.Killstreak = 0;
	v1.HideGun = false;
	v1.ControllerMoveVector = Vector3.new(0, 0, 0);
	v1.ScopeUIToHide = { "Killfeed", "Killstreaks", "Top", "Side", "Challenges", "SkillLeaderboard" };
	v1.ScopeUICache = {};
	v1.Desktop = false;
	v1.Mobile = false;
	v1.Console = false;
	v1.VR = false;
	v1.Chatting = false;
	v1.Typing = false;
	v1.Orientation = nil;
	v1.Portrait = false;
	v1.Landscape = true;
	v1.Resolution = Vector2.new(1920, 1080);
	v1.ResolutionScale = 1;
else
	v1.Rounds = {
		MapThingsCache = {}, 
		VotingMaps = {}, 
		PlayerRoundStats = {}
	};
end;
return v1;
