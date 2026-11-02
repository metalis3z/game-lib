-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:07:45 2025 ]]
local l_Children_0 = script.Hairs:GetChildren();
local l_random_0 = math.random;
return {
    OnSlashHit = function(_, v3) --[[ Line: 7 ]] --[[ Name: OnSlashHit ]]
        -- upvalues: l_random_0 (copy), l_Children_0 (copy)
        for _, v5 in (v3:GetDescendants()) do
            if not v5:GetAttribute("Fade") then
                if v5:IsA("BasePart") and v5.Name:lower():find("hair") then
                    v5.Transparency = 1;
                elseif v5:IsA("Accessory") and (v5.AccessoryType == Enum.AccessoryType.Hair or v5.Name:lower():find("hair") or v5:FindFirstChild("HairAttachment", true)) then
                    v5:Destroy();
                end;
            end;
        end;
        if l_random_0(10) == 1 then
            local l_BarberJasonFade_0 = v3:FindFirstChild("BarberJasonFade");
            if l_BarberJasonFade_0 then
                l_BarberJasonFade_0:Destroy();
            end;
            local v7 = l_Children_0[l_random_0(#l_Children_0)]:Clone();
            v7.Name = "BarberJasonFade";
            v7.Handle:SetAttribute("Fade", true);
            v7:SetAttribute("Fade", true);
            v7.Parent = v3;
        end;
    end
};