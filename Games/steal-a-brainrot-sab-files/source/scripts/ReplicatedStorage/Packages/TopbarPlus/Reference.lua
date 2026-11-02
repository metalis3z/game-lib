

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = {
    objectName = "TopbarPlusReference"
};
v1.addToReplicatedStorage = function()
    if l_ReplicatedStorage_0:FindFirstChild(v1.objectName) then
        return false;
    else
        local l_ObjectValue_0 = Instance.new("ObjectValue");
        l_ObjectValue_0.Name = v1.objectName;
        l_ObjectValue_0.Value = script.Parent;
        l_ObjectValue_0.Parent = l_ReplicatedStorage_0;
        return l_ObjectValue_0;
    end;
end;
v1.getObject = function()
    local l_l_ReplicatedStorage_0_FirstChild_0 = l_ReplicatedStorage_0:FindFirstChild(v1.objectName);
    if l_l_ReplicatedStorage_0_FirstChild_0 then
        return l_l_ReplicatedStorage_0_FirstChild_0;
    else
        return false;
    end;
end;
return v1;