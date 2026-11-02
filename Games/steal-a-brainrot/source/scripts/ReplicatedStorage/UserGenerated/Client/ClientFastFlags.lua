-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Players");
assert(l_RunService_0:IsClient());
local v3 = require(l_ReplicatedStorage_0.UserGenerated.Concurrency.Bindable);
local v4 = require(l_ReplicatedStorage_0.UserGenerated.FastFlags.SharedFastFlags);
local v5 = require(l_ReplicatedStorage_0.UserGenerated.Lang.Asserts);
local v6 = require(l_ReplicatedStorage_0.UserGenerated.Collections.DeepEqualsPureUnsafe);
local v7 = require(l_ReplicatedStorage_0.UserGenerated.Collections.DeepCopyPureUnsafe);
local v8 = require(l_ReplicatedStorage_0.UserGenerated.Collections.DeepFreezeUnsafe);
local v9 = require(l_ReplicatedStorage_0.UserGenerated.Strings.ObjectPaths);
local v10 = {};
local v11 = table.freeze({
    __index = v10
});
v10.Get = function(v12) --[[ Line: 48 ]] --[[ Name: Get ]]
    return v12.Value;
end;
v10.GetAsync = function(v13) --[[ Line: 51 ]] --[[ Name: GetAsync ]]
    while not v13.ValueLoaded do
        task.wait();
    end;
    return v13.Value;
end;
v10.IsLoaded = function(v14) --[[ Line: 59 ]] --[[ Name: IsLoaded ]]
    return v14.ValueLoaded;
end;
table.freeze(v10);
local l_NullValue_0 = v4.NullValue;
local l_UpdateRemote_0 = v4.UpdateRemote;
local v17 = {};
local v18 = false;
local v19 = {};
local v20 = v3.new();
local function _(v21) --[[ Line: 74 ]] --[[ Name: DecodeValue ]]
    -- upvalues: l_NullValue_0 (copy)
    if v21 ~= l_NullValue_0 then
        return v21;
    else
        return nil;
    end;
end;
local function v30(v23, v24) --[[ Line: 78 ]] --[[ Name: SetContent ]]
    -- upvalues: v8 (copy), v19 (ref), v17 (copy), l_NullValue_0 (copy), v6 (copy), v18 (ref), v20 (copy)
    v8(v23);
    v19 = v23;
    for v25, v26 in pairs(v23) do
        local v27 = v17[v25];
        if v27 then
            local v28 = if v26 ~= l_NullValue_0 then v26 else nil;
            local l_Value_0 = v27.Value;
            if v6(v28, l_Value_0) then
                v27.Value = v28;
                v27.Changed:Fire(v28, l_Value_0);
            end;
            if v24 and not v27.ValueLoaded then
                v27.ValueLoaded = true;
                v27.Loaded:Fire();
            end;
        end;
    end;
    if v24 and not v18 then
        v18 = true;
        v20:Fire();
    end;
end;
local function v40(v31, v32, v33) --[[ Line: 109 ]] --[[ Name: Create ]]
    -- upvalues: v5 (copy), v7 (copy), v8 (copy), v17 (copy), v9 (copy), v19 (ref), l_NullValue_0 (copy), v18 (ref), v3 (copy), v11 (copy)
    v5.String(v31);
    v5.Function(v32);
    v32(v33);
    v5.Storable(v33);
    v33 = v7(v33);
    v8(v33);
    assert(not v17[v31], (("ConflictingKeys: %*, %*"):format(v31, v31)));
    for v34, _ in pairs(v17) do
        if v9.HasHierarchicalOverlap(v31, v34) then
            error((("ConflictingKeys: %*, %*"):format(v31, v34)));
        end;
    end;
    local v36 = false;
    local l_v33_0 = v33;
    local v38 = v19[v31];
    if v38 ~= nil then
        l_v33_0 = if v38 ~= l_NullValue_0 then v38 else nil;
        v36 = v18;
    end;
    local v39 = setmetatable({
        Changed = v3.new(), 
        Loaded = v3.new(), 
        Replicated = true, 
        Key = v31, 
        DefaultValue = v33, 
        Assertion = v32, 
        ValueLoaded = v36, 
        Value = l_v33_0
    }, v11);
    v17[v31] = v39;
    return v39;
end;
local v49 = {
    Loaded = v20, 
    Replicated = function(v41, v42, v43) --[[ Line: 163 ]] --[[ Name: Replicated ]]
        -- upvalues: v40 (copy)
        return (v40(v41, v42, v43));
    end, 
    Private = function(_, _, _) --[[ Line: 171 ]] --[[ Name: Private ]]
        error("ServerOnly");
    end, 
    Get = function(v47) --[[ Line: 179 ]] --[[ Name: Get ]]
        -- upvalues: v17 (copy), v5 (copy)
        local v48 = v17[v47];
        if v48 then
            return v48;
        else
            v5.String(v47);
            error((("UnknownKey: '%*'"):format(v47)));
            return;
        end;
    end, 
    IsLoaded = function() --[[ Line: 190 ]] --[[ Name: IsLoaded ]]
        -- upvalues: v18 (ref)
        return v18;
    end
};
l_UpdateRemote_0.OnClientEvent:Connect(v30);
table.freeze(v49);
return v49;