-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TokenBucket = require(ReplicatedStorage.Shared.Modules.TokenBucket)
local v1 = require(ReplicatedStorage.Packages.Log).new():AtWarning():Wrap()
local t = require(ReplicatedStorage.Packages.t)

local function callerName() -- line 10
    for v2 = 2, 8 do
        local s = debug.info(v2, "s")
        if s == nil then
            break
        end
        local v3 = string.match(s, "([^%.]-)$") or ""
        if v3 ~= "" and v3 ~= "RateLimiter" then
            return v3
        end
    end
    return ""
end

local function watch(v5, v6) -- line 27
    if v5.watched[v6] then
        return
    end
    v5.watched[v6] = true
    v6.Destroying:Connect(function() -- line 30 | captures: v5, v6
        v5:Reset(v6)
        v5.watched[v6] = nil
    end)
end

local function requireBucket(v7, v8) -- line 36 | captures: t
    local function v9(v10, ...)
        assert(v10, ...)
    end

    t.strict(t.optional(t.string))(v8)
    if v8 then
        v9(v7.buckets[v8] and v8 ~= "Global", string.format("no endpoint named '%s' is configured on this limiter", v8))
    end
end

local function charge(v11, v12, v13) -- line 47 | captures: TokenBucket
    if TokenBucket.Spend(v13, v12) then
        return true
    end
    if v13.causesBan then
        v11:ApplyBan(v12)
    end
    return false
end

local v14 = {}

function v14.ApplyBan(v15, v16, v17) -- line 61 | captures: v1, t
    t.strict(t.instanceIsA("Player"))(v16)
    t.strict(t.optional(t.number))(v17)
    local v18 = v15.bannedUntil[v16]
    local v19 = workspace:GetServerTimeNow() + (v17 or v15.banSeconds)
    if v18 ~= nil then
        v19 = math.max(v19, v18)
    end
    v15.bannedUntil[v16] = v19
    if v15.warns and v18 == nil then
        v1(string.format(v15.logFormat, "BAN", v16.Name, v16.UserId, "Banned!"))
    end
end

function v14.RemoveBan(v20, v21) -- line 84 | captures: v1, t
    t.strict(t.instanceIsA("Player"))(v21)
    if v20.bannedUntil[v21] then
        v20.bannedUntil[v21] = nil
        return true
    end
    local v22 = string.format(v20.logFormat, "BAN", v21.Name, v21.UserId, "lifted a ban that was never applied")
    return false, v1(v22)
end

function v14.IsBanned(v23, v24) -- line 94 | captures: t
    t.strict(t.instanceIsA("Player"))(v24)
    local v25 = v23.bannedUntil[v24]
    local v26 = if v25 == nil then false else v25 < workspace:GetServerTimeNow()
    if v26 then
        v23.bannedUntil[v24] = nil
    end
    if v25 == nil then
        return false
    end
    return not v26
end

function v14.Reset(v27, v28) -- line 105 | captures: TokenBucket
    local v29
    if v28 then
        v29 = { v28 }
    else
        v29 = game.Players:GetPlayers()
    end
    for v30, v31 in ipairs(v29) do
        v27.bannedUntil[v31] = nil
        for v32, v33 in pairs(v27.buckets) do
            TokenBucket.Forget(v33, v31)
        end
    end
end

function v14.Limit(v34, v35, v36) -- line 120 | captures: t, charge
    local function v37(v38, ...)
        assert(v38, ...)
    end

    t.strict(t.instanceIsA("Player"))(v35)
    t.strict(t.optional(t.string))(v36)
    if v36 then
        v37(v34.buckets[v36] and v36 ~= "Global", string.format("no endpoint named '%s' is configured on this limiter", v36))
    end
    if not v34.watched[v35] then
        v34.watched[v35] = true
        v35.Destroying:Connect(function() -- line 135 | captures: v34, v35
            v34:Reset(v35)
            v34.watched[v35] = nil
        end)
    end
    local v39 = v36 and v34.buckets[v36]
    local Global = v34.buckets.Global
    local v40
    if v34.retired then
        v40 = (nil).Message.GARBAGE_COLLECTED
    elseif v34:IsBanned(v35) then
        v40 = (nil).Message.TEMP_BANNED
    elseif v39 then
        if charge(v34, v35, v39) then
        else
            v40 = (nil).Message.STANDARD_ERROR
        end
    elseif Global then
        if charge(v34, v35, Global) then
        else
            v40 = (nil).Message.STANDARD_ERROR
        end
    end
    if v40 then
        return false, v40
    end
    return true
end

local v41 = {
    DefaultBanLength = 60,
    DefaultWarn = true,
    Message = {
        STANDARD_ERROR = "You're doing that too fast!",
        TEMP_BANNED = "You're on cooldown. Please try again later.",
        GARBAGE_COLLECTED = "Endpoint not permitted."
    },
    LogTemplates = { BAN = "[RATE LIMIT][%*] (%*): %*, %*: (%*)" }
}

function v41.new(v42) -- line 168 | captures: TokenBucket, t, callerName, v14
    t.strict(t.table)(v42)
    t.strict(t.optional(t.number))(v42.BanLength)
    local v43 = v42.Global or v42.Endpoints
    assert(v43, "a limiter needs at least one endpoint")
    local v44 = {}
    if v42.Global then
        v44.Global = TokenBucket.Build("Global", v42.Global)
    end
    local v45 = v42.Endpoints or {}
    for v46, v47 in pairs(v45) do
        local v48 = v46 ~= "Global"
        assert(v48, "the global endpoint is configured through Global")
        v44[v46] = TokenBucket.Build(v46, v47)
    end
    local v49 = next(v44) ~= nil
    assert(v49, "a limiter needs at least one endpoint")
    local v50 = v4.Id or callerName()
    local v51 = {
        retired = false,
        label = v50,
        logFormat = string.format((nil).LogTemplates.BAN, "%*", v50, "%*", "%*", "%*")
    }
    if v4.Warn == nil then
        v51.warns = (nil).DefaultWarn
    else
        v51.warns = v4.Warn
    end
    v51.buckets = v44
    v51.bannedUntil = {}
    v51.banSeconds = v4.BanLength or (nil).DefaultBanLength
    v51.watched = {}
    local v52 = { __index = v14 }
    return (setmetatable(v51, v52))
end

function v41.AllowOnce() -- line 216
    return (nil).new({
        BanLength = (1/0),
        Global = { MaximumTokens = 1 }
    })
end

function v41.AllowPerSecond(v53, v54) -- line 222 | captures: t
    local v55 = v53 > 0
    assert(v55, "a per-second allowance needs a positive rate")
    t.strict(t.optional(t.number))(v54)
    return (nil).new({
        BanLength = (nil).DefaultBanLength,
        Global = {
            Ban = false,
            MaximumTokens = v54 or 1,
            Refresh = {
                {
                    Tokens = 1,
                    Interval = 1 / v53
                }
            }
        }
    })
end

return v41
