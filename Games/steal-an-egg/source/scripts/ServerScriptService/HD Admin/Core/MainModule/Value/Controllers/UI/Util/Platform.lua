--!strict

local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

return {
	isMobile = UserInputService.TouchEnabled
		and GuiService.ViewportDisplaySize == Enum.DisplaySize.Small,
}
