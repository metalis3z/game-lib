local Settings = {}
local _L; coroutine.wrap(function()  _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))  end)()
Settings.MusicEnabled = true
Settings.SoundsEnabled = true
Settings.SupportsVR = false
Settings.MagicTextColorCodes = {
	["red"] = Color3.fromRGB(255, 52, 52),
	["yellow"] = Color3.fromRGB(255, 238, 51),
	["orange"] = Color3.fromRGB(255, 151, 33),
	["green"] = Color3.fromRGB(122, 255, 60),
	["teal"] = Color3.fromRGB(56, 255, 242),
	["blue"] = Color3.fromRGB(58, 193, 255),
	["purple"] = Color3.fromRGB(186, 66, 255),
	["pink"] = Color3.fromRGB(255, 92, 239),
	["white"] = Color3.fromRGB(255, 255, 255),
	["brown"] = Color3.fromRGB(147, 98, 66),
	["black"] = Color3.fromRGB(0, 0, 0),
	["grey"] = Color3.fromRGB(130, 130, 130),
	["o"] = Color3.fromRGB(103, 247, 247),
	["vipred"] = Color3.fromRGB(255, 74, 77),
}
Settings.MusicEnabled = true;
Settings.SoundsEnabled = true;
Settings.SupportsVR = false;
Settings.SupportsPortrait = false;
Settings.ForcedPortrait = false;
Settings.Scale9Slice = true;
Settings.ScaleStrokes = true;
Settings.ScalePadding = false;
Settings.ScaleLists = false;
Settings.ScaleGrids = false;
Settings.MagicTextColorCodes = {
	red = Color3.fromRGB(255, 52, 52), 
	yellow = Color3.fromRGB(255, 238, 51), 
	orange = Color3.fromRGB(255, 151, 33), 
	green = Color3.fromRGB(122, 255, 60), 
	teal = Color3.fromRGB(56, 255, 242), 
	blue = Color3.fromRGB(58, 193, 255), 
	purple = Color3.fromRGB(186, 66, 255), 
	pink = Color3.fromRGB(255, 92, 239), 
	white = Color3.fromRGB(255, 255, 255), 
	brown = Color3.fromRGB(147, 98, 66), 
	black = Color3.fromRGB(0, 0, 0), 
	grey = Color3.fromRGB(130, 130, 130)
};
Settings.MouseDownSound = 4380261669;

return Settings