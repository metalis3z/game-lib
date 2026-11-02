
local v0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("CanChangeServerSettings"):InvokeServer();
local l_ServerSettings_0 = script.Parent.ServerSettings
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
l_ServerSettings_0.Visible = v0;
l_ServerSettings_0:WaitForChild("Button").Activated:Connect(function() --[[ Line: 8 ]]
    l_WindowService_0:ToggleFrame("PrivateServer");
end);