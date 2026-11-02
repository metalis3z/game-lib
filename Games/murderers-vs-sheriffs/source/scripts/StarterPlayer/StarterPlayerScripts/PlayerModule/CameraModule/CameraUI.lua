-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_StarterGui_0 = game:GetService("StarterGui");
local v1 = false;
local v2 = {};
v2.setCameraModeToastEnabled = function(v3)
    if not v3 and not v1 then
        return;
    else
        if not v1 then
            v1 = true;
        end;
        if not v3 then
            v2.setCameraModeToastOpen(false);
        end;
        return;
    end;
end;
v2.setCameraModeToastOpen = function(v4)
    assert(v1);
    if v4 then
        l_StarterGui_0:SetCore("SendNotification", {
            Title = "Camera Control Enabled", 
            Text = "Right click to toggle", 
            Duration = 3
        });
    end;
end;
return v2;