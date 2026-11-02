-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local v2 = l__LocalPlayer__1.Character or l__LocalPlayer__1.CharacterAdded:Wait();
local l__HumanoidRootPart__3 = v2:WaitForChild("HumanoidRootPart");
local l__Humanoid__4 = v2:WaitForChild("Humanoid");
local v5 = l__Humanoid__4:LoadAnimation(script:WaitForChild("TallGate Anim"));
local l__UserInputService__6 = game:GetService("UserInputService");
local v7 = true;
while game:GetService("RunService").RenderStepped:Wait() do
	local v8 = workspace:FindPartOnRay(Ray.new(l__HumanoidRootPart__3.Position, l__HumanoidRootPart__3.CFrame.LookVector * 7 + l__HumanoidRootPart__3.CFrame.UpVector * -5), v2);
	if v8 and l__UserInputService__6:IsKeyDown(Enum.KeyCode.Space) and v7 and v8.Name == "TallGate" and l__Humanoid__4.FloorMaterial ~= Enum.Material.Air then
		v2.HumanoidRootPart.Anchored = true;
		v5:Play();
		game:GetService("TweenService"):Create(v2.HumanoidRootPart, TweenInfo.new(1), {
			CFrame = v2.HumanoidRootPart.CFrame * CFrame.new(0, 0.4, -4.2)
		}):Play();
		wait(2);
		v7 = true;
		v2.HumanoidRootPart.Anchored = false;
	end;
end;
