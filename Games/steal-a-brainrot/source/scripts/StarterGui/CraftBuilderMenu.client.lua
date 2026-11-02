local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer

-- Remotes
local netFolder = RS.Packages.Net
local OpenMenu    = netFolder:WaitForChild("RE/CraftBuilder/OpenMenu")
local SubmitRecipe = netFolder:WaitForChild("RE/CraftBuilder/SubmitRecipe")
local SearchAnimals = netFolder:WaitForChild("RF/CraftBuilder/SearchAnimals")

-- ════════════════════════════════════════════
-- COULEURS RARETÉS
-- ════════════════════════════════════════════
local RARITY_COLORS = {
    Epic          = Color3.fromRGB(163, 73, 255),
    Legendary     = Color3.fromRGB(255, 170, 0),
    Mythic        = Color3.fromRGB(255, 50, 50),
    ["Brainrot God"] = Color3.fromRGB(255, 0, 100),
    Secret        = Color3.fromRGB(255, 0, 200),
    OG            = Color3.fromRGB(255, 215, 0),
    Cosmic        = Color3.fromRGB(0, 200, 255),
}
local RARITY_ORDER = {"Epic","Legendary","Mythic","Brainrot God","Secret","OG","Cosmic"}

-- ════════════════════════════════════════════
-- CONSTRUCTION DE LA GUI
-- ════════════════════════════════════════════
local SG = Instance.new("ScreenGui")
SG.Name = "CraftBuilderGui"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.IgnoreGuiInset = true
SG.DisplayOrder = 200
SG.Enabled = false
SG.Parent = LP.PlayerGui

-- Overlay sombre
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 0.45
Overlay.BorderSizePixel = 0
Overlay.ZIndex = 10
Overlay.Parent = SG

local function uicorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 12)
    c.Parent = parent
    return c
end
local function uistroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(80,80,100)
    s.Thickness = thickness or 1.5
    s.Parent = parent
    return s
end
local function label(parent, text, size, color, font, zIndex)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Text = text or ""
    l.TextSize = size or 16
    l.TextColor3 = color or Color3.new(1,1,1)
    l.Font = font or Enum.Font.GothamBold
    l.ZIndex = zIndex or 20
    l.TextScaled = false
    l.Parent = parent
    return l
end

-- Fenêtre principale  (largeur 680, hauteur 520)
local WIN_W, WIN_H = 680, 540
local Window = Instance.new("Frame")
Window.Size = UDim2.new(0, WIN_W, 0, WIN_H)
Window.Position = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
Window.BackgroundColor3 = Color3.fromRGB(12, 10, 28)
Window.BorderSizePixel = 0
Window.ZIndex = 20
Window.Parent = SG
uicorner(Window, 16)
uistroke(Window, Color3.fromRGB(80, 60, 160), 2)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,54)
Header.BackgroundColor3 = Color3.fromRGB(25, 18, 55)
Header.BorderSizePixel = 0
Header.ZIndex = 21
Header.Parent = Window
uicorner(Header, 16)

local HeaderTitle = label(Header, "⚙️  CRAFT BUILDER — Admin", 20, Color3.fromRGB(200,180,255), Enum.Font.GothamBold, 22)
HeaderTitle.Size = UDim2.new(1,-60,1,0)
HeaderTitle.Position = UDim2.new(0,16,0,0)
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0,36,0,36)
CloseBtn.Position = UDim2.new(1,-46,0,9)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180,40,40)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 22
CloseBtn.Parent = Window
uicorner(CloseBtn, 8)

-- ═══ COLONNE GAUCHE : résultat + recette ═══
local LeftCol = Instance.new("Frame")
LeftCol.Size = UDim2.new(0, 320, 0, WIN_H - 80)
LeftCol.Position = UDim2.new(0, 12, 0, 62)
LeftCol.BackgroundTransparency = 1
LeftCol.ZIndex = 21
LeftCol.Parent = Window

-- Section: animal résultat
local ResultSection = Instance.new("Frame")
ResultSection.Size = UDim2.new(1,0,0,100)
ResultSection.BackgroundColor3 = Color3.fromRGB(22, 18, 45)
ResultSection.BorderSizePixel = 0
ResultSection.ZIndex = 21
ResultSection.Parent = LeftCol
uicorner(ResultSection, 10)
uistroke(ResultSection, Color3.fromRGB(80,60,160), 1)

local ResultTitle = label(ResultSection, "🎯  Animal à crafter (résultat)", 13, Color3.fromRGB(180,160,255), Enum.Font.GothamBold, 22)
ResultTitle.Size = UDim2.new(1,0,0,22)
ResultTitle.Position = UDim2.new(0,10,0,6)
ResultTitle.TextXAlignment = Enum.TextXAlignment.Left

local ResultBox = Instance.new("TextBox")
ResultBox.Size = UDim2.new(1,-20,0,32)
ResultBox.Position = UDim2.new(0,10,0,30)
ResultBox.BackgroundColor3 = Color3.fromRGB(15,12,35)
ResultBox.TextColor3 = Color3.new(1,1,1)
ResultBox.PlaceholderText = "Tape le nom de l'animal..."
ResultBox.PlaceholderColor3 = Color3.fromRGB(120,100,160)
ResultBox.Text = ""
ResultBox.TextSize = 14
ResultBox.Font = Enum.Font.Gotham
ResultBox.ClearTextOnFocus = false
ResultBox.ZIndex = 22
ResultBox.Parent = ResultSection
uicorner(ResultBox, 7)
uistroke(ResultBox, Color3.fromRGB(100,80,200), 1)

local ResultStatus = label(ResultSection, "", 12, Color3.fromRGB(100,255,150), Enum.Font.Gotham, 22)
ResultStatus.Size = UDim2.new(1,0,0,18)
ResultStatus.Position = UDim2.new(0,10,0,64)
ResultStatus.TextXAlignment = Enum.TextXAlignment.Left

-- Section: rareté
local RaritySection = Instance.new("Frame")
RaritySection.Size = UDim2.new(1,0,0,82)
RaritySection.Position = UDim2.new(0,0,0,108)
RaritySection.BackgroundColor3 = Color3.fromRGB(22, 18, 45)
RaritySection.BorderSizePixel = 0
RaritySection.ZIndex = 21
RaritySection.Parent = LeftCol
uicorner(RaritySection, 10)
uistroke(RaritySection, Color3.fromRGB(80,60,160), 1)

local RarityTitle = label(RaritySection, "💎  Rareté du slot", 13, Color3.fromRGB(180,160,255), Enum.Font.GothamBold, 22)
RarityTitle.Size = UDim2.new(1,0,0,22)
RarityTitle.Position = UDim2.new(0,10,0,5)
RarityTitle.TextXAlignment = Enum.TextXAlignment.Left

local RarityRow = Instance.new("Frame")
RarityRow.Size = UDim2.new(1,-14,0,42)
RarityRow.Position = UDim2.new(0,7,0,32)
RarityRow.BackgroundTransparency = 1
RarityRow.ZIndex = 22
RarityRow.Parent = RaritySection
local RarityLayout = Instance.new("UIListLayout")
RarityLayout.FillDirection = Enum.FillDirection.Horizontal
RarityLayout.SortOrder = Enum.SortOrder.LayoutOrder
RarityLayout.Padding = UDim.new(0,4)
RarityLayout.Parent = RarityRow

local selectedRarity = "Legendary"
local rarityButtons = {}

for i, rarity in ipairs(RARITY_ORDER) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 76, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30,25,60)
    btn.Text = rarity
    btn.TextColor3 = RARITY_COLORS[rarity] or Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.ZIndex = 23
    btn.LayoutOrder = i
    btn.Parent = RarityRow
    uicorner(btn, 7)
    uistroke(btn, Color3.fromRGB(50,40,100), 1)
    rarityButtons[rarity] = btn
end

-- Section: recette
local RecipeSection = Instance.new("Frame")
RecipeSection.Size = UDim2.new(1,0,0, WIN_H - 80 - 100 - 108 - 16)
RecipeSection.Position = UDim2.new(0,0,0,198)
RecipeSection.BackgroundColor3 = Color3.fromRGB(22, 18, 45)
RecipeSection.BorderSizePixel = 0
RecipeSection.ZIndex = 21
RecipeSection.Parent = LeftCol
uicorner(RecipeSection, 10)
uistroke(RecipeSection, Color3.fromRGB(80,60,160), 1)

local RecipeTitle = label(RecipeSection, "🧪  Recette (ingrédients)", 13, Color3.fromRGB(180,160,255), Enum.Font.GothamBold, 22)
RecipeTitle.Size = UDim2.new(1,0,0,22)
RecipeTitle.Position = UDim2.new(0,10,0,5)
RecipeTitle.TextXAlignment = Enum.TextXAlignment.Left

local RecipeScroll = Instance.new("ScrollingFrame")
RecipeScroll.Size = UDim2.new(1,-14,1,-54)
RecipeScroll.Position = UDim2.new(0,7,0,28)
RecipeScroll.BackgroundTransparency = 1
RecipeScroll.ScrollBarThickness = 4
RecipeScroll.ScrollBarImageColor3 = Color3.fromRGB(100,80,200)
RecipeScroll.BorderSizePixel = 0
RecipeScroll.ZIndex = 22
RecipeScroll.Parent = RecipeSection
local RecipeLayout = Instance.new("UIListLayout")
RecipeLayout.SortOrder = Enum.SortOrder.LayoutOrder
RecipeLayout.Padding = UDim.new(0,4)
RecipeLayout.Parent = RecipeScroll

local AddIngredientBtn = Instance.new("TextButton")
AddIngredientBtn.Size = UDim2.new(1,-14,0,28)
AddIngredientBtn.Position = UDim2.new(0,7,1,-34)
AddIngredientBtn.BackgroundColor3 = Color3.fromRGB(40,80,40)
AddIngredientBtn.Text = "+ Ajouter un ingrédient"
AddIngredientBtn.TextColor3 = Color3.fromRGB(100,255,100)
AddIngredientBtn.TextScaled = true
AddIngredientBtn.Font = Enum.Font.GothamBold
AddIngredientBtn.ZIndex = 22
AddIngredientBtn.Parent = RecipeSection
uicorner(AddIngredientBtn, 7)

-- ═══ COLONNE DROITE : autocomplete + paramètres ═══
local RightCol = Instance.new("Frame")
RightCol.Size = UDim2.new(0, 330, 0, WIN_H - 80)
RightCol.Position = UDim2.new(0, 338, 0, 62)
RightCol.BackgroundTransparency = 1
RightCol.ZIndex = 21
RightCol.Parent = Window

-- Paramètres : coût + temps
local ParamsSection = Instance.new("Frame")
ParamsSection.Size = UDim2.new(1,0,0,110)
ParamsSection.BackgroundColor3 = Color3.fromRGB(22, 18, 45)
ParamsSection.BorderSizePixel = 0
ParamsSection.ZIndex = 21
ParamsSection.Parent = RightCol
uicorner(ParamsSection, 10)
uistroke(ParamsSection, Color3.fromRGB(80,60,160), 1)

local ParamsTitle = label(ParamsSection, "⚙️  Paramètres", 13, Color3.fromRGB(180,160,255), Enum.Font.GothamBold, 22)
ParamsTitle.Size = UDim2.new(1,0,0,22)
ParamsTitle.Position = UDim2.new(0,10,0,5)
ParamsTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Coût
local CostLabel = label(ParamsSection, "💰 Coût ($)", 12, Color3.fromRGB(200,200,200), Enum.Font.Gotham, 22)
CostLabel.Size = UDim2.new(0,90,0,20)
CostLabel.Position = UDim2.new(0,10,0,32)
CostLabel.TextXAlignment = Enum.TextXAlignment.Left

local CostBox = Instance.new("TextBox")
CostBox.Size = UDim2.new(0,150,0,26)
CostBox.Position = UDim2.new(0,100,0,29)
CostBox.BackgroundColor3 = Color3.fromRGB(15,12,35)
CostBox.TextColor3 = Color3.new(1,1,1)
CostBox.Text = "500000"
CostBox.TextSize = 14
CostBox.Font = Enum.Font.Gotham
CostBox.ZIndex = 22
CostBox.Parent = ParamsSection
uicorner(CostBox, 6)
uistroke(CostBox, Color3.fromRGB(80,60,160), 1)

-- CraftTime
local TimeLabel = label(ParamsSection, "⏱️ Temps (s)", 12, Color3.fromRGB(200,200,200), Enum.Font.Gotham, 22)
TimeLabel.Size = UDim2.new(0,90,0,20)
TimeLabel.Position = UDim2.new(0,10,0,66)
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left

local TimeBox = Instance.new("TextBox")
TimeBox.Size = UDim2.new(0,150,0,26)
TimeBox.Position = UDim2.new(0,100,0,63)
TimeBox.BackgroundColor3 = Color3.fromRGB(15,12,35)
TimeBox.TextColor3 = Color3.new(1,1,1)
TimeBox.Text = "900"
TimeBox.TextSize = 14
TimeBox.Font = Enum.Font.Gotham
TimeBox.ZIndex = 22
TimeBox.Parent = ParamsSection
uicorner(TimeBox, 6)
uistroke(TimeBox, Color3.fromRGB(80,60,160), 1)

-- Dropdown scope
local ScopeLabel = label(ParamsSection, "🌍 Scope", 12, Color3.fromRGB(200,200,200), Enum.Font.Gotham, 22)
ScopeLabel.Size = UDim2.new(0,90,0,20)
ScopeLabel.Position = UDim2.new(0,262,0,32)
ScopeLabel.TextXAlignment = Enum.TextXAlignment.Left

local ScopeBtn = Instance.new("TextButton")
ScopeBtn.Size = UDim2.new(0,60,0,26)
ScopeBtn.Position = UDim2.new(0,262,0,54)
ScopeBtn.BackgroundColor3 = Color3.fromRGB(180,80,0)
ScopeBtn.Text = "Global"
ScopeBtn.TextColor3 = Color3.new(1,1,1)
ScopeBtn.TextScaled = true
ScopeBtn.Font = Enum.Font.GothamBold
ScopeBtn.ZIndex = 22
ScopeBtn.Parent = ParamsSection
uicorner(ScopeBtn, 7)
local isGlobal = true

ScopeBtn.MouseButton1Click:Connect(function()
    isGlobal = not isGlobal
    ScopeBtn.Text = isGlobal and "Global" or "Local"
    ScopeBtn.BackgroundColor3 = isGlobal and Color3.fromRGB(180,80,0) or Color3.fromRGB(40,100,40)
end)

-- Section autocomplete search
local SearchSection = Instance.new("Frame")
SearchSection.Size = UDim2.new(1,0,0, WIN_H - 80 - 120)
SearchSection.Position = UDim2.new(0,0,0,118)
SearchSection.BackgroundColor3 = Color3.fromRGB(22,18,45)
SearchSection.BorderSizePixel = 0
SearchSection.ZIndex = 21
SearchSection.Parent = RightCol
uicorner(SearchSection, 10)
uistroke(SearchSection, Color3.fromRGB(80,60,160), 1)

local SearchTitle = label(SearchSection, "🔍  Recherche animaux", 13, Color3.fromRGB(180,160,255), Enum.Font.GothamBold, 22)
SearchTitle.Size = UDim2.new(1,0,0,22)
SearchTitle.Position = UDim2.new(0,10,0,5)
SearchTitle.TextXAlignment = Enum.TextXAlignment.Left

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1,-20,0,30)
SearchBox.Position = UDim2.new(0,10,0,30)
SearchBox.BackgroundColor3 = Color3.fromRGB(15,12,35)
SearchBox.TextColor3 = Color3.new(1,1,1)
SearchBox.PlaceholderText = "Chercher un animal..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(120,100,160)
SearchBox.Text = ""
SearchBox.TextSize = 14
SearchBox.Font = Enum.Font.Gotham
SearchBox.ClearTextOnFocus = false
SearchBox.ZIndex = 22
SearchBox.Parent = SearchSection
uicorner(SearchBox, 7)
uistroke(SearchBox, Color3.fromRGB(100,80,200), 1)

local SearchResults = Instance.new("ScrollingFrame")
SearchResults.Size = UDim2.new(1,-14,1,-68)
SearchResults.Position = UDim2.new(0,7,0,66)
SearchResults.BackgroundTransparency = 1
SearchResults.ScrollBarThickness = 4
SearchResults.ScrollBarImageColor3 = Color3.fromRGB(100,80,200)
SearchResults.BorderSizePixel = 0
SearchResults.ZIndex = 22
SearchResults.Parent = SearchSection
local SearchLayout = Instance.new("UIListLayout")
SearchLayout.SortOrder = Enum.SortOrder.LayoutOrder
SearchLayout.Padding = UDim.new(0,3)
SearchLayout.Parent = SearchResults

-- ═══ BOUTON CONFIRMER ═══
local ConfirmBtn = Instance.new("TextButton")
ConfirmBtn.Size = UDim2.new(0, WIN_W - 28, 0, 38)
ConfirmBtn.Position = UDim2.new(0, 14, 1, -48)
ConfirmBtn.BackgroundColor3 = Color3.fromRGB(60,160,60)
ConfirmBtn.Text = "✅  Confirmer et appliquer la recette"
ConfirmBtn.TextColor3 = Color3.new(1,1,1)
ConfirmBtn.TextScaled = true
ConfirmBtn.Font = Enum.Font.GothamBold
ConfirmBtn.ZIndex = 22
ConfirmBtn.Parent = Window
uicorner(ConfirmBtn, 10)
uistroke(ConfirmBtn, Color3.fromRGB(40,200,40), 1.5)

-- ════════════════════════════════════════════
-- ÉTAT DE LA GUI
-- ════════════════════════════════════════════
local ingredientEntries = {}   -- liste des { frame, nameLabel, removeBtn, animalName }
local currentResultAnimal = nil
local activeIngredientTarget = nil  -- "result" ou index dans ingredientEntries
local allAnimals = {}  -- cache animaux chargé depuis serveur

-- Mettre à jour RecipeScroll.CanvasSize
local function updateRecipeCanvas()
    local count = #ingredientEntries
    RecipeScroll.CanvasSize = UDim2.new(0,0,0, count * 36 + (count-1)*4)
end

-- Rareté sélectionnée
local function selectRarity(rarity)
    selectedRarity = rarity
    for r, btn in pairs(rarityButtons) do
        if r == rarity then
            btn.BackgroundColor3 = (RARITY_COLORS[r] or Color3.fromRGB(150,100,255))
            btn.TextColor3 = Color3.new(1,1,1)
        else
            btn.BackgroundColor3 = Color3.fromRGB(30,25,60)
            btn.TextColor3 = RARITY_COLORS[r] or Color3.new(1,1,1)
        end
    end
    -- Mettre à jour le temps par défaut selon rareté
    local defaults = {Epic=420, Legendary=900, Mythic=1800, ["Brainrot God"]=2700, Secret=5400, OG=8800, Cosmic=3600}
    TimeBox.Text = tostring(defaults[rarity] or 900)
end
selectRarity("Legendary")

for rarity, btn in pairs(rarityButtons) do
    btn.MouseButton1Click:Connect(function()
        selectRarity(rarity)
    end)
end

-- Ajouter une ligne ingrédient
local function addIngredientRow(animalName)
    local idx = #ingredientEntries + 1
    
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,0,0,32)
    row.BackgroundColor3 = Color3.fromRGB(30,24,58)
    row.BorderSizePixel = 0
    row.LayoutOrder = idx
    row.ZIndex = 23
    row.Parent = RecipeScroll
    uicorner(row, 7)
    uistroke(row, Color3.fromRGB(80,60,140), 1)

    local numLbl = label(row, tostring(idx)..".", 13, Color3.fromRGB(180,160,255), Enum.Font.GothamBold, 24)
    numLbl.Size = UDim2.new(0,22,1,0)
    numLbl.Position = UDim2.new(0,4,0,0)
    numLbl.TextXAlignment = Enum.TextXAlignment.Center

    local nameLbl = Instance.new("TextButton")
    nameLbl.Size = UDim2.new(1,-68,1,0)
    nameLbl.Position = UDim2.new(0,26,0,0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.TextColor3 = animalName and Color3.fromRGB(100,255,160) or Color3.fromRGB(180,140,255)
    nameLbl.Text = animalName or "— cliquer pour choisir —"
    nameLbl.TextScaled = true
    nameLbl.Font = Enum.Font.Gotham
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.ZIndex = 24
    nameLbl.Parent = row

    local removeBtn = Instance.new("TextButton")
    removeBtn.Size = UDim2.new(0,28,0,22)
    removeBtn.Position = UDim2.new(1,-34,0.5,-11)
    removeBtn.BackgroundColor3 = Color3.fromRGB(160,30,30)
    removeBtn.Text = "✕"
    removeBtn.TextColor3 = Color3.new(1,1,1)
    removeBtn.TextScaled = true
    removeBtn.Font = Enum.Font.GothamBold
    removeBtn.ZIndex = 24
    removeBtn.Parent = row
    uicorner(removeBtn, 5)

    local entry = { frame = row, nameLabel = nameLbl, numLabel = numLbl, animalName = animalName }
    table.insert(ingredientEntries, entry)
    updateRecipeCanvas()

    -- Clic sur le nom → activer la recherche pour cet ingrédient
    nameLbl.MouseButton1Click:Connect(function()
        activeIngredientTarget = idx
        SearchBox.Text = ""
        SearchBox:CaptureFocus()
        -- Highlight
        for i, e in ipairs(ingredientEntries) do
            e.frame.BackgroundColor3 = (i == idx) 
                and Color3.fromRGB(50,35,90) 
                or Color3.fromRGB(30,24,58)
        end
    end)

    -- Supprimer
    removeBtn.MouseButton1Click:Connect(function()
        table.remove(ingredientEntries, idx)
        row:Destroy()
        -- Renuméroter
        for i, e in ipairs(ingredientEntries) do
            e.frame.LayoutOrder = i
            e.numLabel.Text = tostring(i).."."
        end
        updateRecipeCanvas()
    end)
end

-- Bouton ajouter ingrédient
AddIngredientBtn.MouseButton1Click:Connect(function()
    addIngredientRow(nil)
end)

-- ════════════════════════════════════════════
-- RECHERCHE D'ANIMAUX
-- ════════════════════════════════════════════
local function clearSearchResults()
    for _, c in ipairs(SearchResults:GetChildren()) do
        if c:IsA("GuiObject") then c:Destroy() end
    end
end

local function displaySearchResults(results)
    clearSearchResults()
    local h = 0
    for i, animal in ipairs(results) do
        if i > 30 then break end
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,0,0,28)
        btn.BackgroundColor3 = Color3.fromRGB(28,22,55)
        btn.Text = animal.name .. "  ·  " .. animal.rarity
        btn.TextColor3 = RARITY_COLORS[animal.rarity] or Color3.new(1,1,1)
        btn.TextScaled = true
        btn.Font = Enum.Font.Gotham
        btn.LayoutOrder = i
        btn.ZIndex = 23
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = SearchResults
        uicorner(btn, 6)
        local pad = Instance.new("UIPadding"); pad.PaddingLeft = UDim.new(0,8); pad.Parent = btn

        btn.MouseButton1Click:Connect(function()
            if activeIngredientTarget == "result" then
                currentResultAnimal = animal.name
                ResultBox.Text = animal.name
                ResultStatus.Text = "✓ " .. animal.rarity
                ResultStatus.TextColor3 = RARITY_COLORS[animal.rarity] or Color3.fromRGB(100,255,150)
                activeIngredientTarget = nil
            elseif activeIngredientTarget and ingredientEntries[activeIngredientTarget] then
                local entry = ingredientEntries[activeIngredientTarget]
                entry.animalName = animal.name
                entry.nameLabel.Text = animal.name
                entry.nameLabel.TextColor3 = RARITY_COLORS[animal.rarity] or Color3.fromRGB(100,255,160)
                entry.frame.BackgroundColor3 = Color3.fromRGB(30,24,58)
                activeIngredientTarget = nil
            end
        end)
        h += 31
    end
    SearchResults.CanvasSize = UDim2.new(0,0,0,h)
end

local searchDebounce = false
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = SearchBox.Text:lower()
    if #query < 2 then clearSearchResults() return end
    if searchDebounce then return end
    searchDebounce = true
    task.delay(0.15, function()
        searchDebounce = false
        local results = SearchAnimals:InvokeServer(query)
        if results then displaySearchResults(results) end
    end)
end)

-- Clic sur ResultBox → mode "résultat"
ResultBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = ResultBox.Text:lower()
    if #query < 2 then return end
    activeIngredientTarget = "result"
    SearchBox.Text = ResultBox.Text
end)

ResultBox.Focused:Connect(function()
    activeIngredientTarget = "result"
end)

-- ════════════════════════════════════════════
-- CONFIRMER
-- ════════════════════════════════════════════
local function showStatus(msg, color)
    ConfirmBtn.Text = msg
    ConfirmBtn.BackgroundColor3 = color or Color3.fromRGB(60,160,60)
    task.delay(2.5, function()
        ConfirmBtn.Text = "✅  Confirmer et appliquer la recette"
        ConfirmBtn.BackgroundColor3 = Color3.fromRGB(60,160,60)
    end)
end

ConfirmBtn.MouseButton1Click:Connect(function()
    if not currentResultAnimal or currentResultAnimal == "" then
        showStatus("❌ Choisis un animal résultat !", Color3.fromRGB(180,40,40))
        return
    end
    local recipe = {}
    for _, entry in ipairs(ingredientEntries) do
        if entry.animalName and entry.animalName ~= "" then
            table.insert(recipe, entry.animalName)
        end
    end
    if #recipe == 0 then
        showStatus("❌ Ajoute au moins 1 ingrédient !", Color3.fromRGB(180,40,40))
        return
    end
    local cost = tonumber(CostBox.Text) or 500000
    local craftTime = tonumber(TimeBox.Text) or 900

    SubmitRecipe:FireServer({
        result   = currentResultAnimal,
        rarity   = selectedRarity,
        recipe   = recipe,
        cost     = cost,
        craftTime = craftTime,
        global   = isGlobal,
    })
    showStatus("⏳ Application...", Color3.fromRGB(60,100,200))
end)

-- ════════════════════════════════════════════
-- OPEN / CLOSE
-- ════════════════════════════════════════════
local function openMenu()
    -- Reset
    currentResultAnimal = nil
    ResultBox.Text = ""
    ResultStatus.Text = ""
    activeIngredientTarget = nil
    for _, e in ipairs(ingredientEntries) do e.frame:Destroy() end
    ingredientEntries = {}
    clearSearchResults()
    selectRarity("Legendary")
    -- Ajouter 2 ingrédients par défaut
    addIngredientRow(nil)
    addIngredientRow(nil)
    -- Animer
    SG.Enabled = true
    Window.Position = UDim2.new(0.5,-WIN_W/2, 0.4,-WIN_H/2)
    Window.BackgroundTransparency = 1
    TweenService:Create(Window, TweenInfo.new(0.22, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5,-WIN_W/2, 0.5,-WIN_H/2),
        BackgroundTransparency = 0
    }):Play()
end

local function closeMenu()
    TweenService:Create(Window, TweenInfo.new(0.15), {
        Position = UDim2.new(0.5,-WIN_W/2, 0.6,-WIN_H/2),
        BackgroundTransparency = 1
    }):Play()
    task.delay(0.18, function()
        SG.Enabled = false
    end)
end

CloseBtn.MouseButton1Click:Connect(closeMenu)
Overlay.MouseButton1Click:Connect(closeMenu)
OpenMenu.OnClientEvent:Connect(openMenu)

-- ════════════════════════════════════════════
-- RÉPONSE SERVEUR
-- ════════════════════════════════════════════
local Confirmed = netFolder:WaitForChild("RE/CraftBuilder/Confirmed")
Confirmed.OnClientEvent:Connect(function(success, msg)
    if success then
        showStatus("✅ " .. (msg or "Recette appliquée !"), Color3.fromRGB(40,180,40))
        task.delay(1.5, closeMenu)
    else
        showStatus("❌ " .. (msg or "Erreur"), Color3.fromRGB(180,40,40))
    end
end)
