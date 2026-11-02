-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}

v1.__index = v1

function v1.new(v2, v3, v4) -- line 5 | captures: v1
    local v5 = {
        Timeout = v2,
        Generate = v3,
        Cleanup = v4,
        All = {},
        Free = {},
        InUse = {},
        LastUse = {}
    }
    return (setmetatable(v5, v1))
end

local function Release(v6, v7) -- line 23
    local v8 = tick()
    v6.LastUse[v7] = v8
    coroutine.resume(coroutine.create(function() -- line 30 | captures: v6, v7, v8
        wait(v6.Timeout)
        if v6.LastUse[v7] == v8 then
            v6:Remove(v7)
        end
    end))
    v6.Cleanup(v7)
    v6.InUse[v7] = nil
    v6.Free[v7] = true
end

v1.Release = Release

local function Get(v9) -- line 46
    local v10 = next(v9.Free) or v9.Generate()
    v9.Free[v10] = nil
    v9.LastUse[v10] = nil
    v9.All[v10] = true
    v9.InUse[v10] = true
    return v10
end

v1.Get = Get

local function Remove(v11, v12) -- line 62
    v11.Free[v12] = nil
    v11.InUse[v12] = nil
    v11.LastUse[v12] = nil
    v11.All[v12] = nil
    v12:Destroy()
end

v1.Remove = Remove

local function ReleaseAll(v13) -- line 70
    for v14 in pairs(v13.InUse) do
        v13:Release(v14)
    end
end

v1.ReleaseAll = ReleaseAll

local function Generate() -- line 76
    error("No instance generation callback specified", 2)
end

v1.Generate = Generate

local function Cleanup(v15) -- line 81
    v15.Parent = nil
end

v1.Cleanup = Cleanup
return v1
