-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TweenService = game:GetService("TweenService")
local v1 = TweenInfo.new(1, Enum.EasingStyle.Cubic)
local v2 = {
    TextLabel = true,
    TextButton = true,
    TextBox = true
}
local v3 = { ScrollingFrame = true }
local v4 = {
    ImageButton = true,
    ImageLabel = true
}

local function GetTransparencyProperties(v5) -- line 11 | captures: v2, v3, v4
    local v6 = {}
    pcall(function() -- line 13 | captures: v5, v6
        if v5.Transparency then
            local Transparency = v5.Transparency
            if type(Transparency) ~= "userdata" and not v5:IsA("GuiBase") then
                v6.Transparency = v5.Transparency
            end
        end
    end)
    pcall(function() -- line 18 | captures: v5, v6
        if v5.BackgroundTransparency then
            local BackgroundTransparency = v5.BackgroundTransparency
            if type(BackgroundTransparency) ~= "userdata" then
                v6.BackgroundTransparency = v5.BackgroundTransparency
            end
        end
    end)
    if v4[v5.ClassName] then
        v6.ImageTransparency = v5.ImageTransparency
    end
    if v2[v5.ClassName] then
        v6.TextTransparency = v5.TextTransparency
        v6.TextStrokeTransparency = v5.TextStrokeTransparency
    end
    if v3[v5.ClassName] then
        v6.ScrollBarImageTransparency = v5.ScrollBarImageTransparency
    end
    if v6 == {} then
        return
    end
    return v6
end

local function ReturnPropertiesAtValue(v7, v8) -- line 38
    for v9, v10 in pairs(v7) do
        if v7[v9] == 1 then
            v7[v9] = 1
        else
            v7[v9] = v8
        end
    end
    return v7
end

local v11 = {}

v11.__index = v11

function v11.new(v12, v13, v14) -- line 53 | captures: v1, v11
    local function v15(...)
        return table.unpack(...)
    end

    local v16 = {}
    local v17 = setmetatable(v16, v11)
    v17.TweenInfo = v13 or v1
    v17.AppearTweens = {}
    v17.DisappearTweens = {}
    v17.Elements = {}
    v17.GoalTransparency = v14 or 1
    v17.new = nil
    local v18 = if type(v12) == "table"
        then v12
        else {
            v12,
            v15(v12:GetDescendants())
        }
    v17:AddObject(v18)
    return v17
end

function v11.AddObject(v19, v20) -- line 74 | captures: TweenService, GetTransparencyProperties
    if type(v20) == "table" then
        for v21, v22 in ipairs(v20) do
            v19:AddObject(v22)
        end
    else
        local v23 = GetTransparencyProperties(v20)
        if v23 then
            local Elements = v19.Elements
            table.insert(Elements, v20)
            v19.AppearTweens[v20] = TweenService:Create(v20, v19.TweenInfo, v23)
            local DisappearTweens = v19.DisappearTweens
            local TweenInfo = v19.TweenInfo
            local GoalTransparency = v19.GoalTransparency
            for v24, v25 in pairs(v23) do
                if v23[v24] == 1 then
                    v23[v24] = 1
                else
                    v23[v24] = GoalTransparency
                end
            end
            DisappearTweens[v20] = TweenService:Create(v20, TweenInfo, v23)
        end
    end
end

local function RemoveObject(v26, v27) -- line 100
    if type(v27) == "table" then
        for v28, v29 in ipairs(v27) do
            v26:RemoveObject(v29)
        end
    else
        v26.AppearTweens[v27] = nil
        v26.DisappearTweens[v27] = nil
        local v30 = table.find(v26.Elements, v27)
        if v30 then
            table.remove(v26.Elements, v30)
        end
    end
end

v11.RemoveObject = RemoveObject

local function FadeOut(v31) -- line 114
    for v32, v33 in pairs(v31.DisappearTweens) do
        v33:Play()
    end
    return v31.DisappearTweens[v31.Elements[1]].Completed
end

v11.FadeOut = FadeOut

function v11.FadeOutInstant(v34) -- line 120 | captures: GetTransparencyProperties
    for v35, v36 in v34.Elements do
        for v37 in (GetTransparencyProperties(v36)) do
            v36[v37] = 1
        end
    end
end

local function FadeIn(v38) -- line 134
    for v39, v40 in pairs(v38.AppearTweens) do
        v40:Play()
    end
    return v38.AppearTweens[v38.Elements[1]].Completed
end

v11.FadeIn = FadeIn

local v41 = { __call = v11.new }
return (setmetatable(v11, v41))
