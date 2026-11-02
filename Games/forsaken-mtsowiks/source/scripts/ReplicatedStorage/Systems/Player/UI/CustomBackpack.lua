-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Tools = {}
};
v0.__index = v0;
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local v2 = require(game.ReplicatedStorage.Modules.Network);
v0.AddItemToBackpack = function(_, v4) --[[ Line: 10 ]] --[[ Name: AddItemToBackpack ]]
    -- upvalues: l_LocalPlayer_0 (copy), v0 (copy), v2 (copy)
    assert(v4, "bad tool, needs to be Tool.");
    if l_LocalPlayer_0.Character.Parent.Name == "Killers" and workspace:GetAttribute("ServerType") ~= "VIP" then
        return;
    elseif v0.Tools[v4] then
        return;
    else
        local v5 = setmetatable({
            Player = l_LocalPlayer_0, 
            Character = l_LocalPlayer_0.Character, 
            Item = v4, 
            Animations = {}, 
            Connections = {}
        }, v0);
        v0.Tools[v4] = v5;
        v5.Button = script.HotbarItemContainer:Clone();
        v5.Button.Name = v5.Item.Name;
        v5.Button.Size = UDim2.fromScale();
        v5.Button.Parent = l_LocalPlayer_0.PlayerGui.MainUI.Backpack;
        v5.Folder = game.ReplicatedStorage.Assets.Items:FindFirstChild(v5.Item.Name);
        v5.Config = v5.Folder and require(v5.Folder.Config);
        v5.Behavior = v5.Folder and setmetatable({}, require(v5.Folder.Behavior));
        if v5.Config then
            v5.Button.Icon.Image = v5.Config.Icon or "";
            v5.Button.Title.Text = v5.Config.DisplayName or v5.Item.Name;
            v5.Button.Title.Visible = not v5.Config.Icon;
        else
            v5.Button.Icon.Image = v4.TextureId;
            v5.Button.Title.Text = v4.Name;
            v5.Button.Title.Visible = v4.TextureId == "";
        end;
        local l_pairs_0 = pairs;
        local v7 = v5.Config and v5.Config.Animations or {};
        for v8, v9 in l_pairs_0(v7) do
            local v10 = require(game.ReplicatedStorage.Modules.Util);
            v5.Animations[v8] = v10:LoadAnimationFromID(l_LocalPlayer_0.Character, v9);
        end;
        if v5.Animations.Equipped and v5.Animations.Idle then
            v5.Animations.Equipped.Stopped:Connect(function() --[[ Line: 66 ]]
                -- upvalues: v5 (copy)
                if v5.Animations.Equipped.TimePosition >= v5.Animations.Equipped.Length then
                    v5.Animations.Idle:Play(0);
                end;
            end);
        end;
        for _, v12 in pairs({
            "Equipped", 
            "Unequipped", 
            "Activated", 
            "Deactivated"
        }) do
            v5.Connections[("%*Connection"):format(v12)] = v5.Item[v12]:Connect(function() --[[ Line: 76 ]]
                -- upvalues: v12 (copy), v5 (copy)
                if (v12 == "Activated" or v12 == "Deactivated") and v5.Cooldown then
                    return;
                else
                    if v5.Animations[v12] then
                        v5.Animations[v12]:Play(0.125);
                    end;
                    if v12 == "Equipped" and v5.Animations.Idle and not v5.Animations.Equipped then
                        v5.Animations.Idle:Play(0.125);
                    end;
                    if v12 == "Unequipped" then
                        for _, v14 in pairs(v5.Animations) do
                            v14:Stop(0.25);
                        end;
                    end;
                    if v5.Behavior and v5.Behavior[v12] then
                        v5.Behavior[v12](v5);
                    end;
                    return;
                end;
            end);
        end;
        v5.Connections.AncestryChangedConnection = v5.Item.AncestryChanged:Connect(function() --[[ Line: 107 ]]
            -- upvalues: v5 (copy)
            v5:UpdateState();
        end);
        v5:UpdateState();
        v7 = 0;
        v5.Button.MouseButton1Click:Connect(function() --[[ Line: 113 ]]
            -- upvalues: v7 (ref), v2 (ref), v4 (copy)
            v7 = v7 + 1;
            task.delay(0.175, function() --[[ Line: 114 ]]
                -- upvalues: v7 (ref)
                v7 = v7 - 1;
            end);
            if v7 >= 2 then
                v2:FireServerConnection("DropItem", "REMOTE_EVENT", v4);
                return;
            else
                v2:FireServerConnection("UpdateItemParent", "REMOTE_EVENT", v4);
                return;
            end;
        end);
        if v5.Behavior and v5.Behavior.Created then
            v5.Behavior.Created(v5);
        end;
        return v5;
    end;
end;
v0.UpdateState = function(v15) --[[ Line: 131 ]] --[[ Name: UpdateState ]]
    -- upvalues: l_LocalPlayer_0 (copy), v0 (copy)
    local l_Parent_0 = v15.Item.Parent;
    if l_Parent_0 then
        if l_Parent_0.Name == "Backpack" then
            v15:NormalizeItem();
        elseif l_LocalPlayer_0.Character == l_Parent_0 then
            v15:HighlightItem();
        else
            v15:RemoveItem();
        end;
    else
        v15:RemoveItem();
    end;
    v0:UpdateItemsInBackpack();
end;
v0.HighlightItem = function(v17) --[[ Line: 153 ]] --[[ Name: HighlightItem ]]
    game.TweenService:Create(v17.Button, TweenInfo.new(0.25), {
        Size = UDim2.fromScale(1, 1), 
        ImageColor3 = Color3.fromRGB(255, 255, 90)
    }):Play();
end;
v0.NormalizeItem = function(v18) --[[ Line: 158 ]] --[[ Name: NormalizeItem ]]
    game.TweenService:Create(v18.Button, TweenInfo.new(0.25), {
        Size = UDim2.fromScale(1, 0.95), 
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }):Play();
end;
v0.RemoveItem = function(v19) --[[ Line: 163 ]] --[[ Name: RemoveItem ]]
    -- upvalues: v0 (copy)
    if v19.Behavior and v19.Behavior.Destroyed then
        v19.Behavior.Destroyed(v19);
    end;
    for _, v21 in pairs(v19.Animations) do
        v21:Stop(0.25);
    end;
    for _, v23 in pairs(v19.Connections) do
        v23:Disconnect();
        v23 = nil;
    end;
    game.TweenService:Create(v19.Button, TweenInfo.new(0.15), {
        Size = UDim2.fromScale()
    }):Play();
    game.Debris:AddItem(v19.Button, 0.15);
    v0.Tools[v19.Item] = nil;
    task.delay(0.2, function() --[[ Line: 174 ]]
        -- upvalues: v0 (ref)
        v0:UpdateItemsInBackpack();
    end);
end;
v0.UpdateItemsInBackpack = function(_) --[[ Line: 179 ]] --[[ Name: UpdateItemsInBackpack ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local v25 = {};
    for _, v27 in pairs(l_LocalPlayer_0.PlayerGui.MainUI.Backpack:GetChildren()) do
        if v27:IsA("ImageButton") then
            table.insert(v25, v27);
        end;
    end;
    for v28, v29 in pairs(v25) do
        v29.Number.Text = math.round(v28);
    end;
end;
v0.Start = function(_) --[[ Line: 192 ]] --[[ Name: Start ]]
    -- upvalues: l_LocalPlayer_0 (copy), v0 (copy), v2 (copy)
    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
    local v31 = script.Backpack:Clone();
    v31.Parent = l_LocalPlayer_0.PlayerGui:WaitForChild("MainUI");
    local function v34(v32) --[[ Line: 201 ]] --[[ Name: onToolAdded ]]
        -- upvalues: v0 (ref)
        if v32:IsA("Tool") then
            local _ = v0:AddItemToBackpack(v32);
        end;
    end;
    local function v41(v35) --[[ Line: 207 ]] --[[ Name: setupCharacter ]]
        -- upvalues: l_LocalPlayer_0 (ref), v0 (ref), v31 (copy), v34 (copy)
        for _, v37 in pairs(l_LocalPlayer_0.Backpack:GetChildren()) do
            if v37:IsA("Tool") then
                local _ = v0:AddItemToBackpack(v37);
            end;
        end;
        v31.Position = script.Backpack.Position;
        l_LocalPlayer_0.Backpack.ChildAdded:Connect(v34);
        v35.ChildAdded:Connect(v34);
        v35:WaitForChild("Humanoid").Died:Once(function() --[[ Line: 216 ]]
            -- upvalues: v0 (ref)
            for _, v40 in pairs(v0.Tools) do
                v40:RemoveItem();
                task.wait(0.15);
            end;
        end);
    end;
    v41(l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait());
    l_LocalPlayer_0.CharacterAdded:Connect(v41);
    game.UserInputService.InputBegan:Connect(function(v42, v43) --[[ Line: 229 ]]
        -- upvalues: v0 (ref), v2 (ref)
        if v43 then
            return;
        else
            for v44, v45 in pairs({
                "One", 
                "Two", 
                "Three", 
                "Four", 
                "Five", 
                "Six", 
                "Seven", 
                "Eight", 
                "Nine", 
                "Zero"
            }) do
                if v42.KeyCode.Name == v45 then
                    for v46, v47 in pairs(v0.Tools) do
                        if tonumber(v47.Button.Number.Text) == v44 then
                            v2:FireServerConnection("UpdateItemParent", "REMOTE_EVENT", v46);
                        end;
                    end;
                end;
            end;
            return;
        end;
    end);
end;
return v0;