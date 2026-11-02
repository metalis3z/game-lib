-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}

local function RunCallback(v2, v3, ...) -- line 3 | captures: v1
    v2(...)
    table.insert(v1, v3)
end

local function Yielder() -- line 8 | captures: RunCallback
    while true do
        RunCallback(coroutine.yield())
    end
end

return function(v4, ...) -- line 14 | captures: v1, Yielder
    local v5
    if #v1 > 0 then
        v5 = v1[#v1]
        v1[#v1] = nil
    else
        v5 = coroutine.create(Yielder)
        coroutine.resume(v5)
    end
    task.spawn(v5, v4, v5, ...)
end
