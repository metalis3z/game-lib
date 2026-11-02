-- These are configurable, but HD Admin has only been extensively tested under these
-- default settings, so it's highly recommended to keep these as they are to avoid issues
local ENDLESS_SEPARATOR = "|"
return {
	Collective = ",", -- The character used to split up items (like ,jump player1,player2,player3)
	SpaceSeparator = " ", -- The character between command arguments. Setting it to '/' would change ';jump me' to ';jump/me'
	EndlessArgSeparator = ENDLESS_SEPARATOR, -- The character separating two endless arguments (like ';poll all What is your favourite colour? || Red | Dark Blue | Green')
	EndlessArgPattern = ` {ENDLESS_SEPARATOR}{ENDLESS_SEPARATOR} `,
	EndlessArgCutPattern = ` {ENDLESS_SEPARATOR}{ENDLESS_SEPARATOR}`,
	EndlessFieldsPattern = ` {ENDLESS_SEPARATOR} `,
	EmptyUnparsedValue = "-", -- The value shown in the UI when unparse returns an empty string
}