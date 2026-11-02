-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved soon!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-01-02 08:18:31
-- Luau version 6, Types version 3
-- Time taken: 0.000678 seconds

return {
    Start = function(arg1, arg2, arg3) -- Line 16, Named "Start"
        if arg2.Value == true then
            game.TweenService:Create(game.Lighting, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                ClockTime = 0;
                Brightness = 1;
                Ambient = Color3.fromRGB(0, 0, 0);
            }):Play()
        else
            game.TweenService:Create(game.Lighting, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                ClockTime = 14.5;
                Brightness = 3;
                Ambient = Color3.fromRGB(214, 214, 214);
            }):Play()
        end
    end;
}