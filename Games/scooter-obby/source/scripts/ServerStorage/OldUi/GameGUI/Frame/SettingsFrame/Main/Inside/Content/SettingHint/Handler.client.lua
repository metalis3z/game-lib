-- Decompiled with the Synapse X Luau decompiler.

local l__Parent__1 = script.Parent;
local l__SettingHint__2 = game:GetService("ReplicatedStorage"):WaitForChild("Client"):WaitForChild("Interface"):WaitForChild("SettingHint");
l__SettingHint__2.Changed:Connect(function()
	l__Parent__1.Text = l__SettingHint__2.Value and "";
end);
l__Parent__1.Text = l__SettingHint__2.Value and "";
