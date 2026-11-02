-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = Enum.AvatarAssetType:GetEnumItems()

local function AssetTypeFromId(v2) -- line 3 | captures: v1
    for v3, v4 in ipairs(v1) do
        if v4.Value == v2 then
            return v4
        end
    end
    return nil
end

return AssetTypeFromId
