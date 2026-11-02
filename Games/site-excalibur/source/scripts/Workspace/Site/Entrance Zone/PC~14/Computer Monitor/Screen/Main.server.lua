--Services
local Workspace      = game:GetService("Workspace");
local Players        = game:GetService("Players");

--Objects
local SurfaceGui     = script.Parent:WaitForChild("Screen"):WaitForChild("SurfaceGui");
local ThreatFrame      = SurfaceGui:WaitForChild("ThreatFrame");
local FPLabel        = ThreatFrame:WaitForChild("FPNumLabel");
local CombativesLabel  = ThreatFrame:WaitForChild("CombativesNumLabel");
local CDLabel   		= ThreatFrame:WaitForChild("CDNumLabel");
local MDLabel 			= ThreatFrame:WaitForChild("MDNumLabel");
local ScDLabel			= ThreatFrame:WaitForChild("ScDNumLabel");
local MTFLabel 			= ThreatFrame:WaitForChild("MTFNumLabel");
local SiteStatusLabel  = ThreatFrame:WaitForChild("SiteStatusLabel1");

--Settings
local RaidActive     = false;
local Personnel      = 0;
local Visitors       = 0;
local CI             = 0;

spawn(function ()
	while wait() do
		FPLabel.Text = #game:GetService("Teams")["Foundation Personnel"]:GetPlayers()
		CDLabel.Text = #game:GetService("Teams")["Class D"]:GetPlayers()
		CombativesLabel.Text = #game:GetService("Teams")["Security Department"]:GetPlayers()
		MDLabel.Text = #game:GetService("Teams")["Foundation Healthcare"]:GetPlayers()
		MTFLabel.Text = #game:GetService("Teams")["Mobile Task Forces"]:GetPlayers()
		ScDLabel.Text = #game:GetService("Teams")["Scientific Department"]:GetPlayers()
	end
end)