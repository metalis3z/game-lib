-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local l_PlayerScripts_0 = l_LocalPlayer_0:WaitForChild("PlayerScripts");
local l_FlyModule_0 = require(l_PlayerScripts_0:WaitForChild("FlyModule"));
local l_FlyModeButton_0 = l_PlayerGui_0:WaitForChild("Hud"):WaitForChild("RightSide"):WaitForChild("FlyModeButton");
local l_TextLabel_0 = l_FlyModeButton_0:WaitForChild("TextLabel");
local v6 = false;
local function _() --[[ Line: 19 ]] --[[ Name: updateButton ]]
    -- upvalues: v6 (ref), l_FlyModeButton_0 (copy), l_TextLabel_0 (copy)
    if v6 then
        l_FlyModeButton_0.OnGradient.Enabled = true;
        l_FlyModeButton_0.OffGradeint.Enabled = false;
        l_TextLabel_0.Text = "Fly Mode On";
        return;
    else
        l_FlyModeButton_0.OnGradient.Enabled = false;
        l_FlyModeButton_0.OffGradeint.Enabled = true;
        l_TextLabel_0.Text = "Fly Mode Off";
        return;
    end;
end;
if v6 then
    l_FlyModeButton_0.OnGradient.Enabled = true;
    l_FlyModeButton_0.OffGradeint.Enabled = false;
    l_TextLabel_0.Text = "Fly Mode On";
else
    l_FlyModeButton_0.OnGradient.Enabled = false;
    l_FlyModeButton_0.OffGradeint.Enabled = true;
    l_TextLabel_0.Text = "Fly Mode Off";
end;
l_FlyModeButton_0.MouseButton1Click:Connect(function() --[[ Line: 33 ]]
    -- upvalues: v6 (ref), l_FlyModule_0 (copy), l_FlyModeButton_0 (copy), l_TextLabel_0 (copy)
    v6 = not v6;
    if v6 then
        l_FlyModule_0.Enable();
    else
        l_FlyModule_0.Disable();
    end;
    if v6 then
        l_FlyModeButton_0.OnGradient.Enabled = true;
        l_FlyModeButton_0.OffGradeint.Enabled = false;
        l_TextLabel_0.Text = "Fly Mode On";
        return;
    else
        l_FlyModeButton_0.OnGradient.Enabled = false;
        l_FlyModeButton_0.OffGradeint.Enabled = true;
        l_TextLabel_0.Text = "Fly Mode Off";
        return;
    end;
end);