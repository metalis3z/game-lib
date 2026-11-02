-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("ReplicatedStorage");
local v1 = {
    CurrentItems = {}
};
local _ = game:GetService("UserInputService");
local _ = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Debris");
local _ = l_RunService_0:IsClient();
local v7 = l_RunService_0:IsServer();
local l_Items_0 = game.ReplicatedStorage.Assets.Items;
v1.GiveItem = function(_, v10, v11) --[[ Line: 20 ]] --[[ Name: GiveItem ]]
    -- upvalues: v1 (copy)
    if not v10.Character then
        return;
    elseif not v10.Character:FindFirstChild("Humanoid") then
        return;
    elseif not v10.Character.PrimaryPart then
        return;
    elseif v10.Character.Humanoid.Health <= 0 then
        return;
    elseif v10.Character.Parent ~= workspace.Players.Survivors then
        return;
    elseif v1.CurrentItems[v10] and v1.CurrentItems[v10][v11.Name] then
        return;
    elseif v1:GetPlayerItemCount(v10) >= 2 then
        return;
    elseif v11 and v11.Item then
        if v11.DroppedByDead then
            require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v10, "Yoink");
            v11.DroppedByDead = nil;
		end;
		--
        v11.Item.Parent = v10.Backpack;
        return true;
    else
        return;
    end;
end;
v1.CreateItem = function(_, v13) --[[ Line: 44 ]] --[[ Name: CreateItem ]]
    -- upvalues: l_Items_0 (copy), v1 (copy)
    local l_l_Items_0_FirstChild_0 = l_Items_0:FindFirstChild((tostring(v13)));
    if l_l_Items_0_FirstChild_0 then
        if not l_l_Items_0_FirstChild_0.Item:FindFirstChild("ItemRoot", true) then
            error((("%* has no ItemRoot!"):format((tostring(v13)))));
        end;
        local v15 = setmetatable({
            Name = v13, 
            Folder = l_l_Items_0_FirstChild_0, 
            Config = require(l_l_Items_0_FirstChild_0.Config), 
            Connections = {}
        }, v1);
        v15.Item = l_l_Items_0_FirstChild_0.Item:Clone();
        v15.Item.Name = v13;
        local l_FirstChild_0 = v15.Item:FindFirstChild("ItemRoot", true);
        v15.Motor6D = v15.Config.Motor6D and v15.Config.Motor6D:Clone() or Instance.new("Motor6D");
        v15.Motor6D.Part1 = l_FirstChild_0;
        v15.Motor6D.Parent = l_FirstChild_0;
        v15.Behavior = setmetatable(v15, (require(l_l_Items_0_FirstChild_0.Behavior)));
        v15.Prompt = Instance.new("ProximityPrompt");
        v15.Prompt.ActionText = v15.Config.DisplayName or tostring(v13);
        v15.Prompt.ObjectText = v15.Config.Description or "...";
        v15.Prompt.Style = Enum.ProximityPromptStyle.Custom;
        v15.Prompt.HoldDuration = 0;
        v15.Prompt.MaxActivationDistance = 12;
        v15.Prompt.RequiresLineOfSight = true;
        v15.Prompt.Enabled = false;
        v15.Prompt.Parent = l_FirstChild_0;
        v15.Prompt:SetAttribute("Theme", "Item");
        v15.Prompt:SetAttribute("OverridePositions", true);
        v15.Prompt.Triggered:Connect(function(v17) --[[ Line: 86 ]]
            -- upvalues: v15 (ref)
            if v15.Prompt.Enabled then
                v15:GiveTo(v17);
            end;
        end);
        for _, v19 in pairs({
            "Equipped", 
            "Unequipped", 
            "Activated", 
            "Deactivated"
        }) do
            v15.Connections[("%*Connection"):format(v19)] = v15.Item[v19]:Connect(function() --[[ Line: 95 ]]
                -- upvalues: v19 (copy), v15 (ref)
                if (v19 == "Activated" or v19 == "Deactivated") and (v15.Cooldown or v15.Character.PrimaryPart.Anchored) then
                    return;
                else
                    if v15.Behavior and v15.Behavior[v19] then
                        v15.Behavior[v19](v15);
                    end;
                    return;
                end;
            end);
        end;
        v15.Connections.TouchInterestConnection = v15.Item.DescendantAdded:Connect(function(v20) --[[ Line: 109 ]]
            if v20:IsA("TouchTransmitter") then
                v20:Destroy();
            end;
        end);
        v15.Connections.BackpackConnection = v15.Item.AncestryChanged:Connect(function(_, v22) --[[ Line: 116 ]]
            -- upvalues: v1 (ref), v13 (copy), v15 (ref), l_FirstChild_0 (copy)
            if v22 and (v22:IsA("Backpack") or game.Players:GetPlayerFromCharacter(v22)) then
                local v23 = v22:FindFirstAncestorOfClass("Player") or game.Players:GetPlayerFromCharacter(v22);
                if v23 and v1.CurrentItems[v23] then
                    v1.CurrentItems[v23][v13] = v15;
                    v15.Player = v23;
                    v15.Character = v23.Character;
                    v15.Motor6D.Part0 = v15.Config.Motor6DPart0 and v23.Character:FindFirstChild(v15.Config.Motor6DPart0) or v23.Character.PrimaryPart;
                    v15.Prompt.Enabled = false;
                    l_FirstChild_0.CanCollide = false;
                    if v15.Connections.DiedConnection then
                        v15.Connections.DiedConnection:Disconnect();
                        v15.Connections.DiedConnection = nil;
                    end;
                    v15.Connections.DiedConnection = v23.Character.Humanoid.Died:Once(function() --[[ Line: 130 ]]
                        -- upvalues: v15 (ref)
                        if v15 and v15.Item then
                            v15.DroppedByDead = true;
                            v15.Item.Parent = workspace.Map.Ingame;
                        end;
                    end);
                    return;
                end;
            elseif v22 and v22 ~= v15.Character and v22 ~= (v15.Player and v15.Player:FindFirstChild("Backpack")) then
                local v24 = v15.Character and v15.Character.PrimaryPart and v15.Character.PrimaryPart.CFrame * CFrame.new(0, 2, -3);
                if v15.Character and v15.Character.PrimaryPart then
                    local v25 = RaycastParams.new();
                    v25.FilterDescendantsInstances = {
                        v15.Item, 
                        workspace.Players
                    };
                    v25.FilterType = Enum.RaycastFilterType.Exclude;
                    local l_Position_0 = (v15.Character.PrimaryPart.CFrame * CFrame.new(0, 2, -3)).Position;
                    local v27 = workspace:Raycast(l_Position_0, Vector3.new(0, -100, 0, 0), v25);
                    if v27 then
                        v24 = CFrame.new(v27.Position + Vector3.new(0, l_FirstChild_0.Size.Y / 2, 0)) * l_FirstChild_0.CFrame.Rotation;
                    end;
                end;
                if v1.CurrentItems[v15.Player] then
                    v1.CurrentItems[v15.Player][v13] = nil;
                end;
                v15.Player = nil;
                v15.Character = nil;
                v15.Motor6D.Part0 = nil;
                v15.Prompt.Enabled = true;
                l_FirstChild_0.CanCollide = true;
                if v24 then
                    l_FirstChild_0.CFrame = v24;
                end;
                if v15.Connections.DiedConnection then
                    v15.Connections.DiedConnection:Disconnect();
                    v15.Connections.DiedConnection = nil;
                    return;
                end;
            elseif v22 == nil then
                v15:Destroy();
            end;
        end);
        if v15.Behavior.Created then
            v15.Behavior:Created();
        end;
        v15.SetCFrame = function(_, v29) --[[ Line: 176 ]] --[[ Name: SetCFrame ]]
            -- upvalues: l_FirstChild_0 (copy)
            l_FirstChild_0.CFrame = v29;
        end;
        v15.GiveTo = function(_, v31) --[[ Line: 181 ]] --[[ Name: GiveTo ]]
            -- upvalues: v1 (ref), v15 (ref)
            return v1:GiveItem(v31, v15);
        end;
        v15.Destroy = function(_) --[[ Line: 186 ]] --[[ Name: Destroy ]]
            -- upvalues: v15 (ref), v1 (ref), v13 (copy)
            if v15 and not v15.Destroying then
                v15.Destroying = true;
                if v15.Behavior.Destroyed then
                    v15.Behavior:Destroyed();
                end;
                for _, v34 in pairs(v15.Connections) do
                    v34:Disconnect();
                    v34 = nil;
                end;
                if v1.CurrentItems[v15.Player] then
                    v1.CurrentItems[v15.Player][v13] = nil;
                end;
                v15.Motor6D:Destroy();
                v15.Item:Destroy();
                v15 = nil;
            end;
        end;
        return v15;
    else
        return;
    end;
end;
v1.PlayerHasItem = function(_, v36, v37) --[[ Line: 205 ]] --[[ Name: PlayerHasItem ]]
    -- upvalues: v1 (copy)
    return v1.CurrentItems[v36] and v1.CurrentItems[v36][v37];
end;
v1.GetPlayerItemCount = function(_, v39) --[[ Line: 209 ]] --[[ Name: GetPlayerItemCount ]]
    -- upvalues: v1 (copy)
    local v40 = 0;
    local l_pairs_0 = pairs;
    local v42 = v1.CurrentItems[v39] or {};
    for _, _ in l_pairs_0(v42) do
        v40 = v40 + 1;
    end;
    return v40;
end;
v1.Start = function(_) --[[ Line: 217 ]] --[[ Name: Start ]]
    -- upvalues: v7 (copy), l_Items_0 (copy), v1 (copy)
    if v7 then
        for _, v47 in pairs(l_Items_0:GetDescendants()) do
            if v47:IsA("BasePart") then
                v47.CanCollide = false;
                v47.CanTouch = false;
                v47.CanQuery = false;
                v47.Massless = true;
                v47.CollisionGroup = "Items";
            end;
        end;
        require(game.ReplicatedStorage.Modules.Util).OnCharacterAdded(function(v48) --[[ Line: 232 ]]
            -- upvalues: v1 (ref)
            local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(v48);
            if l_PlayerFromCharacter_0 then
                local l_pairs_1 = pairs;
                local v51 = v1.CurrentItems[l_PlayerFromCharacter_0] or {};
                for v52, v53 in l_pairs_1(v51) do
                    v53:Destroy();
                    v1.CurrentItems[l_PlayerFromCharacter_0][v52] = nil;
                end;
                v1.CurrentItems[l_PlayerFromCharacter_0] = {};
            end;
        end);
        game.Players.PlayerRemoving:Connect(function(v54) --[[ Line: 244 ]]
            -- upvalues: v1 (ref)
            if v1.CurrentItems[v54] then
                local l_pairs_2 = pairs;
                local v56 = v1.CurrentItems[v54] or {};
                for v57, v58 in l_pairs_2(v56) do
                    v58:Destroy();
                    v1.CurrentItems[v54][v57] = nil;
                end;
                v1.CurrentItems[v54] = nil;
            end;
        end);
    end;
end;
return v1;