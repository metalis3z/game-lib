-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = script.Parent.AnimationController:LoadAnimation(script.Parent.Parent.Camera);
for _ = 1, 5 do
    v0:Play(0);
    v0:Stop(0);
    wait(0.5);
end;
script:Destroy();