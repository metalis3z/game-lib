-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVBHR5cGUIdXNlcmRhdGEIdG9zdHJpbmcGc3RyaW5nA3N1YgdYYm94T25lBHdhcm4WQ291bGQgbm90IGZpbmQgc3R5bGU6IAlHZXRTcHJpdGUQZ2V0SW1hZ2VJbnN0YW5jZQpJbWFnZUxhYmVsDUdldEltYWdlTGFiZWwLSW1hZ2VCdXR0b24OR2V0SW1hZ2VCdXR0b24FcGFpcnMGc2NyaXB0DFNwcml0ZXNoZWV0cwtHZXRDaGlsZHJlbgROYW1lB3JlcXVpcmUDbmV3AAQIAwEAAAAluygBA1IEAQCkAwEAAAAAQJ8DAgLwAw0AAgAAgLs/AQNSBQEApAQEAAAAMECfBAICgS0EBAUAAABvBQUApAMIAAAcYICfAwMCUgEDAPsFAABNBAV5CQAAAIcDBAIrAwcApAQLAAAAoEBvBgwAUgcCAHMFBgefBAIBggABAFIGAABSBwEAvAQD7Q0AAACfBAQCggQCAA4DAQQAAABAAwIDAwQAADBAAgAAAAAAACxAAwQDBQQAHGCAAwYDBwQAAKBAAwgDCQAOCgEYAAAAAAAAAAEAAAAAAAAAAAAAAAIAAAABAQAAAAAAAQIAAAAAARAAAAAACQQBAAAAB/sEAABvBQAAUgYBAFIHAgBSCAMAnwQFAIIEAAABAwsAHAwBGAAAAAAAAAAdAAAAAAkEAQAAAAf7BAAAbwUAAFIGAQBSBwIAUggDAJ8EBQCCBAAAAQMNACAOARgAAAAAAAAAIQAAAAAQAAABAAA4owAAAP8AAgAAAAAA/wEAAAAAAACkAgEAAAAAQKQDAwAAACBATQMDHQQAAAC8AwNoBQAAAJ8DAgCfAgAEFwIbAE0HBroGAAAA/wgAAAAAAABqCAEHpAcBAAAAAEC8CAZoBQAAAJ8IAgCfBwAEFwcNAE0NBroGAAAAhwwBDU0NC7oGAAAApA4IAAAAcEBSDwsAnw4CAk0ODu8JAAAAnw4BAmoODA1uB/L/AgAAAG4C5P8CAAAAwAIKABIAAQDAAwsAEgACADADAIEMAAAAwAMNABIAAgAwAwCODgAAAIIAAgAPAw8EAAAAQAMQBAAAIEADEQMSAxMDFAQAAHBAAxUGAAYBAwwGAgMOAwABAgEAARgAAwACAAEAAAAAAAAAAAAAAQAAAAABAAAAAAAAAQAAAAAAAAAAAAAAAP8A/gAHAA4AAAAEAAAABAEAAAAAA9JyaeX1ZEV8/TorIrgFyVaian6R4LYD5A==

-- decompilation:
local v0 = {};
local v1 = {};
for _, v3 in pairs(script.Spritesheets:GetChildren()) do
    v1[v3.Name] = {};
    for _, v5 in pairs(v3:GetChildren()) do
        v1[v3.Name][v5.Name] = require(v5).new();
    end;
end;
local function v10(v6, v7, v8) --[[ Line: 14 ]] --[[ Name: getImageInstance ]]
    -- upvalues: v1 (copy)
    if type(v7) == "userdata" then
        v7 = string.sub(tostring(v7), 14);
    end;
    local v9 = v1.XboxOne[v8];
    if not v9 then
        warn("Could not find style: " .. v8);
        return;
    else
        return (v9:GetSprite(v6, v7));
    end;
end;
v0.GetImageLabel = function(_, v12, v13, v14) --[[ Line: 28 ]] --[[ Name: GetImageLabel ]]
    -- upvalues: v10 (copy)
    return v10("ImageLabel", v12, v13, v14);
end;
v0.GetImageButton = function(_, v16, v17, v18) --[[ Line: 32 ]] --[[ Name: GetImageButton ]]
    -- upvalues: v10 (copy)
    return v10("ImageButton", v16, v17, v18);
end;
return v0;
