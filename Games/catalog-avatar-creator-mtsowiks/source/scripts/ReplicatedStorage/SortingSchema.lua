-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Featured = {
        Readable = "Featured",
        LayoutOrder = 10,
        HorizontalLayoutOrder = 30,
        HorizontalAddDividerAfter = true,
        NoSubcategories = true,
        CategoryFilter = Enum.CatalogCategoryFilter.Featured
    },
    Recent = {
        Readable = "Recent",
        LayoutOrder = 25,
        HorizontalLayoutOrder = 25,
        AddDividerAfter = true,
        NoSubcategories = true,
        SpecialCase = "Recent"
    },
    Favorites = {
        Readable = "My Favorites",
        LayoutOrder = 15,
        HorizontalLayoutOrder = 10,
        SpecialCase = "Favorites",
        DefaultSubcategory = "All",
        Subcategories = {
            All = {
                Readable = "All",
                LayoutOrder = 0,
                AddDividerAfter = true,
                AssetTypes = {
                    Enum.AvatarAssetType.TShirt,
                    Enum.AvatarAssetType.Hat,
                    Enum.AvatarAssetType.Shirt,
                    Enum.AvatarAssetType.Pants,
                    Enum.AvatarAssetType.Head,
                    Enum.AvatarAssetType.Face,
                    Enum.AvatarAssetType.Gear,
                    Enum.AvatarAssetType.Torso,
                    Enum.AvatarAssetType.RightArm,
                    Enum.AvatarAssetType.LeftArm,
                    Enum.AvatarAssetType.LeftLeg,
                    Enum.AvatarAssetType.RightLeg,
                    Enum.AvatarAssetType.HairAccessory,
                    Enum.AvatarAssetType.FaceAccessory,
                    Enum.AvatarAssetType.NeckAccessory,
                    Enum.AvatarAssetType.ShoulderAccessory,
                    Enum.AvatarAssetType.FrontAccessory,
                    Enum.AvatarAssetType.BackAccessory,
                    Enum.AvatarAssetType.WaistAccessory,
                    Enum.AvatarAssetType.ClimbAnimation,
                    Enum.AvatarAssetType.FallAnimation,
                    Enum.AvatarAssetType.IdleAnimation,
                    Enum.AvatarAssetType.JumpAnimation,
                    Enum.AvatarAssetType.RunAnimation,
                    Enum.AvatarAssetType.SwimAnimation,
                    Enum.AvatarAssetType.WalkAnimation,
                    Enum.AvatarAssetType.EmoteAnimation,
                    Enum.AvatarAssetType.TShirtAccessory,
                    Enum.AvatarAssetType.ShirtAccessory,
                    Enum.AvatarAssetType.PantsAccessory,
                    Enum.AvatarAssetType.JacketAccessory,
                    Enum.AvatarAssetType.SweaterAccessory,
                    Enum.AvatarAssetType.ShortsAccessory,
                    Enum.AvatarAssetType.LeftShoeAccessory,
                    Enum.AvatarAssetType.RightShoeAccessory,
                    Enum.AvatarAssetType.DressSkirtAccessory,
                    Enum.AvatarAssetType.EyebrowAccessory,
                    Enum.AvatarAssetType.EyelashAccessory,
                    Enum.AvatarAssetType.MoodAnimation,
                    Enum.AvatarAssetType.DynamicHead,
                    Enum.AvatarAssetType.FaceMakeup,
                    Enum.AvatarAssetType.LipMakeup,
                    Enum.AvatarAssetType.EyeMakeup,
                    Enum.AvatarAssetType.AvatarBackground
                },
                BundleTypes = {
                    Enum.BundleType.BodyParts,
                    Enum.BundleType.DynamicHead,
                    Enum.BundleType.Animations,
                    Enum.BundleType.Shoes
                }
            },
            Accessories = {
                Readable = "Accessories",
                DefaultSubcategory = "All",
                LayoutOrder = 100,
                Subcategories = {
                    All = {
                        Readable = "All",
                        LayoutOrder = 0,
                        AddDividerAfter = true,
                        HorizontalAddDividerAfter = true,
                        AssetTypes = {
                            Enum.AvatarAssetType.Hat,
                            Enum.AvatarAssetType.HairAccessory,
                            Enum.AvatarAssetType.FaceAccessory,
                            Enum.AvatarAssetType.NeckAccessory,
                            Enum.AvatarAssetType.ShoulderAccessory,
                            Enum.AvatarAssetType.FrontAccessory,
                            Enum.AvatarAssetType.BackAccessory,
                            Enum.AvatarAssetType.WaistAccessory,
                            Enum.AvatarAssetType.Gear
                        }
                    },
                    Hat = {
                        Readable = "Hat",
                        LayoutOrder = 10,
                        AssetTypes = { Enum.AvatarAssetType.Hat }
                    },
                    Hair = {
                        Readable = "Hair",
                        LayoutOrder = 12,
                        AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                    },
                    Face = {
                        Readable = "Face",
                        LayoutOrder = 13,
                        AssetTypes = { Enum.AvatarAssetType.FaceAccessory }
                    },
                    Neck = {
                        Readable = "Neck",
                        LayoutOrder = 14,
                        AssetTypes = { Enum.AvatarAssetType.NeckAccessory }
                    },
                    Shoulder = {
                        Readable = "Shoulder",
                        LayoutOrder = 15,
                        AssetTypes = { Enum.AvatarAssetType.ShoulderAccessory }
                    },
                    Front = {
                        Readable = "Front",
                        LayoutOrder = 16,
                        AssetTypes = { Enum.AvatarAssetType.FrontAccessory }
                    },
                    Back = {
                        Readable = "Back",
                        LayoutOrder = 17,
                        AssetTypes = { Enum.AvatarAssetType.BackAccessory }
                    },
                    Waist = {
                        Readable = "Waist",
                        LayoutOrder = 18,
                        AssetTypes = { Enum.AvatarAssetType.WaistAccessory }
                    },
                    Gear = {
                        Readable = "Gear",
                        LayoutOrder = 19,
                        AssetTypes = { Enum.AvatarAssetType.Gear }
                    }
                }
            },
            Clothing = {
                Readable = "Clothing",
                DefaultSubcategory = "All",
                LayoutOrder = 130,
                Subcategories = {
                    All = {
                        Readable = "All",
                        LayoutOrder = 20,
                        AlignLeft = true,
                        AddDividerAfter = true,
                        HorizontalAddDividerAfter = true,
                        AssetTypes = {
                            Enum.AvatarAssetType.TShirtAccessory,
                            Enum.AvatarAssetType.ShirtAccessory,
                            Enum.AvatarAssetType.PantsAccessory,
                            Enum.AvatarAssetType.JacketAccessory,
                            Enum.AvatarAssetType.SweaterAccessory,
                            Enum.AvatarAssetType.ShortsAccessory,
                            Enum.AvatarAssetType.LeftShoeAccessory,
                            Enum.AvatarAssetType.RightShoeAccessory,
                            Enum.AvatarAssetType.DressSkirtAccessory,
                            Enum.AvatarAssetType.Shirt,
                            Enum.AvatarAssetType.Pants,
                            Enum.AvatarAssetType.TShirt
                        }
                    },
                    AllClassic = {
                        Readable = "All Classic",
                        LayoutOrder = 10,
                        AssetTypes = { Enum.AvatarAssetType.Shirt, Enum.AvatarAssetType.Pants, Enum.AvatarAssetType.TShirt }
                    },
                    AllLayered = {
                        Readable = "All Layered",
                        LayoutOrder = 0,
                        AssetTypes = {
                            Enum.AvatarAssetType.TShirtAccessory,
                            Enum.AvatarAssetType.ShirtAccessory,
                            Enum.AvatarAssetType.PantsAccessory,
                            Enum.AvatarAssetType.JacketAccessory,
                            Enum.AvatarAssetType.SweaterAccessory,
                            Enum.AvatarAssetType.ShortsAccessory,
                            Enum.AvatarAssetType.LeftShoeAccessory,
                            Enum.AvatarAssetType.RightShoeAccessory,
                            Enum.AvatarAssetType.DressSkirtAccessory
                        }
                    },
                    ClassicTShirts = {
                        Readable = "Classic T-Shirts",
                        LayoutOrder = 30,
                        AssetTypes = { Enum.AvatarAssetType.TShirt }
                    },
                    ClassicShirt = {
                        Readable = "Classic Shirt",
                        LayoutOrder = 40,
                        AssetTypes = { Enum.AvatarAssetType.Shirt }
                    },
                    ClassicPants = {
                        Readable = "Classic Pants",
                        LayoutOrder = 50,
                        HorizontalAddDividerAfter = true,
                        AssetTypes = { Enum.AvatarAssetType.Pants }
                    },
                    TShirt = {
                        Readable = "T-Shirt",
                        LayoutOrder = 60,
                        AssetTypes = { Enum.AvatarAssetType.TShirtAccessory }
                    },
                    Shirt = {
                        Readable = "Shirt",
                        LayoutOrder = 70,
                        AssetTypes = { Enum.AvatarAssetType.ShirtAccessory }
                    },
                    Pants = {
                        Readable = "Pants",
                        LayoutOrder = 80,
                        AssetTypes = { Enum.AvatarAssetType.PantsAccessory }
                    },
                    Jacket = {
                        Readable = "Jacket",
                        LayoutOrder = 90,
                        AssetTypes = { Enum.AvatarAssetType.JacketAccessory }
                    },
                    Sweater = {
                        Readable = "Sweater",
                        LayoutOrder = 100,
                        AssetTypes = { Enum.AvatarAssetType.SweaterAccessory }
                    },
                    Shorts = {
                        Readable = "Shorts",
                        LayoutOrder = 110,
                        AssetTypes = { Enum.AvatarAssetType.ShortsAccessory }
                    },
                    DressesAndSkirts = {
                        Readable = "Dresses & Skirts",
                        LayoutOrder = 120,
                        AssetTypes = { Enum.AvatarAssetType.DressSkirtAccessory }
                    },
                    Shoes = {
                        Readable = "Shoes",
                        LayoutOrder = 130,
                        AssetTypes = { Enum.AvatarAssetType.LeftShoeAccessory, Enum.AvatarAssetType.RightShoeAccessory },
                        BundleTypes = { Enum.BundleType.Shoes }
                    }
                }
            },
            Hair = {
                Readable = "Hair",
                DefaultSubcategory = "All",
                LayoutOrder = 110,
                Subcategories = {
                    All = {
                        Readable = "All",
                        AddDividerAfter = true,
                        HorizontalAddDividerAfter = true,
                        LayoutOrder = 0,
                        AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                    },
                    Masculine = {
                        Readable = "Masculine",
                        LayoutOrder = 10,
                        SearchKeyword = "boy",
                        AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                    },
                    Feminine = {
                        Readable = "Feminine",
                        LayoutOrder = 20,
                        SearchKeyword = "girl",
                        AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                    },
                    Bangs = {
                        Readable = "Bangs",
                        LayoutOrder = 30,
                        SearchKeyword = "bangs",
                        AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                    }
                }
            },
            Heads = {
                Readable = "Heads",
                LayoutOrder = 160,
                DefaultSubcategory = "All",
                Subcategories = {
                    All = {
                        Readable = "All",
                        AddDividerAfter = true,
                        LayoutOrder = 0,
                        AssetTypes = { Enum.AvatarAssetType.Head, Enum.AvatarAssetType.DynamicHead },
                        BundleTypes = { Enum.BundleType.DynamicHead }
                    },
                    Face = {
                        Readable = "Face",
                        SearchKeyword = "face",
                        LayoutOrder = 12,
                        BundleTypes = { Enum.BundleType.DynamicHead }
                    },
                    ["3D"] = {
                        Readable = "3D Face",
                        SearchKeyword = "3d face",
                        LayoutOrder = 13,
                        AssetTypes = { Enum.AvatarAssetType.FaceAccessory }
                    },
                    Hair = {
                        Readable = "Hair",
                        LayoutOrder = 14,
                        AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                    }
                }
            },
            BodyParts = {
                Readable = "Body Parts",
                LayoutOrder = 200,
                DefaultSubcategory = "All",
                Subcategories = {
                    All = {
                        Readable = "All",
                        AddDividerAfter = true,
                        LayoutOrder = 0,
                        AssetTypes = {
                            Enum.AvatarAssetType.Head,
                            Enum.AvatarAssetType.DynamicHead,
                            Enum.AvatarAssetType.LeftArm,
                            Enum.AvatarAssetType.LeftLeg,
                            Enum.AvatarAssetType.RightArm,
                            Enum.AvatarAssetType.RightLeg,
                            Enum.AvatarAssetType.Torso
                        }
                    },
                    DynamicHeads = {
                        Readable = "Heads",
                        LayoutOrder = 20,
                        AssetTypes = { Enum.AvatarAssetType.DynamicHead }
                    },
                    LeftArms = {
                        Readable = "Left Arms",
                        LayoutOrder = 30,
                        AssetTypes = { Enum.AvatarAssetType.LeftArm }
                    },
                    RightArms = {
                        Readable = "Right Arms",
                        LayoutOrder = 40,
                        AssetTypes = { Enum.AvatarAssetType.RightArm }
                    },
                    LeftLegs = {
                        Readable = "Left Legs",
                        LayoutOrder = 50,
                        AssetTypes = { Enum.AvatarAssetType.LeftLeg }
                    },
                    RightLegs = {
                        Readable = "Right Legs",
                        LayoutOrder = 60,
                        AssetTypes = { Enum.AvatarAssetType.RightLeg }
                    },
                    Torsos = {
                        Readable = "Torsos",
                        LayoutOrder = 25,
                        AssetTypes = { Enum.AvatarAssetType.Torso }
                    }
                }
            },
            Animations = {
                Readable = "Animations",
                DefaultSubcategory = "All",
                LayoutOrder = 180,
                Subcategories = {
                    All = {
                        Readable = "All",
                        AddDividerAfter = true,
                        HorizontalAddDividerAfter = true,
                        LayoutOrder = 0,
                        AssetTypes = {
                            Enum.AvatarAssetType.EmoteAnimation,
                            Enum.AvatarAssetType.ClimbAnimation,
                            Enum.AvatarAssetType.FallAnimation,
                            Enum.AvatarAssetType.IdleAnimation,
                            Enum.AvatarAssetType.JumpAnimation,
                            Enum.AvatarAssetType.RunAnimation,
                            Enum.AvatarAssetType.SwimAnimation,
                            Enum.AvatarAssetType.WalkAnimation
                        },
                        BundleTypes = { Enum.BundleType.Animations }
                    },
                    Emotes = {
                        Readable = "Emotes",
                        LayoutOrder = 10,
                        AssetTypes = { Enum.AvatarAssetType.EmoteAnimation }
                    },
                    Movement = {
                        Readable = "Movement",
                        LayoutOrder = 15,
                        AssetTypes = {
                            Enum.AvatarAssetType.ClimbAnimation,
                            Enum.AvatarAssetType.FallAnimation,
                            Enum.AvatarAssetType.IdleAnimation,
                            Enum.AvatarAssetType.JumpAnimation,
                            Enum.AvatarAssetType.RunAnimation,
                            Enum.AvatarAssetType.SwimAnimation,
                            Enum.AvatarAssetType.WalkAnimation
                        }
                    },
                    AnimationBundles = {
                        Readable = "Animation Bundles",
                        LayoutOrder = 20,
                        BundleTypes = { Enum.BundleType.Animations }
                    }
                }
            },
            Makeup = {
                Readable = "Makeup",
                DefaultSubcategory = "All",
                LayoutOrder = 173,
                Subcategories = {
                    All = {
                        Readable = "All",
                        AddDividerAfter = true,
                        HorizontalAddDividerAfter = true,
                        LayoutOrder = 0,
                        AssetTypes = { Enum.AvatarAssetType.FaceMakeup, Enum.AvatarAssetType.LipMakeup, Enum.AvatarAssetType.EyeMakeup }
                    },
                    Face = {
                        Readable = "Face",
                        LayoutOrder = 10,
                        AssetTypes = { Enum.AvatarAssetType.FaceMakeup }
                    },
                    Lip = {
                        Readable = "Lips",
                        LayoutOrder = 20,
                        AssetTypes = { Enum.AvatarAssetType.LipMakeup }
                    },
                    Eye = {
                        Readable = "Eyes",
                        LayoutOrder = 30,
                        AssetTypes = { Enum.AvatarAssetType.EyeMakeup }
                    }
                }
            },
            Gears = {
                Readable = "Gears",
                LayoutOrder = 180,
                NoSubcategories = true,
                AssetTypes = { Enum.AvatarAssetType.Gear },
                Subcategories = {}
            },
            Characters = {
                Readable = "Characters",
                LayoutOrder = 170,
                NoSubcategories = true,
                BundleTypes = { Enum.BundleType.BodyParts },
                Subcategories = {}
            },
            Backgrounds = {
                Readable = "Backgrounds",
                LayoutOrder = 174,
                NoSubcategories = true,
                AssetTypes = { Enum.AvatarAssetType.AvatarBackground },
                Subcategories = {}
            }
        }
    },
    Inventory = {
        Readable = "My Inventory",
        LayoutOrder = 20,
        HorizontalLayoutOrder = 20,
        SpecialCase = "Inventory",
        Subcategories = {
            All = {
                Readable = "All",
                LayoutOrder = 0,
                NoSubcategories = true,
                AssetTypes = {
                    Enum.AvatarAssetType.TShirt,
                    Enum.AvatarAssetType.Hat,
                    Enum.AvatarAssetType.Shirt,
                    Enum.AvatarAssetType.Pants,
                    Enum.AvatarAssetType.Head,
                    Enum.AvatarAssetType.Face,
                    Enum.AvatarAssetType.Gear,
                    Enum.AvatarAssetType.Torso,
                    Enum.AvatarAssetType.RightArm,
                    Enum.AvatarAssetType.LeftArm,
                    Enum.AvatarAssetType.LeftLeg,
                    Enum.AvatarAssetType.RightLeg,
                    Enum.AvatarAssetType.HairAccessory,
                    Enum.AvatarAssetType.FaceAccessory,
                    Enum.AvatarAssetType.NeckAccessory,
                    Enum.AvatarAssetType.ShoulderAccessory,
                    Enum.AvatarAssetType.FrontAccessory,
                    Enum.AvatarAssetType.BackAccessory,
                    Enum.AvatarAssetType.WaistAccessory,
                    Enum.AvatarAssetType.ClimbAnimation,
                    Enum.AvatarAssetType.FallAnimation,
                    Enum.AvatarAssetType.IdleAnimation,
                    Enum.AvatarAssetType.JumpAnimation,
                    Enum.AvatarAssetType.RunAnimation,
                    Enum.AvatarAssetType.SwimAnimation,
                    Enum.AvatarAssetType.WalkAnimation,
                    Enum.AvatarAssetType.EmoteAnimation,
                    Enum.AvatarAssetType.TShirtAccessory,
                    Enum.AvatarAssetType.ShirtAccessory,
                    Enum.AvatarAssetType.PantsAccessory,
                    Enum.AvatarAssetType.JacketAccessory,
                    Enum.AvatarAssetType.SweaterAccessory,
                    Enum.AvatarAssetType.ShortsAccessory,
                    Enum.AvatarAssetType.LeftShoeAccessory,
                    Enum.AvatarAssetType.RightShoeAccessory,
                    Enum.AvatarAssetType.DressSkirtAccessory,
                    Enum.AvatarAssetType.EyebrowAccessory,
                    Enum.AvatarAssetType.EyelashAccessory,
                    Enum.AvatarAssetType.MoodAnimation,
                    Enum.AvatarAssetType.DynamicHead,
                    Enum.AvatarAssetType.FaceMakeup,
                    Enum.AvatarAssetType.LipMakeup,
                    Enum.AvatarAssetType.EyeMakeup,
                    Enum.AvatarAssetType.AvatarBackground
                }
            },
            Accessories = {
                Readable = "Accessories",
                DefaultSubcategory = "All",
                LayoutOrder = 100,
                Subcategories = {
                    All = {
                        Readable = "All",
                        LayoutOrder = 0,
                        AddDividerAfter = true,
                        HorizontalAddDividerAfter = true,
                        AssetTypes = {
                            Enum.AvatarAssetType.Hat,
                            Enum.AvatarAssetType.HairAccessory,
                            Enum.AvatarAssetType.FaceAccessory,
                            Enum.AvatarAssetType.NeckAccessory,
                            Enum.AvatarAssetType.ShoulderAccessory,
                            Enum.AvatarAssetType.FrontAccessory,
                            Enum.AvatarAssetType.BackAccessory,
                            Enum.AvatarAssetType.WaistAccessory,
                            Enum.AvatarAssetType.Gear
                        }
                    },
                    Hat = {
                        Readable = "Hat",
                        LayoutOrder = 10,
                        AssetTypes = { Enum.AvatarAssetType.Hat }
                    },
                    Hair = {
                        Readable = "Hair",
                        LayoutOrder = 12,
                        AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                    },
                    Face = {
                        Readable = "Face",
                        LayoutOrder = 13,
                        AssetTypes = { Enum.AvatarAssetType.FaceAccessory }
                    },
                    Neck = {
                        Readable = "Neck",
                        LayoutOrder = 14,
                        AssetTypes = { Enum.AvatarAssetType.NeckAccessory }
                    },
                    Shoulder = {
                        Readable = "Shoulder",
                        LayoutOrder = 15,
                        AssetTypes = { Enum.AvatarAssetType.ShoulderAccessory }
                    },
                    Front = {
                        Readable = "Front",
                        LayoutOrder = 16,
                        AssetTypes = { Enum.AvatarAssetType.FrontAccessory }
                    },
                    Back = {
                        Readable = "Back",
                        LayoutOrder = 17,
                        AssetTypes = { Enum.AvatarAssetType.BackAccessory }
                    },
                    Waist = {
                        Readable = "Waist",
                        LayoutOrder = 18,
                        AssetTypes = { Enum.AvatarAssetType.WaistAccessory }
                    },
                    Gear = {
                        Readable = "Gear",
                        LayoutOrder = 19,
                        AssetTypes = { Enum.AvatarAssetType.Gear }
                    }
                }
            },
            Clothing = {
                Readable = "Clothing",
                DefaultSubcategory = "All",
                LayoutOrder = 130,
                Subcategories = {
                    All = {
                        Readable = "All",
                        LayoutOrder = 20,
                        AlignLeft = true,
                        AddDividerAfter = true,
                        HorizontalAddDividerAfter = true,
                        AssetTypes = {
                            Enum.AvatarAssetType.TShirtAccessory,
                            Enum.AvatarAssetType.ShirtAccessory,
                            Enum.AvatarAssetType.PantsAccessory,
                            Enum.AvatarAssetType.JacketAccessory,
                            Enum.AvatarAssetType.SweaterAccessory,
                            Enum.AvatarAssetType.ShortsAccessory,
                            Enum.AvatarAssetType.LeftShoeAccessory,
                            Enum.AvatarAssetType.RightShoeAccessory,
                            Enum.AvatarAssetType.DressSkirtAccessory,
                            Enum.AvatarAssetType.Shirt,
                            Enum.AvatarAssetType.Pants,
                            Enum.AvatarAssetType.TShirt
                        }
                    },
                    AllClassic = {
                        Readable = "All Classic",
                        LayoutOrder = 10,
                        AssetTypes = { Enum.AvatarAssetType.Shirt, Enum.AvatarAssetType.Pants, Enum.AvatarAssetType.TShirt }
                    },
                    AllLayered = {
                        Readable = "All Layered",
                        LayoutOrder = 0,
                        AssetTypes = {
                            Enum.AvatarAssetType.TShirtAccessory,
                            Enum.AvatarAssetType.ShirtAccessory,
                            Enum.AvatarAssetType.PantsAccessory,
                            Enum.AvatarAssetType.JacketAccessory,
                            Enum.AvatarAssetType.SweaterAccessory,
                            Enum.AvatarAssetType.ShortsAccessory,
                            Enum.AvatarAssetType.LeftShoeAccessory,
                            Enum.AvatarAssetType.RightShoeAccessory,
                            Enum.AvatarAssetType.DressSkirtAccessory
                        }
                    },
                    ClassicTShirts = {
                        Readable = "Classic T-Shirts",
                        LayoutOrder = 30,
                        AssetTypes = { Enum.AvatarAssetType.TShirt }
                    },
                    ClassicShirt = {
                        Readable = "Classic Shirt",
                        LayoutOrder = 40,
                        AssetTypes = { Enum.AvatarAssetType.Shirt }
                    },
                    ClassicPants = {
                        Readable = "Classic Pants",
                        LayoutOrder = 50,
                        HorizontalAddDividerAfter = true,
                        AssetTypes = { Enum.AvatarAssetType.Pants }
                    },
                    TShirt = {
                        Readable = "T-Shirt",
                        LayoutOrder = 60,
                        AssetTypes = { Enum.AvatarAssetType.TShirtAccessory }
                    },
                    Shirt = {
                        Readable = "Shirt",
                        LayoutOrder = 70,
                        AssetTypes = { Enum.AvatarAssetType.ShirtAccessory }
                    },
                    Pants = {
                        Readable = "Pants",
                        LayoutOrder = 80,
                        AssetTypes = { Enum.AvatarAssetType.PantsAccessory }
                    },
                    Jacket = {
                        Readable = "Jacket",
                        LayoutOrder = 90,
                        AssetTypes = { Enum.AvatarAssetType.JacketAccessory }
                    },
                    Sweater = {
                        Readable = "Sweater",
                        LayoutOrder = 100,
                        AssetTypes = { Enum.AvatarAssetType.SweaterAccessory }
                    },
                    Shorts = {
                        Readable = "Shorts",
                        LayoutOrder = 110,
                        AssetTypes = { Enum.AvatarAssetType.ShortsAccessory }
                    },
                    DressesAndSkirts = {
                        Readable = "Dresses & Skirts",
                        LayoutOrder = 120,
                        AssetTypes = { Enum.AvatarAssetType.DressSkirtAccessory }
                    },
                    Shoes = {
                        Readable = "Shoes",
                        LayoutOrder = 130,
                        AssetTypes = { Enum.AvatarAssetType.LeftShoeAccessory, Enum.AvatarAssetType.RightShoeAccessory }
                    }
                }
            },
            Hair = {
                Readable = "Hair",
                DefaultSubcategory = "All",
                LayoutOrder = 110,
                Subcategories = {
                    All = {
                        Readable = "All",
                        AddDividerAfter = true,
                        HorizontalAddDividerAfter = true,
                        LayoutOrder = 0,
                        AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                    },
                    Masculine = {
                        Readable = "Masculine",
                        LayoutOrder = 10,
                        SearchKeyword = "boy",
                        AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                    },
                    Feminine = {
                        Readable = "Feminine",
                        LayoutOrder = 20,
                        SearchKeyword = "girl",
                        AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                    },
                    Bangs = {
                        Readable = "Bangs",
                        LayoutOrder = 30,
                        SearchKeyword = "bangs",
                        AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                    }
                }
            },
            Heads = {
                Readable = "Heads",
                LayoutOrder = 160,
                DefaultSubcategory = "All",
                Subcategories = {
                    All = {
                        Readable = "All",
                        AddDividerAfter = true,
                        LayoutOrder = 0,
                        AssetTypes = { Enum.AvatarAssetType.Head, Enum.AvatarAssetType.DynamicHead }
                    },
                    Face = {
                        Readable = "Face",
                        SearchKeyword = "face",
                        LayoutOrder = 12,
                        BundleTypes = { Enum.BundleType.DynamicHead }
                    },
                    Hair = {
                        Readable = "Hair",
                        LayoutOrder = 14,
                        AssetTypes = { Enum.AvatarAssetType.HairAccessory }
                    },
                    ["3D"] = {
                        Readable = "3D Face",
                        SearchKeyword = "3d face",
                        LayoutOrder = 13,
                        AssetTypes = { Enum.AvatarAssetType.FaceAccessory }
                    }
                }
            },
            BodyParts = {
                Readable = "Body Parts",
                LayoutOrder = 200,
                DefaultSubcategory = "All",
                Subcategories = {
                    All = {
                        Readable = "All",
                        AddDividerAfter = true,
                        LayoutOrder = 0,
                        AssetTypes = {
                            Enum.AvatarAssetType.Head,
                            Enum.AvatarAssetType.DynamicHead,
                            Enum.AvatarAssetType.LeftArm,
                            Enum.AvatarAssetType.LeftLeg,
                            Enum.AvatarAssetType.RightArm,
                            Enum.AvatarAssetType.RightLeg,
                            Enum.AvatarAssetType.Torso
                        }
                    },
                    DynamicHeads = {
                        Readable = "Dynamic Heads",
                        LayoutOrder = 20,
                        AssetTypes = { Enum.AvatarAssetType.DynamicHead }
                    },
                    LeftArms = {
                        Readable = "Left Arms",
                        LayoutOrder = 30,
                        AssetTypes = { Enum.AvatarAssetType.LeftArm }
                    },
                    RightArms = {
                        Readable = "Right Arms",
                        LayoutOrder = 40,
                        AssetTypes = { Enum.AvatarAssetType.RightArm }
                    },
                    LeftLegs = {
                        Readable = "Left Legs",
                        LayoutOrder = 50,
                        AssetTypes = { Enum.AvatarAssetType.LeftLeg }
                    },
                    RightLegs = {
                        Readable = "Right Legs",
                        LayoutOrder = 60,
                        AssetTypes = { Enum.AvatarAssetType.RightLeg }
                    },
                    Torsos = {
                        Readable = "Torsos",
                        LayoutOrder = 25,
                        AssetTypes = { Enum.AvatarAssetType.Torso }
                    }
                }
            },
            Animations = {
                Readable = "Animations",
                DefaultSubcategory = "All",
                LayoutOrder = 180,
                Subcategories = {
                    All = {
                        Readable = "All",
                        AddDividerAfter = true,
                        HorizontalAddDividerAfter = true,
                        LayoutOrder = 0,
                        AssetTypes = {
                            Enum.AvatarAssetType.EmoteAnimation,
                            Enum.AvatarAssetType.FallAnimation,
                            Enum.AvatarAssetType.IdleAnimation,
                            Enum.AvatarAssetType.JumpAnimation,
                            Enum.AvatarAssetType.RunAnimation,
                            Enum.AvatarAssetType.SwimAnimation,
                            Enum.AvatarAssetType.WalkAnimation
                        }
                    },
                    Emotes = {
                        Readable = "Emotes",
                        LayoutOrder = 10,
                        AssetTypes = { Enum.AvatarAssetType.EmoteAnimation }
                    },
                    Movement = {
                        Readable = "Movement",
                        LayoutOrder = 15,
                        AssetTypes = {
                            Enum.AvatarAssetType.ClimbAnimation,
                            Enum.AvatarAssetType.FallAnimation,
                            Enum.AvatarAssetType.IdleAnimation,
                            Enum.AvatarAssetType.JumpAnimation,
                            Enum.AvatarAssetType.RunAnimation,
                            Enum.AvatarAssetType.SwimAnimation,
                            Enum.AvatarAssetType.WalkAnimation
                        }
                    }
                }
            },
            Makeup = {
                Readable = "Makeup",
                DefaultSubcategory = "All",
                LayoutOrder = 173,
                Subcategories = {
                    All = {
                        Readable = "All",
                        AddDividerAfter = true,
                        HorizontalAddDividerAfter = true,
                        LayoutOrder = 0,
                        AssetTypes = { Enum.AvatarAssetType.FaceMakeup, Enum.AvatarAssetType.LipMakeup, Enum.AvatarAssetType.EyeMakeup }
                    },
                    Face = {
                        Readable = "Face",
                        LayoutOrder = 10,
                        AssetTypes = { Enum.AvatarAssetType.FaceMakeup }
                    },
                    Lip = {
                        Readable = "Lips",
                        LayoutOrder = 20,
                        AssetTypes = { Enum.AvatarAssetType.LipMakeup }
                    },
                    Eye = {
                        Readable = "Eyes",
                        LayoutOrder = 30,
                        AssetTypes = { Enum.AvatarAssetType.EyeMakeup }
                    }
                }
            },
            Gears = {
                Readable = "Gears",
                LayoutOrder = 180,
                NoSubcategories = true,
                AssetTypes = { Enum.AvatarAssetType.Gear },
                Subcategories = {}
            },
            Backgrounds = {
                Readable = "Backgrounds",
                LayoutOrder = 174,
                NoSubcategories = true,
                AssetTypes = { Enum.AvatarAssetType.AvatarBackground },
                Subcategories = {}
            }
        }
    },
    Accessories = {
        Readable = "Accessories",
        DefaultSubcategory = "All",
        LayoutOrder = 100,
        Subcategories = {
            All = {
                Readable = "All",
                LayoutOrder = 0,
                AddDividerAfter = true,
                HorizontalAddDividerAfter = true,
                AssetTypes = {
                    Enum.AvatarAssetType.Hat,
                    Enum.AvatarAssetType.FaceAccessory,
                    Enum.AvatarAssetType.NeckAccessory,
                    Enum.AvatarAssetType.ShoulderAccessory,
                    Enum.AvatarAssetType.FrontAccessory,
                    Enum.AvatarAssetType.BackAccessory,
                    Enum.AvatarAssetType.WaistAccessory,
                    Enum.AvatarAssetType.Gear
                }
            },
            Hat = {
                Readable = "Hat",
                LayoutOrder = 10,
                AssetTypes = { Enum.AvatarAssetType.Hat }
            },
            Hair = {
                Readable = "Hair",
                LayoutOrder = 12,
                AssetTypes = { Enum.AvatarAssetType.HairAccessory }
            },
            Face = {
                Readable = "Face",
                LayoutOrder = 13,
                AssetTypes = { Enum.AvatarAssetType.FaceAccessory }
            },
            Neck = {
                Readable = "Neck",
                LayoutOrder = 14,
                AssetTypes = { Enum.AvatarAssetType.NeckAccessory }
            },
            Shoulder = {
                Readable = "Shoulder",
                LayoutOrder = 15,
                AssetTypes = { Enum.AvatarAssetType.ShoulderAccessory }
            },
            Front = {
                Readable = "Front",
                LayoutOrder = 16,
                AssetTypes = { Enum.AvatarAssetType.FrontAccessory }
            },
            Back = {
                Readable = "Back",
                LayoutOrder = 17,
                AssetTypes = { Enum.AvatarAssetType.BackAccessory }
            },
            Waist = {
                Readable = "Waist",
                LayoutOrder = 18,
                AssetTypes = { Enum.AvatarAssetType.WaistAccessory }
            },
            Gear = {
                Readable = "Gear",
                LayoutOrder = 19,
                AssetTypes = { Enum.AvatarAssetType.Gear }
            }
        }
    },
    Clothing = {
        Readable = "Clothing",
        DefaultSubcategory = "All",
        LayoutOrder = 130,
        Subcategories = {
            All = {
                Readable = "All",
                LayoutOrder = 20,
                AlignLeft = true,
                AddDividerAfter = true,
                HorizontalAddDividerAfter = true,
                AssetTypes = {
                    Enum.AvatarAssetType.TShirtAccessory,
                    Enum.AvatarAssetType.ShirtAccessory,
                    Enum.AvatarAssetType.PantsAccessory,
                    Enum.AvatarAssetType.JacketAccessory,
                    Enum.AvatarAssetType.SweaterAccessory,
                    Enum.AvatarAssetType.ShortsAccessory,
                    Enum.AvatarAssetType.LeftShoeAccessory,
                    Enum.AvatarAssetType.RightShoeAccessory,
                    Enum.AvatarAssetType.DressSkirtAccessory,
                    Enum.AvatarAssetType.Shirt,
                    Enum.AvatarAssetType.Pants,
                    Enum.AvatarAssetType.TShirt
                }
            },
            AllClassic = {
                Readable = "All Classic",
                LayoutOrder = 10,
                AssetTypes = {
                    Enum.AvatarAssetType.TShirtAccessory,
                    Enum.AvatarAssetType.ShirtAccessory,
                    Enum.AvatarAssetType.PantsAccessory,
                    Enum.AvatarAssetType.JacketAccessory,
                    Enum.AvatarAssetType.SweaterAccessory,
                    Enum.AvatarAssetType.ShortsAccessory,
                    Enum.AvatarAssetType.LeftShoeAccessory,
                    Enum.AvatarAssetType.RightShoeAccessory,
                    Enum.AvatarAssetType.DressSkirtAccessory,
                    Enum.AvatarAssetType.Shirt,
                    Enum.AvatarAssetType.Pants,
                    Enum.AvatarAssetType.TShirt
                },
                FilterOutAfterResults = {
                    Enum.AvatarAssetType.TShirtAccessory,
                    Enum.AvatarAssetType.ShirtAccessory,
                    Enum.AvatarAssetType.PantsAccessory,
                    Enum.AvatarAssetType.JacketAccessory,
                    Enum.AvatarAssetType.SweaterAccessory,
                    Enum.AvatarAssetType.ShortsAccessory,
                    Enum.AvatarAssetType.LeftShoeAccessory,
                    Enum.AvatarAssetType.RightShoeAccessory,
                    Enum.AvatarAssetType.DressSkirtAccessory
                }
            },
            AllLayered = {
                Readable = "All Layered",
                LayoutOrder = 0,
                AssetTypes = {
                    Enum.AvatarAssetType.TShirtAccessory,
                    Enum.AvatarAssetType.ShirtAccessory,
                    Enum.AvatarAssetType.PantsAccessory,
                    Enum.AvatarAssetType.JacketAccessory,
                    Enum.AvatarAssetType.SweaterAccessory,
                    Enum.AvatarAssetType.ShortsAccessory,
                    Enum.AvatarAssetType.LeftShoeAccessory,
                    Enum.AvatarAssetType.RightShoeAccessory,
                    Enum.AvatarAssetType.DressSkirtAccessory,
                    Enum.AvatarAssetType.Shirt,
                    Enum.AvatarAssetType.Pants,
                    Enum.AvatarAssetType.TShirt
                },
                FilterOutAfterResults = { Enum.AvatarAssetType.Shirt, Enum.AvatarAssetType.Pants, Enum.AvatarAssetType.TShirt }
            },
            ClassicTShirts = {
                Readable = "Classic T-Shirt",
                LayoutOrder = 30,
                AssetTypes = { Enum.AvatarAssetType.TShirt }
            },
            ClassicShirt = {
                Readable = "Classic Shirt",
                LayoutOrder = 40,
                AssetTypes = { Enum.AvatarAssetType.Shirt }
            },
            ClassicPants = {
                Readable = "Classic Pants",
                LayoutOrder = 50,
                HorizontalAddDividerAfter = true,
                AssetTypes = { Enum.AvatarAssetType.Pants }
            },
            TShirt = {
                Readable = "T-Shirt",
                LayoutOrder = 60,
                AssetTypes = { Enum.AvatarAssetType.TShirtAccessory }
            },
            Shirt = {
                Readable = "Shirt",
                LayoutOrder = 70,
                AssetTypes = { Enum.AvatarAssetType.ShirtAccessory }
            },
            Pants = {
                Readable = "Pants",
                LayoutOrder = 80,
                AssetTypes = { Enum.AvatarAssetType.PantsAccessory }
            },
            Jacket = {
                Readable = "Jacket",
                LayoutOrder = 90,
                AssetTypes = { Enum.AvatarAssetType.JacketAccessory }
            },
            Sweater = {
                Readable = "Sweater",
                LayoutOrder = 100,
                AssetTypes = { Enum.AvatarAssetType.SweaterAccessory }
            },
            Shorts = {
                Readable = "Shorts",
                LayoutOrder = 110,
                AssetTypes = { Enum.AvatarAssetType.ShortsAccessory }
            },
            DressesAndSkirts = {
                Readable = "Dresses & Skirts",
                LayoutOrder = 120,
                AssetTypes = { Enum.AvatarAssetType.DressSkirtAccessory }
            },
            Shoes = {
                Readable = "Shoes",
                LayoutOrder = 130,
                BundleTypes = { Enum.BundleType.Shoes }
            }
        }
    },
    Animations = {
        Readable = "Animations",
        DefaultSubcategory = "All",
        LayoutOrder = 172,
        Subcategories = {
            All = {
                Readable = "All",
                AddDividerAfter = true,
                HorizontalAddDividerAfter = true,
                LayoutOrder = 0,
                AssetTypes = { Enum.AvatarAssetType.EmoteAnimation },
                BundleTypes = { Enum.BundleType.Animations }
            },
            Emotes = {
                Readable = "Emotes",
                LayoutOrder = 10,
                AssetTypes = { Enum.AvatarAssetType.EmoteAnimation }
            },
            AnimationBundles = {
                Readable = "Animation Bundles",
                LayoutOrder = 20,
                SearchKeyword = "animation pack",
                IgnorePersonalizedSearchResults = true,
                BundleTypes = { Enum.BundleType.Animations }
            }
        }
    },
    Makeup = {
        Readable = "Makeup",
        DefaultSubcategory = "All",
        LayoutOrder = 173,
        Subcategories = {
            All = {
                Readable = "All",
                AddDividerAfter = true,
                HorizontalAddDividerAfter = true,
                LayoutOrder = 0,
                AssetTypes = { Enum.AvatarAssetType.FaceMakeup, Enum.AvatarAssetType.LipMakeup, Enum.AvatarAssetType.EyeMakeup }
            },
            Face = {
                Readable = "Face",
                LayoutOrder = 10,
                AssetTypes = { Enum.AvatarAssetType.FaceMakeup }
            },
            Lip = {
                Readable = "Lips",
                LayoutOrder = 20,
                AssetTypes = { Enum.AvatarAssetType.LipMakeup }
            },
            Eye = {
                Readable = "Eyes",
                LayoutOrder = 30,
                AssetTypes = { Enum.AvatarAssetType.EyeMakeup }
            },
            Eyebrows = {
                Readable = "Eyebrows",
                LayoutOrder = 40,
                AssetTypes = { Enum.AvatarAssetType.EyebrowAccessory }
            },
            Eyelashes = {
                Readable = "Eyelashes",
                LayoutOrder = 50,
                AssetTypes = { Enum.AvatarAssetType.EyelashAccessory }
            }
        }
    },
    Characters = {
        Readable = "Characters",
        LayoutOrder = 170,
        NoSubcategories = true,
        BundleTypes = { Enum.BundleType.BodyParts },
        Subcategories = {}
    },
    Hair = {
        Readable = "Hair",
        DefaultSubcategory = "All",
        LayoutOrder = 110,
        Subcategories = {
            All = {
                Readable = "All",
                AddDividerAfter = true,
                HorizontalAddDividerAfter = true,
                LayoutOrder = 0,
                AssetTypes = { Enum.AvatarAssetType.HairAccessory }
            },
            Masculine = {
                Readable = "Masculine",
                LayoutOrder = 10,
                SearchKeyword = "boy",
                AssetTypes = { Enum.AvatarAssetType.HairAccessory }
            },
            Feminine = {
                Readable = "Feminine",
                LayoutOrder = 20,
                SearchKeyword = "girl",
                AssetTypes = { Enum.AvatarAssetType.HairAccessory }
            },
            Bangs = {
                Readable = "Bangs",
                LayoutOrder = 30,
                SearchKeyword = "bangs",
                AssetTypes = { Enum.AvatarAssetType.HairAccessory }
            }
        }
    },
    Heads = {
        Readable = "Heads",
        DefaultSubcategory = "All",
        LayoutOrder = 160,
        Subcategories = {
            All = {
                Readable = "All",
                AddDividerAfter = true,
                HorizontalAddDividerAfter = true,
                LayoutOrder = 11,
                BundleTypes = { Enum.BundleType.DynamicHead }
            },
            Face = {
                Readable = "Face",
                SearchKeyword = "face",
                LayoutOrder = 15,
                BundleTypes = { Enum.BundleType.DynamicHead }
            },
            Hair = {
                Readable = "Hair",
                LayoutOrder = 25,
                AssetTypes = { Enum.AvatarAssetType.HairAccessory }
            },
            ["3D"] = {
                Readable = "3D Face",
                SearchKeyword = "3d face",
                LayoutOrder = 20,
                AddDividerAfter = true,
                HorizontalAddDividerAfter = true,
                AssetTypes = { Enum.AvatarAssetType.FaceAccessory }
            },
            ByRoblox = {
                Readable = "By Roblox",
                LayoutOrder = 12,
                CreatorName = "Roblox",
                BundleTypes = { Enum.BundleType.DynamicHead }
            }
        }
    },
    Gears = {
        Readable = "Gears",
        NoSubcategories = true,
        LayoutOrder = 180,
        AssetTypes = { Enum.AvatarAssetType.Gear },
        Subcategories = {}
    },
    Collectibles = {
        Readable = "Collectibles",
        AddDividerAfter = true,
        LayoutOrder = 190,
        SalesTypeFilter = Enum.SalesTypeFilter.Collectibles,
        Subcategories = {
            All = {
                Readable = "All",
                LayoutOrder = 0
            },
            Accessories = {
                Readable = "Accessories",
                LayoutOrder = 10,
                AssetTypes = {
                    Enum.AvatarAssetType.Hat,
                    Enum.AvatarAssetType.FaceAccessory,
                    Enum.AvatarAssetType.NeckAccessory,
                    Enum.AvatarAssetType.ShoulderAccessory,
                    Enum.AvatarAssetType.FrontAccessory,
                    Enum.AvatarAssetType.BackAccessory,
                    Enum.AvatarAssetType.WaistAccessory,
                    Enum.AvatarAssetType.Gear
                }
            },
            ByRoblox = {
                Readable = "By Roblox",
                LayoutOrder = 11,
                CreatorName = "Roblox"
            }
        }
    },
    BodyAdjustment = {
        Readable = "Adjust Body",
        LayoutOrder = 175,
        SpecialCase = "BodyAdjustment",
        DefaultSubcategory = "Body",
        Subcategories = {
            Body = {
                Readable = "Body",
                LayoutOrder = 0,
                SpecialCase = "BodyAdjustment"
            },
            SkinTones = {
                Readable = "Skin Tones",
                LayoutOrder = 10,
                SpecialCase = "SkinTones",
                AddDividerAfter = true,
                HorizontalAddDividerAfter = true
            },
            Heads = {
                Readable = "Heads",
                LayoutOrder = 20,
                IgnorePersonalizedSearchResults = true,
                IncludeOffSale = true,
                BundleTypes = { Enum.BundleType.DynamicHead },
                AssetTypes = { Enum.AvatarAssetType.Head },
                SortType = Enum.CatalogSortType.MostFavorited,
                SortAggregation = Enum.CatalogSortAggregation.AllTime
            },
            HeadShapes = {
                Readable = "Head Shapes",
                LayoutOrder = 21,
                SpecialCase = "HeadShapes",
                Shapes = {
                    {
                        LayoutOrder = 1,
                        AssetId = 746767604,
                        Key = "Cheeks",
                        Name = "Cheeks"
                    },
                    {
                        LayoutOrder = 2,
                        AssetId = 746774687,
                        Key = "Narrow",
                        Name = "Narrow"
                    },
                    {
                        LayoutOrder = 3,
                        AssetId = 6340213,
                        Key = "Roundy",
                        Name = "Roundy"
                    },
                    {
                        LayoutOrder = 4,
                        AssetId = 6340101,
                        Key = "Blockhead",
                        Name = "Blockhead"
                    },
                    {
                        LayoutOrder = 5,
                        AssetId = 6340227,
                        Key = "Trim",
                        Name = "Trim"
                    },
                    {
                        LayoutOrder = 6,
                        AssetId = 86498113,
                        Key = "WomanHead",
                        Name = "Woman Head"
                    },
                    {
                        LayoutOrder = 7,
                        AssetId = 86498048,
                        Key = "ManHead",
                        Name = "Man Head"
                    },
                    {
                        LayoutOrder = 8,
                        AssetId = 616387160,
                        Key = "Chiseled",
                        Name = "Chiseled"
                    },
                    {
                        LayoutOrder = 9,
                        AssetId = 616398268,
                        Key = "Paragon",
                        Name = "Paragon"
                    },
                    {
                        LayoutOrder = 10,
                        AssetId = 6340269,
                        Key = "Perfection",
                        Name = "Perfection"
                    },
                    {
                        LayoutOrder = 11,
                        AssetId = 8330578,
                        Key = "Peabrain",
                        Name = "Peabrain"
                    },
                    {
                        LayoutOrder = 12,
                        AssetId = 6340198,
                        Key = "Roll",
                        Name = "Roll"
                    },
                    {
                        LayoutOrder = 13,
                        AssetId = 2432102561,
                        Key = "RobloxClassic",
                        Name = "Roblox Classic"
                    },
                    {
                        LayoutOrder = 14,
                        AssetId = 6340154,
                        Key = "RoxBox",
                        Name = "Rox Box"
                    },
                    {
                        LayoutOrder = 15,
                        AssetId = 8330389,
                        Key = "FatHead",
                        Name = "Fat Head"
                    },
                    {
                        LayoutOrder = 16,
                        AssetId = 6340161,
                        Key = "EraserHead",
                        Name = "Eraser Head"
                    },
                    {
                        LayoutOrder = 17,
                        AssetId = 6340208,
                        Key = "FlatTop",
                        Name = "Flat Top"
                    },
                    {
                        LayoutOrder = 18,
                        AssetId = 6340258,
                        Key = "CoolThing",
                        Name = "Cool Thing"
                    },
                    {
                        LayoutOrder = 19,
                        AssetId = 2510300430,
                        Key = "KnightOfChivalry",
                        Name = "Knight Of Chivalry"
                    },
                    {
                        LayoutOrder = 20,
                        AssetId = 2535709102,
                        Key = "KnightOfCourage",
                        Name = "Knight Of Courage"
                    },
                    {
                        LayoutOrder = 21,
                        AssetId = 6653077909,
                        Key = "GoldenMrRobot",
                        Name = "Golden Mr Robot"
                    },
                    {
                        LayoutOrder = 22,
                        AssetId = 6652984223,
                        Key = "MercilessNinja",
                        Name = "Merciless Ninja"
                    },
                    {
                        LayoutOrder = 23,
                        AssetId = 6678831309,
                        Key = "GoldenKorbloxGeneral",
                        Name = "Golden Korblox General"
                    },
                    {
                        LayoutOrder = 24,
                        AssetId = 6711225558,
                        Key = "TheEngineer",
                        Name = "The Engineer"
                    }
                }
            },
            Torsos = {
                Readable = "Torsos",
                LayoutOrder = 25,
                IgnorePersonalizedSearchResults = true,
                IncludeOffSale = true,
                AssetTypes = { Enum.AvatarAssetType.Torso },
                SortType = Enum.CatalogSortType.MostFavorited,
                SortAggregation = Enum.CatalogSortAggregation.AllTime
            },
            Arms = {
                Readable = "Arms",
                LayoutOrder = 30,
                IgnorePersonalizedSearchResults = true,
                IncludeOffSale = true,
                AssetTypes = { Enum.AvatarAssetType.LeftArm, Enum.AvatarAssetType.RightArm },
                SortType = Enum.CatalogSortType.MostFavorited,
                SortAggregation = Enum.CatalogSortAggregation.AllTime
            },
            Legs = {
                Readable = "Legs",
                LayoutOrder = 50,
                IgnorePersonalizedSearchResults = true,
                IncludeOffSale = true,
                AssetTypes = { Enum.AvatarAssetType.LeftLeg, Enum.AvatarAssetType.RightLeg },
                SortType = Enum.CatalogSortType.MostFavorited,
                SortAggregation = Enum.CatalogSortAggregation.AllTime
            }
        }
    },
    Backgrounds = {
        Readable = "Backgrounds",
        NoSubcategories = true,
        LayoutOrder = 174,
        AssetTypes = { Enum.AvatarAssetType.AvatarBackground },
        Subcategories = {}
    }
};