-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local Parent = require(script.Parent)
    it("should load with all public APIs", function() -- line 4 | captures: Parent
        local v1 = {
            createElement = "function",
            createFragment = "function",
            createRef = "function",
            createBinding = "function",
            joinBindings = "function",
            mount = "function",
            unmount = "function",
            update = "function",
            oneChild = "function",
            setGlobalConfig = "function",
            createContext = "function",
            reify = "function",
            teardown = "function",
            reconcile = "function",
            Component = true,
            PureComponent = true,
            Portal = true,
            Children = true,
            Event = true,
            Change = true,
            Ref = true,
            None = true,
            UNSTABLE = true
        }
        expect(Parent).to.be.ok()
        for v2, v3 in pairs(v1) do
            local v4
            if typeof(v3) == "string" then
                local v5 = Parent[v2]
                v4 = typeof(v5) == v3
            else
                v4 = Parent[v2] ~= nil
            end
            if not v4 then
                local v6 = if typeof(v3) == "boolean" then "present" else "of type " .. v3
                local v7 = tostring(v2)
                local v8 = Parent[v2]
                local v9 = ("Expected public API member %q to be %s, but instead it was of type %s"):format(v7, v6, (typeof(v8)))
                error(v9)
            end
        end
        for v10 in pairs(Parent) do
            if v1[v10] == nil then
                local v11 = ("Found unknown public API key %q!"):format((tostring(v10)))
                error(v11)
            end
        end
    end)
end
