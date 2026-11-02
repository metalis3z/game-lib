-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Debris = game:GetService("Debris")
local GamepadService = game:GetService("GamepadService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local v1 = {
    Response_UI = true,
    Talk_UI = true
}
local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local v3 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local Talk_UI = ReplicatedStorage.Assets.UI.Npcs.Talk_UI
local Response_UI = ReplicatedStorage.Assets.UI.Npcs.Response_UI
local Option_UI = ReplicatedStorage.Assets.UI.Npcs.Option_UI
local Response_Text = SoundService.Response_Text
local v4 = {}
task.wait(1)

local function jitter(v5) -- line 20
    return 1 + math.random(-v5, v5) / 100
end

local function eachScript(v6, v7) -- line 23
    for v8, v9 in v6:GetDescendants() do
        if v9:IsA("BaseScript") then
            v7(v9)
        end
    end
end

local function switchOn(v10) -- line 30
    v10.Enabled = true
end

local function discard(v11) -- line 33
    v11:Destroy()
end

local function revealNpcText(v12, v13) -- line 36 | captures: SoundService
    local v14 = v12.Text:gsub("<.->", "")
    local v15 = string.len(v14)
    local v16
    if v13 then
        v16 = SoundService.NPC_SFX:FindFirstChild(v13)
    else
        v16 = SoundService.NPC_Text
    end
    v12.MaxVisibleGraphemes = 0
    while true do
        if v15 >= 1 then
            task.wait()
            if v16.TimePosition > 0.07 then
                v16.TimePosition = 0
                v16.Playing = true
                v16.PlaybackSpeed = 1 + math.random(-5, 5) / 100
            elseif v16.Playing == false then
            end
        else
            break
        end
        v15 -= 1
        v12.MaxVisibleGraphemes += 1
    end
end

local function revealPlayerText(v17) -- line 58 | captures: Debris, SoundService, Response_Text
    local v18 = v17.Text:gsub("<.->", "")
    local v19 = string.len(v18)
    v17.MaxVisibleGraphemes = 0
    local v20 = v19
    while true do
        local v21
        if v20 >= 1 then
            task.wait()
            local v22 = v20 / 3
            v21 = math.floor(v22) * 3 == v20
        else
            break
        end
        if v21 then
            local v23 = Response_Text:Clone()
            v23.Parent = SoundService
            v23.Name = "SFX"
            v23.PlaybackSpeed = 1 + math.random(-15, 15) / 100
            v23.Playing = true
            Debris:AddItem(v23, v23.TimeLength * v23.PlaybackSpeed)
        elseif v20 == v19 then
        end
        v20 -= 1;
        (nil).MaxVisibleGraphemes = (nil).MaxVisibleGraphemes + 1
    end
end

local function restockScripts(v24, v25, v26) -- line 79
    for v27, v28 in v24:GetDescendants() do
        if v28:IsA("BaseScript") then
            for v29, v30 in v25:GetDescendants() do
                if v30.Name == v28.Parent.Name then
                    if v26 then
                        v28.Enabled = false
                    end
                    local v31 = v28:Clone()
                    v31.Parent = v30
                    v31.Enabled = true
                end
            end
        end
    end
end

local function raiseBubble(v32, v33, v34, v35, v36, v37, v38) -- line 97 | captures: Talk_UI, eachScript, switchOn, discard, revealNpcText, revealPlayerText, restockScripts
    local Head = v33.Head
    local v39 = Head:FindFirstChild(Talk_UI.Name)
    local v40 = v35 == true
    local v41
    if v39 == nil then
        v41 = v32:Clone()
        v41.Parent = Head
    else
        if v40 then
            eachScript(v39, discard)
        end
        v41 = v39
    end
    v41.TextLabel.Text = v34
    if v36 then
        revealNpcText(v41.TextLabel, v37)
    else
        revealPlayerText(v41.TextLabel)
    end
    if v40 then
        if v39 == nil then
            eachScript(v41, switchOn)
        else
            restockScripts(v32, v41, v38)
        end
    end
    return v41
end

local function clearSideFrame(v42) -- line 129
    for v43, v44 in v42.PlayerGui.Billboard_UI:GetChildren() do
        if v44.Name ~= "UIListLayout" then
            v44:Destroy()
        end
    end
end

function v4.Speak(v45, v46, v47) -- line 136 | captures: Talk_UI, raiseBubble
    return (raiseBubble(Talk_UI, v45, v46, v47, true, v45.Name, false))
end

function v4.Reply(v48, v49, v50) -- line 139 | captures: Talk_UI, raiseBubble
    return (raiseBubble(Talk_UI, v48, v49, v50, true, nil, true))
end

function v4.Echo(v51, v52, v53) -- line 142 | captures: Response_UI, raiseBubble
    if v52 == nil then
        return
    end
    return (raiseBubble(Response_UI, v51, v52, v53, false, nil, true))
end

function v4.OfferChoices(v54, v55) -- line 148 | captures: Debris, GamepadService, TweenService, v2, Option_UI
    local v56 = {}
    local v57 = 0
    for v58, v59 in pairs(v55) do
        v57 += 1
        local v60 = Option_UI:Clone()
        v60.Parent = v54.PlayerGui.Billboard_UI
        v60.Frame.Frame.Text_Element.Text = v59
        local v61 = tostring(v57)
        v60.Frame.Frame.TextLabel.Text = v61 .. "."
        local UIPadding = v60.Frame.Frame.Text_Element.UIPadding
        local v62 = string.len(v59) * 0.001 + 0.04
        UIPadding.PaddingLeft = UDim.new(v62, 0)
        local v63 = TweenService:Create(UIPadding, v2, { PaddingLeft = UDim.new(0, 0) })
        v63:Play()
        Debris:AddItem(v63, v2.Time)
        table.insert(v56, v60)
        v60.Frame.Frame.Text_Element:SetAttribute("Text", v59)
        task.wait(0.075)
    end
    if v56[1] then
        GamepadService:EnableGamepadCursor(v56[1])
    end
    return v56
end

function v4.FadeOut(v64, v65) -- line 174 | captures: Debris, TweenService, v1, v3, clearSideFrame
    clearSideFrame(v65)
    for v66, v67 in v64.Head:GetChildren() do
        if v67:IsA("BillboardGui") and v1[v67.Name] then
            for v68, v69 in v67:GetChildren() do
                if v69:IsA("TextLabel") then
                    TweenService:Create(v69, v3, { TextTransparency = 1 }):Play()
                elseif v69:IsA("ImageLabel") then
                    TweenService:Create(v69, v3, { ImageTransparency = 1 }):Play()
                end
            end
            Debris:AddItem(v67, v3.Time)
        end
    end
end

function v4.ClearChoices(v70) -- line 189 | captures: GamepadService, clearSideFrame
    clearSideFrame(v70)
    GamepadService:DisableGamepadCursor()
end

return v4
