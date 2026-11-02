local l_CollectionService_0 = game:GetService("CollectionService");
local v1 = require(script.SwimController);
task.wait(2);
for _, v3 in pairs(l_CollectionService_0:GetTagged("Water")) do
    v1:AddZone(v3);
end;
l_CollectionService_0:GetInstanceAddedSignal("Water"):Connect(function(v4)
    v1:AddZone(v4);
end);
v1:Start();