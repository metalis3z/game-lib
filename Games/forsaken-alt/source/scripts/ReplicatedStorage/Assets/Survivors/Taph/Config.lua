-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Taph", 
    Quote = "\"BOOM BOOM BOOM!\"", 
    Credits = "", 
    Class = "Support", 
    RenderImage = "rbxassetid://91979599169148", 
    Price = 600, 
    Exclusive = false, 
    Health = 90, 
    Speed = 12, 
    TripwireCooldown = 25, 
    TripwireLifetime = 150, 
    TripwireMaxAmount = 3, 
    TripwireHealth = 20, 
    TripwireLifetimeDecreasePerTaph = 20, 
    TripwireDistanceBetweenTripwires = 8, 
    TripwireTriggerSlownessData = {
        Level = 2, 
        Duration = 4
    }, 
    TripwireTriggerAuraRevealInvincibleDuration = 4, 
    TripwireTriggerAuraRevealDuration = 8, 
    TripwireTriggerAuraRevealDistance = 100, 
    TripwireDestroyedAuraDuration = 2, 
    TripwireDurationBetweenRewards = 4, 
    TripwireCooldownWhilePlacing = 2.5, 
    TripwireSpeedWhilePlacing = 8.5, 
    TripwireTemplate = script.TripwireHook, 
    SubspaceTripmineCooldown = 40, 
    SubspaceCooldownReductionOnSuccess = 7, 
    SubspaceDamage = 55, 
    SubspaceLifetime = 40, 
    SubspaceThrowForce = 50, 
    SubspaceRange = 16, 
    SubspaceEffectHitLevel = 1, 
    SubspaceEffectLevel = 3, 
    SubspaceEffectDuration = 5, 
    SubspaceHelplessDuration = 3, 
    SubspaceExplosionDelay = 0.5, 
    SubspaceHiddenTransparency = 0.85, 
    SubspaceHintCount = 3, 
    SubspaceHintTransparency = 0.6, 
    SubspaceExplosionVFX = script.ExplosionVFX, 
    Animations = {
		TripwireIdle = "rbxassetid://79976430909224", 
		TripwireWalk = "rbxassetid://106630672603110", 
		TripwireRun = "rbxassetid://116815685933670", 
		TripwirePlaceStart = "rbxassetid://126381606386178", 
		TripwirePlaceEnd = "rbxassetid://101788707645560", 
		ThrowSubspace = "rbxassetid://95429649339167"
    }, 
    Sounds = {
        BeartrapToss = "rbxassetid://2769387310", 
        BeartrapLatch = "rbxassetid://2769387865", 
        SubspaceToss = "rbxassetid://11956590", 
        SubspaceHint = "rbxassetid://11984254", 
        SubspaceDetonate = "rbxassetid://11984351"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "\240\159\141\149\226\157\147 (Have pizza?)", 
                "\240\159\141\149\226\157\151 (Need pizza!)", 
                "\240\159\141\149\226\157\151\226\157\151 (Need pizza, now!!)", 
                "\240\159\141\149\240\159\152\139 (Pizza is yummy. Need some.)", 
                "\240\159\141\149\240\159\141\189\239\184\143\226\157\147 (Have pizza to eat?)"
            }, 
            BuildermanSentry = {
                "\240\159\148\171\226\157\147 (Sentry here?)", 
                "\240\159\148\171\226\157\151 (Sentry here!)", 
                "\240\159\148\171\240\159\146\165\226\157\147 (Sentry goes off here?)", 
                "\240\159\148\171\226\128\188\239\184\143\226\172\135\239\184\143 (Sentry over here!!)", 
                "\240\159\148\171\226\158\161\239\184\143\240\159\148\170\240\159\146\171 (Sentry handles the killer here.)"
            }, 
            BuildermanDispenser = {
                "\226\157\164\239\184\143\226\128\141\240\159\169\185\226\157\147 (Dispenser please?)", 
                "\226\157\164\239\184\143\226\128\141\240\159\169\185\226\157\151 (Dispenser, hurry!)", 
                "\226\157\164\239\184\143\226\128\141\240\159\169\185\240\159\141\142\226\157\147 (Dispenser heal, please?)", 
                "\240\159\141\142\226\172\135\239\184\143\226\157\151 (Dispenser here, now!)", 
                "\226\157\164\239\184\143\226\128\141\240\159\169\185\226\128\188\239\184\143 (Dispenser over here, now!!)"
            }, 
            DusekkarProtection = {
                "\240\159\142\131\226\156\168\240\159\145\135 (Pumpkin magic here, please!)", 
                "\240\159\142\131\226\156\168\226\157\147 (Pumpkin, can you use magic here?)", 
                "\240\159\142\131\226\156\168 \226\157\151 (Pumpkin, use magic here!)", 
                "\240\159\142\131\226\156\168\240\159\153\143 (Pumpkin, use your magic here, please.)", 
                "\240\159\142\131\226\156\168\240\159\164\178\226\157\147 (Pumpkin, may you cast magic on me?)"
            }
        }, 
        Thanks = {
            Regular = {
                "\240\159\145\141\226\156\168 (Thank you, you\226\128\153re the best.)", 
                "\240\159\146\170\226\157\151 (Thank you, you\226\128\153ve empowered me!)", 
                "\240\159\153\143\240\159\145\143 (Much appreciated.)", 
                "\240\159\153\135\226\157\163\239\184\143 (Thank you so very much!)", 
                "\240\159\152\132\240\159\145\141 (Thank you, I appreciate it!)", 
                "\240\159\152\129\240\159\145\141 (Many thanks, I appreciate the gesture!)"
            }
        }
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "TAPH", 
        Text = "A mute demolitionist who used to blow up & destroy the houses of terminated users at the will of Builderman.\nUses Tripwires and Subspace Tripmines to reveal the position of and disorientate the Killer.\n"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v0.Health or 100) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 24) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Image = "rbxassetid://135707604176757", 
        Header = "TRIPWIRE", 
        Quote = "\"\240\159\148\151\240\159\154\182\226\128\141\226\153\130\239\184\143\240\159\144\140\226\154\160\239\184\143\240\159\145\165\"", 
        Text = "Taph places a tripwire on the ground in order to weaken the Killer and alert other Survivors about their presence.\n" .. ("When the killer walks over a tripwire, all survivors within %* studs of Taph have the killer\226\128\153s aura revealed for %* seconds and the killer gains slowness %* for %* seconds. \n"):format(v0.TripwireTriggerAuraRevealDistance, v0.TripwireTriggerAuraRevealDuration, v0.TripwireTriggerSlownessData.Level, v0.TripwireTriggerSlownessData.Duration) .. ("The tripwire has a total of %* health, and if the killer hits the tripwire, it will completely destroy it.\n"):format(v0.TripwireHealth) .. ("The tripwire slowly becomes less visible over the course of %* seconds after being placed, "):format(v0.TripwireLifetime) .. ("Tripwires cannot be placed within %* studs of each other\n\n"):format(v0.TripwireDistanceBetweenTripwires)
    }, 
    {
        Image = "rbxassetid://89334370123950", 
        Header = "SUBSPACE TRIPMINE", 
        Quote = "\"\240\159\145\129\226\128\141\240\159\151\168  \240\159\146\163\240\159\146\165\226\157\147\240\159\146\171", 
        Text = ("Taph throws a Subspace Tripmine infront of him, which detonates when the killer\226\128\153s within %* studs of it. It automatically detonates after %* seconds and slightly \n"):format(v0.SubspaceRange, v0.SubspaceExplosionDelay) .. ("reveals itself every %* seconds. \n"):format((math.floor(v0.SubspaceLifetime / v0.SubspaceHintCount))) .. ("When triggered, the Killer (and Taph if theyre close to the mine) is inflicted with Subspaced %* For %* seconds. \n"):format(v0.SubspaceEffectLevel, v0.SubspaceEffectDuration) .. "If the killer hits the mine prior to it detonating, the mine inflicts a lesser punishment."
    }
};
return v0;