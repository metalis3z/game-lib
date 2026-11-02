-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreatedPost = function(_, v1) --[[ Line: 3 ]] --[[ Name: CreatedPost ]]
        if game["Run Service"]:IsServer() then
            local l_Sword_0 = v1.Rig:FindFirstChild("Sword");
            if l_Sword_0 then
                local l_Highlight_0 = Instance.new("Highlight");
                l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
                l_Highlight_0.FillColor = Color3.new(1, 1, 1);
                l_Highlight_0.OutlineColor = Color3.new(0.85, 0.55, 1);
                l_Highlight_0.FillTransparency = 0.25;
                l_Highlight_0.OutlineTransparency = 0;
                l_Highlight_0.Parent = l_Sword_0;
            end;
        end;
    end
};