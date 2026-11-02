-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local players = game:GetService("Players");
local _ = game:GetService("StarterGui");
local _ = game:GetService("ReplicatedStorage");
local replicatedStorage = game:GetService("ReplicatedStorage");
local packages = replicatedStorage:WaitForChild("Packages");
local net = require(packages.Net);
local observers = require(replicatedStorage.Packages.Observers);
local backpackController = require(replicatedStorage.Controllers.BackpackController);
local localPlayer = players.LocalPlayer;
local playerGui = localPlayer.PlayerGui;
local v10 = nil;
local highlight = Instance.new("Highlight");
highlight.Name = "MainHighlight";
highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
highlight.FillColor = Color3.fromRGB(255, 0, 0);
highlight.FillTransparency = 0.5;
highlight.OutlineColor = Color3.fromRGB(155, 0, 0);
highlight.OutlineTransparency = 0.8;
highlight.Parent = workspace;
highlight.Adornee = script;
local v12 = {};
local v13 = {};
local function v21(v14)
	local l_v14_Attribute_0 = v14:GetAttribute("CurrentSlot");
	local v16 = tonumber(v14:GetAttribute("CooldownTime") or 0) or 0;
	if not v10 or not l_v14_Attribute_0 then
		return;
	else
		local l_v10_FirstChild_0 = v10:FindFirstChild(l_v14_Attribute_0);
		if not l_v10_FirstChild_0 then
			return;
		else
			local icon = l_v10_FirstChild_0:FindFirstChild("Icon");
			if not icon then
				return;
			else
				local v19 = v16 > 0;
				local cooldownTextLabel = icon:FindFirstChild("CooldownTextLabel");
				if cooldownTextLabel then
					cooldownTextLabel.Text = string.format("%0.1f", v16);
					cooldownTextLabel.Visible = v19;
				end;
				icon.ImageColor3 = v19 and Color3.fromRGB(90, 90, 90) or Color3.fromRGB(255, 255, 255);
				return;
			end;
		end;
	end;
end;
local function onAttributeChanged(v22)
	v22:GetAttributeChangedSignal("CooldownTime"):Connect(function()
		v21(v22);
	end);
	v22:GetAttributeChangedSignal("CurrentSlot"):Connect(function()
		v21(v22);
	end);
	task.spawn(v21, v22);
end;
v13.Load = function(_)
	for _, v26 in script:GetChildren() do
		if v26:IsA("ModuleScript") then
			local l_status_0, l_result_0 = pcall(require, v26);
			if l_status_0 and l_result_0 and l_result_0.Start then
				l_result_0:Start();
			end;
		end;
	end;
end;
v13.Start = function(_)
	local function onAttributeChanged2()
		local v30 = not localPlayer:GetAttribute("BlockTools") and not localPlayer:GetAttribute("Stealing") and not localPlayer:GetAttribute("CartSeated") and not localPlayer:GetAttribute("TrainSeated") and not localPlayer:GetAttribute("SleighSeated") and not replicatedStorage:GetAttribute("InTrainTravelCutscene");
		backpackController:SetEnabled("BlockTools", v30);
	end;
	replicatedStorage:GetAttributeChangedSignal("InTrainTravelCutscene"):Connect(onAttributeChanged2);
	localPlayer:GetAttributeChangedSignal("SleighSeated"):Connect(onAttributeChanged2);
	localPlayer:GetAttributeChangedSignal("TrainSeated"):Connect(onAttributeChanged2);
	localPlayer:GetAttributeChangedSignal("CartSeated"):Connect(onAttributeChanged2);
	localPlayer:GetAttributeChangedSignal("BlockTools"):Connect(onAttributeChanged2);
	localPlayer:GetAttributeChangedSignal("Stealing"):Connect(onAttributeChanged2);
	task.spawn(onAttributeChanged2);
	v10 = playerGui:WaitForChild("BackpackGui", 120):WaitForChild("Backpack"):WaitForChild("Hotbar");
	observers.observeCharacter(localPlayer, function(v32, _)
		local backpack = v32:WaitForChild("Backpack");
		if not backpack then
			return nil;
		else
			for _, v36 in backpack:GetChildren() do
				if v36:IsA("Tool") then
					task.spawn(onAttributeChanged, v36);
				end;
			end;
			local v38 = backpack.ChildAdded:Connect(function(v37)
				if v37:IsA("Tool") then
					onAttributeChanged(v37);
				end;
			end);
			return function()
				v38:Disconnect();
			end;
		end;
	end);
	net:RemoteEvent("Tools/Cooldown").OnClientEvent:Connect(function(v39, v40)
		local v41 = os.clock();
		local v42 = v12[v39.Name];
		if v42 and coroutine.status(v42) ~= "suspended" then
			task.cancel(v42);
			v39:SetAttribute("CooldownTime", nil);
			v12[v39.Name] = nil;
		end;
		local v45 = task.spawn(function()
			while true do
				local v43 = os.clock() - v41;
				local v44 = v40 - v43;
				if v44 > 0 then
					v39:SetAttribute("CooldownTime", v44);
					task.wait(0.05);
				else
					break;
				end;
			end;
			v39:SetAttribute("CooldownTime", nil);
			v12[v39.Name] = nil;
		end);
		v12[v39.Name] = v45;
	end);
end;
return v13;