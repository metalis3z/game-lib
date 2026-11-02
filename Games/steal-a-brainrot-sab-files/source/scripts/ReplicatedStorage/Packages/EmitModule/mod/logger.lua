
local function v_u_1(...)
    return ("[Forge Emit API]: %*"):format((table.concat({ ... }, " ")))
end
return {
    ["error"] = function(...)
        error(v_u_1(..., "\n"))
    end,
    ["warn"] = function(...)
        warn(v_u_1(...))
        warn(v_u_1(debug.traceback("stack trace:")))
    end,
    ["info"] = function(...)
        print(v_u_1(...))
    end
}