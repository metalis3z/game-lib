-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_Signals_0 = require(l_ReplicatedStorage_0:WaitForChild("Signals"));
local v3 = require(l_ReplicatedStorage_0.Frameworks.Notifications);
local v4 = l_Knit_0.CreateController({
    Name = "CursedZoneController"
});
v4.KnitInit = function(_) --[[ Line: 13 ]] --[[ Name: KnitInit ]]

end;
v4.KnitStart = function(v6) --[[ Line: 16 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_Knit_0 (copy)
    v6.CursedZoneService = l_Knit_0.GetService("CursedZoneService");
    v6:_bindSignals();
end;
v4._bindSignals = function(v7) --[[ Line: 23 ]] --[[ Name: _bindSignals ]]
    -- upvalues: l_Signals_0 (copy), v3 (copy)
    if not v7.CursedZoneService then
        warn("[CursedZoneController] Missing CursedZoneService");
        return;
    else
        v7.CursedZoneService.ZoneShake:Connect(function(_, v9) --[[ Line: 29 ]]
            -- upvalues: l_Signals_0 (ref)
            if l_Signals_0 and l_Signals_0.CameraShake then
                l_Signals_0.CameraShake:Fire(3.2, v9 or 0.3);
            end;
        end);
        v7.CursedZoneService.ZoneNotification:Connect(function(v10, v11) --[[ Line: 35 ]]
            -- upvalues: v3 (ref)
            v3.New(v10 or "CURSED ZONE UPDATE", v11 or "SuccessNotification");
        end);
        return;
    end;
end;
return v4;