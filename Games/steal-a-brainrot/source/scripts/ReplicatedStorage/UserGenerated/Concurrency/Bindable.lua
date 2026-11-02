-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local v0 = require(game.ReplicatedStorage.UserGenerated.Concurrency.Connection);
local v1 = require(game.ReplicatedStorage.UserGenerated.Lang.WCall);
local v2 = {};
local function v10(v3, v4, ...) --[[ Line: 73 ]] --[[ Name: FindRight ]]
    local v5 = false;
    local v6 = 1;
    local v7 = #v3;
    while v6 <= v7 do
        local v8 = v6 + (v7 - v6) // 2;
        local v9 = v4(v3[v8], ...);
        if v9 > 0 then
            v7 = v8 - 1;
        elseif v9 < 0 then
            v6 = v8 + 1;
        else
            v5 = true;
            v6 = v8 + 1;
        end;
    end;
    return v5 and v6 or -v6;
end;
local function v16(v11, v12, v13) --[[ Line: 102 ]] --[[ Name: Remove ]]
    -- upvalues: v10 (copy)
    local v14 = v10(v11, v12, v13);
    if v14 > 0 then
        for v15 = v14, #v11 do
            if v11[v15] == v13 then
                table.remove(v11, v15);
                return true;
            end;
        end;
    end;
    return false;
end;
local function _(v17, v18, v19) --[[ Line: 122 ]] --[[ Name: InsertRight ]]
    -- upvalues: v10 (copy)
    local v20 = math.abs((v10(v17, v18, v19)));
    table.insert(v17, v20, v19);
    return v20;
end;
Comparator = function(v22, v23) --[[ Line: 132 ]] --[[ Name: Comparator ]]
    return v22.Pr - v23.Pr;
end;
Disconnector = function(v24, v25) --[[ Line: 139 ]] --[[ Name: Disconnector ]]
    -- upvalues: v16 (copy)
    if not v16(v25.Cs, Comparator, v24) then
        error("Bindable disconnection failure");
    end;
end;
v2.Connect = function(v26, v27, v28) --[[ Line: 148 ]] --[[ Name: Connect ]]
    -- upvalues: v0 (copy), v10 (copy)
    local v29 = true;
    if v28 ~= nil then
        v29 = false;
        if type(v28) == "number" then
            v29 = v28 == v28;
        end;
    end;
    assert(v29);
    local v30 = v28 or 1e999;
    v29 = v0.new(v27, v30, Disconnector, v26);
    if v30 == 1e999 then
        table.insert(v26.Cs, v29);
        return v29;
    else
        local l_Cs_0 = v26.Cs;
        table.insert(l_Cs_0, math.abs((v10(l_Cs_0, Comparator, v29))), v29);
        return v29;
    end;
end;
v2.Fire = function(v32, ...) --[[ Line: 163 ]] --[[ Name: Fire ]]
    local l_Cs_1 = v32.Cs;
    local v34 = 1;
    while v34 <= #l_Cs_1 do
        local v35 = l_Cs_1[v34];
        task.spawn(v35.Cb, ...);
        if l_Cs_1[v34] == v35 then
            v34 = v34 + 1;
        end;
    end;
end;
v2.FireAndWait = function(v36, ...) --[[ Line: 177 ]] --[[ Name: FireAndWait ]]
    local v37 = {};
    local l_Cs_2 = v36.Cs;
    local v39 = 1;
    while v39 <= #l_Cs_2 do
        local v40 = l_Cs_2[v39];
        table.insert(v37, (task.spawn(v40.Cb, ...)));
        if l_Cs_2[v39] == v40 then
            v39 = v39 + 1;
        end;
    end;
    for _, v42 in pairs(v37) do
        while coroutine.status(v42) ~= "dead" do
            task.wait();
        end;
    end;
end;
v2.FireSync = function(v43, ...) --[[ Line: 196 ]] --[[ Name: FireSync ]]
    -- upvalues: v1 (copy)
    local l_Cs_3 = v43.Cs;
    local v45 = 1;
    while v45 <= #l_Cs_3 do
        local v46 = l_Cs_3[v45];
        v1(v46.Cb, ...);
        if l_Cs_3[v45] == v46 then
            v45 = v45 + 1;
        end;
    end;
end;
v2.Invoke = function(v47, ...) --[[ Line: 208 ]] --[[ Name: Invoke ]]
    local l_Cs_4 = v47.Cs;
    if #l_Cs_4 >= 1 then
        return l_Cs_4[1].Cb(...);
    else
        error("Invoke");
        return;
    end;
end;
v2.Wait = function(v49) --[[ Line: 219 ]] --[[ Name: Wait ]]
    local v50 = nil;
    local v51 = nil;
    v51 = v49:Connect(function(...) --[[ Line: 222 ]]
        -- upvalues: v50 (ref), v51 (ref)
        v50 = table.pack(...);
        v51:Disconnect();
    end);
    while not v50 do
        if not v51:IsConnected() then
            error("Disconnected");
        end;
        task.wait();
    end;
    return table.unpack(v50);
end;
v2.Once = function(v52, v53, _) --[[ Line: 237 ]] --[[ Name: Once ]]
    local v55 = nil;
    v55 = v52:Connect(function(...) --[[ Line: 242 ]]
        -- upvalues: v55 (ref), v53 (copy)
        v55:Disconnect();
        return v53(...);
    end);
    return v55;
end;
v2.DisconnectAll = function(v56) --[[ Line: 249 ]] --[[ Name: DisconnectAll ]]
    local l_Cs_5 = v56.Cs;
    for v58 = #l_Cs_5, 1, -1 do
        l_Cs_5[v58]:Disconnect();
    end;
end;
v2.GetSize = function(v59) --[[ Line: 256 ]] --[[ Name: GetSize ]]
    return #v59.Cs;
end;
v2.IsEmpty = function(v60) --[[ Line: 260 ]] --[[ Name: IsEmpty ]]
    return #v60.Cs == 0;
end;
local v61 = {};
local v62 = table.freeze({
    __index = table.freeze(v2)
});
v61.new = function(_) --[[ Line: 270 ]] --[[ Name: new ]]
    -- upvalues: v62 (copy)
    local v64 = setmetatable({
        Cs = {}
    }, v62);
    table.freeze(v64);
    return v64;
end;
return table.freeze(v61);