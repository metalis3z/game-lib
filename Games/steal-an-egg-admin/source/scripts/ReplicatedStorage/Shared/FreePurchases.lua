-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Enabled = false,
    Allowed = {}
}

function v1.AllowsUserId(v2) -- line 2 | captures: v1
    return v1.Enabled or v1.Allowed[v2] == true
end

function v1.Allows(v3) -- line 5 | captures: v1
    if typeof(v3) == "Instance" then
        return v3:IsA("Player") and v1.AllowsUserId(v3.UserId)
    end
    return false
end

return v1
