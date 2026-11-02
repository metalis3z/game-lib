-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local BUTTON_FX = require(ReplicatedStorage.Shared.Globals.Constants).BUTTON_FX
local CenterAnchor = require(ReplicatedStorage.Shared.Utils.Layout).CenterAnchor
local ClientGlobals = require(ReplicatedStorage.Client.ClientGlobals)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local v1 = {
    hoverScale = 1.05,
    pressedScale = 0.97,
    restingScale = 1
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
    }
}
local v3 = {}

local function noop() -- line 20
end

local function adoptScale(v4) -- line 21
    local UIScale = v4:FindFirstChildOfClass("UIScale")
    if UIScale == nil then
        UIScale = Instance.new("UIScale")
        UIScale.Name = "ButtonUIScale"
        UIScale.Parent = v4
    end
    return UIScale
end

local function isPress(v5) -- line 31
    if v5.UserInputType == Enum.UserInputType.MouseButton1 then
        return true
    end
    if v5.UserInputType == Enum.UserInputType.Touch then
        return v5.UserInputState == Enum.UserInputState.Begin
    end
    return false
end

local function isRelease(v6) -- line 35
    if v6.UserInputType == Enum.UserInputType.MouseButton1 then
        return true
    end
    return v6.UserInputType == Enum.UserInputType.Touch
end

return function(v7, v8, v9) -- line 39 | captures: Audio, BUTTON_FX, CenterAnchor, ClientGlobals, Trove, Tween, v2, v3, noop
    if v3[v7] then
        return noop
    end
    v3[v7] = true
    v7.Active = true
    CenterAnchor(v7)
    local v10 = v8 or 1.05
    local UIScale = v7:FindFirstChildOfClass("UIScale")
    if UIScale == nil then
        UIScale = Instance.new("UIScale")
        UIScale.Name = "ButtonUIScale"
        UIScale.Parent = v7
    end
    local v11 = Trove.new()
    local v12 = false
    local v13 = false
    local v14 = false
    local v15, TextButton
    if v7:IsA("GuiButton") then
        v15 = v7
        TextButton = v7
    else
        TextButton = Instance.new("TextButton")
        TextButton.Name = "SurfaceButtonInput"
        TextButton.AutoButtonColor = false
        TextButton.BackgroundTransparency = 1
        TextButton.Text = ""
        TextButton.TextTransparency = 1
        TextButton.Size = UDim2.fromScale(1, 1)
        local v16 = v7.ZIndex + 100
        TextButton.ZIndex = math.min(v16, 10000)
        TextButton.Parent = v7
        v15 = TextButton
        v14 = true
    end
    TextButton.Active = v7.Active
    TextButton.Selectable = v7.Active
    local UIScale_2 = UIScale

    local function restingOrHover() -- line 77 | captures: v13, v10, UIScale_2, Tween, v2
        local v17 = {}
        if v13 then
            v17.Scale = v10
        else
            v17.Scale = 1
        end
        Tween(UIScale_2, v17, v2.spring)
    end

    local InputBegan = TextButton.InputBegan
    v11:Add(InputBegan:Connect(function(v18) -- line 88 | captures: v12, v7, UIScale_2, Audio, BUTTON_FX, Tween, v2
        if not (v7.Active and (v18.UserInputType == Enum.UserInputType.MouseButton1 or v18.UserInputType == Enum.UserInputType.Touch and v18.UserInputState == Enum.UserInputState.Begin)) then
            return
        end
        v12 = true
        Tween(UIScale_2, { Scale = 0.97 }, v2.press)
        Audio.Play(BUTTON_FX.BUTTON_MOUSE_DOWN_SOUND, v7, {
            Volume = 1.8,
            PlaybackSpeed = math.random(95, 105) / 100
        })
    end))
    local InputEnded = TextButton.InputEnded
    v11:Add(InputEnded:Connect(function(v19) -- line 98 | captures: v12, v13, v10, UIScale_2, Tween, v2
        if v19.UserInputType ~= Enum.UserInputType.MouseButton1 and v19.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        v12 = false
        local v20 = {}
        if v13 then
            v20.Scale = v10
        else
            v20.Scale = 1
        end
        Tween(UIScale_2, v20, v2.spring)
    end))
    local Activated = TextButton.Activated
    v11:Add(Activated:Connect(function() -- line 114 | captures: v7, v9
        if v7.Active and v9 then
            v9()
        end
    end))
    local MouseEnter = TextButton.MouseEnter
    v11:Add(MouseEnter:Connect(function() -- line 119 | captures: v12, v13, v7, v10, UIScale_2, ClientGlobals, Tween, v2
        local v21, v22, v23
        if v7.Active and ClientGlobals.Desktop then
            v13 = true
            if v12 then
                v23 = true
            else
                v21 = {}
                if v13 then
                    v22 = v10
                else
                    v22 = 1
                end
                v23 = false
            end
        else
            v23 = true
        end
        if not v23 then
            v21.Scale = v22
            Tween(UIScale_2, v21, v2.spring)
        end
    end))
    local MouseLeave = TextButton.MouseLeave
    v11:Add(MouseLeave:Connect(function() -- line 135 | captures: v12, v13, v10, UIScale_2, Tween, v2
        v13 = false
        v12 = false
        local v24 = {}
        if v13 then
            v24.Scale = v10
        else
            v24.Scale = 1
        end
        Tween(UIScale_2, v24, v2.spring)
    end))
    local Active = v7:GetPropertyChangedSignal("Active")
    v11:Add(Active:Connect(function() -- line 149 | captures: v15, v12, v13, v7, v10, UIScale_2, Tween, v2
        v15.Active = v7.Active
        v15.Selectable = v7.Active
        if v7.Active then
            return
        end
        v13 = false
        v12 = false
        local v25 = {}
        if v13 then
            v25.Scale = v10
        else
            v25.Scale = 1
        end
        Tween(UIScale_2, v25, v2.spring)
    end))
    return function() -- line 166 | captures: v15, v14, v7, v11, UIScale_2, v3
        v3[v7] = nil
        v11:Destroy()
        if v14 then
            v15:Destroy()
        end
        if UIScale_2.Parent then
            UIScale_2.Scale = 1
        end
    end
end
