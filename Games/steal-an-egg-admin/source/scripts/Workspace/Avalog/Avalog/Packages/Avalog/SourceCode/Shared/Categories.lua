-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local AvatarAssetTypes = require(script.Parent.AvatarAssetTypes)

local function PurgeBundles(v1) -- line 11 | captures: PurgeBundles
    local v2 = {}
    for v3, v4 in v1 do
        local v5
        if v4.SubCategories then
            v5 = PurgeBundles(v4.SubCategories)
            if #v5 == 0 then
                v5 = nil
            end
        end
        if v4.AssetTypes or v5 then
            local v6 = {}
            v6.Name = v4.Name
            v6.AssetTypes = v4.AssetTypes
            v6.BundleTypes = v4.BundleTypes
            v6.SubCategories = v5
            table.insert(v2, v6)
        end
    end
    return v2
end

local v7 = {
    Marketplace = {
        {
            Name = "Featured",
            CategoryFilter = Enum.CatalogCategoryFilter.Recommended,
            AssetTypes = AvatarAssetTypes.Types.All,
            BundleTypes = {
                Enum.BundleType.Animations,
                Enum.BundleType.BodyParts,
                Enum.BundleType.DynamicHead,
                Enum.BundleType.DynamicHeadAvatar,
                Enum.BundleType.Shoes
            }
        },
        {
            Name = "All",
            AssetTypes = AvatarAssetTypes.Types.All,
            BundleTypes = {
                Enum.BundleType.Animations,
                Enum.BundleType.BodyParts,
                Enum.BundleType.DynamicHead,
                Enum.BundleType.DynamicHeadAvatar,
                Enum.BundleType.Shoes
            }
        },
        {
            Name = "Body",
            SubCategories = {
                {
                    Name = "Bodies",
                    BundleTypes = { Enum.BundleType.BodyParts }
                },
                {
                    Name = "Hair",
                    AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                },
                {
                    Name = "Heads",
                    BundleTypes = { Enum.BundleType.DynamicHead },
                    AssetTypes = { Enum.AvatarAssetType.DynamicHead }
                }
            }
        },
        {
            Name = "Clothing",
            SubCategories = {
                {
                    Name = "Shirts",
                    AssetTypes = { Enum.AvatarAssetType.ShirtAccessory }
                },
                {
                    Name = "T-Shirts",
                    AssetTypes = { Enum.AvatarAssetType.TShirtAccessory }
                },
                {
                    Name = "Sweaters",
                    AssetTypes = { Enum.AvatarAssetType.SweaterAccessory }
                },
                {
                    Name = "Jackets",
                    AssetTypes = { Enum.AvatarAssetType.JacketAccessory }
                },
                {
                    Name = "Pants",
                    AssetTypes = { Enum.AvatarAssetType.PantsAccessory }
                },
                {
                    Name = "Dresses & Skirts",
                    AssetTypes = { Enum.AvatarAssetType.DressSkirtAccessory }
                },
                {
                    Name = "Shorts",
                    AssetTypes = { Enum.AvatarAssetType.ShortsAccessory }
                },
                {
                    Name = "Shoes",
                    AssetTypes = {
                        Enum.AvatarAssetType.LeftShoeAccessory,
                        Enum.AvatarAssetType.RightShoeAccessory
                    },
                    BundleTypes = { Enum.BundleType.Shoes }
                },
                {
                    Name = "Classic Shirts",
                    AssetTypes = { Enum.AvatarAssetType.Shirt }
                },
                {
                    Name = "Classic T-Shirts",
                    AssetTypes = { Enum.AvatarAssetType.TShirt }
                },
                {
                    Name = "Classic Pants",
                    AssetTypes = { Enum.AvatarAssetType.Pants }
                }
            }
        },
        {
            Name = "Accessories",
            SubCategories = {
                {
                    Name = "Head",
                    AssetTypes = { Enum.AvatarAssetType.Hat }
                },
                {
                    Name = "Face",
                    AssetTypes = { Enum.AvatarAssetType.FaceAccessory }
                },
                {
                    Name = "Neck",
                    AssetTypes = { Enum.AvatarAssetType.NeckAccessory }
                },
                {
                    Name = "Shoulder",
                    AssetTypes = { Enum.AvatarAssetType.ShoulderAccessory }
                },
                {
                    Name = "Front",
                    AssetTypes = { Enum.AvatarAssetType.FrontAccessory }
                },
                {
                    Name = "Back",
                    AssetTypes = { Enum.AvatarAssetType.BackAccessory }
                },
                {
                    Name = "Waist",
                    AssetTypes = { Enum.AvatarAssetType.WaistAccessory }
                }
            }
        },
        {
            Name = "Animation",
            SubCategories = {
                {
                    Name = "Bundles",
                    BundleTypes = { Enum.BundleType.Animations },
                    AssetTypes = AvatarAssetTypes.Types.Animations
                },
                {
                    Name = "Emotes",
                    AssetTypes = AvatarAssetTypes.Types.Emotes
                }
            }
        }
    },
    Inventory = {},
    Customize = {
        { Name = "Equipped" },
        { Name = "Skin" },
        { Name = "Build" }
    }
}

v7.Inventory = PurgeBundles(v7.Marketplace)
table.remove(v7.Inventory, 1)
return v7
