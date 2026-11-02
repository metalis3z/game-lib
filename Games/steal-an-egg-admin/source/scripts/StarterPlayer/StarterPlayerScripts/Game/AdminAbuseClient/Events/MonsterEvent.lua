-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Trove = require(ReplicatedStorage.Packages.Trove)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local EggState = require(ReplicatedStorage.Client.EggState)
local PlayerUtils = require(ReplicatedStorage.Shared.Utils.PlayerUtils)
local LightingsController = require(ReplicatedStorage.Client.LightingsController)
local Lightings = require(ReplicatedStorage.Data.Lightings)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local AvatarBust = Enum.ThumbnailType.AvatarBust
local Size150x150 = Enum.ThumbnailSize.Size150x150
local v1 = UDim2.fromScale(0, 0)
local v2 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v3 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v4 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v5 = Color3.fromRGB(255, 255, 32)
local v6 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v7 = Vector2.new(0.3, 0.35)
local v8 = Vector2.new(0.7, 0.65)
local v9 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v10 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local v11 = Trove.new()
local v12 = false
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v13, v14
local v15 = {}
local v16 = {}
local v17 = {}
local v18 = {}
local v19
local v20 = false
local v21 = {}
local v22 = {}
local v23 = false
local v24

local function BuildRow(v25) -- line 52 | captures: v14, v1
    local v26 = v14:FindFirstChild(v25)
    local v27 = v26 and v26:IsA("Frame")
    local v28 = ("MonsterEventUI is missing its %* row"):format(v25)
    assert(v27, v28)
    local Avatar = v26:FindFirstChild("Avatar")
    local v29 = Avatar and Avatar:IsA("ImageLabel")
    local v30 = ("the %* row is missing its Avatar"):format(v25)
    assert(v29, v30)
    local Amount = Avatar:FindFirstChild("Amount")
    local v31 = Amount and Amount:IsA("TextLabel")
    local v32 = ("the %* row is missing its Amount label"):format(v25)
    assert(v31, v32)
    local Size = v26.Size
    local v33
    if Size.X.Scale == 0 and Size.X.Offset == 0 then
        local You = v14:FindFirstChild("You")
        v33 = You and You ~= v26 and You.Size or UDim2.fromScale(0.2, 0.85)
    else
        v33 = Size
    end
    local v34 = {
        Shown = false,
        Frame = v26,
        Avatar = Avatar,
        Amount = Amount,
        BaseSize = v33,
        BaseColor = v26.BackgroundColor3
    }
    v26.Size = v1
    v26.Visible = false
    return v34
end

local function EnsureUI() -- line 99 | captures: v13, v14, v18, v19, LocalPlayer, PlayerGui, BuildRow
    if v13 == nil then
        if LocalPlayer.Character == nil then
            LocalPlayer.CharacterAdded:Wait()
        end
        local v35 = PlayerGui:WaitForChild("MonsterEventUI", 30)
        if v35 == nil then
            warn("[MonsterEvent] StarterGui.MonsterEventUI never reached the PlayerGui")
        else
            local v36 = v35:WaitForChild("Board", 30)
            local v37 = v36 and v36:WaitForChild("Rows", 30)
            if v37 == nil then
                warn("[MonsterEvent] MonsterEventUI is missing Board.Rows")
            else
                v14 = v37
                local v38, v39 = pcall(function() -- line 118 | captures: v18, v19, BuildRow
                    v18 = {
                        BuildRow("First"),
                        BuildRow("Second"),
                        (BuildRow("Third"))
                    }
                    v19 = BuildRow("You")
                end)
                if v38 then
                    v13 = v35
                    return true
                end
                v14 = nil
                warn("[MonsterEvent] the leaderboard rows could not be built: " .. tostring(v39))
            end
        end
        return false
    end
    return true
end

local function SetRowShown(v40, v41) -- line 130 | captures: TweenService, v1, v2
    if v40.Shown == v41 then
        return
    end
    v40.Shown = v41
    local Frame = v40.Frame
    if v41 then
        Frame.Size = v1
        Frame.Visible = true
        TweenService:Create(Frame, v2, { Size = v40.BaseSize }):Play()
    else
        local v42 = TweenService:Create(Frame, v2, { Size = v1 })
        v42.Completed:Once(function() -- line 143 | captures: v40, Frame
            Frame.Visible = v40.Shown
        end)
        v42:Play()
    end
end

local function FlashRow(v43) -- line 148 | captures: TweenService, v3
    local v44 = Color3.new(1, 1, 1)
    v43.Frame.BackgroundColor3 = v43.BaseColor:Lerp(v44, 0.6)
    TweenService:Create(v43.Frame, v3, { BackgroundColor3 = v43.BaseColor }):Play()
end

local function ResolvePlayerImage(v45) -- line 153 | captures: v24, Players, PlayerUtils, AvatarBust, Size150x150, v16, v17
    local v46 = v16[v45]
    if v46 then
        return v46
    end
    if not v17[v45] then
        local v47 = Players:FindFirstChild(v45)
        if v47 and v47:IsA("Player") then
            v17[v45] = true
            task.spawn(function() -- line 166 | captures: v45, v47, v24, PlayerUtils, AvatarBust, Size150x150, v16, v17
                local v48, v49 = pcall(PlayerUtils.Thumbnail, v47.UserId, AvatarBust, Size150x150)
                v17[v45] = nil
                if v48 and type(v49) == "string" then
                    v16[v45] = v49
                    v24()
                end
            end)
        end
    end
    return nil
end

local function FillRow(v50, v51, v52) -- line 177 | captures: TweenService, Simple, v1, v2, FlashRow, ResolvePlayerImage
    local v53 = ResolvePlayerImage(v51)
    v50.Avatar.Image = v53 or ""
    v50.Amount.Text = Simple.FormatCompact(v52, ".#")
    if v50.Occupant ~= nil and v50.Occupant ~= v51 then
        FlashRow(v50)
    end
    v50.Occupant = v51
    if v50.Shown == true then
        return
    end
    v50.Shown = true
    local Frame = v50.Frame
    Frame.Size = v1
    Frame.Visible = true
    TweenService:Create(Frame, v2, { Size = v50.BaseSize }):Play()
end

local function ClearRow(v54) -- line 194 | captures: TweenService, v1, v2
    v54.Occupant = nil
    if v54.Shown == false then
        return
    end
    v54.Shown = false
    local Frame = v54.Frame
    local v55 = TweenService:Create(Frame, v2, { Size = v1 })
    v55.Completed:Once(function() -- line 202 | captures: v54, Frame
        Frame.Visible = v54.Shown
    end)
    v55:Play()
end

function v24() -- line 207 | captures: v13, v15, v18, v19, TweenService, v1, v2, LocalPlayer, FillRow
    if v13 == nil then
        return
    end
    local v56 = {}
    for v57, v58 in v15 do
        if v58 > 0 then
            local v59 = {
                Name = v57,
                Wins = v58
            }
            table.insert(v56, v59)
        end
    end
    table.sort(v56, function(v60, v61) -- line 223
        if v60.Wins == v61.Wins then
            return v60.Name < v61.Name
        end
        return v61.Wins < v60.Wins
    end)
    local Name = LocalPlayer.Name
    local v62 = false
    for v63, v64 in v18 do
        local v65 = v56[v63]
        if v65 == nil then
            v64.Occupant = nil
            if v64.Shown ~= false then
                v64.Shown = false
                local Frame = v64.Frame
                local v66 = TweenService:Create(Frame, v2, { Size = v1 })
                local Completed = v66.Completed
                local v67 = v64
                Completed:Once(function() -- line 252 | captures: Frame, v67
                    Frame.Visible = v67.Shown
                end)
                v66:Play()
            end
        else
            FillRow(v64, v65.Name, v65.Wins)
            v62 = v62 or v65.Name == Name
        end
    end
    local v68 = v19
    assert(v68, "MonsterEventUI has no You row")
    if v62 then
        v68.Occupant = nil
        if v68.Shown ~= false then
            v68.Shown = false
            local Frame = v68.Frame
            local v69 = TweenService:Create(Frame, v2, { Size = v1 })
            v69.Completed:Once(function() -- line 272 | captures: v68, Frame
                Frame.Visible = v68.Shown
            end)
            v69:Play()
        end
    else
        FillRow(v68, Name, v15[Name] or 0)
    end
end

local function CollectWinPartFades(v70) -- line 277
    local v71 = {
        {
            Property = "Transparency",
            Object = v70,
            Base = v70.Transparency
        }
    }
    for v72, v73 in v70:GetDescendants() do
        if v73:IsA("TextLabel") then
            local v74 = {
                Property = "TextTransparency",
                Object = v73,
                Base = v73.TextTransparency
            }
            table.insert(v71, v74)
            local v75 = {
                Property = "BackgroundTransparency",
                Object = v73,
                Base = v73.BackgroundTransparency
            }
            table.insert(v71, v75)
        elseif v73:IsA("ImageLabel") then
            local v76 = {
                Property = "ImageTransparency",
                Object = v73,
                Base = v73.ImageTransparency
            }
            table.insert(v71, v76)
            local v77 = {
                Property = "BackgroundTransparency",
                Object = v73,
                Base = v73.BackgroundTransparency
            }
            table.insert(v71, v77)
        elseif v73:IsA("Frame") then
            local v78 = {
                Property = "BackgroundTransparency",
                Object = v73,
                Base = v73.BackgroundTransparency
            }
            table.insert(v71, v78)
        elseif v73:IsA("UIStroke") then
            local v79 = {
                Property = "Transparency",
                Object = v73,
                Base = v73.Transparency
            }
            table.insert(v71, v79)
        end
    end
    return v71
end

local function SetWinPartHidden(v80, v81) -- line 296 | captures: TweenService, v4
    if v80.Hidden == v81 then
        return
    end
    v80.Hidden = v81
    if not v81 then
        v80.Gui.Enabled = true
    end
    for v82, v83 in v80.Fades do
        local v84 = if v81 then 1 else v83.Base
        local v85 = {}
        v85[v83.Property] = v84
        TweenService:Create(v83.Object, v4, v85):Play()
    end
    if v81 then
        task.delay(0.35, function() -- line 320 | captures: v80
            if v80.Hidden then
                v80.Gui.Enabled = false
            end
        end)
    end
end

local function ApplyWinPartVisibility() -- line 327 | captures: v21, v22, v23, SetWinPartHidden
    for v86, v87 in v21 do
        local v88 = v23 or v22[v86] == true
        SetWinPartHidden(v87, v88)
    end
end

local function FlashWinClaim() -- line 340 | captures: Lighting, TweenService, v5, v6
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
    ColorCorrectionEffect.Name = "MonsterEventWinFlash"
    ColorCorrectionEffect.TintColor = v5
    ColorCorrectionEffect.Contrast = 0.2
    ColorCorrectionEffect.Saturation = 0.1
    ColorCorrectionEffect.Parent = Lighting
    ColorCorrectionEffect.Enabled = true
    local v89 = TweenService:Create(ColorCorrectionEffect, v6, {
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.new(1, 1, 1)
    })
    v89.Completed:Once(function() -- line 349 | captures: ColorCorrectionEffect
        ColorCorrectionEffect:Destroy()
    end)
    v89:Play()
end

local function GetLocalRowAvatar() -- line 354 | captures: v18, v19, LocalPlayer
    local Name = LocalPlayer.Name
    for v90, v91 in v18 do
        if v91.Shown and v91.Occupant == Name then
            return v91.Avatar
        end
    end
    local v92 = v19
    if v92 ~= nil and v92.Shown and v92.Occupant == Name then
        return v92.Avatar
    end
    return nil
end

local function ScreenPositionOf(v93) -- line 373 | captures: v13
    if v13 == nil then
        return UDim2.fromScale(0.5, 0.5)
    end
    local AbsoluteSize = v13.AbsoluteSize
    local v94 = v93.AbsolutePosition + v93.AbsoluteSize * 0.5 - v13.AbsolutePosition
    return UDim2.fromScale(v94.X / AbsoluteSize.X, v94.Y / AbsoluteSize.Y)
end

local function SpawnTrophyBurst(v95) -- line 381 | captures: v13, TweenService, v7, v8, v9, v10, GetLocalRowAvatar
    if v13 ~= nil then
        local v96 = math.clamp(v95, 1, 7)
        for v97 = 1, v96 do
            local ImageLabel = Instance.new("ImageLabel")
            ImageLabel.Name = "MonsterEventTrophy"
            ImageLabel.Image = "rbxassetid://82857133407630"
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.ImageTransparency = 1
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            ImageLabel.Size = UDim2.new(0, 0, 0, 0)
            local v98 = TweenInfo.new(0.1)
            TweenService:Create(ImageLabel, v98, { Size = UDim2.fromScale(0.06, 0.06) }):Play()
            ImageLabel.Rotation = math.random(0, 359)
            local v99 = v7.X + math.random() * (v8.X - v7.X)
            ImageLabel.Position = UDim2.fromScale(v99, v7.Y + math.random() * (v8.Y - v7.Y))
            ImageLabel.ZIndex = 10
            local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
            UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
            UIAspectRatioConstraint.Parent = ImageLabel
            ImageLabel.Parent = v13
            TweenService:Create(ImageLabel, v9, { ImageTransparency = 0 }):Play()
            local delay = task.delay
            delay(0.2, function() -- line 407 | captures: ImageLabel, v13, TweenService, v10, GetLocalRowAvatar
                if ImageLabel.Parent == nil then
                    return
                end
                local v100 = GetLocalRowAvatar()
                local v101 = { ImageTransparency = 1 }
                if v100 ~= nil then
                    local AbsoluteSize = v13.AbsoluteSize
                    local v102 = v100.AbsolutePosition + v100.AbsoluteSize * 0.5 - v13.AbsolutePosition
                    v101.Position = UDim2.fromScale(v102.X / AbsoluteSize.X, v102.Y / AbsoluteSize.Y)
                end
                local v103 = TweenService:Create(ImageLabel, v10, v101)
                v103.Completed:Once(function() -- line 419 | captures: ImageLabel
                    ImageLabel:Destroy()
                end)
                v103:Play()
            end)
        end
    end
end

local function InitWinParts() -- line 426 | captures: v21, v11, CollectWinPartFades
    local v104 = workspace:WaitForChild("MonsterEventMap", 10)
    if v104 == nil then
        return
    end
    local WinParts = v104:FindFirstChild("WinParts")
    local v105 = WinParts ~= nil
    assert(v105, "MonsterEventMap is missing its WinParts model")
    for v106, v107 in WinParts:GetChildren() do
        local BasePart = v107:IsA("BasePart")
        local v108 = ("Win part %* is not a BasePart"):format(v107.Name)
        assert(BasePart, v108)
        local SurfaceGui = v107:FindFirstChildOfClass("SurfaceGui")
        local v109 = SurfaceGui ~= nil
        local v110 = ("Win part %* is missing its SurfaceGui"):format(v107.Name)
        assert(v109, v110)
        v21[v107.Name] = {
            Hidden = false,
            Part = v107,
            Gui = SurfaceGui,
            Fades = CollectWinPartFades(v107)
        }
    end
    v11:Add(function() -- line 443 | captures: v21
        v21 = {}
    end)
end

local v111 = require(script.Cutscene)(v11)
Remotes.MonsterEvent.WinsUpdated.OnClientEvent:Connect(function(v112) -- line 449 | captures: v15, v24
    v15 = v112
    v24()
end)
Remotes.MonsterEvent.PlaySFX.OnClientEvent:Connect(function(v113) -- line 453
    script.SFX[v113]:Play()
end)
EggState.CarryChanged:Connect(function(v114) -- line 456 | captures: v20
    v20 = v114.IsCarrying
end)
Remotes.MonsterEvent.WinPartsUpdated.OnClientEvent:Connect(function(v115, v116) -- line 459 | captures: v21, v22, v23, SetWinPartHidden, FlashWinClaim, SpawnTrophyBurst
    v22 = v115
    for v117, v118 in v21 do
        local v119 = v23 or v22[v117] == true
        SetWinPartHidden(v118, v119)
    end
    if v116 ~= nil then
        FlashWinClaim()
        SpawnTrophyBurst(v116)
    end
end)
local v120 = false
CollectionService:GetInstanceAddedSignal("MonsterEventKillBrick"):Connect(function(v121) -- line 480 | captures: v13, v120, TweenService, LocalPlayer
    v121.Touched:Connect(function(v122) -- line 481 | captures: v13, v120, TweenService, LocalPlayer
        if v122.Parent ~= LocalPlayer.Character or v120 then
            return
        end
        script.SFX.Died:Play()
        v13.Cover.Position = UDim2.new(-2, 0, 0.5, 0)
        v120 = true
        local v123 = TweenInfo.new(0.2)
        TweenService:Create(v13.Cover, v123, { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
        task.wait(0.6)
        local v124 = TweenInfo.new(0.2)
        TweenService:Create(v13.Cover, v124, { Position = UDim2.new(2.7, 0, 0.5, 0) }):Play()
        task.wait(0.2)
        v120 = false
    end)
end)
for v125, v126 in CollectionService:GetTagged("MonsterEventKillBrick") do
    local Touched = v126.Touched
    Touched:Connect(function(v127) -- line 498 | captures: v13, v120, TweenService, LocalPlayer
        if v127.Parent ~= LocalPlayer.Character or v120 then
            return
        end
        script.SFX.Died:Play()
        v13.Cover.Position = UDim2.new(-2, 0, 0.5, 0)
        v120 = true
        local v128 = TweenInfo.new(0.2)
        TweenService:Create(v13.Cover, v128, { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
        task.wait(0.6)
        local v129 = TweenInfo.new(0.2)
        TweenService:Create(v13.Cover, v129, { Position = UDim2.new(2.7, 0, 0.5, 0) }):Play()
        task.wait(0.2)
        v120 = false
    end)
end
local v130 = {}

function v130.StartEvent(v131, v132) -- line 515 | captures: v12, v13, v15, v20, v21, v22, v23, v24, TweenService, Workspace, Remotes, LightingsController, Lightings, v11, EnsureUI, SetWinPartHidden, InitWinParts, v111
    if not EnsureUI() then
        return
    end
    v11:Clean()
    v12 = true
    v13.Enabled = true
    for v133, v134 in game.Workspace.__OBJECTS.Build["1"].COLLISIONS["COLL GUARD"]["WALL RIGHT (COLL GUARD)"]:GetChildren() do
        if v134:IsA("BasePart") then
            v134.CanCollide = false
            local v135 = v134
            v11:Add(function() -- line 526 | captures: v135
                v135.CanCollide = true
            end)
        end
    end
    task.spawn(function() -- line 531 | captures: v12, v20, Workspace
        local FrozenWallRight = Workspace.__OBJECTS.Build["1"].COLLISIONS["GUARD NO COLLIDE"].PLAYER["WALL RIGHT"].FrozenWallRight
        while v12 do
            FrozenWallRight.CanCollide = v20
            task.wait()
        end
        FrozenWallRight.CanCollide = true
    end)
    workspace.__OBJECTS.Build.MainMap.Bases.SIDE_WALLS.CanCollide = false
    v11:Add(function() -- line 540
        workspace.__OBJECTS.Build.MainMap.Bases.SIDE_WALLS.CanCollide = true
    end)
    v15 = Remotes.MonsterEvent.GetWins:InvokeServer() or {}
    v24()
    local MonsterEvent = Lightings.Directory.MonsterEvent
    LightingsController:SetModifier("MonsterEvent", function() -- line 548 | captures: MonsterEvent
        return MonsterEvent
    end, 25, 2)
    InitWinParts()
    v22 = Remotes.MonsterEvent.GetWinParts:InvokeServer() or {}
    for v136, v137 in v21 do
        local v138 = v23 or v22[v136] == true
        SetWinPartHidden(v137, v138)
    end
    if workspace:GetAttribute("PlayMonsterCutscene") then
        v23 = true
        for v139, v140 in v21 do
            local v141 = v23 or v22[v139] == true
            SetWinPartHidden(v140, v141)
        end
        xpcall(v111.Run, warn)
        v23 = false
        for v142, v143 in v21 do
            local v144 = v23 or v22[v142] == true
            SetWinPartHidden(v143, v144)
        end
    end
    local MonsterEventMap = workspace:FindFirstChild("MonsterEventMap")
    if MonsterEventMap then
        MonsterEventMap.WallStartVisual1.SurfaceGui.Enabled = true
        MonsterEventMap.WallStartVisual2.SurfaceGui.Enabled = true
    end
    local MonsterEventMusic = workspace:FindFirstChild("MonsterEventMusic")
    if MonsterEventMusic then
        local v145 = TweenInfo.new(5)
        TweenService:Create(MonsterEventMusic, v145, { Volume = 0.5 }):Play()
    end
end

function v130.StopEvent(v146) -- line 599 | captures: v12, v13, v15, v22, v23, v24, TweenService, Workspace, LightingsController, v11, LocalPlayer
    v11:Clean()
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        CurrentCamera.CameraType = Enum.CameraType.Custom
        TweenService:Create(CurrentCamera, TweenInfo.new(0), { FieldOfView = 70 }):Play()
        CurrentCamera.FieldOfView = 70
        local Character = LocalPlayer.Character
        local v147 = Character and Character:FindFirstChildOfClass("Humanoid")
        if v147 then
            CurrentCamera.CameraSubject = v147
        end
    end
    v12 = false
    if v13 ~= nil then
        v13.Enabled = false
    end
    v15 = {}
    v24()
    v22 = {}
    v23 = false
    LightingsController:ClearModifier("MonsterEvent", 2)
end

return v130
