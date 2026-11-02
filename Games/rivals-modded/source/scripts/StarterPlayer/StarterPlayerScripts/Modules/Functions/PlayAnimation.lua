-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, ...) -- Line: 1
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p2;
    local v3 = p1:LoadAnimation(Animation);
    v3:Play(...);

    return v3, Animation;
end;