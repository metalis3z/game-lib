-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.Types)
local PickWeightedWith = require(ReplicatedStorage.Shared.Utils.Numeric).PickWeightedWith
local v1 = table.freeze({
    Normal = "Normal",
    Lazy = "Lazy",
    Loyal = "Loyal",
    Energetic = "Energetic",
    InvertedModel = "InvertedModel",
    Shy = "Shy",
    Scared = "Scared",
    ExtremelyEnergetic = "ExtremelyEnergetic",
    UltraLoyal = "UltraLoyal",
    JumpCrazy = "JumpCrazy"
})
local v2 = {
    RollWeight = 12,
    _id = v1.Energetic,
    Movement = {
        WalkSpeedMin = 9,
        WalkSpeedMax = 20,
        IdleSecondsMin = 0.1,
        IdleSecondsMax = 0.75,
        NearOwnerPreference = 0.2,
        IsolationPreference = 0,
        CurvedWanderChance = 0.62,
        BurstChance = 0.42,
        FollowOwnerInPen = false,
        AmbientJumpRatePerSecond = 0,
        AmbientSpinJumpChance = 0
    },
    Greeting = {
        Chance = 1,
        FirstPlacementChance = 1,
        FirstPlacementNormalChance = 0,
        FirstPlacementNormalJumpCount = 4,
        ReturnOrbitChance = 0.6,
        ReturnNormalJumpCount = 3,
        RandomOrbitChance = 0.2,
        RandomOrbitIntervalSeconds = 45,
        DurationSeconds = 6,
        JumpChancePerSecond = 0.85,
        SpinJumpChance = 0.3,
        Texts = { "\240\159\152\138", "\240\159\152\132", "\240\159\165\176" }
    },
    Affection = {
        Enabled = true,
        Chance = 0.125,
        IntervalSeconds = 5,
        DurationSeconds = 4.5,
        JumpCount = 5,
        Texts = {
            "\240\159\152\134",
            "\240\159\152\132",
            "\240\159\152\129",
            "\240\159\152\131",
            "\240\159\164\170",
            "\240\159\152\157",
            "\240\159\152\156",
            "\240\159\152\139",
            "\240\159\152\185",
            "\240\159\153\128",
            "\240\159\152\142"
        }
    }
}
local Greeting = v2.Greeting
local v3 = {
    Normal = {
        RollWeight = 37,
        _id = v1.Normal,
        Movement = {
            WalkSpeedMin = 6.5,
            WalkSpeedMax = 12,
            IdleSecondsMin = 1.2,
            IdleSecondsMax = 3.2,
            NearOwnerPreference = 0.14,
            IsolationPreference = 0,
            CurvedWanderChance = 0.16,
            BurstChance = 0.035,
            FollowOwnerInPen = false,
            AmbientJumpRatePerSecond = 0,
            AmbientSpinJumpChance = 0
        },
        Greeting = {
            Chance = 1,
            FirstPlacementChance = 0,
            FirstPlacementNormalChance = 1,
            FirstPlacementNormalJumpCount = 3,
            ReturnOrbitChance = 0,
            ReturnNormalJumpCount = 2,
            RandomOrbitChance = 0,
            RandomOrbitIntervalSeconds = 45,
            DurationSeconds = 6,
            JumpChancePerSecond = 0.8,
            SpinJumpChance = 0.08,
            Texts = { "\240\159\152\138", "\240\159\152\132", "\240\159\165\176" }
        },
        Affection = {
            Enabled = true,
            Chance = 0.16666666666666666,
            IntervalSeconds = 5,
            DurationSeconds = 4,
            JumpCount = 2,
            Texts = { "\240\159\152\138", "\240\159\152\132", "\240\159\153\130", "\226\152\186\239\184\143", "\240\159\165\176", "\240\159\152\131", "\240\159\152\129", "\240\159\164\151" }
        }
    },
    Lazy = {
        RollWeight = 15,
        _id = v1.Lazy,
        Movement = {
            WalkSpeedMin = 2.5,
            WalkSpeedMax = 3.75,
            IdleSecondsMin = 6,
            IdleSecondsMax = 15,
            NearOwnerPreference = 0.025,
            IsolationPreference = 0.08,
            CurvedWanderChance = 0.025,
            BurstChance = 0,
            FollowOwnerInPen = false,
            AmbientJumpRatePerSecond = 0,
            AmbientSpinJumpChance = 0
        },
        Greeting = {
            Chance = 0,
            FirstPlacementChance = 0,
            FirstPlacementNormalChance = 0,
            FirstPlacementNormalJumpCount = 0,
            ReturnOrbitChance = 0,
            ReturnNormalJumpCount = 1,
            RandomOrbitChance = 0,
            RandomOrbitIntervalSeconds = 60,
            DurationSeconds = 3.5,
            JumpChancePerSecond = 0.08,
            SpinJumpChance = 0,
            Texts = { "\240\159\152\138", "\240\159\152\132", "\240\159\165\176" }
        },
        Affection = {
            Enabled = false,
            Chance = 0,
            IntervalSeconds = 80,
            DurationSeconds = 0,
            JumpCount = 0,
            Texts = { "\240\159\152\180", "\240\159\165\177", "\240\159\152\170", "\240\159\152\140", "\240\159\152\144", "\240\159\152\145", "\240\159\152\182", "\240\159\153\131" }
        }
    },
    Loyal = {
        RollWeight = 10,
        _id = v1.Loyal,
        Movement = {
            WalkSpeedMin = 7.5,
            WalkSpeedMax = 10,
            IdleSecondsMin = 0.35,
            IdleSecondsMax = 1.25,
            NearOwnerPreference = 0.9,
            IsolationPreference = 0,
            CurvedWanderChance = 0.08,
            BurstChance = 0.055,
            FollowOwnerInPen = true,
            AmbientJumpRatePerSecond = 0,
            AmbientSpinJumpChance = 0
        },
        Greeting = {
            Chance = 1,
            FirstPlacementChance = 1,
            FirstPlacementNormalChance = 0,
            FirstPlacementNormalJumpCount = 3,
            ReturnOrbitChance = 0.45,
            ReturnNormalJumpCount = 2,
            RandomOrbitChance = 0.08,
            RandomOrbitIntervalSeconds = 45,
            DurationSeconds = 6.5,
            JumpChancePerSecond = 0.55,
            SpinJumpChance = 0.06,
            Texts = { "Mama" }
        },
        Affection = {
            Enabled = true,
            Chance = 0.002976190476190476,
            IntervalSeconds = 5,
            DurationSeconds = 5,
            JumpCount = 2,
            Texts = { "\240\159\165\176", "\240\159\152\141", "\240\159\152\138", "\226\152\186\239\184\143", "\240\159\164\151", "\240\159\152\154" }
        }
    },
    Energetic = v2,
    InvertedModel = {
        RollWeight = 1.5,
        _id = v1.InvertedModel,
        Movement = v2.Movement,
        Greeting = {
            Chance = Greeting.Chance,
            FirstPlacementChance = Greeting.FirstPlacementChance,
            FirstPlacementNormalChance = Greeting.FirstPlacementNormalChance,
            FirstPlacementNormalJumpCount = Greeting.FirstPlacementNormalJumpCount,
            ReturnOrbitChance = Greeting.ReturnOrbitChance,
            ReturnNormalJumpCount = Greeting.ReturnNormalJumpCount,
            RandomOrbitChance = Greeting.RandomOrbitChance,
            RandomOrbitIntervalSeconds = Greeting.RandomOrbitIntervalSeconds,
            DurationSeconds = Greeting.DurationSeconds,
            JumpChancePerSecond = Greeting.JumpChancePerSecond,
            SpinJumpChance = Greeting.SpinJumpChance,
            Texts = {
                "//ERRsORijwoR//",
                "0x?#!@NLL",
                "01011010???",
                "\226\150\147\226\150\146\226\150\145???\226\150\145\226\150\146\226\150\147",
                "M4M4.EXE???",
                "##!%$@//",
                "<???:'aWsFE>",
                "1010_=249_0101",
                "??//V//#"
            }
        },
        Affection = v2.Affection
    },
    Shy = {
        RollWeight = 10,
        _id = v1.Shy,
        Movement = {
            WalkSpeedMin = 3,
            WalkSpeedMax = 5,
            IdleSecondsMin = 5.5,
            IdleSecondsMax = 14,
            NearOwnerPreference = 0,
            IsolationPreference = 0.95,
            CurvedWanderChance = 0.035,
            BurstChance = 0,
            FollowOwnerInPen = false,
            AmbientJumpRatePerSecond = 0,
            AmbientSpinJumpChance = 0,
            Retreat = {
                TriggerDistance = 22,
                Chance = 0.85,
                MaxTravelDistance = 16
            }
        },
        Greeting = {
            Chance = 0,
            FirstPlacementChance = 0,
            FirstPlacementBubbleChance = 0,
            FirstPlacementNormalChance = 0,
            FirstPlacementNormalJumpCount = 0,
            ReturnOrbitChance = 0,
            ReturnNormalJumpCount = 0,
            RandomOrbitChance = 0,
            RandomOrbitIntervalSeconds = 30,
            DurationSeconds = 0,
            JumpChancePerSecond = 0,
            SpinJumpChance = 0,
            Texts = { "\240\159\152\138" }
        },
        Affection = {
            Enabled = false,
            Chance = 0,
            IntervalSeconds = 50,
            DurationSeconds = 0,
            JumpCount = 0,
            Texts = { "\240\159\152\138", "\240\159\152\132", "\240\159\165\176" }
        }
    },
    Scared = {
        RollWeight = 5,
        _id = v1.Scared,
        Movement = {
            WalkSpeedMin = 20,
            WalkSpeedMax = 40,
            IdleSecondsMin = 0.8,
            IdleSecondsMax = 4,
            NearOwnerPreference = 0,
            IsolationPreference = 1,
            CurvedWanderChance = 0.03,
            BurstChance = 0,
            FollowOwnerInPen = false,
            AmbientJumpRatePerSecond = 0,
            AmbientSpinJumpChance = 0,
            Retreat = {
                TriggerDistance = 20,
                Chance = 1
            },
            IdleTremble = {
                Amplitude = 0.1,
                CyclesPerSecond = 3
            }
        },
        Greeting = {
            Chance = 0,
            FirstPlacementChance = 0,
            FirstPlacementBubbleChance = 1,
            FirstPlacementNormalChance = 0,
            FirstPlacementNormalJumpCount = 0,
            ReturnOrbitChance = 0,
            ReturnNormalJumpCount = 0,
            RandomOrbitChance = 0,
            RandomOrbitIntervalSeconds = 30,
            DurationSeconds = 0,
            JumpChancePerSecond = 0,
            SpinJumpChance = 0,
            Texts = { "Where is MAMA \240\159\152\176?" }
        },
        Affection = {
            Enabled = false,
            Chance = 0,
            IntervalSeconds = 50,
            DurationSeconds = 0,
            JumpCount = 0,
            Texts = { "\240\159\152\168", "\240\159\152\176" }
        }
    },
    ExtremelyEnergetic = {
        RollWeight = 3.5,
        _id = v1.ExtremelyEnergetic,
        Movement = {
            WalkSpeedMin = 30,
            WalkSpeedMax = 70,
            IdleSecondsMin = 0.05,
            IdleSecondsMax = 0.2,
            NearOwnerPreference = 0.2,
            IsolationPreference = 0,
            CurvedWanderChance = 0.8,
            BurstChance = 0.7,
            FollowOwnerInPen = false,
            AmbientJumpRatePerSecond = 3.5,
            AmbientSpinJumpChance = 0.35
        },
        Greeting = {
            Chance = 1,
            FirstPlacementChance = 1,
            FirstPlacementNormalChance = 0,
            FirstPlacementNormalJumpCount = 5,
            ReturnOrbitChance = 0.75,
            ReturnNormalJumpCount = 5,
            RandomOrbitChance = 0.35,
            RandomOrbitIntervalSeconds = 30,
            DurationSeconds = 6,
            JumpChancePerSecond = 1.8,
            SpinJumpChance = 0.4,
            Texts = { "\240\159\164\169", "\240\159\164\170" }
        },
        Affection = {
            Enabled = true,
            Chance = 0.1,
            IntervalSeconds = 5,
            DurationSeconds = 4.5,
            JumpCount = 7,
            Texts = { "\240\159\164\169", "\240\159\152\134", "\240\159\164\170" }
        }
    },
    UltraLoyal = {
        RollWeight = 2.5,
        _id = v1.UltraLoyal,
        Movement = {
            WalkSpeedMin = 10,
            WalkSpeedMax = 16,
            IdleSecondsMin = 0.1,
            IdleSecondsMax = 0.5,
            NearOwnerPreference = 0.98,
            IsolationPreference = 0,
            CurvedWanderChance = 0.12,
            BurstChance = 0.1,
            FollowOwnerInPen = true,
            AmbientJumpRatePerSecond = 0.35,
            AmbientSpinJumpChance = 0.1
        },
        Greeting = {
            Chance = 1,
            FirstPlacementChance = 1,
            FirstPlacementNormalChance = 0,
            FirstPlacementNormalJumpCount = 4,
            ReturnOrbitChance = 0.9,
            ReturnNormalJumpCount = 3,
            RandomOrbitChance = 0.9,
            RandomOrbitIntervalSeconds = 5,
            DurationSeconds = 6.5,
            JumpChancePerSecond = 0.8,
            SpinJumpChance = 0.1,
            Texts = { "Mama \240\159\164\151", "Mama \240\159\165\176" }
        },
        Affection = {
            Enabled = true,
            Chance = 0.15151515151515152,
            IntervalSeconds = 5,
            DurationSeconds = 5,
            JumpCount = 3,
            Texts = { "\240\159\165\176", "\240\159\164\151" }
        }
    },
    JumpCrazy = {
        RollWeight = 3.5,
        _id = v1.JumpCrazy,
        Movement = {
            WalkSpeedMin = 10,
            WalkSpeedMax = 18,
            IdleSecondsMin = 0.05,
            IdleSecondsMax = 0.3,
            NearOwnerPreference = 0.2,
            IsolationPreference = 0,
            CurvedWanderChance = 0.25,
            BurstChance = 0.1,
            FollowOwnerInPen = false,
            AmbientJumpRatePerSecond = 12,
            AmbientSpinJumpChance = 0.5
        },
        Greeting = {
            Chance = 1,
            FirstPlacementChance = 0,
            FirstPlacementNormalChance = 1,
            FirstPlacementNormalJumpCount = 8,
            ReturnOrbitChance = 0,
            ReturnNormalJumpCount = 7,
            RandomOrbitChance = 0,
            RandomOrbitIntervalSeconds = 30,
            DurationSeconds = 6,
            JumpChancePerSecond = 2,
            SpinJumpChance = 0.5,
            Texts = {
                "\240\159\152\134",
                "\240\159\152\132",
                "\240\159\152\129",
                "\240\159\152\131",
                "\240\159\164\170",
                "\240\159\152\157",
                "\240\159\152\156",
                "\240\159\152\139",
                "\240\159\152\185",
                "\240\159\153\128",
                "\240\159\152\142"
            }
        },
        Affection = {
            Enabled = true,
            Chance = 0.1,
            IntervalSeconds = 5,
            DurationSeconds = 4,
            JumpCount = 8,
            Texts = {
                "\240\159\152\134",
                "\240\159\152\132",
                "\240\159\152\129",
                "\240\159\152\131",
                "\240\159\164\170",
                "\240\159\152\157",
                "\240\159\152\156",
                "\240\159\152\139",
                "\240\159\152\185",
                "\240\159\153\128",
                "\240\159\152\142"
            }
        }
    }
}

local function freezeTable(v4) -- line 469
    if v4 ~= nil and not table.isfrozen(v4) then
        table.freeze(v4)
    end
end

for v5, v6 in v3 do
    local Retreat = v6.Movement.Retreat
    if Retreat ~= nil and not table.isfrozen(Retreat) then
        table.freeze(Retreat)
    end
    local IdleTremble = v6.Movement.IdleTremble
    if IdleTremble ~= nil and not table.isfrozen(IdleTremble) then
        table.freeze(IdleTremble)
    end
    local Movement = v6.Movement
    if Movement ~= nil and not table.isfrozen(Movement) then
        table.freeze(Movement)
    end
    local Texts = v6.Greeting.Texts
    if Texts ~= nil and not table.isfrozen(Texts) then
        table.freeze(Texts)
    end
    local Greeting = v6.Greeting
    if Greeting ~= nil and not table.isfrozen(Greeting) then
        table.freeze(Greeting)
    end
    local Texts_2 = v6.Affection.Texts
    if Texts_2 ~= nil and not table.isfrozen(Texts_2) then
        table.freeze(Texts_2)
    end
    local Affection = v6.Affection
    if Affection ~= nil and not table.isfrozen(Affection) then
        table.freeze(Affection)
    end
    if v6 ~= nil and not table.isfrozen(v6) then
        table.freeze(v6)
    end
end

if v3 ~= nil and not table.isfrozen(v3) then
    table.freeze(v3)
end
local v7 = {}
local v8 = {
    Personality = v1.Lazy,
    Weight = v3[v1.Lazy].RollWeight
}
local v9 = {
    Personality = v1.Loyal,
    Weight = v3[v1.Loyal].RollWeight
}
local v10 = {
    Personality = v1.Energetic,
    Weight = v3[v1.Energetic].RollWeight
}
local v11 = {
    Personality = v1.InvertedModel,
    Weight = v3[v1.InvertedModel].RollWeight
}
local v12 = {
    Personality = v1.Shy,
    Weight = v3[v1.Shy].RollWeight
}
local v13 = {
    Personality = v1.Scared,
    Weight = v3[v1.Scared].RollWeight
}
local v14 = {
    Personality = v1.ExtremelyEnergetic,
    Weight = v3[v1.ExtremelyEnergetic].RollWeight
}
local v15 = {
    Personality = v1.UltraLoyal,
    Weight = v3[v1.UltraLoyal].RollWeight
}
local v16 = {
    Personality = v1.JumpCrazy,
    Weight = v3[v1.JumpCrazy].RollWeight
}

v7[1] = {
    Personality = v1.Normal,
    Weight = v3[v1.Normal].RollWeight
}
v7[2] = v8
v7[3] = v9
v7[4] = v10
v7[5] = v11
v7[6] = v12
v7[7] = v13
v7[8] = v14
v7[9] = v15
v7[10] = v16

local v17 = table.freeze(v7)
local v18 = {}
local v19 = {
    v1.Lazy,
    v3[v1.Lazy].RollWeight
}
local v20 = {
    v1.Loyal,
    v3[v1.Loyal].RollWeight
}
local v21 = {
    v1.Energetic,
    v3[v1.Energetic].RollWeight
}
local v22 = {
    v1.InvertedModel,
    v3[v1.InvertedModel].RollWeight
}
local v23 = {
    v1.Shy,
    v3[v1.Shy].RollWeight
}
local v24 = {
    v1.Scared,
    v3[v1.Scared].RollWeight
}
local v25 = {
    v1.ExtremelyEnergetic,
    v3[v1.ExtremelyEnergetic].RollWeight
}
local v26 = {
    v1.UltraLoyal,
    v3[v1.UltraLoyal].RollWeight
}
local v27 = {
    v1.JumpCrazy,
    v3[v1.JumpCrazy].RollWeight
}

v18[1] = {
    v1.Normal,
    v3[v1.Normal].RollWeight
}
v18[2] = v19
v18[3] = v20
v18[4] = v21
v18[5] = v22
v18[6] = v23
v18[7] = v24
v18[8] = v25
v18[9] = v26
v18[10] = v27

local v28 = table.freeze(v18)
for v29, v30 in v17 do
    if v30 ~= nil and not table.isfrozen(v30) then
        table.freeze(v30)
    end
end
for v31, v32 in v28 do
    if v32 ~= nil and not table.isfrozen(v32) then
        table.freeze(v32)
    end
end
local v33 = {
    Personalities = v1,
    Configs = v3,
    RollTable = v17
}

function v33.IsPersonality(v34) -- line 575 | captures: v3
    if typeof(v34) == "string" then
        return v3[v34] ~= nil
    end
    return false
end

function v33.GetConfig(v35) -- line 579 | captures: v1, v3
    return v3[v35] or v3[v1.Normal]
end

function v33.Roll(v36) -- line 587 | captures: PickWeightedWith, v28, v33
    local v37 = PickWeightedWith(v36, v28)
    local v38
    if typeof(v37) == "string" then
        v38 = v33.IsPersonality(v37)
    else
        v38 = false
    end
    assert(v38, "Asset personality roll failed")
    return v37
end

function v33.CreateNewItemData(v39) -- line 593 | captures: v33
    local v40 = table.clone(v39)
    v40.Mutations = table.clone(v39.Mutations)
    if not v33.IsPersonality(v40.Personality) then
        v40.Personality = v33.Roll()
    end
    v40.HasBeenFirstPlaced = false
    return v40
end

local function ResetFirstPlacementForTransfer(v41) -- line 602
    local v42 = table.clone(v41)
    v42.Mutations = table.clone(v41.Mutations)
    v42.HasBeenFirstPlaced = false
    return v42
end

v33.ResetFirstPlacementForTransfer = ResetFirstPlacementForTransfer
return table.freeze(v33)
