local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v2 = require(script.Parent);
local v3 = require(script:FindFirstAncestor("MainUI").Modules.WindShake);
local v4 = require(l__LocalPlayer__1:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v5 = game:GetService("RunService")
local l__UserInputService__6 = game:GetService("UserInputService");
local l__TweenService__7 = game:GetService("TweenService");
local l__CollectionService__8 = game:GetService("CollectionService");
local v9 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("Module_Events"));
local v10 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("LowQuality"));
v3:Init();
local v11 = {};
for v12, v13 in pairs(script.AttributeModules:GetChildren()) do
	v11[v13.Name] = require(v13);
end;
local function v14()
	local v15 = v2.controller == "console";
	for v16, v17 in pairs(game:GetService("CollectionService"):GetTagged("XBox")) do
		v17.Visible = v15;
	end;
end;
l__UserInputService__6.GamepadConnected:Connect(v14);
l__UserInputService__6.GamepadDisconnected:Connect(v14);
local v18 = v2.controller == "console";
for v19, v20 in pairs(game:GetService("CollectionService"):GetTagged("XBox")) do
	v20.Visible = v18;
end;
local v21 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"));
local v22, v23 = v21();
local u1 = v23;
local u2 = v22;
l__UserInputService__6.LastInputTypeChanged:Connect(function()
	local v24, v25 = v21();
	v2.platform = v24;
	v2.controller = v25;
	if u1 ~= v2.controller then
		local v26 = v2.controller == "console";
		for v27, v28 in pairs(game:GetService("CollectionService"):GetTagged("XBox")) do
			v28.Visible = v26;
		end;
		local v29, v30 = v21();
		u2 = v29;
		u1 = v30;
	end;
end);
local function v31()
	local Locked = false
	local v32 = workspace.CurrentRooms:FindFirstChild(v2.gd.LatestRoom.Value);
	local l__Value__33 = v2.gd.LatestRoom.Value;
	if not tonumber(l__LocalPlayer__1:GetAttribute("CurrentRoom")) or not l__Value__33 then
		warn("Cannot calculate current room");
		warn(tonumber(l__LocalPlayer__1:GetAttribute("CurrentRoom")));
		warn(l__Value__33);
	end;
	if v32 and v32:GetAttribute("RequiresKey") == true then
		Locked = true
	end;
	if v32:WaitForChild("Door", 1) then
		local l__Door__34 = v32:FindFirstChild("Door");
		local v35 = 12;
		if v2.chase then
			v35 = 24;
		end;
		if l__Door__34 then
			task.spawn(function()
				while true do
					wait(0.1);
					if l__Value__33 < tonumber(l__LocalPlayer__1:GetAttribute("CurrentRoom")) then
						return;
					end;
					if (l__LocalPlayer__1.Character.PrimaryPart.Position - l__Door__34.PrimaryPart.Position).Magnitude < v35 then
						local v37 = RaycastParams.new();
						v37.CollisionGroup = "Player";
						v37.FilterDescendantsInstances = { l__Door__34, l__LocalPlayer__1.Character };
						local v38 = workspace:Raycast(l__LocalPlayer__1.Character.PrimaryPart.Position, CFrame.new(l__LocalPlayer__1.Character.PrimaryPart.Position, l__Door__34.PrimaryPart.Position).LookVector * (l__LocalPlayer__1.Character.PrimaryPart.Position - l__Door__34.PrimaryPart.Position).Magnitude, v37);
						if not v38 then
							-- just beware of things blocking this ray, like workspace.Halt or another player.
							if Locked then
								if l__Door__34.Lock.Anchored == false then
									l__Door__34.ClientOpen:FireServer();
									print("Fired")
									return;
								end	
							elseif not Locked then
								l__Door__34.ClientOpen:FireServer();
								print("Fired2")
								return;
							end
						end;
						--[[if not v38.Position then
							if Locked and l__Door__34.Locked.Anchored == false then
								l__Door__34.ClientOpen:FireServer();
								print("Fired3")
								return;
							elseif not Locked then
								l__Door__34.ClientOpen:FireServer();
								print("Fired4")
								return;
							end
						end;]]
					end;
				end;
			end);
		end;
	end;
	local l__PathfindNodes__39 = v32:WaitForChild("PathfindNodes", 1);
	if l__PathfindNodes__39 then
		l__PathfindNodes__39:Destroy();
	end;
	for v40, v41 in pairs(v11) do
		for v42, v43 in ipairs(v32:GetDescendants()) do

			if v43:GetAttribute(v40) then
				v41(v43);
			end;		
		end;
	end;
	if v32:FindFirstChild("Shopkeeper") then
		require(script.Shopkeeper).run(v32);
	end;
	for v45, v46 in ipairs(v32:GetDescendants()) do
		if v46:IsA("BasePart") and v46:GetAttribute("WindShake") == true then
			v3:AddObjectShake(v46);
		elseif v46.Name == "GuidingLightStuff" or v46.Name == "HelpLight" or v46.Name == "HelpParticle" then
			if v46:IsA("SpotLight") then
				if v10() then
					v46.Color = Color3.fromRGB(39, 190, 255);
					v46.Brightness = 8;
					v46.Range = 32;
					v46.Angle = 40;
				end;
			elseif v46:IsA("ParticleEmitter") and v10() then
				v46.Rate = 50;
			end;
		end;	
	end;
	if v32:GetAttribute("Header") ~= nil and v32:GetAttribute("Header") ~= "" and v32:GetAttribute("Header") ~= " " then
		v2.titlelocation(v32:GetAttribute("Header"));
	end;
	if not v10(8, true) then
		--[[for v48, v49 in l__CollectionService__8("HighQualityOnly") do
			v49:Destroy();
		end;]] --NEWADT:
		for v50, v51 in ipairs(v32:GetDescendants()) do
			if v51:IsA("Light") and v51:GetAttribute("HighQualityOnly") then
				v51.Enabled = false;
				v51.Brightness = 0;
			end;		
		end;
	end;
	if v32:FindFirstChild("FigureSetup", true) then
		local l__FigureRagdoll__53 = v32:FindFirstChild("FigureSetup", true).FigureRagdoll;
		local l__Parent__54 = l__FigureRagdoll__53.Parent;
		local v55 = 0;
		local l__Click__56 = l__FigureRagdoll__53.Head.Click;
		local l__Growl__57 = l__FigureRagdoll__53.Head.Growl;
		local v58 = {};
		for v59, v60 in pairs(l__FigureRagdoll__53:GetDescendants()) do
			if v60:IsA("Light") and v60.Name == "BlisterLight" then
				v60.Enabled = true;
				v60.Brightness = 0;
				table.insert(v58, {
					Light = v60, 
					Distance = l__FigureRagdoll__53.Head.Position - v60.Parent.WorldPosition
				});
			end;
		end;
		local v61 = TweenInfo.new(0.1, Enum.EasingStyle.Linear);
		for v62 = 1, 100000000 do
			wait(0.1);
			if not l__FigureRagdoll__53 then
				break;
			end;
			if l__FigureRagdoll__53.Parent ~= l__Parent__54 then
				break;
			end;
			local v63 = (l__Click__56.PlaybackLoudness + l__Growl__57.PlaybackLoudness) / 60;
			if v63 ~= v55 then
				for v64, v65 in v58, nil do
					delay(v65.Distance / 2, function()
						l__TweenService__7:Create(v65.Light, v61, {
							Brightness = v63
						}):Play();
					end);
				end;
			end;
			v55 = v63;
		end;
	end;
	if v32:FindFirstChild("FigureAnimatedWelded", true) then
		local l__FigureAnimatedWelded__66 = v32:FindFirstChild("FigureAnimatedWelded", true);
		local l__Parent__67 = l__FigureAnimatedWelded__66.Parent;
		local v68 = 0;
		local l__Click__69 = l__FigureAnimatedWelded__66.Parent.Head.Click;
		local l__Growl__70 = l__FigureAnimatedWelded__66.Parent.Head.Growl;
		local v71 = {};
		for v72, v73 in pairs(l__FigureAnimatedWelded__66:GetDescendants()) do
			if v73:IsA("Light") and v73.Name == "BlisterLight" then
				v73.Enabled = true;
				v73.Brightness = 0;
				table.insert(v71, {
					Light = v73, 
					Distance = l__FigureAnimatedWelded__66.Parent.Head.Position - v73.Parent.WorldPosition
				});
			end;
		end;
		local v74 = TweenInfo.new(0.1, Enum.EasingStyle.Linear);
		for v75 = 1, 100000000 do
			wait(0.1);
			if not l__FigureAnimatedWelded__66 then
				break;
			end;
			if l__FigureAnimatedWelded__66.Parent ~= l__Parent__67 then
				break;
			end;
			local v76 = (l__Click__69.PlaybackLoudness + l__Growl__70.PlaybackLoudness) / 90 - 0.15;
			if v76 ~= v68 then
				for v77, v78 in v71, nil do
					delay(v78.Distance / 4, function()
						l__TweenService__7:Create(v78.Light, v74, {
							Brightness = v76
						}):Play();
					end);
				end;
			end;
			v68 = v76;
		end;
	end;
end;
v2.gd:WaitForChild("FinishedLoadingRoom").Changed:Connect(v31);
v2.gd:WaitForChild("Preload").Changed:Connect(v31);
workspace:WaitForChild("Ambience_Dark").Played:Connect(function()

end);
l__LocalPlayer__1:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
	local v79 = workspace.CurrentRooms:FindFirstChild(l__LocalPlayer__1:GetAttribute("CurrentRoom"));
	if v79 then
		
		local v80
		
		if game.Players.LocalPlayer.PlayerStats.TypeRun.Value == "Hotel" then
			
			v80 = Color3.fromRGB(67, 51, 56);
			
		elseif game.Players.LocalPlayer.PlayerStats.TypeRun.Value == "Hunt" then
			
			v80 = Color3.fromRGB(27, 20, 11);
		
		elseif game.Players.LocalPlayer.PlayerStats.TypeRun.Value == "HuntExit" then

			v80 = Color3.fromRGB(67, 51, 56);

		end
		
		local v81 = v79:GetAttribute("Ambient");
		if v81 and type(v81) == "userdata" then
			v80 = v81;
		end;
		l__TweenService__7:Create(game.Lighting, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Ambient = v80
		}):Play();
		l__TweenService__7:Create(game.Lighting, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			FogColor = v80
		}):Play();
	end;
end);
local l__Shopkeeper__82 = workspace:FindFirstChild("Shopkeeper", true);
if l__Shopkeeper__82 then
	require(script.Shopkeeper).run(l__Shopkeeper__82.Parent);
end;
--[[local v83, v84, v85 = ipairs(workspace.CurrentRooms:GetDescendants());
while true do
	v83(v84, v85);
	if not v83 then
		break;
	end;
	v85 = v83;
	if v84:IsA("BasePart") and v84:GetAttribute("WindShake") == true then
		v3:AddObjectShake(v84);
	end;
end;]]

for v83, v84 in ipairs(workspace.CurrentRooms:GetDescendants()) do
	if v84:IsA("BasePart") and v84:GetAttribute("WindShake") == true then
		v3:AddObjectShake(v84);
	end;
end;

