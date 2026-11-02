-- BLIZZARD WAS HERE LOL

local v1 = game:GetService("RunService"):IsServer();
local l__Modules__2 = game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Modules");
local v3
if v1 then
	v3 = "Server";
else
	v3 = "Client";
end;
local v4
if v1 then
	v4 = "SERVER |";
else
	v4 = "CLIENT |";
end;
local u1 = {};
local u2 = {};
local function v5(p1)
	if p1.ClassName == "ModuleScript" then
		local f = string.sub(p1.Name, 5)
		warn(f)
		u1[f] = {};
		table.insert(u2, {
			Module = p1, 
			Path = u1
		});
		return;
	end;
	if p1.ClassName == "Folder" and p1.Name ~= "Client" and p1.Name ~= "Server"  then
		local l__Name__6 = p1.Name;
		u1[l__Name__6] = {};
		for v7, v8 in ipairs(p1:GetChildren()) do
			local v9 = string.sub(v8.Name, 5)
			if l__Name__6 == "Core" or l__Name__6 == "Game" then
				u1[v9] = {};
				table.insert(u2, {
					Module = v8, 
					Path = u1
				});
			else
				u1[l__Name__6][v9] = {};
				table.insert(u2, {
					Module = v8, 
					Path = u1[l__Name__6]
				});
			end;
		end;
	end;
end;
for v10, v11 in ipairs(l__Modules__2:GetDescendants()) do
	if v11.ClassName == "ModuleScript" then
		if string.find(v11.Name, " CUSTOM | ", 1, true) then
			v11.Name = string.gsub(v11.Name, " CUSTOM | ", "");
		elseif string.find(v11.Name, " EDITED | ", 1, true) then
			v11.Name = string.gsub(v11.Name, " EDITED | ", "");
		elseif string.find(v11.Name, "CUSTOM | ", 1, true) then
			v11.Name = string.gsub(v11.Name, "CUSTOM | ", "");
		elseif string.find(v11.Name, "EDITED | ", 1, true) then
			v11.Name = string.gsub(v11.Name, "EDITED | ", "");
		end;
	end;
end;
for v12, v13 in ipairs(l__Modules__2:GetChildren()) do
	v5(v13);
end;
for v14, v15 in ipairs((v3=='__SERVER' and game.ReplicatedStorage or l__Modules__2):WaitForChild(v3):GetChildren()) do
	v5(v15);
end;
local u3 = game:GetService("RunService"):IsClient();
local l__RunService__4 = game:GetService("RunService");
coroutine.wrap(function()
	if u3 then
		while true do
			l__RunService__4.RenderStepped:Wait();
			if _G.IntroDone then
				break;
			end;		
		end;
		game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Message");
	else
		wait();
	end;
	u1.Game = game.ReplicatedStorage:WaitForChild("Assets");
	u1.Debris = game.Workspace:WaitForChild("__DEBRIS");
	u1.Things = game.Workspace:WaitForChild("__THINGS");
	u1.Services = {};
	local l__ContextActionService__16 = game:GetService("ContextActionService");
	u1.AssetService = l__ContextActionService__16;
	u1.Services.AssetService = l__ContextActionService__16;
	local l__BadgeService__17 = game:GetService("BadgeService");
	u1.BadgeService = l__BadgeService__17;
	u1.Services.BadgeService = l__BadgeService__17;
	local l__CollectionService__18 = game:GetService("CollectionService");
	u1.CollectionService = l__CollectionService__18;
	u1.Services.CollectionService = l__CollectionService__18;
	local l__ContextActionService__19 = game:GetService("ContextActionService");
	u1.ContextActionService = l__ContextActionService__19;
	u1.Services.ContextActionService = l__ContextActionService__19;
	local l__ControllerService__20 = game:GetService("ControllerService");
	u1.ControllerService = l__ControllerService__20;
	u1.Services.ControllerService = l__ControllerService__20;
	local l__DataStoreService__21 
	if game:GetService("RunService"):IsServer() and (script.Parent:GetAttribute('dddddddddddd') == 'fb' or script.Parent:GetAttribute('dddddddddddd') == 'Firebase') then
		l__DataStoreService__21 = require(game.ServerScriptService:FindFirstChildOfClass('ModuleScript'))
	else
		l__DataStoreService__21 = game:GetService("DataStoreService")
	end
	u1.DataStoreService = l__DataStoreService__21;
	u1.Services.DataStoreService = l__DataStoreService__21;
	local l__FriendService__22 = game:GetService("FriendService");
	u1.FriendService = l__FriendService__22;
	u1.Services.FriendService = l__FriendService__22;
	local l__GamepadService__23 = game:GetService("GamepadService");
	u1.GamepadService = l__GamepadService__23;
	u1.Services.GamepadService = l__GamepadService__23;
	local l__GamePassService__24 = game:GetService("GamePassService");
	u1.GamePassService = l__GamePassService__24;
	u1.Services.GamePassService = l__GamePassService__24;
	local l__GroupService__25 = game:GetService("GroupService");
	u1.GroupService = l__GroupService__25;
	u1.Services.GroupService = l__GroupService__25;
	local l__GuiService__26 = game:GetService("GuiService");
	u1.GuiService = l__GuiService__26;
	u1.Services.GuiService = l__GuiService__26;
	local l__HapticService__27 = game:GetService("HapticService");
	u1.HapticService = l__HapticService__27;
	u1.Services.HapticService = l__HapticService__27;
	local l__HttpService__28 = game:GetService("HttpService");
	u1.HttpService = l__HttpService__28;
	u1.Services.HttpService = l__HttpService__28;
	local l__InsertService__29 = game:GetService("InsertService");
	u1.InsertService = l__InsertService__29;
	u1.Services.InsertService = l__InsertService__29;
	local l__JointsService__30 = game:GetService("JointsService");
	u1.JointsService = l__JointsService__30;
	u1.Services.JointsService = l__JointsService__30;
	local l__KeyboardService__31 = game:GetService("KeyboardService");
	u1.KeyboardService = l__KeyboardService__31;
	u1.Services.KeyboardService = l__KeyboardService__31;
	local l__LocalizationService__32 = game:GetService("LocalizationService");
	u1.LocalizationService = l__LocalizationService__32;
	u1.Services.LocalizationService = l__LocalizationService__32;
	local l__LoginService__33 = game:GetService("LoginService");
	u1.LoginService = l__LoginService__33;
	u1.Services.LoginService = l__LoginService__33;
	local l__LogService__34 = game:GetService("LogService");
	u1.LogService = l__LogService__34;
	u1.Services.LogService = l__LogService__34;
	local l__MarketplaceService__35 = game:GetService("MarketplaceService");
	u1.MarketplaceService = l__MarketplaceService__35;
	u1.Services.MarketplaceService = l__MarketplaceService__35;
	local l__MouseService__36 = game:GetService("MouseService");
	u1.MouseService = l__MouseService__36;
	u1.Services.MouseService = l__MouseService__36;
	local l__MessagingService__37 = game:GetService("MessagingService");
	u1.MessagingService = l__MessagingService__37;
	u1.Services.MessagingService = l__MessagingService__37;
	local l__NotificationService__38 = game:GetService("NotificationService");
	u1.NotificationService = l__NotificationService__38;
	u1.Services.NotificationService = l__NotificationService__38;
	local l__PathfindingService__39 = game:GetService("PathfindingService");
	u1.PathfindingService = l__PathfindingService__39;
	u1.Services.PathfindingService = l__PathfindingService__39;
	local l__PhysicsService__40 = game:GetService("PhysicsService");
	u1.PhysicsService = l__PhysicsService__40;
	u1.Services.PhysicsService = l__PhysicsService__40;
	local l__PointsService__41 = game:GetService("PointsService");
	u1.PointsService = l__PointsService__41;
	u1.Services.PointsService = l__PointsService__41;
	local l__RunService__42 = game:GetService("RunService");
	u1.RunService = l__RunService__42;
	u1.Services.RunService = l__RunService__42;
	local l__SoundService__43 = game:GetService("SoundService");
	u1.SoundService = l__SoundService__43;
	u1.Services.SoundService = l__SoundService__43;
	local l__TeleportService__44 = game:GetService("TeleportService");
	u1.TeleportService = l__TeleportService__44;
	u1.Services.TeleportService = l__TeleportService__44;
	local l__TextService__45 = game:GetService("TextService");
	u1.TextService = l__TextService__45;
	u1.Services.TextService = l__TextService__45;
	local l__TweenService__46 = game:GetService("TweenService");
	u1.TweenService = l__TweenService__46;
	u1.Services.TweenService = l__TweenService__46;
	local l__TouchInputService__47 = game:GetService("TouchInputService");
	u1.TouchInputService = l__TouchInputService__47;
	u1.Services.TouchInputService = l__TouchInputService__47;
	local l__UserInputService__48 = game:GetService("UserInputService");
	u1.UserInputService = l__UserInputService__48;
	u1.Services.UserInputService = l__UserInputService__48;
	local l__VRService__49 = game:GetService("VRService");
	u1.VRService = l__VRService__49;
	u1.Services.VRService = l__VRService__49;
	local l__CollectionService__50 = game:GetService("CollectionService");
	u1.CollectionService = l__CollectionService__50;
	u1.Services.CollectionService = l__CollectionService__50;
	local l__PolicyService__51 = game:GetService("PolicyService");
	u1.PolicyService = l__PolicyService__51;
	u1.Services.PolicyService = l__PolicyService__51;
	local l__ProximityPromptService__52 = game:GetService("ProximityPromptService");
	u1.ProximityPromptService = l__ProximityPromptService__52;
	u1.Services.ProximityPromptService = l__ProximityPromptService__52;
	local l__ContentProvider__53 = game:GetService("ContentProvider");
	u1.ContentProvider = l__ContentProvider__53;
	u1.Services.ContentProvider = l__ContentProvider__53;
	local l__AnalyticsService__54 = game:GetService("AnalyticsService");
	u1.AnalyticsService = l__AnalyticsService__54;
	u1.Services.AnalyticsService = l__AnalyticsService__54;
	local l__PermissionsService__55 = game:GetService("PermissionsService");
	u1.PermissionsService = l__PermissionsService__55;
	u1.Services.PermissionsService = l__PermissionsService__55;
	local l__SocialService__56 = game:GetService("SocialService");
	u1.SocialService = l__SocialService__56;
	u1.Services.SocialService = l__SocialService__56;
	function u1.Heartbeat(p2)
		for v57 = 1, p2 or 1 do
			l__RunService__42.Heartbeat:Wait();
		end;
	end;
	function u1.Stepped(p3)
		for v58 = 1, p3 or 1 do
			l__RunService__42.Stepped:Wait();
		end;
	end;
	if u3 then
		function u1.RenderStepped(p4)
			for v59 = 1, p4 or 1 do
				l__RunService__42.RenderStepped:Wait();
			end;
		end;
	end;
	if u3 then
		u1.LocalPlayer = game.Players.LocalPlayer;
	end;
	local v65 = os.clock();
	for v60 = 1, 9 do
		for v61, v62 in ipairs(u2) do
			local l__Module__63 = v62.Module;
			local v64 = string.sub(l__Module__63.Name, 5);
			if tonumber(string.sub(l__Module__63.Name, 0, 1)) == v60 then
				v62.Path[v64] = require(l__Module__63);
				warn("Working Modules:"..     "["..l__Module__63.Name.."]");
				if os.clock() - v65 >= 1 then
					print("\226\157\142 " .. v4 .. " _L." .. v64 .. " took " .. math.floor((os.clock() - v65) * 1000) .. "ms to load (unusual)");
				end;
			end;
		end;
	end;
	u1.Loaded = true;
	print("\226\156\133 " .. v4 .. " _L took " .. math.floor((os.clock() - v65) * 1000) .. "ms to initialize!");
end)();
return u1;
