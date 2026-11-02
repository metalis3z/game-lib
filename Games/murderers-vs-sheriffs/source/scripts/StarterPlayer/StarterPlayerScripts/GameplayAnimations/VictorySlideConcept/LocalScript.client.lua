-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_SheriffVictory_0 = script.Parent.SheriffVictory;
l_SheriffVictory_0.Visible = true;
local l_TweenService_0 = game:GetService("TweenService");
local v2 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local v3 = {
    l_TweenService_0:Create(l_SheriffVictory_0.Container, v2, {
        Size = UDim2.new(1, 0, 1, 0)
    }), 
    l_TweenService_0:Create(l_SheriffVictory_0.KnifeRight, v2, {
        Position = UDim2.new(0.975, 0, 0.5, 0), 
        Rotation = 0
    }), 
    l_TweenService_0:Create(l_SheriffVictory_0.KnifeLeft, v2, {
        Position = UDim2.new(0.025, 0, 0.5, 0), 
        Rotation = 0
    })
};
for _, v5 in pairs(v3) do
    v5:Play();
end;