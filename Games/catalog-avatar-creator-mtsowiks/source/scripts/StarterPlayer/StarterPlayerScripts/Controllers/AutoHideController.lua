-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local v1 = {};
local u2 = false;
local u3 = {};

local function getHiddenFolder() -- Line: 39
    -- upvalues: ReplicatedStorage (copy)
    local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

    if not HiddenPlayers then
        HiddenPlayers = Instance.new("Folder");
        HiddenPlayers.Name = "HiddenPlayers";
        HiddenPlayers.Parent = ReplicatedStorage;
    end;

    return HiddenPlayers;
end;

local function resyncPosition(u4, u5) -- Line: 52
    -- upvalues: Remotes (copy)
    task.spawn(function() -- Line: 53
        -- upvalues: Remotes (ref), u4 (copy), u5 (copy)
        local success, result = pcall(function() -- Line: 54
            -- upvalues: Remotes (ref), u4 (ref)
            return Remotes.GetCharacterCFrame:InvokeServer(u4.UserId);
        end);

        if success and (typeof(result) == "CFrame" and (u4.Character == u5 and u5:IsDescendantOf(workspace))) then
            u5:PivotTo(result);
        end;
    end);
end;

local hiddenIndicator = script:WaitForChild("hiddenIndicator");
local u6 = {};

local function detachIndicator(p7) -- Line: 69
    -- upvalues: u6 (copy)
    local v8 = u6[p7];

    if v8 then
        v8:Destroy();
        u6[p7] = nil;
    end;
end;

local function refreshIndicatorText(p9) -- Line: 77
    -- upvalues: u6 (copy)
    local v10 = u6[p9];

    if not v10 or v10.Parent == nil then
        return;
    end;

    local StatusLabel = v10:FindFirstChild("StatusLabel");

    if not StatusLabel then
        return;
    end;

    local v11 = tonumber(p9:GetAttribute("AvatarAutoHiddenScore")) or 0;
    StatusLabel.Text = string.format("HIDDEN | SCORE: %d", v11);
end;

local function attachIndicator(u12, u13) -- Line: 88
    -- upvalues: u6 (copy), refreshIndicatorText (copy), hiddenIndicator (copy)
    task.spawn(function() -- Line: 89
        -- upvalues: u13 (copy), u12 (copy), u6 (ref), refreshIndicatorText (ref), hiddenIndicator (ref)
        local HumanoidRootPart = u13:WaitForChild("HumanoidRootPart", 10);

        if not HumanoidRootPart then
            return;
        end;

        if u12.Character ~= u13 then
            return;
        end;

        if u12:GetAttribute("AvatarAutoHidden") ~= true then
            return;
        end;

        local v14 = u6[u12];

        if v14 and v14.Adornee == HumanoidRootPart then
            refreshIndicatorText(u12);

            return;
        end;

        local v15 = u12;
        local v16 = u6[v15];

        if v16 then
            v16:Destroy();
            u6[v15] = nil;
        end;

        local v17 = hiddenIndicator:Clone();
        v17.Adornee = HumanoidRootPart;
        v17.Parent = HumanoidRootPart;
        u6[u12] = v17;
        refreshIndicatorText(u12);
    end);
end;

local function updateIndicator(u18) -- Line: 110
    -- upvalues: u6 (copy), refreshIndicatorText (copy), hiddenIndicator (copy)
    local Character = u18.Character;

    if u18:GetAttribute("AvatarAutoHidden") == true and (Character and Character.Parent ~= nil) then
        task.spawn(function() -- Line: 89
            -- upvalues: Character (copy), u18 (copy), u6 (ref), refreshIndicatorText (ref), hiddenIndicator (ref)
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 10);

            if not HumanoidRootPart then
                return;
            end;

            if u18.Character ~= Character then
                return;
            end;

            if u18:GetAttribute("AvatarAutoHidden") ~= true then
                return;
            end;

            local v19 = u6[u18];

            if v19 and v19.Adornee == HumanoidRootPart then
                refreshIndicatorText(u18);

                return;
            end;

            local v20 = u18;
            local v21 = u6[v20];

            if v21 then
                v21:Destroy();
                u6[v20] = nil;
            end;

            local v22 = hiddenIndicator:Clone();
            v22.Adornee = HumanoidRootPart;
            v22.Parent = HumanoidRootPart;
            u6[u18] = v22;
            refreshIndicatorText(u18);
        end);

        return;
    end;

    local v23 = u6[u18];

    if v23 then
        v23:Destroy();
        u6[u18] = nil;
    end;
end;

local function applyState(u24) -- Line: 119
    -- upvalues: LocalPlayer (copy), u2 (ref), u6 (copy), refreshIndicatorText (copy), hiddenIndicator (copy), u3 (copy), ReplicatedStorage (copy), Remotes (copy)
    if u24 == LocalPlayer then
        return;
    end;

    if not u2 then
        local Character = u24.Character;

        if not Character or Character.Parent == nil then
            return;
        end;

        if u24:GetAttribute("AvatarAutoHidden") == true and not u3[u24] then
            local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

            if not HiddenPlayers then
                HiddenPlayers = Instance.new("Folder");
                HiddenPlayers.Name = "HiddenPlayers";
                HiddenPlayers.Parent = ReplicatedStorage;
            end;

            if Character.Parent ~= HiddenPlayers then
                Character.Parent = HiddenPlayers;

                return;
            end;
        elseif u24:GetAttribute("isHidden") == nil and u24:GetAttribute("StaffVanished") ~= true then
            local Parent = Character.Parent;
            local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

            if not HiddenPlayers then
                HiddenPlayers = Instance.new("Folder");
                HiddenPlayers.Name = "HiddenPlayers";
                HiddenPlayers.Parent = ReplicatedStorage;
            end;

            if Parent == HiddenPlayers then
                Character.Parent = workspace;
                task.spawn(function() -- Line: 53
                    -- upvalues: Remotes (ref), u24 (copy), Character (copy)
                    local success, result = pcall(function() -- Line: 54
                        -- upvalues: Remotes (ref), u24 (ref)
                        return Remotes.GetCharacterCFrame:InvokeServer(u24.UserId);
                    end);

                    if success and (typeof(result) == "CFrame" and (u24.Character == Character and Character:IsDescendantOf(workspace))) then
                        Character:PivotTo(result);
                    end;
                end);
            end;
        end;

        return;
    end;

    local Character = u24.Character;

    if u24:GetAttribute("AvatarAutoHidden") == true and (Character and Character.Parent ~= nil) then
        task.spawn(function() -- Line: 89
            -- upvalues: Character (copy), u24 (copy), u6 (ref), refreshIndicatorText (ref), hiddenIndicator (ref)
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 10);

            if not HumanoidRootPart then
                return;
            end;

            if u24.Character ~= Character then
                return;
            end;

            if u24:GetAttribute("AvatarAutoHidden") ~= true then
                return;
            end;

            local v25 = u6[u24];

            if v25 and v25.Adornee == HumanoidRootPart then
                refreshIndicatorText(u24);

                return;
            end;

            local v26 = u24;
            local v27 = u6[v26];

            if v27 then
                v27:Destroy();
                u6[v26] = nil;
            end;

            local v28 = hiddenIndicator:Clone();
            v28.Adornee = HumanoidRootPart;
            v28.Parent = HumanoidRootPart;
            u6[u24] = v28;
            refreshIndicatorText(u24);
        end);

        return;
    end;

    local v29 = u6[u24];

    if v29 then
        v29:Destroy();
        u6[u24] = nil;
    end;
end;

local function resolveFriendship(u30) -- Line: 142
    -- upvalues: LocalPlayer (copy), u3 (copy), applyState (copy)
    task.spawn(function() -- Line: 143
        -- upvalues: LocalPlayer (ref), u30 (copy), u3 (ref), applyState (ref)
        for _ = 1, 5 do
            local success, result = pcall(function() -- Line: 145
                -- upvalues: LocalPlayer (ref), u30 (ref)
                return LocalPlayer:IsFriendsWith(u30.UserId);
            end);

            if success then
                if result == true then
                    u3[u30] = true;
                    applyState(u30);
                end;

                return;
            end;

            task.wait(2);
        end;
    end);
end;

local function watchCharacter(u31, p32) -- Line: 162
    -- upvalues: applyState (copy)
    p32.AncestryChanged:Connect(function() -- Line: 166
        -- upvalues: u31 (copy), applyState (ref)
        if u31:GetAttribute("AvatarAutoHidden") == true then
            task.defer(applyState, u31);
        end;
    end);
end;

local function watchPlayer(u33) -- Line: 173
    -- upvalues: LocalPlayer (copy), u3 (copy), applyState (copy), u2 (ref), refreshIndicatorText (copy)
    if u33 == LocalPlayer then
        return;
    end;

    task.spawn(function() -- Line: 143
        -- upvalues: LocalPlayer (ref), u33 (copy), u3 (ref), applyState (ref)
        for _ = 1, 5 do
            local success, result = pcall(function() -- Line: 145
                -- upvalues: LocalPlayer (ref), u33 (ref)
                return LocalPlayer:IsFriendsWith(u33.UserId);
            end);

            if success then
                if result == true then
                    u3[u33] = true;
                    applyState(u33);
                end;

                return;
            end;

            task.wait(2);
        end;
    end);
    u33:GetAttributeChangedSignal("AvatarAutoHidden"):Connect(function() -- Line: 176
        -- upvalues: applyState (ref), u33 (copy)
        applyState(u33);
    end);
    u33:GetAttributeChangedSignal("AvatarAutoHiddenScore"):Connect(function() -- Line: 179
        -- upvalues: u2 (ref), refreshIndicatorText (ref), u33 (copy)
        if u2 then
            refreshIndicatorText(u33);
        end;
    end);
    u33.CharacterAdded:Connect(function(p34) -- Line: 184
        -- upvalues: u33 (copy), applyState (ref)
        local u35 = u33;
        p34.AncestryChanged:Connect(function() -- Line: 166
            -- upvalues: u35 (copy), applyState (ref)
            if u35:GetAttribute("AvatarAutoHidden") == true then
                task.defer(applyState, u35);
            end;
        end);
        task.defer(applyState, u33);
    end);

    if u33.Character then
        u33.Character.AncestryChanged:Connect(function() -- Line: 166
            -- upvalues: u33 (copy), applyState (ref)
            if u33:GetAttribute("AvatarAutoHidden") == true then
                task.defer(applyState, u33);
            end;
        end);
        applyState(u33);
    end;
end;

Players.PlayerAdded:Connect(watchPlayer);
Players.PlayerRemoving:Connect(function(p36) -- Line: 195
    -- upvalues: u6 (copy), u3 (copy)
    local v37 = u6[p36];

    if v37 then
        v37:Destroy();
        u6[p36] = nil;
    end;

    u3[p36] = nil;
end);

for _, v in Players:GetPlayers() do
    watchPlayer(v);
end;

task.spawn(function() -- Line: 203
    -- upvalues: Remotes (copy), u2 (ref), Players (copy), LocalPlayer (copy), ReplicatedStorage (copy), u6 (copy), refreshIndicatorText (copy), hiddenIndicator (copy)
    local function resolveFlag(u38) -- Line: 211
        -- upvalues: Remotes (ref)
        local v39;

        while true do
            local v40, v41;
            v40, v41, v39 = pcall(function() -- Line: 213
                -- upvalues: Remotes (ref), u38 (copy)
                return Remotes.GetFlag:InvokeServer(u38);
            end);

            if v40 and v41 == true then
                break;
            end;

            task.wait(1);
        end;

        return v39 == true;
    end;

    u2 = resolveFlag("IsContentModerator") or resolveFlag("IsTrialModerator");

    if u2 then
        for _, v in Players:GetPlayers() do
            if v ~= LocalPlayer and (v:GetAttribute("AvatarAutoHidden") == true and v:GetAttribute("isHidden") == nil) then
                local Character = v.Character;

                if Character then
                    local Parent = Character.Parent;
                    local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

                    if not HiddenPlayers then
                        HiddenPlayers = Instance.new("Folder");
                        HiddenPlayers.Name = "HiddenPlayers";
                        HiddenPlayers.Parent = ReplicatedStorage;
                    end;

                    if Parent == HiddenPlayers then
                        Character.Parent = workspace;
                        task.spawn(function() -- Line: 53
                            -- upvalues: Remotes (ref), v (copy), Character (copy)
                            local success, result = pcall(function() -- Line: 54
                                -- upvalues: Remotes (ref), v (ref)
                                return Remotes.GetCharacterCFrame:InvokeServer(v.UserId);
                            end);

                            if success and (typeof(result) == "CFrame" and (v.Character == Character and Character:IsDescendantOf(workspace))) then
                                Character:PivotTo(result);
                            end;
                        end);
                    end;
                end;
            end;
        end;

        for _, v in Players:GetPlayers() do
            if v ~= LocalPlayer then
                local Character = v.Character;

                if v:GetAttribute("AvatarAutoHidden") == true and (Character and Character.Parent ~= nil) then
                    task.spawn(function() -- Line: 89
                        -- upvalues: Character (copy), v (copy), u6 (ref), refreshIndicatorText (ref), hiddenIndicator (ref)
                        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 10);

                        if not HumanoidRootPart then
                            return;
                        end;

                        if v.Character ~= Character then
                            return;
                        end;

                        if v:GetAttribute("AvatarAutoHidden") ~= true then
                            return;
                        end;

                        local v42 = u6[v];

                        if v42 and v42.Adornee == HumanoidRootPart then
                            refreshIndicatorText(v);

                            return;
                        end;

                        local v43 = v;
                        local v44 = u6[v43];

                        if v44 then
                            v44:Destroy();
                            u6[v43] = nil;
                        end;

                        local v45 = hiddenIndicator:Clone();
                        v45.Adornee = HumanoidRootPart;
                        v45.Parent = HumanoidRootPart;
                        u6[v] = v45;
                        refreshIndicatorText(v);
                    end);
                else
                    local v46 = u6[v];

                    if v46 then
                        v46:Destroy();
                        u6[v] = nil;
                    end;
                end;
            end;
        end;
    end;
end);

return v1;