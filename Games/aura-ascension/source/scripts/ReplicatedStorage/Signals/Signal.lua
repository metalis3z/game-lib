-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = if script:GetAttribute("Deferred") then task.defer else task.spawn;
local v1 = {};
local function v4(v2, v3, ...) --[[ Line: 52 ]] --[[ Name: reusableThreadCall ]]
    -- upvalues: v1 (copy)
    v2(...);
    table.insert(v1, v3);
end;
local function v5() --[[ Line: 56 ]] --[[ Name: reusableThread ]]
    -- upvalues: v4 (copy)
    while true do
        v4(coroutine.yield());
    end;
end;
local v6 = {};
v6.__index = v6;
v6.Disconnect = function(v7) --[[ Line: 66 ]]
    if not v7.Connected then
        return;
    else
        v7.Connected = nil;
        local l_Signal_0 = v7.Signal;
        local l_Previous_0 = v7.Previous;
        local l_Next_0 = v7.Next;
        if l_Previous_0 then
            l_Previous_0.Next = l_Next_0;
        else
            l_Signal_0.Tail = l_Next_0;
        end;
        if l_Next_0 then
            l_Next_0.Previous = l_Previous_0;
            return;
        else
            l_Signal_0.Head = l_Previous_0;
            return;
        end;
    end;
end;
local v11 = {};
v11.__index = v11;
v11.Connect = function(v12, v13) --[[ Line: 92 ]]
    -- upvalues: v6 (copy)
    local l_Head_0 = v12.Head;
    local v15 = {
        Signal = v12, 
        Previous = l_Head_0, 
        Callback = v13, 
        Connected = true
    };
    if l_Head_0 then
        l_Head_0.Next = v15;
    else
        v12.Tail = v15;
    end;
    v12.Head = v15;
    return (setmetatable(v15, v6));
end;
v11.Once = function(v16, v17) --[[ Line: 117 ]]
    -- upvalues: v6 (copy)
    local l_Head_1 = v16.Head;
    local v19 = nil;
    v19 = {
        Signal = v16, 
        Previous = l_Head_1, 
        Callback = function(...) --[[ Line: 127 ]] --[[ Name: Callback ]]
            -- upvalues: v19 (ref), v16 (copy), v17 (copy)
            if not v19.Connected then
                return;
            else
                v19.Connected = false;
                local l_Previous_1 = v19.Previous;
                local l_Next_1 = v19.Next;
                if l_Previous_1 then
                    l_Previous_1.Next = l_Next_1;
                else
                    v16.Tail = l_Next_1;
                end;
                if l_Next_1 then
                    l_Next_1.Previous = l_Previous_1;
                else
                    v16.Head = l_Previous_1;
                end;
                v17(...);
                return;
            end;
        end, 
        Connected = true
    };
    if l_Head_1 then
        l_Head_1.Next = v19;
    else
        v16.Tail = v19;
    end;
    v16.Head = v19;
    return (setmetatable(v19, v6));
end;
v11.Wait = function(v22) --[[ Line: 165 ]]
    local v23 = coroutine.running();
    local l_Head_2 = v22.Head;
    local v25 = nil;
    v25 = {
        Previous = l_Head_2, 
        Callback = function(...) --[[ Line: 177 ]] --[[ Name: Callback ]]
            -- upvalues: v25 (ref), v22 (copy), v23 (copy)
            v25.Connected = false;
            local l_Previous_2 = v25.Previous;
            local l_Next_2 = v25.Next;
            if l_Previous_2 then
                l_Previous_2.Next = l_Next_2;
            else
                v22.Tail = l_Next_2;
            end;
            if l_Next_2 then
                l_Next_2.Previous = l_Previous_2;
            else
                v22.Head = l_Previous_2;
            end;
            if coroutine.status(v23) == "suspended" then
                task.spawn(v23, ...);
            end;
        end
    };
    if l_Head_2 then
        l_Head_2.Next = v25;
    else
        v22.Tail = v25;
    end;
    v22.Head = v25;
    return coroutine.yield();
end;
v11.Fire = function(v28, ...) --[[ Line: 213 ]]
    -- upvalues: v1 (copy), v5 (copy), v0 (copy)
    local l_Tail_0 = v28.Tail;
    while l_Tail_0 do
        local v30 = #v1;
        if v30 == 0 then
            local v31 = coroutine.create(v5);
            coroutine.resume(v31);
            v0(v31, l_Tail_0.Callback, v31, ...);
        else
            local v32 = v1[v30];
            v1[v30] = nil;
            v0(v32, l_Tail_0.Callback, v32, ...);
        end;
        l_Tail_0 = l_Tail_0.Next;
    end;
end;
v11.DisconnectAll = function(v33) --[[ Line: 232 ]]
    local l_Tail_1 = v33.Tail;
    while l_Tail_1 do
        l_Tail_1.Connected = nil;
        l_Tail_1 = l_Tail_1.Next;
    end;
    v33.Tail = nil;
    v33.Head = nil;
end;
v11.Destroy = function(v35) --[[ Line: 244 ]]
    local l_Tail_2 = v35.Tail;
    while l_Tail_2 do
        l_Tail_2.Connected = nil;
        l_Tail_2 = l_Tail_2.Next;
    end;
    v35.Tail = nil;
    v35.Head = nil;
    setmetatable(v35, nil);
end;
return function() --[[ Line: 261 ]]
    -- upvalues: v11 (copy)
    return (setmetatable({}, v11));
end;