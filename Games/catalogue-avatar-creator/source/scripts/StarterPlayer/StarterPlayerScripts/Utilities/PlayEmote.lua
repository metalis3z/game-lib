-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local LocalPlayer = game:GetService("Players").LocalPlayer;
local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local u1 = {
    EmotePlayed = Instance.new("BindableEvent"),
    DirectAnimator = nil
};

local function getPlayEmoteBindable() -- Line: 11
    -- upvalues: LocalPlayer (copy)
    if LocalPlayer.Character ~= nil then
        for _, child in LocalPlayer.Character:GetChildren() do
            if child.Name == "Animate" and child:IsA("LocalScript") then
                return child:FindFirstChild("PlayEmote");
            end;
        end;
    end;

    return nil;
end;

function u1.PlayEmote(p2) -- Line: 23
    -- upvalues: u1 (copy), Remotes (copy), getPlayEmoteBindable (copy)
    local EmoteId = p2.EmoteId;
    local Animation = Instance.new("Animation");
    Animation.Name = p2.EmoteName;
    Animation.AnimationId = EmoteId;

    if not u1.DirectAnimator then
        local v3 = getPlayEmoteBindable();

        if v3 then
            v3:Invoke(Animation, Animation.Name);
            u1.EmotePlayed:Fire(p2, v3);
            pcall(Remotes.AnalyticsEvent.FireServer, Remotes.AnalyticsEvent, "EmotePlayed");
        end;

        return;
    end;

    local v4 = u1.DirectAnimator:LoadAnimation(Animation);
    v4.Priority = Enum.AnimationPriority.Action;
    v4:Play();
    u1.EmotePlayed:Fire(p2, nil);
    pcall(Remotes.AnalyticsEvent.FireServer, Remotes.AnalyticsEvent, "EmotePlayed");
end;

return u1;