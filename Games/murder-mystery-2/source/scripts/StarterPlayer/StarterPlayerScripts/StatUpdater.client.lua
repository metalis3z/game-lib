local function GetGifts()
	local Inventory = _G.PlayerData.Weapons.Owned;
	for ItemName,ItemAmount in pairs(Inventory) do
		if ItemName == "Gift" then
			_G.Gifts = ItemAmount;
			return;
		end
	end
end

_G.Gifts = 0;

_G.OfferEndTime = 1471244400;
_G.EventEndTime = 1641808800;
_G.LeaderboardEndTime = 1682812800;
local TotalSecondsLeft = _G.OfferEndTime-os.time();
local ToyData = {}
_G.ShowItemPack = false;
_G.Unboxing = false;
_G.CoinBagFull = false;
_G.InRound = false;
_G.CanJump = true;


repeat 
	_G.PlayerData = game.ReplicatedStorage.GetData2:InvokeServer();
	wait(0.1);
until _G.PlayerData ~= nil;

local function CombindToys()
	GetGifts()
	for _, Item in pairs(_G.PlayerData.Toys.Owned) do
		if ToyData[Item] == nil then
			table.insert(_G.PlayerData.Emotes.Owned, Item)
			ToyData[Item] = true
		end
	end
end

local function UpdateData()
	GetGifts();
	CombindToys();
end

game.ReplicatedStorage.UpdateData2.OnClientEvent:connect(function(Data,CoinUpdate)
	_G.PlayerData = Data;
	UpdateData();
	CombindToys();
	game.ReplicatedStorage.UpdateDataClient:Fire(CoinUpdate);
end)
game.ReplicatedStorage.UpdateDataClient.Event:connect(UpdateData)



game.ReplicatedStorage.UpdateData3.OnClientEvent:connect(function(Data)
	_G.PlayerData = Data;
	CombindToys();
end)

function _G.UpdateEmotes()
	CombindToys();
end;

_G.Windows = {};
_G.Windows.Frames = {};
_G.Windows.FrameNames = {};
_G.Windows.ViewFrame = function(currentFrame, currentFrame2)
	for frame, frame2 in pairs(_G.Windows.Frames) do
		if frame ~= nil then
			if frame == currentFrame then
				if currentFrame2 ~= nil then
					frame.Visible = currentFrame2;
				else
					frame.Visible = not frame.Visible;
				end;
			else
				frame.Visible = false;
			end;
		end;
	end;
end;


UpdateData();

