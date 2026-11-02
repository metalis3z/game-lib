-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local AES = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.AES)
local Base64 = require(game.ReplicatedStorage.UserGenerated.IO.Base64)
local HMAC = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.HMAC)
local ISAAC = require(game.ReplicatedStorage.UserGenerated.Randoms.ISAAC)
local SHA256 = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.SHA256)
require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)
local v1 = ISAAC.Unique()

local function GetRandomBytes(v2) -- line 14 | captures: v1
    local v3 = buffer.create(v2)
    local v4 = v2 - 1
    for v5 = 0, v4 do
        local v6 = v1:NextInteger(0, 255)
        buffer.writeu8(v3, v5, v6)
    end
    return v3
end

local function PBKDF2(v7, v8, v9, v10, v11) -- line 23 | captures: HMAC
    local v12 = HMAC.Derive(v11, v7)
    local OutputSize = v11.OutputSize
    local v13 = v9 / OutputSize
    local v14 = math.ceil(v13)
    local v15 = buffer.create(v9)
    local v16 = 0
    for v17 = 1, v14 do
        local v18 = buffer.create(buffer.len(v8) + 4)
        buffer.copy(v18, 0, v8)
        local v19 = buffer.len(v8)
        local v20 = bit32.byteswap(v17)
        buffer.writeu32(v18, v19, v20)
        local v21 = v12.DigestBuffer(v18)
        local v22 = buffer.create(buffer.len(v21))
        buffer.copy(v22, 0, v21)
        for v23 = 2, v10 do
            v21 = v12.DigestBuffer(v21)
            local v24 = buffer.len(v21) - 1
            for v25 = 0, v24 do
                local v26 = buffer.readu8(v22, v25)
                local v27 = buffer.readu8(v21, v25)
                local v28 = bit32.bxor(v26, v27)
                buffer.writeu8(v22, v25, v28)
            end
        end
        local v29 = v9 - v16
        local v30 = math.min(OutputSize, v29)
        buffer.copy(v15, v16, v22, 0, v30)
        v16 += v30
    end
    return v15
end

local function ApplyPKCS7Padding(v31) -- line 59
    local v32 = buffer.len(v31)
    local v33 = 16 - v32 % 16
    local v34 = v32 + v33
    local v35 = buffer.create(v34)
    buffer.copy(v35, 0, v31)
    local v36 = v34 - 1
    for v37 = v32, v36 do
        buffer.writeu8(v35, v37, v33)
    end
    return v35
end

local function RemovePKCS7Padding(v38) -- line 72
    local v39 = buffer.len(v38)
    if v39 == 0 then
        error("Invalid padding: empty input")
    end
    local v40 = v39 - 1
    local v41 = buffer.readu8(v38, v40)
    if v41 < 1 then
        error("Invalid padding length: " .. v41)
    elseif v41 <= 16 then
    end
    local v42 = v39 - 1
    local v43 = v39 - v41
    for v44 = v43, v42 do
        if buffer.readu8(v38, v44) ~= v41 then
            error("Invalid padding")
        end
    end
    local v45 = v39 - v41
    local v46 = buffer.create(v45)
    buffer.copy(v46, 0, v38, 0, v45)
    return v46
end

local function Encrypt(v47, v48, v49) -- line 95 | captures: AES, Base64, SHA256, GetRandomBytes, PBKDF2, ApplyPKCS7Padding
    local v50 = v49 or SHA256
    local v51 = buffer.fromstring(v47)
    local v52 = GetRandomBytes(8)
    local v53 = PBKDF2(v48, v52, 48, 10000, v50)
    local v54 = buffer.create(32)
    buffer.copy(v54, 0, v53, 0, 32)
    local v55 = buffer.create(16)
    buffer.copy(v55, 0, v53, 32, 16)
    local v56 = ApplyPKCS7Padding(v51)
    local v57 = buffer.tostring(v54)
    local v58 = AES.new(v57, AES.modes.CBC, AES.pads.None):Encrypt(v56, nil, v55)
    local v59 = 16 + buffer.len(v58)
    local v60 = buffer.create(v59)
    buffer.writestring(v60, 0, "Salted__")
    buffer.copy(v60, 8, v52)
    buffer.copy(v60, 16, v58)
    return buffer.tostring(Base64.EncodeBuffer(v60))
end

local function Decrypt(v61, v62, v63) -- line 118 | captures: AES, Base64, SHA256, PBKDF2, RemovePKCS7Padding
    local v64 = v63 or SHA256
    local v65 = Base64.DecodeBuffer(buffer.fromstring(v61))
    if buffer.len(v65) < 16 then
        error("Invalid data: too short")
    end
    local v66 = buffer.create(8)
    buffer.copy(v66, 0, v65, 0, 8)
    if buffer.tostring(v66) ~= "Salted__" then
        error("Invalid data: Missing 'Salted__' header")
    end
    local v67 = buffer.create(8)
    buffer.copy(v67, 0, v65, 8, 8)
    local v68 = buffer.len(v65) - 16
    local v69 = buffer.create(v68)
    buffer.copy(v69, 0, v65, 16, v68)
    local v70 = PBKDF2(v62, v67, 48, 10000, v64)
    local v71 = buffer.create(32)
    buffer.copy(v71, 0, v70, 0, 32)
    local v72 = buffer.create(16)
    buffer.copy(v72, 0, v70, 32, 16)
    local v73 = buffer.tostring(v71)
    local v74 = AES.new(v73, AES.modes.CBC, AES.pads.None):Decrypt(v69, nil, v72)
    local v75 = RemovePKCS7Padding(v74)
    return buffer.tostring(v75)
end

local v76 = {
    Encrypt = Encrypt,
    Decrypt = Decrypt
}

function v76.EncryptString(v77, v78, v79) -- line 152 | captures: Encrypt
    local v80 = buffer.fromstring(v78)
    return Encrypt(v77, v80, v79)
end

function v76.DecryptString(v81, v82, v83) -- line 156 | captures: Decrypt
    local v84 = buffer.fromstring(v82)
    return Decrypt(v81, v84, v83)
end

v76.PBKDF2 = PBKDF2
v76.GetRandomBytes = GetRandomBytes
table.freeze(v76)
return v76
