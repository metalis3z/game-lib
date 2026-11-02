# 09 - RNG, Gacha & Pets

Reference scripts for random rewards. This covers weighted rarity rolls, luck multipliers, pity, egg hatching, mutations, spin wheels, lucky blocks, index (collection) tracking, auto-roll, and equipping pets and making them follow the player.

They come from pet-rng, rcu-roller, slime-rng, steal-a-brainrot, evade, drill-and-mine, brainrot-lab and smash-egg-for-animals. Every file is copied unchanged from a script that passed the safety checks: no saveinstance or decompiler output, no web requests, no asset-id requires. Each file starts with a header naming the game, the original path and what it does. Excerpts list the line ranges they came from.

These are leaked or shared places, so they depend on their own frameworks (Knit, Net/Synchronizer, ProfileService, custom DataService). Read them for the ideas. To build your own, start from the `_patterns` folder.

## Files

| File | From game | What it does | Reuse notes |
|---|---|---|---|
| `WeightedRoll__pet-rng.lua` | pet-rng | The smallest possible weighted pick: total, draw, cumulative walk. | Copy as-is. Uses `pairs`, so order is not fixed. That doesn't matter for correctness. |
| `PetRarityTable__pet-rng.lua` | pet-rng | Pet table with raw weights, from 5 down to 0.0000001. The game shows them as "1/N". | Good model for an RNG game's "1 in 10M" pets. Keep the weights in one ModuleScript. |
| `RollAnimationAutoRoll__pet-rng.lua` | pet-rng | Client roll button. It flashes 4 fake results before the real one, has an auto-roll gamepass toggle, and multiplies rare weights by luck. | **Anti-pattern for security:** the client rolls and sends the pet name to the server. Keep only the UI part and roll on the server. |
| `RollServerAnnounceBadges__pet-rng.lua` | pet-rng | Shows odds as "1/N", gives badges at 1/100, 1/1k, ... and announces very rare rolls to all servers with MessagingService. | The announcement and badge thresholds are worth reusing. The server trusts the client's pet name, so don't copy that. |
| `PetFollowAlignPosition__pet-rng.lua` | pet-rng | Server-side pet follow using AlignPosition and AlignOrientation on attachments. A tween bobs the pet faster while the player walks. | Easy to understand, but there is one `while wait()` loop per pet on the server. Client-side following scales better (see `_patterns/PetFollower.lua`). |
| `EggHatchService__rcu-roller.lua` | rcu-roller | The best complete egg service. It has a rate limit, clamps the amount, checks the cost, applies luck as `weight^(1/luck)`, rolls Golden or Toxic tiers, stacks duplicates, writes index entries and hooks into quests. | Best starting point for a server egg hatch. Swap the Knit and Replica calls for your own data layer. |
| `PetEquipService__rcu-roller.lua` | rcu-roller | Equip and unequip with a slot cap (base + upgrades + passes), lock, delete (refused if the pet is locked) and nickname. | Shows the rule to follow: every action looks the pet up in the server's own data, never in what the client sent. |
| `PetRowFormation__rcu-roller.lua` | rcu-roller | Pure function that returns a formation of up to 3 arcs behind the player, sorted by pet size and priority. | Drop-in. Feed the offsets into any follow system. |
| `LuckStack__rcu-roller.lua` | rcu-roller | One function that adds up every luck source: flag, global event, upgrades, passes, potions, fruits and aura. | Keep luck in one shared function so the UI and the roll always agree. |
| `LuckChanceShift__rcu-roller.lua` | rcu-roller | `getNewChances` raises the % of rare pets and takes the same % from the common ones, so the egg still adds up to 100. | Use it for the "your odds with luck" egg preview. |
| `AuraRoll__rcu-roller.lua` | rcu-roller | Bundle: AuraService uses up a dice and rolls on the server; AuraUtils redistributes luck with clamping and works out aura XP levels. | Example of a consumable-item roll. |
| `ZonePoolRollMutations__slime-rng.lua` | slime-rng | Roll pool built from slimes the player's zone unlocks. It boosts rare tiers, rolls mutations independently, auto-equips, updates the index and runs "special every 10/100/1000 rolls" counters. | The best "RNG game" server roll here. The admin-luck pool clamp (`getMaxWeightForMultiplier`) is a neat trick. |
| `RandomLuckEvents__slime-rng.lua` | slime-rng | Every 5-10 minutes it starts a weighted random server luck event, from x2 (common) to x50 (rare). | Copy the config block and pick function. |
| `IndexCollectionTracking__slime-rng.lua` | slime-rng | Index service. It migrates old saves into the index, tracks counts per category and mutation, and gives index milestone rewards. | Its migration step is useful when you add an index to a live game. |
| `RNGMachineService__steal-a-brainrot.lua` | steal-a-brainrot | Paid slot machine. The server picks the result and the decoy reel entries, has a 15% chance of a luck-multiplier result, a skill tree (luck, speed, mutations), a 60-second buy offer and delivery to a podium. | Model for "the server decides, the client just animates." |
| `MutationTable__steal-a-brainrot.lua` | steal-a-brainrot | Two entries of the mutation table: roll Weight, income Modifier, icon and colour palettes. | Good layout for mutation data. |
| `ServerLuckTimer__steal-a-brainrot.lua` | steal-a-brainrot | Server luck index and end time, replicated and counted down every second. | Tiny. Uses `spawn` and a polling loop; a single end timestamp is simpler. |
| `SpinWheelService__evade.lua` | evade | Event spin wheel: weighted reward, an alternate reward if you already own the item, a cooldown, and free spins given on a UTC schedule. | Rewards are applied after a delay so the wheel can finish spinning. Server-authoritative. |
| `LuckyBlockService__drill-and-mine.lua` | drill-and-mine | Lucky blocks where luck gives a chance per step to climb one rarity (capped at +2). It skips invalid ids, falls back along the rarity ladder, and holds rewards as "pending" until the reveal is confirmed or times out. | Best example of capping luck so it can't skip progression, and of never losing a paid reward. |
| `PityTimerSpawns__brainrot-lab.lua` | brainrot-lab | Legendary, Mythical and Secret never roll randomly. A countdown per rarity guarantees one when it reaches zero. | A server-wide, time-based pity. For per-player, roll-count pity see `_patterns/PityCounter.lua`. |
| `EggZoneRolls__smash-egg-for-animals.lua` | smash-egg-for-animals | Size tier roll, an egg pick where luck boosts every egg except the most common one, and a pet pick plus stacked event mutations ("Like+Disco+Galaxy"). | Comments are in French. The "boost all but the first entry" rule is a simple, safe luck model. |
| `EggIncubateHatch__smash-egg-for-animals.lua` | smash-egg-for-animals | Eggs placed in the base incubate until `ReadyAt`, can grow heavier at random while waiting, then hatch on the server with an inventory-cap check. | Comments are in French. Good for "place egg, wait, hatch" games. |
| `GlobalLuckEvent__smash-egg-for-animals.lua` | smash-egg-for-animals | x4 luck event shared by every server. The end time is saved in a DataStore and broadcast with MessagingService, and a resync loop keeps servers in step. | Admin check is `AdminConfig.AdminIds`. Uses DataStore `GetAsync` only, no web requests. |
| `_patterns/WeightedTable.lua` | pattern | Weighted table with three luck modes (BoostRare, Exponent, Shift), binary-search roll, `RollMany` and "1/N" odds text. | Clean ModuleScript. Roll on the server. |
| `_patterns/PityCounter.lua` | pattern | Per-player hard and soft pity per banner, plus "every N rolls" bonus counters, kept in a table you can save. | Store the state in the player profile. |
| `_patterns/EggHatcher.lua` | pattern | Server egg hatch: validates the arguments, rate limits, spends before rolling, rolls tiers and mutations, writes the index. Plugs into any data layer. | Needs `WeightedTable.lua`. Auto-hatch is just the client calling it again. |
| `_patterns/PetFollower.lua` | pattern | Client pet follow: arc formation by size, frame-rate-independent lerp, walk and idle bobbing. | Run one per player on each client. The server only syncs which pets are equipped. |

## Techniques seen across games

- **Rarity tables are plain weights, not percentages.** pet-rng and slime-rng store a raw `weight` per item and show odds as `1/(total/weight)`. Adding an item never requires rebalancing the others. Egg-style games (rcu-roller, smash-egg) store % per egg so the egg UI can list them. drill-and-mine adds a rarity ladder (`LuckyBlockRarityOrder`) and a pool per rarity.
- **Luck is applied in one of four ways:**
  1. Multiply only the rare weights. Used by pet-rng (weights ≤ 0.02) and smash-egg (every entry except the first).
  2. Flatten the curve with `weight^(1/luck)` (rcu-roller eggs).
  3. Move % from common to rare so the total stays 100 (rcu-roller PetUtils and AuraUtils).
  4. Give a chance to climb rarity tiers, with a cap (drill-and-mine).

  slime-rng also uses zone gates and tier "amplifiers". Option 4, or a cap on option 1, is what stops stacked luck from skipping progression.
- **The good games roll on the server and send only the result.** rcu-roller, slime-rng, steal-a-brainrot (RNG machine), evade (spin wheel) and drill-and-mine all check the arguments, apply a cooldown, take the cost first and then roll. The client gets the result (and decoy reel entries) to animate. pet-rng is the counter-example: it rolls on the client and the server accepts any pet name.
- **Pity comes in two shapes.** Server-wide timers guarantee a rarity every X minutes (brainrot-lab conveyor). Per-player roll counters give a bonus roll every N rolls (slime-rng golden, diamond and void, saved in player data) or count toward "Mythical Pity" (rcu-roller `data.pity[egg]`).
- **Mutations are separate rolls on top of the item roll.** Each mutation has its own small chance (slime-rng: huge 0.8%, shiny 3%) or a weight in a table (steal-a-brainrot `Mutations.Weight` plus an income `Modifier`). Event mutations can stack as a "+"-joined string (smash-egg).
- **Server luck events live in one replicated value.** Most use an attribute or a synced channel plus an end timestamp (`LuckMultiplier`/`LuckEnd`, `ServerLuck.EndTime`). The cross-server version saves the end time in a DataStore and broadcasts it with MessagingService, so new servers join an event already running (smash-egg).
