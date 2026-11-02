local CutsceneManager = require('@game/ServerStorage/Modules/Managers/CutsceneManager');

return function (context, Intro: string): ()	
	local Cutscene = CutsceneManager.new(context.Executor, Intro, 'IdkTwin');
	Cutscene:Play(1);
	
	return 'Fuck you bro.'
end