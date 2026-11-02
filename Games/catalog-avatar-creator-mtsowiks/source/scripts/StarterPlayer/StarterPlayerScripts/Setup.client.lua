-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

print("Avatar Maker v" .. tostring(game.PlaceVersion));
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local Remotes = ReplicatedStorage.Remotes;
local Parent = script.Parent;

local moduleQueue = {};

local controllers = Parent:WaitForChild("Controllers");

for _, child in controllers:GetChildren() do
    if child:IsA("ModuleScript") and child.Name ~= "ModeratorPanelController" then
        table.insert(moduleQueue, child);
    end;
end;

table.sort(moduleQueue, function(a, b)
    return a.Name < b.Name;
end);

-- Limit eager initialization so low-memory systems do not compile every controller at once.
task.spawn(function()
    local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait();
    character:WaitForChild("Humanoid", 10);
    local nextIndex = 0;

    for _ = 1, 3 do
        task.spawn(function()
            while true do
                nextIndex = nextIndex + 1;
                local child = moduleQueue[nextIndex];

                if not child then
                    return;
                end;

                local success, result = pcall(require, child);

                if not success then
                    warn("[AvatarMaker] Module failed to initialize:", child:GetFullName(), result);
                end;

                task.wait(0.05);
            end;
        end);
    end;
end);

local function getFlag(flagName)
    for _ = 1, 8 do
        local invoked, requestOk, enabled = pcall(function()
            return Remotes.GetFlag:InvokeServer(flagName);
        end);

        if invoked and requestOk == true then
            return enabled == true;
        end;

        task.wait(0.5);
    end;

    return false;
end;

local isAdministrator = getFlag("IsAdministrator");

if isAdministrator then
    local success, cmdrClient = pcall(require, ReplicatedStorage:WaitForChild("CmdrClient"));

    if success and cmdrClient then
        cmdrClient:SetActivationKeys({ Enum.KeyCode.Semicolon });
    end;
end;

local isModerator = getFlag("IsContentModerator")
    or getFlag("IsContentAdministrator")
    or getFlag("IsTrialModerator");

if isModerator then
    task.spawn(function()
        local success, result = pcall(require, Parent.Controllers.ModeratorPanelController);

        if not success then
            warn("[AvatarMaker] Moderator panel failed to initialize:", result);
        end;
    end);

    return;
end;

Parent.Controllers.ModeratorPanelController:Destroy();
local moderatorGui = PlayerGui:FindFirstChild("ModeratorPanel");

if moderatorGui then
    moderatorGui:Destroy();
end;