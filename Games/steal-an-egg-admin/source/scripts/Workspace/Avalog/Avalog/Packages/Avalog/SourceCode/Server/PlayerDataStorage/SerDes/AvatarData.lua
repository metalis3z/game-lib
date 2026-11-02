-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Squash = require(script.Parent.Parent.Parent.Parent.Parent.Parent.Squash)
local T = Squash.T
local v1 = Squash.record({
    AssetId = T(Squash.number(8)),
    AccessoryType = T(Squash.EnumItem(Enum.AccessoryType)),
    Order = T(Squash.opt(Squash.number(4))),
    Puffiness = T(Squash.opt(Squash.number(8))),
    IsLayered = T(Squash.opt(Squash.boolean())),
    Position = T(Squash.opt(Squash.Vector3(Squash.number(8)))),
    Rotation = T(Squash.opt(Squash.Vector3(Squash.number(8)))),
    Scale = T(Squash.opt(Squash.Vector3(Squash.number(8))))
})
local v2 = Squash.record({
    Name = T(Squash.string()),
    Slot = T(Squash.number(4))
})
return (Squash.record({
    Accessories = T(Squash.array(v1)),
    Emotes = T(Squash.map(Squash.string(), Squash.array(Squash.number(8)))),
    EquippedEmotes = T(Squash.array(v2)),
    Face = T(Squash.number(8)),
    Scale = T(Squash.record({
        BodyType = T(Squash.number(8)),
        Depth = T(Squash.number(8)),
        Head = T(Squash.number(8)),
        Height = T(Squash.number(8)),
        Proportion = T(Squash.number(8)),
        Width = T(Squash.number(8))
    })),
    Animations = T(Squash.record({
        Walk = T(Squash.number(8)),
        Run = T(Squash.number(8)),
        Fall = T(Squash.number(8)),
        Climb = T(Squash.number(8)),
        Swim = T(Squash.number(8)),
        Idle = T(Squash.number(8)),
        Mood = T(Squash.number(8)),
        Jump = T(Squash.number(8))
    })),
    BodyParts = T(Squash.record({
        Head = T(Squash.number(8)),
        Torso = T(Squash.number(8)),
        LeftArm = T(Squash.number(8)),
        RightArm = T(Squash.number(8)),
        LeftLeg = T(Squash.number(8)),
        RightLeg = T(Squash.number(8))
    })),
    BodyPartColors = T(Squash.record({
        Head = T(Squash.Color3()),
        Torso = T(Squash.Color3()),
        LeftArm = T(Squash.Color3()),
        RightArm = T(Squash.Color3()),
        LeftLeg = T(Squash.Color3()),
        RightLeg = T(Squash.Color3())
    })),
    Clothing = T(Squash.record({
        Shirt = T(Squash.number(8)),
        TShirt = T(Squash.number(8)),
        Pants = T(Squash.number(8))
    }))
}))
