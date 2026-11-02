-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VisibleBounds = require(ReplicatedStorage.Shared.Utils.Spatial).VisibleBounds
local TweenOnce = require(ReplicatedStorage.Shared.Utils.Instances).TweenOnce
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Cash = ReplicatedStorage.Assets.Extra.Cash
local BillboardGui = Cash:IsA("BillboardGui")
assert(BillboardGui, "Assets.Extra.Cash must be a BillboardGui")
local v1 = {}

local function scaleBillboardSize(v2, v3) -- line 15
    return UDim2.new(v2.X.Scale * v3, v2.X.Offset * v3, v2.Y.Scale * v3, v2.Y.Offset * v3)
end

local function getBillboardScale(v4) -- line 18
    local v5 = v4.X / 2
    local v6 = v4.Y / 5.72646427154541
    local v7 = v4.Z / 5.299603462219238
    local v8 = math.min(v5, v6, v7)
    if v8 <= 0 then
        return 0.9
    end
    return (math.clamp(v8, 0.9, 5))
end

local function fadeTextLabel(v9, v10, v11, v12) -- line 25 | captures: TweenOnce
    v9.Text = v10
    v9.TextTransparency = 1
    TweenOnce(v9, v11, { TextTransparency = 0 })
    task.delay(0.8499999999999999, function() -- line 29 | captures: v9, v12, TweenOnce
        if v9.Parent then
            TweenOnce(v9, v12, { TextTransparency = 1 })
        end
    end)
end

local function fadeTextButton(v13, v14, v15, v16) -- line 35 | captures: TweenOnce
    v13.Text = v14
    v13.TextTransparency = 1
    TweenOnce(v13, v15, { TextTransparency = 0 })
    task.delay(0.8499999999999999, function() -- line 39 | captures: v13, v16, TweenOnce
        if v13.Parent then
            TweenOnce(v13, v16, { TextTransparency = 1 })
        end
    end)
end

local function fadeTextBox(v17, v18, v19, v20) -- line 45 | captures: TweenOnce
    v17.Text = v18
    v17.TextTransparency = 1
    TweenOnce(v17, v19, { TextTransparency = 0 })
    task.delay(0.8499999999999999, function() -- line 49 | captures: v17, v20, TweenOnce
        if v17.Parent then
            TweenOnce(v17, v20, { TextTransparency = 1 })
        end
    end)
end

local function fadeImageObject(v21, v22, v23) -- line 55 | captures: TweenOnce
    v21.ImageTransparency = 1
    TweenOnce(v21, v22, { ImageTransparency = 0 })
    task.delay(0.8499999999999999, function() -- line 58 | captures: v21, v23, TweenOnce
        if v21.Parent then
            TweenOnce(v21, v23, { ImageTransparency = 1 })
        end
    end)
end

local function fadePopupDescendants(v24, v25, v26, v27) -- line 64 | captures: TweenOnce, fadeTextLabel, fadeTextButton, fadeTextBox, fadeImageObject
    for v28, v29 in ipairs(v24:GetDescendants()) do
        if v29:IsA("TextLabel") then
            fadeTextLabel(v29, v25, v26, v27)
        elseif v29:IsA("TextButton") then
            fadeTextButton(v29, v25, v26, v27)
        elseif v29:IsA("TextBox") then
            fadeTextBox(v29, v25, v26, v27)
        elseif v29:IsA("UIStroke") then
            v29.Transparency = 1
            TweenOnce(v29, v26, { Transparency = 0 })
            local delay = task.delay
            local v30 = v29
            delay(0.8499999999999999, function() -- line 77 | captures: v27, v30, TweenOnce
                if v30.Parent then
                    TweenOnce(v30, v27, { Transparency = 1 })
                end
            end)
        elseif v29:IsA("ImageLabel") then
            fadeImageObject(v29, v26, v27)
        elseif v29:IsA("ImageButton") then
        end
    end
end

local function showAtCFrame(v31, v32, v33, v34, v35) -- line 88 | captures: Debris, TweenOnce, Simple, Cash, fadePopupDescendants
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "SyncedIncomeCashAttachment"
    Attachment.WorldCFrame = v31
    Attachment.Parent = workspace.Terrain
    local v36 = Cash:Clone()
    v36.Name = "SyncedIncomeCash"
    v36.Adornee = Attachment
    v36.Parent = Attachment
    if v33 then
        if v33.alwaysOnTop == nil then
            v36.AlwaysOnTop = true
        else
            v36.AlwaysOnTop = v33.alwaysOnTop
        end
    else
        v36.AlwaysOnTop = true
    end
    local Size = v36.Size
    v36.Size = UDim2.new(Size.X.Scale * v35, Size.X.Offset * v35, Size.Y.Scale * v35, Size.Y.Offset * v35)
    local v37 = ("+$%*"):format((Simple.FormatCompact((math.round(v32)))))
    local v38 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    fadePopupDescendants(v36, v37, v38, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
    local v39 = TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenOnce(Attachment, v39, { WorldPosition = v31.Position + Vector3.new(0, v34, 0) })
    Debris:AddItem(v36, 1.4)
    Debris:AddItem(Attachment, 1.4)
end

function v1.Show(v40, v41, v42) -- line 116 | captures: VisibleBounds, Cash, showAtCFrame
    local v43, v44 = VisibleBounds(v40)
    local v45 = v44.Y / 1.5
    local v46 = v43 - Vector3.new(0, v45, 0)
    local CurrentCamera = workspace.CurrentCamera
    local v47 = assert(CurrentCamera, "Active asset income popup requires Workspace.CurrentCamera")
    local MaxDistance = Cash.MaxDistance
    if MaxDistance <= 0 then
        local v48 = v44.X / 2
        local v49 = v44.Y / 5.72646427154541
        local v50 = v44.Z / 5.299603462219238
        local v51 = math.min(v48, v49, v50)
        local v52
        if v51 > 0 then
            v52 = math.clamp(v51, 0.9, 5)
        else
            v52 = 0.9
        end
        showAtCFrame(v46, v41, v42, v44.Y - v44.Y * 0.25, v52)
    elseif not (MaxDistance < (v47.CFrame.Position - v46.Position).Magnitude) then
        local v53 = v44.X / 2
        local v54 = v44.Y / 5.72646427154541
        local v55 = v44.Z / 5.299603462219238
        local v56 = math.min(v53, v54, v55)
        local v57
        if v56 > 0 then
            v57 = math.clamp(v56, 0.9, 5)
        else
            v57 = 0.9
        end
        showAtCFrame(v46, v41, v42, v44.Y - v44.Y * 0.25, v57)
    end
end

return v1
