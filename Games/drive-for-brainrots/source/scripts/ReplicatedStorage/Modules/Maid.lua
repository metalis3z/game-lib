-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPDHNldG1ldGF0YWJsZQZfdGFza3MDbmV3CEdpdmVUYXNrBmlwYWlycwZ0eXBlb2YIZnVuY3Rpb24TUkJYU2NyaXB0Q29ubmVjdGlvbgpEaXNjb25uZWN0CEluc3RhbmNlB0Rlc3Ryb3kFdGFibGUFY2xlYXIKRG9DbGVhbmluZwdfX2luZGV4AAUDAAEAAAAN/wEBAAAAAAD7AgAAnj0BAwIAAACkAAEAAAAAQJ8AAwL/AQAAAAAAADABAKcCAAAAggACAAMDAQQAAABAAwIABwMBGAAAAAAAAAAAAQAAAAEIAAAAAAUCAAAAAAorAQEAggABAE0EAKcBAAAAHAMEAJUCAwBNAwCnAQAAAGoBAwKCAgIAAgIAAAAAAADwPwMCAA0EARgAAQMAAAABAAABDgAAAAAIAQAAAAAtpAEBAAAAAEBNAgCnAgAAAJ8BAgRRAR8AuywFA1IHBQCkBgQAAAAwQJ8GAgLwBgQABQAAgFIGBQCfBgEBZQAVALssBQNSBwUApAYEAAAAMECfBgIC8AYFAAYAAIC8BgUaBwAAAJ8GAgFlAAoAuywFA1IHBQCkBgQAAAAwQJ8GAgLwBgQACAAAgLwGBVAJAAAAnwYCAW4B4P8CAACApAEMAAAsoIBNAgCnAgAAAJ8BAgGCAAEADQMFBAAAAEADAgMGBAAAMEADBwMIAwkDCgMLAwwDDQQALKCAABcOARgAAAAAAAABAAAAAAAAAQAAAQAAAAAAAAEAAAABAAAAAAAAAQAA+gAJAAAAAAEYAAAAAAMBAAAAAAi8AQBRAAAAAJ8BAgGkAQMAAAgQgFICAACfAQIBggABAAQDDgMMAw0EAAgQgAAkCwEYAAAAAQAAAAElAAAAAAIAAAECABOjAAAA/wAEAAAAAAAwAABuAAAAAMABAQASAAAAMAEA7wIAAADAAQMAMAEA/QQAAADAAQUAMAEAUQYAAADAAQcAMAEAUAgAAACCAAIACQMPBgADAwYBAwQGAgMOBgMDCwQAAQIDAQABGAADAAEAAgAAAAYAAAoAAA0AAAUBAAAAAAT51yCPC+vD/lw3rQE7Y4z4ic83+8sTSo4=

-- decompilation:
local v0 = {};
v0.__index = v0;
v0.new = function() --[[ Line: 7 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy)
    local v1 = setmetatable({}, v0);
    v1._tasks = {};
    return v1;
end;
v0.GiveTask = function(v2, v3) --[[ Line: 13 ]] --[[ Name: GiveTask ]]
    if not v3 then
        return;
    else
        local v4 = #v2._tasks + 1;
        v2._tasks[v4] = v3;
        return v4;
    end;
end;
v0.DoCleaning = function(v5) --[[ Line: 23 ]] --[[ Name: DoCleaning ]]
    for _, v7 in ipairs(v5._tasks) do
        if typeof(v7) == "function" then
            v7();
        elseif typeof(v7) == "RBXScriptConnection" then
            v7:Disconnect();
        elseif typeof(v7) == "Instance" then
            v7:Destroy();
        end;
    end;
    table.clear(v5._tasks);
end;
v0.Destroy = function(v8) --[[ Line: 36 ]] --[[ Name: Destroy ]]
    v8:DoCleaning();
    table.clear(v8);
end;
return v0;
