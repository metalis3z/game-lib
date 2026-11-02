-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local ClientGlobals = require(ReplicatedStorage.Client.ClientGlobals)
local BUTTON_FX = require(ReplicatedStorage.Shared.Globals.Constants).BUTTON_FX
local InteractSound = require(script.Parent.InteractSound)
local ConsoleSignals = require(ReplicatedStorage.Client.ConsoleSignals)
local CenterAnchor = require(ReplicatedStorage.Shared.Utils.Layout).CenterAnchor
local Trove = require(ReplicatedStorage.Packages.Trove)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    peakHoverScale = 1.06,
    pressedScale = 0.96,
    restingScale = 1,
    scaleInstanceName = "ButtonUIScale",
    ownedScaleAttribute = "ButtonFXOwned",
    muteAttribute = "MuteSounds",
    closeGlyphText = "X",
    pressSoundVolume = 1.8,
    pressedGlyphPosition = UDim2.new(0.5, 0, 0.6, 0),
    restingGlyphPosition = UDim2.new(0.5, 0, 0.5, 0),
    pressSoundId = BUTTON_FX.BUTTON_MOUSE_DOWN_SOUND,
    closeIconImage = BUTTON_FX.BUTTON_CLOSE_SOUND
}
local v2 = {
    press = {
        0.065,
        Enum.EasingStyle.Exponential,
        Enum.EasingDirection.Out
    },
    release = {
        0.16,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    },
    spring = {
        0.16,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    },
    glide = {
        0.16,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    },
    ease = {
        0.16,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    }
}
local v3 = {}

local function noop() -- line 38
end

local v4 = table.freeze({})

local function findCloseGlyph(v5) -- line 40 | captures: v1, v4
    local v6
    if v5:IsA("ImageButton") and v5.Image == v1.closeIconImage then
        v6 = v5:GetChildren()
    else
        v6 = v4
    end
    for v7, v8 in v6 do
        if v8:IsA("TextLabel") and v8.Text == v1.closeGlyphText then
            return v8
        end
    end
    return nil
end

local function adoptScale(v9) -- line 60 | captures: v1
    local UIScale = v9:FindFirstChildOfClass("UIScale")
    if UIScale == nil then
        UIScale = Instance.new("UIScale")
        UIScale.Name = v1.scaleInstanceName
        UIScale.Parent = v9
    end
    return UIScale
end

local function isPress(v10) -- line 70
    if v10.KeyCode == Enum.KeyCode.ButtonA then
        return true
    end
    if v10.UserInputType == Enum.UserInputType.Touch then
        return v10.UserInputState == Enum.UserInputState.Begin
    end
    return v10.UserInputType == Enum.UserInputType.MouseButton1
end

local v11 = {}

v11[Enum.UserInputType.MouseButton1] = true
v11[Enum.UserInputType.Touch] = true

local function isRelease(v12) -- line 85 | captures: v11
    if v11[v12.UserInputType] == true then
        return true
    end
    return v12.KeyCode == Enum.KeyCode.ButtonA
end

local function onDesktop() -- line 89 | captures: ClientGlobals
    return ClientGlobals.Desktop
end

Log.new():AtInfo():Log("gui button feedback wired")
return function(v13, v14, v15, v16) -- line 93 | captures: InteractSound, ConsoleSignals, CenterAnchor, Trove, Tween, t, v1, v2, v3, noop, findCloseGlyph, isPress, isRelease, onDesktop
    t.strict(t.instanceIsA("GuiButton"))(v13)
    t.strict(t.optional(t.number))(v14)
    t.strict(t.optional(t.callback))(v15)
    local v17 = false
    local v18 = false
    local v19 = v14
    if not v14 then
        v19 = v1.peakHoverScale
    end
    local v20 = v16 or v13:GetAttribute(v1.muteAttribute) == true
    if v3[v13] then
        return noop
    end
    v3[v13] = true
    local v21 = Trove.new()
    CenterAnchor(v13)
    local v22 = findCloseGlyph(v13)
    local UIScale
    if v22 then
        local UIScale_2 = v22:FindFirstChildOfClass("UIScale")
        if UIScale_2 == nil then
            UIScale_2 = Instance.new("UIScale")
            UIScale_2.Name = v1.scaleInstanceName
            UIScale_2.Parent = v22
        end
        UIScale = UIScale_2
    end
    local UIScale_2 = v13:FindFirstChildOfClass("UIScale")
    if UIScale_2 == nil then
        UIScale_2 = Instance.new("UIScale")
        UIScale_2.Name = v1.scaleInstanceName
        UIScale_2.Parent = v13
    end
    UIScale_2:SetAttribute(v1.ownedScaleAttribute, true)
    local UIScale_3 = UIScale_2

    local function holdState(v23) -- line 140 | captures: UIScale, v17, v18, v22, UIScale_3, Tween, v1, v2
        if v17 == v23 then
            return
        end
        local v24, v25, v26
        if v23 then
            v25 = v1.pressedScale
            v26 = v1.pressedGlyphPosition
            v24 = v2.press
        else
            v25 = v1.restingScale
            v26 = v1.restingGlyphPosition
            v24 = v2.release
        end
        v17 = v23
        v18 = v18 and not v23
        Tween(UIScale_3, { Scale = v25 }, v24)
        if UIScale and v22 then
            Tween(UIScale, { Scale = v25 }, v24)
            Tween(v22, { Position = v26 }, v24)
        end
    end

    if v15 then
        local Activated = v13.Activated
        v21:Add(Activated:Connect(function() -- line 172 | captures: v13, v15
            if v13.Active then
                v15()
            end
        end))
        local ReleasedButton = ConsoleSignals.ReleasedButton
        v21:Add(ReleasedButton:Connect(function(v27) -- line 177 | captures: v13, v15
            if v27 == v13 and v13.Active then
                v15()
            end
        end))
    end
    local v28 = {}
    local v29 = {
        v13.InputBegan,
        isPress,
        function() -- line 187 | captures: holdState
            holdState(true)
        end
    }
    local v30 = {
        v13.InputEnded,
        isRelease,
        function() -- line 194 | captures: holdState
            holdState(false)
        end
    }
    local v31 = {
        v13.MouseEnter,
        onDesktop,
        function() -- line 201 | captures: UIScale, v17, v18, v19, UIScale_3, Tween, v2
            if not v18 then
                v18 = true
                if not v17 then
                    Tween(UIScale_3, { Scale = v19 }, v2.spring)
                    if UIScale then
                        Tween(UIScale, { Scale = v19 }, v2.glide)
                    end
                end
            end
        end
    }
    local v32 = {
        v13.MouseLeave,
        onDesktop,
        function() -- line 216 | captures: UIScale, v17, v18, v22, UIScale_3, Tween, v1, v2
            if not v18 then
                return
            end
            v18 = false
            if v17 and UIScale and v22 then
                Tween(v22, { Position = v1.restingGlyphPosition }, v2.glide)
            end
            if not v17 then
                Tween(UIScale_3, { Scale = v1.restingScale }, v2.spring)
                if UIScale then
                    Tween(UIScale, { Scale = v1.restingScale }, v2.ease)
                end
            end
        end
    }
    v28[1] = v29
    v28[2] = v30
    v28[3] = v31
    v28[4] = v32
    for v33, v34 in v28 do
        local v35 = v34[2]
        local v36 = v34[3]
        local v37 = v34[1]
        v21:Add(v37:Connect(function(v38) -- line 241 | captures: v13, v35, v36
            if v13.Active and v35(v38) then
                v36()
            end
        end))
    end
    local Active = v13:GetPropertyChangedSignal("Active")
    v21:Add(Active:Connect(function() -- line 248 | captures: UIScale, v17, v18, v13, v22, UIScale_3, Tween, v1, v2
        if v13.Active then
            return
        end
        v17 = false
        v18 = false
        Tween(UIScale_3, { Scale = v1.restingScale }, v2.release)
        if UIScale and v22 then
            Tween(UIScale, { Scale = v1.restingScale }, v2.release)
            Tween(v22, { Position = v1.restingGlyphPosition }, v2.release)
        end
    end))
    if not v20 then
        v21:Add(InteractSound(v13, "mousedown", v1.pressSoundId, v1.pressSoundVolume, true))
    end
    local v39 = false

    local function tearDown() -- line 264 | captures: UIScale, v39, v13, v21, v22, UIScale_3, v1, v3
        if v39 then
            return
        end
        v39 = true
        v21:Destroy()
        if UIScale_3 and UIScale_3.Parent then
            UIScale_3.Scale = v1.restingScale
        end
        if UIScale and v22 then
            v22.Position = v1.restingGlyphPosition
            UIScale.Scale = v1.restingScale
        end
        v3[v13] = nil
    end

    v21:Add(v13.Destroying:Connect(tearDown))
    return tearDown
end
