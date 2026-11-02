-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ConsoleSignals = require(ReplicatedStorage.Client.ConsoleSignals)
require(ReplicatedStorage.Client.Types.GUI)
local v1, v2

if RunService:IsStudio() then
    v1 = 30
    v2 = 30
else
    v1 = 99999999
    v2 = 99999999
end
local v3 = {
    ActivePets = { "ActivePets" },
    AreaGui = { "AreaGui" },
    AssetEggData = { "AssetEggData" },
    AutoSell = { "AutoSell" },
    Backpack = { "BackpackGui" },
    CaptureTheEggUI = { "CaptureTheEggUI" },
    DropHeldEgg = { "DropHeldEgg" },
    Fade = { "Fade" },
    GreatBloomBanner = { "GreatBloomBanner" },
    GroupReward = { "FreeGift" },
    GrowingEggs = { "GrowingEggs" },
    HUD = { "HUD" },
    Index = { "Index" },
    Message = { "Message" },
    MonsterChestRewards = { "MonsterChestRewards" },
    MonsterEventTutorialFrame = { "MonsterEventTutorialFrame" },
    Notifications = { "Notifications" },
    OfflineMoneyInPlot = { "OfflineMoneyInPlot" },
    PetFuse = { "PetFuse" },
    PopupPrompt = { "PopupPrompt" },
    ResetStartTimer = { "ResetStartTimer" },
    RollbackReward = { "RollbackRewardUI" },
    SakuraCrystalCounter = { "SakuraCrystalCounter" },
    SakuraEggCharge = { "SakuraEggCharge" },
    SakuraEventTutorialFrame = { "SakuraEventTutorialFrame" },
    Settings = { "Settings" },
    Shop = { "RobuxShop" },
    SpeedGainAnimation = { "SpeedGainAnimation" },
    StaticTreadmillImageSurfaceGui = { "StaticTreadmillImageSurfaceGui" },
    TopBarStandard = { "TopbarStandard" },
    TrailShop = { "TrailShop" },
    TreadmillScreenButtonShare = { "TreadmillScreenButtonShare" },
    TreadmillScreenButtonSwapLeft = { "TreadmillScreenButtonSwapLeft" },
    TreadmillScreenButtonSwapRight = { "TreadmillScreenButtonSwapRight" },
    TreadmillScreenComments = { "TreadmillScreenComments" },
    TreadmillScreenFriendLikes = { "TreadmillScreenFriendLikes" },
    TreadmillScreenSideButtons = { "TreadmillScreenSideButtons" },
    TreadmillSpeedShop = { "SpeedShop" },
    TreadmillVideoSurfaceGui = { "TreadmillVideoSurfaceGui" },
    TutorialInstructions = { "TutorialInstructions" }
}
local v4 = {
    AssetHoverData = {
        class = "ScreenGui",
        path = { "AssetHoverData" }
    },
    GetMoreSpeedOnHit = {
        class = "ScreenGui",
        path = { "GetMoreSpeedOnHit" }
    }
}

v4.MonsterCharge = {
    class = "ScreenGui",
    path = { "MonsterChargeUI" }
}

local v5 = {}
local v6 = {
    class = "Frame",
    path = { "BottomFrame" }
}

v5[1] = {
    class = "ScreenGui",
    path = {}
}
v5[2] = v6
v5[3] = {
    class = "Frame",
    path = { "BottomFrame", "Holder" }
}
v5[4] = {
    class = "Frame",
    path = { "BottomFrame", "Holder", "List" }
}
v5[5] = {
    class = "Frame",
    path = { "BottomFrame", "Holder", "List", "Luck" }
}
v5[6] = {
    class = "ImageButton",
    path = { "BottomFrame", "Holder", "List", "Luck", "Button" }
}
v5[7] = {
    class = "Frame",
    path = { "BottomFrame", "Holder", "List", "Luck", "Button", "Content" }
}
v5[8] = {
    class = "Frame",
    path = { "BottomFrame", "Holder", "List", "Luck", "Button", "Content", "Value" }
}
v5[9] = {
    class = "TextLabel",
    path = { "BottomFrame", "Holder", "List", "Luck", "Button", "Content", "Value", "TextLabel" }
}
v5[10] = {
    class = "Frame",
    path = { "BottomFrame", "Holder", "List", "x2Luck" }
}
v5[11] = {
    class = "ImageButton",
    path = { "BottomFrame", "Holder", "List", "x2Luck", "Icon" }
}
v5[12] = {
    class = "TextLabel",
    path = { "BottomFrame", "Holder", "List", "x2Luck", "Timer" }
}
v5[13] = {
    class = "Frame",
    path = { "BottomFrame", "Holder", "List", "x2Growth" }
}
v5[14] = {
    class = "ImageButton",
    path = { "BottomFrame", "Holder", "List", "x2Growth", "Icon" }
}
v5[15] = {
    class = "TextLabel",
    path = { "BottomFrame", "Holder", "List", "x2Growth", "Timer" }
}

local v7 = Players.LocalPlayer:WaitForChild("PlayerGui", v2)
local v8 = {}
local v9 = {}
local v10 = {}

local function walkWaiting(v11) -- line 188 | captures: v1, v7
    local v12 = v7
    for v13, v14 in v11 do
        v12 = v12:WaitForChild(v14, v1)
    end
    return v12
end

local function walkIndexing(v15, v16) -- line 198
    local v17 = v15
    for v18, v19 in v16 do
        v17 = v17[v19]
    end
    return v17
end

local function borrowScale(v20) -- line 208
    local UIScale = v20:FindFirstChildOfClass("UIScale")
    if UIScale then
        return UIScale
    end
    local UIScale_2 = Instance.new("UIScale")
    UIScale_2.Scale = 0
    UIScale_2.Parent = v20
    return UIScale_2
end

for v21, v22 in v3 do
    local v23 = v22

    v8[v21] = function() -- line 222 | captures: v1, v7, v23
        local v24 = v7
        for v25, v26 in v23 do
            v24 = v24:WaitForChild(v26, v1)
        end
        return v24
    end
end
for v27, v28 in {
        FadeFrame = {
            base = "Fade",
            chain = { "Fade" }
        },
        ResetStartTimerLabel = {
            base = "ResetStartTimer",
            chain = { "Frame", "TextLabel" }
        }
    } do
    local v29 = v28

    v8[v27] = function() -- line 246 | captures: v8, v29
        local v30 = v8[v29.base]()
        for v31, v32 in v29.chain do
            v30 = v30[v32]
        end
        return v30
    end
end
for v33, v34 in v4 do
    local v35 = v34
    local v36 = v33

    v8[v33] = function() -- line 261 | captures: v1, v7, v35, v36
        local v37 = v7
        for v38, v39 in v35.path do
            v37 = v37:WaitForChild(v39, v1)
        end
        local v40 = v37:IsA(v35.class)
        local v41 = ("%* did not resolve to a %*"):format(v36, v35.class)
        assert(v40, v41)
        return v37
    end
end

function v8.PlayerGui() -- line 275 | captures: v7
    return v7
end

function v8.ResetStartTimerLabelScale() -- line 278 | captures: v8
    local v42 = v8.ResetStartTimerLabel()
    local UIScale = v42:FindFirstChildOfClass("UIScale")
    if UIScale then
        return UIScale
    end
    local UIScale_2 = Instance.new("UIScale")
    UIScale_2.Scale = 0
    UIScale_2.Parent = v42
    return UIScale_2
end

function v8.BottomUI() -- line 289 | captures: v1, v5, v7
    local v43 = v7
    for v44, v45 in { "BottomUI" } do
        v43 = v43:WaitForChild(v45, v1)
    end
    for v46, v47 in v5 do
        local v48 = v43
        for v49, v50 in v47.path do
            v48 = v48[v50]
        end
        local v51 = v48:IsA(v47.class)
        local v52 = ("BottomUI/%* did not resolve to a %*"):format(table.concat(v47.path, "/"), v47.class)
        assert(v51, v52)
    end
    return v43
end

local v53 = table.clone(v8)
local v54 = {
    __index = function(v55, v56) -- __index | line 318
        error("no GUI accessor is registered under " .. tostring(v56))
    end
}
local v57 = setmetatable(v53, v54)
table.freeze(v57)
local v58 = {}

function v58.ButtonActivated(v59, v60) -- line 324 | captures: ConsoleSignals, v10
    local v61 = v10[v59]
    if v61 then
        v61.Signal:Disconnect()
        v61.Default:Disconnect()
    end
    local v62 = { Default = v59.Activated:Connect(v60) }
    v62.Signal = ConsoleSignals.PressedButton:Connect(function(v63) -- line 330 | captures: v59, v60
        if v63 == v59 then
            v60()
        end
    end)
    v10[v59] = v62
    return v62
end

function v58.Get(v64) -- line 339 | captures: v8, v9
    local v65 = v9[v64]
    if v65 then
        return v65
    end
    local v66 = v8[v64]
    local v67
    if v66 then
        v67 = v66()
    end
    if v67 then
        v9[v64] = v67
        return v67
    end
    error("no GUI is reachable under the accessor " .. v64)
end

local v68 = { __index = v57 }
return (setmetatable(v58, v68))
