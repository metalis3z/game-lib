-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = { __mode = "k" }

local function isCallable(v2) -- line 7
    if type(v2) == "function" then
        return true
    end
    if type(v2) == "table" then
        local v3 = getmetatable(v2)
        if v3 then
            local __call = rawget(v3, "__call")
            return type(__call) == "function"
        end
    end
    return false
end

local function makeEnum(v4, v5) -- line 23
    local v7 = {}
    for v8, v9 in ipairs(v5) do
        v7[v9] = v9
    end
    local v10 = {}

    function v10.__index(v11, v12) -- line 29 | captures: v4
        local v13 = string.format("%s is not in %s!", v12, v4)
        error(v13, 2)
    end

    function v10.__newindex() -- line 33 | captures: v4
        local v14 = string.format("Creating new members in %s is not allowed!", v4)
        error(v14, 2)
    end

    return (setmetatable(v7, v10))
end

local v15 = { Kind = makeEnum("Promise.Error.Kind", { "ExecutionError", "AlreadyCancelled", "NotResolvedInTime", "TimedOut" }) }

v15.__index = v15

function v15.new(v16, v17) -- line 45 | captures: v15
    local v18 = v16 or {}
    local v19 = {}
    local error = v18.error
    v19.error = tostring(error) or "[This error has no error text.]"
    v19.trace = v18.trace
    v19.context = v18.context
    v19.kind = v18.kind
    v19.parent = v17
    v19.createdTick = os.clock()
    v19.createdTrace = debug.traceback()
    return (setmetatable(v19, v15))
end

local function is(v20) -- line 62
    if type(v20) == "table" then
        local v21 = getmetatable(v20)
        if type(v21) == "table" then
            if rawget(v20, "error") == nil then
                return false
            end
            local extend = rawget(v21, "extend")
            return type(extend) == "function"
        end
    end
    return false
end

v15.is = is

function v15.isKind(v22, v23) -- line 73 | captures: v15
    local v24 = v23 ~= nil
    assert(v24, "Argument #2 to Promise.Error.isKind must not be nil")
    return v15.is(v22) and v22.kind == v23
end

function v15.extend(v25, v26) -- line 82 | captures: v15
    local v27 = v26 or {}
    v27.kind = v27.kind or v25.kind
    return v15.new(v27, v25)
end

local function getErrorChain(v28) -- line 95
    local v29 = { v28 }
    while v29[#v29].parent do
        local parent = v29[#v29].parent
        table.insert(v29, parent)
    end
    return v29
end

v15.getErrorChain = getErrorChain

local function __tostring(v30) -- line 102
    local function v31(v32, ...)
        table.insert(v32, ...)
    end

    local v33 = { string.format("-- Promise.Error(%s) --", v30.kind or "?") }
    for v34, v35 in ipairs(v30:getErrorChain()) do
        local v36 = {}
        v36[1] = v35.trace or v35.error
        v36[2] = v35.context
        v31(v33, table.concat(v36, "\n"))
    end
    return table.concat(v33, "\n")
end

v15.__tostring = __tostring

local function pack(...) -- line 117
    return select("#", ...), { ... }
end

local function packResult(v37, ...) -- line 121
    return v37, select("#", ...), { ... }
end

local function makeErrorHandler(v38) -- line 125 | captures: v15
    local v39 = v38 ~= nil
    assert(v39, "traceback is nil")
    return function(v40) -- line 128 | captures: v38, v15
        if type(v40) == "table" then
            return v40
        end
        local v41 = {
            error = v40,
            kind = v15.Kind.ExecutionError
        }
        local v42 = tostring(v40)
        v41.trace = debug.traceback(v42, 2)
        v41.context = "Promise created at:\n\n" .. v38
        return v15.new(v41)
    end
end

local function runExecutor(v43, v44, ...) -- line 139 | captures: v15, packResult
    local v45 = v43 ~= nil
    assert(v45, "traceback is nil")
    local xpcall_2 = xpcall
    return packResult(xpcall_2(v44, function(v46) -- line 142 | captures: v43, v15
        if type(v46) == "table" then
            return v46
        end
        local v47 = {
            error = v46,
            kind = v15.Kind.ExecutionError
        }
        local v48 = tostring(v46)
        v47.trace = debug.traceback(v48, 2)
        v47.context = "Promise created at:\n\n" .. v43
        return v15.new(v47)
    end, ...))
end

local function createAdvancer(v49, v50, v51, v52) -- line 153 | captures: runExecutor
    return function(...) -- line 154 | captures: v49, v50, v51, v52, runExecutor
        local v53, v54, v55 = runExecutor(v49, v50, ...)
        if v53 then
            v51(unpack(v55, 1, v54))
        else
            v52(v55[1])
        end
    end
end

local function isEmpty(v56) -- line 164
    return next(v56) == nil
end

local v57 = { Error = v15 }

v57.Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" })
v57._getTime = os.clock
v57._timeEvent = game:GetService("RunService").Heartbeat
v57._unhandledRejectionCallbacks = {}
v57.prototype = {}
v57.__index = v57.prototype

function v57._new(v58, v59, v60) -- line 176 | captures: v1, runExecutor, v57
    if v60 ~= nil and not v57.is(v60) then
        error("Argument #2 to Promise.new must be a promise or nil", 2)
    end
    local v61 = {
        _valuesLength = -1,
        _unhandledRejection = true,
        _source = v58,
        _status = v57.Status.Started,
        _queuedResolve = {},
        _queuedReject = {},
        _queuedFinally = {},
        _parent = v60
    }
    local v62 = {}
    v61._consumers = setmetatable(v62, v1)
    if v60 and v60._status == v57.Status.Started then
        v60._consumers[v61] = true
    end
    setmetatable(v61, v57)

    local function resolve(...) -- line 195 | captures: v61
        v61:_resolve(...)
    end

    local function reject(...) -- line 198 | captures: v61
        v61:_reject(...)
    end

    local function onCancel(v63) -- line 201 | captures: v61, v57
        if v63 then
            if v61._status == v57.Status.Cancelled then
                v63()
            else
                v61._cancellationHook = v63
            end
        end
        return v61._status == v57.Status.Cancelled
    end

    local create = coroutine.create
    v61._thread = create(function() -- line 212 | captures: v59, v61, resolve, reject, onCancel, runExecutor
        local v64, v65, v66 = runExecutor(v61._source, v59, resolve, reject, onCancel)
        _ = v65
        if not v64 then
            reject(v66[1])
        end
    end)
    task.spawn(v61._thread)
    return v61
end

function v57.new(v67) -- line 222 | captures: v57
    local v68 = debug.traceback(nil, 2)
    return v57._new(v68, v67)
end

local function __tostring_2(v69) -- line 226
    return string.format("Promise(%s)", v69._status)
end

v57.__tostring = __tostring_2

function v57.defer(v70) -- line 229 | captures: v57
    local v71 = debug.traceback(nil, 2)
    return (v57._new(v71, function(v72, v73, v74) -- line 231
    end))
end

v57.async = v57.defer

function v57.resolve(...) -- line 238 | captures: pack, v57
    local v75, v76 = pack(...)
    local v77 = debug.traceback(nil, 2)
    return v57._new(v77, function(v78) -- line 242 | captures: v75, v76
        v78(unpack(v76, 1, v75))
    end)
end

function v57.reject(...) -- line 246 | captures: pack, v57
    local v79, v80 = pack(...)
    local v81 = debug.traceback(nil, 2)
    return v57._new(v81, function(v82, v83) -- line 250 | captures: v79, v80
        v83(unpack(v80, 1, v79))
    end)
end

function v57._try(v84, v85, ...) -- line 254 | captures: pack, v57
    local v86, v87 = pack(...)
    return v57._new(v84, function(v88) -- line 257 | captures: v85, v86, v87
        v88(v85(unpack(v87, 1, v86)))
    end)
end

function v57.try(v89, ...) -- line 261 | captures: v57
    local v90 = debug.traceback(nil, 2)
    return v57._try(v90, v89, ...)
end

function v57._all(v91, v92, v93) -- line 265 | captures: v57
    if type(v92) ~= "table" then
        local v94 = string.format("Please pass a list of promises to %s", "Promise.all")
        error(v94, 3)
    end
    for v95, v96 in pairs(v92) do
        if not v57.is(v96) then
            local v97 = string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(v95)))
            error(v97, 3)
        end
    end
    if #v92 == 0 or v93 == 0 then
        return v57.resolve({})
    end
    return v57._new(v91, function(v98, v99, v100) -- line 280 | captures: v92, v93
        local v101 = {}
        local v102 = {}
        local v103 = 0
        local v104 = 0
        local v105 = false

        local function resolveOne(v106, ...) -- line 286 | captures: v103, v105, v98, v101, v102, v92, v93
            if v105 then
                return
            end
            v103 += 1
            if v93 == nil then
                v101[v106] = ...
            else
                v101[v103] = ...
            end
            if not ((v93 or #v92) <= v103) then
                return
            end
            v105 = true
            v98(v101)
            for v107, v108 in ipairs(v102) do
                v108:cancel()
            end
        end

        v100(function() -- line 308 | captures: v102
            for v109, v110 in ipairs(v102) do
                v110:cancel()
            end
        end)
        for v111, v112 in ipairs(v92) do
            local v113 = v111

            local v114 = function(...) -- line 314 | captures: resolveOne, v113
                resolveOne(v113, ...)
            end

            v102[v111] = v112:andThen(v114, function(...) -- line 316 | captures: v104, v105, v99, v102, v92, v93
                v104 += 1
                if v93 == nil then
                    for v115, v116 in ipairs(v102) do
                        v116:cancel()
                    end
                    v105 = true
                    v99(...)
                else
                    local v117 = #v92 - v104
                    if v93 <= v117 then
                    end
                end
            end)
        end
        if v105 then
            for v118, v119 in ipairs(v102) do
                v119:cancel()
            end
        end
    end)
end

function v57.all(v120) -- line 337 | captures: v57
    local v121 = debug.traceback(nil, 2)
    return v57._all(v121, v120)
end

function v57.fold(v122, v123, v124) -- line 341 | captures: v57
    local v125 = type(v122) == "table"
    assert(v125, "Bad argument #1 to Promise.fold: must be a table")
    local v126
    if type(v123) == "function" then
        v126 = true
    elseif type(v123) == "table" then
        local v127 = getmetatable(v123)
        if v127 then
            local __call = rawget(v127, "__call")
            v126 = type(__call) == "function"
        else
            v126 = false
        end
    else
        v126 = false
    end
    assert(v126, "Bad argument #2 to Promise.fold: must be a function")
    local v128 = v57.resolve(v124)
    return v57.each(v122, function(v129, v130) -- line 358 | captures: v128, v123
        v128 = v128:andThen(function(v131) -- line 359 | captures: v129, v130, v123
            return v123(v131, v129, v130)
        end)
    end):andThen(function() -- line 363 | captures: v128
        return v128
    end)
end

function v57.some(v132, v133) -- line 367 | captures: v57
    local v134 = type(v133) == "number"
    assert(v134, "Bad argument #2 to Promise.some: must be a number")
    local v135 = debug.traceback(nil, 2)
    return v57._all(v135, v132, v133)
end

function v57.any(v136) -- line 373 | captures: v57
    local v137 = debug.traceback(nil, 2)
    return v57._all(v137, v136, 1):andThen(function(v138) -- line 376
        return v138[1]
    end)
end

function v57.allSettled(v139) -- line 380 | captures: v57
    if type(v139) ~= "table" then
        local v140 = string.format("Please pass a list of promises to %s", "Promise.allSettled")
        error(v140, 2)
    end
    for v141, v142 in pairs(v139) do
        if not v57.is(v142) then
            local v143 = string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(v141)))
            error(v143, 2)
        end
    end
    if #v139 == 0 then
        return v57.resolve({})
    end
    local v144 = debug.traceback(nil, 2)
    return v57._new(v144, function(v145, v146, v147) -- line 396 | captures: v139
        local v148 = {}
        local v149 = {}
        local v150 = 0

        local function resolveOne(v151, ...) -- line 400 | captures: v150, v145, v148, v139
            v150 += 1
            v148[v151] = ...
            if #v139 <= v150 then
                v145(v148)
            end
        end

        v147(function() -- line 407 | captures: v149
            for v152, v153 in ipairs(v149) do
                v153:cancel()
            end
        end)
        for v154, v155 in ipairs(v139) do
            local v156 = v154
            v149[v154] = v155:finally(function(...) -- line 413 | captures: resolveOne, v156
                resolveOne(v156, ...)
            end)
        end
    end)
end

function v57.race(v157) -- line 419 | captures: v57
    local function v158(v159, ...)
        assert(v159, ...)
    end

    local function v160(v161, ...)
        assert(v161, ...)
    end

    v158(type(v157) == "table", string.format("Please pass a list of promises to %s", "Promise.race"))
    for v162, v163 in pairs(v157) do
        v160(v57.is(v163), string.format("Non-promise value passed into %s at index %s", "Promise.race", (tostring(v162))))
    end
    local v164 = debug.traceback(nil, 2)
    return v57._new(v164, function(v165, v166, v167) -- line 428 | captures: v157
        local v168 = {}
        local v169 = false

        local function cancel() -- line 431 | captures: v168
            for v170, v171 in ipairs(v168) do
                v171:cancel()
            end
        end

        local function finalize(v172) -- line 436 | captures: v169, v168
            return function(...) -- line 437 | captures: v172, v169, v168
                for v173, v174 in ipairs(v168) do
                    v174:cancel()
                end
                v169 = true
                return v172(...)
            end
        end

        if not v167(function(...) -- line 445 | captures: v169, v166, v168
                for v175, v176 in ipairs(v168) do
                    v176:cancel()
                end
                v169 = true
                return v166(...)
            end) then
            for v177, v178 in ipairs(v157) do
                local v179 = function(...) -- line 456 | captures: v169, v165, v168
                    for v180, v181 in ipairs(v168) do
                        v181:cancel()
                    end
                    v169 = true
                    return v165(...)
                end

                v168[v177] = v178:andThen(v179, function(...) -- line 462 | captures: v169, v166, v168
                    for v182, v183 in ipairs(v168) do
                        v183:cancel()
                    end
                    v169 = true
                    return v166(...)
                end)
            end
            if v169 then
                for v184, v185 in ipairs(v168) do
                    v185:cancel()
                end
            end
        end
    end)
end

function v57.each(v186, v187) -- line 477 | captures: v15, v57
    local function v188(v189, ...)
        assert(v189, ...)
    end

    local function v190(v191, ...)
        assert(v191, ...)
    end

    v188(type(v186) == "table", string.format("Please pass a list of promises to %s", "Promise.each"))
    local v192
    if type(v187) == "function" then
        v192 = true
    elseif type(v187) == "table" then
        local v193 = getmetatable(v187)
        if v193 then
            local __call = rawget(v193, "__call")
            v192 = type(__call) == "function"
        else
            v192 = false
        end
    else
        v192 = false
    end
    v190(v192, string.format("Please pass a handler function to %s!", "Promise.each"))
    local v194 = debug.traceback(nil, 2)
    return v57._new(v194, function(v195, v196, v197) -- line 494 | captures: v186, v187, v15, v57
        local v198 = {}
        local v199 = {}
        local v200 = false

        local function cancel() -- line 499 | captures: v199
            for v201, v202 in ipairs(v199) do
                v202:cancel()
            end
        end

        v197(function() -- line 504 | captures: v200, v199
            v200 = true
            for v203, v204 in ipairs(v199) do
                v204:cancel()
            end
        end)
        local v205 = {}
        for v206, v207 in ipairs(v186) do
            if v57.is(v207) then
                if v207:getStatus() == v57.Status.Cancelled then
                    for v208, v209 in ipairs(v199) do
                        v209:cancel()
                    end
                    return v196(v15.new({
                        error = "Promise is cancelled",
                        kind = v15.Kind.AlreadyCancelled,
                        context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", v206, v207._source)
                    }))
                end
                if v207:getStatus() == v57.Status.Rejected then
                    for v210, v211 in ipairs(v199) do
                        v211:cancel()
                    end
                    return v196(select(2, v207:await()))
                end
                local v212 = v207:andThen(function(...) -- line 529
                    return ...
                end)
                table.insert(v199, v212)
                v205[v206] = v212
            else
                v205[v206] = v207
            end
        end
        for v213, v214 in ipairs(v205) do
            local v215
            if v57.is(v214) then
                local v216
                v216, v215 = v214:await()
                if not v216 then
                    for v217, v218 in ipairs(v199) do
                        v218:cancel()
                    end
                    return v6(v215)
                end
            else
                v215 = v214
            end
            if v200 then
                return
            end
            local v219 = v57.resolve(v187(v215, v213))
            table.insert(v199, v219)
            local v220, v221 = v219:await()
            if v220 then
                v198[v213] = v221
            else
                for v222, v223 in ipairs(v199) do
                    v223:cancel()
                end
                return v6(v221)
            end
        end
        v195(v198)
    end)
end

function v57.is(v224) -- line 564 | captures: v57
    if type(v224) == "table" then
        local v225 = getmetatable(v224)
        if v225 == v57 then
            return true
        end
        if v225 == nil then
            local andThen = v224.andThen
            if type(andThen) == "function" then
                return true
            end
            if type(andThen) == "table" then
                local v226 = getmetatable(andThen)
                if v226 then
                    local __call = rawget(v226, "__call")
                    return type(__call) == "function"
                end
            end
        else
            local v227, v228
            if type(v225) == "table" then
                local __index = rawget(v225, "__index")
                if type(__index) == "table" then
                    local __index = rawget(v225, "__index")
                    local andThen = rawget(__index, "andThen")
                    if type(andThen) == "function" then
                        v227 = true
                    elseif type(andThen) == "table" then
                        local v229 = getmetatable(andThen)
                        if v229 then
                            local __call = rawget(v229, "__call")
                            v227 = type(__call) == "function"
                        else
                            v227 = false
                        end
                    else
                        v227 = false
                    end
                    v228 = false
                else
                    v228 = true
                end
            else
                v228 = true
            end
            if not v228 then
                return not not v227
            end
        end
    end
    return false
end

function v57.promisify(v230) -- line 612 | captures: v57
    return function(...) -- line 613 | captures: v230, v57
        local v231 = debug.traceback(nil, 2)
        return v57._try(v231, v230, ...)
    end
end

local v232, v233

function v57.delay(v234) -- line 627 | captures: v232, v233, v57
    local v235 = type(v234) == "number"
    assert(v235, "Bad argument #1 to Promise.delay, must be a number.")
    local v236 = if v234 < 0.016666666666666666 or v234 == (1/0) then 0.016666666666666666 else v234
    local v237 = debug.traceback(nil, 2)
    return v57._new(v237, function(v238, v239, v240) -- line 639 | captures: v236, v232, v233, v57
        local v241 = v57._getTime()
        local v242 = v241 + v236
        local v243 = {
            resolve = v238,
            startTime = v241,
            endTime = v242
        }
        if v233 == nil then
            v232 = v243
            v233 = v57._timeEvent:Connect(function() -- line 646 | captures: v232, v233, v57
                local v244 = v57._getTime()
                while true do
                    if v232 == nil or v244 <= v232.endTime then
                        break
                    end
                    local v245 = v232
                    v232 = v245.next
                    if v232 == nil then
                        v233:Disconnect()
                        v233 = nil
                    else
                        v232.previous = nil
                    end
                    v245.resolve(v57._getTime() - v245.startTime)
                end
            end)
        elseif v242 <= v232.endTime then
            v243.next = v232
            v232.previous = v243
            v232 = v243
        else
            local v246 = v232
            local next = v246.next
            while next ~= nil do
                if v242 <= next.endTime then
                    break
                end
                next = next.next
            end
            v246.next = v243
            v243.previous = v246
            if next ~= nil then
                v243.next = next
                next.previous = v243
            end
        end
        v240(function() -- line 684 | captures: v243, v232, v233
            local next = v243.next
            if v232 == v243 then
                if next == nil then
                    v233:Disconnect()
                    v233 = nil
                else
                    next.previous = nil
                end
                v232 = next
            else
                local previous = v243.previous
                previous.next = next
                if next ~= nil then
                    next.previous = previous
                end
            end
        end)
    end)
end

local function timeout(v247, v248, v249) -- line 708 | captures: v15, v57
    local v250 = debug.traceback(nil, 2)
    local v251 = {}
    v251[1] = v57.delay(v248):andThen(function() -- line 711 | captures: v248, v249, v250, v15, v57
        return v57.reject(v249 == nil and
        v15.new({
            error = "Timed out",
            kind = v15.Kind.TimedOut,
            context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", v248, v250)
        }) or
        v249)
    end)
    v251[2] = v247
    return v57.race(v251)
end

v57.prototype.timeout = timeout

local function timeout_2(v252) -- line 730
    return v252._status
end

v57.prototype.getStatus = timeout_2

local function timeout_3(v253, v254, v255, v256) -- line 735 | captures: runExecutor, v57
    v253._unhandledRejection = false
    if v253._status == v57.Status.Cancelled then
        local v257 = v57.new(function() -- line 783
        end)
        v257:cancel()
        return v257
    end
    return v57._new(v254, function(v258, v259, v260) -- line 738 | captures: v253, v254, v255, v256, runExecutor, v57
        local v261 = v258
        local v262
        if v255 then
            local function u7(...) -- line 743 | captures: v258, v259, v254, v255, runExecutor
                local v263, v264, v265 = runExecutor(v254, v255, ...)
                if v263 then
                    v258(unpack(v265, 1, v264))
                else
                    v259(v265[1])
                end
            end

            v261 = u7
            v262 = u7
        else
            v262 = v258
        end
        local v266 = v259
        local v267
        if v256 then
            local function u13(...) -- line 757 | captures: v258, v259, v254, v256, runExecutor
                local v268, v269, v270 = runExecutor(v254, v256, ...)
                if v268 then
                    v258(unpack(v270, 1, v269))
                else
                    v259(v270[1])
                end
            end

            v266 = u13
            v267 = u13
        else
            v267 = v259
        end
        if v253._status == v57.Status.Started then
            local _queuedResolve = v253._queuedResolve
            table.insert(_queuedResolve, v262)
            local _queuedReject = v253._queuedReject
            table.insert(_queuedReject, v267)
            v260(function() -- line 770 | captures: v261, v266, v253, v57
                if v253._status == v57.Status.Started then
                    table.remove(v253._queuedResolve, table.find(v253._queuedResolve, v261))
                    table.remove(v253._queuedReject, table.find(v253._queuedReject, v266))
                end
            end)
        elseif v253._status == v57.Status.Resolved then
            local _values = v253._values
            local _valuesLength = v253._valuesLength
            v262(unpack(_values, 1, _valuesLength))
        elseif v253._status == v57.Status.Rejected then
            local _values = v253._values
            local _valuesLength = v253._valuesLength
            v267(unpack(_values, 1, _valuesLength))
        end
    end, v253)
end

v57.prototype._andThen = timeout_3

local function timeout_4(v271, v272, v273) -- line 789
    local function v274(v275, ...)
        assert(v275, ...)
    end

    local function v276(v277, ...)
        assert(v277, ...)
    end

    local v278
    if v272 == nil or type(v272) == "function" then
        v278 = true
    elseif type(v272) == "table" then
        local v279 = getmetatable(v272)
        if v279 then
            local __call = rawget(v279, "__call")
            if type(__call) == "function" then
            end
        end
        v278 = true
    else
        v278 = false
    end
    v274(v278, string.format("Please pass a handler function to %s!", "Promise:andThen"))
    local v280
    if v273 == nil or type(v273) == "function" then
        v280 = true
    elseif type(v273) == "table" then
        local v281 = getmetatable(v273)
        if v281 then
            local __call = rawget(v281, "__call")
            v280 = type(__call) == "function"
        else
            v280 = false
        end
    else
        v280 = false
    end
    v276(v280, string.format("Please pass a handler function to %s!", "Promise:andThen"))
    return v271:_andThen(debug.traceback(nil, 2), v272, v273)
end

v57.prototype.andThen = timeout_4

local function timeout_5(v282, v283) -- line 826
    local function v284(v285, ...)
        assert(v285, ...)
    end

    local v286
    if v283 == nil or type(v283) == "function" then
        v286 = true
    elseif type(v283) == "table" then
        local v287 = getmetatable(v283)
        if v287 then
            local __call = rawget(v287, "__call")
            v286 = type(__call) == "function"
        else
            v286 = false
        end
    else
        v286 = false
    end
    v284(v286, string.format("Please pass a handler function to %s!", "Promise:catch"))
    return v282:_andThen(debug.traceback(nil, 2), nil, v283)
end

v57.prototype.catch = timeout_5

local function timeout_6(v288, v289) -- line 849 | captures: pack, v57
    local function v290(v291, ...)
        assert(v291, ...)
    end

    local v292
    if type(v289) == "function" then
        v292 = true
    elseif type(v289) == "table" then
        local v293 = getmetatable(v289)
        if v293 then
            local __call = rawget(v293, "__call")
            v292 = type(__call) == "function"
        else
            v292 = false
        end
    else
        v292 = false
    end
    v290(v292, string.format("Please pass a handler function to %s!", "Promise:tap"))
    return v288:_andThen(debug.traceback(nil, 2), function(...) -- line 865 | captures: v289, pack, v57
        local v294 = v289(...)
        if v57.is(v294) then
            local v295, v296 = pack(...)
            return v294:andThen(function() -- line 872 | captures: v296, v295
                return unpack(v296, 1, v295)
            end)
        end
        return ...
    end)
end

v57.prototype.tap = timeout_6

local function timeout_7(v297, v298, ...) -- line 879 | captures: pack
    local function v299(v300, ...)
        assert(v300, ...)
    end

    local v301
    if type(v298) == "function" then
        v301 = true
    elseif type(v298) == "table" then
        local v302 = getmetatable(v298)
        if v302 then
            local __call = rawget(v302, "__call")
            v301 = type(__call) == "function"
        else
            v301 = false
        end
    else
        v301 = false
    end
    v299(v301, string.format("Please pass a handler function to %s!", "Promise:andThenCall"))
    local v303, v304 = pack(...)
    return v297:_andThen(debug.traceback(nil, 2), function() -- line 896 | captures: v298, v303, v304
        return v298(unpack(v304, 1, v303))
    end)
end

v57.prototype.andThenCall = timeout_7

local function timeout_8(v305, ...) -- line 902 | captures: pack
    local v306, v307 = pack(...)
    return v305:_andThen(debug.traceback(nil, 2), function() -- line 906 | captures: v306, v307
        return unpack(v307, 1, v306)
    end)
end

v57.prototype.andThenReturn = timeout_8

local function timeout_9(v308) -- line 912 | captures: v57
    if v308._status ~= v57.Status.Started then
        return
    end
    v308._status = v57.Status.Cancelled
    if v308._cancellationHook then
        v308._cancellationHook()
    end
    coroutine.close(v308._thread)
    if v308._parent then
        v308._parent:_consumerCancelled(v308)
    end
    for v309 in pairs(v308._consumers) do
        v309:cancel()
    end
    v308:_finalize()
end

v57.prototype.cancel = timeout_9

local function timeout_10(v310, v311) -- line 931 | captures: v57
    if v310._status == v57.Status.Started then
        v310._consumers[v311] = nil
        if next(v310._consumers) == nil then
            v310:cancel()
        end
    end
end

v57.prototype._consumerCancelled = timeout_10

local function timeout_11(v312, v313, v314) -- line 942 | captures: v57
    v312._unhandledRejection = false
    return (v57._new(v313, function(v315, v316, v317) -- line 944 | captures: v312, v314, v57
        local v318
        v317(function() -- line 947 | captures: v318, v312
            v312:_consumerCancelled(v312)
            if v318 then
                v318:cancel()
            end
        end)
        local v319
        if v314 then
            function v319(...) -- line 957 | captures: v318, v315, v316, v312, v314, v57
                local v320 = v314(...)
                if v57.is(v320) then
                    v318 = v320
                    v320:finally(function(v321) -- line 965 | captures: v315, v312, v57
                        if v321 ~= v57.Status.Rejected then
                            v315(v312)
                        end
                    end):catch(function(...) -- line 972 | captures: v316
                        v316(...)
                    end)
                else
                    v315(v312)
                end
            end
        else
            v319 = v315
        end
        if v312._status == v57.Status.Started then
            local _queuedFinally = v312._queuedFinally
            table.insert(_queuedFinally, v319)
        else
            v319(v312._status)
        end
    end))
end

v57.prototype._finally = timeout_11

local function timeout_12(v322, v323) -- line 991
    local function v324(v325, ...)
        assert(v325, ...)
    end

    local v326
    if v323 == nil or type(v323) == "function" then
        v326 = true
    elseif type(v323) == "table" then
        local v327 = getmetatable(v323)
        if v327 then
            local __call = rawget(v327, "__call")
            v326 = type(__call) == "function"
        else
            v326 = false
        end
    else
        v326 = false
    end
    v324(v326, string.format("Please pass a handler function to %s!", "Promise:finally"))
    return v322:_finally(debug.traceback(nil, 2), v323)
end

v57.prototype.finally = timeout_12

local function timeout_13(v328, v329, ...) -- line 1014 | captures: pack
    local function v330(v331, ...)
        assert(v331, ...)
    end

    local v332
    if type(v329) == "function" then
        v332 = true
    elseif type(v329) == "table" then
        local v333 = getmetatable(v329)
        if v333 then
            local __call = rawget(v333, "__call")
            v332 = type(__call) == "function"
        else
            v332 = false
        end
    else
        v332 = false
    end
    v330(v332, string.format("Please pass a handler function to %s!", "Promise:finallyCall"))
    local v334, v335 = pack(...)
    return v328:_finally(debug.traceback(nil, 2), function() -- line 1031 | captures: v329, v334, v335
        return v329(unpack(v335, 1, v334))
    end)
end

v57.prototype.finallyCall = timeout_13

local function timeout_14(v336, ...) -- line 1037 | captures: pack
    local v337, v338 = pack(...)
    return v336:_finally(debug.traceback(nil, 2), function() -- line 1041 | captures: v337, v338
        return unpack(v338, 1, v337)
    end)
end

v57.prototype.finallyReturn = timeout_14

local function timeout_15(v339) -- line 1047 | captures: v57
    v339._unhandledRejection = false
    if v339._status == v57.Status.Started then
        local v340 = coroutine.running()
        v339:finally(function() -- line 1051 | captures: v340
            task.spawn(v340)
        end):catch(function() -- line 1054
        end)
        coroutine.yield()
    end
    if v339._status ~= v57.Status.Resolved and v339._status ~= v57.Status.Rejected then
        return v339._status
    end
    local _status = v339._status
    local _values = v339._values
    local _valuesLength = v339._valuesLength
    return _status, unpack(_values, 1, _valuesLength)
end

v57.prototype.awaitStatus = timeout_15

local function v341(v342, ...) -- line 1064 | captures: v57
    return v342 == v57.Status.Resolved, ...
end

local function prototype(v343) -- line 1068 | captures: v341
    return v341(v343:awaitStatus())
end

v57.prototype.await = prototype

local function v344(v345, ...) -- line 1072 | captures: v57
    if v345 ~= v57.Status.Resolved then
        local v346
        if ... == nil then
            v346 = "Expected Promise rejected with no value."
        else
            v346 = ...
        end
        error(v346, 3)
    end
    return ...
end

local function expect(v347) -- line 1084 | captures: v344
    return v344(v347:awaitStatus())
end

v57.prototype.expect = expect
v57.prototype.awaitValue = v57.prototype.expect

local function _unwrap(v348) -- line 1088 | captures: v57
    if v348._status == v57.Status.Started then
        error("Promise has not resolved or rejected.", 2)
    end
    local v349 = v348._status == v57.Status.Resolved
    local _values = v348._values
    local _valuesLength = v348._valuesLength
    return v349, unpack(_values, 1, _valuesLength)
end

v57.prototype._unwrap = _unwrap

local function _resolve(v350, ...) -- line 1095 | captures: v15, pack, v57
    if v350._status == v57.Status.Started then
        if v57.is((...)) then
            if select("#", ...) > 1 then
                local v351 = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", v350._source)
                warn(v351)
            end
            local v352 = ...

            local function v353(...) -- line 1122 | captures: v350
                v350:_resolve(...)
            end

            local v354 = v352:andThen(v353, function(...) -- line 1124 | captures: v350, v352, v15
                local v355
                if v352._error then
                    v355 = v15.new({
                        context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v1)]",
                        error = v352._error,
                        kind = v15.Kind.ExecutionError
                    })
                else
                    v355 = v352._values[1]
                end
                if v15.isKind(v355, v15.Kind.ExecutionError) then
                    return v350:_reject(v355:extend({
                        error = "This Promise was chained to a Promise that errored.",
                        trace = "",
                        context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", v350._source)
                    }))
                end
                v350:_reject(...)
            end)
            if v354._status == v57.Status.Cancelled then
                v350:cancel()
            elseif v354._status == v57.Status.Started then
                v350._parent = v354
                v354._consumers[v350] = true
            end
        else
            v350._status = v57.Status.Resolved
            local v356, v357 = pack(...)
            v350._valuesLength = v356
            v350._values = v357
            for v358, v359 in ipairs(v350._queuedResolve) do
                coroutine.wrap(v359)(...)
            end
            v350:_finalize()
        end
    elseif v57.is((...)) then
        (...):_consumerCancelled(v350)
    end
end

v57.prototype._resolve = _resolve

local function _reject(v360, ...) -- line 1141 | captures: pack, v57
    if v360._status ~= v57.Status.Started then
        return
    end
    v360._status = v57.Status.Rejected
    local v361, v362 = pack(...)
    v360._valuesLength = v361
    v360._values = v362
    if next(v360._queuedReject) == nil then
        local v363 = ...
        local v364 = tostring(v363)
        coroutine.wrap(function() -- line 1153 | captures: v360, v364, v57
            v57._timeEvent:Wait()
            if not v360._unhandledRejection then
                return
            end
            local v365 = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", v364, v360._source)
            for v366, v367 in ipairs(v57._unhandledRejectionCallbacks) do
                local spawn = task.spawn
                local _values = v360._values
                local _valuesLength = v360._valuesLength
                spawn(v367, v360, unpack(_values, 1, _valuesLength))
            end
            if not v57.TEST then
                warn(v365)
            end
        end)()
    else
        for v368, v369 in ipairs(v360._queuedReject) do
            coroutine.wrap(v369)(...)
        end
    end
    v360:_finalize()
end

v57.prototype._reject = _reject

local function _finalize(v370) -- line 1176 | captures: v57
    for v371, v372 in ipairs(v370._queuedFinally) do
        coroutine.wrap(v372)(v370._status)
    end
    v370._queuedFinally = nil
    v370._queuedReject = nil
    v370._queuedResolve = nil
    if not v57.TEST then
        v370._parent = nil
        v370._consumers = nil
    end
    task.defer(coroutine.close, v370._thread)
end

v57.prototype._finalize = _finalize

local function now(v373, v374) -- line 1191 | captures: v15, v57
    local v375 = debug.traceback(nil, 2)
    if v373._status == v57.Status.Resolved then
        return v373:_andThen(v375, function(...) -- line 1195
            return ...
        end)
    end
    return v57.reject(v374 == nil and
    v15.new({
        error = "This Promise was not resolved in time for :now()",
        kind = v15.Kind.NotResolvedInTime,
        context = ":now() was called at:\n\n" .. v375
    }) or
    v374)
end

v57.prototype.now = now

function v57.retry(v376, v377, ...) -- line 1210 | captures: v57
    local v378
    if type(v376) == "function" then
        v378 = true
    elseif type(v376) == "table" then
        local v379 = getmetatable(v376)
        if v379 then
            local __call = rawget(v379, "__call")
            v378 = type(__call) == "function"
        else
            v378 = false
        end
    else
        v378 = false
    end
    assert(v378, "Parameter #1 to Promise.retry must be a function")
    local v380 = type(v377) == "number"
    assert(v380, "Parameter #2 to Promise.retry must be a number")
    local v381 = { ... }
    local v382 = select("#", ...)
    return v57.resolve(v376(...)):catch(function(...) -- line 1229 | captures: v376, v377, v381, v382, v57
        if v377 > 0 then
            local retry = v57.retry
            local v383 = v377 - 1
            return retry(v376, v383, unpack(v381, 1, v382))
        end
        return v57.reject(...)
    end)
end

function v57.retryWithDelay(v384, v385, v386, ...) -- line 1236 | captures: v57
    local v387
    if type(v384) == "function" then
        v387 = true
    elseif type(v384) == "table" then
        local v388 = getmetatable(v384)
        if v388 then
            local __call = rawget(v388, "__call")
            if type(__call) == "function" then
                v387 = true
            end
        end
    else
        v387 = false
    end
    assert(v387, "Parameter #1 to Promise.retry must be a function")
    local v389 = type(v385) == "number"
    assert(v389, "Parameter #2 (times) to Promise.retry must be a number")
    local v390 = type(v386) == "number"
    assert(v390, "Parameter #3 (seconds) to Promise.retry must be a number")
    local v391 = { ... }
    local v392 = select("#", ...)
    return v57.resolve(v384(...)):catch(function(...) -- line 1255 | captures: v384, v385, v386, v391, v392, v57
        if v385 <= 0 then
            return v57.reject(...)
        end
        v57.delay(v386):await()
        local retryWithDelay = v57.retryWithDelay
        local v393 = v385 - 1
        return retryWithDelay(v384, v393, v386, unpack(v391, 1, v392))
    end)
end

function v57.fromEvent(v394, v395) -- line 1263 | captures: v57
    local v396 = v395 or function() -- v1 | line 1266
        return true
    end
    local v397 = debug.traceback(nil, 2)
    return v57._new(v397, function(v398, v399, v400) -- line 1272 | captures: v394, v396
        local v401
        local v402 = false

        local function disconnect() -- line 1275 | captures: v401
            v401:Disconnect()
            v401 = nil
        end

        v401 = v394:Connect(function(...) -- line 1279 | captures: v401, v402, v398, v396
            local v403 = v396(...)
            if v403 == true then
                v398(...)
                if v401 then
                    v401:Disconnect()
                    v401 = nil
                else
                    v402 = true
                end
            elseif type(v403) ~= "boolean" then
                error("Promise.fromEvent predicate should always return a boolean")
            end
        end)
        if v402 and v401 then
            return disconnect()
        end
        v400(disconnect)
    end)
end

function v57.onUnhandledRejection(v404) -- line 1305 | captures: v57
    local _unhandledRejectionCallbacks = v57._unhandledRejectionCallbacks
    table.insert(_unhandledRejectionCallbacks, v404)
    return function() -- line 1307 | captures: v404, v57
        local v405 = table.find(v57._unhandledRejectionCallbacks, v404)
        if v405 then
            table.remove(v57._unhandledRejectionCallbacks, v405)
        end
    end
end

return v57
