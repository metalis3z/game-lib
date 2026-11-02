local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Packages.Gradients);
local v2 = require(l_ReplicatedStorage_0.Packages.Trove);
local v3 = {
    "rainbow", 
    "og", 
    "yellowred", 
    "zebra", 
    "greenred", 
    "slowgreenred"
};
local function v11(v4) --[[ Line: 23 ]] --[[ Name: transformRichText ]]
    -- upvalues: v3 (copy)
    local v5 = {};
    for _, v7 in v3 do
        local v8 = ("<%*>(.-)</%*>"):format(v7, v7);
        local v9, v10 = string.gsub(v4, v8, "<stroke transparency=\"0\"><font transparency=\"0\">%1</font></stroke>");
        if v10 > 0 then
            v4 = string.gsub(v4, v8, "<stroke transparency=\"1\"><font transparency=\"1\">%1</font></stroke>");
            table.insert(v5, {
                tag = v7, 
                text = v9
            });
        end;
    end;
    return v4, v5;
end;
local v12 = {};
local v13 = {};
v12.apply = function(v14, v15, v16) --[[ Line: 49 ]] --[[ Name: apply ]]
    -- upvalues: v12 (copy), v2 (copy), v13 (copy), v11 (copy), v1 (copy)
    v12.cleanup(v14);
    local v17 = v2.new();
    v13[v14] = v17;
    v17:Add(function() --[[ Line: 54 ]]
        -- upvalues: v13 (ref), v14 (copy)
        v13[v14] = nil;
    end);
    v14.RichText = true;
    local v18, v19 = v11(v15);
    v14.Text = v18;
    for _, v21 in v19 do
        local v22 = v17:Clone(v14);
        v22:ClearAllChildren();
        v22.Text = ("<stroke transparency=\"1\"><font transparency=\"1\">%*</font></stroke>"):format(v21.text);
        v22.Size = UDim2.fromScale(1, 1);
        v22.Position = UDim2.fromScale(0.5, 0.5);
        v22.AnchorPoint = Vector2.new(0.5, 0.5);
        v22.Parent = v14;
        if v21.tag == "rainbow" then
            v17:Add(v1.apply(v22, "Rainbow"));
        elseif v21.tag == "zebra" then
            v17:Add(v1.apply(v22, "Zebra"));
        elseif v21.tag == "og" then
            v17:Add(v1.apply(v22, "OG"));
        elseif v21.tag == "yellowred" then
            v17:Add(v1.apply(v22, "YellowRed"));
        elseif v21.tag == "greenred" then
            v17:Add(v1.apply(v22, "GreenRed"));
        elseif v21.tag == "slowgreenred" then
            v17:Add(v1.apply(v22, "SlowGreenRed"));
        end;
    end;
    if v16 and v16.attachToInstance then
        v17:AttachToInstance(v14);
    end;
    return v17;
end;
v12.cleanup = function(v23) --[[ Line: 94 ]] --[[ Name: cleanup ]]
    -- upvalues: v13 (copy)
    if v13[v23] then
        v13[v23]:Destroy();
    end;
end;
return v12;
