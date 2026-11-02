-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    RetryCount = 0,
    _IsAttempt = true
}

v1.__index = v1

local function __tostring(v2) -- line 11
    return v2.Id:gsub("table", "Attempt")
end

v1.__tostring = __tostring

local function PackageProtectedCall(...) -- line 16
    return ..., { select(2, ...) }
end

local function IsAttempt(v3) -- line 20
    local v4 = getmetatable(v3)
    return v4 and v4._IsAttempt or false
end

local function Try(v5, ...) -- line 31 | captures: v1
    local v6 = {}
    v6.Id = tostring(v6)
    setmetatable(v6, v1)
    return v6:Execute(v5, { ... })
end

function v1.Execute(v7, v8, v9) -- line 44 | captures: PackageProtectedCall
    local v10, v11 = PackageProtectedCall(pcall(v8, unpack(v9)))
    v7.Function = v8
    v7.Arguments = v9
    v7.Success = v10
    v7.Results = v11
    if not v10 then
        v7.Stack = debug.traceback()
        v7.Skips = {}
    end
    return v7
end

local function Then(v12, v13) -- line 67
    local v14 = v12.Results[1]
    local v15
    if v12.Success then
        local v16 = getmetatable(v14)
        if v16 and v16._IsAttempt then
            v15 = v14
        else
            v15 = v12
        end
    else
        v15 = v12
    end
    if v15.Success then
        v15:Execute(v13, v15.Results)
    else
        v15.Skips[#v15.Skips + 1] = v13
    end
    return v15
end

v1.Then = Then

function v1.Catch(v17, ...) -- line 90 | captures: Try
    local v18 = v17
    local v19 = v17.Results[1]
    local v20
    if v17.Success then
        local v21 = getmetatable(v19)
        if v21 and v21._IsAttempt then
            v18 = v19
            v20 = v19
        else
            v20 = v17
        end
    else
        v20 = v17
    end
    if not (v20.Success or v20.Handled) then
        local v22 = { ... }
        local v23 = #v22 - 1
        local v24 = v22[v23 + 1]
        v20.Skips[#v20.Skips + 1] = v22
        local v25 = v20.Results[1]
        local v26
        if v23 == 0 then
            v26 = true
        elseif type(v25) == "string" then
            v26 = false
            for v27 = 1, v23 do
                if v25:match(v22[v27]) then
                    v26 = true
                    break
                end
                v26 = false
            end
        else
            v26 = false
        end
        if v26 then
            return Try(v24, v25, v20.Stack, v20):Then(function() -- line 134 | captures: v18
                v18.Handled = true
                return v18
            end)
        end
    end
    return v20
end

local function Retry(v28) -- line 145
    if v28.Success then
        return
    end
    local Skips = v28.Skips
    v28.Handled = nil
    v28.Skips = nil
    v28.Stack = nil
    v28.RetryCount += 1
    v28:Execute(v28.Function, v28.Arguments)
    if v28.Success then
        v28.RetryCount = nil
    end
    local v29 = #Skips
    local v30 = v28
    for v31 = 1, v29 do
        local v32 = Skips[v31]
        local v33 = getmetatable(v32)
        if type(v32) ~= "function" and (not v33 or not v33.__call) then
            v30 = v30:Catch(unpack(v32))
        else
            v30 = v30:Then(v32)
        end
    end
    return v30
end

v1.Retry = Retry
return Try
