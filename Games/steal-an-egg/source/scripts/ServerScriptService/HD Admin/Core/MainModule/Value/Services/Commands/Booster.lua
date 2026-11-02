--[[

When a user purchases a gamepass you sell through HD Admin,
it will also recommend HD Admin's donation accessory, which
you receive 40% of, and HD Admin 30%.

The revenue from this not only increases your games revenue,
it provides an income for HD Admin so that we can continue
to build a better application and provide regular updates.
A large portion of this revenue is also invested into
open-source projects for the Roblox community.

For example, we're using this income to:

	1. 	Regularly update HD Admin:
		https://devforum.roblox.com/t/hd-admin-updates/3446058
		
	2. 	Invest into open-source initiatives like TopbarPlus:
		https://devforum.roblox.com/t/topbarplus/1017485
		
	3.	Re-write and re-build HD Admin from the ground up with
		modern programming practices and tools. Hop into #announcements
		of our community server to see some previews:
		https://www.roblox.com/communities/4676369/HD-Admin

Please also become familiar with HD Admin's license:
https://github.com/nanoblox/hd-admin/blob/main/LICENSE.md

If there's any changes you'd like to make to HD Admin don't
hesitate to get in touch with us via the social links of the model:
https://create.roblox.com/store/asset/857927023/HD-Admin

Many thanks for your support,

Ben, ForeverHD

--]]


--!strict
-- CONFIG
local ORDER = 1000000
local TAGS = {"_Booster"}
local PREFIX = "/"
local HIDE = true
local RANDOM_EMOTE_ICON = 131879078789509
local BUNDLE_COOLDOWN = 1.5
local EMOTE_COOLDOWN = 0.75


-- LOCAL
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local Task = require(modules.Objects.Task)
local getHumanoid = require(modules.PlayerUtil.getHumanoid)
local boosterDisplay = require(modules.CommandUtil.boosterDisplay)
local allDances: {any} = {}
local allEmotas: {any} = {}


-- LOCAL FUNCTIONS
local function updateProperties(command: any)
	command.name = PREFIX..command.name
	command.tags = TAGS
	command.order = ORDER
	command.hide = HIDE
	if command.aliases then
		local newAliases = {}
		for _, alias in command.aliases do
			table.insert(newAliases, PREFIX..alias)
		end
		command.aliases = newAliases
	end
end

local function createEmoteCommand(emoteName: string, emoteId: number | false, properties: any?)
	
	-- Group dances and actions/emotas
	if typeof(emoteId) == "number" then
		local detail = {emoteName, emoteId, properties or {}}
		if not properties then
			table.insert(allEmotas, detail)
		else
			local aliases = properties.Aliases
			if aliases then
				for _, alias in aliases do
					if alias:lower():match("dance") then
						table.insert(allDances, detail)
					end
				end
			end
		end
	end
	
	local createEmoteCommand = require(modules.CommandUtil.createEmoteCommand)
	local command: Task.Command?
	if typeof(emoteId) == "number" then
		-- Normal emote command
		command = createEmoteCommand(emoteName, emoteId, properties)
	else
		command = createEmoteCommand(emoteName, function()
			local query = (properties and properties.Query) or "Dance"
			local targetPool = if query == "Dance" then allDances else allEmotas
			local randomDetail = targetPool[math.random(1, #targetPool)]
			return unpack(randomDetail)
		end)
	end
	updateProperties(command)
	if typeof(emoteId) == "number" then
		boosterDisplay.register((command :: any).name:lower(), "Emote", emoteId)
	else
		boosterDisplay.register((command :: any).name:lower(), "Image", RANDOM_EMOTE_ICON)
	end
	local boosterEmote = command :: any
	boosterEmote.cooldown = EMOTE_COOLDOWN
	table.insert(boosterEmote.groups, "BoosterEmote")
	return command
end

local function createBundleCommand(bundleName: string, bundleId: number, properties: any?)
	local createBundleCommand = require(modules.CommandUtil.createBundleCommand)
	local command = createBundleCommand(bundleName, bundleId, properties)
	updateProperties(command)
	boosterDisplay.register((command :: any).name:lower(), "Bundle", bundleId)
	-- Every booster bundle shares a one second cooldown so holders can't spam-switch
	local boosterBundle = command :: any
	boosterBundle.cooldown = BUNDLE_COOLDOWN
	table.insert(boosterBundle.groups, "BoosterBundle")
	return command
end


-- COMMANDS
local commands: Task.Commands = {

	--------------------
	{
		name = PREFIX.."Commands",
		aliases = {PREFIX.."Cmds"},
		tags = TAGS,
		order = ORDER,
		args = {"Player"},
		run = function(task: Task.Class)
			local target = task.target
			require(modules.CommandUtil.openCommands)(target)
		end
	},

    --------------------
	createEmoteCommand("Shake", 132367660388476, {Looped = true});
	createEmoteCommand("Dolphin", 5938365243, {Looped = true, Aliases = {"Dance0"}});
	createEmoteCommand("Dorky", 4212499637, {Looped = true, Aliases = {"Dance1"}});
	createEmoteCommand("Monkey", 3716636630, {Looped = true, Aliases = {"Dance2"}});
	createEmoteCommand("Floss", 5917570207, {Looped = true, Aliases = {"Dance3"}});
	createEmoteCommand("AroundTown", 3576747102, {Looped = true, Aliases = {"Dance4"}});
	createEmoteCommand("TouchDance", 139021427684680, {Looped = true, Aliases = {"Dance5"}});
	createEmoteCommand("HotToGo", 79312439851071, {Looped = true, Aliases = {"Dance6"}});
	createEmoteCommand("FancyFeet", 3934988903, {Looped = true, Aliases = {"Dance7"}});
	createEmoteCommand("Bouncy", 14353423348, {Looped = true, Aliases = {"Dance8"}});
	createEmoteCommand("TopRock", 3570535774, {Looped = true, Aliases = {"Dance9"}});
	
	createEmoteCommand("Dance", false, {Query = "Dance"});
	createEmoteCommand("Emota", false, {Query = "Action"});
	
	createEmoteCommand("Cheer", 3994127840);
	createEmoteCommand("Backflip", 15694504637);
	createEmoteCommand("Salute", 3360689775);
	createEmoteCommand("Shy", 3576717965);
	createEmoteCommand("Sad", 4849502101);
	createEmoteCommand("Bored", 5230661597);
	createEmoteCommand("Flex", 3994130516);
	createEmoteCommand("Brag", 15506506103);
	createEmoteCommand("Tpose", 3576719440);
	createEmoteCommand("Vpose", 10214418283);
	createEmoteCommand("Ypose", 4391211308);
	createEmoteCommand("ZombieHands", 4212496830);
	createEmoteCommand("Roar", 18524331128);
	createEmoteCommand("HandBlast", 4849497510);
	createEmoteCommand("JumpingJacks", 3570649048);
	createEmoteCommand("GuitarAir", 15506499986);
	createEmoteCommand("Flare", 10214406616);
	createEmoteCommand("FaceFrame", 14353421343);
	createEmoteCommand("Samba", 16276506814);
	createEmoteCommand("Happy", 4849499887);
	
	createBundleCommand("Buff", 594200, {RemoveBodyParts = {"Head"}}),
	createBundleCommand("Snowman", 173035),
	createBundleCommand("Wormy", 394523),
	createBundleCommand("Skeleton", 4778),
	createBundleCommand("Chibi", 6470),
	createBundleCommand("Plush", 3416, {RemoveBodyParts = {"Head"}, ScaleHead = 1.15}),
	createBundleCommand("Chunky", 637696),
	createBundleCommand("Crab", 464998, {IgnoreAccessories = nil}),
	createBundleCommand("Spider", 340256, {IgnoreAccessories = {"Back"}}),
	createBundleCommand("Frog", 386731),
	createBundleCommand("Rat", 365520, {IgnoreAccessories = true}),
	createBundleCommand("Hamster", 8232),
	createBundleCommand("Capybara", 295597),
	createBundleCommand("Penguin", 319025, {IgnoreBodyParts = true}),
	createBundleCommand("Duck", 394166, {IgnoreAccessories = {"Hat", "Hair"}}),
	createBundleCommand("Goose", 310626, {IgnoreAccessories = true}),
	createBundleCommand("Sponge", 393419),
	createBundleCommand("Freak", 1186597),

	--------------------
	{
		name = PREFIX.."Reset",
		aliases = {PREFIX.."Re"},
		tags = TAGS,
		order = ORDER,
		args = {"Player"},
		hide = HIDE,
		run = function(task: Task.Class)
			local player: Player = task.target
			local targetUserId = player.UserId
			local tasks = Task.getTasks(nil, targetUserId) :: {Task.Class}
			local Commands = require(modules.Parent.Services.Commands)
			for _, targetTask: any in tasks do
				local commandKey = targetTask.commandKey
				local command = Commands.getCommand(commandKey)
				local commandPrefix = (command and command.prefix) or ""
				if commandPrefix == PREFIX then
					targetTask:destroy()
				end
			end
		end
	},

    --------------------
}


-- ADDITIONAL EMOTES
local forEveryCommand = require(modules.CommandUtil.forEveryCommand)
local emoteCommands = require(modules.Internal.Commands.FunPack.Emote) :: any
local indexToInsertAt = 2
forEveryCommand(emoteCommands, function(command: any)
	local config = command.config
	local emoteDetail = config and config.EmoteDetail
	if emoteDetail then
		local emoteName: string = emoteDetail[1]
		local emoteId: number = emoteDetail[2]
		local properties: any = emoteDetail[3]
		local newProperties = {Looped = true, PlayVoice = properties.PlayVoice == true}
		local additionalCommand = createEmoteCommand(emoteName, emoteId, newProperties)
		table.insert(commands, indexToInsertAt, additionalCommand)
		indexToInsertAt += 1
	end
end)


return commands