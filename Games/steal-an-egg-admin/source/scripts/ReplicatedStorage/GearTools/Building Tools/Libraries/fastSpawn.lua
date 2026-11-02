-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1, ...) -- line 5
    local v2 = type(v1) == "function"
    assert(v2)
    local v3 = { ... }
    local v4 = select("#", ...)
    local BindableEvent = Instance.new("BindableEvent")
    BindableEvent.Event:Connect(function() -- line 12 | captures: v1, v3, v4
        v1(unpack(v3, 1, v4))
    end)
    BindableEvent:Fire()
    BindableEvent:Destroy()
end
