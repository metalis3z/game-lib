-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Config = {
        FacePlayer = false, 
        PlayIdleOutsideOfDialog = true, 
        VoiceSFX = "rbxassetid://107648255423077", 
        Poses = {
            Idle = "rbxassetid://180435571"
        }, 
        Actions = {
            Wave = "rbxassetid://128777973"
        }
    }
};
v0.Interacted = function(v1) --[[ Line: 16 ]]
    -- upvalues: v0 (copy)
    if not v0.SpokenToBefore then
        v0.SpokenToBefore = true;
        require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UnlockAchievement", "REMOTE_EVENT", "MeetBrandon");
    end;
    v1:CreateDialog({
        Text = "lets chat! how are you feeling", 
        Action = "Wave"
    });
    local l_v1_UserResponse_0 = v1:GetUserResponse({
        [1] = {
            Choice = "feeling good"
        }, 
        [2] = {
            Choice = "feeling bad"
        }, 
        [3] = {
            Choice = "Goodbye!"
        }
    });
    local function v4() --[[ Line: 37 ]] --[[ Name: cancelDialog ]]
        -- upvalues: v1 (copy)
        local v3 = {
            "Goodbye!"
        };
        v1:CreateDialog({
            Text = v3[math.random(1, #v3)]
        });
    end;
    v1:ProcessResponse(l_v1_UserResponse_0, {
        [1] = function() --[[ Line: 46 ]]
            -- upvalues: v1 (copy), v4 (copy)
            local v5 = {
                "cool :D what have you been up too"
            };
            v1:CreateDialog({
                Text = v5[math.random(1, #v5)]
            });
            (function() --[[ Line: 52 ]] --[[ Name: recursive ]]
                -- upvalues: v1 (ref), v4 (ref)
                local l_v1_UserResponse_1 = v1:GetUserResponse({
                    [1] = {
                        Choice = "playing games"
                    }, 
                    [2] = {
                        Choice = "hanging out"
                    }, 
                    [3] = {
                        Choice = "Goodbye!"
                    }
                });
                v1:ProcessResponse(l_v1_UserResponse_1, {
                    [1] = function() --[[ Line: 62 ]]
                        -- upvalues: v1 (ref), v4 (ref)
                        v1:CreateDialog({
                            Text = "oh whats your favorite game right now?"
                        });
                        (function() --[[ Line: 65 ]] --[[ Name: recursive ]]
                            -- upvalues: v1 (ref), v4 (ref)
                            local l_v1_UserResponse_2 = v1:GetUserResponse({
                                [1] = {
                                    Choice = "heli wars"
                                }, 
                                [2] = {
                                    Choice = "work at a pizza place"
                                }, 
                                [3] = {
                                    Choice = "survive disasters"
                                }, 
                                [4] = {
                                    Choice = "Goodbye!"
                                }
                            });
                            v1:ProcessResponse(l_v1_UserResponse_2, {
                                [1] = function() --[[ Line: 75 ]]
                                    -- upvalues: v1 (ref)
                                    v1:CreateDialog({
                                        Text = "<Color=Blue>ozo<Color=/> is that you? LOL it must be! hope you still get out there and pwn, so much fun"
                                    });
                                end, 
                                [2] = function() --[[ Line: 78 ]]
                                    -- upvalues: v1 (ref)
                                    v1:CreateDialog({
                                        Text = "<Color=Red>ERROR [Code D8]<Color=/>"
                                    });
                                end, 
                                [3] = function() --[[ Line: 81 ]]
                                    -- upvalues: v1 (ref)
                                    v1:CreateDialog({
                                        Text = "<Color=Red>ERROR [Code D8]<Color=/>"
                                    });
                                end, 
                                [4] = v4
                            });
                        end)();
                    end, 
                    [2] = function() --[[ Line: 88 ]]
                        -- upvalues: v1 (ref)
                        v1:CreateDialog({
                            Text = "<Color=Red>ERROR [Code D8]<Color=/>"
                        });
                    end, 
                    [3] = v4
                });
            end)();
        end, 
        [2] = function() --[[ Line: 96 ]]
            -- upvalues: v1 (copy), v4 (copy)
            local v8 = {
                "sorry :( whats going on?"
            };
            v1:CreateDialog({
                Text = v8[math.random(1, #v8)]
            });
            (function() --[[ Line: 102 ]] --[[ Name: recursive ]]
                -- upvalues: v1 (ref), v4 (ref)
                local l_v1_UserResponse_3 = v1:GetUserResponse({
                    [1] = {
                        Choice = "something online"
                    }, 
                    [2] = {
                        Choice = "something irl"
                    }, 
                    [3] = {
                        Choice = "Goodbye!"
                    }
                });
                v1:ProcessResponse(l_v1_UserResponse_3, {
                    [1] = function() --[[ Line: 112 ]]
                        -- upvalues: v1 (ref)
                        v1:CreateDialog({
                            Text = "noobs/trolls bothering you? try ignoring :D itll be okay"
                        });
                    end, 
                    [2] = function() --[[ Line: 116 ]]
                        -- upvalues: v1 (ref)
                        v1:CreateDialog({
                            Text = "hope it works out, wish i could help sooner.. try talking it out with the person"
                        });
                    end, 
                    [3] = v4
                });
            end)();
        end, 
        [3] = v4
    });
end;
return v0;