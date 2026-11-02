-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Types.Interface)
return {
    BindOnAdapterChanged = function(v1, v2, v3) -- BindOnAdapterChanged | line 8
        local v4 = v1.Changed:Connect(function() -- line 9 | captures: v1, v2, v3
            if v2(v1) then
                v3()
            end
        end)
        task.defer(function() -- line 14 | captures: v1, v2, v3
            if v2(v1) then
                v3()
            end
        end)
        return function() -- line 19 | captures: v4
            v4:Disconnect()
        end
    end
}
