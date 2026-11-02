local Emotes = game.ReplicatedStorage.GetSyncData:InvokeServer("Emotes");
local LocalPlayer = game.Players.LocalPlayer;
repeat wait(); until LocalPlayer.Character ~= nil;

local Tracks = {};
for EmoteName,EmoteTable in pairs(Emotes) do
	local Animation = Instance.new("Animation",LocalPlayer.Character);
	Animation.AnimationId = "http://www.roblox.com/asset/?id=" .. EmoteTable["AnimationID"];
	Tracks[EmoteName] = LocalPlayer.Character.Humanoid:LoadAnimation(Animation);
end

local Keys = {
	Enum.KeyCode.W;
	--Enum.KeyCode.Space;
	Enum.KeyCode.A;
	Enum.KeyCode.S;
	Enum.KeyCode.D;
	Enum.KeyCode.Left;
	Enum.KeyCode.Right;
	Enum.KeyCode.Up;
	Enum.KeyCode.Down;
}


local LastEmote = 0;
local Emoting = false;

game.ReplicatedStorage.DoEmote.OnClientEvent:connect(function(EmoteName)
	if Tracks[EmoteName] ~= nil and (time()-LastEmote>1) then
		Emoting = true;
		_G.CanJump = false;
		LocalPlayer.Character.HumanoidRootPart.Anchored = true;
		Tracks[EmoteName]:Play();
		print("Playing " .. EmoteName);
	end;
end)


game:GetService("UserInputService").InputBegan:connect(function(Input)
	local Key = Input.KeyCode;
	for _,BadKey in pairs(Keys) do
		if Key == BadKey then
			for _,Emote in pairs(Tracks) do
				if Emote.IsPlaying then
					LastEmote = time();
					Emoting = false;
					Emote:Stop();
					LocalPlayer.Character.HumanoidRootPart.Anchored = false;
				end;
			end
		end;
	end
end)

game:GetService("RunService"):BindToRenderStep("NoEmote",0,function()
	local Pressed = game:GetService("UserInputService"):GetKeysPressed();
	for _,Key in pairs(Pressed) do
		for _,BadKey in pairs(Keys) do
			if Key.KeyCode == BadKey then
				for _,Emote in pairs(Tracks) do
					if Emote.IsPlaying then
						LastEmote = time();
						Emoting = false;
						Emote:Stop();
						LocalPlayer.Character.HumanoidRootPart.Anchored = false;
					end;
				end
			end;
		end
	end
	if time()-LastEmote > 0.3 and not Emoting then
		_G.CanJump = true;
	end
end);

