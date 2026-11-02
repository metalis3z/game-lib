-- RagdollFailsafe v2 - Détecte les joueurs bloqués au sol
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

local MAX_RAGDOLL_TIME = 4  -- secondes max en ragdoll avant force-unlock
local MAX_STUCK_TIME   = 3  -- secondes bloqué sans bouger = stuck

local platformStandTimers = {}
local positionTrackers    = {}  -- détecter si le joueur ne bouge plus

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        platformStandTimers[player.UserId] = nil
        positionTrackers[player.UserId]    = nil

        local humanoid = character:WaitForChild("Humanoid", 5)
        if not humanoid then return end
        local hrp = character:WaitForChild("HumanoidRootPart", 5)
        if not hrp then return end

        humanoid:GetPropertyChangedSignal("PlatformStand"):Connect(function()
            if humanoid.PlatformStand then
                platformStandTimers[player.UserId] = tick()
                -- Tracker la position pour détecter si bloqué
                positionTrackers[player.UserId] = {
                    pos = hrp.Position,
                    time = tick()
                }
            else
                platformStandTimers[player.UserId] = nil
                positionTrackers[player.UserId]    = nil
            end
        end)
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    platformStandTimers[player.UserId] = nil
    positionTrackers[player.UserId]    = nil
end)

local function forceUnstuck(player)
    platformStandTimers[player.UserId] = nil
    positionTrackers[player.UserId]    = nil
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end

    warn("[RagdollFailsafe] Force-unlock:", player.Name)
    pcall(function()
        Ragdoll.Unragdoll(char)
        hum.PlatformStand = false
        hum.Sit = false
    end)
    player:SetAttribute("Ragdolled", nil)
    player:SetAttribute("RagdollEndTime", nil)

    -- Si toujours bloqué après 1s, reset forcé
    task.delay(1, function()
        if not player or not player.Parent then return end
        local char2 = player.Character
        if not char2 then return end
        local hum2 = char2:FindFirstChildOfClass("Humanoid")
        if hum2 and hum2.PlatformStand and hum2.Health > 0 then
            warn("[RagdollFailsafe] Reset forcé:", player.Name)
            hum2.Health = 0
        end
    end)
end

task.spawn(function()
    while true do
        task.wait(0.5)
        local now = tick()

        for _, player in ipairs(Players:GetPlayers()) do
            local startTime = platformStandTimers[player.UserId]
            if startTime and (now - startTime) > MAX_RAGDOLL_TIME then
                forceUnstuck(player)
                continue
            end

            -- Détecter si le joueur est bloqué au sol sans bouger
            local tracker = positionTrackers[player.UserId]
            if tracker and startTime then
                local char = player.Character
                local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (hrp.Position - tracker.pos).Magnitude
                    if dist < 0.5 then
                        -- N'a pas bougé
                        if (now - tracker.time) > MAX_STUCK_TIME then
                            forceUnstuck(player)
                        end
                    else
                        -- A bougé, reset le tracker
                        positionTrackers[player.UserId] = {
                            pos  = hrp.Position,
                            time = now
                        }
                    end
                end
            end
        end
    end
end)
