-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local function v0(v1)
    local v2 = {};
    for v3, v4 in pairs(v1) do
        if type(v4) == "table" then
            v4 = v0(v4);
        end;
        v2[v3] = v4;
    end;
    return v2;
end;
return (v0((require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync")))));