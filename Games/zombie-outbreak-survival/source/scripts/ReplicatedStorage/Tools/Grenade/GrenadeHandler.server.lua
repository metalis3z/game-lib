local tool = script.Parent
local handle = tool:FindFirstChild("Handle")
local explodeSound = handle and handle:FindFirstChild("ExplodeSound")
local cooldown = 3
local coolingDown = false
local explodesIn = 3
local mouseCF = nil

local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local character = nil
local player = nil

-- Helper: Check if a model is a player character
local function isPlayerCharacter(model)
    if not model or not model:IsA("Model") then return false end
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Name ~= "Zombie" then
        for k, p in Players:GetPlayers() do
            if p.Character == model then
                return true
            end
        end
    end
    return false
end

-- Helper: Check if a model is a zombie
local function isZombie(model)
    if not model or not model:IsA("Model") then return false end
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Name == "Zombie" and humanoid.Health > 0
end

-- Helper: Tagging logic for kill attribution
local function TagHumanoid(humanoid, player)
    local tag = Instance.new("ObjectValue")
    tag.Name = "creator"
    tag.Value = player
    Debris:AddItem(tag, 2)
    tag.Parent = humanoid
end

local function UntagHumanoid(humanoid)
    for k, v in humanoid:GetChildren() do
        if v:IsA("ObjectValue") and v.Name == "creator" then
            v:Destroy()
        end
    end
end

-- Helper: Check if player is alive and ready
local function CheckIfAlive()
    return (player and player.Parent and character and character.Parent)
        and (character:FindFirstChildOfClass("Humanoid") and character:FindFirstChildOfClass("Humanoid").Health > 0)
        and (character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart"))
end

-- Equip/Unequip logic
tool.Equipped:Connect(function()
    character = tool.Parent
    player = Players:GetPlayerFromCharacter(character)
end)

tool.Unequipped:Connect(function()
    character = nil
    player = nil
end)

-- Get mouse position from client
local mouseInfoRE = tool:FindFirstChild("MouseInfoRE")
if mouseInfoRE then
    mouseInfoRE.OnServerEvent:Connect(function(plr, mouseHit)
        if plr == player then
            mouseCF = mouseHit
        end
    end)
end

-- Main grenade throw logic
tool.Activated:Connect(function()
    if coolingDown or not character or not mouseCF or not CheckIfAlive() then return end

    -- Prevent throwing if aiming at a player
    local ray = Ray.new(handle.Position, mouseCF.LookVector * 100)
    local ignoreList = {character, handle}
    local targetPart = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
    if targetPart and isPlayerCharacter(targetPart.Parent) then
        return -- Don't throw at players
    end

    coolingDown = true

    -- Play throw animation if available
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid and script:FindFirstChild("ThrowAnim") then
        local anim = humanoid:LoadAnimation(script.ThrowAnim)
        anim:Play()
    end

    task.wait(0.1)

    -- Clone grenade and throw
    local clone = handle:Clone()
    clone.Transparency = 0
    clone.CanCollide = true
    clone.Parent = workspace
    clone.Position = handle.Position

    -- Hide original handle
    handle.Transparency = 1

    -- Add velocity to grenade
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = mouseCF.LookVector * 100
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.Parent = clone

    -- Explosion logic
    coroutine.wrap(function()
        task.wait(explodesIn)
        -- Create explosion effect
        local explosion = Instance.new("Explosion")
        explosion.Position = clone.Position
        explosion.BlastRadius = 8
        explosion.BlastPressure = 0 -- Don't fling parts
        explosion.Parent = workspace

        -- Only damage zombies (humanoid named "Zombie")
        explosion.Hit:Connect(function(part, distance)
            local zombieChar = part.Parent
            if isZombie(zombieChar) then
                local humanoid = zombieChar:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    UntagHumanoid(humanoid)
                    TagHumanoid(humanoid, player)
                    humanoid.Health = 0 -- Classic Sword logic: instant kill
                end
            end
        end)

        -- Play explosion sound
        if clone:FindFirstChild("ExplodeSound") then
            clone.ExplodeSound:Play()
        end

        Debris:AddItem(clone, 1)
        task.wait(1)
        if clone and clone.Parent then
            clone:Destroy()
        end

        -- Remove the weapon from the player's inventory after the explosion
        if tool and tool.Parent then
            -- Remove from Backpack if still there
            if player and player:FindFirstChild("Backpack") and tool.Parent == player.Backpack then
                tool.Parent = nil
            end
            -- Remove from character if still equipped
            if character and tool.Parent == character then
                tool.Parent = nil
            end
            -- Destroy the tool to prevent reuse
            tool:Destroy()
        end
    end)()

    task.wait(0.1)
    bv:Destroy()

    task.wait(cooldown - 0.2)
    handle.Transparency = 0
    coolingDown = false
end)

-- Modernize particle emitters for thumbnail
for k, v in handle:GetChildren() do
    if v:IsA("ParticleEmitter") then
        v.Rate = 20
    end
end