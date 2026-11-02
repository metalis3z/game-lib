

--!native
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = require(l_ReplicatedStorage_0.UserGenerated.Concurrency.Bindable);
local _ = require(l_ReplicatedStorage_0.UserGenerated.Lang.Asserts);
local v3 = {
    UpdateRemote = script:WaitForChild("Update"), 
    NullValue = script
};
return table.freeze(v3);