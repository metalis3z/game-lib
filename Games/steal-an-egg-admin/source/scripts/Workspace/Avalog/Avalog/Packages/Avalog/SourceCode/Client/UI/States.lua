-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Types = require(Parent.SourceCode.Shared.Types)
local v1 = Fusion.scoped(Fusion)

return {
    Theme = v1:Value(nil),
    Catalog = {
        SearchQuery = v1:Value(""),
        Mode = v1:Value(1),
        Category = v1:Value(1),
        SubCategory = v1:Value(1)
    },
    Avatar = {
        Data = v1:Value(nil),
        DataHistory = v1:Value({}),
        UndoHistory = v1:Value({}),
        AssetIds = v1:Value({}),
        EquippedAssetIds = v1:Value({}),
        EquippedBundleIds = v1:Value({}),
        Character = v1:Value(nil),
        Loaded = v1:Value(false)
    },
    Checkout = { Loading = v1:Value(false) },
    Inventory = { AccessAllowed = v1:Value(false) },
    Featured = {
        MessageShown = v1:Value(true),
        PrefixItems = v1:Value({}),
        Creators = v1:Value({})
    },
    CloudConfig = v1:Value(Types.AvalogConfig.Fallback),
    Screen = { Resolution = v1:Value(Vector2.new()) },
    Open = v1:Value(false)
}
