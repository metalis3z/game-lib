-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 5 ]] --[[ Name: Start ]]
        local v1 = require(game.ReplicatedStorage.Modules.Util);
        local l_Character_0 = game.Players.LocalPlayer.Character;
        local v3 = l_Character_0:WaitForChild("Humanoid", 15);
        local v4 = l_Character_0:WaitForChild("HumanoidRootPart", 15);
        if v3 and v4 then
            v3.StateChanged:Connect(function(_, v6) --[[ Line: 17 ]]
                -- upvalues: v4 (copy), l_Character_0 (copy), v1 (copy)
                if v6 == Enum.HumanoidStateType.Landed then
                    local l_Y_0 = v4.AssemblyLinearVelocity.Y;
                    if l_Y_0 <= -40 then
                        local v8 = math.abs(l_Y_0);
                        local v9 = tostring(l_Character_0.Parent) == "Survivors" and 1.5 or 0;
                        if v9 > 0 then
                            local v10 = 40 / v8 / v9;
                            local v11 = math.clamp(v8 / 40 * v9 / 2, 0.2, 2);
                            local l_v1_SpeedMultiplier_0 = v1:CreateSpeedMultiplier(l_Character_0, math.clamp(v10, 0, 1), "FallSlowness");
                            game.TweenService:Create(l_v1_SpeedMultiplier_0, TweenInfo.new(v11), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_v1_SpeedMultiplier_0, v11);
                        end;
                    end;
                end;
            end);
        end;
    end
};