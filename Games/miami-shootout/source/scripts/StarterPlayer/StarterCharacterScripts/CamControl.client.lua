-- Decompiled with the Synapse X Luau decompiler.

local l__CurrentCamera__1 = workspace.CurrentCamera;
local l__RunService__2 = game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__LocalPlayer__4 = game.Players.LocalPlayer;
local v5 = l__LocalPlayer__4.Character or l__LocalPlayer__4.CharacterAdded:Wait();
local l__HumanoidRootPart__6 = v5:WaitForChild("HumanoidRootPart");
local l__UpperTorso__7 = v5:WaitForChild("UpperTorso");
local v8 = 0;
local v9 = 0;
local v10 = 0;
local l__UserInputService__1 = game:GetService("UserInputService");
function isTyping()
	return l__UserInputService__1:GetFocusedTextBox();
end;
while true do
	if tick() - 0 > 0.01 and not isTyping() then
		local v11 = tick();
		if l__UserInputService__1:IsKeyDown(Enum.KeyCode.A) then
			v8 = v8 + 0.01;
		end;
		if l__UserInputService__1:IsKeyDown(Enum.KeyCode.D) then
			v8 = v8 - 0.01;
		end;
		local v12 = math.clamp(v8, -0.03, 0.03);
		if l__UserInputService__1:IsKeyDown(Enum.KeyCode.W) then
			v9 = v9 - 0.01;
		end;
		if l__UserInputService__1:IsKeyDown(Enum.KeyCode.S) then
			v9 = v9 + 0.01;
		end;
		v9 = math.clamp(v9, -0.03, 0.03);
	end;
	if tick() - v10 > 0.01 then
		v10 = tick();
		v8 = v8 * 0.9;
		v9 = v9 * 0.9;
	end;
	l__RunService__2.RenderStepped:Wait();
	l__CurrentCamera__1.CFrame = l__CurrentCamera__1.CFrame * CFrame.Angles(0, 0, v8);
end;
