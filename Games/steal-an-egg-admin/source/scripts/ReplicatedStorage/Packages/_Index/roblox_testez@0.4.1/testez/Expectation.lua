-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local v2 = {
    to = true,
    be = true,
    been = true,
    have = true,
    was = true,
    at = true
}
local v3 = { never = true }

local function assertLevel(v4, v5, v6) -- line 16
    if not v4 then
        error(v5 or "Assertion failed!", (v6 or 1) + 1)
    end
end

local function bindSelf(v7, v8) -- line 21
    return function(v9, ...) -- line 22 | captures: v7, v8
        if v9 == v7 then
            return v8(v7, ...)
        end
        return v8(v7, v9, ...)
    end
end

local function formatMessage(v10, v11, v12) -- line 29
    if v10 then
        return v11
    end
    return v12
end

function v1.new(v13) -- line 35 | captures: v1
    local v14 = {
        successCondition = true,
        condition = false,
        value = v13,
        matchers = {},
        _boundMatchers = {}
    }
    setmetatable(v14, v1)
    local a = v14.a

    function v14.a(v15, ...) -- line 45 | captures: v14, a
        if v15 == v14 then
            return a(v14, ...)
        end
        return a(v14, v15, ...)
    end

    v14.an = v14.a
    local ok = v14.ok

    function v14.ok(v16, ...) -- line 53 | captures: v14, ok
        if v16 == v14 then
            return ok(v14, ...)
        end
        return ok(v14, v16, ...)
    end

    local equal = v14.equal

    function v14.equal(v17, ...) -- line 60 | captures: v14, equal
        if v17 == v14 then
            return equal(v14, ...)
        end
        return equal(v14, v17, ...)
    end

    local throw = v14.throw

    function v14.throw(v18, ...) -- line 67 | captures: v14, throw
        if v18 == v14 then
            return throw(v14, ...)
        end
        return throw(v14, v18, ...)
    end

    local near = v14.near

    function v14.near(v19, ...) -- line 74 | captures: v14, near
        if v19 == v14 then
            return near(v14, ...)
        end
        return near(v14, v19, ...)
    end

    return v14
end

function v1.checkMatcherNameCollisions(v20) -- line 82 | captures: v1, v2, v3
    return not not (not v2[v20] and not v3[v20] and not v1[v20])
end

local function extend(v21, v22) -- line 88
    v21.matchers = v22 or {}
    for v23, v24 in pairs(v21.matchers) do
        local v25 = v24

        local u20 = function(v26, ...) -- u20 | line 95 | captures: v21, v25
            local v27 = v25(v21.value, ...)
            if v27.pass ~= v21.successCondition then
                error(v27.message or "Assertion failed!", 4)
            end
            v21:_resetModifiers()
            return v21
        end

        local _boundMatchers = v21._boundMatchers

        _boundMatchers[v23] = function(v28, ...) -- line 104 | captures: v21, u20
            if v28 == v21 then
                return u20(v21, ...)
            end
            return u20(v21, v28, ...)
        end
    end
    return v21
end

v1.extend = extend

function v1.__index(v29, v30) -- line 113 | captures: v1, v2, v3
    if v2[v30] then
        return v29
    end
    if v3[v30] then
        local v31 = v1.new(v29.value):extend(v29.matchers)
        v31.successCondition = not v29.successCondition
        return v31
    end
    if v29._boundMatchers[v30] then
        return v29._boundMatchers[v30]
    end
    return v1[v30]
end

local function _resetModifiers(v32) -- line 127
    v32.successCondition = true
end

v1._resetModifiers = _resetModifiers

local function a(v33, v34) -- line 130
    local value = v33.value
    local v35 = type(value) == v34 == v33.successCondition
    local value_2 = v33.value
    local v36 = tostring(value_2)
    local value_3 = v33.value
    local v37 = ("Expected value of type %q, got value %q of type %s"):format(v34, v36, (type(value_3)))
    local value_4 = v33.value
    local v38 = tostring(value_4)
    if not v33.successCondition then
        local value = v33.value
        v37 = ("Expected value not of type %q, got value %q of type %s"):format(v34, v38, (type(value)))
    end
    if not v35 then
        error(v37 or "Assertion failed!", 4)
    end
    v33:_resetModifiers()
    return v33
end

v1.a = a
v1.an = v1.a

local function ok(v39) -- line 148
    local v40 = v39.value ~= nil == v39.successCondition
    local value = v39.value
    local v41 = ("Expected value %q to be non-nil"):format((tostring(value)))
    if not v39.successCondition then
        local value = v39.value
        v41 = ("Expected value %q to be nil"):format((tostring(value)))
    end
    if not v40 then
        error(v41 or "Assertion failed!", 4)
    end
    v39:_resetModifiers()
    return v39
end

v1.ok = ok

local function equal(v42, v43) -- line 163
    local v44 = v42.value == v43 == v42.successCondition
    local v45 = tostring(v43)
    local v46 = type(v43)
    local value = v42.value
    local v47 = tostring(value)
    local value_2 = v42.value
    local v48 = ("Expected value %q (%s), got %q (%s) instead"):format(v45, v46, v47, (type(value_2)))
    local v49 = tostring(v43)
    if not v42.successCondition then
        v48 = ("Expected anything but value %q (%s)"):format(v49, (type(v43)))
    end
    if not v44 then
        error(v48 or "Assertion failed!", 4)
    end
    v42:_resetModifiers()
    return v42
end

v1.equal = equal

local function near(v50, v51, v52) -- line 182
    local value = v50.value
    local v53 = type(value) == "number"
    assert(v53, "Expectation value must be a number to use 'near'")
    local v54 = type(v51) == "number"
    assert(v54, "otherValue must be a number")
    local v55 = if type(v52) == "number" then true else v52 == nil
    assert(v55, "limit must be a number or nil")
    local v56 = v52 or 0.0000001
    local v57 = v50.value - v51
    local v58 = math.abs(v57) <= v56 == v50.successCondition
    local v59 = ("Expected value to be near %f (within %f) but got %f instead"):format(v51, v56, v50.value)
    if not v50.successCondition then
        v59 = ("Expected value to not be near %f (within %f) but got %f instead"):format(v51, v56, v50.value)
    end
    if not v58 then
        error(v59 or "Assertion failed!", 4)
    end
    v50:_resetModifiers()
    return v50
end

v1.near = near

local function throw(v60, v61) -- line 204
    local v62, v63 = pcall(v60.value)
    local v64 = v62 ~= v60.successCondition
    local v65
    if v61 then
        if not v62 then
            if v60.successCondition then
                v64 = v63:find(v61, 1, true) ~= nil
            else
                v64 = v63:find(v61, 1, true) == nil
            end
        end
        local successCondition = v60.successCondition
        local v66
        if v63 then
            v66 = ("threw: %s"):format(v63)
        else
            v66 = "did not throw."
        end
        v65 = ("Expected function to throw an error containing %q, but it %s"):format(v61, v66)
        if not successCondition then
            v65 = ("Expected function to never throw an error containing %q, but it threw: %s"):format(v61, (tostring(v63)))
        end
    elseif v60.successCondition then
        v65 = "Expected function to throw an error, but it did not throw."
    else
        v65 = ("Expected function to succeed, but it threw an error: %s"):format((tostring(v63)))
    end
    if not v64 then
        error(v65 or "Assertion failed!", 4)
    end
    v60:_resetModifiers()
    return v60
end

v1.throw = throw
return v1
