
local survivorConfig = {

	--// stuff for the shop
	DisplayName = "Ringmaster";
	Quote = `Robloxia's "Greatest Circus Director!"`;
	Credits = "By: Forsaken Dev Team";
	RenderImage = "rbxassetid://76676408139128";
	Price = 500;
	
	--// basic stuff
	Speed = 12;
	
	--// abilities

	--// facial expressions
	Expressions = {
		Happy = "rbxassetid://129518825455437";
		Default = "rbxassetid://72727389118160";
		Hurt = "rbxassetid://88158089214276";
		Injured = "rbxassetid://137934480549683";
		Dead = "rbxassetid://99128042122280";
		Drinking = "rbxassetid://122817821371080";
	};
	
	--// animations
	Animations = {
		
	};
	
	--// sounds
	Sounds = {
		
	}
	
}

local survivorName = "Ringmaster"
survivorConfig.Information = {
	{
		Separator = "GENERAL INFO";
	};
	{
		Header = "RINGMASTER";
		Text = `Once Robloxia's Greatest Circus Director, he was best at his job and loved by fans. but one day while performenc. he made a mistake... a big mistake makig him fall to his demise\n`
	};
	{
		Header = "STATS";
		Text = `Difficulty: ★★★☆☆\n`..
			`Health: {survivorConfig.Health or 100}\n`..
			`Regular Speed: {survivorConfig.Speed or 12}\n`..
			`Sprinting Speed: {survivorConfig.SprintSpeed or 26}\n`..
			`Max Stamina: {survivorConfig.MaxStamina or 100}\n`..
			`Stamina Loss per sec: {survivorConfig.StaminaLoss or 10}\n`..
			`Stamina Gain per sec: {survivorConfig.StaminaGain or 20}\n`
	};
	{
		Separator = "ABILITIES";
	};
	{
		Image = "rbxassetid://89910721511648";
		Header = "W.I.P.";
		Text = `Cooldown: {'W.I.P.'}s\n`
	};
}


return survivorConfig