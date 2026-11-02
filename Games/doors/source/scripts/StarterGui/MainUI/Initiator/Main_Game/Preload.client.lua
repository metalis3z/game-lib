-- Decompiled with the Synapse X Luau decompiler.

local l__ContentProvider__1 = game:GetService("ContentProvider");
local l__PreloadAnimations__2 = game:GetService("ReplicatedStorage"):WaitForChild("PreloadAnimations");
local function u3()
	local v1 = tick();
	l__ContentProvider__1:PreloadAsync(l__PreloadAnimations__2:GetChildren());
	for v2, v3 in pairs(l__PreloadAnimations__2:GetChildren()) do
		delay(5, function()
			pcall(function()
				if v3:IsA("Animation") then
					local v4 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(v3);
					v4:Play(1, 0, 0);
					v4:Stop();
					task.wait();
					v4:Stop();
				end;
			end);
		end);
	end;
end;
l__PreloadAnimations__2.ChildAdded:Connect(function()
	u3();
end);
u3();
