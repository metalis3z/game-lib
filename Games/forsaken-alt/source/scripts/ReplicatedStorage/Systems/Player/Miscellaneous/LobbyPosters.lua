-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        if workspace:GetAttribute("Testing") then
            return;
        else
            local l_Posters_0 = workspace:WaitForChild("Map"):WaitForChild("Lobby"):WaitForChild("Posters");
            for _, v3 in pairs(l_Posters_0:GetChildren()) do
                local l_ClickDetector_0 = Instance.new("ClickDetector");
                l_ClickDetector_0.MaxActivationDistance = 12;
                l_ClickDetector_0.Parent = v3;
                l_ClickDetector_0.MouseHoverEnter:Connect(function() --[[ Line: 18 ]]
                    -- upvalues: v3 (copy)
                    local l_PosterUI_0 = v3:FindFirstChild("PosterUI");
                    if l_PosterUI_0 then
                        game.TweenService:Create(l_PosterUI_0.Credit, TweenInfo.new(0.25), {
                            TextTransparency = 0
                        }):Play();
                        game.TweenService:Create(l_PosterUI_0.Credit.UIStroke, TweenInfo.new(0.25), {
                            Transparency = 0.25
                        }):Play();
                    end;
                end);
                l_ClickDetector_0.MouseHoverLeave:Connect(function() --[[ Line: 26 ]]
                    -- upvalues: v3 (copy)
                    local l_PosterUI_1 = v3:FindFirstChild("PosterUI");
                    if l_PosterUI_1 then
                        game.TweenService:Create(l_PosterUI_1.Credit, TweenInfo.new(0.25), {
                            TextTransparency = 1
                        }):Play();
                        game.TweenService:Create(l_PosterUI_1.Credit.UIStroke, TweenInfo.new(0.25), {
                            Transparency = 1
                        }):Play();
                    end;
                end);
            end;
            return;
        end;
    end
};