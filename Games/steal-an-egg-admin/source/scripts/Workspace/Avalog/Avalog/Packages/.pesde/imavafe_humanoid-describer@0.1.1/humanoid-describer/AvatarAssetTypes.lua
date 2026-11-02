-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Types = {
        RigidAccessories = {
            Enum.AvatarAssetType.BackAccessory,
            Enum.AvatarAssetType.FaceAccessory,
            Enum.AvatarAssetType.HairAccessory,
            Enum.AvatarAssetType.NeckAccessory,
            Enum.AvatarAssetType.FrontAccessory,
            Enum.AvatarAssetType.WaistAccessory,
            Enum.AvatarAssetType.ShoulderAccessory,
            Enum.AvatarAssetType.Hat
        },
        LayeredClothing = {
            Enum.AvatarAssetType.PantsAccessory,
            Enum.AvatarAssetType.ShirtAccessory,
            Enum.AvatarAssetType.TShirtAccessory,
            Enum.AvatarAssetType.ShortsAccessory,
            Enum.AvatarAssetType.DressSkirtAccessory,
            Enum.AvatarAssetType.JacketAccessory,
            Enum.AvatarAssetType.SweaterAccessory,
            Enum.AvatarAssetType.RightShoeAccessory,
            Enum.AvatarAssetType.LeftShoeAccessory
        },
        ClassicClothing = {
            Enum.AvatarAssetType.Shirt,
            Enum.AvatarAssetType.TShirt,
            Enum.AvatarAssetType.Pants
        },
        Emotes = { Enum.AvatarAssetType.EmoteAnimation },
        Animations = {
            Enum.AvatarAssetType.RunAnimation,
            Enum.AvatarAssetType.FallAnimation,
            Enum.AvatarAssetType.IdleAnimation,
            Enum.AvatarAssetType.WalkAnimation,
            Enum.AvatarAssetType.SwimAnimation,
            Enum.AvatarAssetType.ClimbAnimation,
            Enum.AvatarAssetType.JumpAnimation,
            Enum.AvatarAssetType.MoodAnimation
        },
        BodyParts = {
            Enum.AvatarAssetType.Torso,
            Enum.AvatarAssetType.LeftArm,
            Enum.AvatarAssetType.RightArm,
            Enum.AvatarAssetType.LeftLeg,
            Enum.AvatarAssetType.RightLeg,
            Enum.AvatarAssetType.Head,
            Enum.AvatarAssetType.DynamicHead
        },
        ClassicFaces = { Enum.AvatarAssetType.Face },
        FacialFeatures = {
            Enum.AvatarAssetType.EyebrowAccessory,
            Enum.AvatarAssetType.EyelashAccessory
        },
        Gear = { Enum.AvatarAssetType.Gear }
    }
}

function v1.Combine(v2, v3) -- line 64
    local v4 = {}
    for v5, v6 in ipairs(v3) do
        for v7, v8 in ipairs(v6) do
            if table.find(v4, v8) == nil then
                table.insert(v4, v8)
            end
        end
    end
    return v4
end

function v1.Flatten(v9, v10) -- line 78
    local v11 = {}
    for v12, v13 in pairs(v10) do
        table.insert(v11, v13)
    end
    return v11
end

v1.Types.All = v1:Combine(v1:Flatten(v1.Types))
v1.Types.Clothing = v1:Combine({
    v1.Types.ClassicClothing,
    v1.Types.LayeredClothing
})
v1.Types.Accessories = v1:Combine({
    v1.Types.RigidAccessories,
    v1.Types.LayeredClothing,
    v1.Types.FacialFeatures
})
return v1
