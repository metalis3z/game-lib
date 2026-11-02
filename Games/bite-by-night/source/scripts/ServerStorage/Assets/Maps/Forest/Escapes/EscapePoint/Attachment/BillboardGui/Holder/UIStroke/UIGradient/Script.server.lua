-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
while true do
    l_TweenService_0:Create(script.Parent, TweenInfo.new(4, Enum.EasingStyle.Linear), {
        Rotation = 360
    }):Play();
    task.wait(4);
    script.Parent.Rotation = 0;
    task.wait();
end;