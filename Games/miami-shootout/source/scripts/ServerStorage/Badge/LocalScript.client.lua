
while true do
	wait();
	if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
		break;
	end;
end;
local v1 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.Idle);
local u1 = false;
local u2 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.FlipA);
local u3 = false;
local u4 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.FlipAD);
script.Parent.Activated:Connect(function()
	if u1 == false then
		u2:Play(0.2);
		u1 = true;
		wait(0.1);
		if u3 == true then
			u4:Play(0.1);
		end;
	end;
end);
script.Parent.Equipped:Connect(function()
	u3 = true;
	if not v1.IsPlaying then
		v1:Play(0.2);
	end;
end);
script.Parent.Unequipped:Connect(function()
	u1 = false;
	u3 = false;
	if v1.IsPlaying then
		v1:Stop(0.2);
	end;
	if u2.IsPlaying then
		u2:Stop(0.2);
	end;
	if u4.IsPlaying then
		u4:Stop();
	end;
end);

