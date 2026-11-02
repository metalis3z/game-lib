-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local v1 = {};
local u2 = false;

local function getHiddenFolder() -- Line: 35
    -- upvalues: ReplicatedStorage (copy)
    local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

    if not HiddenPlayers then
        HiddenPlayers = Instance.new("Folder");
        HiddenPlayers.Name = "HiddenPlayers";
        HiddenPlayers.Parent = ReplicatedStorage;
    end;

    return HiddenPlayers;
end;

local function resyncPosition(u3, u4) -- Line: 48
    -- upvalues: Remotes (copy)
    task.spawn(function() -- Line: 49
        -- upvalues: Remotes (ref), u3 (copy), u4 (copy)
        local success, result = pcall(function() -- Line: 50
            -- upvalues: Remotes (ref), u3 (ref)
            return Remotes.GetCharacterCFrame:InvokeServer(u3.UserId);
        end);

        if success and (typeof(result) == "CFrame" and (u3.Character == u4 and u4:IsDescendantOf(workspace))) then
            u4:PivotTo(result);
        end;
    end);
end;

local vanishedIndicator = script:WaitForChild("vanishedIndicator");
local u5 = {};
local u6 = {};

local function updateIndicatorOffset(p7) -- Line: 83
    -- upvalues: u5 (copy)
    local v8 = u5[p7];

    if not v8 or v8.Parent == nil then
        return;
    end;

    local v9 = false;

    for _, child in v8.Parent:GetChildren() do
        if child:IsA("BillboardGui") and (child.Name == "hiddenIndicator" and child.Enabled) then
            v9 = true;
            break;
        end;
    end;

    v8.StudsOffsetWorldSpace = v9 and Vector3.new(0, 0.65, 0) or Vector3.new(0, 0, 0);
end;

local function attachIndicator(u10, u11) -- Line: 96
    -- upvalues: u5 (copy), u6 (copy), vanishedIndicator (copy), updateIndicatorOffset (copy)
    task.spawn(function() -- Line: 97
        -- upvalues: u11 (copy), u10 (copy), u5 (ref), u6 (ref), vanishedIndicator (ref), updateIndicatorOffset (ref)
        local HumanoidRootPart = u11:WaitForChild("HumanoidRootPart", 10);

        if not HumanoidRootPart then
            return;
        end;

        if u10.Character ~= u11 then
            return;
        end;

        if u10:GetAttribute("StaffVanished") ~= true then
            return;
        end;

        local v12 = u5[u10];

        if v12 and v12.Adornee == HumanoidRootPart then
            return;
        end;

        local v13 = u10;
        local v14 = u5[v13];

        if v14 then
            v14:Destroy();
            u5[v13] = nil;
        end;

        local v15 = u6[v13];

        if v15 then
            for _, v in v15 do
                v:Disconnect();
            end;

            u6[v13] = nil;
        end;

        local v16 = vanishedIndicator:Clone();
        v16.Adornee = HumanoidRootPart;
        v16.Parent = HumanoidRootPart;
        u5[u10] = v16;
        local u17 = {};
        u6[u10] = u17;

        local function watchSibling(p18) -- Line: 114
            -- upvalues: u17 (copy), updateIndicatorOffset (ref), u10 (ref)
            if p18:IsA("BillboardGui") and p18.Name == "hiddenIndicator" then
                local v19 = p18:GetPropertyChangedSignal("Enabled");
                table.insert(u17, v19:Connect(function() -- Line: 116
                    -- upvalues: updateIndicatorOffset (ref), u10 (ref)
                    updateIndicatorOffset(u10);
                end));
                updateIndicatorOffset(u10);
            end;
        end;

        table.insert(u17, HumanoidRootPart.ChildAdded:Connect(watchSibling));
        table.insert(u17, HumanoidRootPart.ChildRemoved:Connect(function(p20) -- Line: 123
            -- upvalues: updateIndicatorOffset (ref), u10 (ref)
            if p20:IsA("BillboardGui") and p20.Name == "hiddenIndicator" then
                updateIndicatorOffset(u10);
            end;
        end));

        for _, child in HumanoidRootPart:GetChildren() do
            watchSibling(child);
        end;

        updateIndicatorOffset(u10);
    end);
end;

local function applyState(u21) -- Line: 139
    -- upvalues: LocalPlayer (copy), u2 (ref), u5 (copy), u6 (copy), vanishedIndicator (copy), updateIndicatorOffset (copy), ReplicatedStorage (copy), Remotes (copy)
    if u21 == LocalPlayer then
        return;
    end;

    local v22 = u21:GetAttribute("StaffVanished") == true;

    if not u2 then
        local Character = u21.Character;

        if not Character or Character.Parent == nil then
            return;
        end;

        if v22 then
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
        elseif u21:GetAttribute("isHidden") == nil and u21:GetAttribute("AvatarAutoHidden") ~= true then
            local Parent = Character.Parent;
            local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

            if not HiddenPlayers then
                HiddenPlayers = Instance.new("Folder");
                HiddenPlayers.Name = "HiddenPlayers";
                HiddenPlayers.Parent = ReplicatedStorage;
            end;

            if Parent == HiddenPlayers then
                Character.Parent = workspace;
                task.spawn(function() -- Line: 49
                    -- upvalues: Remotes (ref), u21 (copy), Character (copy)
                    local success, result = pcall(function() -- Line: 50
                        -- upvalues: Remotes (ref), u21 (ref)
                        return Remotes.GetCharacterCFrame:InvokeServer(u21.UserId);
                    end);

                    if success and (typeof(result) == "CFrame" and (u21.Character == Character and Character:IsDescendantOf(workspace))) then
                        Character:PivotTo(result);
                    end;
                end);
            end;
        end;

        return;
    end;

    local Character = u21.Character;

    if v22 and (Character and Character.Parent ~= nil) then
        task.spawn(function() -- Line: 97
            -- upvalues: Character (copy), u21 (copy), u5 (ref), u6 (ref), vanishedIndicator (ref), updateIndicatorOffset (ref)
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 10);

            if not HumanoidRootPart then
                return;
            end;

            if u21.Character ~= Character then
                return;
            end;

            if u21:GetAttribute("StaffVanished") ~= true then
                return;
            end;

            local v23 = u5[u21];

            if v23 and v23.Adornee == HumanoidRootPart then
                return;
            end;

            local v24 = u21;
            local v25 = u5[v24];

            if v25 then
                v25:Destroy();
                u5[v24] = nil;
            end;

            local v26 = u6[v24];

            if v26 then
                for _, v in v26 do
                    v:Disconnect();
                end;

                u6[v24] = nil;
            end;

            local v27 = vanishedIndicator:Clone();
            v27.Adornee = HumanoidRootPart;
            v27.Parent = HumanoidRootPart;
            u5[u21] = v27;
            local u28 = {};
            u6[u21] = u28;

            local function v31(p29) -- Line: 114
                -- upvalues: u28 (copy), updateIndicatorOffset (ref), u21 (ref)
                if p29:IsA("BillboardGui") and p29.Name == "hiddenIndicator" then
                    local v30 = p29:GetPropertyChangedSignal("Enabled");
                    table.insert(u28, v30:Connect(function() -- Line: 116
                        -- upvalues: updateIndicatorOffset (ref), u21 (ref)
                        updateIndicatorOffset(u21);
                    end));
                    updateIndicatorOffset(u21);
                end;
            end;

            table.insert(u28, HumanoidRootPart.ChildAdded:Connect(v31));
            table.insert(u28, HumanoidRootPart.ChildRemoved:Connect(function(p32) -- Line: 123
                -- upvalues: updateIndicatorOffset (ref), u21 (ref)
                if p32:IsA("BillboardGui") and p32.Name == "hiddenIndicator" then
                    updateIndicatorOffset(u21);
                end;
            end));

            for _, child in HumanoidRootPart:GetChildren() do
                v31(child);
            end;

            updateIndicatorOffset(u21);
        end);

        return;
    end;

    local v33 = u5[u21];

    if v33 then
        v33:Destroy();
        u5[u21] = nil;
    end;

    local v34 = u6[u21];

    if v34 then
        for _, v in v34 do
            v:Disconnect();
        end;

        u6[u21] = nil;
    end;
end;

local function watchCharacter(u35, p36) -- Line: 170
    -- upvalues: applyState (copy)
    p36.AncestryChanged:Connect(function() -- Line: 174
        -- upvalues: u35 (copy), applyState (ref)
        if u35:GetAttribute("StaffVanished") == true then
            task.defer(applyState, u35);
        end;
    end);
end;

local function watchPlayer(u37) -- Line: 181
    -- upvalues: LocalPlayer (copy), applyState (copy)
    if u37 == LocalPlayer then
        return;
    end;

    u37:GetAttributeChangedSignal("StaffVanished"):Connect(function() -- Line: 183
        -- upvalues: applyState (ref), u37 (copy)
        applyState(u37);
    end);
    u37.CharacterAdded:Connect(function(p38) -- Line: 186
        -- upvalues: u37 (copy), applyState (ref)
        local u39 = u37;
        p38.AncestryChanged:Connect(function() -- Line: 174
            -- upvalues: u39 (copy), applyState (ref)
            if u39:GetAttribute("StaffVanished") == true then
                task.defer(applyState, u39);
            end;
        end);
        task.defer(applyState, u37);
    end);

    if u37.Character then
        u37.Character.AncestryChanged:Connect(function() -- Line: 174
            -- upvalues: u37 (copy), applyState (ref)
            if u37:GetAttribute("StaffVanished") == true then
                task.defer(applyState, u37);
            end;
        end);
        applyState(u37);
    end;
end;

Players.PlayerAdded:Connect(watchPlayer);
Players.PlayerRemoving:Connect(function(p40) -- Line: 68, Name: detachIndicator
    -- upvalues: u5 (copy), u6 (copy)
    local v41 = u5[p40];

    if v41 then
        v41:Destroy();
        u5[p40] = nil;
    end;

    local v42 = u6[p40];

    if v42 then
        for _, v in v42 do
            v:Disconnect();
        end;

        u6[p40] = nil;
    end;
end);

for _, v in Players:GetPlayers() do
    watchPlayer(v);
end;

local function applySelf() -- Line: 203
    -- upvalues: LocalPlayer (copy), u5 (copy), u6 (copy), vanishedIndicator (copy), updateIndicatorOffset (copy)
    local Character = LocalPlayer.Character;

    if LocalPlayer:GetAttribute("StaffVanished") == true and (Character and Character.Parent ~= nil) then
        local u43 = LocalPlayer;
        task.spawn(function() -- Line: 97
            -- upvalues: Character (copy), u43 (copy), u5 (ref), u6 (ref), vanishedIndicator (ref), updateIndicatorOffset (ref)
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 10);

            if not HumanoidRootPart then
                return;
            end;

            if u43.Character ~= Character then
                return;
            end;

            if u43:GetAttribute("StaffVanished") ~= true then
                return;
            end;

            local v44 = u5[u43];

            if v44 and v44.Adornee == HumanoidRootPart then
                return;
            end;

            local v45 = u43;
            local v46 = u5[v45];

            if v46 then
                v46:Destroy();
                u5[v45] = nil;
            end;

            local v47 = u6[v45];

            if v47 then
                for _, v in v47 do
                    v:Disconnect();
                end;

                u6[v45] = nil;
            end;

            local v48 = vanishedIndicator:Clone();
            v48.Adornee = HumanoidRootPart;
            v48.Parent = HumanoidRootPart;
            u5[u43] = v48;
            local u49 = {};
            u6[u43] = u49;

            local function v52(p50) -- Line: 114
                -- upvalues: u49 (copy), updateIndicatorOffset (ref), u43 (ref)
                if p50:IsA("BillboardGui") and p50.Name == "hiddenIndicator" then
                    local v51 = p50:GetPropertyChangedSignal("Enabled");
                    table.insert(u49, v51:Connect(function() -- Line: 116
                        -- upvalues: updateIndicatorOffset (ref), u43 (ref)
                        updateIndicatorOffset(u43);
                    end));
                    updateIndicatorOffset(u43);
                end;
            end;

            table.insert(u49, HumanoidRootPart.ChildAdded:Connect(v52));
            table.insert(u49, HumanoidRootPart.ChildRemoved:Connect(function(p53) -- Line: 123
                -- upvalues: updateIndicatorOffset (ref), u43 (ref)
                if p53:IsA("BillboardGui") and p53.Name == "hiddenIndicator" then
                    updateIndicatorOffset(u43);
                end;
            end));

            for _, child in HumanoidRootPart:GetChildren() do
                v52(child);
            end;

            updateIndicatorOffset(u43);
        end);

        return;
    end;

    local v54 = LocalPlayer;
    local v55 = u5[v54];

    if v55 then
        v55:Destroy();
        u5[v54] = nil;
    end;

    local v56 = u6[v54];

    if v56 then
        for _, v in v56 do
            v:Disconnect();
        end;

        u6[v54] = nil;
    end;
end;

LocalPlayer:GetAttributeChangedSignal("StaffVanished"):Connect(applySelf);
LocalPlayer.CharacterAdded:Connect(function() -- Line: 213
    -- upvalues: applySelf (copy)
    task.defer(applySelf);
end);
local Character = LocalPlayer.Character;

if LocalPlayer:GetAttribute("StaffVanished") == true and (Character and Character.Parent ~= nil) then
    task.spawn(function() -- Line: 97
        -- upvalues: Character (copy), LocalPlayer (copy), u5 (copy), u6 (copy), vanishedIndicator (copy), updateIndicatorOffset (copy)
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 10);

        if not HumanoidRootPart then
            return;
        end;

        if LocalPlayer.Character ~= Character then
            return;
        end;

        if LocalPlayer:GetAttribute("StaffVanished") ~= true then
            return;
        end;

        local v57 = u5[LocalPlayer];

        if v57 and v57.Adornee == HumanoidRootPart then
            return;
        end;

        local v58 = LocalPlayer;
        local v59 = u5[v58];

        if v59 then
            v59:Destroy();
            u5[v58] = nil;
        end;

        local v60 = u6[v58];

        if v60 then
            for _, v in v60 do
                v:Disconnect();
            end;

            u6[v58] = nil;
        end;

        local v61 = vanishedIndicator:Clone();
        v61.Adornee = HumanoidRootPart;
        v61.Parent = HumanoidRootPart;
        u5[LocalPlayer] = v61;
        local u62 = {};
        u6[LocalPlayer] = u62;

        local function v65(p63) -- Line: 114
            -- upvalues: u62 (copy), updateIndicatorOffset (ref), LocalPlayer (ref)
            if p63:IsA("BillboardGui") and p63.Name == "hiddenIndicator" then
                local v64 = p63:GetPropertyChangedSignal("Enabled");
                table.insert(u62, v64:Connect(function() -- Line: 116
                    -- upvalues: updateIndicatorOffset (ref), LocalPlayer (ref)
                    updateIndicatorOffset(LocalPlayer);
                end));
                updateIndicatorOffset(LocalPlayer);
            end;
        end;

        table.insert(u62, HumanoidRootPart.ChildAdded:Connect(v65));
        table.insert(u62, HumanoidRootPart.ChildRemoved:Connect(function(p66) -- Line: 123
            -- upvalues: updateIndicatorOffset (ref), LocalPlayer (ref)
            if p66:IsA("BillboardGui") and p66.Name == "hiddenIndicator" then
                updateIndicatorOffset(LocalPlayer);
            end;
        end));

        for _, child in HumanoidRootPart:GetChildren() do
            v65(child);
        end;

        updateIndicatorOffset(LocalPlayer);
    end);
else
    local v67 = u5[LocalPlayer];

    if v67 then
        v67:Destroy();
        u5[LocalPlayer] = nil;
    end;

    local v68 = u6[LocalPlayer];

    if v68 then
        for _, v in v68 do
            v:Disconnect();
        end;

        u6[LocalPlayer] = nil;
    end;
end;

task.spawn(function() -- Line: 218
    -- upvalues: Remotes (copy), u2 (ref), Players (copy), LocalPlayer (copy), ReplicatedStorage (copy), applyState (copy)
    local function resolveFlag(u69) -- Line: 222
        -- upvalues: Remotes (ref)
        local v70;

        while true do
            local v71, v72;
            v71, v72, v70 = pcall(function() -- Line: 224
                -- upvalues: Remotes (ref), u69 (copy)
                return Remotes.GetFlag:InvokeServer(u69);
            end);

            if v71 and v72 == true then
                break;
            end;

            task.wait(1);
        end;

        return v70 == true;
    end;

    u2 = resolveFlag("IsContentAdministrator") or (resolveFlag("IsGameManager") or resolveFlag("IsAdministrator") or (resolveFlag("IsContentModerator") or resolveFlag("IsTrialModerator")));

    if u2 then
        for _, v in Players:GetPlayers() do
            if v ~= LocalPlayer and (v:GetAttribute("StaffVanished") == true and (v:GetAttribute("isHidden") == nil and v:GetAttribute("AvatarAutoHidden") ~= true)) then
                local Character2 = v.Character;

                if Character2 then
                    local Parent = Character2.Parent;
                    local HiddenPlayers = ReplicatedStorage:FindFirstChild("HiddenPlayers");

                    if not HiddenPlayers then
                        HiddenPlayers = Instance.new("Folder");
                        HiddenPlayers.Name = "HiddenPlayers";
                        HiddenPlayers.Parent = ReplicatedStorage;
                    end;

                    if Parent == HiddenPlayers then
                        Character2.Parent = workspace;
                        task.spawn(function() -- Line: 49
                            -- upvalues: Remotes (ref), v (copy), Character2 (copy)
                            local success, result = pcall(function() -- Line: 50
                                -- upvalues: Remotes (ref), v (ref)
                                return Remotes.GetCharacterCFrame:InvokeServer(v.UserId);
                            end);

                            if success and (typeof(result) == "CFrame" and (v.Character == Character2 and Character2:IsDescendantOf(workspace))) then
                                Character2:PivotTo(result);
                            end;
                        end);
                    end;
                end;
            end;
        end;

        for _, v in Players:GetPlayers() do
            if v ~= LocalPlayer then
                applyState(v);
            end;
        end;
    end;
end);

return v1;