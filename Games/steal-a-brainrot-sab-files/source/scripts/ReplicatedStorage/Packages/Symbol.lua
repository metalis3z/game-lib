

return function(v0)
    local v1 = newproxy(true);
    if not v0 then
        v0 = "";
    end;
    getmetatable(v1).__tostring = function()
        return "Symbol(" .. v0 .. ")";
    end;
    return v1;
end;