-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Elliot_0 = l_ReplicatedStorage_0.Assets.Survivors.Elliot;
local v2 = require(script:FindFirstAncestor("HallucinationClass"));
local v3 = require(l_Elliot_0.Config);
local v4 = require(l_ReplicatedStorage_0.Modules.Util);
local v5 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v6 = {
    ApplyAt = 2, 
    Condition = function() --[[ Line: 16 ]]
        if workspace.Players.Survivors:FindFirstChild("Elliot") then
            return true;
        else
            return false;
        end;
    end
};
v6.__index = v6;
setmetatable(v6, v2);
local function v13() --[[ Line: 22 ]] --[[ Name: findPizza ]]
    local l_Children_0 = workspace.Players.Survivors:GetChildren();
    local l_ipairs_0 = ipairs;
    local v9 = l_Children_0 or {};
    for _, v11 in l_ipairs_0(v9) do
        if v11.Name == "Elliot" then
            local l_Pizza_0 = v11:FindFirstChild("Pizza");
            if l_Pizza_0 and l_Pizza_0:IsA("BasePart") then
                return l_Pizza_0:Clone();
            end;
        end;
    end;
end;
v6.new = function(...) --[[ Line: 35 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy), v6 (copy)
    return (setmetatable(v2.new(...), v6));
end;
v6.Init = function(v14) --[[ Line: 41 ]] --[[ Name: Init ]]
    -- upvalues: v13 (copy), v3 (copy), v5 (copy), v4 (copy)
    v14.Pizzas = {};
    task.delay(math.random(1, 3), function() --[[ Line: 44 ]]
        -- upvalues: v14 (copy), v13 (ref), v3 (ref), v5 (ref), v4 (ref)
        if not v14 or not v14.Running then
            return;
        else
            local l_Position_0 = v14.Survivor.Rig.PrimaryPart.Position;
            local v16 = v13() or script.Pizza:Clone();
            v16.Transparency = 0;
            if v16:FindFirstChild("PizzaJoint") then
                v16.PizzaJoint:Destroy();
            end;
            for _, v18 in ipairs(v16:GetDescendants()) do
                if v18:IsA("BasePart") then
                    v18.Transparency = 0;
                end;
            end;
            v16.CanCollide = true;
            v16.CollisionGroup = "Items";
            v16.Parent = workspace.Map.Ingame;
            v16.Position = v14:GetRandomSpawnInCone(l_Position_0, NumberRange.new(90, 270), 60, 7);
            v16.AssemblyLinearVelocity = ((l_Position_0 - v16.Position).Unit + Vector3.new(0, 0.5, 0, 0)) * v3.PizzaThrowForce;
            v5:Play(v3.Sounds.PizzaThrown, {
                Parent = v16
            });
            v4:RevealPlayerAura(v16, v3.PizzaPingDuration, Color3.new(0.75, 1, 0.75));
            v4:ApplyOnTouched(v16, false, function(v19, v20) --[[ Line: 71 ]]
                -- upvalues: v14 (ref), v16 (copy), v5 (ref), v3 (ref)
                local l_Parent_0 = v20.Parent;
                local v22 = l_Parent_0 and l_Parent_0:FindFirstChild("Humanoid");
                if l_Parent_0 and l_Parent_0 == v14.Survivor.Rig and v14.Running and v16.Parent then
                    v19.Disconnect();
                    v16:Destroy();
                    v5:Play(v3.Sounds.PizzaEaten, {
                        Parent = v14.Survivor.Rig.PrimaryPart
                    });
                    local function _(v23) --[[ Line: 81 ]] --[[ Name: fakeHeal ]]
                        -- upvalues: v22 (copy)
                        v22:SetAttribute("FakeDamage", (v22:GetAttribute("FakeDamage") or 0) - v23);
                    end;
                    local l_PizzaHealingAmount_0 = v3.PizzaHealingAmount;
                    v22:SetAttribute("FakeDamage", (v22:GetAttribute("FakeDamage") or 0) - l_PizzaHealingAmount_0);
                    l_PizzaHealingAmount_0 = 0;
                    while v14 and v14.Running do
                        local v26 = task.wait();
                        l_PizzaHealingAmount_0 = l_PizzaHealingAmount_0 + v26;
                        if v3.PizzaHealingProgressivelyTime > l_PizzaHealingAmount_0 then
                            local v27 = v26 * v3.PizzaHealingProgressively / v3.PizzaHealingProgressivelyTime;
                            v22:SetAttribute("FakeDamage", (v22:GetAttribute("FakeDamage") or 0) - v27);
                        else
                            break;
                        end;
                    end;
                end;
            end);
            table.insert(v14.Pizzas, v16);
            return;
        end;
    end);
end;
v6.Destroy = function(v28) --[[ Line: 103 ]] --[[ Name: Destroy ]]
    local l_ipairs_1 = ipairs;
    local v30 = v28.Pizzas or {};
    for _, v32 in l_ipairs_1(v30) do
        v32:Destroy();
    end;
    v28.Running = false;
    v28:Clean();
end;
return v6;