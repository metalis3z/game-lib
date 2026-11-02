-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

if workspace:GetAttribute("Testing") then
    return;
else
    local l_Parent_0 = script.Parent;
    local l_ClickDetector_0 = Instance.new("ClickDetector");
    l_ClickDetector_0.Parent = l_Parent_0;
    l_ClickDetector_0.MouseClick:Connect(function() --[[ Line: 7 ]]
        -- upvalues: l_Parent_0 (copy)
        local l_Beam_0 = l_Parent_0:FindFirstChild("Beam");
        if l_Beam_0 then
            l_Beam_0:Destroy();
        end;
        l_Parent_0.Glass.Transparency = 0.8;
        l_Parent_0.Neon.Transparency = 1;
        l_Parent_0.Image.Decal.Texture = "rbxassetid://101971414372024";
    end);
    return;
end;