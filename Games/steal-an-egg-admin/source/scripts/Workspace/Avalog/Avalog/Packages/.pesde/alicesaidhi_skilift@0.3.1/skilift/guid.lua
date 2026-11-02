-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "a",
    "b",
    "c",
    "d",
    "e",
    "f"
}

local function generate_guid() -- line 3 | captures: v1
    local v2 = buffer.create(32)
    for v3 = 0, 31 do
        local v4 = v1[math.random(1, 16)]
        local v5 = string.byte(v4)
        buffer.writeu8(v2, v3, v5)
    end
    return buffer.tostring(v2)
end

return generate_guid
