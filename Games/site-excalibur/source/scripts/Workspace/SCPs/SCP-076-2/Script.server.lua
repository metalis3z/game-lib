local larm = script.Parent:FindFirstChild("HumanoidRootPart")
local rarm = script.Parent:FindFirstChild("HumanoidRootPart")
local hum = script.Parent:FindFirstChild("Item")
local anim = hum:LoadAnimation(script.Parent["058attack1"])
local anim2 = hum:LoadAnimation(script.Parent["058attack2"])
local attackdb = false

local anims = {"whip","sting"}

function attackAnim() -- type this in attack function: attackAnim()
local randomanim = anims[math.random(1,#anims)]
if randomanim == "whip" then
anim:Play()
script.Parent.Head.Punch:Play()
wait(1)
script.Parent.Head.AttackSound:Play()
else
anim2:Play()
wait(0.8)
script.Parent.Head.Overhead:Play()
wait(0.2)
script.Parent.Head.AttackSound:Play()
end
end

function findNearestTorso(pos)
    local list = game.Workspace:children()
    local torso = nil
    local dist = math.huge
    local temp = nil
    local human = nil
    local temp2 = nil
    for x = 1, #list do
        temp2 = list[x]
        if (temp2.className == "Model") and (temp2 ~= script.Parent) then
            temp = temp2:findFirstChild("HumanoidRootPart")
            human = temp2:findFirstChild("Humanoid")
            if (temp ~= nil) and (human ~= nil) and (human.Health > 0) then
                if (temp.Position - pos).magnitude < dist then
                    torso = temp
                    dist = (temp.Position - pos).magnitude
                end
            end
        end
    end
    return torso
end
while true do
    wait(0.4)
    local target = findNearestTorso(script.Parent.HumanoidRootPart.Position)
    if target ~= nil then
    script.Parent.Item:MoveTo(target.Position, target) 
    script.Parent.Head.Sprint:Play()
    if (target.Position - larm.Position).magnitude < 10 and attackdb == false then
    attackAnim()
    attackdb = true
    target.Parent:FindFirstChild("Humanoid"):TakeDamage(20)
    wait(0.2)
    attackdb = false
    end
    end
end