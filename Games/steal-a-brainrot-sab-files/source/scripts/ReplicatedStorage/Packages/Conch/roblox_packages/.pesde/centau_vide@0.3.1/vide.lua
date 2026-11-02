

local v0 = {
    major = 0, 
    minor = 3, 
    patch = 1
};
if not game then
    script = require("test/relative-string");
end;
local v1 = require(script.root);
local v2 = require(script.mount);
local v3 = require(script.create);
local v4 = require(script.apply);
local v5 = require(script.source);
local v6 = require(script.effect);
local v7 = require(script.derive);
local v8 = require(script.cleanup);
local v9 = require(script.untrack);
local v10 = require(script.read);
local v11 = require(script.batch);
local v12 = require(script.context);
local v13 = require(script.switch);
local v14 = require(script.show);
local v15, v16 = require(script.maps)();
local v17, v18 = require(script.spring)();
local v19 = require(script.action)();
local v20 = require(script.changed);
local v21 = require(script.throw);
local v22 = require(script.flags);
local function v24(v23)
    if game then
        debug.profilebegin("VIDE STEP");
        debug.profilebegin("VIDE SPRING");
    end;
    v18(v23);
    if game then
        debug.profileend();
        debug.profileend();
    end;
end;
local v26 = game and game:GetService("RunService"):IsClient() and game:GetService("RunService").Heartbeat:Connect(function(v25)
    task.defer(v24, v25);
end);
local v30 = {
    version = v0, 
    root = v1, 
    mount = v2, 
    create = v3, 
    source = v5, 
    effect = v6, 
    derive = v7, 
    switch = v13, 
    show = v14, 
    indexes = v15, 
    values = v16, 
    cleanup = v8, 
    untrack = v9, 
    read = v10, 
    batch = v11, 
    context = v12, 
    spring = v17, 
    action = v19, 
    changed = v20, 
    strict = nil, 
    apply = function(v27)
        return function(v28)
            v4(v27, v28);
            return v27;
        end;
    end, 
    step = function(v29)
        if v26 then
            v26:Disconnect();
            v26 = nil;
        end;
        v24(v29);
    end
};
setmetatable(v30, {
    __index = function(_, v32)
        if v32 == "strict" then
            return v22.strict;
        else
            v21((("%* is not a valid member of vide"):format((tostring(v32)))));
            return;
        end;
    end, 
    __newindex = function(_, v34, v35)
        if v34 == "strict" then
            v22.strict = v35;
            return;
        else
            v21((("%* is not a valid member of vide"):format((tostring(v34)))));
            return;
        end;
    end
});
return v30;