-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

if workspace:GetAttribute("Testing") then
    return;
else
    local l_Light_0 = script.Parent:WaitForChild("Light");
    local l_PointLight_0 = l_Light_0:WaitForChild("PointLight");
    local function v3(v2) --[[ Line: 15 ]] --[[ Name: toggleTransparency ]]
        -- upvalues: l_Light_0 (copy), l_PointLight_0 (copy)
        game.TweenService:Create(l_Light_0, TweenInfo.new(0.1), {
            Color = Color3.fromRGB(234, 140, 93)
        }):Play();
        game.TweenService:Create(l_PointLight_0, TweenInfo.new(0.1), {
            Brightness = 4.5
        }):Play();
        task.wait(v2);
        game.TweenService:Create(l_Light_0, TweenInfo.new(0.1), {
            Color = Color3.fromRGB(85, 72, 31)
        }):Play();
        game.TweenService:Create(l_PointLight_0, TweenInfo.new(0.1), {
            Brightness = 1
        }):Play();
        task.wait(0.1);
    end;
    local function v6(v4) --[[ Line: 25 ]] --[[ Name: playMorseCode ]]
        -- upvalues: v3 (copy)
        for v5 in v4:gmatch(".") do
            if v5 == "." then
                v3(0.1);
            elseif v5 == "-" then
                v3(0.30000000000000004);
            elseif v5 == " " then
                task.wait(0.6000000000000001);
            end;
        end;
    end;
    while task.wait(5) do
        v6("-.-. .----");
        game.TweenService:Create(l_Light_0, TweenInfo.new(0.1), {
            Color = Color3.fromRGB(0, 0, 0)
        }):Play();
        game.TweenService:Create(l_PointLight_0, TweenInfo.new(0.1), {
            Brightness = 0
        }):Play();
    end;
    return;
end;