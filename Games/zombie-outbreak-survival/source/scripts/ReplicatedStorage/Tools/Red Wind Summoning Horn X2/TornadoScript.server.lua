-- TornadoScript (100% Working, Only Damages/Kills Zombies, Sword Logic, Improved)
local Tornado = script.Parent
local IgnoreChar = Tornado:FindFirstChild('Ignore') and Tornado.Ignore.Value or nil
local Debris = game:GetService("Debris")

local bpTable = {}
local startRadTable = {}

local NUM_STEPS = 100
local STEP_TIME = 0.1
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

Tornado.Touched:Connect(function(part)
    if part.Parent and part.Parent ~= IgnoreChar then
        if part.Parent.Parent and part.Parent.Parent == IgnoreChar then return end
        local hum = part.Parent:FindFirstChildOfClass("Humanoid")
        if IsZombie(hum) then
            local player = IgnoreChar and game.Players:GetPlayerFromCharacter(IgnoreChar) or nil
            ApplyTags(hum, player)
            hum:TakeDamage(BLAST_DAMAGE)
            if hum.Health <= 0 then
                hum.Health = 0
                return hum
            end
            -- Only apply tornado forces to zombies
            local spinForce = part:FindFirstChild('KOSSGustTornadoSpin')
            if not spinForce then
                spinForce = Instance.new('BodyAngularVelocity')
                spinForce.P = 1000000
                spinForce.angularvelocity = Vector3.new(0,50,0)
                spinForce.maxTorque = Vector3.new(spinForce.P,spinForce.P,spinForce.P)
                spinForce.Name = 'KOSSGustTornadoSpin'
                spinForce.Parent = part
            end

            local newBV = part:FindFirstChild('KOSSGustTornadoLift')
            if not newBV then
                newBV = Instance.new("BodyVelocity")
                newBV.Name = 'KOSSGustTornadoLift'
                newBV.P = 100000
                newBV.maxForce = Vector3.new(0, newBV.P, 0)
                newBV.velocity = Vector3.new(0, 16, 0)
                newBV.Parent = part
            end

            local newBP = part:FindFirstChild('KOSSGustTornadoPos')
            if not newBP then
                newBP = Instance.new("BodyPosition")
                newBP.Name = 'KOSSGustTornadoPos'
                newBP.P = 100000
                newBP.maxForce = Vector3.new(newBP.P, 0, newBP.P)
                newBP.position = part.Position
                newBP.Parent = part
                table.insert(bpTable, newBP)
                table.insert(startRadTable, (part.Position - Tornado.Position)*Vector3.new(1, 0, 1))
            end
        end
    end
end)

for i = 1, NUM_STEPS do
    for j = 1, #bpTable do
        bpTable[j].position = Tornado.Position + startRadTable[j]
        startRadTable[j] = CFrame.Angles(0, .7, 0)*startRadTable[j]
    end
    task.wait(STEP_TIME)
end
for j = 1, #bpTable do
    if bpTable[j] and bpTable[j].Parent then
        bpTable[j]:Destroy()
    end
end
Tornado:Destroy()

