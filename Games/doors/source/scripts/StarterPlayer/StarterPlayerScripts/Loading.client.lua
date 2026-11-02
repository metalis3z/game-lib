local l__LoadingUINew__1 = game:GetService("ReplicatedFirst"):WaitForChild("LoadingUINew");
l__LoadingUINew__1.Parent = game.Players.LocalPlayer.PlayerGui;
repeat wait(0.5) until game.Players.LocalPlayer.Character
repeat wait(0.5) until game.Players.LocalPlayer.Character.PrimaryPart.Anchored == false
game:GetService("TweenService"):Create(l__LoadingUINew__1:WaitForChild("TextLabel"), TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
	BackgroundTransparency = 1, 
	TextTransparency = 1
}):Play();
wait(2);
l__LoadingUINew__1.Enabled = false;

local d = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)

if game.Players.LocalPlayer:FindFirstChild("PlayerStats").Knobs.Value < 1 then
	return
else
	if game.Players.LocalPlayer.PlayerStats.TypeRun.Value == "Hotel" then
		game.Players.LocalPlayer.PlayerGui.MainUI.ItemShop.Visible = true
		d.freemouse = true
	end
end