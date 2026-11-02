

return ((function(v0)
    return (setmetatable({}, {
        __index = v0, 
        __metatable = false, 
        __newindex = function(v1, v2, v3)
            error("Attempt to modify read-only table: " .. v1 .. ", key=" .. v2 .. ", value=" .. v3);
        end
    }));
end)({
    Start = "Start", 
    Complete = "Complete", 
    Fail = "Fail"
}));