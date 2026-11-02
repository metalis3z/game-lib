local v0 = {
    __mode = "k"
};
local function v8(v1, v2)
    local v3 = {};
    for _, v5 in ipairs(v2) do
        v3[v5] = v5;
    end;
    return (setmetatable(v3, {
        __index = function(_, v7)
            error(string.format("%s is not in %s!", v7, v1), 2);
        end, 
        __newindex = function()
            error(string.format("Creating new members in %s is not allowed!", v1), 2);
        end
    }));
end;
local v9 = {
    Kind = v8("Promise.Error.Kind", {
        "ExecutionError", 
        "AlreadyCancelled", 
        "NotResolvedInTime", 
        "TimedOut"
    })
};
v9.__index = v9;
v9.new = function(v10, v11)
    local v12 = v10 or {};
    return (setmetatable({
        error = tostring(v12.error) or "[This error has no error text.]", 
        trace = v12.trace, 
        context = v12.context, 
        kind = v12.kind, 
        parent = v11, 
        createdTick = os.clock(), 
        createdTrace = debug.traceback()
    }, v9));
end;
v9.is = function(v13)
    if type(v13) == "table" then
        local v14 = getmetatable(v13);
        if type(v14) == "table" then
            local _ = nil;
            if rawget(v13, "error") == nil then
                return false;
            else
                return type((rawget(v14, "extend"))) == "function";
            end;
        end;
    end;
    return false;
end;
v9.isKind = function(v16, v17)
    assert(v17 ~= nil, "Argument #2 to Promise.Error.isKind must not be nil");
    return v9.is(v16) and v16.kind == v17;
end;
v9.extend = function(v18, v19)
    local v20 = v19 or {};
    v20.kind = v20.kind or v18.kind;
    return v9.new(v20, v18);
end;
v9.getErrorChain = function(v21)
    local v22 = {
        v21
    };
    while v22[#v22].parent do
        table.insert(v22, v22[#v22].parent);
    end;
    return v22;
end;
v9.__tostring = function(v23)
    local v24 = {
        string.format("-- Promise.Error(%s) --", v23.kind or "?")
    };
    for _, v26 in ipairs(v23:getErrorChain()) do
        table.insert(v24, table.concat({
            v26.trace or v26.error, 
            v26.context
        }, "\n"));
    end;
    return table.concat(v24, "\n");
end;
local function v27(...)
    return select("#", ...), {
        ...
    };
end;
local function v29(v28, ...)
    return v28, select("#", ...), {
        ...
    };
end;
local function v35(v30, v31, ...)
    local l_v29_0 = v29;
    local l_xpcall_0 = xpcall;
    assert(v30 ~= nil, "traceback is nil");
    return l_v29_0(l_xpcall_0(v31, function(v34)
        if type(v34) == "table" then
            return v34;
        else
            return v9.new({
                error = v34, 
                kind = v9.Kind.ExecutionError, 
                trace = debug.traceback(tostring(v34), 2), 
                context = "Promise created at:\n\n" .. v30
            });
        end;
    end, ...));
end;
local v36 = {
    Error = v9, 
    Status = v8("Promise.Status", {
        "Started", 
        "Resolved", 
        "Rejected", 
        "Cancelled"
    }), 
    _getTime = os.clock, 
    _timeEvent = game:GetService("RunService").Heartbeat, 
    _unhandledRejectionCallbacks = {}, 
    prototype = {}
};
v36.__index = v36.prototype;
v36._new = function(v37, v38, v39)
    if v39 ~= nil and not v36.is(v39) then
        error("Argument #2 to Promise.new must be a promise or nil", 2);
    end;
    local v40 = {
        _thread = nil, 
        _source = v37, 
        _status = v36.Status.Started, 
        _values = nil, 
        _valuesLength = -1, 
        _unhandledRejection = true, 
        _queuedResolve = {}, 
        _queuedReject = {}, 
        _queuedFinally = {}, 
        _cancellationHook = nil, 
        _parent = v39, 
        _consumers = setmetatable({}, v0)
    };
    if v39 and v39._status == v36.Status.Started then
        v39._consumers[v40] = true;
    end;
    setmetatable(v40, v36);
    local function v41(...)
        v40:_resolve(...);
    end;
    local function v42(...)
        v40:_reject(...);
    end;
    local function v44(v43)
        if v43 then
            if v40._status == v36.Status.Cancelled then
                v43();
            else
                v40._cancellationHook = v43;
            end;
        end;
        return v40._status == v36.Status.Cancelled;
    end;
    v40._thread = coroutine.create(function()
        local v45, _, v47 = v35(v40._source, v38, v41, v42, v44);
        if not v45 then 
            v42(v47[1]);
        end;
    end);
    task.spawn(v40._thread);
    return v40;
end;
v36.new = function(v48)
    return v36._new(debug.traceback(nil, 2), v48);
end;
v36.__tostring = function(v49)
    return string.format("Promise(%s)", v49._status);
end;
v36.defer = function(v50)
    local v51 = debug.traceback(nil, 2);
    return v36._new(v51, function(v52, v53, v54)
        local v55 = nil;
        v55 = v36._timeEvent:Connect(function()
            v55:Disconnect();
            local v56, _, v58 = v35(v51, v50, v52, v53, v54);
            if not v56 then
                v53(v58[1]);
            end;
        end);
    end);
end;
v36.async = v36.defer;
v36.resolve = function(...)
    local v59, v60 = v27(...);
    return v36._new(debug.traceback(nil, 2), function(v61)
        v61(unpack(v60, 1, v59));
    end);
end;
v36.reject = function(...)
    local v62, v63 = v27(...);
    return v36._new(debug.traceback(nil, 2), function(_, v65)
        v65(unpack(v63, 1, v62));
    end);
end;
v36._try = function(v66, v67, ...)
    local v68, v69 = v27(...);
    return v36._new(v66, function(v70)
        v70(v67(unpack(v69, 1, v68)));
    end);
end;
v36.try = function(v71, ...)
    return v36._try(debug.traceback(nil, 2), v71, ...);
end;
v36._all = function(v72, v73, v74)
    if type(v73) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3);
    end;
    for v75, v76 in pairs(v73) do
        if not v36.is(v76) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(v75))), 3);
        end;
    end;
    if not (#v73 ~= 0) or v74 == 0 then
        return v36.resolve({});
    else
        return v36._new(v72, function(v77, v78, v79)
            local v80 = {};
            local v81 = {};
            local v82 = 0;
            local v83 = 0;
            local v84 = false;
            local function v88(v85, ...)
                if not v84 then
                    v82 = v82 + 1;
                    if v74 == nil then
                        v80[v85] = ...;
                    else
                        v80[v82] = ...;
                    end;
                    if v82 >= (v74 or #v73) then
                        v84 = true;
                        v77(v80);
                        for _, v87 in ipairs(v81) do
                            v87:cancel();
                        end;
                    end;
                end;
            end;
            v79(function()
                for _, v90 in ipairs(v81) do
                    v90:cancel();
                end;
            end);
            for v91, v92 in ipairs(v73) do
                v81[v91] = v92:andThen(function(...)
                    v88(v91, ...);
                end, function(...)
                    v83 = v83 + 1;
                    if not (v74 ~= nil) or #v73 - v83 < v74 then
                        for _, v94 in ipairs(v81) do
                            v94:cancel();
                        end;
                        v84 = true;
                        v78(...);
                    end;
                end);
            end;
            if v84 then
                for _, v96 in ipairs(v81) do
                    v96:cancel();
                end;
            end;
        end);
    end;
end;
v36.all = function(v97)
    return v36._all(debug.traceback(nil, 2), v97);
end;
v36.fold = function(v98, v99, v100)
    assert(type(v98) == "table", "Bad argument #1 to Promise.fold: must be a table");
    local v101 = nil;
    if type(v99) == "function" then
        v101 = true;
    else
        local v102 = false;
        if type(v99) == "table" then
            v102 = getmetatable(v99);
        end;
        v101 = if v102 then type((rawget(v102, "__call"))) == "function" else false;
    end;
    assert(v101, "Bad argument #2 to Promise.fold: must be a function");
    local v103 = v36.resolve(v100);
    return v36.each(v98, function(v104, v105)
        v103 = v103:andThen(function(v106)
            return v99(v106, v104, v105);
        end);
    end):andThen(function()
        return v103;
    end);
end;
v36.some = function(v107, v108)
    assert(type(v108) == "number", "Bad argument #2 to Promise.some: must be a number");
    return v36._all(debug.traceback(nil, 2), v107, v108);
end;
v36.any = function(v109)
    return v36._all(debug.traceback(nil, 2), v109, 1):andThen(function(v110)
        return v110[1];
    end);
end;
v36.allSettled = function(v111)
    if type(v111) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2);
    end;
    for v112, v113 in pairs(v111) do
        if not v36.is(v113) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(v112))), 2);
        end;
    end;
    if #v111 == 0 then
        return v36.resolve({});
    else
        return v36._new(debug.traceback(nil, 2), function(v114, _, v116)
            local v117 = {};
            local v118 = {};
            local v119 = 0;
            local function v121(v120, ...)
                v119 = v119 + 1;
                v117[v120] = ...;
                if v119 >= #v111 then
                    v114(v117);
                end;
            end;
            v116(function()
                for _, v123 in ipairs(v118) do
                    v123:cancel();
                end;
            end);
            for v124, v125 in ipairs(v111) do
                v118[v124] = v125:finally(function(...)
                    v121(v124, ...);
                end);
            end;
        end);
    end;
end;
v36.race = function(v126)
    assert(type(v126) == "table", string.format("Please pass a list of promises to %s", "Promise.race"));
    for v127, v128 in pairs(v126) do
        assert(v36.is(v128), string.format("Non-promise value passed into %s at index %s", "Promise.race", (tostring(v127))));
    end;
    return v36._new(debug.traceback(nil, 2), function(v129, v130, v131)
        local v132 = {};
        local v133 = false;
        if not v131(function(...)
            for _, v135 in ipairs(v132) do
                v135:cancel();
            end;
            v133 = true;
            return v130(...);
        end) then
            for v136, v137 in ipairs(v126) do
                v132[v136] = v137:andThen(function(...)
                    for _, v139 in ipairs(v132) do
                        v139:cancel();
                    end;
                    v133 = true;
                    return v129(...);
                end, function(...)
                    for _, v141 in ipairs(v132) do
                        v141:cancel();
                    end;
                    v133 = true;
                    return v130(...);
                end);
            end;
            if v133 then
                for _, v143 in ipairs(v132) do
                    v143:cancel();
                end;
            end;
        end;
    end);
end;
v36.each = function(v144, v145)
    assert(type(v144) == "table", string.format("Please pass a list of promises to %s", "Promise.each"));
    local v146 = nil;
    if type(v145) == "function" then
        v146 = true;
    else
        local v147 = false;
        if type(v145) == "table" then
            v147 = getmetatable(v145);
        end;
        v146 = if v147 then type((rawget(v147, "__call"))) == "function" else false;
    end;
    assert(v146, string.format("Please pass a handler function to %s!", "Promise.each"));
    return v36._new(debug.traceback(nil, 2), function(v148, v149, v150)
        local v151 = {};
        local v152 = {};
        local v153 = false;
        v150(function()
            v153 = true;
            for _, v155 in ipairs(v152) do
                v155:cancel();
            end;
        end);
        local v156 = {};
        for v157, v158 in ipairs(v144) do
            if v36.is(v158) then
                if v158:getStatus() == v36.Status.Cancelled then
                    for _, v160 in ipairs(v152) do
                        v160:cancel();
                    end;
                    return v149(v9.new({
                        error = "Promise is cancelled", 
                        kind = v9.Kind.AlreadyCancelled, 
                        context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", v157, v158._source)
                    }));
                elseif v158:getStatus() == v36.Status.Rejected then
                    for _, v162 in ipairs(v152) do
                        v162:cancel();
                    end;
                    return v149(select(2, v158:await()));
                else
                    local v163 = v158:andThen(function(...)
                        return ...;
                    end);
                    table.insert(v152, v163);
                    v156[v157] = v163;
                end;
            else
                v156[v157] = v158;
            end;
        end;
        for v164, v165 in ipairs(v156) do
            if v36.is(v165) then
                local v166, v167 = v165:await();
                if not v166 then
                    for _, v169 in ipairs(v152) do
                        v169:cancel();
                    end;
                    return v149(v167);
                end;
            end;
            if v153 then
                return;
            else
                local v170 = v36.resolve(v145(v165, v164));
                table.insert(v152, v170);
                local v171, v172 = v170:await();
                if not v171 then
                    for _, v174 in ipairs(v152) do
                        v174:cancel();
                    end;
                    return v149(v172);
                else
                    v151[v164] = v172;
                end;
            end;
        end;
        v148(v151);
    end);
end;
v36.is = function(v175)
    if type(v175) ~= "table" then
        return false;
    else
        local v176 = getmetatable(v175);
        if v176 == v36 then
            return true;
        elseif v176 ~= nil then
            if type(v176) == "table" and type((rawget(v176, "__index"))) == "table" then
                local v177 = rawget(rawget(v176, "__index"), "andThen");
                local v178 = nil;
                if type(v177) == "function" then
                    v178 = true;
                else
                    local v179 = false;
                    if type(v177) == "table" then
                        v179 = getmetatable(v177);
                    end;
                    v178 = if v179 then type((rawget(v179, "__call"))) == "function" else false;
                end;
                if v178 then
                    return true;
                end;
            end;
            return false;
        else
            local l_andThen_0 = v175.andThen;
            if type(l_andThen_0) == "function" then
                return true;
            else
                local v181 = false;
                if type(l_andThen_0) == "table" then
                    v181 = getmetatable(l_andThen_0);
                end;
                if v181 and type((rawget(v181, "__call"))) == "function" then
                    return true;
                else
                    return false;
                end;
            end;
        end;
    end;
end;
v36.promisify = function(v182)
    return function(...)
        return v36._try(debug.traceback(nil, 2), v182, ...);
    end;
end;
local v183 = nil;
local v184 = nil;
v36.delay = function(v185)
    assert(type(v185) == "number", "Bad argument #1 to Promise.delay, must be a number.");
    local v186 = (not (v185 >= 0.016666666666666666) or v185 == 1e999) and 0.016666666666666666 or v185;
    return v36._new(debug.traceback(nil, 2), function(v187, _, v189)
        local v190 = v36._getTime();
        local v191 = v190 + v186;
        local v192 = {
            resolve = v187, 
            startTime = v190, 
            endTime = v191
        };
        if v184 == nil then
            v183 = v192;
            v184 = v36._timeEvent:Connect(function()
                local v193 = v36._getTime();
                while v183 ~= nil and v183.endTime < v193 do
                    local l_v183_0 = v183;
                    v183 = l_v183_0.next;
                    if v183 == nil then
                        v184:Disconnect();
                        v184 = nil;
                    else
                        v183.previous = nil;
                    end;
                    l_v183_0.resolve(v36._getTime() - l_v183_0.startTime);
                end;
            end);
        elseif v183.endTime < v191 then
            local l_v183_1 = v183;
            local l_next_0 = l_v183_1.next;
            while l_next_0 ~= nil and l_next_0.endTime < v191 do
                local l_next_1 = l_next_0.next;
                l_v183_1 = l_next_0;
                l_next_0 = l_next_1;
            end;
            l_v183_1.next = v192;
            v192.previous = l_v183_1;
            if l_next_0 ~= nil then
                v192.next = l_next_0;
                l_next_0.previous = v192;
            end;
        else
            v192.next = v183;
            v183.previous = v192;
            v183 = v192;
        end;
        v189(function()
            local l_next_2 = v192.next;
            if v183 == v192 then
                if l_next_2 == nil then
                    v184:Disconnect();
                    v184 = nil;
                else
                    l_next_2.previous = nil;
                end;
                v183 = l_next_2;
                return;
            else
                local l_previous_0 = v192.previous;
                l_previous_0.next = l_next_2;
                if l_next_2 ~= nil then
                    l_next_2.previous = l_previous_0;
                end;
                return;
            end;
        end);
    end);
end;
v36.prototype.timeout = function(v200, v201, v202)
    local v203 = debug.traceback(nil, 2);
    return v36.race({
        v36.delay(v201):andThen(function()
            return v36.reject(v202 == nil and v9.new({
                kind = v9.Kind.TimedOut, 
                error = "Timed out", 
                context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", v201, v203)
            }) or v202);
        end), 
        v200
    });
end;
v36.prototype.getStatus = function(v204)
    return v204._status;
end;
v36.prototype._andThen = function(v205, v206, v207, v208)
    v205._unhandledRejection = false;
    if v205._status ~= v36.Status.Cancelled then
        return v36._new(v206, function(v209, v210, v211)
            local v212 = nil;
            if v207 then
                local l_v206_0 = v206;
                local l_v207_0 = v207;
                local l_l_v206_0_0 = l_v206_0 --[[ copy: 4 -> 6 ]];
                local l_l_v207_0_0 = l_v207_0 --[[ copy: 5 -> 7 ]];
                v212 = function(...)
                    local v217, v218, v219 = v35(l_l_v206_0_0, l_l_v207_0_0, ...);
                    if v217 then
                        v209(unpack(v219, 1, v218));
                        return;
                    else
                        v210(v219[1]);
                        return;
                    end;
                end;
            else
                v212 = v209;
            end;
            if v208 then
                local l_v206_1 = v206;
                local l_v208_0 = v208;
                v210 = function(...)
                    local v222, v223, v224 = v35(l_v206_1, l_v208_0, ...);
                    if v222 then
                        v209(unpack(v224, 1, v223));
                        return;
                    else
                        v210(v224[1]);
                        return;
                    end;
                end;
            end;
            if v205._status == v36.Status.Started then
                table.insert(v205._queuedResolve, v212);
                table.insert(v205._queuedReject, v210);
                v211(function()
                    if v205._status == v36.Status.Started then
                        table.remove(v205._queuedResolve, table.find(v205._queuedResolve, v212));
                        table.remove(v205._queuedReject, table.find(v205._queuedReject, v210));
                    end;
                end);
            elseif v205._status == v36.Status.Resolved then
                v212(unpack(v205._values, 1, v205._valuesLength));
            elseif v205._status == v36.Status.Rejected then
                v210(unpack(v205._values, 1, v205._valuesLength));
            end;
        end, v205);
    else
        local v225 = v36.new(function()

        end);
        v225:cancel();
        return v225;
    end;
end;
v36.prototype.andThen = function(v226, v227, v228)
    local v229 = nil;
    if v227 == nil then
        v229 = true;
    elseif type(v227) == "function" then
        v229 = true;
    else
        local v230 = false;
        if type(v227) == "table" then
            v230 = getmetatable(v227);
        end;
        v229 = if v230 then type((rawget(v230, "__call"))) == "function" else false;
    end;
    assert(v229, string.format("Please pass a handler function to %s!", "Promise:andThen"));
    local v231 = nil;
    if v228 == nil then
        v231 = true;
    elseif type(v228) == "function" then
        v231 = true;
    else
        local v232 = false;
        if type(v228) == "table" then
            v232 = getmetatable(v228);
        end;
        v231 = if v232 then type((rawget(v232, "__call"))) == "function" else false;
    end;
    assert(v231, string.format("Please pass a handler function to %s!", "Promise:andThen"));
    return v226:_andThen(debug.traceback(nil, 2), v227, v228);
end;
v36.prototype.catch = function(v233, v234)
    local v235 = nil;
    if v234 == nil then
        v235 = true;
    elseif type(v234) == "function" then
        v235 = true;
    else
        local v236 = false;
        if type(v234) == "table" then
            v236 = getmetatable(v234);
        end;
        v235 = if v236 then type((rawget(v236, "__call"))) == "function" else false;
    end;
    assert(v235, string.format("Please pass a handler function to %s!", "Promise:catch"));
    return v233:_andThen(debug.traceback(nil, 2), nil, v234);
end;
v36.prototype.tap = function(v237, v238)
    local v239 = nil;
    if type(v238) == "function" then
        v239 = true;
    else
        local v240 = false;
        if type(v238) == "table" then
            v240 = getmetatable(v238);
        end;
        v239 = if v240 then type((rawget(v240, "__call"))) == "function" else false;
    end;
    assert(v239, string.format("Please pass a handler function to %s!", "Promise:tap"));
    return v237:_andThen(debug.traceback(nil, 2), function(...)
        local v241 = v238(...);
        if not v36.is(v241) then
            return ...;
        else
            local v242, v243 = v27(...);
            return v241:andThen(function()
                return unpack(v243, 1, v242);
            end);
        end;
    end);
end;
v36.prototype.andThenCall = function(v244, v245, ...)
    local v246 = nil;
    if type(v245) == "function" then
        v246 = true;
    else
        local v247 = false;
        if type(v245) == "table" then
            v247 = getmetatable(v245);
        end;
        v246 = if v247 then type((rawget(v247, "__call"))) == "function" else false;
    end;
    assert(v246, string.format("Please pass a handler function to %s!", "Promise:andThenCall"));
    local v248, v249 = v27(...);
    return v244:_andThen(debug.traceback(nil, 2), function()
        return v245(unpack(v249, 1, v248));
    end);
end;
v36.prototype.andThenReturn = function(v250, ...)
    local v251, v252 = v27(...);
    return v250:_andThen(debug.traceback(nil, 2), function()
        return unpack(v252, 1, v251);
    end);
end;
v36.prototype.cancel = function(v253)
    if v253._status == v36.Status.Started then
        v253._status = v36.Status.Cancelled;
        if v253._cancellationHook then
            v253._cancellationHook();
        end;
        coroutine.close(v253._thread);
        if v253._parent then
            v253._parent:_consumerCancelled(v253);
        end;
        for v254 in pairs(v253._consumers) do
            v254:cancel();
        end;
        v253:_finalize();
    end;
end;
v36.prototype._consumerCancelled = function(v255, v256)
    if v255._status == v36.Status.Started then
        v255._consumers[v256] = nil;
        if next(v255._consumers) == nil then
            v255:cancel();
        end;
    end;
end;
v36.prototype._finally = function(v257, v258, v259)
    v257._unhandledRejection = false;
    return v36._new(v258, function(v260, v261, v262)
        local v263 = nil;
        v262(function()
            v257:_consumerCancelled(v257);
            if v263 then
                v263:cancel();
            end;
        end);
        local v266 = v259 and function(...)
            local v264 = v259(...);
            if v36.is(v264) then
                v263 = v264;
                v264:finally(function(v265)
                    if v265 ~= v36.Status.Rejected then
                        v260(v257);
                    end;
                end):catch(function(...)
                    v261(...);
                end);
                return;
            else
                v260(v257);
                return;
            end;
        end or v260;
        if v257._status == v36.Status.Started then
            table.insert(v257._queuedFinally, v266);
        else
            v266(v257._status);
        end;
    end);
end;
v36.prototype.finally = function(v267, v268)
    local v269 = nil;
    if v268 == nil then
        v269 = true;
    elseif type(v268) == "function" then
        v269 = true;
    else
        local v270 = false;
        if type(v268) == "table" then
            v270 = getmetatable(v268);
        end;
        v269 = if v270 then type((rawget(v270, "__call"))) == "function" else false;
    end;
    assert(v269, string.format("Please pass a handler function to %s!", "Promise:finally"));
    return v267:_finally(debug.traceback(nil, 2), v268);
end;
v36.prototype.finallyCall = function(v271, v272, ...)
    local v273 = nil;
    if type(v272) == "function" then
        v273 = true;
    else
        local v274 = false;
        if type(v272) == "table" then
            v274 = getmetatable(v272);
        end;
        v273 = if v274 then type((rawget(v274, "__call"))) == "function" else false;
    end;
    assert(v273, string.format("Please pass a handler function to %s!", "Promise:finallyCall"));
    local v275, v276 = v27(...);
    return v271:_finally(debug.traceback(nil, 2), function()
        return v272(unpack(v276, 1, v275));
    end);
end;
v36.prototype.finallyReturn = function(v277, ...)
    local v278, v279 = v27(...);
    return v277:_finally(debug.traceback(nil, 2), function()
        return unpack(v279, 1, v278);
    end);
end;
v36.prototype.awaitStatus = function(v280)
    v280._unhandledRejection = false;
    if v280._status == v36.Status.Started then
        local v281 = coroutine.running();
        v280:finally(function()
            task.spawn(v281);
        end):catch(function()

        end);
        coroutine.yield();
    end;
    if v280._status == v36.Status.Resolved then
        return v280._status, unpack(v280._values, 1, v280._valuesLength);
    elseif v280._status ~= v36.Status.Rejected then
        return v280._status;
    else
        return v280._status, unpack(v280._values, 1, v280._valuesLength);
    end;
end;
local function v283(v282, ...)
    return v282 == v36.Status.Resolved, ...;
end;
v36.prototype.await = function(v284)
    return v283(v284:awaitStatus());
end;
local function v286(v285, ...)
    if v285 ~= v36.Status.Resolved then
        error(... == nil and "Expected Promise rejected with no value." or ..., 3);
    end;
    return ...;
end;
v36.prototype.expect = function(v287)
    return v286(v287:awaitStatus());
end;
v36.prototype.awaitValue = v36.prototype.expect;
v36.prototype._unwrap = function(v288)
    if v288._status == v36.Status.Started then
        error("Promise has not resolved or rejected.", 2);
    end;
    return v288._status == v36.Status.Resolved, unpack(v288._values, 1, v288._valuesLength);
end;
v36.prototype._resolve = function(v289, ...)
    if v289._status == v36.Status.Started then
        if v36.is((...)) then
            if select("#", ...) > 1 then
                local v290 = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", v289._source);
                warn(v290);
            end;
            local v291 = ...;
            local v293 = v291:andThen(function(...)
                v289:_resolve(...);
            end, function(...)
                local v292 = v291._values[1];
                if v291._error then
                    v292 = v9.new({
                        error = v291._error, 
                        kind = v9.Kind.ExecutionError, 
                        context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]"
                    });
                end;
                if v9.isKind(v292, v9.Kind.ExecutionError) then
                    return v289:_reject(v292:extend({
                        error = "This Promise was chained to a Promise that errored.", 
                        trace = "", 
                        context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", v289._source)
                    }));
                else
                    v289:_reject(...);
                    return;
                end;
            end);
            if v293._status == v36.Status.Cancelled then
                v289:cancel();
                return;
            elseif v293._status == v36.Status.Started then
                v289._parent = v293;
                v293._consumers[v289] = true;
                return;
            else
                return;
            end;
        else
            v289._status = v36.Status.Resolved;
            local v294, v295 = v27(...);
            v289._valuesLength = v294;
            v289._values = v295;
            for _, v297 in ipairs(v289._queuedResolve) do
                coroutine.wrap(v297)(...);
            end;
            v289:_finalize();
            return;
        end;
    else
        if v36.is((...)) then
            (...):_consumerCancelled(v289);
        end;
        return;
    end;
end;
v36.prototype._reject = function(v298, ...)
    if v298._status == v36.Status.Started then
        v298._status = v36.Status.Rejected;
        local v299, v300 = v27(...);
        v298._valuesLength = v299;
        v298._values = v300;
        local l__queuedReject_0 = v298._queuedReject;
        if next(l__queuedReject_0) == nil then
            local v302 = tostring((...));
            coroutine.wrap(function()
                v36._timeEvent:Wait();
                if v298._unhandledRejection then
                    local v303 = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", v302, v298._source);
                    for _, v305 in ipairs(v36._unhandledRejectionCallbacks) do
                        task.spawn(v305, v298, unpack(v298._values, 1, v298._valuesLength));
                    end;
                    if not v36.TEST then
                        warn(v303);
                        return;
                    else
                        return;
                    end;
                else
                    return;
                end;
            end)();
        else
            for _, v307 in ipairs(v298._queuedReject) do
                coroutine.wrap(v307)(...);
            end;
        end;
        v298:_finalize();
    end;
end;
v36.prototype._finalize = function(v308)
    for _, v310 in ipairs(v308._queuedFinally) do
        coroutine.wrap(v310)(v308._status);
    end;
    v308._queuedFinally = nil;
    v308._queuedReject = nil;
    v308._queuedResolve = nil;
    if not v36.TEST then
        v308._parent = nil;
        v308._consumers = nil;
    end;
    task.defer(coroutine.close, v308._thread);
end;
v36.prototype.now = function(v311, v312)
    local v313 = debug.traceback(nil, 2);
    if v311._status == v36.Status.Resolved then
        return v311:_andThen(v313, function(...)
            return ...;
        end);
    else
        local l_reject_0 = v36.reject;
        if v312 == nil then
            v312 = v9.new({
                kind = v9.Kind.NotResolvedInTime, 
                error = "This Promise was not resolved in time for :now()", 
                context = ":now() was called at:\n\n" .. v313
            }) or v312;
        end;
        return l_reject_0(v312);
    end;
end;
v36.retry = function(v315, v316, ...)
    local v317 = nil;
    if type(v315) == "function" then
        v317 = true;
    else
        local v318 = false;
        if type(v315) == "table" then
            v318 = getmetatable(v315);
        end;
        v317 = if v318 then type((rawget(v318, "__call"))) == "function" else false;
    end;
    assert(v317, "Parameter #1 to Promise.retry must be a function");
    assert(type(v316) == "number", "Parameter #2 to Promise.retry must be a number");
    local v319 = {
        ...
    };
    local v320 = select("#", ...);
    return v36.resolve(v315(...)):catch(function(...)
        if v316 <= 0 then
            return v36.reject(...);
        else
            local l_v319_0 = v319;
            local l_v320_0 = v320;
            return v36.retry(v315, v316 - 1, unpack(l_v319_0, 1, l_v320_0));
        end;
    end);
end;
v36.retryWithDelay = function(v323, v324, v325, ...)
    local v326 = nil;
    if type(v323) == "function" then
        v326 = true;
    else
        local v327 = false;
        if type(v323) == "table" then
            v327 = getmetatable(v323);
        end;
        v326 = if v327 then type((rawget(v327, "__call"))) == "function" else false;
    end;
    assert(v326, "Parameter #1 to Promise.retry must be a function");
    assert(type(v324) == "number", "Parameter #2 (times) to Promise.retry must be a number");
    assert(type(v325) == "number", "Parameter #3 (seconds) to Promise.retry must be a number");
    local v328 = {
        ...
    };
    local v329 = select("#", ...);
    return v36.resolve(v323(...)):catch(function(...)
        if v324 <= 0 then
            return v36.reject(...);
        else
            v36.delay(v325):await();
            local l_v328_0 = v328;
            local l_v329_0 = v329;
            return v36.retryWithDelay(v323, v324 - 1, v325, unpack(l_v328_0, 1, l_v329_0));
        end;
    end);
end;
v36.fromEvent = function(v332, v333)
    local v334 = v333 or function()
        return true;
    end;
    return v36._new(debug.traceback(nil, 2), function(v335, _, v337)
        local v338 = nil;
        local v339 = false;
        local function v340()
            v338:Disconnect();
            v338 = nil;
        end;
        v338 = v332:Connect(function(...)
            local v341 = v334(...);
            if v341 == true then
                v335(...);
                if v338 then
                    v338:Disconnect();
                    v338 = nil;
                    return;
                else
                    v339 = true;
                    return;
                end;
            else
                if type(v341) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean");
                end;
                return;
            end;
        end);
        if v339 and v338 then
            return v340();
        else
            v337(v340);
            return;
        end;
    end);
end;
v36.onUnhandledRejection = function(v342)
    table.insert(v36._unhandledRejectionCallbacks, v342);
    return function()
        local v343 = table.find(v36._unhandledRejectionCallbacks, v342);
        if v343 then
            table.remove(v36._unhandledRejectionCallbacks, v343);
        end;
    end;
end;
return v36;