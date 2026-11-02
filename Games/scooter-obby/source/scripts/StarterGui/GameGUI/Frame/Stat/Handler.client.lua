-- Decompiled with the Synapse X Luau decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Stats__2 = l__ReplicatedStorage__1:WaitForChild("ActiveData"):WaitForChild(game:GetService("Players").LocalPlayer.Name):WaitForChild("Stats");
local l__Parent__3 = script.Parent;
local l__Shop__4 = script.Parent.Parent.OpenableUi.Shop;
local u1 = require(l__ReplicatedStorage__1:WaitForChild("Shared"):WaitForChild("Modules"):WaitForChild("Formatter"));
local l__Inside__2 = l__Shop__4.Main.Inside.Content.RightSide.Inside;
local function u3(p1)
	for v5, v6 in pairs(l__Inside__2:GetChildren()) do
		if v6:IsA("Frame") or v6:IsA("ScrollingFrame") then
			if v6.Name == p1 then
				v6.Visible = true;
			else
				v6.Visible = false;
			end;
		end;
	end;
end;
local u4 = require(script.Parent.Parent.Client.Modules.InterfaceOpener);
l__Parent__3.Coins.Top.Add.Back.Button.Activated:Connect(function()
	u3("Currency");
	if not u4.OpenedInterfaces[l__Shop__4.Main] then
		u4.OpenInterface(l__Shop__4.Main, true);
	end;
end);
l__Parent__3.Skips.Top.Add.Back.Button.Activated:Connect(function()
	u3("Skips");
	if not u4.OpenedInterfaces[l__Shop__4.Main] then
		u4.OpenInterface(l__Shop__4.Main, true);
	end;
end);
for v7, v8 in pairs(l__Parent__3:GetChildren()) do
	local v9 = l__Stats__2:FindFirstChild(v8.Name);
	if v9 and v8:IsA("Frame") then
		local l__Label__5 = v8.Top.Label;
		v9.Changed:Connect(function()
			l__Label__5.Text = u1.AddCommas(v9.Value);
		end);
		l__Label__5.Text = u1.AddCommas(v9.Value);
	end;
end;
