-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0:WaitForChild("Math Utility"));
local l_ParseAbbreviatedNumber_0 = v1.ParseAbbreviatedNumber;
local v3 = {
    DominionStride = {
        Id = "DominionStride", 
        DisplayName = "Dominion Stride", 
        IsDefault = false, 
        Order = 1, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("25M"), 
            ProductId = nil
        },
        Animation = {
            Id = "rbxassetid://83309727741718", 
            Speed = 1, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 0.75
        }
    }, 
    Kingsthrone = {
        Id = "Kingsthrone", 
        DisplayName = "Kings Throne", 
        IsDefault = false, 
        Order = 2, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("1T"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://110818049706673", 
            Speed = 1, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 0.75
        }
    }, 
    CelestialReach = {
        Id = "CelestialReach", 
        DisplayName = "Celestial Reach", 
        IsDefault = false, 
        Order = 3, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("15Qi"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://96696907200684", 
            Speed = 1, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 0.95
        }
    }, 
    Psychosis = {
        Id = "Psychosis", 
        DisplayName = "Psychosis", 
        IsDefault = false, 
        Order = 4, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("24.5Sp"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://108491068650256", 
            Speed = 1, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 1.5
        }
    }, 
    VanguardPulse = {
        Id = "VanguardPulse", 
        DisplayName = "Vanguard Pulse", 
        IsDefault = false, 
        Order = 5, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("100No"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://95960857152920", 
            Speed = 0.5, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 1.5
        }
    }, 
    IronGate = {
        Id = "IronGate", 
        DisplayName = "Iron Gate", 
        IsDefault = false, 
        Order = 6, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("45Dc"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://126996735382543", 
            Speed = 0.5, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 1.5
        }
    }, 
    TheSingularity = {
        Id = "TheSingularity", 
        DisplayName = "The Singularity", 
        IsDefault = false, 
        Order = 7, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("75DDc"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://102334914254770", 
            Speed = 0.5, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 2.5
        }
    }, 
    PhaseShift = {
        Id = "PhaseShift", 
        DisplayName = "Phase Shift", 
        IsDefault = false, 
        Order = 8, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("5qDc"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://120266177284794", 
            Speed = 0.9, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 3.75
        }
    }, 
    EternalBliss = {
        Id = "EternalBliss", 
        DisplayName = "Eternal Bliss", 
        IsDefault = false, 
        Order = 9, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("18QDc"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://85303925349640", 
            Speed = 0.9, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 5
        }
    }, 
    GrandStature = {
        Id = "GrandStature", 
        DisplayName = "Grand Stature", 
        IsDefault = false, 
        Order = 10, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("33SDc"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://87012511888836", 
            Speed = 1, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 6
        }
    }, 
    SereneDefiance = {
        Id = "SereneDefiance", 
        DisplayName = "Serene Defiance", 
        IsDefault = false, 
        Order = 11, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("8NDc"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://87553000911673", 
            Speed = 1, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 6
        }
    }, 
    StasisPulse = {
        Id = "StasisPulse", 
        DisplayName = "Stasis Pulse", 
        IsDefault = false, 
        Order = 12, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("1UVg"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://134893979437333", 
            Speed = 1, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 6
        }
    }, 
    Legend = {
        Id = "Legend", 
        DisplayName = "Legend", 
        IsDefault = false, 
        Order = 13, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("5DVg"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://74488208348553", 
            Speed = 1, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 6
        }
    }, 
    SixSeven = {
        Id = "SixSeven", 
        DisplayName = "67", 
        IsDefault = false, 
        Order = 14, 
        Costs = {
            Rebirths = l_ParseAbbreviatedNumber_0("18TVg"), 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://135429262536527", 
            Speed = 1, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 9
        }
    }, 
    HonouredOne = {
        Id = "HonouredOne", 
        DisplayName = "The Honoured One", 
        IsDefault = false, 
        Order = 1001, 
        Unlock = {
            Type = "Pack", 
            PackId = "GOJOPack"
        }, 
        Costs = {
            Rebirths = nil, 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://95269389999464", 
            Speed = 1, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 4.5
        }
    }, 
    SilverSurfer = {
        Id = "SilverSurfer", 
        DisplayName = "Silver Surfer", 
        IsDefault = false, 
        Order = 1002, 
        Unlock = {
            Type = "Pack", 
            PackId = "SilverSurferPack"
        }, 
        Costs = {
            Rebirths = nil, 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://134210068565383", 
            Speed = 1, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 3.5
        }, 
        Prop = {
            Type = "StoredProp", 
            PropId = "SilverSurfer"
        }
    }, 
    BoxingChamp = {
        Id = "BoxingChamp", 
        DisplayName = "Boxing Bounce", 
        IsDefault = false, 
        Order = 1003, 
        Unlock = {
            Type = "Pack", 
            PackId = "BoxingChamp"
        }, 
        Costs = {
            Rebirths = nil, 
            ProductId = nil
        }, 
        Animation = {
            Id = "rbxassetid://122028720182307", 
            Speed = 1, 
            Priority = Enum.AnimationPriority.Action3, 
            HipHeight = 1.5
        }
    }
};
v3.GetPose = function(v4) --[[ Line: 352 ]] --[[ Name: GetPose ]]
    -- upvalues: v3 (copy)
    return v3[v4];
end;
v3.GetAllPoses = function() --[[ Line: 356 ]] --[[ Name: GetAllPoses ]]
    -- upvalues: v3 (copy)
    local v5 = {};
    for _, v7 in pairs(v3) do
        if type(v7) == "table" and v7.Id then
            table.insert(v5, v7);
        end;
    end;
    table.sort(v5, function(v8, v9) --[[ Line: 365 ]]
        return (v8.Order or 0) < (v9.Order or 0);
    end);
    return v5;
end;
v3.GetProductIdToPoseMap = function() --[[ Line: 372 ]] --[[ Name: GetProductIdToPoseMap ]]
    -- upvalues: v3 (copy)
    local v10 = {};
    for _, v12 in pairs(v3) do
        if type(v12) == "table" and v12.Id then
            local l_Costs_0 = v12.Costs;
            local v14 = l_Costs_0 and l_Costs_0.ProductId;
            if typeof(v14) == "number" and v14 > 0 then
                v10[v14] = v12.Id;
            end;
        end;
    end;
    return v10;
end;
v3.GetRebirthPrice = function(v15) --[[ Line: 389 ]] --[[ Name: GetRebirthPrice ]]
    -- upvalues: v3 (copy), v1 (copy)
    local v16 = v3.GetPose(v15);
    if not v16 or not v16.Costs then
        return nil;
    else
        local l_Rebirths_0 = v16.Costs.Rebirths;
        if v1.IsBigNum(l_Rebirths_0) then
            return v1.Clone(l_Rebirths_0);
        else
            return nil;
        end;
    end;
end;
v3.GetRebirthPriceDisplay = function(v18) --[[ Line: 403 ]] --[[ Name: GetRebirthPriceDisplay ]]
    -- upvalues: v3 (copy), v1 (copy)
    local v19 = v3.GetRebirthPrice(v18);
    if not v19 then
        return nil;
    else
        return v1.FormatNumber(v19);
    end;
end;
v3.GetProductId = function(v20) --[[ Line: 412 ]] --[[ Name: GetProductId ]]
    -- upvalues: v3 (copy)
    local v21 = v3.GetPose(v20);
    if not v21 or not v21.Costs then
        return nil;
    else
        local l_ProductId_0 = v21.Costs.ProductId;
        if typeof(l_ProductId_0) == "number" and l_ProductId_0 > 0 then
            return l_ProductId_0;
        else
            return nil;
        end;
    end;
end;
v3.CanAffordWithRebirths = function(v23, v24) --[[ Line: 426 ]] --[[ Name: CanAffordWithRebirths ]]
    -- upvalues: v3 (copy), v1 (copy)
    local v25 = v3.GetRebirthPrice(v24);
    if not v25 then
        return false;
    else
        return (v1.Compare(v23, v25) or -1) >= 0;
    end;
end;
return v3;