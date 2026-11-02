-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        local v1 = game.Players.LocalPlayer.Character:WaitForChild("Humanoid", 20);
        if v1 then
            local function v2() --[[ Line: 10 ]] --[[ Name: resetStates ]]
                -- upvalues: v1 (copy)
                v1:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
                v1:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
                v1:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
            end;
            v1:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
            v1:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
            v1:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
            v1.StateChanged:Connect(v2);
        end;
    end
};