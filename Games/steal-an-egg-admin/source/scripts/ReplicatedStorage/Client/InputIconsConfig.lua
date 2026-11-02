-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Signal = require(ReplicatedStorage.Packages.Signal)
local v1 = {
    Xbox = {
        ButtonA = "rbxassetid://113824701684322",
        ButtonB = "rbxassetid://107100143818564",
        ButtonX = "rbxassetid://121994310218398",
        ButtonY = "rbxassetid://118121490246715",
        ButtonL1 = "rbxassetid://128016621986260",
        ButtonR1 = "rbxassetid://86739128961101",
        ButtonL2 = "rbxassetid://121095629027146",
        ButtonR2 = "rbxassetid://121138812911138",
        ButtonL3 = "rbxassetid://98426369439432",
        ButtonR3 = "rbxassetid://108823668376359",
        ButtonStart = "rbxassetid://121407964275535",
        ButtonSelect = "rbxassetid://73640706748399",
        Thumbstick1 = "rbxassetid://86234104961357",
        Thumbstick2 = "rbxassetid://92731666763608",
        DPadUp = "rbxassetid://110656716055777",
        DPadDown = "rbxassetid://134006970980101",
        DPadLeft = "rbxassetid://113523064631322",
        DPadRight = "rbxassetid://125621109562134"
    }
}

v1.PlayStation = {
    ButtonA = "rbxassetid://140688515494419",
    ButtonB = "rbxassetid://89979188218128",
    ButtonX = "rbxassetid://105740811198422",
    ButtonY = "rbxassetid://102844478766253",
    ButtonL1 = "rbxassetid://101741164721625",
    ButtonR1 = "rbxassetid://108359563054786",
    ButtonL2 = "rbxassetid://92051888341203",
    ButtonR2 = "rbxassetid://95486021989419",
    ButtonL3 = "rbxassetid://71736763291675",
    ButtonR3 = "rbxassetid://100766112822921",
    ButtonStart = "rbxassetid://115132567456286",
    ButtonSelect = "rbxassetid://74732078206933",
    Thumbstick1 = "rbxassetid://87994926804700",
    Thumbstick2 = "rbxassetid://123691072001381",
    DPadUp = "rbxassetid://77095582918408",
    DPadDown = "rbxassetid://101700700938948",
    DPadLeft = "rbxassetid://114773739810891",
    DPadRight = "rbxassetid://110011411664004"
}

local v2 = { Changed = Signal.new() }
local v3 = {}
local v4 = {}

local function askRoblox(v5, v6) -- line 56
    local v7, v8 = pcall(v5, v6)
    if not v7 or v8 == nil then
        return nil
    end
    if v8 == "" then
        return nil
    end
    return v8
end

local function platform() -- line 67 | captures: UserInputService
    local v9, v10 = pcall(function(v11) -- line 69 | captures: UserInputService
        return UserInputService:GetStringForKeyCode(v11)
    end, Enum.KeyCode.ButtonA)
    if v9 then
        if v10 == nil or v10 == "" then
            v10 = nil
        end
    else
        v10 = nil
    end
    if v10 == "ButtonCross" then
        return "PlayStation"
    end
    return "Xbox"
end

local function probe(v12) -- line 86 | captures: ContentProvider, v2, v3, v4
    v4[v12] = true
    task.spawn(function() -- line 88 | captures: v12, ContentProvider, v2, v3, v4
        local v13
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Image = v12
        local v14 = pcall(function() -- line 92 | captures: v13, ImageLabel, ContentProvider
            local v15 = { ImageLabel }
            ContentProvider:PreloadAsync(v15, function(v16, v17) -- line 94 | captures: v13
                v13 = v17 == Enum.AssetFetchStatus.Success
            end)
        end)
        ImageLabel:Destroy()
        v4[v12] = nil
        v3[v12] = v14 and false
        if not v3[v12] then
            warn((("input icon %* cannot be fetched; using platform glyph"):format(v12)))
            v2.Changed:Fire()
        end
    end)
end

local function customImage(v18) -- line 108 | captures: ContentProvider, UserInputService, v1, v2, v3, v4
    local v19, v20 = pcall(function(v21) -- line 110 | captures: UserInputService
        return UserInputService:GetStringForKeyCode(v21)
    end, Enum.KeyCode.ButtonA)
    if v19 then
        if v20 == nil or v20 == "" then
            v20 = nil
        end
    else
        v20 = nil
    end
    local v22 = if v20 == "ButtonCross" then "PlayStation" else "Xbox"
    local v23 = v1[v22][v18.Name]
    if v23 == nil or v23 == "" then
        return nil
    end
    if v3[v23] == nil and not v4[v23] then
        v4[v23] = true
        task.spawn(function() -- line 130 | captures: v23, ContentProvider, v2, v3, v4
            local v24
            local ImageLabel = Instance.new("ImageLabel")
            ImageLabel.Image = v23
            local v25 = pcall(function() -- line 134 | captures: v24, ImageLabel, ContentProvider
                local v26 = { ImageLabel }
                ContentProvider:PreloadAsync(v26, function(v27, v28) -- line 136 | captures: v24
                    v24 = v28 == Enum.AssetFetchStatus.Success
                end)
            end)
            ImageLabel:Destroy()
            v4[v23] = nil
            v3[v23] = v25 and false
            if not v3[v23] then
                warn((("input icon %* cannot be fetched; using platform glyph"):format(v23)))
                v2.Changed:Fire()
            end
        end)
    end
    if v3[v23] == false then
        return nil
    end
    return v23
end

function v2.Image(v29) -- line 155 | captures: ContentProvider, UserInputService, v1, v2, v3, v4
    local v30, v31 = pcall(function(v32) -- line 158 | captures: UserInputService
        return UserInputService:GetStringForKeyCode(v32)
    end, Enum.KeyCode.ButtonA)
    if v30 then
        if v31 == nil or v31 == "" then
            v31 = nil
        end
    else
        v31 = nil
    end
    local v33 = if v31 == "ButtonCross" then "PlayStation" else "Xbox"
    local v34 = v1[v33][v29.Name]
    local v35
    if v34 == nil or v34 == "" then
    else
        if v3[v34] == nil and not v4[v34] then
            v4[v34] = true
            task.spawn(function() -- line 178 | captures: v34, ContentProvider, v2, v3, v4
                local v36
                local ImageLabel = Instance.new("ImageLabel")
                ImageLabel.Image = v34
                local v37 = pcall(function() -- line 182 | captures: v36, ImageLabel, ContentProvider
                    local v38 = { ImageLabel }
                    ContentProvider:PreloadAsync(v38, function(v39, v40) -- line 184 | captures: v36
                        v36 = v40 == Enum.AssetFetchStatus.Success
                    end)
                end)
                ImageLabel:Destroy()
                v4[v34] = nil
                v3[v34] = v37 and false
                if not v3[v34] then
                    warn((("input icon %* cannot be fetched; using platform glyph"):format(v34)))
                    v2.Changed:Fire()
                end
            end)
        end
        if v3[v34] == false then
        else
            v35 = v34
        end
    end
    if v35 then
        return v35
    end
    local v41, v42 = pcall(function(v43) -- line 207 | captures: UserInputService
        return UserInputService:GetImageForKeyCode(v43)
    end, v29)
    if not v41 or v42 == nil then
        return nil
    end
    if v42 == "" then
        return nil
    end
    return v42
end

function v2.Platform() -- line 218 | captures: UserInputService
    local v44, v45 = pcall(function(v46) -- line 220 | captures: UserInputService
        return UserInputService:GetStringForKeyCode(v46)
    end, Enum.KeyCode.ButtonA)
    if v44 then
        if v45 == nil or v45 == "" then
            v45 = nil
        end
    else
        v45 = nil
    end
    if v45 == "ButtonCross" then
        return "PlayStation"
    end
    return "Xbox"
end

return table.freeze(v2)
