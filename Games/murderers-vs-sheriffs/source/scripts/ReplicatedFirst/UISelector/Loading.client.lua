local ReplicatedFirst = game:GetService("ReplicatedFirst");
local l_UserInputService_0 = game:GetService("UserInputService");
local TeleportService = game:GetService("TeleportService");
local l_GuiService_0 = game:GetService("GuiService");
local l_RunService_0 = game:GetService("RunService");

ReplicatedFirst:RemoveDefaultLoadingScreen();
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false);

local v6 = false;
local v7 = false;
local v8 = nil;
local v9 = false;

local function SafeTeleportToPlaceInstance(...)
	if l_RunService_0:IsStudio() then
		warn("[Loading] TeleportToPlaceInstance blocked during Studio playtest.")
		return nil
	end
	return TeleportService:TeleportToPlaceInstance(...)
end

TeleportService.LocalPlayerArrivedFromTeleport:Connect(function(_, p10)
	v8 = true
	ReplicatedFirst.ClientLoaded:FireServer("Teleport")
	if p10 then
		if p10.Joined == true then
			v6 = true;
		end
		if p10.ModeSwitch then
			v7 = true
		end
		if p10.PortalEvent == true then
			v9 = true
		end
	end
end)

task.spawn(function() --[[ Line: 49 ]]
	repeat
		wait();
	until game.ReplicatedStorage;
	repeat
		wait();
	until game.ReplicatedStorage:FindFirstChild("GetSyncData");
	repeat
		task.wait(0.25);
		_G.Database = game.ReplicatedStorage.GetSyncData:InvokeServer();
	until _G.Database ~= nil;
	_G.Database.Weapons = _G.Database.Item;
	for v15, v16 in pairs(_G.Database.Toys) do
		_G.Database.Emotes[v15] = v16;
	end;
	
end);

local v17 = false;
local v18 = l_GuiService_0:IsTenFootInterface();
local l_PlayerGui_0 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local l_Loading_0 = script:WaitForChild("Loading_Clean");

l_Loading_0.Name = "Loading";
l_Loading_0.Parent = l_PlayerGui_0;

local l_Container_0 = l_Loading_0:WaitForChild("Container");
local l_Images_0 = l_Container_0:WaitForChild("Images");
local l_Grey_0 = l_Images_0:WaitForChild("Grey");
local l_Colored_Clean_0 = l_Images_0:WaitForChild("Colored_Clean");

if v18 then
	task.spawn(function()
		game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("IsXbox"):FireServer();
	end);
	l_PlayerGui_0:SetAttribute("Device", "Gamepad");
end;
local function v25(v26, v27)
	v27.AncestryChanged:connect(function(_, v29)
		if v29 == nil and game.Players.LocalPlayer:FindFirstChild("PlayerGui") and game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainGUI") == nil then
			local v30 = v26:Clone();
			v25(v26, v30);
			v30.Name = "MainGUI";
			v30.Parent = game.Players.LocalPlayer.PlayerGui;
		end;
	end);
end;

local v31 = game.GameId == 119460199;

local function v42()
	local v35 = nil;
	if v17 then
		v35 = game.ReplicatedStorage:WaitForChild("GUI"):WaitForChild("MainMobile"):Clone();
	elseif v18 then
		if v31 then
			if l_PlayerGui_0:WaitForChild("MainXbox", 1) then
				v35 = l_PlayerGui_0:WaitForChild("MainXbox");
			else
				v35 = game.ReplicatedStorage:WaitForChild("GUI"):WaitForChild("MainXbox"):Clone();
			end
		else
			v35 = game.ReplicatedStorage:WaitForChild("GUI"):WaitForChild("MainXbox"):Clone();
		end
	else
		local _ = game:GetService("RunService"):IsStudio();
		v35 = game.ReplicatedStorage:WaitForChild("GUI"):WaitForChild("MainPC"):Clone();
	end;
	v35.Name = "MainGUI";
	v35.Parent = game.ReplicatedStorage;
	local v37 = v35:Clone();
	local l_v35_0 = v35;
	game.Players.LocalPlayer.CharacterAdded:connect(function() --[[ Line: 89 ]]
		if game.Players.LocalPlayer:FindFirstChild("PlayerGui") and game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainGUI") then
			game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainGUI"):Destroy();
		end
		local v41 = l_v35_0:Clone();
		v41.Name = "MainGUI";
		v41.Parent = game.Players.LocalPlayer.PlayerGui;
	end);
	v37.Parent = game.Players.LocalPlayer.PlayerGui;
end;
local function v46() --[[ Line: 129 ]] --[[ Name: LoadGame ]]
	local v44 = false;
	local v45 = false;
	task.spawn(function() --[[ Line: 134 ]]
		task.wait(7);
		pcall(function() --[[ Line: 136 ]]
			if not v44 then
				l_Container_0:WaitForChild("Skip").Visible = true;
				l_Container_0:WaitForChild("Warning").Visible = true;
				l_Container_0:WaitForChild("Skip").Activated:Connect(function() --[[ Line: 140 ]]
					v45 = true;
				end);
			end;
		end);
	end);
	while game.ContentProvider.RequestQueueSize > 0 and not v45 do
		l_Loading_0:WaitForChild("Container"):WaitForChild("LoadingText").Text = "Loading World: " .. game.ContentProvider.RequestQueueSize .. " objects left.";
		l_RunService_0.PreSimulation:Wait();
	end;
	v44 = true;
	l_Container_0:WaitForChild("Skip").Visible = false;
	l_Container_0:WaitForChild("Warning").Visible = false;
end;
local l_TweenService_0 = game:GetService("TweenService");
local v48 = TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0);
local v49 = l_RunService_0:IsStudio();
local function v51() --[[ Line: 171 ]] --[[ Name: WaitForCharacter ]]
	if not v49 then
		l_Loading_0:WaitForChild("Container"):WaitForChild("LoadingText").Text = "Loading Data...";
		task.wait(1);
		l_Loading_0:WaitForChild("Container"):WaitForChild("LoadingBar").Visible = true;
		l_Loading_0:WaitForChild("Container"):WaitForChild("LoadingText").Visible = false;
		task.wait(0.5);
		l_TweenService_0:Create(l_Loading_0:WaitForChild("Container"):WaitForChild("LoadingBar"):WaitForChild("BarContainer"):WaitForChild("Bar"), v48, {
			Size = UDim2.new(1, 0, 1, 0)
		}):Play();
		task.wait(1.8);
		l_Loading_0:WaitForChild("Container"):WaitForChild("LoadingBar").Visible = false;
		l_Loading_0:WaitForChild("Container"):WaitForChild("LoadingText").Text = "Loading Character...";
		l_Loading_0:WaitForChild("Container"):WaitForChild("LoadingText").Visible = true;
	end;
	local v50 = false;
	local waitStart = os.clock();
	repeat
		wait();
		v50 = game.Players.LocalPlayer:FindFirstChild("LoadingData");
	until game.Players.LocalPlayer.Character ~= nil or v50 or os.clock() - waitStart >= 30;
	if v50 and game.Players.LocalPlayer.Character == nil then
		l_Loading_0:WaitForChild("Container"):WaitForChild("LoadingText").Text = "Verifying Data, please wait 60 seconds!...";
		local dataWaitStart = os.clock();
		repeat
			wait();
		until game.Players.LocalPlayer.Character ~= nil or os.clock() - dataWaitStart >= 60;
	end;
end;
local _ = game.ReplicatedStorage:WaitForChild("GetSyncData"):InvokeServer("Item");
local _ = {};
_G.Cache = {};
_G.SmallCache = {};
local function _(v54) --[[ Line: 208 ]] --[[ Name: GetImage ]]
	if _G.Cache[v54] ~= nil then
		return _G.Cache[v54];
	else
		return tonumber(v54) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v54 or v54;
	end;
end;
local function v59() --[[ Line: 229 ]] --[[ Name: FadeOut ]]
	while l_Container_0.BackgroundTransparency < 1 do
		local v58 = l_RunService_0.PreSimulation:Wait() * 1.3;
		l_Container_0.BackgroundTransparency = l_Container_0.BackgroundTransparency + v58;
		l_Colored_Clean_0.ImageTransparency = l_Colored_Clean_0.ImageTransparency + v58;
	end;
end;
v51();
local v60 = true;
task.spawn(function() --[[ Line: 245 ]]
	while task.wait() and v60 do
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
	end;
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true);
end);
local function v61() --[[ Line: 253 ]] --[[ Name: Play ]]
	if not v17 then
		v46();
	end;
	if game.ReplicatedStorage:FindFirstChild("Database") == nil then
		l_Loading_0:WaitForChild("Container"):WaitForChild("LoadingText").Text = "Loading Database...";
		repeat
			wait();
		until game.ReplicatedStorage:FindFirstChild("Database") ~= nil;
	end;
	l_Colored_Clean_0.Visible = true;
	l_Colored_Clean_0.ImageTransparency = 0;
	l_Grey_0.Visible = false;
	l_Container_0:WaitForChild("LoadingText").Text = "";
	l_Container_0:WaitForChild("Thumbs").Visible = false;
	task.wait(1);
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true);
	v42();
	v59();
	l_Loading_0:Destroy();
	game.ReplicatedStorage.GUI:Destroy();
	v60 = false;
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("LoadedCompletely"):FireServer();
end;
local v65 = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("IsVIPServer"):InvokeServer();
local v66 = not v6 and not v65;
local v67 = nil;
local v68 = nil;
local v69 = nil;
local v70 = {
	[104623395645506] = "Main Server", --Standard
	[76296357343644] = "Main Server", --Disguises
	[126502277408290] = "Main Server", --Assasin
	
	[188331334] = "Testing Server", 
	[333740520] = "Testing Server", 
	[4809287476] = "Testing Server"
};
local v72 = {
	[333740520] = true, 
	[126502277408290] = true --Assasin
};
local v73 = {
	[126502277408290] = true --Assasin
};
local v75 = {
	Hardcore = 333740520, 
	Classic = 188331334, 
	[333740520] = "Disguises", 
	[188331334] = "Standard"
};
v67 = not v17 and script:WaitForChild("Join"):Clone() or script:WaitForChild("JoinPhone"):Clone();
v67.Retry.Retry.MouseButton1Click:connect(function() --[[ Line: 343 ]]
	v67.Retry.Visible = false;
	v67.Friends.Visible = true;
end);
local v77 = v75[game.PlaceId];
local function v78(v79)
	if not v79 then
		v79 = game.Players.LocalPlayer:GetFriendsOnline();
	end;
	v67.Friends.FriendsList.ScrollingFrame.Container:ClearAllChildren();
	script.FriendLayout:Clone().Parent = v67.Friends.FriendsList.ScrollingFrame.Container;
	for _, v81 in pairs(v79) do
		if v70[v81.PlaceId] then
			local v82 = script.FriendFrame:Clone();
			v82.FriendName.Text = v81.UserName or v81.DisplayName or "";
			local v83 = v75[v81.PlaceId];
			if v81.LocationType == 3 then
				v82.Studio.Visible = true;
			elseif v83 and not v77 then
				v82.Server.Text = "Testing Server";
				v82.Server.Visible = true;
			elseif v77 and not v83 then
				v82.Server.Text = "Main Server";
				v82.Server.Visible = true;
			else
				v82.Join.Visible = true;
				v82.Assassin.Visible = v73[v81.PlaceId];
				v82.Hardcore.Visible = v72[v81.PlaceId];
			end;
			v82.Parent = v67.Friends.FriendsList.ScrollingFrame.Container;
			v82.Join.MouseButton1Click:connect(function() --[[ Line: 395 ]]
				v67.Friends.Visible = false;
				v67.Loading.Visible = true;
				local v84 = false;
				for _, v86 in pairs(game.Players:GetPlayers()) do
					if v86.UserId == v81.VisitorId then
						v84 = true;
						break;
					end;
				end;
				if not v84 then
					v68 = v81.PlaceId;
					v69 = v81.GameId;
					SafeTeleportToPlaceInstance(v68, v69, game.Players.LocalPlayer, "", {
						Joined = true
					});
					spawn(function() --[[ Line: 404 ]]
						while v67.Loading.Visible == true do
							v67.Loading.Spinner.Rotation = v67.Loading.Spinner.Rotation + 5;
							game:GetService("RunService").RenderStepped:wait();
						end;
					end);
					wait(5);
					v67.Friends.Visible = false;
					v67.Retry.Visible = true;
					v67.Loading.Visible = false;
					spawn(function() --[[ Line: 409 ]]
						while v67.Retry.Visible == true do
							v67.Retry.Spinner.Rotation = v67.Retry.Spinner.Rotation + 5;
							game:GetService("RunService").RenderStepped:wait();
						end;
					end);
					spawn(function() --[[ Line: 410 ]]
						local v87 = 1;
						while v67.Retry.Visible == true do
							v67.Retry.Retrying.Text = "Retrying... (" .. v87 .. ")";
							v68 = v81.PlaceId;
							v69 = v81.GameId;
							SafeTeleportToPlaceInstance(v68, v69, game.Players.LocalPlayer, "", {
								Joined = true
							});
							for _ = 1, 50 do
								wait(0.1);
								if not v67.Retry.Visible then
									break;
								end;
							end;
							v87 = v87 + 1;
						end;
					end);
					v78();
					return;
				else
					v67:Destroy();
					v61();
					return;
				end;
			end);
		end;
	end;
end;
local function v93() --[[ Line: 440 ]] --[[ Name: JoinFriend ]]
	if v66 then
		local v89 = nil;
		pcall(function() --[[ Line: 443 ]]
			v89 = game.Players.LocalPlayer:GetFriendsOnline();
		end);
		if v89 and #v89 > 0 then
			local v90 = false;
			for _, v92 in pairs(v89) do
				if v70[v92.PlaceId] then
					v90 = true;
				end;
			end;
			if v90 and not v17 then
				v67.Parent = game.Players.LocalPlayer.PlayerGui;
				v78(v89);
				v67.Friends.Play.MouseButton1Click:Connect(function() --[[ Line: 455 ]]
					v67:Destroy();
					v61();
				end);
			else
				v61();
			end;
		else
			v61();
		end;
		return;
	else
		v61();
		return;
	end;
end;
local function v95()
	v67 = not v17 and script.Join:Clone() or script.JoinPhone:Clone();
	v67.Retry.Retry.MouseButton1Click:connect(function() --[[ Line: 478 ]]
		v67.Retry.Visible = false;
		v67.Friends.Visible = true;
	end);
end;
local v96 = {
	Tablet = "Phone", 
	Phone = "Tablet"
};
local function v99()
	local l_DeviceSelect_0 = script:WaitForChild("DeviceSelect");
	local v98 = game.ReplicatedStorage.Remotes.Extras.GetData:InvokeServer("LastDevice");
	game:GetService("ContentProvider"):PreloadAsync({
		"https://www.roblox.com/asset/?id=466263397", 
		"https://www.roblox.com/asset/?id=466240313"
	});
	wait();
	l_DeviceSelect_0.Parent = game.Players.LocalPlayer.PlayerGui;
	if v98 then
		l_DeviceSelect_0:WaitForChild("Container"):WaitForChild(v98):WaitForChild("Last").Visible = true;
		l_DeviceSelect_0:WaitForChild("Container"):WaitForChild(v96[v98]):WaitForChild("Cover").Visible = true;
		l_DeviceSelect_0:WaitForChild("Container"):WaitForChild(v96[v98]):WaitForChild("Switch").Visible = true;
	end;
	l_DeviceSelect_0:WaitForChild("Container"):WaitForChild("Phone"):WaitForChild("Button").MouseButton1Click:connect(function() --[[ Line: 505 ]]
		v17 = true;
		game.Players.LocalPlayer.PlayerGui:SetAttribute("Device", "Phone");
		task.spawn(function() --[[ Line: 508 ]]
			game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ChangeLastDevice"):FireServer("Phone");
		end);
		l_DeviceSelect_0:Destroy();
		v95();
		v93();
		_G.MobileDevice = "Phone";
	end);
	l_DeviceSelect_0:WaitForChild("Container"):WaitForChild("Tablet"):WaitForChild("Button").MouseButton1Click:connect(function() --[[ Line: 516 ]]
		task.spawn(function() --[[ Line: 517 ]]
			game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ChangeLastDevice"):FireServer("Tablet");
		end);
		l_DeviceSelect_0:Destroy();
		v95();
		v93();
		_G.MobileDevice = "Tablet";
		game.Players.LocalPlayer.PlayerGui:SetAttribute("Device", "Tablet");
	end);
end;
local v100 = l_UserInputService_0:GetLastInputType() == Enum.UserInputType.Touch;
local l_TouchEnabled_0 = l_UserInputService_0.TouchEnabled;
local v102 = v100 or l_TouchEnabled_0 and not l_UserInputService_0.KeyboardEnabled or l_TouchEnabled_0 and v49;
if v31 then
	print("== TESTING SERVER ==");
end;
print("Server Version: " .. game.PlaceVersion);

if v31 and v49 and script:GetAttribute("studioTouchEnabled") then
	v102 = true;
end;
if game.Players.LocalPlayer.FollowUserId > 0 and not v65 then
	local v103 = false;
	for _, v105 in pairs(game.Players:GetChildren()) do
		if v105.userId == game.Players.LocalPlayer.FollowUserId then
			v103 = true;
			break;
		end;
	end;
	if not v103 then
		l_Container_0:WaitForChild("LoadingText").Text = "Joining User...";
		game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("Follow"):FireServer();
		task.wait(5);
		l_Container_0:WaitForChild("LoadingText").Text = "Failed to join user.";
		task.wait(1);
	end;
	if v102 then
		v99();
	else
		v93();
	end;
elseif not v18 and not v17 then
	if v102 then
		v99();
	else
		v93();
		game.Players.LocalPlayer.PlayerGui:SetAttribute("Device", "PC");
	end;
else
	v61();
end;


