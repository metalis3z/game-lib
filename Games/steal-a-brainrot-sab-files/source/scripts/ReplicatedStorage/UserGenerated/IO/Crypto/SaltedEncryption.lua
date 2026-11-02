

--!native
local v0 = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.AES);
local v1 = require(game.ReplicatedStorage.UserGenerated.IO.Base64);
local v2 = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.HMAC);
local v3 = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.SHA256);
local _ = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);
local function v22(v5, v6, v7, v8, v9)
    local v10 = v2.Derive(v9, v5);
    local l_OutputSize_0 = v9.OutputSize;
    local v12 = math.ceil(v7 / l_OutputSize_0);
    local v13 = buffer.create(v7);
    local v14 = 0;
    for v15 = 1, v12 do
        local v16 = buffer.create(buffer.len(v6) + 4);
        buffer.copy(v16, 0, v6);
        buffer.writeu32(v16, buffer.len(v6), (bit32.byteswap(v15)));
        local v17 = v10.DigestBuffer(v16);
        local v18 = buffer.create(buffer.len(v17));
        buffer.copy(v18, 0, v17);
        for _ = 2, v8 do
            v17 = v10.DigestBuffer(v17);
            for v20 = 0, buffer.len(v17) - 1 do
                buffer.writeu8(v18, v20, (bit32.bxor(buffer.readu8(v18, v20), (buffer.readu8(v17, v20)))));
            end;
        end;
        local v21 = math.min(l_OutputSize_0, v7 - v14);
        buffer.copy(v13, v14, v18, 0, v21);
        v14 = v14 + v21;
    end;
    return v13;
end;
local function _(v23)
    local v24 = buffer.len(v23);
    local v25 = 16 - v24 % 16;
    local v26 = v24 + v25;
    local v27 = buffer.create(v26);
    buffer.copy(v27, 0, v23);
    for v28 = v24, v26 - 1 do
        buffer.writeu8(v27, v28, v25);
    end;
    return v27;
end;
local function v36(v30)
    local v31 = buffer.len(v30);
    if v31 == 0 then
        error("Invalid padding: empty input");
    end;
    local v32 = buffer.readu8(v30, v31 - 1);
    if v32 < 1 or v32 > 16 then
        error("Invalid padding length: " .. v32);
    end;
    for v33 = v31 - v32, v31 - 1 do
        if buffer.readu8(v30, v33) ~= v32 then
            error("Invalid padding");
        end;
    end;
    local v34 = v31 - v32;
    local v35 = buffer.create(v34);
    buffer.copy(v35, 0, v30, 0, v34);
    return v35;
end;
local function v51(v37, v38, v39)
    local v40 = v39 or v3;
    local v41 = v1.DecodeBuffer(buffer.fromstring(v37));
    if buffer.len(v41) < 16 then
        error("Invalid data: too short");
    end;
    local v42 = buffer.create(8);
    buffer.copy(v42, 0, v41, 0, 8);
    if buffer.tostring(v42) ~= "Salted__" then
        error("Invalid data: Missing 'Salted__' header");
    end;
    local v43 = buffer.create(8);
    buffer.copy(v43, 0, v41, 8, 8);
    local v44 = buffer.len(v41) - 16;
    local v45 = buffer.create(v44);
    buffer.copy(v45, 0, v41, 16, v44);
    local v46 = v22(v38, v43, 48, 10000, v40);
    local v47 = buffer.create(32);
    buffer.copy(v47, 0, v46, 0, 32);
    local v48 = buffer.create(16);
    buffer.copy(v48, 0, v46, 32, 16);
    local v49 = v0.new(buffer.tostring(v47), v0.modes.CBC, v0.pads.None):Decrypt(v45, nil, v48);
    local v50 = v36(v49);
    return buffer.tostring(v50);
end;
local v55 = {
    Decrypt = v51, 
    DecryptString = function(v52, v53, v54)
        return v51(v52, buffer.fromstring(v53), v54);
    end, 
    PBKDF2 = v22
};
table.freeze(v55);
return v55;