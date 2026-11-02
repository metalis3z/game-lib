-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("CanChangeServerSettings"):InvokeServer();
local l_PrivateServer_0 = script.Parent:WaitForChild("Main"):WaitForChild("PrivateServer");
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
l_PrivateServer_0.Visible = v0;
l_PrivateServer_0:WaitForChild("Button").Activated:Connect(function()
    l_WindowService_0:ToggleFrame("PrivateServer");
end);