

local _ = game:GetService("Players");
local _ = game:GetService("RunService");
local _ = game:GetService("CollectionService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = l_ReplicatedStorage_0:WaitForChild("Models").ToolsExtras;
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v6 = require(l_Packages_0.Net);
local _ = require(l_Packages_0.Debounce);
local l_Parent_0 = script.Parent;
local _ = l_Parent_0.Parent.Parent;
l_Parent_0.Activated:Connect(function()
    v6:RemoteEvent("UseItem"):FireServer();
end);