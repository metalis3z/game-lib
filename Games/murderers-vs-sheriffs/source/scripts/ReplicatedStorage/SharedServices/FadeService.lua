-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
    CreateFadeInfo = function(_) --[[ Line: 4 ]] --[[ Name: CreateFadeInfo ]]
        return {
            Start = {
                BackgroundTransparency = nil, 
                BackgroundColor3 = nil
            }, 
            End = {
                BackgroundTransparency = nil, 
                BackgroundColor3 = nil
            }, 
            Time = 1
        };
    end
};
v1.FadeIn = v1:CreateFadeInfo();
v1.FadeIn.Start.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
v1.FadeIn.Start.BackgroundTransparency = 0;
v1.FadeIn.End.BackgroundTransparency = 1;
v1.FadeOut = v1:CreateFadeInfo();
v1.FadeOut.Start.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
v1.FadeOut.Start.BackgroundTransparency = 1;
v1.FadeOut.End.BackgroundTransparency = 0;
v1.PlayFade = function(v2) --[[ Line: 30 ]] --[[ Name: PlayFade ]]
    local l_TweenService_0 = game:GetService("TweenService");
    local l_Frame_0 = game.Players.LocalPlayer.PlayerGui:WaitForChild("Fade"):WaitForChild("Frame");
    l_Frame_0.BackgroundTransparency = v2.Start.BackgroundTransparency;
    l_Frame_0.BackgroundColor3 = v2.Start.BackgroundColor3;
    l_TweenService_0:Create(l_Frame_0, TweenInfo.new(v2.Time, Enum.EasingStyle.Linear), {
        BackgroundTransparency = v2.End.BackgroundTransparency, 
        BackgroundColor3 = v2.End.BackgroundColor3
    }):Play();
end;
return v1;