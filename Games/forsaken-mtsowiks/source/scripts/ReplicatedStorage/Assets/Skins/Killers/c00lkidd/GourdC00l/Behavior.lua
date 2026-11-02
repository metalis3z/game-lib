-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:38 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_Debris_0 = game:GetService("Debris");
local _ = require(l_ReplicatedStorage_0.Modules.Util);
return {
    MinionSummon = function(v4) --[[ Line: 12 ]] --[[ Name: MinionSummon ]]
        local l_Rig_0 = v4.Rig;
        if not l_Rig_0 then
            return;
        else
            l_Rig_0.PHONE["Phone Base"].Transparency = 0;
            l_Rig_0.PHONE["Phone Down"].Transparency = 0;
            l_Rig_0.PHONE["Phone Hang"].Transparency = 0;
            task.delay(2.25, function() --[[ Line: 20 ]]
                -- upvalues: l_Rig_0 (copy)
                l_Rig_0.PHONE["Phone Base"].Transparency = 1;
                l_Rig_0.PHONE["Phone Down"].Transparency = 1;
                l_Rig_0.PHONE["Phone Hang"].Transparency = 1;
            end);
            return;
        end;
    end, 
    OnIntroduction = function(_, _, v8, v9) --[[ Line: 27 ]] --[[ Name: OnIntroduction ]]
        -- upvalues: l_Players_0 (copy), l_Debris_0 (copy)
        local v10 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3);
        local l_ScreenGui_0 = script.ScreenGui;
        local l_DisplayThing_0 = script.DisplayThing;
        if v8 then
            v8:PivotTo(v8.PrimaryPart.CFrame - Vector3.new(0, 100, 0, 0));
        end;
        l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
        local v13 = l_ScreenGui_0:Clone();
        v13.Parent = l_Players_0.LocalPlayer.PlayerGui;
        v13.SurfaceGui.Adornee = v10.COMPUTER.Screen;
        v13.SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        l_Debris_0:AddItem(v13, v9);
        v13.SurfaceGui.ViewportFrame.WorldModel.Rig.Humanoid.Animator:LoadAnimation(l_DisplayThing_0):Play();
        workspace.CurrentCamera.FieldOfView = 40;
        task.delay(v9, function() --[[ Line: 50 ]]
            -- upvalues: l_Players_0 (ref)
            l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
        end);
    end
};