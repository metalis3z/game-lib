-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = {
    WindPower = "number", 
    WindSpeed = "number", 
    WindDirection = "Vector3", 
    PivotOffset = "CFrame"
};
v0.new = function(v2)
    local v3 = {};
    local l_v2_Attribute_0 = v2:GetAttribute("WindPower");
    local l_v2_Attribute_1 = v2:GetAttribute("WindSpeed");
    local l_v2_Attribute_2 = v2:GetAttribute("WindDirection");
    v3.WindPower = if typeof(l_v2_Attribute_0) == v1.WindPower then l_v2_Attribute_0 else nil;
    v3.WindSpeed = if typeof(l_v2_Attribute_1) == v1.WindSpeed then l_v2_Attribute_1 else nil;
    v3.WindDirection = if typeof(l_v2_Attribute_2) == v1.WindDirection then if l_v2_Attribute_2.Magnitude > 0 then l_v2_Attribute_2.Unit else Vector3.zero else nil;
    v3.PivotOffset = if v2:IsA("BasePart") then v2.PivotOffset else nil;
    v3.PivotOffsetInverse = if typeof(v3.PivotOffset) == "CFrame" then v3.PivotOffset:Inverse() else nil;
    local v7 = v2:GetAttributeChangedSignal("WindPower"):Connect(function()
        l_v2_Attribute_0 = v2:GetAttribute("WindPower");
        v3.WindPower = if typeof(l_v2_Attribute_0) == v1.WindPower then l_v2_Attribute_0 else nil;
    end);
    local v8 = v2:GetAttributeChangedSignal("WindSpeed"):Connect(function()
        l_v2_Attribute_1 = v2:GetAttribute("WindSpeed");
        v3.WindSpeed = if typeof(l_v2_Attribute_1) == v1.WindSpeed then l_v2_Attribute_1 else nil;
    end);
    local v9 = v2:GetAttributeChangedSignal("WindDirection"):Connect(function()
        l_v2_Attribute_2 = v2:GetAttribute("WindDirection");
        v3.WindDirection = if typeof(l_v2_Attribute_2) == v1.WindDirection then if l_v2_Attribute_2.Magnitude > 0 then l_v2_Attribute_2.Unit else Vector3.zero else nil;
    end);
    local v10 = nil;
    if v2:IsA("BasePart") then
        v10 = v2:GetPropertyChangedSignal("PivotOffset"):Connect(function()
            v3.PivotOffset = v2.PivotOffset;
            v3.PivotOffsetInverse = v3.PivotOffset:Inverse();
        end);
    end;
    v3.Destroy = function(_)
        v7:Disconnect();
        v8:Disconnect();
        v9:Disconnect();
        if v10 then
            v10:Disconnect();
        end;
        table.clear(v3);
    end;
    return v3;
end;
return v0;