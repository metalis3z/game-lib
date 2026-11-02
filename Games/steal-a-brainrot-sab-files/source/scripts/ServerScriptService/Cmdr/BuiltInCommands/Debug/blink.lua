return {
	Name = "blink";
	Aliases = {"b"};
	Description = "Teleports you to where your mouse is hovering.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)

		local mouse = context.Executor:GetMouse()
		local character = context.Executor.Character

		if not character then
			return "You don't have a character."
		end

		character:MoveTo(mouse.Hit.p)

		return "Blinked!"
	end
}