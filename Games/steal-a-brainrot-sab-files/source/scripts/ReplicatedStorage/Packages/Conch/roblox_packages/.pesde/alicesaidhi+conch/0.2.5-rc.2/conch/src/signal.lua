

local _ = require("./types");
return function()
    local v1 = {};
    return {
        connect = function(_, v3)
            local v4 = false;
            local v5 = {
                callback = v3
            };
            v5.disconnect = function()
                if v4 then
                    return;
                else
                    v4 = true;
                    v5.disconnected = true;
                    local v6 = table.find(v1, v5);
                    if not v6 then
                        return;
                    else
                        table.remove(v1, v6);
                        return;
                    end;
                end;
            end;
            table.insert(v1, v5);
            return v5;
        end, 
        fire = function(_, ...)
            for _, v9 in v1 do
                v9.callback(...);
            end;
        end
    };
end;