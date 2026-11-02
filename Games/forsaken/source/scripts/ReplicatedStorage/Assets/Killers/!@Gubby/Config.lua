-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Gubby", 
    Quote = "The one and only.", 
    Credits = "Made By: Yuyu, aaronrtwo & Kayla (Gubby made by: misaki_sana & amonim)", 
    RenderImage = "rbxassetid://132322722596320", 
    Price = 900, 
    Exclusive = true, 
    Health = 1500, 
    Speed = 15, 
    HipHeight = 1, 
    CollisionHitbox = script.CollisionHitbox, 
    QueryHitbox = script.QueryHitbox, 
    AttackDamage = 32.5, 
    RootPartDamage = 15, 
    ShootHitboxSize = 2.5, 
    ShootHitboxRange = 90, 
    CameraShakeMagnitude = 1.5, 
    CameraShakeDuration = 0.4, 
	Animations = {
		GunShoot = "rbxassetid://94147681322047", 
		Idle = "rbxassetid://124243232760407", 
		Stunned = {
			Start = "rbxassetid://132938525815691", 
			Loop = "rbxassetid://104760784738466", 
			End = "rbxassetid://109126829366208", 
		}, 
		Bite = "rbxassetid://72710557722539", 
		Run = "rbxassetid://116710979111061", 
		Walk = "rbxassetid://116710979111061", 
	}, 
    Sounds = {
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://103389202841467", 
                BPM = 81
            }, 
            [40] = {
                ID = "rbxassetid://122681522006881", 
                BPM = 81
            }, 
            [20] = {
                ID = "rbxassetid://72118386663393", 
                BPM = 81
            }, 
            [6] = {
                ID = "rbxassetid://99374771475778", 
                BPM = 81, 
                Chase = true
            }
        }, 
        Bite = "rbxassetid://430285057", 
        GunShoot = "rbxassetid://3976061026"
    }, 
    Voicelines = {}, 
    Information = {
        {
            Separator = "GENERAL INFO"
        }, 
        {
            Header = "GUUB", 
            Text = "I LOVE HGUBBY GUBBY SO AWESOME GUB B  GUBBBB"
        }
    }
};