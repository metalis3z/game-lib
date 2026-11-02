-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Modules);
local PlayEmote = require(Modules.Utilities.PlayEmote);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
require(Modules.Controllers.DialogController);
local Remotes = ReplicatedStorage:WaitForChild("Remotes");

local function connectRemote(remoteName, callback)
    local remote = Remotes:FindFirstChild(remoteName) or Remotes:WaitForChild(remoteName, 5);

    if not remote then
        warn("[RemoteListener] Missing remote:", remoteName);
        return false;
    end;

    if remote:IsA("RemoteEvent") then
        remote.OnClientEvent:Connect(callback);
        return true;
    end;

    if remote:IsA("RemoteFunction") then
        remote.OnClientInvoke = callback;
        return true;
    end;

    warn("[RemoteListener] Unsupported remote type:", remoteName, remote.ClassName);
    return false;
end;

connectRemote("PlayEmote", PlayEmote.PlayEmote);
connectRemote("HumanoidDescriptionUpdated", HumanoidDescriptionController.UpdateHumanoidDescription);

local function v7(p4) -- Line: 24
    -- upvalues: Remotes (copy)
    local Events = script.Parent.Events;
    local WearLatestOutfitResponse = Remotes:FindFirstChild("WearLatestOutfitResponse") or Remotes:WaitForChild("WearLatestOutfitResponse", 5);
    local GetSetting = Events:FindFirstChild("GetSetting");

    if not WearLatestOutfitResponse or not WearLatestOutfitResponse:IsA("RemoteFunction") then
        warn("[RemoteListener] WearLatestOutfitResponse is unavailable");
        return;
    end;

    if GetSetting and (GetSetting:GetAttribute("bound") == true and GetSetting:Invoke({ "Miscellaneous", "WearLatestOutfitOnReset" }) == true) then
        WearLatestOutfitResponse:InvokeServer(true);

        return;
    end;

    local v5, v6 = WearLatestOutfitResponse:InvokeServer(Events.PromptWearLatestOutfit:Invoke({
        SerializedDescription = p4
    }) == true);

    if v5 == false then
        warn("error in wear latest outfit response:", v6);
    end;
end;

connectRemote("PromptWearLatestOutfit", v7);