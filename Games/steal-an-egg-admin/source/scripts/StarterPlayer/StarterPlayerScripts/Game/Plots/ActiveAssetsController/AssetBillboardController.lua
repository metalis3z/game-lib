-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Shared.Types.AssetItem)
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = {}

v1.__index = v1

local function isHiddenByDefault(v2, v3) -- line 14
    local v4 = v2
    while true do
        if v4 == nil then
            return false
        end
        if v4 == v3 then
            return false
        end
        if not v4:IsA("GuiObject") or v4.Visible then
            v4 = v4.Parent
            continue
        end
        break
    end
    return true
end

local function addChannel(v5, v6, v7) -- line 28
    if not (v6 >= 1) then
        local v8 = {
            Original = v6,
            Apply = v7
        }
        table.insert(v5, v8)
    end
end

local function addTextLabelChannels(v9, v10) -- line 34
    local TextTransparency = v10.TextTransparency
    if TextTransparency < 1 then
        local v11 = { Original = TextTransparency }

        function v11.Apply(v12) -- line 39 | captures: v10
            v10.TextTransparency = v12
        end

        table.insert(v9, v11)
    end
    local TextStrokeTransparency = v10.TextStrokeTransparency
    if TextStrokeTransparency >= 1 then
        return
    end
    local v13 = { Original = TextStrokeTransparency }

    function v13.Apply(v14) -- line 50 | captures: v10
        v10.TextStrokeTransparency = v14
    end

    table.insert(v9, v13)
end

local function addTextButtonChannels(v15, v16) -- line 55
    local TextTransparency = v16.TextTransparency
    if TextTransparency < 1 then
        local v17 = { Original = TextTransparency }

        function v17.Apply(v18) -- line 60 | captures: v16
            v16.TextTransparency = v18
        end

        table.insert(v15, v17)
    end
    local TextStrokeTransparency = v16.TextStrokeTransparency
    if TextStrokeTransparency >= 1 then
        return
    end
    local v19 = { Original = TextStrokeTransparency }

    function v19.Apply(v20) -- line 71 | captures: v16
        v16.TextStrokeTransparency = v20
    end

    table.insert(v15, v19)
end

local function addTextBoxChannels(v21, v22) -- line 76
    local TextTransparency = v22.TextTransparency
    if TextTransparency < 1 then
        local v23 = { Original = TextTransparency }

        function v23.Apply(v24) -- line 81 | captures: v22
            v22.TextTransparency = v24
        end

        table.insert(v21, v23)
    end
    local TextStrokeTransparency = v22.TextStrokeTransparency
    if TextStrokeTransparency >= 1 then
        return
    end
    local v25 = { Original = TextStrokeTransparency }

    function v25.Apply(v26) -- line 92 | captures: v22
        v22.TextStrokeTransparency = v26
    end

    table.insert(v21, v25)
end

local function addImageLabelChannel(v27, v28) -- line 97
    local ImageTransparency = v28.ImageTransparency
    if ImageTransparency >= 1 then
        return
    end
    local v29 = { Original = ImageTransparency }

    function v29.Apply(v30) -- line 104 | captures: v28
        v28.ImageTransparency = v30
    end

    table.insert(v27, v29)
end

local function addImageButtonChannel(v31, v32) -- line 109
    local ImageTransparency = v32.ImageTransparency
    if ImageTransparency >= 1 then
        return
    end
    local v33 = { Original = ImageTransparency }

    function v33.Apply(v34) -- line 116 | captures: v32
        v32.ImageTransparency = v34
    end

    table.insert(v31, v33)
end

local function captureFadeChannels(v35) -- line 121 | captures: isHiddenByDefault, addTextLabelChannels, addTextButtonChannels, addTextBoxChannels
    local v36 = {}
    for v37, v38 in ipairs(v35:GetDescendants()) do
        if not isHiddenByDefault(v38, v35) then
            if v38:IsA("GuiObject") then
                local BackgroundTransparency = v38.BackgroundTransparency
                if BackgroundTransparency < 1 then
                    local v39 = { Original = BackgroundTransparency }
                    local v40 = v38

                    function v39.Apply(v41) -- line 132 | captures: v40
                        v40.BackgroundTransparency = v41
                    end

                    table.insert(v36, v39)
                end
                if v38:IsA("TextLabel") then
                    addTextLabelChannels(v36, v38)
                elseif v38:IsA("TextButton") then
                    addTextButtonChannels(v36, v38)
                elseif v38:IsA("TextBox") then
                    addTextBoxChannels(v36, v38)
                elseif v38:IsA("ImageLabel") then
                    local ImageTransparency = v38.ImageTransparency
                    if ImageTransparency < 1 then
                        local v42 = { Original = ImageTransparency }
                        local v43 = v38

                        function v42.Apply(v44) -- line 148 | captures: v43
                            v43.ImageTransparency = v44
                        end

                        table.insert(v36, v42)
                    end
                elseif v38:IsA("ImageButton") then
                    local ImageTransparency = v38.ImageTransparency
                    if ImageTransparency < 1 then
                        local v45 = { Original = ImageTransparency }
                        local v46 = v38

                        function v45.Apply(v47) -- line 158 | captures: v46
                            v46.ImageTransparency = v47
                        end

                        table.insert(v36, v45)
                    end
                end
                if v38:IsA("CanvasGroup") then
                    local GroupTransparency = v38.GroupTransparency
                    if GroupTransparency < 1 then
                        local v48 = { Original = GroupTransparency }
                        local v49 = v38

                        function v48.Apply(v50) -- line 169 | captures: v49
                            v49.GroupTransparency = v50
                        end

                        table.insert(v36, v48)
                    end
                end
            elseif v38:IsA("UIStroke") then
                local Transparency = v38.Transparency
                if Transparency < 1 then
                    local v51 = { Original = Transparency }
                    local v52 = v38

                    function v51.Apply(v53) -- line 180 | captures: v52
                        v52.Transparency = v53
                    end

                    table.insert(v36, v51)
                end
            end
        end
    end
    return v36
end

local function resolveTransparency(v54, v55) -- line 190
    return 1 - v55 * (1 - v54)
end

local function applyFadeAlpha(v56) -- line 193
    for v57, v58 in ipairs(v56.Channels) do
        v58.Apply(1 - v56.Alpha * (1 - v58.Original))
    end
end

local function applyEntryTargetVisible(v59) -- line 198
    local v60 = v59.RangeVisible and v59.SuppressCount <= 0
    v59.TargetVisible = v60
    if v60 then
        v59.Billboard.Enabled = true
    end
end

local function setEntryRangeVisible(v61, v62) -- line 208
    v61.RangeVisible = v62
    local v63 = v61.RangeVisible and v61.SuppressCount <= 0
    v61.TargetVisible = v63
    if v63 then
        v61.Billboard.Enabled = true
    end
end

local function stepEntryFade(v64, v65) -- line 219 | captures: applyFadeAlpha
    local v66 = if v64.TargetVisible then 1 else 0
    if v64.Alpha ~= v66 then
        local v67 = v65 / 0.2
        if v66 <= v64.Alpha then
            local v68 = v64.Alpha - v67
            v64.Alpha = math.max(v68, v66)
        else
            local v69 = v64.Alpha + v67
            v64.Alpha = math.min(v69, v66)
        end
        applyFadeAlpha(v64)
    end
    if v64.TargetVisible then
        v64.Billboard.Enabled = true
    elseif v64.Alpha <= 0 then
        v64.Billboard.Enabled = false
    end
end

function v1.new() -- line 243 | captures: Players, RunService, ItemDisplay, Trove, v1, stepEntryFade
    local v70 = {}
    local v71 = setmetatable(v70, v1)
    v71._trove = Trove.new()
    v71._entries = {}
    v71._elapsed = 0
    v71._trove:Add(RunService.Heartbeat:Connect(function(v72) -- line 249 | captures: v71, Players, ItemDisplay, stepEntryFade
        v71._elapsed += v72
        local v73 = v71._elapsed >= 0.15
        if v73 then
            v71._elapsed = 0
        end
        local Character = Players.LocalPlayer.Character
        local v74 = Character and Character:FindFirstChild("HumanoidRootPart")
        if v74 ~= nil and not v74:IsA("BasePart") then
            v74 = nil
        end
        for v75, v76 in pairs(v71._entries) do
            if v73 then
                local PrimaryPart = v75.PrimaryPart
                if PrimaryPart == nil then
                    v76.RangeVisible = false
                    local v77 = v76.RangeVisible and v76.SuppressCount <= 0
                    v76.TargetVisible = v77
                    if v77 then
                        v76.Billboard.Enabled = true
                    end
                elseif v75.Parent ~= nil and v74 ~= nil then
                    local v78 = PrimaryPart.Position - v74.Position
                    v76.RangeVisible = Vector2.new(v78.X, v78.Z).Magnitude <= ItemDisplay.GetDataBillboardMaxDistance()
                    local v79 = v76.RangeVisible and v76.SuppressCount <= 0
                    v76.TargetVisible = v79
                    if v79 then
                        v76.Billboard.Enabled = true
                    end
                end
            end
            stepEntryFade(v76, v72)
        end
    end))
    return v71
end

function v1.Add(v80, v81, v82, v83) -- line 300 | captures: ItemDisplay, captureFadeChannels, applyFadeAlpha
    local v84 = ItemDisplay.CreateDataBillboard(v81, v82.Category, v82, v83)
    local v85 = v84 ~= nil
    local v86 = ("Asset model %* must expose CENTER for its data billboard"):format(v81.Name)
    assert(v85, v86)
    v84.MaxDistance = 100000
    local v87 = {
        Alpha = 0,
        RangeVisible = false,
        SuppressCount = 0,
        TargetVisible = false,
        Model = v81,
        Billboard = v84,
        Channels = captureFadeChannels(v84)
    }
    applyFadeAlpha(v87)
    v84.Enabled = false
    v80._entries[v81] = v87
end

function v1.UpdateMoneyPerSecond(v88, v89, v90) -- line 318 | captures: ItemDisplay
    local v91 = v88._entries[v89]
    local v92 = v91 ~= nil
    local v93 = ("Asset model %* must have a data billboard before its MPS can update"):format(v89.Name)
    assert(v92, v93)
    ItemDisplay.SetDataBillboardMoneyPerSecond(v91.Billboard, v90)
end

local function SetSuppressed(v94, v95, v96) -- line 324
    local v97 = v94._entries[v95]
    if v97 == nil then
        return
    end
    if v96 then
        v97.SuppressCount += 1
    elseif v97.SuppressCount > 0 then
        v97.SuppressCount -= 1
    end
    local v98 = v97.RangeVisible and v97.SuppressCount <= 0
    v97.TargetVisible = v98
    if v98 then
        v97.Billboard.Enabled = true
    end
end

v1.SetSuppressed = SetSuppressed

local function Remove(v99, v100) -- line 343
    local v101 = v99._entries[v100]
    if v101 ~= nil then
        v101.Billboard:Destroy()
        v99._entries[v100] = nil
    end
end

v1.Remove = Remove

local function Destroy(v102) -- line 350
    for v103 in pairs(v102._entries) do
        v102:Remove(v103)
    end
    v102._trove:Destroy()
end

v1.Destroy = Destroy
return v1
