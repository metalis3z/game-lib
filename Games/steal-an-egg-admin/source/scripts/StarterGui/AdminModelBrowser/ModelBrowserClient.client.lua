-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Shade = script.Parent:WaitForChild("Shade")
local Main = Shade:WaitForChild("Main")
local SearchInput = Main:WaitForChild("SearchInput")
local SearchButton = Main:WaitForChild("SearchButton")
local IdInput = Main:WaitForChild("IdInput")
local LoadButton = Main:WaitForChild("LoadButton")
local AvatarInput = Main:WaitForChild("AvatarInput")
local AvatarButton = Main:WaitForChild("AvatarButton")
local LoadMoreButton = Main:WaitForChild("LoadMoreButton")
local Status = Main:WaitForChild("Status")
local Hero = Main:WaitForChild("Hero")
local Results = Main:WaitForChild("Results")
local ResultTemplate = Results:WaitForChild("ResultTemplate")
local Header = Main:WaitForChild("Header")
local Close = Header:WaitForChild("Close")
local Subtitle = Header:WaitForChild("Subtitle")
local BuilderTools_ToolboxSearch = ReplicatedStorage:WaitForChild("BuilderTools_ToolboxSearch")
local BuilderTools_ToolboxPreview = ReplicatedStorage:WaitForChild("BuilderTools_ToolboxPreview")
local BuilderTools_ToolboxInsert = ReplicatedStorage:WaitForChild("BuilderTools_ToolboxInsert")
local BuilderTools_ToolboxAvatar = ReplicatedStorage:WaitForChild("BuilderTools_ToolboxAvatar")
local BuilderTools_ToolboxAvatarInsert = ReplicatedStorage:WaitForChild("BuilderTools_ToolboxAvatarInsert")
local v1 = Color3.fromRGB(96, 165, 250)
local v2 = Color3.fromRGB(52, 58, 76)
local v3 = Color3.fromRGB(33, 37, 49)
local v4 = Color3.fromRGB(46, 53, 71)
local v5 = Color3.fromRGB(120, 235, 165)
local v6 = Color3.fromRGB(245, 120, 130)
local v7 = Color3.fromRGB(146, 158, 184)
local v8 = false
local v9 = 0
local v10 = {}
local v11 = false
local v12 = ""
local v13 = 0
local v14 = 0

local function setStatus(v15, v16) -- line 53 | captures: Status, v5, v6, v7
    local v17 = v15 or ""
    Status.Text = tostring(v17)
    local v18, v19
    if v16 == true and v5 then
        v18 = v5
        v19 = true
    elseif v16 == false and v6 then
        v18 = v6
        v19 = true
    else
        v19 = false
    end
    if not v19 then
        v18 = v7
    end
    Status.TextColor3 = v18
end

local function invoke(v20, ...) -- line 58 | captures: Status, v5, v6, v7
    local v21 = table.pack(...)
    local v22, v23, v24 = pcall(function() -- line 60 | captures: v20, v21
        local n = v21.n
        return v20:InvokeServer(table.unpack(v21, 1, n))
    end)
    if v22 then
        if not v24 then
            if v23 then
                v24 = "Done"
            else
                v24 = "Failed"
            end
        end
        local v25 = v23 == true
        local v26 = v24 or ""
        Status.Text = tostring(v26)
        local v27, v28
        if v25 == true and v5 then
            v27 = v5
            v28 = true
        elseif v25 == false and v6 then
            v27 = v6
            v28 = true
        else
            v28 = false
        end
        if not v28 then
            v27 = v7
        end
        Status.TextColor3 = v27
        return v23 == true
    end
    Status.Text = tostring("Request failed")
    Status.TextColor3 = v6 or v7
    warn("[ModelBrowser]", v23)
    return false
end

local function refreshHero() -- line 72 | captures: v14, Hero, Results
    Hero.Visible = v14 == 0
    Results.Visible = v14 > 0
end

local function clearResults() -- line 77 | captures: v9, v14, LoadMoreButton, Hero, Results, ResultTemplate, v10
    v9 += 1
    table.clear(v10)
    v14 = 0
    LoadMoreButton.Visible = false
    for v29, v30 in ipairs(Results:GetChildren()) do
        if v30:IsA("Frame") and v30 ~= ResultTemplate then
            v30:Destroy()
        end
    end
    Hero.Visible = v14 == 0
    Results.Visible = v14 > 0
end

local function setupViewport(v31, v32) -- line 90 | captures: TweenService
    if not v31.Parent or not v32 then
        return
    end
    local PreviewHolder = v31.PreviewHolder
    local Viewport = PreviewHolder.Viewport
    Viewport:ClearAllChildren()
    local WorldModel = Instance.new("WorldModel")
    WorldModel.Name = "PreviewWorld"
    WorldModel.Parent = Viewport
    local v33 = v32:Clone()
    v33.Name = "Model"
    v33.Parent = WorldModel
    local v34, v35, v36 = pcall(v33.GetBoundingBox, v33)
    if v34 and v36 ~= nil and not (v36.Magnitude < 0.01) then
        local X = v36.X
        local Y = v36.Y
        local Z = v36.Z
        local v37 = math.max(X, Y, Z, 1)
        local Position = v35.Position
        local Unit = Vector3.new(1, 0.6499999761581421, 1).Unit
        local Camera = Instance.new("Camera")
        Camera.FieldOfView = 35
        Camera.CFrame = CFrame.lookAt(Position + Unit * (v37 * 1.9 + 2), Position)
        Camera.Parent = Viewport
        Viewport.CurrentCamera = Camera
        PreviewHolder.Loading.Visible = false
        TweenService:Create(PreviewHolder.Thumbnail, TweenInfo.new(0.2), { ImageTransparency = 1 }):Play()
        task.delay(0.2, function() -- line 122 | captures: v31, PreviewHolder
            if v31.Parent then
                PreviewHolder.Thumbnail.Visible = false
            end
        end)
    else
        PreviewHolder.Loading.Text = "3D PREVIEW UNAVAILABLE"
    end
end

local function processPreviewQueue() -- line 131 | captures: v9, v11, BuilderTools_ToolboxPreview, v10, setupViewport
    if not v11 then
        v11 = true
        task.spawn(function() -- line 136 | captures: v9, v11, BuilderTools_ToolboxPreview, v10, setupViewport
            local v38, v39, PreviewHolder
            while true do
                if #v10 > 0 then
                    local v40 = table.remove(v10, 1)
                    if v40.Generation == v9 and v40.Card.Parent then
                        local pcall_2 = pcall
                        v38 = v40
                        local v41, v42 = pcall_2(function() -- line 140 | captures: v38, BuilderTools_ToolboxPreview
                            return BuilderTools_ToolboxPreview:InvokeServer(v38.AssetId)
                        end)
                        if v40.Card.Parent and v40.Generation == v9 then
                            if v41 and typeof(v42) == "Instance" then
                                setupViewport(v40.Card, v42)
                            else
                                local PreviewHolder_2 = v40.Card.PreviewHolder
                                PreviewHolder_2.Loading.Text = "THUMBNAIL ONLY"
                                local delay = task.delay
                                v39 = v40
                                PreviewHolder = PreviewHolder_2
                                delay(1.5, function() -- line 149 | captures: v39, PreviewHolder
                                    if v39.Card.Parent then
                                        PreviewHolder.Loading.Visible = false
                                    end
                                end)
                            end
                        end
                    end
                else
                    break
                end
            end
            v11 = false
        end)
    end
end

local function request3DPreview(v43, v44) -- line 162 | captures: v9, v11, BuilderTools_ToolboxPreview, v10, setupViewport
    local v45 = {
        Card = v43,
        AssetId = v44,
        Generation = v9
    }
    table.insert(v10, v45)
    if not v11 then
        v11 = true
        task.spawn(function() -- line 136 | captures: v9, v11, BuilderTools_ToolboxPreview, v10, setupViewport
            local v46, v47, PreviewHolder
            while true do
                if #v10 > 0 then
                    local v48 = table.remove(v10, 1)
                    if v48.Generation == v9 and v48.Card.Parent then
                        local pcall_2 = pcall
                        v46 = v48
                        local v49, v50 = pcall_2(function() -- line 140 | captures: BuilderTools_ToolboxPreview, v46
                            return BuilderTools_ToolboxPreview:InvokeServer(v46.AssetId)
                        end)
                        if v48.Card.Parent and v48.Generation == v9 then
                            if v49 and typeof(v50) == "Instance" then
                                setupViewport(v48.Card, v50)
                            else
                                local PreviewHolder_2 = v48.Card.PreviewHolder
                                PreviewHolder_2.Loading.Text = "THUMBNAIL ONLY"
                                local delay = task.delay
                                v47 = v48
                                PreviewHolder = PreviewHolder_2
                                delay(1.5, function() -- line 149 | captures: v47, PreviewHolder
                                    if v47.Card.Parent then
                                        PreviewHolder.Loading.Visible = false
                                    end
                                end)
                            end
                        end
                    end
                else
                    break
                end
            end
            v11 = false
        end)
    end
end

local function addCard(v51, v52) -- line 167 | captures: v8, v9, v11, Results, ResultTemplate, BuilderTools_ToolboxPreview, BuilderTools_ToolboxInsert, BuilderTools_ToolboxAvatarInsert, v1, v2, v3, v4, v10, invoke, setupViewport
    local Id = v51.Id
    local v53 = tonumber(Id)
    if v53 == nil then
        return
    end
    local v54 = v51.Kind == "Avatar"
    local v55 = ResultTemplate:Clone()
    local v56 = if v54 then "user_" else ""
    v55.Name = v56 .. v53
    v55.LayoutOrder = v52
    local ModelName = v55.ModelName
    local Name = v51.Name
    if Name then
        ModelName.Text = Name
    else
        local v57 = if v54 then "User " else "Model "
        ModelName.Text = v57 .. v53
    end
    local Creator = v55.Creator
    local v58, v59
    if v51.Creator then
        local v60 = if v54 then "" else "by "
        local v61 = v60 .. v51.Creator
        if v61 then
            v58 = v61
            v59 = true
        else
            v59 = false
        end
    else
        v59 = false
    end
    if not v59 then
        v58 = ""
    end
    Creator.Text = v58
    local AssetId = v55.AssetId
    local v62 = if v54 then "USER " else "ID "
    AssetId.Text = v62 .. v53
    local Thumbnail = v55.PreviewHolder.Thumbnail
    local format = string.format
    local v63 = if v54 then "rbxthumb://type=AvatarThumbnail&id=%d&w=420&h=420" else "rbxthumb://type=Asset&id=%d&w=420&h=420"
    Thumbnail.Image = format(v63, v53)
    v55.PreviewHolder.Thumbnail.Visible = true
    v55.PreviewHolder.Thumbnail.ImageTransparency = 0
    v55.PreviewHolder.Loading.Text = "LOADING 3D..."
    v55.PreviewHolder.Loading.Visible = true
    v55.Visible = true
    v55.Parent = Results
    local Outline = v55:FindFirstChild("Outline")
    v55.MouseEnter:Connect(function() -- line 193 | captures: v55, Outline, v1, v4
        v55.BackgroundColor3 = v4
        if Outline then
            Outline.Color = v1
            Outline.Transparency = 0
        end
    end)
    v55.MouseLeave:Connect(function() -- line 200 | captures: v55, Outline, v2, v3
        v55.BackgroundColor3 = v3
        if Outline then
            Outline.Color = v2
            Outline.Transparency = 0.35
        end
    end)
    v55.Insert.Activated:Connect(function() -- line 208 | captures: v53, v55, v54, v8, BuilderTools_ToolboxInsert, BuilderTools_ToolboxAvatarInsert, invoke
        if v8 then
            return
        end
        v8 = true
        v55.Insert.Text = "INSERTING..."
        local v64 = v54 and BuilderTools_ToolboxAvatarInsert or BuilderTools_ToolboxInsert
        invoke(v64, v53)
        v55.Insert.Text = "INSERT"
        v8 = false
    end)
    if v51.Model then
        setupViewport(v55, v51.Model)
    else
        local v65 = {
            Card = v55,
            AssetId = v53,
            Generation = v9
        }
        table.insert(v10, v65)
        if not v11 then
            v11 = true
            task.spawn(function() -- line 136 | captures: v9, v11, BuilderTools_ToolboxPreview, v10, setupViewport
                local v66, v67, PreviewHolder
                while true do
                    if #v10 > 0 then
                        local v68 = table.remove(v10, 1)
                        if v68.Generation == v9 and v68.Card.Parent then
                            local pcall_2 = pcall
                            v66 = v68
                            local v69, v70 = pcall_2(function() -- line 140 | captures: BuilderTools_ToolboxPreview, v66
                                return BuilderTools_ToolboxPreview:InvokeServer(v66.AssetId)
                            end)
                            if v68.Card.Parent and v68.Generation == v9 then
                                if v69 and typeof(v70) == "Instance" then
                                    setupViewport(v68.Card, v70)
                                else
                                    local PreviewHolder_2 = v68.Card.PreviewHolder
                                    PreviewHolder_2.Loading.Text = "THUMBNAIL ONLY"
                                    local delay = task.delay
                                    v67 = v68
                                    PreviewHolder = PreviewHolder_2
                                    delay(1.5, function() -- line 149 | captures: v67, PreviewHolder
                                        if v67.Card.Parent then
                                            PreviewHolder.Loading.Visible = false
                                        end
                                    end)
                                end
                            end
                        end
                    else
                        break
                    end
                end
                v11 = false
            end)
        end
    end
end

local function appendResults(v71) -- line 228 | captures: v14, Hero, Results, addCard
    for v72, v73 in ipairs(v71) do
        v14 += 1
        addCard(v73, v14)
    end
    Hero.Visible = v14 == 0
    Results.Visible = v14 > 0
end

local function runSearch(v74, v75, v76) -- line 236 | captures: v8, v12, v13, v14, SearchButton, LoadMoreButton, Status, Subtitle, BuilderTools_ToolboxSearch, v5, v6, v7, clearResults, appendResults
    if v8 then
        return
    end
    v8 = true
    local v77 = v76 and LoadMoreButton or SearchButton
    local Text = v77.Text
    v77.Text = "..."
    local v78 = if v76 then "Loading more models..." else "Searching Roblox..."
    local v79 = v78 or ""
    Status.Text = tostring(v79)
    Status.TextColor3 = v7
    local v80, v81, v82 = pcall(function() -- line 246 | captures: v74, v75, BuilderTools_ToolboxSearch
        return BuilderTools_ToolboxSearch:InvokeServer(v74, v75)
    end)
    v77.Text = Text
    v8 = false
    if v80 then
        if type(v81) == "table" then
            if not v76 then
                clearResults()
            end
            v12 = v74
            v13 = tonumber(v82) or v75 + 1
            appendResults(v81)
            LoadMoreButton.Visible = #v81 > 0
            Subtitle.Text = "Results for " .. v74
            local v83 = v14 .. " models loaded for " .. v74
            local v84 = v14 > 0
            local v85 = v83 or ""
            Status.Text = tostring(v85)
            local v86, v87
            if v84 == true and v5 then
                v86 = v5
                v87 = true
            elseif v84 == false and v6 then
                v86 = v6
                v87 = true
            else
                v87 = false
            end
            if not v87 then
                v86 = v7
            end
            Status.TextColor3 = v86
        else
            local v88 = v82 or "Roblox model search failed" or ""
            Status.Text = tostring(v88)
            Status.TextColor3 = v6 or v7
            if not v76 then
                clearResults()
            end
        end
    else
        Status.Text = tostring("Search request failed")
        Status.TextColor3 = v6 or v7
        warn("[ModelBrowser]", v81)
    end
end

local function search() -- line 276 | captures: SearchInput, Status, v6, v7, runSearch
    local v89 = SearchInput.Text:match("^%s*(.-)%s*$")
    if #v89 < 2 then
        Status.Text = tostring("Type at least 2 characters")
        Status.TextColor3 = v6 or v7
    else
        runSearch(v89, 0, false)
    end
end

local function loadMore() -- line 285 | captures: v12, v13, runSearch
    if v12 ~= "" then
        runSearch(v12, v13, true)
    end
end

local function loadById() -- line 292 | captures: v8, IdInput, LoadButton, Status, BuilderTools_ToolboxInsert, v6, v7, invoke
    if not v8 then
        local v90 = IdInput.Text:match("%d+")
        if v90 then
            v8 = true
            LoadButton.Text = "..."
            invoke(BuilderTools_ToolboxInsert, (tonumber(v90)))
            LoadButton.Text = "LOAD ID"
            v8 = false
        else
            Status.Text = tostring("Enter a valid model ID")
            Status.TextColor3 = v6 or v7
        end
    end
end

local function loadAvatar() -- line 310 | captures: v8, v12, v14, AvatarInput, AvatarButton, Status, Hero, Results, Subtitle, BuilderTools_ToolboxAvatar, v5, v6, v7, clearResults, addCard
    if not v8 then
        local v91 = AvatarInput.Text:match("^%s*(.-)%s*$")
        if #v91 == 0 then
            Status.Text = tostring("Enter a Roblox username or user ID")
            Status.TextColor3 = v6 or v7
        else
            v8 = true
            local Text = AvatarButton.Text
            AvatarButton.Text = "..."
            local v92 = "Looking up " .. v91 .. "..." or ""
            Status.Text = tostring(v92)
            Status.TextColor3 = v7
            local v93, v94, v95, v96 = pcall(function() -- line 325 | captures: v91, BuilderTools_ToolboxAvatar
                return BuilderTools_ToolboxAvatar:InvokeServer(v91)
            end)
            AvatarButton.Text = Text
            v8 = false
            if v93 then
                if type(v94) == "table" then
                    clearResults()
                    v12 = ""
                    v14 = 1
                    local v97 = {
                        Kind = "Avatar",
                        Id = v94.Id
                    }
                    v97.Name = v94.DisplayName or v94.Name
                    local Name = v94.Name
                    v97.Creator = "@" .. tostring(Name)
                    v97.Model = v95
                    addCard(v97, 1)
                    Hero.Visible = v14 == 0
                    Results.Visible = v14 > 0
                    local Name_2 = v94.Name
                    Subtitle.Text = "Avatar of @" .. tostring(Name_2)
                    local v98 = v96 or "Avatar ready"
                    local v99 = v95 ~= nil
                    local v100 = v98 or ""
                    Status.Text = tostring(v100)
                    local v101, v102
                    if v99 == true and v5 then
                        v101 = v5
                        v102 = true
                    elseif v99 == false and v6 then
                        v101 = v6
                        v102 = true
                    else
                        v102 = false
                    end
                    if not v102 then
                        v101 = v7
                    end
                    Status.TextColor3 = v101
                else
                    local v103 = v96 or "Could not find that user" or ""
                    Status.Text = tostring(v103)
                    Status.TextColor3 = v6 or v7
                end
            else
                Status.Text = tostring("Avatar request failed")
                Status.TextColor3 = v6 or v7
                warn("[ModelBrowser]", v94)
            end
        end
    end
end

local function open() -- line 356 | captures: v14, Shade, SearchInput, Status, Hero, Results, v7
    Shade.Visible = true
    Hero.Visible = v14 == 0
    Results.Visible = v14 > 0
    if Status.Text == "" then
        Status.Text = tostring("Search free models, paste an asset ID, or load a user's avatar")
        Status.TextColor3 = v7
    end
    SearchInput:CaptureFocus()
end

local function closeBrowser() -- line 365 | captures: Shade, SearchInput, IdInput, AvatarInput
    Shade.Visible = false
    SearchInput:ReleaseFocus()
    IdInput:ReleaseFocus()
    AvatarInput:ReleaseFocus()
end

for v104, v105 in ipairs({ SearchInput, IdInput, AvatarInput }) do
    local UIStroke = v105:FindFirstChildOfClass("UIStroke")
    if UIStroke then
        v105.Focused:Connect(function() -- line 376 | captures: v1, UIStroke
            UIStroke.Color = v1
        end)
        v105.FocusLost:Connect(function() -- line 379 | captures: v2, UIStroke
            UIStroke.Color = v2
        end)
    end
end
Close.Activated:Connect(closeBrowser)
SearchButton.Activated:Connect(search)
LoadButton.Activated:Connect(loadById)
AvatarButton.Activated:Connect(loadAvatar)
LoadMoreButton.Activated:Connect(loadMore)
SearchInput.FocusLost:Connect(function(v106) -- line 391 | captures: SearchInput, Status, v6, v7, runSearch
    if not v106 then
        return
    end
    local v107 = SearchInput.Text:match("^%s*(.-)%s*$")
    if #v107 < 2 then
        Status.Text = tostring("Type at least 2 characters")
        local v108 = v6 or v7
        Status.TextColor3 = v108
    else
        runSearch(v107, 0, false)
    end
end)
IdInput.FocusLost:Connect(function(v109) -- line 396 | captures: v8, IdInput, LoadButton, Status, BuilderTools_ToolboxInsert, v6, v7, invoke
    if not v109 then
        return
    end
    if v8 then
        return
    end
    local v110 = IdInput.Text:match("%d+")
    if not v110 then
        Status.Text = tostring("Enter a valid model ID")
        local v111 = v6 or v7
        Status.TextColor3 = v111
    else
        v8 = true
        LoadButton.Text = "..."
        invoke(BuilderTools_ToolboxInsert, (tonumber(v110)))
        LoadButton.Text = "LOAD ID"
        v8 = false
    end
end)
AvatarInput.FocusLost:Connect(function(v112) -- line 401 | captures: loadAvatar
    if v112 then
        loadAvatar()
    end
end)
UserInputService.InputBegan:Connect(function(v113, v114) -- line 407 | captures: v14, Shade, SearchInput, IdInput, AvatarInput, Status, Hero, Results, v7
    if not v114 then
        if v113.KeyCode == Enum.KeyCode.F3 then
            if Shade.Visible then
                Shade.Visible = false
                SearchInput:ReleaseFocus()
                IdInput:ReleaseFocus()
                AvatarInput:ReleaseFocus()
            else
                Shade.Visible = true
                Hero.Visible = v14 == 0
                Results.Visible = v14 > 0
                if Status.Text == "" then
                    Status.Text = tostring("Search free models, paste an asset ID, or load a user's avatar")
                    Status.TextColor3 = v7
                end
                SearchInput:CaptureFocus()
            end
        elseif v113.KeyCode == Enum.KeyCode.Escape and Shade.Visible then
            Shade.Visible = false
            SearchInput:ReleaseFocus()
            IdInput:ReleaseFocus()
            AvatarInput:ReleaseFocus()
        end
    end
end)
Hero.Visible = v14 == 0
Results.Visible = v14 > 0
