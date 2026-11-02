

local v0 = require("./state");
local _ = require("./types");
return {
    create_command_context = function(v2, v3)
        assert(not v0.command_context[coroutine.running()], "there is already a command context for this thread");
        v0.command_context[coroutine.running()] = {
            executor = v2, 
            invocation_id = v3
        };
        return function()
            v0.command_context[coroutine.running()] = nil;
        end;
    end, 
    get_command_context = function()
        return v0.command_context[coroutine.running()];
    end
};