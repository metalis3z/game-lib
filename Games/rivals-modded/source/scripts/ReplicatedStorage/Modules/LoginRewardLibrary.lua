-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u3 = {
    NUM_ONBOARDING_LOGIN_REWARD_MILESTONES = 0,
    NUM_LOOPED_LOGIN_REWARD_MILESTONES = 0,
    OnboardingRewards = {},
    LoopedRewards = {},

    GetLoginRewardInfoFromDay = function(p1, p2) -- Line: 9, Name: GetLoginRewardInfoFromDay
        if p2 <= p1.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES then
            return p1.OnboardingRewards[p2];
        end;

        return p1.LoopedRewards[(p2 - p1.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES - 1) % p1.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1];
    end
};

local function add_login_reward(p4, p5, p6) -- Line: 19
    -- upvalues: u3 (copy)
    local v7;

    if p4 then
        v7 = u3.OnboardingRewards;
    else
        v7 = u3.LoopedRewards;
    end;

    local v8 = #v7 + 1;
    table.insert(v7, {
        LoginRewardID = (p4 and "LoginRewardOnboarding" or "LoginRewardLooped") .. v8,
        Rewards = p6,
        Title = "Day " .. (v8 - 1) % 7 + 1,
        Description = p5 or ""
    });

    if p4 then
        local v9 = u3;
        v9.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES = v9.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES + 1;

        return;
    end;

    local v10 = u3;
    v10.NUM_LOOPED_LOGIN_REWARD_MILESTONES = v10.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
end;

local OnboardingRewards = u3.OnboardingRewards;
local v11 = #OnboardingRewards + 1;
table.insert(OnboardingRewards, {
    Description = "Welcome!",
    LoginRewardID = "LoginRewardOnboarding" .. v11,
    Rewards = { {
            Name = "Key",
            Quantity = 1
        } },
    Title = "Day " .. (v11 - 1) % 7 + 1
});
u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES = u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES + 1;
local OnboardingRewards2 = u3.OnboardingRewards;
local v12 = #OnboardingRewards2 + 1;
table.insert(OnboardingRewards2, {
    Description = "",
    LoginRewardID = "LoginRewardOnboarding" .. v12,
    Rewards = { {
            Name = "Wrap Box",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    Title = "Day " .. (v12 - 1) % 7 + 1
});
u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES = u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES + 1;
local OnboardingRewards3 = u3.OnboardingRewards;
local v13 = #OnboardingRewards3 + 1;
table.insert(OnboardingRewards3, {
    Description = "Free weapon!",
    LoginRewardID = "LoginRewardOnboarding" .. v13,
    Rewards = { {
            Name = "Standard Weapon Crate",
            Quantity = 1
        } },
    Title = "Day " .. (v13 - 1) % 7 + 1
});
u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES = u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES + 1;
local OnboardingRewards4 = u3.OnboardingRewards;
local v14 = #OnboardingRewards4 + 1;
table.insert(OnboardingRewards4, {
    Description = "",
    LoginRewardID = "LoginRewardOnboarding" .. v14,
    Rewards = { {
            Name = "Prize Wheel",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    Title = "Day " .. (v14 - 1) % 7 + 1
});
u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES = u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES + 1;
local OnboardingRewards5 = u3.OnboardingRewards;
local v15 = #OnboardingRewards5 + 1;
table.insert(OnboardingRewards5, {
    Description = "Super cool!",
    LoginRewardID = "LoginRewardOnboarding" .. v15,
    Rewards = { {
            Name = "Finisher Pack",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    Title = "Day " .. (v15 - 1) % 7 + 1
});
u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES = u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES + 1;
local OnboardingRewards6 = u3.OnboardingRewards;
local v16 = #OnboardingRewards6 + 1;
table.insert(OnboardingRewards6, {
    Description = "",
    LoginRewardID = "LoginRewardOnboarding" .. v16,
    Rewards = { {
            Name = "Key",
            Quantity = 10
        } },
    Title = "Day " .. (v16 - 1) % 7 + 1
});
u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES = u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES + 1;
local OnboardingRewards7 = u3.OnboardingRewards;
local v17 = #OnboardingRewards7 + 1;
table.insert(OnboardingRewards7, {
    Description = "Free skins!",
    LoginRewardID = "LoginRewardOnboarding" .. v17,
    Rewards = { {
            Name = "Skin Ticket",
            Quantity = 1
        } },
    Title = "Day " .. (v17 - 1) % 7 + 1
});
u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES = u3.NUM_ONBOARDING_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards = u3.LoopedRewards;
local v18 = #LoopedRewards + 1;
table.insert(LoopedRewards, {
    Description = "Claim now!",
    LoginRewardID = "LoginRewardLooped" .. v18,
    Rewards = { {
            Name = "Key",
            Quantity = 1
        } },
    Title = "Day " .. (v18 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards2 = u3.LoopedRewards;
local v19 = #LoopedRewards2 + 1;
table.insert(LoopedRewards2, {
    Description = "",
    LoginRewardID = "LoginRewardLooped" .. v19,
    Rewards = { {
            Name = "Goodie Bag",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    Title = "Day " .. (v19 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards3 = u3.LoopedRewards;
local v20 = #LoopedRewards3 + 1;
table.insert(LoopedRewards3, {
    Description = "",
    LoginRewardID = "LoginRewardLooped" .. v20,
    Rewards = { {
            Name = "Key",
            Quantity = 3
        } },
    Title = "Day " .. (v20 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards4 = u3.LoopedRewards;
local v21 = #LoopedRewards4 + 1;
table.insert(LoopedRewards4, {
    Description = "",
    LoginRewardID = "LoginRewardLooped" .. v21,
    Rewards = { {
            Name = "Goodie Bag",
            Quantity = 2,
            Weapon = "IsRandom"
        } },
    Title = "Day " .. (v21 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards5 = u3.LoopedRewards;
local v22 = #LoopedRewards5 + 1;
table.insert(LoopedRewards5, {
    Description = "",
    LoginRewardID = "LoginRewardLooped" .. v22,
    Rewards = { {
            Name = "Goodie Bag",
            Quantity = 3,
            Weapon = "IsRandom"
        } },
    Title = "Day " .. (v22 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards6 = u3.LoopedRewards;
local v23 = #LoopedRewards6 + 1;
table.insert(LoopedRewards6, {
    Description = "",
    LoginRewardID = "LoginRewardLooped" .. v23,
    Rewards = { {
            Name = "Key",
            Quantity = 5
        } },
    Title = "Day " .. (v23 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards7 = u3.LoopedRewards;
local v24 = #LoopedRewards7 + 1;
table.insert(LoopedRewards7, {
    Description = "Grand prize!",
    LoginRewardID = "LoginRewardLooped" .. v24,
    Rewards = { {
            Name = "Skin Ticket",
            Quantity = 1
        } },
    Title = "Day " .. (v24 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards8 = u3.LoopedRewards;
local v25 = #LoopedRewards8 + 1;
table.insert(LoopedRewards8, {
    Description = "Claim now!",
    LoginRewardID = "LoginRewardLooped" .. v25,
    Rewards = { {
            Name = "Goodie Bag",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    Title = "Day " .. (v25 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards9 = u3.LoopedRewards;
local v26 = #LoopedRewards9 + 1;
table.insert(LoopedRewards9, {
    Description = "",
    LoginRewardID = "LoginRewardLooped" .. v26,
    Rewards = { {
            Name = "Key",
            Quantity = 3
        } },
    Title = "Day " .. (v26 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards10 = u3.LoopedRewards;
local v27 = #LoopedRewards10 + 1;
table.insert(LoopedRewards10, {
    Description = "",
    LoginRewardID = "LoginRewardLooped" .. v27,
    Rewards = { {
            Name = "Goodie Bag",
            Quantity = 2,
            Weapon = "IsRandom"
        } },
    Title = "Day " .. (v27 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards11 = u3.LoopedRewards;
local v28 = #LoopedRewards11 + 1;
table.insert(LoopedRewards11, {
    Description = "",
    LoginRewardID = "LoginRewardLooped" .. v28,
    Rewards = { {
            Name = "Key",
            Quantity = 5
        } },
    Title = "Day " .. (v28 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards12 = u3.LoopedRewards;
local v29 = #LoopedRewards12 + 1;
table.insert(LoopedRewards12, {
    Description = "",
    LoginRewardID = "LoginRewardLooped" .. v29,
    Rewards = { {
            Name = "Goodie Bag",
            Quantity = 3,
            Weapon = "IsRandom"
        } },
    Title = "Day " .. (v29 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards13 = u3.LoopedRewards;
local v30 = #LoopedRewards13 + 1;
table.insert(LoopedRewards13, {
    Description = "",
    LoginRewardID = "LoginRewardLooped" .. v30,
    Rewards = { {
            Name = "Key",
            Quantity = 7
        } },
    Title = "Day " .. (v30 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;
local LoopedRewards14 = u3.LoopedRewards;
local v31 = #LoopedRewards14 + 1;
table.insert(LoopedRewards14, {
    Description = "Grand prize!",
    LoginRewardID = "LoginRewardLooped" .. v31,
    Rewards = { {
            Name = "Prime Goodie Bag",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    Title = "Day " .. (v31 - 1) % 7 + 1
});
u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES = u3.NUM_LOOPED_LOGIN_REWARD_MILESTONES + 1;

return u3;