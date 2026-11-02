-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)

local function Derive(v1, v2) -- line 7
    local BlockSize = v1.BlockSize
    local v3
    if BlockSize < buffer.len(v2) then
        v3 = v1.DigestBuffer(v2)
    else
        v3 = v2
    end
    local v4 = buffer.create(BlockSize)
    buffer.copy(v4, 0, v3)
    local v5 = buffer.create(BlockSize)
    local v6 = buffer.create(BlockSize)
    local v7 = BlockSize - 1
    for v8 = 0, v7 do
        local v9 = buffer.readu8(v4, v8)
        local v10 = bit32.bxor(v9, 92)
        buffer.writeu8(v5, v8, v10)
        local v11 = bit32.bxor(v9, 54)
        buffer.writeu8(v6, v8, v11)
    end

    local function ComputeHmac(v12) -- line 25 | captures: v1, BlockSize, v5, v6
        local v13 = buffer.create(BlockSize + buffer.len(v12))
        buffer.copy(v13, 0, v6)
        buffer.copy(v13, BlockSize, v12)
        local v14 = v1.DigestBuffer(v13)
        local v15 = buffer.create(BlockSize + buffer.len(v14))
        buffer.copy(v15, 0, v5)
        buffer.copy(v15, BlockSize, v14)
        return v1.DigestBuffer(v15)
    end

    local v16 = {
        Name = "HMAC-" .. v1.Name,
        BlockSize = v1.BlockSize,
        OutputSize = v1.OutputSize
    }

    function v16.Digest(v17) -- line 39 | captures: ComputeHmac
        return buffer.tostring(ComputeHmac(buffer.fromstring(v17)))
    end

    v16.DigestBuffer = ComputeHmac

    function v16.DigestToBuffer(v18) -- line 43 | captures: ComputeHmac
        return ComputeHmac(buffer.fromstring(v18))
    end

    return v16
end

local v19 = { Derive = Derive }

function v19.DeriveString(v20, v21) -- line 50 | captures: Derive
    return (Derive(v20, buffer.fromstring(v21)))
end

return v19
