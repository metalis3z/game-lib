-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        local v1 = false;
        local v2 = 0;
        local v3 = 0;
        local l_MainUI_0 = game.Players.LocalPlayer.PlayerGui:WaitForChild("MainUI");
        local v5 = script.InsaneVignette:Clone();
        local v6 = script.Warning:Clone();
        v5.Parent = l_MainUI_0;
        v6.Parent = l_MainUI_0;
        local function _(v7, v8) --[[ Line: 24 ]] --[[ Name: applyExponentialCurve ]]
            return v7 ^ (1 / (1 - v8 + 1.0E-5));
        end;
        local v10 = 0;
        local v11 = {
            "you aren't alone here.", 
            "do you call this your home?", 
            "i decide when you can leave.", 
            "don\226\128\153t test my patience.", 
            "i want to see your face.", 
            "come back and play.", 
            "you wouldn't dare defy me.", 
            "don't turn around.", 
            "the air is heavier out there, isn't it?", 
            "i've been waiting for you.", 
            "is this where it ends?", 
            "do you hear that?", 
            "i never left.", 
            "if you leave, you won\226\128\153t make it far.", 
            "can you feel me watching?", 
            "why did you lock the door?", 
            "you brought this upon yourself.", 
            "there's nowhere to hide.", 
            "don't make me find you.", 
            "leaving is not an option.", 
            "you belong to me now.", 
            "who else knows you're here?", 
            "it's colder now, isn't it?", 
            "you can't escape me."
        };
        local function v16(v12) --[[ Line: 65 ]] --[[ Name: randomCase ]]
            local v13 = {};
            for v14 = 1, #v12 do
                local v15 = v12:sub(v14, v14);
                if math.random(0, 1) == 1 then
                    table.insert(v13, v15:upper());
                else
                    table.insert(v13, v15:lower());
                end;
            end;
            return table.concat(v13);
        end;
        local v17 = {};
        game["Run Service"].RenderStepped:Connect(function(v18) --[[ Line: 80 ]]
            -- upvalues: v2 (ref), v1 (ref), v3 (ref), v5 (copy), v17 (copy), v10 (ref), v11 (copy), v6 (copy), v16 (copy)
            local l_v2_0 = v2;
            if not v1 and l_v2_0 <= 0 then
                return;
            else
                local v20 = v1 and v18 / 120 or -v18 / 0.125;
                v2 = math.clamp(v2 + v20, 0, 1);
                if v1 then
                    v3 = v3 + v18;
                end;
                local v21 = v2 ^ 6.6662222518498755;
                local v22 = v21 * 2;
                v5.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromScale(math.random(-v22, v22) / 1000, math.random(-v22 * 2.5, v22 * 2.5) / 1000);
                v5.ImageTransparency = 1 - v21;
                if not v17.TimeSinceMessageChange then
                    v17.TimeSinceMessageChange = tick();
                end;
                local v23 = "...";
                if tick() >= v17.TimeSinceMessageChange + 2 then
                    v17.TimeSinceMessageChange = tick();
                    if v3 >= 300 and not v17.ScreamingForHelp then
                        v17.TimeSinceMessageChange = tick() + 2;
                        v17.ScreamingForHelp = true;
                        v23 = "APieceForThePuzzle Awaits You";
                    else
                        v10 = v10 + 1;
                        v23 = v11[v10 % #v11 + 1];
                    end;
                else
                    v23 = v6.Text;
                end;
                local v24 = v23 == "APieceForThePuzzle Awaits You" and v23 or v16((tostring(v23)));
                v6.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromScale(math.random(-v22, v22) / 1000, math.random(-v22 * 2.5, v22 * 2.5) / 1000);
                v6.Text = v24;
                v6.TextTransparency = 1 - v21;
                v6.TextStrokeTransparency = 1 - v21 / 2;
                return;
            end;
        end);
        local l_UserInputService_0 = game:GetService("UserInputService");
        l_UserInputService_0.WindowFocused:Connect(function() --[[ Line: 123 ]]
            -- upvalues: v1 (ref), v3 (ref), v17 (copy)
            v1 = false;
            v3 = 0;
            v17.ScreamingForHelp = false;
        end);
        l_UserInputService_0.WindowFocusReleased:Connect(function() --[[ Line: 130 ]]
            -- upvalues: v1 (ref)
            v1 = true;
        end);
    end
};