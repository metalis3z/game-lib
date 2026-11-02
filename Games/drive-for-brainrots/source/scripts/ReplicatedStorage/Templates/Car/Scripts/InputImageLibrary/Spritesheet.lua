-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPDHNldG1ldGF0YWJsZQdUZXh0dXJlB1Nwcml0ZXMDbmV3CFBvc2l0aW9uBFNpemUJQWRkU3ByaXRlBHdhcm4YSW1hZ2UgbmFtZSBjYW5ub3QgYmUgbmlsG0NvdWxkIG5vdCBmaW5kIHNwcml0ZSBmb3I6IA9JbWFnZVJlY3RPZmZzZXQNSW1hZ2VSZWN0U2l6ZQVJbWFnZQlHZXRTcHJpdGUHX19pbmRleAAEBQEBAAAAEP8BAgAAAAAA+wQAAJ49AQQEAAAAUgMBAKQCAQAAAABAnwIDATAAAU8CAAAA/wIAAAAAAAAwAgF3AwAAAIIBAgAEAwEEAAAAQAMCAwMABAQBGAAAAQAAAAAAAAIAAQAAAAIFAAAAAAYEAAAAAAniBAIAMAIEOwAAAAAwAwQvAQAAAE0FAHcDAAAAagQFAYIAAQAEAwUDBgUCAAEDAwAOBwEYAAAAAAABAAABDwAAAAAIAwAAAAAhKwIGAKQDAQAAAABAbwQCAJ8DAgGpAwAAggMCAE0EAHcDAAAAhwMEAisDCACkBAEAAAAAQG8GBABSBwIAcwUGB58EAgGpBAAAggQCAOIECABNBQM7CQAAADAFBPkFAAAATQUDLwoAAAAwBQTrBgAAAE0FAE8LAAAAMAUEqQcAAACCBAIADAMIBAAAAEADCQMDAwoDCwMMAw0FAwUGBwMFAwYDAgATDgEYAAEAAAABAAIAAAEBAAAAAAABAAMAAAAAAAAAAAAAAAAAFAAAAAACAAABAgAQowAAAP8AAwAAAAAAMAAAbgAAAADAAQEAEgAAADABAO8CAAAAwAEDADABAI0EAAAAwAEFADABAO0GAAAAggACAAcDDwYAAwQGAQMHBgIDDgMAAQIBAAEYAAAAAQACAAAACgAABQAADgEAAAAAAwWBvLbYl8bUbuyNZZNUf1t1mavCN0XWtw==

-- decompilation:
local v0 = {};
v0.__index = v0;
v0.new = function(v1) --[[ Line: 4 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy)
    local v2 = {};
    setmetatable(v2, v0);
    v2.Texture = v1;
    v2.Sprites = {};
    return v2;
end;
v0.AddSprite = function(v3, v4, v5, v6) --[[ Line: 14 ]] --[[ Name: AddSprite ]]
    local v7 = {
        Position = v5, 
        Size = v6
    };
    v3.Sprites[v4] = v7;
end;
v0.GetSprite = function(v8, _, v10) --[[ Line: 19 ]] --[[ Name: GetSprite ]]
    if not v10 then
        warn("Image name cannot be nil");
        return false;
    else
        local v11 = v8.Sprites[v10];
        if not v11 then
            warn("Could not find sprite for: " .. v10);
            return false;
        else
            return {
                ImageRectOffset = v11.Position, 
                ImageRectSize = v11.Size, 
                Image = v8.Texture
            };
        end;
    end;
end;
return v0;
