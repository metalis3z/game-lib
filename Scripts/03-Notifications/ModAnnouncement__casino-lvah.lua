-- Reference copy for study. Game: LvaH Casino (casino-lvah)
-- Original: StarterGui/Game/Announcement/Announcer.client.luau  (client, 31 lines)
-- Categories: notifications 15.8
-- What it does: Simple moderator announcement banner: clone template, fade in title/text/name over 2s, hold 6s, fade out.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local CommandAction = ReplicatedStorage.Remotes.CommandAction;
local template = script.Backing;
local transition = TweenInfo.new(2, Enum.EasingStyle.Linear);

CommandAction.OnClientEvent:Connect(function(action, data)
	if action == "Announcement" then
		local announcement = script.Backing:Clone();
		announcement.ModText.Text = data[1];
		announcement.ModName.Text = data[2];
		announcement.Parent = script.Parent;

		local tween = TweenService:Create(announcement, TweenInfo.new(2), {BackgroundTransparency = 0.2})
		TweenService:Create(announcement.Title, TweenInfo.new(2), {TextTransparency = 0}):Play();
		TweenService:Create(announcement.ModText, TweenInfo.new(2), {TextTransparency = 0}):Play();
		TweenService:Create(announcement.ModName, TweenInfo.new(2), {TextTransparency = 0}):Play();
		tween:Play();
		tween.Completed:Wait();

		task.wait(6);

		local tween = TweenService:Create(announcement, TweenInfo.new(2), {BackgroundTransparency = 1})
		TweenService:Create(announcement.Title, TweenInfo.new(2), {TextTransparency = 1}):Play();
		TweenService:Create(announcement.ModText, TweenInfo.new(2), {TextTransparency = 1}):Play();
		TweenService:Create(announcement.ModName, TweenInfo.new(2), {TextTransparency = 1}):Play();
		tween:Play();
		tween.Completed:Wait();
		announcement:Destroy();
	end
end)