-- GustHornServerScript (Fully Working, Only Damages/Kills Zombies, Sword Logic)
local TornadoScript = script.Parent:FindFirstChild('TornadoScript')
local RemoteEvent = script.Parent:FindFirstChild('RemoteEvent')
local Debris = game:GetService("Debris")

local TIME_BETWEEN_USES = 20
local TORNADO_RADIUS = 15
local TORNADO_HEIGHT = 200
local TORNADO_SPEED = 40
local TORNADO_TIME = 10
local SPACE_BETWEEN_TORNADOES = 5
local NUM_TORNADOES = 2
local GRAVITY = 196.2
local TORSO_HEIGHT = 3
local BLAST_DAMAGE = 100 -- Sword-like damage

local function ApplyTags(humanoid, player)
    if humanoid and player then
        local tag = Instance.new("ObjectValue")
        tag.Name = "creator"
        tag.Value = player
        Debris:AddItem(tag, 2)
        tag.Parent = humanoid
    end
end

local function IsZombie(humanoid)
    return humanoid and humanoid.Name == "Zombie" and humanoid.Health > 0
end

RemoteEvent.OnServerEvent:Connect(function(player)
    local tool = script.Parent
    if not tool or not tool.Parent then return end
    local character = tool.Parent
    local humanoid = character:FindFirstChild("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not hrp or humanoid.Health <= 0 then return end

    local rightVector = hrp.CFrame.lookVector:Cross(Vector3.new(0,1,0))
    for i = 1, NUM_TORNADOES do
        local tornadoClone = Instance.new("Part")
        tornadoClone.Name = "Tornado"
        tornadoClone.FormFactor = Enum.FormFactor.Symmetric
        tornadoClone.CanCollide = false
        tornadoClone.Size = Vector3.new(TORNADO_RADIUS, TORNADO_HEIGHT, TORNADO_RADIUS)
        tornadoClone.BrickColor = BrickColor.new('Bright red')
        tornadoClone.Transparency = 0.4
        local CylinderMesh = Instance.new('CylinderMesh')
        CylinderMesh.Parent = tornadoClone
        local BodyVelocity = Instance.new('BodyVelocity')
        BodyVelocity.Parent = tornadoClone
        BodyVelocity.maxForce = Vector3.new(1E6,0,1E6)
        BodyVelocity.P = 1E6
        local BodyForce = Instance.new('BodyForce')
        BodyForce.force = Vector3.new(0, GRAVITY * tornadoClone:GetMass(), 0)
        BodyForce.Parent = tornadoClone
        local Ignore = Instance.new('ObjectValue')
        Ignore.Name = 'Ignore'
        Ignore.Value = character
        Ignore.Parent = tornadoClone
        local tornadoScriptClone = TornadoScript:Clone()
        tornadoScriptClone.Disabled = false
        tornadoScriptClone.Parent = tornadoClone

        tornadoClone.Parent = workspace
        local position = hrp.Position + Vector3.new(0, TORNADO_HEIGHT/2 - TORSO_HEIGHT, 0) + (i - (NUM_TORNADOES + 1) / 2) * (TORNADO_RADIUS + SPACE_BETWEEN_TORNADOES) * rightVector
        tornadoClone.CFrame = CFrame.new(position)
        tornadoClone:WaitForChild('BodyVelocity').velocity = TORNADO_SPEED * hrp.CFrame.lookVector

        tornadoClone.Touched:Connect(function(part)
            local parentModel = part.Parent
            if parentModel and parentModel ~= character then
                local hum = parentModel:FindFirstChildOfClass("Humanoid")
                if IsZombie(hum) then
                    ApplyTags(hum, player)
                    hum:TakeDamage(BLAST_DAMAGE)
                    if hum.Health <= 0 then
                        hum.Health = 0
                        return hum
                    end
                end
            end
        end)
    end
end)