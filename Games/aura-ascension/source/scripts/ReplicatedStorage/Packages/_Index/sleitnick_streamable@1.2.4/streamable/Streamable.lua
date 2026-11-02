-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script.Parent.Parent.Trove);
local v1 = require(script.Parent.Parent.Signal);
local v2 = {};
v2.__index = v2;
v2.new = function(v3, v4) --[[ Line: 96 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy), v0 (copy), v1 (copy)
    local v5 = {};
    setmetatable(v5, v2);
    v5._trove = v0.new();
    v5._shown = v5._trove:Construct(v1);
    v5._shownTrove = v0.new();
    v5._trove:Add(v5._shownTrove);
    v5.Instance = v3:FindFirstChild(v4);
    local function v7() --[[ Line: 107 ]] --[[ Name: OnInstanceSet ]]
        -- upvalues: v5 (copy)
        local l_Instance_0 = v5.Instance;
        if typeof(l_Instance_0) == "Instance" then
            v5._shown:Fire(l_Instance_0, v5._shownTrove);
            v5._shownTrove:Connect(l_Instance_0:GetPropertyChangedSignal("Parent"), function() --[[ Line: 111 ]]
                -- upvalues: l_Instance_0 (copy), v5 (ref)
                if not l_Instance_0.Parent then
                    v5._shownTrove:Clean();
                end;
            end);
            v5._shownTrove:Add(function() --[[ Line: 116 ]]
                -- upvalues: v5 (ref), l_Instance_0 (copy)
                if v5.Instance == l_Instance_0 then
                    v5.Instance = nil;
                end;
            end);
        end;
    end;
    v5._trove:Connect(v3.ChildAdded, function(v8) --[[ Line: 124 ]] --[[ Name: OnChildAdded ]]
        -- upvalues: v4 (copy), v5 (copy), v7 (copy)
        if v8.Name == v4 and not v5.Instance then
            v5.Instance = v8;
            v7();
        end;
    end);
    if v5.Instance then
        v7();
    end;
    return v5;
end;
v2.primary = function(v9) --[[ Line: 146 ]] --[[ Name: primary ]]
    -- upvalues: v2 (copy), v0 (copy), v1 (copy)
    local v10 = {};
    setmetatable(v10, v2);
    v10._trove = v0.new();
    v10._shown = v10._trove:Construct(v1);
    v10._shownTrove = v0.new();
    v10._trove:Add(v10._shownTrove);
    v10.Instance = v9.PrimaryPart;
    v10._trove:Connect(v9:GetPropertyChangedSignal("PrimaryPart"), function() --[[ Line: 157 ]] --[[ Name: OnPrimaryPartChanged ]]
        -- upvalues: v9 (copy), v10 (copy)
        local l_PrimaryPart_0 = v9.PrimaryPart;
        v10._shownTrove:Clean();
        v10.Instance = l_PrimaryPart_0;
        if l_PrimaryPart_0 then
            v10._shown:Fire(l_PrimaryPart_0, v10._shownTrove);
        end;
    end);
    if v10.Instance then
        local l_PrimaryPart_1 = v9.PrimaryPart;
        v10._shownTrove:Clean();
        v10.Instance = l_PrimaryPart_1;
        if l_PrimaryPart_1 then
            v10._shown:Fire(l_PrimaryPart_1, v10._shownTrove);
        end;
    end;
    return v10;
end;
v2.Observe = function(v13, v14) --[[ Line: 184 ]] --[[ Name: Observe ]]
    if v13.Instance then
        task.spawn(v14, v13.Instance, v13._shownTrove);
    end;
    return v13._shown:Connect(v14);
end;
v2.Destroy = function(v15) --[[ Line: 196 ]] --[[ Name: Destroy ]]
    v15._trove:Destroy();
end;
return v2;