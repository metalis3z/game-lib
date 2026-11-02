local Remote = game.ReplicatedStorage;
local EmoteData = Remote.GetSyncData:InvokeServer("Emotes");
local EmoteInventory = _G.PlayerData.Emotes.Owned;


local DefaultEmotes = {
	["Wave"] = 128777973;
	["Point"] = 128853357;
	["Laugh"] = 129423131;
	["Cheer"] = 129423030;
	["Gangnam Style"] = 182435998;
	["The Wave"] = 182436842;
	["Dance"] = 182436935;
};
local EmoteNames = {
	["Gangnam Style"] = "dance1";
	["The Wave"] = "dance2";
	["Dance"] = "dance3";
}

local Emotes = {};

for EmoteID,Data in pairs(EmoteData) do
	if not (Data.Price == "NotForSale") then
		Emotes[EmoteID] = Data.AnimationID;
	end;
end

local EmotesFrame = script.Parent.Parent.Chat.Emotes;

local function UpdateEmoteButtons()
	EmotesFrame:ClearAllChildren();
	
	local i = 0;
	for EmoteName,AnimationID in pairs(DefaultEmotes) do
		local Row = math.floor(i/(1/0.5)); local Column = i%(1/0.5);
		local NewFrame =  script.Emote:Clone();
		NewFrame.Parent = EmotesFrame;
		NewFrame.Position = UDim2.new(NewFrame.Size.X.Scale*Column,0,0,NewFrame.AbsoluteSize.Y*Row);
		NewFrame.Container.ItemName.Text = EmoteName;
		NewFrame.Container.Button.MouseButton1Click:connect(function()
			game.ReplicatedStorage.XboxEmote:Fire("/e " .. (EmoteNames[EmoteName] or string.lower(EmoteName)) );
		end)
		NewFrame.Name = "Slot" .. i;
		i=i+1;
	end
	
	for EmoteName,AnimationID in pairs(Emotes) do
		local Row = math.floor(i/(1/0.5)); local Column = i%(1/0.5);
		local NewFrame =  script.Emote:Clone();
		NewFrame.Parent = EmotesFrame;
		NewFrame.Position = UDim2.new(NewFrame.Size.X.Scale*Column,0,0,NewFrame.AbsoluteSize.Y*Row);
		NewFrame.Container.ItemName.Text = EmoteData[EmoteName].Name;
		local OwnsEmote = false;
		for _,EmoteID in pairs(EmoteInventory) do if EmoteID == EmoteName then OwnsEmote = true; break; end; end;
		NewFrame.Container.ItemName.TextColor3 = (OwnsEmote and Color3.new(1,1,1)) or Color3.new(0.6,0.6,0.6);
		if (not OwnsEmote) then NewFrame.Container.BackgroundColor3 = Color3.new(0.1,0.1,0.1); end;
		NewFrame.Container.Button.MouseButton1Click:connect(function()
			game.ReplicatedStorage.Chatted:FireServer("/e " .. EmoteData[EmoteName].Command);
		end);
		i=i+1;
	end
	
end

UpdateEmoteButtons();




local LocalPlayer = game.Players.LocalPlayer;
repeat wait(); until LocalPlayer.Character ~= nil;

local Tracks = {};
for EmoteName,EmoteTable in pairs(EmoteData) do
	local Animation = Instance.new("Animation",LocalPlayer.Character);
	Animation.AnimationId = "http://www.roblox.com/asset/?id=" .. EmoteTable["AnimationID"];
	Tracks[EmoteName] = LocalPlayer.Character.Humanoid:LoadAnimation(Animation);
end

local LastEmote = 0;
local Emoting = false;

game.ReplicatedStorage.DoEmote.OnClientEvent:connect(function(EmoteName)
	if Tracks[EmoteName] ~= nil then
		Tracks[EmoteName]:Play();
	end;
end)

LocalPlayer.Character.Humanoid.Running:connect(function()
	for _,Emote in pairs(Tracks) do
		Emote:Stop();
	end
end)


