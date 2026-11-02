-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Util = require(script.Parent.Parent.Shared.Util);
local Players = game:GetService("Players");
local u13 = {
    Transform = function(p1) -- Line: 5, Name: Transform
        -- upvalues: Players (copy)
        local v2 = p1:lower();
        local v3 = {};
        local v4 = {};
        local v5 = {};

        for _, v in ipairs(Players:GetPlayers()) do
            local v6 = v.Name:lower();
            local v7 = v.DisplayName:lower();

            if v6 == v2 then
                table.insert(v3, v);
            elseif v7 == v2 then
                table.insert(v4, v);
            elseif v6:find(v2, 1, true) or v7:find(v2, 1, true) then
                table.insert(v5, v);
            end;
        end;

        local v8 = {};

        for _, v in ipairs(v3) do
            table.insert(v8, v);
        end;

        for _, v in ipairs(v4) do
            table.insert(v8, v);
        end;

        for _, v in ipairs(v5) do
            table.insert(v8, v);
        end;

        return v8;
    end,

    Validate = function(p9) -- Line: 29, Name: Validate
        return #p9 > 0, "No player with that name could be found.";
    end,

    Autocomplete = function(p10) -- Line: 33, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p10);
    end,

    Parse = function(p11) -- Line: 37, Name: Parse
        return p11[1];
    end,

    Default = function(p12) -- Line: 41, Name: Default
        return p12.Name;
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p14) -- Line: 53
    -- upvalues: u13 (copy), Util (copy)
    p14:RegisterType("player", u13);
    p14:RegisterType("players", Util.MakeListableType(u13, {
        Prefixes = "% teamPlayers"
    }));
end;