local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local Players = game:GetService("Players");
local Packages = ReplicatedStorage:WaitForChild("Packages");
local Synchronizer = require(Packages.Synchronizer);
local LocalPlayer = Players.LocalPlayer;
local _ = nil;
return {
    Load = function(_)
		Synchronizer:WaitAndCall(LocalPlayer, function(v8)
            _ = v8;
			ReplicatedFirst:SetAttribute("DataLoaded", true);
        end);
    end
};