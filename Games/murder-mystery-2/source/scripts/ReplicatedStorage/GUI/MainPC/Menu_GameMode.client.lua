local MainGUI = script.Parent.Game;

local ChangeButton = MainGUI.Settings.GameMode;
local ChangeFrame = MainGUI.ChangeGameMode;

ChangeButton.MouseButton1Click:connect(function()
	ChangeFrame.Visible = not ChangeFrame.Visible;
end)

local TestServerID = 13027726810;
local MM2ID = 13085716426;

local HardcoreID = 9254168082;
local HardcoreTestID = 345345;

local MinigamesID = 13556407580;
local MinigamesTestID = 450611752;

local AssassinID = 13558298473;
local AssassinTestID = 13546801377;

local IsHardcore = (game.PlaceId == HardcoreID or game.PlaceId == HardcoreTestID);
local IsMinigames = (game.PlaceId == MinigamesTestID);
local IsAssassin = (game.PlaceId == AssassinTestID or game.PlaceId == AssassinID);
local IsTestingServer = (game.PlaceId == TestServerID or game.PlaceId == MinigamesTestID or game.PlaceId == AssassinTestID or game.PlaceId == HardcoreTestID);

local CasualServerToTelportTo =	   (IsTestingServer and TestServerID ) or MM2ID;
local HardcoreServerToTeleportTo = (IsTestingServer and HardcoreTestID ) or HardcoreID;
local AssassinServerToTeleportTo = (IsTestingServer and AssassinTestID ) or AssassinID;

ChangeFrame.Casual.Play.MouseButton1Click:connect(function()
	if IsHardcore or IsMinigames or IsAssassin then
		game.ReplicatedStorage.ChangeGameMode:FireServer("Casual");
		game:GetService('TeleportService'):Teleport(CasualServerToTelportTo);
		ChangeFrame.Loading.Visible = true;
	else
		ChangeFrame.Visible = false;
	end;
end);

ChangeFrame.Hardcore.Play.MouseButton1Click:connect(function()
	if (not IsHardcore) then
		game.ReplicatedStorage.ChangeGameMode:FireServer("Hardcore");
		game:GetService('TeleportService'):Teleport(HardcoreServerToTeleportTo);
		ChangeFrame.Loading.Visible = true;
	else
		ChangeFrame.Visible = false;
	end;
end);

ChangeFrame.Assassin.Play.MouseButton1Click:connect(function()
	if (not IsAssassin) then
		game.ReplicatedStorage.ChangeGameMode:FireServer("Assassin");
		game:GetService('TeleportService'):Teleport(AssassinServerToTeleportTo);
		ChangeFrame.Loading.Visible = true;
	else
		ChangeFrame.Visible = false;
	end;
end);

if IsMinigames then
	ChangeFrame.Minigames.Play.MouseButton1Click:connect(function()
		if not IsMinigames then
			game.ReplicatedStorage.ChangeGameMode:FireServer("Minigames");
			game:GetService('TeleportService'):Teleport(MinigamesID);
			ChangeFrame.Loading.Visible = true;
		else
			ChangeFrame.Visible = false;
		end;
	end);
end;

local FriendsOnlineFrame = MainGUI.FriendsOnline;
local FOLeaderboard = MainGUI.Leaderboard.Container.FriendsOnline;
local FriendsContainer = FriendsOnlineFrame.Main.ScrollFrame.Container;
local LastCheck = 0;
local TeleportService = game:GetService("TeleportService");

FOLeaderboard.Join.MouseButton1Click:connect(function()
	FriendsOnlineFrame.Visible = not FriendsOnlineFrame.Visible;
end);
FriendsOnlineFrame.Title.Close.MouseButton1Click:connect(function()
	FriendsOnlineFrame.Visible = false;
end)
FriendsOnlineFrame.Retry.Back.MouseButton1Click:connect(function()
	FriendsOnlineFrame.Retry.Visible = false;
	FriendsOnlineFrame.Main.Visible = true;
end)

game:GetService("RunService"):BindToRenderStep("FriendsOnline",1000,function()
	if time()-LastCheck >= 10 then
		LastCheck = time();
		local FriendsOnline = game.Players.LocalPlayer:GetFriendsOnline();
		FriendsContainer:ClearAllChildren();
		local Index = 0;
		for _,Friend in pairs(FriendsOnline) do
			if Friend.PlaceId == MM2ID or Friend.PlaceId == TestServerID or Friend.PlaceId == HardcoreID or Friend.PlaceId == HardcoreTestID then
				local NewFrame = script.Friend:Clone();
				NewFrame.PlayerName.Text = "Friend"; -- game.Players:GetNameFromUserIdAsync(Friend.VisitorId)
				-- line above errors and fails idk why
				NewFrame.GameMode.Text = (Friend.PlaceId == HardcoreID and "Hardcore") or "Casual";
				NewFrame.Position = UDim2.new(0,0,0,30*Index);
				NewFrame.Parent = FriendsContainer;
				NewFrame.Join.MouseButton1Click:connect(function()
					FriendsOnlineFrame.Main.Visible = false;
					FriendsOnlineFrame.Teleporting.Visible = true;
					TeleportService:TeleportToPlaceInstance(Friend.PlaceId,Friend.GameId,game.Players.LocalPlayer,"",{Joined=true})
					wait(5);
					FriendsOnlineFrame.Teleporting.Visible = false;
					FriendsOnlineFrame.Retry.Visible = true;
					
					spawn(function() while FriendsOnlineFrame.Retry.Visible == true do FriendsOnlineFrame.Retry.Spinner.Rotation = FriendsOnlineFrame.Retry.Spinner.Rotation + 5; game:GetService("RunService").RenderStepped:wait(); end; end)
					spawn(function()
						local Attempts = 1;
						while FriendsOnlineFrame.Retry.Visible == true do
							FriendsOnlineFrame.Retry.Retrying.Text = "Retrying... (" .. Attempts .. ")";
							TeleportService:TeleportToPlaceInstance(Friend.PlaceId,Friend.GameId,game.Players.LocalPlayer,"",{Joined=true})
							for i = 1,50 do
								wait(0.1);
								if not FriendsOnlineFrame.Retry.Visible then
									break;
								end
							end
							Attempts = Attempts+1;
						end;
					end);				
					
				end)
				Index = Index + 1;
			end;
		end;
		FOLeaderboard.Title.Text = "Friends Playing: " .. Index;
		FOLeaderboard.Join.Visible = (Index>0);
	end
end);