-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ViewportSize = require(ReplicatedStorage.Client.ViewportSize)
local Player = require(ReplicatedStorage.Shared.Player)
local Rarities = require(ReplicatedStorage.Data.Rarity).Rarities
local Info = ReplicatedStorage.Assets.UI.Misc.Info
local Blocks = Info.Blocks
local RarityGradients = ReplicatedStorage.Assets.UI.RarityGradients
local v1 = {
    Title = 250,
    Rarity = 300,
    Desc = 175,
    Div = 65
}
local v2 = {
    Title = 32,
    Rarity = 22,
    Desc = 20,
    Div = 15
}
local v3 = {}
local v4, v5, v6, v7

local function screenLayer() -- line 24 | captures: v4, Player
    if not v4 then
        v4 = Instance.new("ScreenGui")
        v4.Name = "InfoOverlay"
        v4.DisplayOrder = 10000
        v4.ZIndexBehavior = Enum.ZIndexBehavior.Global
        v4.ResetOnSpawn = false
        v4.ClipToDeviceSafeArea = false
        v4.Parent = Player.PlayerGui()
    end
    return v4
end

local function clearGradients(v8) -- line 37
    for v9, v10 in v8:GetChildren() do
        if v10:IsA("UIGradient") then
            v10:Destroy()
        end
    end
end

local function addRarityGradient(v11, v12) -- line 44 | captures: RarityGradients
    local v13 = RarityGradients:FindFirstChild(v12)
    if v13 then
        v13:Clone().Parent = v11
    end
end

local v14 = {}

function v14.Title(v15, v16) -- line 51 | captures: RarityGradients
    local title = v15.title
    local v17 = v16[2] or ""
    local v18 = tostring(v17)
    local v19 = v16[3]
    local v20 = v16[4]
    title.Text = v18
    title.RichText = string.find(v18, "<.->") ~= nil
    if typeof(v20) == "Color3" then
        title.TextColor3 = v20
    end
    if v19 == "Mythical" then
        title.TextColor3 = Color3.new(1, 1, 1)
        local v21 = RarityGradients:FindFirstChild(v19)
        if v21 then
            v21:Clone().Parent = title
            return v18
        end
    elseif v19 == "Exclusive" then
        title.TextColor3 = Color3.new(1, 1, 1)
        local v22 = RarityGradients:FindFirstChild(v19)
        if v22 then
            v22:Clone().Parent = title
        end
    end
    return v18
end

function v14.Rarity(v23, v24) -- line 77 | captures: Rarities, clearGradients
    local v25 = v24[2]
    local v26 = Rarities[v25]
    local v27 = ("Unknown rarity: %*"):format((tostring(v25)))
    local v28 = assert(v26, v27)
    local title = v23.title
    local UIStroke = title:FindFirstChildOfClass("UIStroke")
    local v29 = if v25 == "Exclusive" then "  \226\152\133" else ""
    local v30 = v28.DisplayName .. v29
    title.Text = v30
    clearGradients(title)
    if UIStroke then
        clearGradients(UIStroke)
    end
    v28.RarityGradient:Clone().Parent = title
    if UIStroke then
        v28.RarityGradient:Clone().Parent = UIStroke
    end
    return v30
end

function v14.Desc(v31, v32) -- line 100 | captures: RarityGradients
    local title = v31.title
    local v33 = v32[2] or ""
    local v34 = tostring(v33)
    local v35 = v32[3]
    title.Text = v34
    title.RichText = string.find(v34, "<.->") ~= nil
    if v35 == "Exclusive" then
        title.TextColor3 = Color3.new(1, 1, 1)
        local v36 = RarityGradients:FindFirstChild(v35)
        if v36 then
            v36:Clone().Parent = title
        end
    end
    return v34
end

local function Div() -- line 116
    return nil
end

v14.Div = Div

local function plainText(v37) -- line 120
    return string.gsub(v37, "<.->", "")
end

local function measureRow(v38, v39, v40) -- line 123 | captures: TextService, v1, v2
    local v41 = v1[v39]
    local v42 = v2[v39]
    if v40 then
        local title = v38.title
        local v43 = if title.Font == Enum.Font.Unknown then Enum.Font.Arial else title.Font
        local v44 = string.gsub(v40, "<.->", "")
        local v45 = TextService:GetTextSize(v44, title.TextSize, v43, Vector2.new(v41, 1000))
        local UIStroke = title:FindFirstChildOfClass("UIStroke")
        local v46 = if UIStroke then UIStroke.Thickness * 2 else 0
        local v47 = v45.X + 10 + v46
        local v48 = math.clamp(v47, 65, v41)
        local v49 = v45.Y + v46
        local v50 = math.max(v49, v42)
        v38.Size = UDim2.new(1, 0, 0, v50)
        return v48, v50
    end
    v38.Size = UDim2.new(1, 0, 0, v42)
    return 65, v42
end

local function pointInside(v51, v52, v53) -- line 150
    local AbsolutePosition = v51.AbsolutePosition
    local AbsoluteSize = v51.AbsoluteSize
    if AbsolutePosition.X <= v52 and v52 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y <= v53 then
        return v53 <= AbsolutePosition.Y + AbsoluteSize.Y
    end
    return false
end

local function placeCard(v54, v55, v56, v57, v58) -- line 156 | captures: v4, Player
    if not v4 then
        v4 = Instance.new("ScreenGui")
        v4.Name = "InfoOverlay"
        v4.DisplayOrder = 10000
        v4.ZIndexBehavior = Enum.ZIndexBehavior.Global
        v4.ResetOnSpawn = false
        v4.ClipToDeviceSafeArea = false
        v4.Parent = Player.PlayerGui()
    end
    local AbsoluteSize = v4.AbsoluteSize
    if AbsoluteSize.X <= 0 then
        local CurrentCamera = workspace.CurrentCamera
        if CurrentCamera then
            local ViewportSize = CurrentCamera.ViewportSize
            local Y = ViewportSize.Y
            local v59 = if Y < v56 + 10 + v58 then v56 - 10 - v58 < 0 else true
            local v60 = v55 + 10
            local v61 = ViewportSize.X - v57
            local v62 = math.max(v61, 0)
            local v63 = math.clamp(v60, 0, v62)
            local v64, v65
            if v59 then
                v65 = 10
                v64 = -v58
            else
                v65 = -10
                v64 = v58
            end
            local v66 = Y + v64
            local v67 = v56 + v65
            local v68 = math.max(v66, 0)
            local v69 = math.clamp(v67, 0, v68)
            local v70 = if v59 then 0 else 1
            v54.AnchorPoint = Vector2.new(0, v70)
            v54.Position = UDim2.fromOffset(v63, v69)
        end
    elseif AbsoluteSize.Y > 0 then
    end
end

local function cardSize(v71, v72, v73) -- line 208
    local AbsoluteSize = v71.AbsoluteSize
    if not (AbsoluteSize.X <= 0) and AbsoluteSize.Y > 0 then
        return AbsoluteSize.X, AbsoluteSize.Y
    end
    return v72, v73
end

local function track(v74, v75, v76, v77) -- line 218 | captures: v5, v7, GuiService, RunService, Player, v3, placeCard, cardSize
    local v78 = Player.Mouse()
    v7 = RunService.RenderStepped:Connect(function() -- line 220 | captures: v74, v75, v76, v77, v78, v5, GuiService, v3, placeCard, cardSize
        if v74 == v5 and v74.Parent and v75.Parent then
            local X = v78.X
            local Y = v78.Y
            local AbsolutePosition = v75.AbsolutePosition
            local AbsoluteSize = v75.AbsoluteSize
            if AbsolutePosition.X <= X and X <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y <= Y and Y <= AbsolutePosition.Y + AbsoluteSize.Y or GuiService.SelectedObject == v75 then
                placeCard(v74, X, Y, cardSize(v74, v76, v77))
            else
                v3.Dismiss()
            end
        else
            v3.Dismiss()
        end
    end)
end

local function show(v79, v80) -- line 242 | captures: v4, v5, v6, v7, GuiService, RunService, Audio, ViewportSize, Player, Info, Blocks, v3, v14, measureRow, placeCard, cardSize
    v3.Dismiss()
    if #v80 == 0 then
        return
    end
    local v81 = Info.Base:Clone()
    local Blocks_2 = v81.Frame.Blocks
    local UIPadding = Blocks_2:FindFirstChildOfClass("UIPadding")
    local UIListLayout = Blocks_2:FindFirstChildOfClass("UIListLayout")
    local v82 = 65
    local v83 = 0
    for v84, v85 in v80 do
        local v86 = v85[1]
        local v87 = v14[v86]
        local v88 = ("Unknown info row: %*"):format((tostring(v86)))
        local v89 = assert(v87, v88)
        local v90 = Blocks:FindFirstChild(v86)
        local v91 = ("Missing info row template: %*"):format(v86)
        local v92 = assert(v90, v91):Clone()
        local v93 = v89(v92, v85)
        local v94, v95 = measureRow(v92, v86, v93)
        v82 = math.max(v82, v94)
        v83 += v95
        v92.LayoutOrder = v84
        v92.Parent = Blocks_2
    end
    local v96 = #v80 - 1
    local v97 = v83 + math.max(v96, 0) * UIListLayout.Padding.Offset
    local v98 = v82 + UIPadding.PaddingLeft.Offset + UIPadding.PaddingRight.Offset
    local v99 = v97 + UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset
    v81.Size = UDim2.fromOffset(v98, v99)
    local UIScale = v81.UIScale
    local v100 = ViewportSize.ReadScale()
    UIScale.Scale = 1 - (1 - math.min(v100, 1)) / 1.5
    if #v80 == 1 then
        v81.Frame.UICorner.CornerRadius = UDim.new(0.15, 0)
    end
    local Scale = v81.UIScale.Scale
    local v101 = v98 * Scale
    local v102 = v99 * Scale
    local v103 = Player.Mouse()
    placeCard(v81, v103.X, v103.Y, v101, v102)
    if not v4 then
        v4 = Instance.new("ScreenGui")
        v4.Name = "InfoOverlay"
        v4.DisplayOrder = 10000
        v4.ZIndexBehavior = Enum.ZIndexBehavior.Global
        v4.ResetOnSpawn = false
        v4.ClipToDeviceSafeArea = false
        v4.Parent = Player.PlayerGui()
    end
    v81.Parent = v4
    v5 = v81
    v6 = v79
    Audio.Play("rbxassetid://72058086648303", script, { Volume = 0.2 })
    local v104 = Player.Mouse()
    v7 = RunService.RenderStepped:Connect(function() -- line 301 | captures: v79, v81, v101, v102, v104, v5, GuiService, v3, placeCard, cardSize
        if v81 == v5 and v81.Parent and v79.Parent then
            local X = v104.X
            local Y = v104.Y
            local AbsolutePosition = v79.AbsolutePosition
            local AbsoluteSize = v79.AbsoluteSize
            if AbsolutePosition.X <= X and X <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y <= Y and Y <= AbsolutePosition.Y + AbsoluteSize.Y or GuiService.SelectedObject == v79 then
                placeCard(v81, X, Y, cardSize(v81, v101, v102))
            else
                v3.Dismiss()
            end
        else
            v3.Dismiss()
        end
    end)
end

function v3.Show(v105, v106) -- line 323 | captures: show
    show(v105, v106)
end

function v3.Hook(v107, v108) -- line 326 | captures: v6, v3, show
    local function open() -- line 327 | captures: v107, v108, show
        local v109
        if typeof(v108) == "function" then
            v109 = v108()
        else
            v109 = v108
        end
        if v109 then
            show(v107, v109)
        end
    end

    local v110 = v107.MouseEnter:Connect(open)
    local v111 = v107.SelectionGained:Connect(open)
    return function() -- line 340 | captures: v107, v110, v111, v6, v3
        v110:Disconnect()
        v111:Disconnect()
        if v6 == v107 then
            v3.Dismiss()
        end
    end
end

function v3.Dismiss() -- line 348 | captures: v5, v6, v7
    if v7 then
        v7:Disconnect()
        v7 = nil
    end
    if v5 then
        v5:Destroy()
        v5 = nil
    end
    v6 = nil
end

return v3
