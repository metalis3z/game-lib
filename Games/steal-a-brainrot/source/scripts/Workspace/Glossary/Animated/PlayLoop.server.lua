-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

if script:IsDescendantOf(workspace) then
    local l__GlossaryLoop__1 = script.Parent.AnimationController.GlossaryLoop;
    local v1 = script.Parent.AnimationController:WaitForChild("Animator"):LoadAnimation(l__GlossaryLoop__1);
    v1.Looped = true;
    v1:Play();
end;