-- EventsAndAnims (Fully Working, Expanded, Robust)
local Tool = script.Parent
local Handle = Tool:FindFirstChild('Handle')
local RemoteEvent = Tool:FindFirstChild('RemoteEvent')

local Anims = {}
local BlowSound

local TIME_BEFORE_SOUND = 0.5
local TIME_BETWEEN_USES = 20

local function Play(animationName)
    if not Anims[animationName] then
        local humanoid = Tool.Parent:FindFirstChild('Humanoid')
        if humanoid and humanoid:IsA('Humanoid') then
            local unloadedAnim = Tool:FindFirstChild(animationName)
            if unloadedAnim then
                Anims[animationName] = humanoid:LoadAnimation(unloadedAnim)
            end
        end
    end
    if Anims[animationName] then
        Anims[animationName]:Play()
    end
end

local function Stop(animationName)
    if Anims[animationName] then
        Anims[animationName]:Stop()
    end
end

function OnActivated()
    if Tool.Enabled then
        Tool.Enabled = false
        task.delay(TIME_BETWEEN_USES, function()
            Tool.Enabled = true
        end)

        local character = Tool.Parent
        local humanoid = character:FindFirstChild('Humanoid')
        if character and humanoid then
            Play('BlowAnim')
            task.wait(TIME_BEFORE_SOUND)
            BlowSound = Handle and Handle:FindFirstChild('BlowSound')
            if BlowSound then BlowSound:Play() end
            if RemoteEvent then
                RemoteEvent:FireServer()
            end
        end
    end
end

function OnEquipped() end

function OnUnequipped()
    Stop('BlowAnim')
    if BlowSound then BlowSound:Stop() end
end

Tool.Equipped:Connect(OnEquipped)
Tool.Activated:Connect(OnActivated)
Tool.Unequipped:Connect(OnUnequipped)

