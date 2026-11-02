
local MainGUI = script.Parent.Game;
local MuteButton = MainGUI.Settings.Mute;

if _G.Mute == nil then
	_G.Mute = false;
end


local function RadioMute()
	for _,Model in pairs(game.Workspace:GetChildren()) do
		if Model:FindFirstChild("Radio") and Model.Radio:FindFirstChild("Sound") then
			Model.Radio.Sound.Volume = (_G.Mute == true and 0) or 0.5;
		end
	end
end


game.ReplicatedStorage.PlaySong.OnClientEvent:connect(function(Sound,SongID,Play)
	if Sound.SoundId == SongID and Sound.IsPlaying then Sound:Stop(); return end;
	Sound:Stop();
	Sound.SoundId = SongID;
	Sound:Play();
	RadioMute();
end)


script.Parent.ChildAdded:connect(function(Child)
	wait();
	if Child:IsA("Sound") then
		if _G.Mute == true then
			Child.Volume = 0;
		end
	end
end)

local MutedImage = "https://www.roblox.com/asset/?id=334560517";
local SoundImage = "https://www.roblox.com/asset/?id=334560485";

if _G.Mute == true then 
	MuteButton.Icon.Image = MutedImage;
else
	MuteButton.Icon.Image = SoundImage;
end

RadioMute();

MuteButton.MouseButton1Click:connect(function()
	if _G.Mute == false then 
		MuteButton.Icon.Image = MutedImage;
		_G.Mute = true;
	else
		_G.Mute = false;
		MuteButton.Icon.Image = SoundImage;
	end
	
	for _,Music in pairs(script.Parent:GetChildren()) do
		if Music:IsA("Sound") and _G.Mute then
			Music:Stop();
		end
	end	
	RadioMute();
end)

wait(0.1);
for _,Music in pairs(script.Parent:GetChildren()) do
	if Music:IsA("Sound") and _G.Mute then
		Music:Stop();
	end
end	
