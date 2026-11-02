

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_CollectionService_0 = game:GetService("CollectionService");
local v3 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v4 = require(l_ReplicatedStorage_0.Packages.Observers);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
return {
    Start = function(_)
        local v7 = false;
        v3:WaitAndCall(l_LocalPlayer_0, function(v8)
            v8:OnChanged("Settings.VFX", function(v9)
                v7 = v9;
                for _, v11 in (l_CollectionService_0:GetTagged("VFX")) do
                    v11.Enabled = v9;
                end;
            end, true);
        end);
        v4.observeTag("VFX", function(v12)
            v12.Enabled = v7;
            return nil;
        end);
    end
};