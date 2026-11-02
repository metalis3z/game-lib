-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Hud = require(ReplicatedStorage.Client.Hud)
local OverlayRoot = require(script.Parent.OverlayRoot)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local Types = require(script.Types)
local v1 = {}

function v1.Resolve() -- line 19 | captures: Hud
    local Money = Hud.Get("Money")
    local GuiObject = Money:IsA("GuiObject")
    assert(GuiObject, "HUD Money role must resolve to a GuiObject")
    return Money, Money
end

local v2 = { SoundId = "rbxassetid://99504764768647" }

v2.Data = { Volume = 1.2 }
v1.SpawnSound = v2

local v3 = { Money = v1 }

if Constants.IS_STUDIO then
    for v4 in v3 do
        local v5 = Types.AvailableCurrencyWidgetsTypes(v4)
        local v6 = ("Unregistered currency widget type: %*"):format(v4)
        assert(v5, v6)
    end
end
local v7 = Random.new()
local v8 = {}
local v9 = {}
local v10 = 0
local v11 = false
local v12 = { "rbxassetid://130670569123609", "rbxassetid://94335578821857" }
local v13 = {}

local function resolveAmountTemplate() -- line 47 | captures: v11, ReplicatedStorage
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v14
    if Assets == nil then
    else
        v14 = Assets:FindFirstChild("UI")
    end
    local v15
    if v14 == nil then
    else
        v15 = v14:FindFirstChild("AddCurrencyScreen")
    end
    local v16
    if v15 == nil then
    else
        v16 = v15:FindFirstChild("Amount")
    end
    if v16 ~= nil and v16:IsA("Frame") then
        return v16
    end
    if not v11 then
        v11 = true
        warn("[AddCurrencyScreen] ReplicatedStorage.Assets.UI.AddCurrencyScreen.Amount is missing")
    end
    return nil
end

local function resolveWidget(v17) -- line 81 | captures: v3
    local v18 = v3[v17]
    local v19 = ("Currency widget not found for type: %*"):format(v17)
    local v20 = assert(v18, v19)
    local v21, v23 = v20.Resolve()
    return v20, v21, v23 or v21
end

local function getTextKey(v24, v25) -- line 87
    if v25 and v25.MergeKey then
        return v25.MergeKey
    end
    return v24
end

local function formatAdditiveText(v26, v27) -- line 96 | captures: Simple
    if v27 and v27.TextOverride then
        return v27.TextOverride
    end
    return "$" .. Simple.FormatCompact(v26, ".")
end

local function quadBezier(v28, v29, v30, v31) -- line 105
    local v32 = 1 - v31
    return v28 * (v32 * v32) + v29 * (v32 * 2 * v31) + v30 * (v31 * v31)
end

local function addCurrencyText(v33, v34, v35, v36, v37) -- line 109 | captures: v10, ContentProvider, RunService, Workspace, Audio, Simple, OverlayRoot, Tween, v3, v7, v8, v9, v12, v13, resolveAmountTemplate
    local v38 = resolveAmountTemplate()
    if v38 == nil then
        return
    end
    v10 += 1
    local v39 = v3[v33]
    local v40 = ("Currency widget not found for type: %*"):format(v33)
    local v41 = assert(v39, v40)
    local v42 = v41.Resolve()
    local v43
    if v37 then
        if v37.MergeKey then
            v43 = v37.MergeKey
        end
    else
        v43 = v33
    end
    local v44 = v8[v43]
    local v45
    if v44 then
        v44:Destroy()
        v8[v43] = nil
        if v37 then
            if v37.TextOverride then
                v45 = v34
            end
        else
            v45 = v34 + (v9[v43] or 0)
        end
    else
        v45 = v34
    end
    local v46 = v38:Clone()
    v8[v43] = v46
    v9[v43] = v45
    v46.AnchorPoint = Vector2.new(0.5, 0.5)
    local Label = v46.Label
    local UIScale = v46:FindFirstChild("UIScale")
    local UIStroke = Label:FindFirstChild("UIStroke")
    UIScale.Scale = 0.9
    local SpawnSound = v41.SpawnSound
    if SpawnSound then
        Audio.PlayFile(SpawnSound, script)
    end
    v46.Parent = OverlayRoot()
    if v37 then
        if v37.TextOverride then
            Label.Text = v37.TextOverride
        else
            Label.Text = nil
        end
    else
        Label.Text = "$" .. Simple.FormatCompact(v45, ".")
    end
    Label.TextTransparency = 0
    if UIStroke then
        UIStroke.Transparency = 0
    end
    Label.Visible = true
    local v47 = v42.AbsoluteSize.X * 1.35
    local v48 = math.round(v47)
    local v49 = math.max(v48, 180)
    local v50 = v42.AbsoluteSize.Y * 0.95
    local v51 = math.round(v50)
    v46.Size = UDim2.fromOffset(v49, (math.max(v51, 40)))
    pcall(ContentProvider.PreloadAsync, ContentProvider, v12)
    local CurrentCamera = Workspace.CurrentCamera
    local v52
    if CurrentCamera then
        v52 = CurrentCamera.ViewportSize
    else
        v52 = Vector2.new(1920, 1080)
    end
    local v53
    if v36 then
        v53 = v36
    else
        local v54 = v52.X * 0.5 + v7:NextNumber(-260, 260)
        v53 = Vector2.new(v54, v52.Y * 0.62 + v7:NextNumber(-140, 140))
    end
    local v55 = v13.GetWidgetIconCenter(v33)
    local v56 = v55 - v53
    local v57 = if v56.X < 0 then 1 else -1
    local X = v56.X
    local v58 = math.abs(X) * 0.35
    local v59 = v57 * math.max(160, v58)
    local v60 = (v53 + v55) / 2
    local new = Vector2.new
    local Y = v56.Y
    local v61 = math.abs(Y) * 0.35
    local v62 = v60 + new(v59, -math.max(140, v61))
    local v63 = os.clock()
    local v64 = 0
    while true do
        local v65
        if v64 < 1 and v46.Parent then
            local v66 = (os.clock() - v63) / 1.9
            v65 = math.min(v66, 1)
            local v67 = 1 - v65
            local v68 = v53 * (v67 * v67) + v62 * (v67 * 2 * v65) + v55 * (v65 * v65)
            local v69 = (v65 - 0.8) / 0.2
            local v70 = math.clamp(v69, 0, 1)
            v46.Position = UDim2.fromOffset(v68.X, v68.Y)
            local v71 = v65 * 3.141592653589793
            UIScale.Scale = math.sin(v71) * 0.18 + 0.9
            Label.TextTransparency = v70
            if UIStroke then
                UIStroke.Transparency = v70
            end
        else
            break
        end
        RunService.RenderStepped:Wait()
        v64 = v65
    end
    if v8[v43] == v46 then
        v8[v43] = nil
        v9[v43] = 0
    end
    if v46.Parent then
        v46:Destroy()
    end
    local v72 = v3[v22]
    local v73 = ("Currency widget not found for type: %*"):format(v22)
    local v74, v75 = assert(v72, v73).Resolve()
    local v76 = v75 or v74
    local UIScale_2 = v76:FindFirstChildOfClass("UIScale")
    if not UIScale_2 then
        UIScale_2 = Instance.new("UIScale")
        UIScale_2.Parent = v76
    end
    local v77 = UIScale_2 ~= nil
    assert(v77, "the widget UIScale fell through its own default")
    UIScale_2.Scale = 1.5
    Tween(UIScale_2, { Scale = 1 }, { 0.05, "Sine", "Out" })
    v10 -= 1
end

function v13.GetWidgetIconCenter(v78) -- line 228 | captures: v3
    local v79 = v3[v78]
    local v80 = ("Currency widget not found for type: %*"):format(v78)
    local v81, v82 = assert(v79, v80).Resolve()
    local v83 = v82 or v81
    return v83.AbsolutePosition + v83.AbsoluteSize / 2
end

local function GetOrbAnimationTime() -- line 235
    return 1.9
end

v13.GetOrbAnimationTime = GetOrbAnimationTime

function v13.IsAnimating() -- line 238 | captures: v10
    return v10 > 0
end

function v13.Create(v84, v85, v86, v87, v88) -- line 242 | captures: addCurrencyText
    if v85 <= 0 then
        return
    end
    local v89
    local v90 = v87
    local v91 = v88
    local NumOrbs
    if typeof(v86) == "table" then
        v89 = v86
        NumOrbs = v86.NumOrbs
        if v86.LowVolumeSound ~= nil then
            v90 = v86.LowVolumeSound
        end
        if v86.OverrideStarPosition ~= nil then
            v91 = v86.OverrideStarPosition
        end
    else
        NumOrbs = v86
    end
    local v92 = NumOrbs or 5
    local v93 = math.min(v92, v85)
    local v94
    if v85 >= 70 then
        v94 = 0.025
    elseif v85 >= 40 then
        v94 = 0.035
    elseif v85 < 20 then
        v94 = 0.1
    else
        v94 = 0.055
    end
    local v95 = v85 / v93
    local v96 = if v93 < 10 then 1 else 3
    task.spawn(function() -- line 278 | captures: v94, v96, v89, v90, v91, v84, v93, v95, addCurrencyText
        local v97 = v93 - v96
        local v98 = math.max(1, v97)
        for v99 = 1, v98 do
            local v100 = if v99 == 1 then v89 else nil
            task.spawn(addCurrencyText, v84, v95, v90, v91, v100)
            task.wait(v94)
        end
    end)
end

return v13
