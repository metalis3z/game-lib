-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent;
local l_LocalPlayer_0 = game.Players.LocalPlayer;
repeat
    task.wait();
until l_LocalPlayer_0.Character;
local v2 = l_LocalPlayer_0.Character:WaitForChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(script:WaitForChild("UseAnim"));
l_Parent_0.Activated:Connect(function() --[[ Line: 10 ]]
    -- upvalues: v2 (copy)
    if v2.IsPlaying then
        return;
    else
        v2:Play();
        return;
    end;
end);