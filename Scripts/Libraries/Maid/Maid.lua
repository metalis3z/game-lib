local v0 = require(script.GetPromiseLibrary);
local v1 = require(script.Symbol);
local v2, v3 = v0();
local v4 = v1("IndicesReference");
local v5 = v1("LinkToInstanceIndex");
local v6 = {
    ClassName = "Janitor", 
    CurrentlyCleaning = true, 
    [v4] = nil
};
v6.__index = v6;
local v7 = {
    ["function"] = true, 
    RBXScriptConnection = "Disconnect"
};
v6.Is = function(v8)
    local _ = nil;
    if type(v8) == "table" then
        return getmetatable(v8) == v6;
    else
        return false;
    end;
end;
v6._Add = function(v10, v11, v12, v13)
    if v13 then
        v10:Remove(v13);
        local v14 = v10[v4];
        if not v14 then
            v14 = {};
            v10[v4] = v14;
        end;
        v14[v13] = v11;
    end;
    local v15 = v12 or v7[typeof(v11)] or "Destroy";
    if type(v11) ~= "function" and not v11[v15] then
        warn(string.format("Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s", tostring(v11), tostring(v15), debug.traceback(nil, 2)));
    end;
    v10[v11] = v15;
    return v11;
end;
v6.Add = function(v16, ...)
    for _, v18 in pairs({
        ...
    }) do
        v16:_Add(v18);
    end;
end;
v6.AddPromise = function(v19, v20)
    if not v2 then
        return v20;
    else
        if not v3.is(v20) then
            error(string.format("Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %s (%s))", typeof(v20), (tostring(v20))));
        end;
        if v20:getStatus() ~= v3.Status.Started then
            return v20;
        else
            local v21 = newproxy(false);
            local v25 = v19:_Add(v3.new(function(v22, _, v24)
                if not v24(function()
                    v20:cancel();
                end) then
                    v22(v20);
                end;
            end), "cancel", v21);
            v25:finallyCall(v19.Remove, v19, v21);
            return v25;
        end;
    end;
end;
v6.Remove = function(v26, v27)
    local v28 = v26[v4];
    local v29 = v28 and v28[v27];
    if v29 then
        local v30 = v26[v29];
        if v30 then
            if v30 == true then
                v29();
            else
                local v31 = v29[v30];
                if v31 then
                    v31(v29);
                end;
            end;
            v26[v29] = nil;
        end;
        v28[v27] = nil;
    end;
    return v26;
end;
v6.Get = function(v32, v33)
    local v34 = v32[v4];
    if v34 then
        return v34[v33];
    else
        return nil;
    end;
end;
v6.Cleanup = function(v35)
    local v36 = false;
    local v37 = false;
    if not v35.CurrentlyCleaning then
        v35.CurrentlyCleaning = nil;
        local function _()
            for v38, v39 in pairs(v35) do
                if v38 ~= v4 then
                    return v38, v39;
                end;
            end;
        end;
        local v41, v42;
        for v43, v44 in pairs(v35) do
            if v43 ~= v4 then
                v41 = v43;
                v42 = v44;
                v36 = true;
            end;
            if v36 then
                break;
            end;
        end;
        if not v36 then
            v41 = nil;
            v42 = nil;
        end;
        v36 = false;
        while true do
            if not (v41 and v42) then
                break;
            end;
            if v42 == true then
                v41();
            else
                local v45 = v41[v42];
                if v45 then
                    v45(v41);
                end;
            end;
            v35[v41] = nil;
            local v46, v47;
            for v48, v49 in pairs(v35) do
                if v48 ~= v4 then
                    v46 = v48;
                    v47 = v49;
                    v37 = true;
                end;
                if v37 then
                    break;
                end;
            end;
            if not v37 then
                v46 = nil;
                v47 = nil;
            end;
            v37 = false;
            v41 = v46;
            v42 = v47;
        end;
        local v50 = v35[v4];
        if v50 then
            table.clear(v50);
            v35[v4] = {};
        end;
        v35.CurrentlyCleaning = false;
    end;
end;
v6.Destroy = function(v51)
    v51:Cleanup();
    table.clear(v51);
    setmetatable(v51, nil);
end;
v6.__call = v6.Cleanup;
local v52 = {
    Connected = true
};
v52.__index = v52;
v52.Disconnect = function(v53)
    if v53.Connected then
        v53.Connected = false;
        v53.Connection:Disconnect();
    end;
end;
v52._new = function(v54)
    return (setmetatable({
        Connection = v54
    }, v52));
end;
v52.__tostring = function(v55)
    return "RbxScriptConnection<" .. tostring(v55.Connected) .. ">";
end;
v6.LinkToInstance = function(v56, v57, v58)
    local v59 = nil;
    local v60 = v58 and newproxy(false) or v5;
    local v61 = v57.Parent == nil;
    local v62 = setmetatable({}, v52);
    local function v65(_, v64)
        v61 = v62.Connected and v64 == nil;
        if v61 then
            task.defer(function()
                if v62.Connected then
                    if v59.Connected then
                        while v61 and v59.Connected and v62.Connected do
                            task.wait();
                        end;
                        if v62.Connected and v61 then
                            v56:Cleanup();
                            return;
                        else
                            return;
                        end;
                    else
                        v56:Cleanup();
                        return;
                    end;
                else
                    return;
                end;
            end);
        end;
    end;
    v59 = v57.AncestryChanged:Connect(v65);
    v62.Connection = v59;
    if v61 then
        local l_Parent_0 = v57.Parent;
        if v62.Connected then
            v61 = l_Parent_0 == nil;
            if v61 then
                task.defer(function()
                    if v62.Connected then
                        if v59.Connected then
                            while v61 and v59.Connected and v62.Connected do
                                task.wait();
                            end;
                            if v62.Connected and v61 then
                                v56:Cleanup();
                                return;
                            else
                                return;
                            end;
                        else
                            v56:Cleanup();
                            return;
                        end;
                    else
                        return;
                    end;
                end);
            end;
        end;
    end;
    return v56:_Add(v62, "Disconnect", v60);
end;
v6.LinkToInstances = function(v67, ...)
    local v68 = v6.new();
    for _, v70 in ipairs({
        ...
    }) do
        v68:_Add(v67:LinkToInstance(v70, true), "Disconnect");
    end;
    return v68;
end;
v6.new = function()
    return (setmetatable({
        CurrentlyCleaning = false, 
        [v4] = nil
    }, v6));
end;
return v6;