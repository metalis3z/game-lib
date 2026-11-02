-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Keys = require(game.ReplicatedStorage.UserGenerated.Lang.Keys)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local Stringify = require(game.ReplicatedStorage.UserGenerated.Strings.Stringify)
local v3 = {
    Pretty = true,
    IndentChar = " ",
    IndentSize = 2
}

local function GetPrefix(v4) -- line 11
    local sln, sln_2, sln_3 = debug.info((v4 or 0) + 2, "sln")
    local v5 = ("%*:%*"):format(sln, sln_2)
    if sln_3 then
        v5 ..= (" %*"):format(sln_3)
    end
    return (("[%*]"):format(v5))
end

local function Format(v6) -- line 20 | captures: Stringify, v3
    if type(v6) == "string" then
        return v6
    end
    if typeof(v6) == "Instance" then
        return (("%*[%*]"):format(v6.ClassName, (v6:GetFullName())))
    end
    return Stringify.Serialize(v6, v3)
end

local function FormatArgs(...) -- line 30 | captures: Stringify, v3
    local v7 = table.pack(...)
    local n = v7.n
    for v8 = 1, n do
        local v9 = v7[v8]
        if type(v9) ~= "string" then
            if typeof(v9) == "Instance" then
                v9 = ("%*[%*]"):format(v9.ClassName, (v9:GetFullName()))
            else
                v9 = Stringify.Serialize(v9, v3)
            end
        end
        v7[v8] = v9
    end
    return table.unpack(v7)
end

local function v1(...) -- line 48 | captures: FormatArgs
    local sln, sln_2, sln_3 = debug.info(2, "sln")
    local v10 = ("%*:%*"):format(sln, sln_2)
    if sln_3 then
        v10 ..= (" %*"):format(sln_3)
    end
    task.spawn(function(v11, ...) -- line 55 | captures: FormatArgs
        print(v11, FormatArgs(...))
    end, ("[%*]"):format(v10), ...)
end

local function v2(...) -- line 59 | captures: FormatArgs
    local sln, sln_2, sln_3 = debug.info(2, "sln")
    local v12 = ("%*:%*"):format(sln, sln_2)
    if sln_3 then
        v12 ..= (" %*"):format(sln_3)
    end
    task.spawn(function(v13, ...) -- line 66 | captures: FormatArgs
        warn(v13, FormatArgs(...))
    end, ("[%*]"):format(v12), ...)
end

local v14, v15

if RunService:IsStudio() then
    v14, v15 = print, warn
else
    v14 = v1
    v15 = v2
end

local function u37() -- line 74
end

local v16 = {
    Trace = 1,
    Debug = 2,
    Info = 3,
    Warn = 4,
    Error = 5,
    Critical = 6,
    Off = 7
}
table.freeze(v16)
local v17 = {
    Trace = v14,
    Debug = v14,
    Info = v14,
    Warn = v15,
    Error = v15,
    Critical = v15,
    Off = u37
}
table.freeze(v17)
local v18 = Asserts.Set(Keys(v16))
local v19 = table.clone(v17)
local v20 = "Info"

local function SetLevel(v21, v22) -- line 98 | captures: v20, u37, v16, v17, v19
    local v23 = v16[v21]
    assert(v23)
    local v24 = if v22 == nil then true else type(v22) == "boolean"
    assert(v24)
    if v20 == v21 then
        return
    end
    v20 = v21
    local v25 = v16[v21]
    local v26 = assert(v25)
    for v27, v28 in pairs(v16) do
        if v28 < v26 then
            v19[v27] = u37
        else
            v19[v27] = v17[v27]
        end
    end
end

SetLevel(v20, true)
local v29 = {
    Levels = v16,
    AssertLevel = v18
}
local v30 = { __index = v19 }
setmetatable(v29, v30)

function v29.GetLevel() -- line 120 | captures: v20
    return v20
end

function v29.SetLevel(v31) -- line 123 | captures: SetLevel
    SetLevel(v31)
end

function v29.Sink(v32) -- line 126 | captures: v19
    local v33 = v19[v32]
    return assert(v33)
end

return table.freeze(v29)
