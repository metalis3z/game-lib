-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = newproxy();
local v1 = newproxy();
local l_RunService_0 = game:GetService("RunService");
local function v6(v3, v4) --[[ Line: 10 ]] --[[ Name: GetObjectCleanupFunction ]]
    -- upvalues: v0 (copy), v1 (copy)
    local v5 = typeof(v3);
    if v5 == "function" then
        return v0;
    elseif v5 == "thread" then
        return v1;
    elseif v4 then
        return v4;
    elseif v5 == "Instance" then
        return "Destroy";
    elseif v5 == "RBXScriptConnection" then
        return "Disconnect";
    else
        if v5 == "table" then
            if typeof(v3.Destroy) == "function" then
                return "Destroy";
            elseif typeof(v3.Disconnect) == "function" then
                return "Disconnect";
            end;
        end;
        error("Failed to get cleanup function for object " .. v5 .. ": " .. tostring(v3), 3);
        return;
    end;
end;
local function _(v7) --[[ Line: 34 ]] --[[ Name: AssertPromiseLike ]]
    if type(v7) ~= "table" or type(v7.getStatus) ~= "function" or type(v7.finally) ~= "function" or type(v7.cancel) ~= "function" then
        error("Did not receive a Promise as an argument", 3);
    end;
end;
local v9 = {};
v9.__index = v9;
v9.new = function() --[[ Line: 57 ]] --[[ Name: new ]]
    -- upvalues: v9 (copy)
    local v10 = setmetatable({}, v9);
    v10._objects = {};
    return v10;
end;
v9.Extend = function(v11) --[[ Line: 82 ]] --[[ Name: Extend ]]
    -- upvalues: v9 (copy)
    return v11:Construct(v9);
end;
v9.Clone = function(v12, v13) --[[ Line: 90 ]] --[[ Name: Clone ]]
    return v12:Add(v13:Clone());
end;
v9.Construct = function(v14, v15, ...) --[[ Line: 127 ]] --[[ Name: Construct ]]
    local v16 = nil;
    local v17 = type(v15);
    if v17 == "table" then
        v16 = v15.new(...);
    elseif v17 == "function" then
        v16 = v15(...);
    end;
    return v14:Add(v16);
end;
v9.Connect = function(v18, v19, v20) --[[ Line: 153 ]] --[[ Name: Connect ]]
    return v18:Add(v19:Connect(v20));
end;
v9.BindToRenderStep = function(v21, v22, v23, v24) --[[ Line: 170 ]] --[[ Name: BindToRenderStep ]]
    -- upvalues: l_RunService_0 (copy)
    l_RunService_0:BindToRenderStep(v22, v23, v24);
    v21:Add(function() --[[ Line: 172 ]]
        -- upvalues: l_RunService_0 (ref), v22 (copy)
        l_RunService_0:UnbindFromRenderStep(v22);
    end);
end;
v9.AddPromise = function(v25, v26) --[[ Line: 200 ]] --[[ Name: AddPromise ]]
    if type(v26) ~= "table" or type(v26.getStatus) ~= "function" or type(v26.finally) ~= "function" or type(v26.cancel) ~= "function" then
        error("Did not receive a Promise as an argument", 3);
    end;
    if v26:getStatus() == "Started" then
        v26:finally(function() --[[ Line: 203 ]]
            -- upvalues: v25 (copy), v26 (copy)
            return v25:_findAndRemoveFromObjects(v26, false);
        end);
        v25:Add(v26, "cancel");
    end;
    return v26;
end;
v9.Add = function(v27, v28, v29) --[[ Line: 259 ]] --[[ Name: Add ]]
    -- upvalues: v6 (copy)
    local v30 = v6(v28, v29);
    table.insert(v27._objects, {
        v28, 
        v30
    });
    return v28;
end;
v9.Remove = function(v31, v32) --[[ Line: 275 ]] --[[ Name: Remove ]]
    return v31:_findAndRemoveFromObjects(v32, true);
end;
v9.Clean = function(v33) --[[ Line: 284 ]] --[[ Name: Clean ]]
    for _, v35 in ipairs(v33._objects) do
        v33:_cleanupObject(v35[1], v35[2]);
    end;
    table.clear(v33._objects);
end;
v9._findAndRemoveFromObjects = function(v36, v37, v38) --[[ Line: 291 ]] --[[ Name: _findAndRemoveFromObjects ]]
    local l__objects_0 = v36._objects;
    for v40, v41 in ipairs(l__objects_0) do
        if v41[1] == v37 then
            local v42 = #l__objects_0;
            l__objects_0[v40] = l__objects_0[v42];
            l__objects_0[v42] = nil;
            if v38 then
                v36:_cleanupObject(v41[1], v41[2]);
            end;
            return true;
        end;
    end;
    return false;
end;
v9._cleanupObject = function(_, v44, v45) --[[ Line: 307 ]] --[[ Name: _cleanupObject ]]
    -- upvalues: v0 (copy), v1 (copy)
    if v45 == v0 then
        v44();
        return;
    elseif v45 == v1 then
        coroutine.close(v44);
        return;
    else
        v44[v45](v44);
        return;
    end;
end;
v9.AttachToInstance = function(v46, v47) --[[ Line: 330 ]] --[[ Name: AttachToInstance ]]
    assert(v47:IsDescendantOf(game), "Instance is not a descendant of the game hierarchy");
    return v46:Connect(v47.Destroying, function() --[[ Line: 332 ]]
        -- upvalues: v46 (copy)
        v46:Destroy();
    end);
end;
v9.Destroy = function(v48) --[[ Line: 340 ]] --[[ Name: Destroy ]]
    v48:Clean();
end;
return v9;