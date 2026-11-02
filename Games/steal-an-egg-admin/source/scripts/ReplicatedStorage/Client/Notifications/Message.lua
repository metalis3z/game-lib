-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local NotificationInstance = require(script.Parent.NotificationInstance)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local t = require(ReplicatedStorage.Packages.t)
local Message = ReplicatedStorage.Assets.UI.Notifications.Bottom.Message
local v1 = { 0.9, 1.1 }
local v2 = { 0.8, 1.2 }
local v3 = UDim2.fromScale(1, 1)
local v4 = UDim2.fromScale(0.5, 1)
local v5 = Vector2.new(0.5, 1)
local v6 = { 3.1, "Sine", "Out" }
local v7 = t.interface({
    Text = t.optional(t.string),
    Color = t.optional(t.Color3),
    StrokeColor = t.optional(t.Color3)
})
local v8 = t.interface({
    Message = t.string,
    Time = t.number,
    Color = t.optional(t.Color3),
    Sound = t.optional(t.union(t.string, t.number)),
    Gradient = t.optional(t.instanceIsA("UIGradient")),
    Segments = t.optional(t.table),
    Image = t.optional(t.string),
    WrapText = t.optional(t.boolean),
    SingleLine = t.optional(t.boolean),
    DelayInRound = t.optional(t.boolean),
    PreText = t.optional(v7)
})
local v9 = t.strict(t.string)
local v10 = t.strict(t.optional(t.Color3))
local v11 = {}

local function seatIcon(v12, v13, v14) -- line 37 | captures: v3, v4, v5
    if v14 == nil or v14 < 2 then
        return
    end
    local UIAspectRatioConstraint = v13:FindFirstChildOfClass("UIAspectRatioConstraint")
    local v15 = if UIAspectRatioConstraint then UIAspectRatioConstraint.AspectRatio else 1
    local IconSlot = v12:FindFirstChild("IconSlot")
    if IconSlot then
        if not IconSlot:IsA("Frame") then
            IconSlot = Instance.new("Frame")
            IconSlot.Name = "IconSlot"
            IconSlot.BackgroundTransparency = 1
            IconSlot.BorderSizePixel = 0
            IconSlot.Parent = v12
            local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
            UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
            UIAspectRatioConstraint.Parent = IconSlot
        end
    else
        IconSlot = Instance.new("Frame")
        IconSlot.Name = "IconSlot"
        IconSlot.BackgroundTransparency = 1
        IconSlot.BorderSizePixel = 0
        IconSlot.Parent = v12
        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
        UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
        UIAspectRatioConstraint.Parent = IconSlot
    end
    local UIAspectRatioConstraint_2 = IconSlot:FindFirstChildOfClass("UIAspectRatioConstraint")
    if UIAspectRatioConstraint_2 then
        UIAspectRatioConstraint_2.AspectRatio = v15 * 1.125 / v14
    end
    IconSlot.Size = v3
    IconSlot.LayoutOrder = v13.LayoutOrder
    IconSlot.ZIndex = v13.ZIndex
    v13.Parent = IconSlot
    v13.AnchorPoint = v5
    v13.Position = v4
    v13.Size = UDim2.fromScale(1, 1.125 / v14)
end

local function plateRoom(v16, v17, v18) -- line 82
    local UIScale = v16:FindFirstChildOfClass("UIScale")
    local v19
    if UIScale == nil then
        v19 = 1
    elseif UIScale.Scale > 0 then
        v19 = UIScale.Scale
    end
    local UIListLayout = v17:FindFirstChildOfClass("UIListLayout")
    local v20 = v17.AbsoluteSize.X / v19
    for v21, v22 in v17:GetChildren() do
        if v22:IsA("GuiObject") and v22.Visible and table.find(v18, v22) == nil then
            local v23 = if UIListLayout then UIListLayout.Padding.Offset else 0
            v20 -= v22.AbsoluteSize.X / v19 + v23
        end
    end
    return v20, v17.AbsoluteSize.Y / v19
end

local function measureLine(v24, v25) -- line 105 | captures: TextService
    local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
    GetTextBoundsParams.Text = v24.ContentText
    GetTextBoundsParams.Font = v24.FontFace
    GetTextBoundsParams.Size = v25
    GetTextBoundsParams.Width = 0
    local v26, v27 = pcall(function() -- line 112 | captures: GetTextBoundsParams, TextService
        return TextService:GetTextBoundsAsync(GetTextBoundsParams)
    end)
    if v26 and typeof(v27) == "Vector2" and not (v27.X <= 0) then
        return v27.X
    end
    return nil
end

local function fitSingleLine(v28, v29, v30) -- line 120 | captures: measureLine
    if v29 <= 0 or v30 <= 0 then
        return false
    end
    local v31 = 0
    for v32, v33 in v28 do
        if v33.Visible then
            local v34 = measureLine(v33, v30)
            if v34 == nil then
                for v35, v36 in v28 do
                    v36.TextWrapped = true
                    v36.TextScaled = true
                end
                return true
            end
            v31 += v34
        end
    end
    local v37 = if v31 <= 0 then v30 else v30 * (v29 * 0.97) / v31
    local v38 = math.min(v30, v37)
    local v39 = math.floor(v38)
    local v40 = math.max(v39, 12)
    for v41, v42 in v28 do
        v42.TextSize = v40
    end
    return true
end

local function resolvePreTextLabel(v43, v44) -- line 160
    local PreText = v43:FindFirstChild("PreText")
    if PreText then
        if PreText:IsA("TextLabel") then
            return PreText
        end
        local v45 = v44:Clone()
        v45.Name = "PreText"
        v45.Parent = v43
        return v45
    end
    local v46 = v44:Clone()
    v46.Name = "PreText"
    v46.Parent = v43
    return v46
end

local function toLowerHex(v47) -- line 177
    local v48, v49 = pcall(function() -- line 179 | captures: v47
        return v47:ToHex()
    end)
    if v48 then
        return (string.lower(v49))
    end
    return nil
end

local function playSound(v50, v51) -- line 187 | captures: Audio, v1, v2
    if v50.Sound then
        Audio.Play(v50.Sound, script, { PlaybackSpeed = v1 })
    elseif v51 == "ff0000" then
        Audio.Play(17208372272, script)
    else
        Audio.Play("rbxassetid://79565598720799", script, {
            Volume = 0.6,
            PlaybackSpeed = v2
        })
    end
end

function v11.Compose(v52, v53, v54) -- line 198 | captures: v9, v10
    v9(v52)
    v10(v53)
    v10(v54)
    local v55 = v54 and v54:ToHex() or "000000"
    if v53 then
        return ("<stroke color=\"#%s\" joins=\"bevel\" thickness=\"3\" transparency=\"0\"><font color=\"#%s\">%s</font></stroke>"):format(v55, v53:ToHex(), v52)
    end
    return ("<stroke color=\"#%s\" joins=\"bevel\" thickness=\"3\" transparency=\"0\">%s</stroke>"):format(v55, v52)
end

local function dress(v56) -- line 217 | captures: RunService, Tween, Message, v6, v8, v11, seatIcon, plateRoom, fitSingleLine, playSound
    local function v57(...)
        assert(...)
    end

    local Color
    v57(v8(v56))
    local v58 = Message:Clone()
    local Shadow = v58.Shadow
    local Frame = v58.Frame
    local TextLabel = Frame.TextLabel
    local UIStroke = TextLabel:FindFirstChild("UIStroke")
    local PreText = Frame:FindFirstChild("PreText")
    if PreText then
        if not PreText:IsA("TextLabel") then
            PreText = nil
        end
    else
        PreText = TextLabel:Clone()
        PreText.Name = "PreText"
        PreText.Parent = Frame
    end
    local v59 = TextLabel.LayoutOrder - 1
    PreText.LayoutOrder = math.max(v59, 0)
    PreText.ZIndex = TextLabel.ZIndex
    if not v56.Color then
        v56.Color = Color3.fromRGB(255, 255, 255)
    end
    local v60
    if v56.Color then
        Color = v56.Color
        local v61, v62 = pcall(function() -- line 245 | captures: Color
            return Color:ToHex()
        end)
        if v61 then
            v60 = string.lower(v62)
        end
    end
    if v56.Size then
        v58.Size = v56.Size
    end
    if v56.Gradient then
        v56.Gradient:Clone().Parent = TextLabel
    end
    Shadow.Visible = not not v56.ShowShadow
    TextLabel.Text = v11.Compose(v56.Message, v56.Color, v56.StrokeColor)
    TextLabel.TextColor3 = v56.Color or TextLabel.TextColor3
    if UIStroke and v56.StrokeColor then
        UIStroke.Color = v56.StrokeColor
    end
    PreText.TextColor3 = TextLabel.TextColor3
    local PreText_2 = v56.PreText
    if PreText_2 then
        PreText.Text = v11.Compose(PreText_2.Text, PreText_2.Color, PreText_2.StrokeColor)
        PreText.Visible = PreText.Text ~= ""
    else
        PreText.Text = ""
        PreText.Visible = false
    end
    local v63 = { TextLabel }
    if v56.Segments then
        local v64 = v56.Segments[1]
        if v64 then
            TextLabel.Text = v11.Compose(v64.Text, v64.Color, v64.StrokeColor)
            if v64.Color then
                TextLabel.TextColor3 = v64.Color
            end
            if v64.Gradient then
                v64.Gradient:Clone().Parent = TextLabel
            end
        end
        local v65 = #v56.Segments
        for v66 = 2, v65 do
            local v67 = v56.Segments[v66]
            local v68 = TextLabel:Clone()
            for v69, v70 in v68:GetChildren() do
                if v70:IsA("UIGradient") then
                    v70:Destroy()
                end
            end
            v68.Name = ("Segment%d"):format(v66)
            v68.LayoutOrder = TextLabel.LayoutOrder + v66 - 1
            v68.Text = v11.Compose(v67.Text, v67.Color, v67.StrokeColor)
            if v67.Color then
                v68.TextColor3 = v67.Color
            end
            local UIStroke = v68:FindFirstChildOfClass("UIStroke")
            if UIStroke and v67.StrokeColor then
                UIStroke.Color = v67.StrokeColor
            end
            if v67.Gradient then
                v67.Gradient:Clone().Parent = v68
            end
            v68.Parent = Frame
            table.insert(v63, v68)
        end
    end
    local v71 = table.clone(v63)
    if PreText then
        table.insert(v71, PreText)
    end
    if v56.Font then
        TextLabel.FontFace = v56.Font
    end
    if v56.SingleLine then
        TextLabel.TextScaled = false
        TextLabel.TextWrapped = false
        PreText.TextScaled = false
        PreText.TextWrapped = false
    end
    if v56.Image then
        local Icon = v58.Frame:FindFirstChild("Icon")
        if Icon and Icon:IsA("ImageLabel") then
            Icon.Image = v56.Image
            Icon.Visible = true
            seatIcon(Frame, Icon, v56.IconLines)
        end
    end
    return v58,
        function() -- line 343 | captures: v60, v56, v58, Shadow, Frame, TextLabel, v63, v71, RunService, Tween, v6, plateRoom, fitSingleLine, playSound
            playSound(v56, v60)
            if v56.SingleLine then
                local function fit() -- line 346 | captures: v58, Frame, v71, plateRoom, fitSingleLine
                    local v72, v73 = plateRoom(v58, Frame, v71)
                    return (fitSingleLine(v71, v72, v73))
                end

                local v74, v75 = plateRoom(v58, Frame, v71)
                if not fitSingleLine(v71, v74, v75) then
                    task.spawn(function() -- line 352 | captures: v58, Frame, v71, RunService, plateRoom, fitSingleLine
                        RunService.RenderStepped:Wait()
                        if v58.Parent ~= nil then
                            local v76, v77 = plateRoom(v58, Frame, v71)
                            fitSingleLine(v71, v76, v77)
                        end
                    end)
                end
            elseif v56.WrapText then
                task.spawn(function() -- line 360 | captures: v58, Frame, TextLabel, v63, RunService, plateRoom
                    RunService.RenderStepped:Wait()
                    if v58.Parent == nil then
                        return
                    end
                    local v78 = plateRoom(v58, Frame, v63)
                    local UISizeConstraint = Instance.new("UISizeConstraint")
                    local v79 = math.max(v78, 120)
                    UISizeConstraint.MaxSize = Vector2.new(v79, (1/0))
                    UISizeConstraint.Parent = TextLabel
                end)
            end
            task.spawn(function() -- line 372 | captures: v58, Shadow, Tween, v6
                task.wait(0.65)
                if v58 and Shadow then
                    Tween(Shadow, { ImageTransparency = 1 }, v6)
                end
            end)
        end
end

local function present(v80, v81, v82) -- line 381 | captures: NotificationInstance, dress
    local v83
    if v82 then
        v83 = table.clone(v82)
    else
        v83 = {}
    end
    local OnAppear = v83.OnAppear
    local OnComplete = v83.OnComplete
    v83.Time = v81.Time
    v83.DelayInRound = v81.DelayInRound
    if v83.PreventDuplicateText then
        v83.DuplicateKey = v81.Message
    end
    v83.OnAppear = nil
    v83.OnComplete = nil
    local v84, v85 = dress(v81)
    return NotificationInstance.Enqueue(v80, v84, function(v86) -- line 398 | captures: OnAppear, v85
        v85()
        if typeof(OnAppear) == "function" then
            OnAppear(v86)
        end
    end, v83, function(v87) -- line 403 | captures: OnComplete
        if typeof(OnComplete) == "function" then
            OnComplete(v87)
        end
    end)
end

function v11.Bottom(v88, v89) -- line 409 | captures: NotificationInstance, present
    return present(NotificationInstance.Locations.Bottom, v88, v89)
end

function v11.Top(v90, v91) -- line 412 | captures: NotificationInstance, present
    return present(NotificationInstance.Locations.Message, v90, v91)
end

return v11
