local l__LocalPlayer__2 = game.Players.LocalPlayer;
local u1 = l__LocalPlayer__2.Character or l__LocalPlayer__2.CharacterAdded:Wait();
local Sound = workspace.SoundSetup.NightmareBG
local ColorCorrection = game.Lighting:FindFirstChild("Nightmare")
game:GetService("RunService").RenderStepped:connect(function()
		if u1:FindFirstChild("Humanoid")  and Sound.Volume > 0 and u1.Humanoid.Health > 0 then
		--workspace.Camera.FieldOfView = 80 - l__Heartbeat__2.PlaybackLoudness * 0.0075 * l__Heartbeat__2.Volume;
			workspace.Camera.CFrame = workspace.Camera.CFrame * CFrame.Angles(0, 0, math.rad(math.random(-Sound.PlaybackLoudness * Sound.Volume, Sound.PlaybackLoudness * Sound.Volume) * 0.003)) + Vector3.new(math.rad(math.random(-Sound.PlaybackLoudness * 0.007 * Sound.Volume, Sound.PlaybackLoudness * 0.007 * Sound.Volume) * 0.007), math.rad(math.random(-Sound.PlaybackLoudness * 0.007 * Sound.Volume, Sound.PlaybackLoudness * 0.007 * Sound.Volume) * 0.007), math.rad(math.random(-Sound.PlaybackLoudness * 0.007 * Sound.Volume, Sound.PlaybackLoudness * 0.007 * Sound.Volume) * 0.007));
			ColorCorrection.Brightness = 0 + Sound.PlaybackLoudness * 5E-13 * Sound.Volume;
		ColorCorrection.TintColor = Color3.new(1 + Sound.PlaybackLoudness * 0.0007 * Sound.Volume, 1 + Sound.PlaybackLoudness * 0.0007 * Sound.Volume, 1 + Sound.PlaybackLoudness * 0.0007 * Sound.Volume);
		return;
	end;
	if  (not (not u1:FindFirstChild("Humanoid")) and u1.Humanoid.Health > 0 or not u1:FindFirstChild("Humanoid")) then
		ColorCorrection.Contrast = 0;
		ColorCorrection.Brightness = 0;
		ColorCorrection.TintColor = Color3.new(1, 1, 1);
	end;
end);
