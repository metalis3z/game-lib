wait(0.5);
local v1 = workspace:WaitForChild(game:service("Players").LocalPlayer.Name);
local l__Parent__2 = script.Parent;
local l__CurrentCamera__3 = game.Workspace.CurrentCamera;
local l__LocalPlayer__4 = game.Players.LocalPlayer;
local u1 = nil;
local u2 = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(script.Parent["Animation 2"]);
local u3 = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(script.Parent.equip);
l__Parent__2.Equipped:connect(function(p1)
	u1 = p1;
	p1.Icon = "http://www.roblox.com/asset/?id=1386173173";
	if u2 and not u2.IsPlaying then
		u2:Play();
	end;
	u3:Play();
end);
l__Parent__2.Unequipped:Connect(function()
	if u2 and u2.IsPlaying then
		u2:Stop();
	end;
	if u3 and u3.IsPlaying then
		u3:Stop();
	end;
	u1 = nil;
end);