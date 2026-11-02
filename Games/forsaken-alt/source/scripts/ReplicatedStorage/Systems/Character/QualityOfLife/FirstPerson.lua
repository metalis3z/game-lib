-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = {
    Sensitivity = 1, 
    SwaySize = 1, 
    DoStrafe = false, 
    DoWalkSway = true, 
    DoCameraSway = true, 
    DoJumpSway = true, 
    DoWaistMovements = false, 
    HeadOffset = Vector3.new(0, 0, 0.5, 0), 
    AimOffset = Vector3.new(), 
    ArmTransparency = 0
};
v0.Start = function(_) --[[ Line: 23 ]] --[[ Name: Start ]]
    -- upvalues: v1 (copy), v0 (copy)
end;
v0.Destroy = function(v3) --[[ Line: 500 ]] --[[ Name: Destroy ]]
    if v3.Connection then
        v3.Connection:Disconnect();
        v3.Connection = nil;
    end;
    if v3.__roothipclone then
        v3.__roothipclone:Destroy();
    end;
    if v3.__fakelowertorso then
        v3.__fakelowertorso:Destroy();
    end;
    if v3.__leftshoulderclone then
        v3.__leftshoulderclone:Destroy();
    end;
    if v3.__rightshoulderclone then
        v3.__rightshoulderclone:Destroy();
    end;
    if v3.__viewmodel then
        v3.__viewmodel:Destroy();
    end;
end;
return v0;