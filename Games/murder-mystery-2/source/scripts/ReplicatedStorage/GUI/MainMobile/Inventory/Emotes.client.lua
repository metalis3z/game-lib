local Remote = game.ReplicatedStorage;
local EmoteData = Remote.GetSyncData:InvokeServer("Emotes");
local nonstopabble = false

local LocalPlayer = game.Players.LocalPlayer;
repeat wait(); until LocalPlayer.Character ~= nil;

local Tracks = {};
for EmoteName,EmoteTable in pairs(EmoteData) do
	local Animation = Instance.new("Animation",LocalPlayer.Character);
	Animation.AnimationId = "http://www.roblox.com/asset/?id=" .. EmoteTable["AnimationID"];
	Tracks[EmoteName] = LocalPlayer.Character.Humanoid:LoadAnimation(Animation);
end

game.ReplicatedStorage.DoEmote.OnClientEvent:connect(function(EmoteName)
	if Tracks[EmoteName] ~= nil then
		Tracks[EmoteName]:Play();
		nonstopabble = true
		wait(0.15)
		nonstopabble = false
	end;
end)

LocalPlayer.Character.Humanoid.Running:connect(function()
	--local mv = _G.pMoveValue;

	-- if math.abs(mv.X) > 0 or  math.abs(mv.Y) > 0 or  math.abs(mv.Z) > 0 then
	if not nonstopabble then
		for _,Emote in pairs(Tracks) do
			Emote:Stop();
		end
	end;
end)