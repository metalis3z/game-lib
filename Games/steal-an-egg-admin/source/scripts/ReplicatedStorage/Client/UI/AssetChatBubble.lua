-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local EnsureScale = require(ReplicatedStorage.Shared.Utils.Layout).EnsureScale
local MessageTyper = require(ReplicatedStorage.Client.UI.MessageTyper)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local Weld = require(ReplicatedStorage.Shared.Utils.Instances).Weld
local v1 = Vector2.new(1084, 144)
local v2 = Vector2.new(251, 72)
local v3 = Vector2.new(213.84, 56.4)
local v4 = TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local v5 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v6 = t.strict(t.instanceIsA("Model"))
local v7 = t.strict(t.instanceIsA("BasePart"))
local v8 = t.strict(t.boolean)
local v9 = t.strict(t.string)
local v10 = {}

v10.__index = v10
v10.__class = "AssetChatBubble"

local ChatBubble = ReplicatedStorage.Assets.Billboards.ChatBubble
local Frame = ChatBubble.Frame
local BillboardGui = ChatBubble:IsA("BillboardGui") and Frame:IsA("Frame") and Frame.TextLabel:IsA("TextLabel")
assert(BillboardGui, "the chat bubble blueprint has the wrong instance shape")
local v11 = true

local function claimAdornee(v12) -- line 37 | captures: Weld
    local adornee = v12.adornee
    if adornee == nil then
        local proxied = v12.proxied
        assert(proxied, "a bubble without an adornee must have been built in proxy mode")
        local Part = Instance.new("Part")
        Part.Name = "AssetBubbleProxy"
        Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
        Part.Transparency = 1
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.Anchored = false
        Part.Massless = true
        Part.CFrame = v12.centre.CFrame + Vector3.new(0, -1, 0)
        Part.Parent = v12.model
        Weld(v12.centre, Part)
        v12.lifetime:Add(Part)
        v12.adornee = Part
        return Part
    end
    return adornee
end

local function tearDown(v13, v14) -- line 59
    local showing = v13.showing
    if showing ~= nil and (v14 == nil or showing == v14) then
        v13.showing = nil
        showing:Destroy()
    end
end

local function widenToFit(v15, v16, v17) -- line 75 | captures: TextService, v1, v2, v3
    local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
    GetTextBoundsParams.Font = v16.FontFace
    GetTextBoundsParams.Size = v3.Y
    GetTextBoundsParams.Width = 10000
    GetTextBoundsParams.Text = v17
    local v18 = TextService:GetTextBoundsAsync(GetTextBoundsParams)
    GetTextBoundsParams:Destroy()
    local v19 = v18.Y > 0
    assert(v19, "measured chat bubble text has no height")
    local Size = v15.Size
    local v20 = if Size.X.Offset == 0 then Size.Y.Offset == 0 else false
    assert(v20, "the chat bubble frame must be sized purely in scale")
    local X = v2.X
    local v21 = v18.X + (v2.X - v3.X)
    local v22 = math.max(X, v21)
    v15.Size = UDim2.fromScale(v22 / v1.X, Size.Y.Scale)
end

function v10.new(v23, v24, v25) -- line 91 | captures: Trove, v6, v7, v8, v10
    v6(v23)
    v7(v24)
    v8(v25)
    local v26 = {}
    local v27 = setmetatable(v26, v10)
    v27.lifetime = Trove.new()
    v27.showing = nil
    v27.model = v23
    v27.centre = v24
    if v25 then
        v27.adornee = nil
    else
        v27.adornee = v24
    end
    local v28 = v24.Size.X / 0.49799999594688416
    local v29 = v24.Size.Y / 0.4440000057220459
    v27.sizeFactor = math.max(v28, v29)
    v27.proxied = v25
    v27.muted = false
    return v27
end

local function Destroy(v30) -- line 112
    local showing = v30.showing
    if showing ~= nil then
        v30.showing = nil
        showing:Destroy()
    end
    v30.lifetime:Destroy()
end

v10.Destroy = Destroy

function v10.PinAbove(v31) -- line 124 | captures: v11, v8
    v8(v31)
    v11 = v31
end

function v10.Mute(v32, v33) -- line 128 | captures: v8
    v8(v33)
    if v32.muted ~= v33 then
        v32.muted = v33
        if v33 then
            local showing = v32.showing
            if showing ~= nil then
                v32.showing = nil
                showing:Destroy()
            end
        end
    end
end

function v10.Say(v34, v35, v36) -- line 142 | captures: v11, TweenService, EnsureScale, MessageTyper, Trove, v4, v5, v9, ChatBubble, claimAdornee, widenToFit
    v9(v35)
    if v34.muted then
        if v36 ~= nil then
            v36()
        end
    else
        local showing = v34.showing
        if showing ~= nil then
            v34.showing = nil
            showing:Destroy()
        end
        local v37 = ChatBubble:Clone()
        local Frame = v37.Frame
        local TextLabel = Frame.TextLabel
        local Frame_2 = Frame:IsA("Frame")
        assert(Frame_2, "the cloned chat bubble lost its Frame")
        local TextLabel_2 = TextLabel:IsA("TextLabel")
        assert(TextLabel_2, "the cloned chat bubble lost its TextLabel")
        local Size = v37.Size
        v37.Size = UDim2.new(Size.X.Scale * v34.sizeFactor, Size.X.Offset * v34.sizeFactor, Size.Y.Scale * v34.sizeFactor, Size.Y.Offset * v34.sizeFactor)
        Frame.AutomaticSize = Enum.AutomaticSize.None
        v37.Adornee = claimAdornee(v34)
        v37.AlwaysOnTop = v11
        v37.Parent = v34.model
        v37.Enabled = true
        TextLabel.Text = ""
        local v38 = Trove.new()
        v34.showing = v38
        v38:Add(v37)
        local spawn = task.spawn
        v38:Add(spawn(function() -- line 180 | captures: v34, v35, v36, Frame, TextLabel, v38, TweenService, EnsureScale, MessageTyper, v4, v5, widenToFit
            if v34.showing == v38 then
                widenToFit(Frame, TextLabel, v35)
                if v34.showing == v38 then
                    local v39 = EnsureScale(Frame)
                    v39.Scale = 0
                    local v40 = MessageTyper.new(TextLabel, nil, nil, false)
                    v38:Add(function() -- line 192 | captures: v40
                        v40:Halt()
                    end)
                    local v41 = TweenService:Create(v39, v4, { Scale = 1 })
                    v38:Add(v41)
                    local delay = task.delay
                    v38:Add(delay(4, function() -- line 198 | captures: v39, v34, v36, v38, TweenService, v5
                        if v34.showing ~= v38 then
                            return
                        end
                        local v42 = TweenService:Create(v39, v5, { Scale = 0 })
                        v38:Add(v42)
                        v38:Add(v42.Completed:Connect(function() -- line 205 | captures: v34, v36, v38
                            if v34.showing ~= v38 then
                                return
                            end
                            local showing = v34.showing
                            if showing ~= nil and (v38 == nil or showing == v38) then
                                v34.showing = nil
                                showing:Destroy()
                            end
                            if v36 ~= nil then
                                v36()
                            end
                        end))
                        v42:Play()
                    end))
                    task.delay(0.2, function() -- line 217 | captures: v40, v34, v35, TextLabel, v38
                        if v34.showing == v38 then
                            v40:Type(v35, TextLabel.TextColor3)
                        end
                    end)
                    v41:Play()
                end
            end
        end))
    end
end

return v10
