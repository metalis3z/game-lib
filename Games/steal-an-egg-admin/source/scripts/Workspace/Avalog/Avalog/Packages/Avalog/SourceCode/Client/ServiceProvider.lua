-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Parent.SourceCode.Client.Avatar.AvatarManager)
local v1 = { _AvatarManager = nil }

function v1.Setup(v2, v3) -- line 16
    v2._AvatarManager = v3.AvatarManager
end

function v1.GetAvatarManager(v4) -- line 20
    local _AvatarManager = v4._AvatarManager
    assert(_AvatarManager, "Missing AvatarManager. Forgot to call Setup?")
    return v4._AvatarManager
end

return v1
