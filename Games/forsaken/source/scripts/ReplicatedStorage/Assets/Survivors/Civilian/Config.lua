local v0 = {
    DisplayName = "Civilian", 
	Quote = "\"Where\'s that Sheriff when we need em?\"", 
	Credits = "Rig and Anims by DoD team, Moveset by deadmanraptos", 
    Class = "Support", 
	RenderImage = "rbxassetid://81610053335082", 
    Price = 600, 
	Exclusive = true, 
    Speed = 7, 
	SprintSpeed = 26,
	StaminaLoss = 12, 
	StaminaGain = 30, 
	SlashDamage = 50, 
	PunchWindupTime = 0.7, 
	SlashStunTime = 3, 
	PunchCooldown = 40, 
	RevolverCooldown = 30, 	
	BulletSpeed = 75, 
	BulletLifetime = 4, 
	RevolverDamage = 0, 
	RevolverStunDuration = 1.5, 
	RevolverAuraDuration = 2, 
	ShockwaveTemplate = script.Shockwave, 
	ExplosionTemplate = script.Explosion,
	Expressions = {
		Happy = "rbxassetid://114601464939585", 
		Default = "rbxassetid://82332539028303", 
		Hurt = "rbxassetid://78074094314941", 
		Injured = "rbxassetid://133765506240800", 
		Dead = "rbxassetid://82701631581679", 
		Drinking = "rbxassetid://94461197791850", 
		StunnedKiller = "rbxassetid://98421826250244",
		Scared = "rbxassetid://120949068881890"
	}, 
    Animations = {
		Slash = "rbxassetid://85509775471898", 
		MassInfection = "rbxassetid://140652801901216", 
    }, 
	Sounds = {
		Unsheath = "rbxassetid://154157312", 
		Slash = "rbxassetid://0", 
		Hit = "rbxassetid://4766119678", 
		RevolverActivate = "rbxassetid://7127178040", 
		RevolverShoot = "rbxassetid://6350479847",
		RevolverTauntHit = "rbxassetid://17570651967",
		RevolverHit = "rbxassetid://4612378521",
		Chains = "rbxassetid://17570651967", 
	}, 
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "CIVILIAN", 
		Text = "Civilian is one of the many people the goverment deemed evil, being hunted down by many killer, they have adpated and turned into a gunslinger. Civilian is a powerful survivor ability wise, with both moves having relativity low cooldowns being able to pester the killer while they chase others."
    }, 
	{
		Header = "STATS", 
		Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v0.Health or 100) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 24) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
	}, 
	{
		Separator = "PASSIVES"
	},
	{ 
		Header = "Memorial", 
		Quote = "\"Sadly, died of death.\"", 
		Text = "Civilian will Die of Death upon death.\n"
	}, 
	{
		Separator = "ABILITIES"
	}, 
	{
		Image = "rbxassetid://97428323453639", 
		Header = "PUNCH", 
		Quote = "\"Grrrrhhhhhhhh\" - Civilian", 
		Text = "Cooldown: 40s\n" .. "Damage: 35\n" .. "Civilian gets angry and winds up a punch for 0.75 seconds, during this he cannot move at all for 1.75 seconds. Hitting the killer stuns then for 3 seconds.\n"
	}, 
	{
		Image = "rbxassetid://112065267803856", 
		Header = "REVOLVER", 
		Quote = "\"Think fast!\" - Civilian", 
		Text = "Cooldown: 30s\n" .. "Damage: 50\n" .. "Civilian holds still for 2 seconds and draws his revolver, then fires after 0.9 seconds shooting a bullet.\n" .. "The bullet flys foward until hitting a killer or wall. When hitting anything the bullet will explode causing a larger hitbox, stunning the killer for 1.5 seconds.\n"
	}, 
	{
		Separator = "LAST MAN STANDING RELATIONS"
	},
	{
		Text = "If killdroid is the killer and civilian is last, his revolver powers up to do 125 on shot, while lowering the cooldown to 15 seconds.\n"
	}, 
};
return v0;