-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = newproxy();
local v1 = newproxy();
local v2 = {
    "Destroy", 
    "Disconnect", 
    "destroy", 
    "disconnect"
};
local l_RunService_0 = game:GetService("RunService");
local function v9(v4, v5) --[[ Line: 11 ]] --[[ Name: GetObjectCleanupFunction ]]
    -- upvalues: v0 (copy), v1 (copy), v2 (copy)
    local v6 = typeof(v4);
    if v6 == "function" then
        return v0;
    elseif v6 == "thread" then
        return v1;
    elseif v5 then
        return v5;
    elseif v6 == "Instance" then
        return "Destroy";
    elseif v6 == "RBXScriptConnection" then
        return "Disconnect";
    else
        if v6 == "table" then
            for _, v8 in v2 do
                if typeof(v4[v8]) == "function" then
                    return v8;
                end;
            end;
        end;
        error("Failed to get cleanup function for object " .. v6 .. ": " .. tostring(v4), 3);
        return;
    end;
end;
local function _(v10) --[[ Line: 35 ]] --[[ Name: AssertPromiseLike ]]
    if typeof(v10) ~= "table" or typeof(v10.getStatus) ~= "function" or typeof(v10.finally) ~= "function" or typeof(v10.cancel) ~= "function" then
        error("Did not receive a Promise as an argument", 3);
    end;
end;
local v12 = {};
v12.__index = v12;
v12.new = function() --[[ Line: 58 ]] --[[ Name: new ]]
    -- upvalues: v12 (copy)
    local v13 = setmetatable({}, v12);
    v13._objects = {};
    v13._cleaning = false;
    return v13;
end;
v12.Extend = function(v14) --[[ Line: 84 ]] --[[ Name: Extend ]]
    -- upvalues: v12 (copy)
    if v14._cleaning then
        error("Cannot call trove:Extend() while cleaning", 2);
    end;
    return v14:Construct(v12);
end;
v12.Clone = function(v15, v16) --[[ Line: 95 ]] --[[ Name: Clone ]]
    if v15._cleaning then
        error("Cannot call trove:Clone() while cleaning", 2);
    end;
    return v15:Add(v16:Clone());
end;
v12.Construct = function(v17, v18, ...) --[[ Line: 135 ]] --[[ Name: Construct ]]
    if v17._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2);
    end;
    local v19 = nil;
    local v20 = type(v18);
    if v20 == "table" then
        v19 = v18.new(...);
    elseif v20 == "function" then
        v19 = v18(...);
    end;
    return v17:Add(v19);
end;
v12.Connect = function(v21, v22, v23) --[[ Line: 164 ]] --[[ Name: Connect ]]
    if v21._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2);
    end;
    return v21:Add(v22:Connect(v23));
end;
v12.BindToRenderStep = function(v24, v25, v26, v27) --[[ Line: 184 ]] --[[ Name: BindToRenderStep ]]
    -- upvalues: l_RunService_0 (copy)
    if v24._cleaning then
        error("Cannot call trove:BindToRenderStep() while cleaning", 2);
    end;
    l_RunService_0:BindToRenderStep(v25, v26, v27);
    v24:Add(function() --[[ Line: 189 ]]
        -- upvalues: l_RunService_0 (ref), v25 (copy)
        l_RunService_0:UnbindFromRenderStep(v25);
    end);
end;
v12.AddPromise = function(v28, v29) --[[ Line: 217 ]] --[[ Name: AddPromise ]]
    if v28._cleaning then
        error("Cannot call trove:AddPromise() while cleaning", 2);
    end;
    if typeof(v29) ~= "table" or typeof(v29.getStatus) ~= "function" or typeof(v29.finally) ~= "function" or typeof(v29.cancel) ~= "function" then
        error("Did not receive a Promise as an argument", 3);
    end;
    if v29:getStatus() == "Started" then
        v29:finally(function() --[[ Line: 223 ]]
            -- upvalues: v28 (copy), v29 (copy)
            if v28._cleaning then
                return;
            else
                v28:_findAndRemoveFromObjects(v29, false);
                return;
            end;
        end);
        v28:Add(v29, "cancel");
    end;
    return v29;
end;
v12.Add = function(v30, v31, v32) --[[ Line: 282 ]] --[[ Name: Add ]]
    -- upvalues: v9 (copy)
    if v30._cleaning then
        error("Cannot call trove:Add() while cleaning", 2);
    end;
    local v33 = v9(v31, v32);
    table.insert(v30._objects, {
        v31, 
        v33
    });
    return v31;
end;
v12.Remove = function(v34, v35) --[[ Line: 301 ]] --[[ Name: Remove ]]
    if v34._cleaning then
        error("Cannot call trove:Remove() while cleaning", 2);
    end;
    return v34:_findAndRemoveFromObjects(v35, true);
end;
v12.Clean = function(v36) --[[ Line: 314 ]] --[[ Name: Clean ]]
    if v36._cleaning then
        return;
    else
        v36._cleaning = true;
        for _, v38 in v36._objects do
            v36:_cleanupObject(v38[1], v38[2]);
        end;
        table.clear(v36._objects);
        v36._cleaning = false;
        return;
    end;
end;
v12._findAndRemoveFromObjects = function(v39, v40, v41) --[[ Line: 326 ]] --[[ Name: _findAndRemoveFromObjects ]]
    local l__objects_0 = v39._objects;
    for v43, v44 in ipairs(l__objects_0) do
        if v44[1] == v40 then
            local v45 = #l__objects_0;
            l__objects_0[v43] = l__objects_0[v45];
            l__objects_0[v45] = nil;
            if v41 then
                v39:_cleanupObject(v44[1], v44[2]);
            end;
            return true;
        end;
    end;
    return false;
end;
v12._cleanupObject = function(_, v47, v48) --[[ Line: 342 ]] --[[ Name: _cleanupObject ]]
    -- upvalues: v0 (copy), v1 (copy)
    if v48 == v0 then
        v47();
        return;
    elseif v48 == v1 then
        pcall(task.cancel, v47);
        return;
    else
        v47[v48](v47);
        return;
    end;
end;
v12.AttachToInstance = function(v49, v50) --[[ Line: 365 ]] --[[ Name: AttachToInstance ]]
    if v49._cleaning then
        error("Cannot call trove:AttachToInstance() while cleaning", 2);
    elseif not v50:IsDescendantOf(game) then
        error("Instance is not a descendant of the game hierarchy", 2);
    end;
    return v49:Connect(v50.Destroying, function() --[[ Line: 371 ]]
        -- upvalues: v49 (copy)
        v49:Destroy();
    end);
end;
v12.Destroy = function(v51) --[[ Line: 379 ]] --[[ Name: Destroy ]]
    v51:Clean();
end;
return v12;