# Admin panels and command systems (game-made)

Admin tools written by the games themselves: text consoles, panel servers, command modules
with permission levels, moderation (kick / ban / freeze) and audit logs. Third-party admin
loaders (Adonis, HD Admin, Kohl's...) are not here. **Leaked games hide backdoors in admin code
more than anywhere else**, so every file was checked for hard-coded outsider UserIds, username
checks and remotes without a permission check. Where a good file had an id list inside it, only
the code around the list was copied (the excerpt note says which lines were dropped) and you
must add your own ids. Several files were rejected outright; see the last section. Start from
`_patterns/` if you want a clean system.

| File | From game | What it does | Reuse notes |
|---|---|---|---|
| [AdminService-AuditRateLimit__aura-ascension.lua](AdminService-AuditRateLimit__aura-ascension.lua) | aura-ascension | Admin check by UserIds or group rank (from a config module), per-admin rate limit, an AllowedCommands whitelist, structured payloads, and an audit log of who ran what. | Best-designed admin service here. Write your own AdminConfig (the game's points at its own group). Its _pushAudit sends the log to ALL clients; change FireAll to admins only. |
| [AdminCommandsService-Console__drill-and-mine.lua](AdminCommandsService-Console__drill-and-mine.lua) | drill-and-mine | F2 text console backend: tokenizer, partial-name player lookup, give-anything commands that reuse the real grant paths, aliases, help text, owner-only data wipe, cross-server shutdown via MessagingService. | Very practical. Every remote call is checked server-side with isAdmin; destructive commands need the owner id. |
| [AdminConsoleClient-F2Console__drill-and-mine.lua](AdminConsoleClient-F2Console__drill-and-mine.lua) | drill-and-mine | Client side of the console: asks the server if you are an admin, builds a small F2 text box UI, sends the raw line with RunCommand and prints the reply. | UI only; safe because the server re-checks. Pairs with AdminCommandsService above. |
| [CmdrServer-CommandParser__catalogue-avatar-creator.lua](CmdrServer-CommandParser__catalogue-avatar-creator.lua) | catalogue-avatar-creator | Server handler for a command bar: one RemoteFunction, admin check through a server-set IsAdministrator attribute, me/all/partial-name selectors, kick/ban/teleport/bring/god and more, pcall'd handlers. | Clean starting point. Its 'ban' only kicks; use Players:BanAsync for a real ban. The attribute is set elsewhere from creator / id list / usernames (prefer ids). |
| [AdminPanelServer-Moderation__escape-kitty-keyboard.lua](AdminPanelServer-Moderation__escape-kitty-keyboard.lua) | escape-kitty-keyboard | Remote functions for an admin panel: player list, kick, DataStore ban/unban checked on join, freeze that survives respawn, fun actions (ragdoll, spin, invisible, spectate), per-admin cooldown. | Every remote checks isPlayerAdmin. Messages are in French. Ban uses a DataStore; Players:BanAsync is the modern alternative. |
| [CommandManager-RankedModules__forsaken.lua](CommandManager-RankedModules__forsaken.lua) | forsaken | Each command is a ModuleScript (title, parameters, RequiredRank, AllowedInVIP, Executed); the server sends only the commands your rank allows and re-checks the rank on execute; private-server owners get VIP-safe commands. | Good architecture. Rank comes from a server-set 'Rank' attribute (group rank on join, see PlayerManager). The command modules themselves were decompiled and are not copied. |
| [CommandsService-ConchLoader__evade.lua](CommandsService-ConchLoader__evade.lua) | evade | Loads every ModuleScript in a Commands folder into the Conch console, gives the super-user role to permitted players and sends them the command list. | Shows the 'one file per command' loader. Its Config (not copied) contains an outsider UserId; write your own Config with AllowedUserIds / GroupId / MinGroupRank. |
| [ConsolePermissions__evade.lua](ConsolePermissions__evade.lua) | evade | hasPermission(player): true if the UserId is in Config.AllowedUserIds or the player's rank in Config.GroupId is at least MinGroupRank. | Tiny and correct; just supply your own Config. |
| [AdminHandler-PanelRemotes__brainrot-lab.lua](AdminHandler-PanelRemotes__brainrot-lab.lua) | brainrot-lab | Admin panel backend with one function per remote (spawn items, start/end events locally or globally, announcements, private-server tools, youtuber tags), each starting with an isAdmin check, plus player resolving by id or name. | Clear structure. AdminConfig (not copied) is the original game's id list; write your own with IsAdmin(player). |
| [_patterns/AdminPermissions.lua](_patterns/AdminPermissions.lua) | pattern (forsaken, aura-ascension, evade, catalogue-avatar-creator) | Resolves Player/VIP/Moderator/Admin/Owner from game owner, group ranks, your own UserId list and private-server ownership; caches it and mirrors an AdminLevel attribute. | Configure with YOUR group and ids. Has(player, 'Admin') everywhere on the server. |
| [_patterns/AdminCommands.lua](_patterns/AdminCommands.lua) | pattern (drill-and-mine, catalogue-avatar-creator, aura-ascension, escape-kitty-keyboard) | Command registry with levels, typed args (player/players/number/string), me/all/others selectors, rate limit, admin-only audit log, built-in help/kick/ban/unban/announce using the Roblox Ban API. | Requires AdminPermissions next to it. Add game commands with Register(). |

## Techniques seen across games

- **Check permission on the server for every remote call**, not just when the panel opens. All files copied here do this; the client 'IsAdmin' check only decides whether to show UI.
- **Permission sources**: game.CreatorId / owning-group rank 255 for the owner, group ranks for staff, and a short UserId list you control. Never usernames (they can be changed and re-registered).
- **Commands as data**: a table or one ModuleScript per command with a required rank and parameter list (`forsaken`, `evade`), so the client UI can be generated from what the server sends.
- **Least power by default**: whitelist which commands exist (`aura-ascension` AllowedCommands), keep destructive ones (data wipe, global shutdown) for the owner only (`drill-and-mine`), rate-limit admins too.
- **Keep an audit trail** of who ran what (`aura-ascension`), and only send it to admins.
- **Use the platform's ban system** (Players:BanAsync, which also handles alt accounts) instead of a home-made ban DataStore when you can.

## Things we did not copy (and why)

- `steal-a-brainrot-sab-files` CommandsService: its Config whitelists outsider UserIds (including 4515418871 and 9834833917 'Viveur292I', plus ids 1, 3, 4, 5), CommandsService gives the 'Lead' role to the hard-coded username `samnmydevv`, and the `ban` command posts to a live Discord webhook. Nothing copied.
- `steal-a-brainrot`: CommandsService grants roles by username, CustomAdminPanel whitelists four outsider UserIds, UnbanCommand trusts player names, and ShopService lets one hard-coded username run purchases for free. Nothing copied.
- `evade` CommandsService/Config lists an outsider UserId (8585395371) next to game.CreatorId; only the loader and the permission function were copied, not the Config.
- `murder-mystery-2` AdminCommands (10 hard-coded outsider ids), `grow-a-garden-2` CmdrPetCommands (17 ids), `drive-for-brainrots` AdminHandler (inline id) and `brainrot-lab` AdminConfig (10 ids): id lists not copied.
- `animal-hospital-modded` AdminBanKick / AdminGiftCommand give power to hard-coded usernames (`thehalconyt1` and a name list); not copied.
- `big-paintball` 2 _ Admins makes every member of BIG Games' group (3347452) an admin, and TempCommands hands out 9,999,999,999 credits; not copied.
- `rivals-modded` AdminPanelService is a free-items panel that 'everyone can use'; `steal-an-egg` AdminPanelHandler sells admin powers as a game pass and opens for free in Studio; `steal-an-egg-admin` adds decompiled code on top. Not copied.
- `the-rake` Admin/Admins use loadstring, setfenv and saveinstance (a third-party admin loader); `site-excalibur` Commands and `bee-swarm-sim` Equipment reference Discord; `slime-rng` admin services are decompiled. Not copied.
