local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Net       = require(ReplicatedStorage.Packages.Net)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove     = require(ReplicatedStorage.Packages.Trove)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)

local ColorDiceMachineController = {}

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local COLOR_DATA = {
    {name="Red",    display="Rouge",  color=Color3.fromRGB(220,50,50)},
    {name="Blue",   display="Bleu",   color=Color3.fromRGB(50,110,220)},
    {name="Green",  display="Vert",   color=Color3.fromRGB(40,190,70)},
    {name="Yellow", display="Jaune",  color=Color3.fromRGB(235,195,20)},
    {name="Purple", display="Violet", color=Color3.fromRGB(155,50,220)},
    {name="Orange", display="Orange", color=Color3.fromRGB(235,120,25)},
}
local COLOR_MAP = {}
for i, cd in ipairs(COLOR_DATA) do COLOR_MAP[cd.name] = cd end

local DeliveryRF = Net:RemoteFunction("ColorDice/Delivery")
local OpenRE     = Net:RemoteEvent("ColorDice/Open")
local RollRF     = Net:RemoteFunction("ColorDice/Roll")

function ColorDiceMachineController:Load() end

function ColorDiceMachineController:Start()
    local sg = playerGui:WaitForChild("ColorDiceMachineGui", 15)
    if not sg then warn("[ColorDice] GUI not found"); return end

    local mainFrame   = sg:WaitForChild("Main")
    local diceFrame   = sg:WaitForChild("DiceFrame")
    local card        = mainFrame:WaitForChild("BrainrotCard")
    local vp          = card:WaitForChild("Viewport")
    local animalLbl   = card:WaitForChild("AnimalName")
    local mutLbl      = card:WaitForChild("MutationLabel")
    local colorsC     = mainFrame:WaitForChild("ColorsContainer")
    local confirmBtn  = mainFrame:WaitForChild("ConfirmBtn")
    local closeBtn    = mainFrame:WaitForChild("CloseBtn")
    local diceTitleBg = diceFrame:WaitForChild("TitleBg")
    local diceTitleLbl= diceTitleBg:WaitForChild("DiceTitle")
    local diceC       = diceFrame:WaitForChild("DiceContainer")
    local resultLbl   = diceFrame:WaitForChild("ResultLabel")
    local diceCloseBtn= diceFrame:WaitForChild("DiceCloseBtn")

    local diceVisuals = {}
    for i = 1, 3 do
        local die = diceC:WaitForChild("Die"..i)
        diceVisuals[i] = {
            frame      = die,
            label      = die:WaitForChild("Label"),
            strip      = die:WaitForChild("ColorStrip"),
            winStroke  = die:WaitForChild("WinStroke"),
        }
    end

    -- State
    local selectedColor   = nil
    local currentAnimal   = nil  -- animalData table
    local isRolling       = false
    local animalInMachine = false  -- true once delivery confirmed

    -- ========== COLOR BUTTONS ==========
    local colorBtns = {}
    for _, cd in ipairs(COLOR_DATA) do
        local btn = colorsC:FindFirstChild(cd.name)
        if not btn then continue end
        colorBtns[cd.name] = btn

        btn.MouseButton1Click:Connect(function()
            if isRolling then return end
            for _, b in pairs(colorBtns) do
                local s = b:FindFirstChild("SelectStroke")
                local ch = b:FindFirstChild("Check")
                if s then s.Thickness = 0 end
                if ch then ch.Visible = false end
                TweenService:Create(b, TweenInfo.new(0.1), {Size=UDim2.new(0,84,0,102)}):Play()
            end
            selectedColor = cd.name
            local s = btn:FindFirstChild("SelectStroke")
            local ch = btn:FindFirstChild("Check")
            if s then s.Thickness = 3 end
            if ch then ch.Visible = true end
            TweenService:Create(btn, TweenInfo.new(0.1), {Size=UDim2.new(0,90,0,108)}):Play()
        end)
    end

    -- ========== OPEN / CLOSE ==========
    local function resetColorBtns()
        selectedColor = nil
        for _, b in pairs(colorBtns) do
            local s = b:FindFirstChild("SelectStroke")
            local ch = b:FindFirstChild("Check")
            if s then s.Thickness = 0 end
            if ch then ch.Visible = false end
            local cd = COLOR_MAP[b.Name]
            if cd then TweenService:Create(b, TweenInfo.new(0.1), {Size=UDim2.new(0,84,0,102)}):Play() end
        end
    end

    local function populateGui(animalData)
        currentAnimal = animalData
        animalLbl.Text = animalData.Index or "?"
        mutLbl.Text = animalData.Mutation and ("Mutation : "..animalData.Mutation) or "Sans mutation"
        vp:ClearAllChildren()
        local cam = Instance.new("Camera"); cam.Parent = vp; vp.CurrentCamera = cam
        pcall(SharedAnimals.AttachOnViewport, SharedAnimals, animalData.Index, vp, animalData.Mutation, animalData.Traits)
        resetColorBtns()
        mainFrame.Visible = true
    end

    local function closeGui()
        mainFrame.Visible = false
        resetColorBtns()
    end

    closeBtn.MouseButton1Click:Connect(closeGui)

    -- ========== SERVER OPENS GUI after delivery ==========
    OpenRE.OnClientEvent:Connect(function(animalData)
        animalInMachine = true
        populateGui(animalData)
    end)

    -- ========== observeTag("ColorDiceMachine") → Hitbox Touched ==========
    -- Exactly like FuseMachineController: connect Touched on all hitboxes
    Observers.observeTag("ColorDiceMachine", function(machineModel)
        local trove = Trove.new()
        local hitboxes = machineModel:FindFirstChild("Hitboxes")
        if not hitboxes then return function() trove:Destroy() end end

        for _, hitbox in ipairs(hitboxes:GetChildren()) do
            trove:Add(hitbox.Touched:Connect(function(part)
                -- Must be HumanoidRootPart of local player
                if part.Name ~= "HumanoidRootPart" then return end
                local touchPlayer = Players:GetPlayerFromCharacter(part.Parent)
                if not touchPlayer or touchPlayer ~= player then return end

                -- Must be carrying a brainrot (like FuseMachineController checks StealingIndex)
                local stealingIndex = player:GetAttribute("StealingIndex")
                if not stealingIndex or stealingIndex == "" then return end

                -- Don't re-trigger if already delivered
                if animalInMachine then return end

                -- Call server delivery (same as FuseMachineController calling Delivery:InvokeServer)
                local ok = DeliveryRF:InvokeServer(hitbox)
                if ok then
                    animalInMachine = true
                    -- Server fires OpenRE to show GUI
                end
            end))
        end

        return function() trove:Destroy() end
    end)

    -- ========== observeTag("ColorDiceMachinePrompt") → re-open GUI if animal in machine ==========
    Observers.observeTag("ColorDiceMachinePrompt", function(promptPart)
        local pp = promptPart:FindFirstChildOfClass("ProximityPrompt")
        if not pp then return end
        local conn = pp.Triggered:Connect(function(triggerPlayer)
            if triggerPlayer ~= player then return end
            if isRolling then return end
            -- Only open if there's already an animal in the machine
            if animalInMachine and currentAnimal then
                if mainFrame.Visible then
                    closeGui()
                else
                    populateGui(currentAnimal)
                end
            end
        end)
        return function() conn:Disconnect() end
    end)

    -- ========== CONFIRM BUTTON → ROLL ==========
    confirmBtn.MouseButton1Click:Connect(function()
        if not selectedColor then return end
        if not animalInMachine then return end
        if isRolling then return end

        isRolling = true
        mainFrame.Visible = false

        local rollOk, results, won, animalName = RollRF:InvokeServer(selectedColor)
        if not rollOk then
            isRolling = false
            animalInMachine = false
            return
        end

        -- Reset
        animalInMachine = false
        currentAnimal   = nil

        -- Show dice frame
        diceFrame.Visible = true
        diceCloseBtn.Visible = false
        resultLbl.Text = ""
        diceTitleLbl.Text = "🎲 LES DÉS TOURNENT..."
        diceTitleLbl.TextColor3 = Color3.fromRGB(210,170,255)

        for _, dv in ipairs(diceVisuals) do
            dv.frame.BackgroundColor3 = Color3.fromRGB(38,36,58)
            dv.label.Text = "?"
            dv.strip.BackgroundColor3 = Color3.fromRGB(80,80,120)
            dv.winStroke.Thickness = 0
        end

        -- Spin ~2.5s
        local spinEnd = tick() + 2.5
        while tick() < spinEnd do
            for _, dv in ipairs(diceVisuals) do
                local rd = COLOR_DATA[math.random(1, #COLOR_DATA)]
                TweenService:Create(dv.frame, TweenInfo.new(0.04), {BackgroundColor3 = rd.color}):Play()
                dv.label.Text = rd.display
                dv.strip.BackgroundColor3 = rd.color:Lerp(Color3.new(0,0,0), 0.45)
            end
            task.wait(0.06)
        end

        -- Reveal one by one
        for i, dv in ipairs(diceVisuals) do
            local fc = results[i]
            local cd = COLOR_MAP[fc]
            local finalColor = cd and cd.color or Color3.fromRGB(180,180,180)
            local displayName = cd and cd.display or fc

            TweenService:Create(dv.frame, TweenInfo.new(0.18), {BackgroundColor3 = finalColor}):Play()
            dv.label.Text = displayName
            dv.strip.BackgroundColor3 = finalColor:Lerp(Color3.new(0,0,0), 0.45)
            if fc == selectedColor then
                dv.winStroke.Thickness = 4
            end
            task.wait(0.42)
        end

        task.wait(0.3)

        if won then
            diceTitleLbl.Text = "🎉 GAGNÉ !"
            diceTitleLbl.TextColor3 = Color3.fromRGB(80,240,110)
            resultLbl.Text = (animalName or "?").." a été dupliqué dans ta base !"
            resultLbl.TextColor3 = Color3.fromRGB(80,240,110)
        else
            diceTitleLbl.Text = "💀 PERDU !"
            diceTitleLbl.TextColor3 = Color3.fromRGB(240,65,65)
            resultLbl.Text = (animalName or "?").." a disparu de ta base..."
            resultLbl.TextColor3 = Color3.fromRGB(240,65,65)
        end

        diceCloseBtn.Visible = true
        isRolling = false
        resetColorBtns()
    end)

    diceCloseBtn.MouseButton1Click:Connect(function()
        diceFrame.Visible = false
    end)
end

return ColorDiceMachineController
