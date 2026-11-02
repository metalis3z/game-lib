-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Data = {
        Duration = 10, 
        MaxLevel = 5, 
        Stackable = false, 
        Description = "Gives the user overheal at the cost of being 45% slower.\n" .. "40 overheal is added for every level of this status.\n" .. "If the overheal reaches 0 while still in effect, then the effect is forcibly cancelled.\n" .. "User cannot be inflicted with Bleeding, Burning, Poisoned, Regeneration, Speed, or Weakness while in effect."
    }
};
local v1 = {
    "Bleeding", 
    "Burning", 
    "Poisoned", 
    "Regeneration", 
    "Speed", 
    "Weakness"
};
local _ = {
    Head = true, 
    Torso = true, 
    LeftArm = true, 
    RightArm = true, 
    LeftLeg = true, 
    RightLeg = true
};
local v3 = require(game.ReplicatedStorage.Modules.Util);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
v0.Applied = function(v5) --[[ Line: 35 ]] --[[ Name: Applied ]]
    -- upvalues: v1 (copy), v4 (copy), v3 (copy), v0 (copy)
    if game["Run Service"]:IsServer() and not v5.LimbData then
        for _, v7 in pairs(v1) do
            v4:RemoveStatus(v5.Player, v7);
            v5.Character:SetAttribute(("%*Disabled"):format(v7), true);
        end;
        v3:ApplyOverheal(v5.Player, v5.Level * 40, true);
        if v5.Character.PrimaryPart then
            require(game.ReplicatedStorage.Modules.Sounds):Play("rbxassetid://11450310", {
                Parent = v5.Character.PrimaryPart
            });
        end;
        v5.LimbData = {};
        for _, v9 in pairs(v5.Character:GetDescendants()) do
            if v9:IsA("BasePart") then
                v5.LimbData[v9] = {
                    Color = v9.Color, 
                    Material = v9.Material
                };
                v9.Color = Color3.fromRGB(99, 95, 98);
                v9.Material = Enum.Material.Slate;
            end;
        end;
        print(v0, v5);
        if v5.Data.OnStart then
            task.spawn(v5.Data.OnStart);
        end;
        local l_Humanoid_0 = v5.Character:FindFirstChild("Humanoid");
        if l_Humanoid_0 then
            v5.OverhealConnection = l_Humanoid_0:GetAttributeChangedSignal("Overheal"):Connect(function() --[[ Line: 72 ]]
                -- upvalues: l_Humanoid_0 (copy), v5 (copy), v4 (ref)
                local l_l_Humanoid_0_Attribute_0 = l_Humanoid_0:GetAttribute("Overheal");
                if not l_l_Humanoid_0_Attribute_0 or l_l_Humanoid_0_Attribute_0 <= 0 then
                    v5.Cancelled = true;
                    v4:RemoveStatus(v5.Player, "Slateskin");
                end;
            end);
            return;
        end;
    elseif game["Run Service"]:IsClient() then
        local v12 = require(game.ReplicatedStorage.Modules.Util);
        if not v5.SpeedMultiplier then
            v5.SpeedMultiplier = v12:CreateSpeedMultiplier(v5.Player, 1, "SlateskinStatus");
        end;
        if not v5.FOVMultiplier then
            v5.FOVMultiplier = v12:CreateFOVMultiplier(v5.Player, 1, "SlateskinStatus");
        end;
        local v13 = v5.Data.Instant and 0 or 0.3;
        game.TweenService:Create(v5.SpeedMultiplier, TweenInfo.new(v13), {
            Value = 0.55
        }):Play();
        game.TweenService:Create(v5.FOVMultiplier, TweenInfo.new(v13), {
            Value = 0.85
        }):Play();
    end;
end;
v0.Removed = function(v14) --[[ Line: 94 ]] --[[ Name: Removed ]]
    -- upvalues: v3 (copy), v1 (copy)
    if v14.OverhealConnection then
        v14.OverhealConnection:Disconnect();
        v14.OverhealConnection = nil;
    end;
    if game["Run Service"]:IsServer() then
        v3:ApplyOverheal(v14.Player, 0);
        local l_pairs_0 = pairs;
        local v16 = v14.LimbData or {};
        for v17, v18 in l_pairs_0(v16) do
            v17.Color = v18.Color;
            v17.Material = v18.Material;
        end;
        if v14.Data.OnEnd then
            task.spawn(v14.Data.OnEnd);
        end;
        for _, v20 in pairs(v1) do
            v14.Character:SetAttribute(("%*Disabled"):format(v20), nil);
        end;
        return;
    else
        if game["Run Service"]:IsClient() then
            for _, v22 in pairs({
                v14.SpeedMultiplier, 
                v14.FOVMultiplier
            }) do
                game.TweenService:Create(v22, TweenInfo.new(1), {
                    Value = 1
                }):Play();
                game.Debris:AddItem(v22, 1);
            end;
            v14.SpeedMultiplier = nil;
            v14.FOVMultiplier = nil;
        end;
        return;
    end;
end;
return v0;