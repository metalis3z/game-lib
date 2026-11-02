-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Encode = require(script.Encode)
local Reflection = require(script.Reflection)
local fastIndex = Encode.fastIndex
local v1 = {
    "Workspace",
    "Players",
    "Lighting",
    "MaterialService",
    "ReplicatedFirst",
    "ReplicatedStorage",
    "SoundService",
    "StarterGui",
    "StarterPack",
    "StarterPlayer",
    "Teams",
    "TextChatService"
}
local v2 = { "ServerScriptService", "ServerStorage" }

local function encodeId(v3) -- line 25
    local v4 = {}
    local v5 = v3
    while true do
        local v6 = #v4 + 1
        local v7 = v5 % 256
        v4[v6] = string.char(v7)
        v5 //= 256
        if v5 == 0 then
            break
        end
    end
    return table.concat(v4)
end

local v8 = {}

function v8.capture(v9, v10) -- line 38 | captures: RunService, Encode, Reflection, fastIndex, v1, v2, encodeId
    local v11 = v9 or {}
    local v12 = v11.properties == true
    local v13 = v11.yielding ~= false
    local v14
    if v10 then
        if v10 > 0 then
            v14 = v10
        end
    else
        v14 = 0.016666666666666666
    end
    local v15 = v14 * 0.33
    local v16 = os.clock() + 30
    local v17 = {}
    local v18 = {}

    local function classIdx(v19) -- line 56 | captures: v17, v18
        local v20 = v18[v19]
        if v20 then
            return v20
        end
        local v21 = #v17
        v17[v21 + 1] = v19
        v18[v19] = v21
        return v21
    end

    local v22 = {}
    local v23 = {}

    local function propIdx(v24) -- line 68 | captures: v22, v23
        local v25 = v23[v24]
        if v25 then
            return v25
        end
        local v26 = #v22
        v22[v26 + 1] = v24
        v23[v24] = v26
        return v26
    end

    local v27 = {}
    local v28 = 0
    local v29 = {}

    local function assign(v30) -- line 81 | captures: v28, v27, v29, encodeId
        local v31 = v27[v30]
        if v31 then
            return v31
        end
        v28 += 1
        local v32 = encodeId(v28)
        v27[v30] = v32
        v29[#v29 + 1] = v30
        return v32
    end

    local game_2 = game
    local v33
    if v27[game_2] then
        v33 = 0
    else
        v33 = v28 + 1
        v28 = v33
        v27[game_2] = encodeId(v28)
        v29[#v29 + 1] = game_2
    end
    local v34 = table.clone(v1)
    if RunService:IsServer() then
        for v35, v36 in v2 do
            table.insert(v34, v36)
        end
    end
    for v37, v38 in v34 do
        local v39 = v38
        local v40, v41 = pcall(function() -- line 111 | captures: v39
            return game:GetService(v39)
        end)
        u397 = v41
        if v40 and u397 then
            if not v27[u397] then
                v33 = v28 + 1
                v28 = v33
                v27[u397] = encodeId(v28)
                v29[#v29 + 1] = u397
            end
            local v42, v43 = pcall(function() -- line 120
                return u397:GetDescendants()
            end)
            if v42 and v43 then
                local v44 = v33
                for v45, v46 in v43 do
                    if not v27[v46] then
                        v44 = v28 + 1
                        v28 = v44
                        v27[v46] = encodeId(v28)
                        v29[#v29 + 1] = v46
                    end
                    v33 = v44
                end
            end
        end
    end
    local v47 = Encode.newWriter(262144)
    v47:u8(68)
    v47:u8(1)
    local v48 = if v12 then 1 else 0
    v47:u8(v48)
    local v49, v50 = 0, os.clock()
    local v51 = false
    for v52, v53 in v29 do
        if v53 ~= game then
            local Parent, Parent_2 = pcall(fastIndex, v53, "Parent")
            if Parent and Parent_2 ~= nil then
                local v54 = v27[Parent_2] or ""
                if v54 ~= "" then
                    local ClassName, ClassName_2 = pcall(fastIndex, v53, "ClassName")
                    if ClassName and type(ClassName_2) == "string" then
                        local Name, Name_2 = pcall(fastIndex, v53, "Name")
                        if Name then
                            if type(Name_2) == "string" then
                            end
                        else
                            Name_2 = ClassName_2
                        end
                        v47:strU8(v27[v53])
                        v47:strU8(v54)
                        local v55 = v18[ClassName_2]
                        if not v55 then
                            v55 = #v17
                            v17[v55 + 1] = ClassName_2
                            v18[ClassName_2] = v55
                        end
                        v47:u16(v55)
                        v47:strU16(Name_2)
                        if v12 then
                            local v56 = Reflection.getReadProperties(ClassName_2)
                            local len = v47.len
                            v47:u16(0)
                            local v57 = 0
                            for v58, v59 in v56 do
                                local v60, v61 = pcall(fastIndex, v53, v59)
                                if v60 then
                                    local v62 = v23[v59]
                                    if not v62 then
                                        v62 = #v22
                                        v22[v62 + 1] = v59
                                        v23[v59] = v62
                                    end
                                    v47:u16(v62)
                                    Encode.writeValue(v47, v61)
                                    v57 += 1
                                end
                            end
                            v47:patchU16(len, v57)
                        end
                        v49 += 1
                        if v47.len >= 50331648 then
                            v51 = true
                            break
                        end
                        if v13 and v49 >= 20 then
                            local v63 = os.clock()
                            if v16 <= v63 then
                                return { TimedOut = true }
                            end
                            if v15 <= v63 - v50 then
                                task.wait()
                                v49, v50 = 0, os.clock()
                            end
                        end
                    end
                end
            end
        end
        v51 = false
    end
    return {
        Buffer = v47:finish(),
        Classes = v17,
        Props = v22,
        Truncated = v51
    }
end

return v8
