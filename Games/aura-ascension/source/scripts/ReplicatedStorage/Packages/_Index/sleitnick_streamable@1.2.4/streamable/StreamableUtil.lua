-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script.Parent.Parent.Trove);
local _ = require(script.Parent.Streamable);
return {
    Compound = function(v2, v3) --[[ Line: 47 ]] --[[ Name: Compound ]]
        -- upvalues: v0 (copy)
        local v4 = v0.new();
        local v5 = v0.new();
        local v6 = false;
        local _ = function() --[[ Line: 51 ]] --[[ Name: Check ]]
            -- upvalues: v6 (ref), v2 (copy), v3 (copy), v5 (copy)
            if v6 then
                return;
            else
                for _, v8 in pairs(v2) do
                    if not v8.Instance then
                        return;
                    end;
                end;
                v6 = true;
                v3(v2, v5);
                return;
            end;
        end;
        local function v10() --[[ Line: 63 ]] --[[ Name: Cleanup ]]
            -- upvalues: v6 (ref), v5 (copy)
            if not v6 then
                return;
            else
                v6 = false;
                v5:Clean();
                return;
            end;
        end;
        for _, v12 in pairs(v2) do
            v4:Add(v12:Observe(function(_, v14) --[[ Line: 71 ]]
                -- upvalues: v6 (ref), v2 (copy), v3 (copy), v5 (copy), v10 (copy)
                local v15 = false;
                if not v6 then
                    for _, v17 in pairs(v2) do
                        v15 = not v17.Instance;
                        if v15 then
                            break;
                        end;
                    end;
                    if not v15 then
                        v6 = true;
                        v3(v2, v5);
                    end;
                end;
                v15 = false;
                v14:Add(v10);
            end));
        end;
        v4:Add(v10);
        return v4;
    end
};