local Channels = {};
--------------------------
Channels['Foundation'] = {Default = true, Requirements = {
	'Team:Foundation Personnel',
	'Team:Foundation Healthcare',
	'Team:Mobile Task Forces',
	'Team:Security Department',
	'Team:Department of External Affairs',
	'Team:Ethics Committee',
	'Team:Security Response Unit',
	'Team:Intelligence Agency',
	"Team:Scientific Department",
	'Player:0',
	'Gamepass:0'
}};

Channels['Combative'] = {Default = true, Requirements = {
	'Team:Security Response Unit',
	'Team:Global Occult Coalition',
	'Team:Mobile Task Forces',
	'Team:Security Department',
	'Team:Intelligence Agency',
	'Team:Internal Security Department',
	"Team:Administrative Department",
	'Player:0',
	'Gamepass:0'
}};

Channels['Friendly'] = {Default = true, Requirements = {
	'Team:Global Occult Coalition'
}};

Channels['Hostiles'] = {Default = false, Requirements = {
	'Team:GRU-P'
}}
--------------------------
return Channels