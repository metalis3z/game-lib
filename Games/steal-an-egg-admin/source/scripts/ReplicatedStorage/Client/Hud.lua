-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local v1 = {
    Game = "GameHUD",
    Treadmill = "TradmilHud"
}
local v2 = {
    EggsButton = { "RightButtons", "EggsButton" },
    IndexButton = { "LeftControls", "IndexBTN" },
    IndexNotificationBadge = { "LeftControls", "IndexBTN", "NotificationBadge" },
    Money = { "BottomLeft", "Money" },
    MoneyIcon = { "BottomLeft", "Money", "Icon" },
    MoneyValue = { "BottomLeft", "Money", "Value" },
    NightTimer = { "BottomRight", "NightTimer" },
    NightTimerIcon = { "BottomRight", "NightTimer", "ImageLabel" },
    NightTimerValue = { "BottomRight", "NightTimer", "Value" },
    PetsButton = { "RightButtons", "PetsButton" },
    ShopButton = { "LeftControls", "ShopBTN" },
    SlowToggle = { "LeftControls", "Slowmode" },
    SlowToggleHitbox = { "LeftControls", "Slowmode", "Hitbox" },
    SlowToggleKnob = { "LeftControls", "Slowmode", "Btn" },
    SlowToggleLabel = { "LeftControls", "Slowmode", "txt" },
    Speed = { "BottomLeft", "Speed" },
    SpeedMultiButton = { "LeftControls", "SpeedMulti" },
    SpeedMultiShine = { "LeftControls", "SpeedMulti", "Glow" },
    SpeedShopButton = { "BottomLeft", "Speed", "ShopBTN" },
    SpeedValue = { "BottomLeft", "Speed", "Value" },
    FriendBoost = { "BottomLeft", "FriendBoost" }
}

v2.TemporarySpeedBoost = { "BottomLeft", "TemporarySpeedBoost" }

local v3 = GUI.HUD()

v3.ResetOnSpawn = false

local v4 = {}
local v5 = {}
local v6 = {}
local v7

function v7(v8, v9, v10) -- line 40 | captures: v7
    local v11 = v9[v10]
    if v11 == nil then
        return v8
    end
    for v12, v13 in v8:GetChildren() do
        if v13.Name == v11 then
            local v14 = v7(v13, v9, v10 + 1)
            if v14 ~= nil then
                return v14
            end
        end
    end
    return nil
end

local function variantFrame(v15) -- line 56 | captures: v1, v3, v4
    local v16 = v4[v15]
    if v16 then
        return v16
    end
    local v17 = v1[v15]
    local v18 = v17 ~= nil
    local v19 = ("no HUD variant named %*"):format(v15)
    assert(v18, v19)
    local v20 = v3:FindFirstChild(v17)
    local v21
    if v20 == nil then
        v21 = false
    else
        v21 = v20:IsA("Frame")
    end
    local v22 = ("HUD.%* must be a Frame"):format(v17)
    assert(v21, v22)
    v4[v15] = v20
    return v20
end

local function chainFor(v23) -- line 70 | captures: v2
    local v24 = v2[v23]
    local v25 = v24 ~= nil
    local v26 = ("no HUD role is registered under %*"):format(v23)
    assert(v25, v26)
    return v24
end

function v6.Screen() -- line 76 | captures: v3
    return v3
end

function v6.Frame(v27) -- line 79 | captures: v1, v3, v4
    local v28 = v27 or "Game"
    local v29 = v4[v28]
    if v29 then
        return v29
    end
    local v30 = v1[v28]
    local v31 = v30 ~= nil
    local v32 = ("no HUD variant named %*"):format(v28)
    assert(v31, v32)
    local v33 = v3:FindFirstChild(v30)
    local v34
    if v33 == nil then
        v34 = false
    else
        v34 = v33:IsA("Frame")
    end
    local v35 = ("HUD.%* must be a Frame"):format(v30)
    assert(v34, v35)
    v4[v28] = v33
    return v33
end

function v6.Find(v36, v37) -- line 94 | captures: v7, v1, v2, v3, v4, v5
    local v38 = v37 or "Game"
    local v39 = v5[v38]
    if v39 == nil then
        v39 = {}
        v5[v38] = v39
    end
    if v39[v36] == nil then
        local v40 = v4[v38]
        if not v40 then
            local v41 = v1[v38]
            local v42 = v41 ~= nil
            local v43 = ("no HUD variant named %*"):format(v38)
            assert(v42, v43)
            v40 = v3:FindFirstChild(v41)
            local v44
            if v40 == nil then
                v44 = false
            else
                v44 = v40:IsA("Frame")
            end
            local v45 = ("HUD.%* must be a Frame"):format(v41)
            assert(v44, v45)
            v4[v38] = v40
        end
        local v46 = v2[v36]
        local v47 = v46 ~= nil
        local v48 = ("no HUD role is registered under %*"):format(v36)
        assert(v47, v48)
        v39[v36] = v7(v40, v46, 1)
    end
    return v39[v36]
end

function v6.Get(v49, v50) -- line 123 | captures: v1, v2, v6
    local v51 = v6.Find(v49, v50)
    local v52 = v51 ~= nil
    local v53 = v2[v49]
    local v54 = v53 ~= nil
    local v55 = ("no HUD role is registered under %*"):format(v49)
    assert(v54, v55)
    local v56 = ("HUD.%*.%* is missing"):format(v1[v50 or "Game"], (table.concat(v53, ".")))
    assert(v52, v56)
    return v51
end

function v6.Every(v57) -- line 133 | captures: v1, v6
    local v58 = {}
    for v59 in v1 do
        local v60 = v6.Find(v57, v59)
        if v60 ~= nil then
            table.insert(v58, v60)
        end
    end
    return v58
end

function v6.SetTreadmillActive(v61) -- line 147 | captures: v1, v3, v4
    local Game = v4.Game
    if not Game then
        local Game_2 = v1.Game
        local v62 = Game_2 ~= nil
        assert(v62, "no HUD variant named Game")
        Game = v3:FindFirstChild(Game_2)
        local v63
        if Game == nil then
            v63 = false
        else
            v63 = Game:IsA("Frame")
        end
        local v64 = ("HUD.%* must be a Frame"):format(Game_2)
        assert(v63, v64)
        v4.Game = Game
    end
    Game.Visible = not v61
    local Treadmill = v4.Treadmill
    if not Treadmill then
        local Treadmill_2 = v1.Treadmill
        local v65 = Treadmill_2 ~= nil
        assert(v65, "no HUD variant named Treadmill")
        Treadmill = v3:FindFirstChild(Treadmill_2)
        local v66
        if Treadmill == nil then
            v66 = false
        else
            v66 = Treadmill:IsA("Frame")
        end
        local v67 = ("HUD.%* must be a Frame"):format(Treadmill_2)
        assert(v66, v67)
        v4.Treadmill = Treadmill
    end
    Treadmill.Visible = v61
end

return table.freeze(v6)
