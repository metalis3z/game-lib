--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  Includes: Script & GUI
  Discord: discord.gg/nDWm6PkFrT
--]]

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Synchronizer)
local v3 = table.freeze
local v4 = {}
local v5 = {
    ["discountedProductId"] = 3536490026,
    ["isLuckyBlock"] = true
}
local v_u_6 = 1
function v5.canGive(p7)
    -- upvalues: (copy) v_u_2, (copy) v_u_6
    if v_u_2:Get(p7) then
        local v8 = game:GetService("ServerScriptService")
        local v9 = require(v8.Services.PlotService)
        local v10 = require(v8.Services.GameService)
        if v9:GetEmptyAnimalsPodiumAmount(p7) - v10:GetTargetAtPlayerAmount(p7) < v_u_6 then
            return false, "Your base is full"
        else
            return true
        end
    else
        return false
    end
end
local v_u_11 = {
    ["Index"] = "Premium Heart Lucky Block",
    ["Timer"] = 0
}
local v_u_12 = 1
function v5.give(p13, p14)
    -- upvalues: (copy) v_u_11, (copy) v_u_12
    local v15 = game:GetService("ServerScriptService")
    local v16 = require(v15.Services.PlotService)
    local v17 = v_u_11
    if p14 then
        v17 = table.clone(v_u_11)
        v17.Mutation = p14
    end
    if v_u_12 == 1 then
        return v16:AddAnimalOnPlotOrQueue(p13, table.clone(v17))
    end
    for _ = 1, v_u_12 do
        v16:AddAnimalOnPlotOrQueue(p13, table.clone(v17))
    end
    return true
end
v4[3531057541] = v5
local v18 = {
    ["discountedProductId"] = 3536490030,
    ["isLuckyBlock"] = true
}
local v_u_19 = 3
function v18.canGive(p20)
    -- upvalues: (copy) v_u_2, (copy) v_u_19
    if v_u_2:Get(p20) then
        local v21 = game:GetService("ServerScriptService")
        local v22 = require(v21.Services.PlotService)
        local v23 = require(v21.Services.GameService)
        if v22:GetEmptyAnimalsPodiumAmount(p20) - v23:GetTargetAtPlayerAmount(p20) < v_u_19 then
            return false, "Your base is full"
        else
            return true
        end
    else
        return false
    end
end
local v_u_24 = {
    ["Index"] = "Premium Heart Lucky Block",
    ["Timer"] = 0
}
local v_u_25 = 3
function v18.give(p26, p27)
    -- upvalues: (copy) v_u_24, (copy) v_u_25
    local v28 = game:GetService("ServerScriptService")
    local v29 = require(v28.Services.PlotService)
    local v30 = v_u_24
    if p27 then
        v30 = table.clone(v_u_24)
        v30.Mutation = p27
    end
    if v_u_25 == 1 then
        return v29:AddAnimalOnPlotOrQueue(p26, table.clone(v30))
    end
    for _ = 1, v_u_25 do
        v29:AddAnimalOnPlotOrQueue(p26, table.clone(v30))
    end
    return true
end
v4[3531057803] = v18
local v31 = {
    ["discountedProductId"] = 3536490034,
    ["isLuckyBlock"] = true
}
local v_u_32 = 10
function v31.canGive(p33)
    -- upvalues: (copy) v_u_2, (copy) v_u_32
    if v_u_2:Get(p33) then
        local v34 = game:GetService("ServerScriptService")
        local v35 = require(v34.Services.PlotService)
        local v36 = require(v34.Services.GameService)
        if v35:GetEmptyAnimalsPodiumAmount(p33) - v36:GetTargetAtPlayerAmount(p33) < v_u_32 then
            return false, "Your base is full"
        else
            return true
        end
    else
        return false
    end
end
local v_u_37 = {
    ["Index"] = "Premium Heart Lucky Block",
    ["Timer"] = 0
}
local v_u_38 = 10
function v31.give(p39, p40)
    -- upvalues: (copy) v_u_37, (copy) v_u_38
    local v41 = game:GetService("ServerScriptService")
    local v42 = require(v41.Services.PlotService)
    local v43 = v_u_37
    if p40 then
        v43 = table.clone(v_u_37)
        v43.Mutation = p40
    end
    if v_u_38 == 1 then
        return v42:AddAnimalOnPlotOrQueue(p39, table.clone(v43))
    end
    for _ = 1, v_u_38 do
        v42:AddAnimalOnPlotOrQueue(p39, table.clone(v43))
    end
    return true
end
v4[3531057804] = v31
local v44 = {
    ["discountedProductId"] = 3536490033,
    ["isLuckyBlock"] = true
}
local v_u_45 = 1
function v44.canGive(p46)
    -- upvalues: (copy) v_u_2, (copy) v_u_45
    if v_u_2:Get(p46) then
        local v47 = game:GetService("ServerScriptService")
        local v48 = require(v47.Services.PlotService)
        local v49 = require(v47.Services.GameService)
        if v48:GetEmptyAnimalsPodiumAmount(p46) - v49:GetTargetAtPlayerAmount(p46) < v_u_45 then
            return false, "Your base is full"
        else
            return true
        end
    else
        return false
    end
end
local v_u_50 = {
    ["Index"] = "Secret Lucky Block",
    ["Timer"] = 0
}
local v_u_51 = 1
function v44.give(p52, p53)
    -- upvalues: (copy) v_u_50, (copy) v_u_51
    local v54 = game:GetService("ServerScriptService")
    local v55 = require(v54.Services.PlotService)
    local v56 = v_u_50
    if p53 then
        v56 = table.clone(v_u_50)
        v56.Mutation = p53
    end
    if v_u_51 == 1 then
        return v55:AddAnimalOnPlotOrQueue(p52, table.clone(v56))
    end
    for _ = 1, v_u_51 do
        v55:AddAnimalOnPlotOrQueue(p52, table.clone(v56))
    end
    return true
end
v4[3609989221] = v44
local v57 = {
    ["discountedProductId"] = 3536490051,
    ["item"] = "Rose Base",
    ["failedGiftKey"] = "RoseBase"
}
local v_u_58 = "Rose"
function v57.give(p59)
    -- upvalues: (copy) v_u_2, (copy) v_u_58
    local v60 = v_u_2:Get(p59)
    if not v60 then
        return false
    end
    if v60:Get({ "UnlockedBaseSkins", v_u_58 }) then
        return "___GIVE_BACK"
    end
    v60:InsertOnDictionary("UnlockedBaseSkins", v_u_58, true)
    return true
end
v4[3531055923] = v57
v4[3531055926] = {
    ["discountedProductId"] = 3536490035,
    ["item"] = "Rose Base",
    ["failedGiftKey"] = "RoseBase",
    ["give"] = function(p61)
        -- upvalues: (copy) v_u_2
        local v_u_62 = "Rose"
        (function(p63)
            -- upvalues: (ref) v_u_2, (copy) v_u_62
            local v64 = v_u_2:Get(p63)
            if not v64 then
                return false
            end
            if v64:Get({ "UnlockedBaseSkins", v_u_62 }) then
                return "___GIVE_BACK"
            end
            v64:InsertOnDictionary("UnlockedBaseSkins", v_u_62, true)
            return true
        end)(p61)
        local v_u_65 = {
            ["Index"] = "Premium Heart Lucky Block",
            ["Timer"] = 0
        }
        local v_u_66 = 1
        (function(p67, p68)
            -- upvalues: (copy) v_u_65, (copy) v_u_66
            local v69 = game:GetService("ServerScriptService")
            local v70 = require(v69.Services.PlotService)
            local v71 = v_u_65
            if p68 then
                v71 = table.clone(v_u_65)
                v71.Mutation = p68
            end
            if v_u_66 == 1 then
                return v70:AddAnimalOnPlotOrQueue(p67, table.clone(v71))
            end
            for _ = 1, v_u_66 do
                v70:AddAnimalOnPlotOrQueue(p67, table.clone(v71))
            end
            return true
        end)(p61)
        return true
    end
}
local v72 = {
    ["discountedProductId"] = 3536490029,
    ["item"] = "Cupid\'s Wings",
    ["failedGiftKey"] = "CupidsWings"
}
local v_u_73 = "Cupid\'s Wings"
function v72.give(p74)
    -- upvalues: (copy) v_u_2, (copy) v_u_73
    local v75 = v_u_2:Get(p74)
    if not v75 then
        return false
    end
    if v75:Get({ "Items", v_u_73 }) then
        return "___GIVE_BACK"
    end
    v75:InsertOnDictionary("Items", v_u_73, true)
    return true
end
v4[3536298171] = v72
v4[3536298173] = {
    ["discountedProductId"] = 3536490050,
    ["item"] = "Cupid\'s Wings",
    ["failedGiftKey"] = "CupidsWings",
    ["give"] = function(p76)
        -- upvalues: (copy) v_u_2
        local v_u_77 = "Cupid\'s Wings"
        (function(p78)
            -- upvalues: (ref) v_u_2, (copy) v_u_77
            local v79 = v_u_2:Get(p78)
            if not v79 then
                return false
            end
            if v79:Get({ "Items", v_u_77 }) then
                return "___GIVE_BACK"
            end
            v79:InsertOnDictionary("Items", v_u_77, true)
            return true
        end)(p76)
        local v_u_80 = {
            ["Index"] = "Premium Heart Lucky Block",
            ["Timer"] = 0
        }
        local v_u_81 = 2
        (function(p82, p83)
            -- upvalues: (copy) v_u_80, (copy) v_u_81
            local v84 = game:GetService("ServerScriptService")
            local v85 = require(v84.Services.PlotService)
            local v86 = v_u_80
            if p83 then
                v86 = table.clone(v_u_80)
                v86.Mutation = p83
            end
            if v_u_81 == 1 then
                return v85:AddAnimalOnPlotOrQueue(p82, table.clone(v86))
            end
            for _ = 1, v_u_81 do
                v85:AddAnimalOnPlotOrQueue(p82, table.clone(v86))
            end
            return true
        end)(p76)
        return true
    end
}
local v87 = {
    ["discountedProductId"] = 3610327634,
    ["isLuckyBlock"] = true,
    ["isBrainrot"] = true
}
local v_u_88_meowl = 1
function v87.canGive(p89_cg)
    if v_u_2:Get(p89_cg) then
        local v_cg1 = game:GetService("ServerScriptService")
        local v_cg2 = require(v_cg1.Services.PlotService)
        local v_cg3 = require(v_cg1.Services.GameService)
        if v_cg2:GetEmptyAnimalsPodiumAmount(p89_cg) - v_cg3:GetTargetAtPlayerAmount(p89_cg) < v_u_88_meowl then
            return false, "Your base is full"
        else
            return true
        end
    else
        return false
    end
end
local v_u_88_mut_weights = {
    { name = nil,           weight = 400 },
    { name = "Gold",        weight = 200 },
    { name = "Diamond",     weight = 100 },
    { name = "Rainbow",     weight = 60  },
    { name = "Candy",       weight = 45  },
    { name = "Lava",        weight = 35  },
    { name = "Galaxy",      weight = 25  },
    { name = "YinYang",     weight = 20  },
    { name = "Radioactive", weight = 15  },
    { name = "Bloodrot",    weight = 10  },
    { name = "Cursed",      weight = 6   },
    { name = "Divine",      weight = 2   },
}
local v_u_88_total_weight = 0
for _, e in ipairs(v_u_88_mut_weights) do v_u_88_total_weight += e.weight end
function v87.give(p89)
    local v90_sss = game:GetService("ServerScriptService")
    local v90_rs = game:GetService("ReplicatedStorage")
    local v90_animals = require(v90_rs.Datas.Animals)
    local v90_animalSvc = require(v90_sss.Services.AnimalService)
    local animalData = v90_animals["Meowl"]
    if not animalData then return false end
    local mutParam = nil
    local roll = math.random(1, v_u_88_total_weight)
    local cumul = 0
    for _, e in ipairs(v_u_88_mut_weights) do
        cumul += e.weight
        if roll <= cumul then mutParam = e.name; break end
    end
    local success, err = pcall(function()
        v90_animalSvc.spawnAnimalCustom(
            animalData,
            mutParam,
            {},
            nil,
            { Owner = p89 },
            nil
        )
    end)
    if not success then
        warn("[ValentinesShop] Meowl spawn failed:", err)
    end
    return true
end
v4[3610327634] = v87
local v91 = {
    ["discountedProductId"] = 3536490048,
    ["item"] = "Laser Gun"
}
local v_u_92 = "Laser Gun"
function v91.give(p93)
    -- upvalues: (copy) v_u_2, (copy) v_u_92
    local v94 = v_u_2:Get(p93)
    if not v94 then
        return false
    end
    if v94:Get({ "Items", v_u_92 }) then
        return "___GIVE_BACK"
    end
    v94:InsertOnDictionary("Items", v_u_92, true)
    return true
end
v4[3570837669] = v91
local v95 = {
    ["discountedProductId"] = 3536490052,
    ["item"] = "Ban Hammer"
}
local v_u_96 = "Ban Hammer"
function v95.give(p97)
    -- upvalues: (copy) v_u_2, (copy) v_u_96
    local v98 = v_u_2:Get(p97)
    if not v98 then
        return false
    end
    if v98:Get({ "Items", v_u_96 }) then
        return "___GIVE_BACK"
    end
    v98:InsertOnDictionary("Items", v_u_96, true)
    return true
end
v4[3570837661] = v95
local v99 = {
    ["discountedProductId"] = 3536490032,
    ["item"] = "Blackhole Slap"
}
local v_u_100 = "Blackhole Slap"
function v99.give(p101)
    -- upvalues: (copy) v_u_2, (copy) v_u_100
    local v102 = v_u_2:Get(p101)
    if not v102 then
        return false
    end
    if v102:Get({ "Items", v_u_100 }) then
        return "___GIVE_BACK"
    end
    v102:InsertOnDictionary("Items", v_u_100, true)
    return true
end
v4[3570837666] = v99
local v103 = {
    ["discountedProductId"] = 3536944215,
    ["item"] = "Admin Commands",
    ["failedGiftKey"] = "AdminCommands"
}
local v_u_104 = "Admin Commands"
local v_u_105 = "AdminCommands"
function v103.give(p106)
    -- upvalues: (copy) v_u_2, (copy) v_u_104, (copy) v_u_105
    local v107 = v_u_2:Get(p106)
    if not v107 then
        return false
    end
    if v107:Get({ "Gamepass", v_u_104 }) then
        return "___GIVE_BACK"
    end
    v107:InsertOnDictionary("Gamepass", v_u_104, true)
    p106:SetAttribute(v_u_105 or v_u_104, true)
    return true
end
v4[1800820512] = v103
local v108 = {
    ["discountedProductId"] = 3536944220,
    ["item"] = "2x Money",
    ["failedGiftKey"] = "2xMoney"
}
local v_u_109 = "2x Money"
local v_u_110 = "2xMoney"
function v108.give(p111)
    -- upvalues: (copy) v_u_2, (copy) v_u_109, (copy) v_u_110
    local v112 = v_u_2:Get(p111)
    if not v112 then
        return false
    end
    if v112:Get({ "Gamepass", v_u_109 }) then
        return "___GIVE_BACK"
    end
    v112:InsertOnDictionary("Gamepass", v_u_109, true)
    p111:SetAttribute(v_u_110 or v_u_109, true)
    return true
end
v4[1801015136] = v108
local v113 = {
    ["discountedProductId"] = 3536944219,
    ["item"] = "VIP",
    ["failedGiftKey"] = "VIP"
}
local v_u_114 = "VIP"
local v_u_115 = nil
function v113.give(p116)
    -- upvalues: (copy) v_u_2, (copy) v_u_114, (copy) v_u_115
    local v117 = v_u_2:Get(p116)
    if not v117 then
        return false
    end
    if v117:Get({ "Gamepass", v_u_114 }) then
        return "___GIVE_BACK"
    end
    v117:InsertOnDictionary("Gamepass", v_u_114, true)
    p116:SetAttribute(v_u_115 or v_u_114, true)
    return true
end
v4[1800564757] = v113
local v118 = {
    ["Products"] = v3(v4)
}
return table.freeze(v118)