-- / kingerman88 / --

-- / Services / --

local Workspace = game:GetService('Workspace');
local Players = game:GetService('Players');
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local TweenService = game:GetService('TweenService');
local MarketplaceService = game:GetService('MarketplaceService');

-- / Modules / --

local Generics = require(ReplicatedStorage.Modules.Generics);

-- / Variables / --

local Remotes = ReplicatedStorage.Remotes;
local WheelRemote = Remotes.Wheel;

local player = Players.LocalPlayer;

local root = script.Parent;

-- / Functions / --

-- / WheelSpin.lua / --

local button = script.Parent.Parent.Parent.SpinButton;

button.MouseButton1Click:Connect(function()
	require(script.Parent.Parent.Parent.UICore)(script.Parent);
end)

local wheelItems = WheelRemote:InvokeServer();

Generics.Bind(player:GetAttributeChangedSignal("WheelSpins"), function()
	root.Spin1.Amount.Text = "x".. player:GetAttribute("WheelSpins")
	button.Notification.Visible = player:GetAttribute("WheelSpins") > 0
	button.Notification.Inner.NotificationValue.Text = player:GetAttribute("WheelSpins");
end, player:GetAttribute("WheelSpins"))

Generics.Bind(player:GetAttributeChangedSignal("WheelCountdown"), function()
	if player:GetAttribute("WheelSpins") <= 0 then
		button.TimeLabel.Text = Generics.toMMSS(player:GetAttribute("WheelCountdown"));
	else
		button.TimeLabel.Text = "Spin!"
	end
	button.Notification.Visible = player:GetAttribute("WheelSpins") > 0
	button.Notification.Inner.NotificationValue.Text = player:GetAttribute("WheelSpins");
	root.Spin1.NextSpin.Text = "+1 Spin in " .. Generics.toMMSS(player:GetAttribute("WheelCountdown"));
	root.Spin1.Amount.Text = "x".. player:GetAttribute("WheelSpins")
	
end, player:GetAttribute("WheelCountdown"))

local rewards = WheelRemote:InvokeServer("Get");

for i, reward in rewards do
	xpcall(function()
		script.Parent.Main.SpinFrame[tostring(i)].Amount.Text = "x"..reward.Amount;
		script.Parent.Main.SpinFrame[tostring(i)].Percent.Text = string.format("%.2f%%", reward.Percent);
		script.Parent.Main.SpinFrame[tostring(i)].Icon.Image = reward.Icon;
		script.Parent.Main.SpinFrame[tostring(i)].ImageColor3 = reward.Color;
	end, function(e)
		warn(e)
	end)
end

local debounce = false;
script.Parent.Spin1.MouseButton1Click:Connect(function()
	if debounce then return end;
	debounce = true;
	task.delay(5, function()
		debounce = false;
	end)
	local index = WheelRemote:InvokeServer("Spin");
	if not index then return end;
	script.Parent.Main.SpinFrame.Rotation = 0;
	TweenService:Create(script.Parent.Main.SpinFrame, TweenInfo.new(5), {Rotation = 360 * 10 + (360 * index / 5) - 36 - 72 + math.random(-35, 35)}):Play();
	wait(5);
	
end)

repeat
	wait()
until require(ReplicatedStorage.GameConfig.Monetization).DoneLoading

script.Parent.Spin10.Contents.Title.Text = require(ReplicatedStorage.GameConfig.Monetization).DevProducts.Spin10.Cost;
script.Parent.Spin10.MouseButton1Click:Connect(function()
	MarketplaceService:PromptProductPurchase(player, require(ReplicatedStorage.GameConfig.Monetization).DevProducts.Spin10.Id);
end)
script.Parent.Spin100.Contents.Title.Text = require(ReplicatedStorage.GameConfig.Monetization).DevProducts.Spin100.Cost;
script.Parent.Spin100.MouseButton1Click:Connect(function()
	MarketplaceService:PromptProductPurchase(player, require(ReplicatedStorage.GameConfig.Monetization).DevProducts.Spin100.Id);
end)
--player:SetAttribute("WheelSpins", 0);
--player:SetAttribute("WheelCountdown", 120);