-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Connections = {}, 
    Updated = function(v0, v1) --[[ Line: 5 ]] --[[ Name: Updated ]]
        if v1 then
            return;
        else
            local l_pairs_0 = pairs;
            local v3 = v0.Connections or {};
            for _, v5 in l_pairs_0(v3) do
                v5:Disconnect();
                v5 = nil;
            end;
            return;
        end;
    end
};