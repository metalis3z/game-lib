local v1 = {};
local v2 = TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false);
local u1 = {
	In = false, 
	Out = true
};
local function u2(p1)
	for v3, v4 in pairs(p1) do
		v4:Play();
	end;
end;
local l__TweenService__3 = game:GetService("TweenService");
local u4 = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false);
local u5 = {
	In = 0, 
	Out = 1
};
function v1.PlayCameraFade(p2)
	local l__Fade__5 = game.Players.LocalPlayer.PlayerGui:WaitForChild("SpawnFade").Fade;
	l__Fade__5.BackgroundColor3 = Color3.new(0, 0, 0);
	l__Fade__5.Visible = true
	l__Fade__5.Parent.Enabled = true
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, u1[p2]);
	u2({ l__TweenService__3:Create(l__Fade__5, u4, {
		BackgroundTransparency = u5[p2]
	}) });
end;
function v1.DeathFlash()
	local l__Fade__6 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("SpawnFade").Fade;
	l__Fade__6.Visible = true
	l__Fade__6.BackgroundTransparency = 0;
	l__Fade__6.BackgroundColor3 = Color3.new(1, 1, 1);
	wait(0.1);
	l__Fade__6.BackgroundColor3 = Color3.new(0, 0, 0);
end;
local function u6(p3)
	local l__Fade__7 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("SpawnFade").Fade;
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, u1[p3]);
	u2({ l__TweenService__3:Create(l__Fade__7, u4, {
		BackgroundTransparency = u5[p3]
	}) });
end;
function v1.FadeToWinner(p4)
	if p4 ~= nil then
		v1.PlayCameraFade("In");
		wait(0.3);
		game.Workspace.CurrentCamera.CameraSubject = game.Players[p4].Character.Humanoid;
		v1.PlayCameraFade("Out");
		wait(0.4);
	end
end;
function v1.SpawnFade()
	local l__Fade__8 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("SpawnFade"):WaitForChild('Fade');
	l__Fade__8.BackgroundTransparency = 0;
	l__Fade__8.BackgroundColor3 = Color3.new(0, 0, 0);
	u6("Out");
	v1.PlayCameraFade("Out");
	game.Workspace.CurrentCamera.CameraType = "Custom";
	game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
end;
function v1.CameraFadeToLocalPlayer()
	if game.Players.LocalPlayer.Character ~= nil then
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
	end;
	v1.PlayCameraFade("Out");
end;


return v1;
