-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Normal = require(ReplicatedStorage.Data.Sounds.Languages.Alphabet).Normal
local v1 = {}

v1.__index = v1
v1.__class = "MessageTyper"

local function splitGlyphs(v2) -- line 14
    local v3 = string.gsub(v2, "<.->", "")
    local v4 = {}
    for v5, v6 in utf8.graphemes(v3) do
        v4[#v4 + 1] = string.sub(v3, v5, v6)
    end
    return v4
end

local function voiceGlyph(v7, v8) -- line 22 | captures: ReplicatedFirst, Audio, Normal
    if v7 ~= " " then
        local v9 = Normal[string.lower(v7)]
        if v9 then
            local v10 = v9.Sound:Clone()
            Audio.PlaySound(v10, v9.Sound.Parent)
        else
            Audio.Play(v8, ReplicatedFirst)
        end
    end
end

function v1.new(v11, v12, v13, v14) -- line 34 | captures: v1
    local v15 = {}
    local v16 = setmetatable(v15, v1)
    v16.label = v11
    v16.run = 0
    v16.clickSound = v12 or "rbxassetid://129229071560354"
    v16.clicksOn = v14 ~= false
    v16.pace = v13 or 0.09
    v16.driver = nil
    v16.watcher = nil
    v16.sweep = nil
    return v16
end

local function Halt(v17) -- line 48
    v17.run += 1
    local sweep = v17.sweep
    if sweep then
        sweep:Cancel()
        v17.sweep = nil
    end
    local watcher = v17.watcher
    if watcher then
        watcher:Disconnect()
        v17.watcher = nil
    end
    local driver = v17.driver
    if driver then
        driver:Destroy()
        v17.driver = nil
    end
    v17.label.MaxVisibleGraphemes = -1
end

v1.Halt = Halt

local function Blank(v18) -- line 67
    v18:Halt()
    v18.label.Text = ""
end

v1.Blank = Blank

local function ShowAll(v19, v20, v21) -- line 71
    local label = v19.label
    if label.Text == v20 and label.TextColor3 == v21 and label.MaxVisibleGraphemes == -1 then
        return
    end
    v19:Halt()
    label.RichText = true
    label.Text = v20
    label.TextColor3 = v21
    label.MaxVisibleGraphemes = -1
end

v1.ShowAll = ShowAll

function v1.Type(v22, v23, v24) -- line 83 | captures: ReplicatedFirst, TweenService, Audio, Normal, splitGlyphs
    local label = v22.label
    if label.Text == v23 then
        if label.TextColor3 ~= v24 then
            v22:Halt()
            v22.run += 1
            local run = v22.run
            label.RichText = true
            label.Text = v23
            label.TextColor3 = v24
            local v25 = splitGlyphs(v23)
            local v26 = v25
            local v27 = #v25
            local v28 = v27
            if v27 <= 0 then
                label.MaxVisibleGraphemes = -1
            else
                label.MaxVisibleGraphemes = 0
                local NumberValue = Instance.new("NumberValue")
                local NumberValue_2 = NumberValue
                NumberValue.Value = 0
                v22.driver = NumberValue
                local v29 = 0
                local Value = NumberValue:GetPropertyChangedSignal("Value")
                v22.watcher = Value:Connect(function() -- line 178 | captures: NumberValue_2, run, v26, v28, v29, v22, label, ReplicatedFirst, Audio, Normal
                    if run ~= v22.run then
                        return
                    end
                    local v30 = NumberValue_2.Value + 0.5
                    local v31 = math.floor(v30)
                    local v32 = v28
                    local v33 = math.clamp(v31, 0, v32)
                    if v33 == v29 then
                        return
                    end
                    label.MaxVisibleGraphemes = v33
                    if v22.clicksOn then
                        local v34 = v29 + 1
                        for v35 = v34, v33 do
                            local v36 = v26[v35]
                            if v36 and v36 ~= " " then
                                local v37 = Normal[string.lower(v36)]
                                if v37 then
                                    local v38 = v37.Sound:Clone()
                                    Audio.PlaySound(v38, v37.Sound.Parent)
                                else
                                    Audio.Play(v22.clickSound, ReplicatedFirst)
                                end
                            end
                        end
                    end
                    v29 = v33
                end)
                local new = TweenInfo.new
                local pace = v22.pace
                local v39 = new(v28 * pace)
                local v40 = TweenService:Create(NumberValue_2, v39, { Value = v28 })
                v22.sweep = v40
                v40.Completed:Connect(function() -- line 210 | captures: run, v22, label
                    if run ~= v22.run then
                        return
                    end
                    label.MaxVisibleGraphemes = -1
                    local watcher = v22.watcher
                    if watcher then
                        watcher:Disconnect()
                        v22.watcher = nil
                    end
                    local driver = v22.driver
                    if driver then
                        driver:Destroy()
                        v22.driver = nil
                    end
                    v22.sweep = nil
                end)
                v40:Play()
            end
        end
    else
        v22:Halt()
        v22.run += 1
        local run = v22.run
        label.RichText = true
        label.Text = v23
        label.TextColor3 = v24
        local v41 = splitGlyphs(v23)
        local v42 = v41
        local v43 = #v41
        local v44 = v43
        if v43 <= 0 then
            label.MaxVisibleGraphemes = -1
        else
            label.MaxVisibleGraphemes = 0
            local NumberValue = Instance.new("NumberValue")
            local NumberValue_2 = NumberValue
            NumberValue.Value = 0
            v22.driver = NumberValue
            local v45 = 0
            local Value = NumberValue:GetPropertyChangedSignal("Value")
            v22.watcher = Value:Connect(function() -- line 105 | captures: v22, label, ReplicatedFirst, Audio, Normal, run, v42, v44, NumberValue_2, v45
                if run ~= v22.run then
                    return
                end
                local v46 = NumberValue_2.Value + 0.5
                local v47 = math.floor(v46)
                local v48 = v44
                local v49 = math.clamp(v47, 0, v48)
                if v49 == v45 then
                    return
                end
                label.MaxVisibleGraphemes = v49
                if v22.clicksOn then
                    local v50 = v45 + 1
                    for v51 = v50, v49 do
                        local v52 = v42[v51]
                        if v52 and v52 ~= " " then
                            local v53 = Normal[string.lower(v52)]
                            if v53 then
                                local v54 = v53.Sound:Clone()
                                Audio.PlaySound(v54, v53.Sound.Parent)
                            else
                                Audio.Play(v22.clickSound, ReplicatedFirst)
                            end
                        end
                    end
                end
                v45 = v49
            end)
            local new = TweenInfo.new
            local pace = v22.pace
            local v55 = new(v44 * pace)
            local v56 = TweenService:Create(NumberValue_2, v55, { Value = v44 })
            v22.sweep = v56
            v56.Completed:Connect(function() -- line 137 | captures: v22, label, run
                if run ~= v22.run then
                    return
                end
                label.MaxVisibleGraphemes = -1
                local watcher = v22.watcher
                if watcher then
                    watcher:Disconnect()
                    v22.watcher = nil
                end
                local driver = v22.driver
                if driver then
                    driver:Destroy()
                    v22.driver = nil
                end
                v22.sweep = nil
            end)
            v56:Play()
        end
    end
end

return v1
