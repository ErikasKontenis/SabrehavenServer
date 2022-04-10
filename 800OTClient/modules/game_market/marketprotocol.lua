MarketProtocol = {}

-- private functions

local silent
local protocol
local statistics = runinsandbox('offerstatistic')

local function send(msg)
  if protocol and not silent then
    protocol:send(msg)
  end
end

local function readMarketOffer(msg, action, var)
  local timestamp = msg:getU32()
  local counter = msg:getU16()

  local itemId = 0
  if var == MarketRequest.MyOffers or var == MarketRequest.MyHistory then
    itemId = msg:getU16()
  else
    itemId = var
  end

  local amount = msg:getU16()
  local price = msg:getU64()
  local playerName
  local state = MarketOfferState.Active
  if var == MarketRequest.MyHistory then
    state = msg:getU8()
  elseif var == MarketRequest.MyOffers then
  else
    playerName = msg:getString()
  end

  return MarketOffer.new({timestamp, counter}, action, Item.create(itemId), amount, price, playerName, state, var)
end

local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

-- parsing protocols
local function parseMarketEnter(protocol, msg)
  local items = {[0] = { id=1781,category=20,name="a small stone" },[1] = { id=2992,category=20,name="a snowball" },[2] = { id=3208,category=20,name="a giant smithhammer" },[3] = { id=3264,category=20,name="a sword" },[4] = { id=3265,category=20,name="a two handed sword" },[5] = { id=3266,category=20,name="a battle axe" },[6] = { id=3267,category=20,name="a dagger" },[7] = { id=3268,category=20,name="a hand axe" },[8] = { id=3269,category=20,name="a halberd" },[9] = { id=3270,category=20,name="a club" },[10] = { id=3271,category=20,name="a spike sword" },[11] = { id=3272,category=20,name="a rapier" },[12] = { id=3273,category=20,name="a sabre" },[13] = { id=3274,category=20,name="an axe" },[14] = { id=3275,category=20,name="a double axe" },[15] = { id=3276,category=20,name="a hatchet" },[16] = { id=3277,category=20,name="a spear" },[17] = { id=3278,category=20,name="a magic longsword" },[18] = { id=3279,category=20,name="a war hammer" },[19] = { id=3280,category=20,name="a fire sword" },[20] = { id=3281,category=20,name="a giant sword" },[21] = { id=3282,category=20,name="a morning star" },[22] = { id=3283,category=20,name="a carlin sword" },[23] = { id=3284,category=20,name="an ice rapier" },[24] = { id=3285,category=20,name="a longsword" },[25] = { id=3286,category=20,name="a mace" },[26] = { id=3287,category=20,name="a throwing star" },[27] = { id=3288,category=20,name="a magic sword" },[28] = { id=3289,category=20,name="a staff" },[29] = { id=3290,category=20,name="a silver dagger" },[30] = { id=3291,category=20,name="a knife" },[31] = { id=3292,category=20,name="a combat knife" },[32] = { id=3293,category=20,name="a sickle" },[33] = { id=3294,category=20,name="a short sword" },[34] = { id=3295,category=20,name="a bright sword" },[35] = { id=3296,category=20,name="a warlord sword" },[36] = { id=3297,category=20,name="a serpent sword" },[37] = { id=3298,category=20,name="a throwing knife" },[38] = { id=3299,category=20,name="a poison dagger" },[39] = { id=3300,category=20,name="a katana" },[40] = { id=3301,category=20,name="a broadsword" },[41] = { id=3302,category=20,name="a dragon lance" },[42] = { id=3303,category=20,name="a great axe" },[43] = { id=3304,category=20,name="a crowbar" },[44] = { id=3305,category=20,name="a battle hammer" },[45] = { id=3306,category=20,name="a golden sickle" },[46] = { id=3307,category=20,name="a scimitar" },[47] = { id=3308,category=20,name="a machete" },[48] = { id=3309,category=20,name="a thunder hammer" },[49] = { id=3310,category=20,name="an iron hammer" },[50] = { id=3311,category=20,name="a clerical mace" },[51] = { id=3312,category=20,name="a silver mace" },[52] = { id=3313,category=20,name="an obsidian lance" },[53] = { id=3314,category=20,name="a naginata" },[54] = { id=3315,category=20,name="a guardian halberd" },[55] = { id=3316,category=20,name="an orcish axe" },[56] = { id=3317,category=20,name="a barbarian axe" },[57] = { id=3318,category=20,name="a knight axe" },[58] = { id=3319,category=20,name="a stonecutter axe" },[59] = { id=3320,category=20,name="a fire axe" },[60] = { id=3321,category=20,name="an enchanted staff" },[61] = { id=3322,category=20,name="a dragon hammer" },[62] = { id=3323,category=20,name="a dwarven axe" },[63] = { id=3324,category=20,name="a skull staff" },[64] = { id=3325,category=20,name="a light mace" },[65] = { id=3326,category=20,name="a foil" },[66] = { id=3327,category=20,name="a daramanian mace" },[67] = { id=3328,category=20,name="a daramanian waraxe" },[68] = { id=3329,category=20,name="a daramanian axe" },[69] = { id=3330,category=20,name="a heavy machete" },[70] = { id=3331,category=20,name="a ravager's axe" },[71] = { id=3332,category=20,name="a hammer of wrath" },[72] = { id=3333,category=20,name="a crystal mace" },[73] = { id=3334,category=20,name="a pharaoh sword" },[74] = { id=3335,category=20,name="a twin axe" },[75] = { id=3336,category=20,name="a studded club" },[76] = { id=3337,category=20,name="a bone club" },[77] = { id=3338,category=20,name="a bone sword" },[78] = { id=3339,category=20,name="a djinn blade" },[79] = { id=3340,category=20,name="a heavy mace" },[80] = { id=3341,category=20,name="an arcane staff" },[81] = { id=3342,category=20,name="a war axe" },[82] = { id=3343,category=20,name="a lich staff" },[83] = { id=3344,category=20,name="a beastslayer axe" },[84] = { id=3345,category=20,name="a templar scytheblade" },[85] = { id=3346,category=20,name="a ripper lance" },[86] = { id=3347,category=20,name="a hunting spear" },[87] = { id=3348,category=20,name="a banana staff" },[88] = { id=3349,category=20,name="a crossbow" },[89] = { id=3350,category=20,name="a bow" },[90] = { id=3409,category=20,name="a steel shield" },[91] = { id=3410,category=20,name="a plate shield" },[92] = { id=3411,category=20,name="a brass shield" },[93] = { id=3412,category=20,name="a wooden shield" },[94] = { id=3413,category=20,name="a battle shield" },[95] = { id=3414,category=20,name="a mastermind shield" },[96] = { id=3415,category=20,name="a guardian shield" },[97] = { id=3416,category=20,name="a dragon shield" },[98] = { id=3417,category=20,name="a shield of honour" },[99] = { id=3418,category=20,name="a beholder shield" },[100] = { id=3419,category=20,name="a crown shield" },[101] = { id=3420,category=20,name="a demon shield" },[102] = { id=3421,category=20,name="a dark shield" },[103] = { id=3422,category=20,name="a great shield" },[104] = { id=3423,category=20,name="a blessed shield" },[105] = { id=3424,category=20,name="an ornamented shield" },[106] = { id=3425,category=20,name="a dwarven shield" },[107] = { id=3426,category=20,name="a studded shield" },[108] = { id=3427,category=20,name="a rose shield" },[109] = { id=3428,category=20,name="a tower shield" },[110] = { id=3429,category=20,name="a black shield" },[111] = { id=3430,category=20,name="a copper shield" },[112] = { id=3431,category=20,name="a viking shield" },[113] = { id=3432,category=20,name="an ancient shield" },[114] = { id=3433,category=20,name="a griffin shield" },[115] = { id=3434,category=20,name="a vampire shield" },[116] = { id=3435,category=20,name="a castle shield" },[117] = { id=3436,category=20,name="a medusa shield" },[118] = { id=3437,category=20,name="an amazon shield" },[119] = { id=3438,category=20,name="an eagle shield" },[120] = { id=3439,category=20,name="a phoenix shield" },[121] = { id=3440,category=20,name="a scarab shield" },[122] = { id=3441,category=20,name="a bone shield" },[123] = { id=3442,category=20,name="a tempest shield" },[124] = { id=3443,category=20,name="a tusk shield" },[125] = { id=3444,category=20,name="a sentinel shield" },[126] = { id=3445,category=20,name="a salamander shield" },[127] = { id=3453,category=20,name="a scythe" },[128] = { id=5803,category=20,name="an arbalest" },[129] = { id=6101,category=20,name="Ron the Ripper's sabre" },[130] = { id=6131,category=20,name="a tortoise shield" },[131] = { id=6390,category=20,name="a nightmare shield" },[132] = { id=6432,category=20,name="a necromancer shield" },[133] = { id=6527,category=20,name="the avenger" },[134] = { id=6553,category=20,name="a ruthless axe" },[135] = { id=7363,category=20,name="a piercing bolt" },[136] = { id=7364,category=20,name="a sniper arrow" },[137] = { id=7365,category=20,name="an onyx arrow" },[138] = { id=7366,category=20,name="a viper star" },[139] = { id=7367,category=20,name="an enchanted spear" },[140] = { id=7368,category=20,name="an assassin star" },[141] = { id=7378,category=20,name="a royal spear" },[142] = { id=7379,category=20,name="brutetamer's staff" },[143] = { id=7380,category=20,name="a headchopper" },[144] = { id=7381,category=20,name="a mammoth whopper" },[145] = { id=7382,category=20,name="a demonrage sword" },[146] = { id=7383,category=20,name="a relic sword" },[147] = { id=7384,category=20,name="a mystic blade" },[148] = { id=7385,category=20,name="a crimson sword" },[149] = { id=7386,category=20,name="a mercenary sword" },[150] = { id=7387,category=20,name="a diamond sceptre" },[151] = { id=7388,category=20,name="a vile axe" },[152] = { id=7389,category=20,name="a heroic axe" },[153] = { id=7390,category=20,name="the justice seeker" },[154] = { id=7391,category=20,name="a thaian sword" },[155] = { id=7392,category=20,name="an orcish maul" },[156] = { id=7402,category=20,name="a dragon slayer" },[157] = { id=7403,category=20,name="a berserker" },[158] = { id=7404,category=20,name="an assassin dagger" },[159] = { id=7405,category=20,name="a havoc blade" },[160] = { id=7406,category=20,name="a blacksteel sword" },[161] = { id=7407,category=20,name="a haunted blade" },[162] = { id=7408,category=20,name="a wyvern fang" },[163] = { id=7409,category=20,name="a northern star" },[164] = { id=7410,category=20,name="a queen's sceptre" },[165] = { id=7411,category=20,name="an ornamented axe" },[166] = { id=7412,category=20,name="a butcher's axe" },[167] = { id=7413,category=20,name="a titan axe" },[168] = { id=7414,category=20,name="a abyss hammer" },[169] = { id=7415,category=20,name="a cranial basher" },[170] = { id=7416,category=20,name="a bloody edge" },[171] = { id=7417,category=20,name="a runed sword" },[172] = { id=7418,category=20,name="a nightmare blade" },[173] = { id=7419,category=20,name="a dreaded cleaver" },[174] = { id=7420,category=20,name="a reaper's axe" },[175] = { id=7421,category=20,name="an onyx flail" },[176] = { id=7422,category=20,name="a jade hammer" },[177] = { id=7423,category=20,name="a skullcrusher" },[178] = { id=7424,category=20,name="a lunar staff" },[179] = { id=7425,category=20,name="a taurus mace" },[180] = { id=7426,category=20,name="an amber staff" },[181] = { id=7427,category=20,name="a chaos mace" },[182] = { id=7428,category=20,name="a bonebreaker" },[183] = { id=7429,category=20,name="a blessed sceptre" },[184] = { id=7430,category=20,name="a dragonbone staff" },[185] = { id=7431,category=20,name="a demonbone" },[186] = { id=7432,category=20,name="a furry club" },[187] = { id=7433,category=20,name="a ravenwing" },[188] = { id=7434,category=20,name="a royal axe" },[189] = { id=7435,category=20,name="an impaler" },[190] = { id=7436,category=20,name="an angelic axe" },[191] = { id=7437,category=20,name="a sapphire hammer" },[192] = { id=7449,category=20,name="a crystal sword" },[193] = { id=7450,category=20,name="a hammer of prophecy" },[194] = { id=7451,category=20,name="a shadow sceptre" },[195] = { id=7452,category=20,name="a spiked squelcher" },[196] = { id=7453,category=20,name="an executioner" },[197] = { id=7454,category=20,name="a glorious axe" },[198] = { id=7455,category=20,name="a mythril axe" },[199] = { id=7456,category=20,name="a noble axe" },[200] = { id=7460,category=20,name="a norse shield" },[201] = { id=3602,category=20,name="a brown bread" },[202] = { id=3008,category=20,name="a crystal necklace" },[203] = { id=3361,category=20,name="a leather armor" },[204] = { id=3114,category=20,name="a skull" },[205] = { id=3030,category=20,name="a small ruby" },[206] = { id=2920,category=20,name="a torch" },[207] = { id=3025,category=20,name="an ancient amulet" },[208] = { id=3046,category=20,name="a magic light wand" },[209] = { id=3357,category=20,name="a plate armor" },[210] = { id=3018,category=20,name="a scarab amulet" },[211] = { id=3042,category=20,name="a scarab coin" },[212] = { id=3033,category=20,name="a small amethyst" },[213] = { id=3032,category=20,name="a small emerald" },[214] = { id=3116,category=20,name="a big bone" },[215] = { id=3027,category=20,name="a black pearl" },[216] = { id=3041,category=20,name="a blue gem" },[217] = { id=3079,category=20,name="boots of haste" },[218] = { id=3076,category=20,name="a crystal ball" },[219] = { id=3007,category=20,name="a crystal ring" },[220] = { id=3356,category=20,name="a devil helmet" },[221] = { id=3051,category=20,name="an energy ring" },[222] = { id=3063,category=20,name="a gold ring" },[223] = { id=3364,category=20,name="golden legs" },[224] = { id=2903,category=20,name="a golden mug" },[225] = { id=3038,category=20,name="a green gem" },[226] = { id=3061,category=20,name="a life crystal" },[227] = { id=3366,category=20,name="a magic plate armor" },[228] = { id=3048,category=20,name="a might ring" },[229] = { id=3062,category=20,name="a mind stone" },[230] = { id=3070,category=20,name="a moonlight rod" },[231] = { id=3060,category=20,name="an orb" },[232] = { id=3055,category=20,name="a platinum amulet" },[233] = { id=3084,category=20,name="a protection amulet" },[234] = { id=2848,category=20,name="a purple tome" },[235] = { id=3098,category=20,name="a ring of healing" },[236] = { id=3006,category=20,name="a ring of the sky" },[237] = { id=3054,category=20,name="a silver amulet" },[238] = { id=3028,category=20,name="a small diamond" },[239] = { id=3029,category=20,name="a small sapphire" },[240] = { id=3066,category=20,name="a snakebite rod" },[241] = { id=3049,category=20,name="a stealth ring" },[242] = { id=3081,category=20,name="a stone skin amulet" },[243] = { id=3058,category=20,name="a strange symbol" },[244] = { id=3034,category=20,name="a talon" },[245] = { id=2993,category=20,name="a teddy bear" },[246] = { id=3069,category=20,name="a volcanic rod" },[247] = { id=3002,category=20,name="a voodoo doll" },[248] = { id=3072,category=20,name="a wand of plague" },[249] = { id=3026,category=20,name="a white pearl" },[250] = { id=3405,category=20,name="a horseman helmet" },[251] = { id=3404,category=20,name="a leopard armor" },[252] = { id=3351,category=20,name="a steel helmet" },[253] = { id=3577,category=20,name="meat" },[254] = { id=3492,category=20,name="a worm" },[255] = { id=3359,category=20,name="a brass armor" },[256] = { id=3352,category=20,name="a chain helmet" },[257] = { id=3353,category=20,name="an iron helmet" },[258] = { id=3559,category=20,name="leather legs" },[259] = { id=3567,category=20,name="a blue robe" },[260] = { id=2917,category=20,name="a candlestick" },[261] = { id=3122,category=20,name="a dirty cape" },[262] = { id=2949,category=20,name="a lyre" },[263] = { id=3463,category=20,name="a mirror" },[264] = { id=3566,category=20,name="a red robe" },[265] = { id=3017,category=20,name="a silver brooch" },[266] = { id=3568,category=20,name="a simple dress" },[267] = { id=3059,category=20,name="a spellbook" },[268] = { id=3004,category=20,name="a wedding ring" },[269] = { id=5894,category=20,name="a bat wing" },[270] = { id=3582,category=20,name="ham" },[271] = { id=5896,category=20,name="a bear paw" },[272] = { id=5902,category=20,name="a honeycomb" },[273] = { id=2893,category=20,name="an amphora" },[274] = { id=3383,category=20,name="a dark armor" },[275] = { id=3456,category=20,name="a pick" },[276] = { id=3554,category=20,name="steel boots" },[277] = { id=5893,category=20,name="a perfect behemoth fang" },[278] = { id=5930,category=20,name="a behemoth claw" },[279] = { id=3065,category=20,name="a quagmire rod" },[280] = { id=5898,category=20,name="a beholder's eye" },[281] = { id=3372,category=20,name="brass legs" },[282] = { id=3384,category=20,name="a dark helmet" },[283] = { id=3370,category=20,name="a knight armor" },[284] = { id=3371,category=20,name="knight legs" },[285] = { id=3003,category=20,name="a rope" },[286] = { id=3016,category=20,name="a ruby necklace" },[287] = { id=3369,category=20,name="a warrior helmet" },[288] = { id=3659,category=20,name="a blue rose" },[289] = { id=2844,category=20,name="a book" },[290] = { id=3595,category=20,name="a carrot" },[291] = { id=3574,category=20,name="a mystic turban" },[292] = { id=2933,category=20,name="a small oil lamp" },[293] = { id=5912,category=20,name="a blue piece of cloth" },[294] = { id=3115,category=20,name="a bone" },[295] = { id=3732,category=20,name="a green mushroom" },[296] = { id=5925,category=20,name="a hardened bone" },[297] = { id=3590,category=20,name="a cherry" },[298] = { id=3728,category=20,name="a dark mushroom" },[299] = { id=3661,category=20,name="a grave flower" },[300] = { id=3740,category=20,name="a shadow herb" },[301] = { id=3738,category=20,name="a sling herb" },[302] = { id=3607,category=20,name="cheese" },[303] = { id=3598,category=20,name="a cookie" },[304] = { id=3606,category=20,name="an egg" },[305] = { id=5890,category=20,name="a chicken feather" },[306] = { id=3578,category=20,name="a fish" },[307] = { id=3556,category=20,name="crocodile boots" },[308] = { id=3355,category=20,name="a leather helmet" },[309] = { id=3112,category=20,name="rotten meat" },[310] = { id=3093,category=20,name="a club ring" },[311] = { id=3012,category=20,name="a wolf tooth chain" },[312] = { id=3077,category=20,name="an ankh" },[313] = { id=3600,category=20,name="a bread" },[314] = { id=2885,category=20,name="a brown flask" },[315] = { id=2853,category=20,name="a bag" },[316] = { id=2914,category=20,name="a lamp" },[317] = { id=3050,category=20,name="a power ring" },[318] = { id=3551,category=20,name="sandals" },[319] = { id=2815,category=20,name="a scroll" },[320] = { id=2842,category=20,name="a book" },[321] = { id=3583,category=20,name="dragon ham" },[322] = { id=3386,category=20,name="a dragon scale mail" },[323] = { id=3450,category=20,name="a power bolt" },[324] = { id=3392,category=20,name="a royal helmet" },[325] = { id=3373,category=20,name="a strange helmet" },[326] = { id=5919,category=20,name="a dragon claw" },[327] = { id=5948,category=20,name="a red dragon leather" },[328] = { id=3731,category=20,name="a fire mushroom" },[329] = { id=5954,category=20,name="a demon horn" },[330] = { id=5776,category=20,name="a Sabrehaven talon" },[331] = { id=3078,category=20,name="a mysterious fetish" },[332] = { id=3147,category=20,name="a blank rune" },[333] = { id=2902,category=20,name="a bowl" },[334] = { id=3082,category=20,name="an elven amulet" },[335] = { id=3563,category=20,name="a green tunic" },[336] = { id=3509,category=20,name="an inkwell" },[337] = { id=3593,category=20,name="a melon" },[338] = { id=3037,category=20,name="a yellow gem" },[339] = { id=5805,category=20,name="a golden goblet" },[340] = { id=5922,category=20,name="a holy orchid" },[341] = { id=3449,category=20,name="a burst arrow" },[342] = { id=3557,category=20,name="plate legs" },[343] = { id=3071,category=20,name="a wand of inferno" },[344] = { id=5877,category=20,name="a green dragon leather" },[345] = { id=5920,category=20,name="a green dragon scale" },[346] = { id=5882,category=20,name="a red dragon scale" },[347] = { id=3097,category=20,name="a dwarven ring" },[348] = { id=3505,category=20,name="a letter" },[349] = { id=3378,category=20,name="a studded armor" },[350] = { id=3723,category=20,name="a white mushroom" },[351] = { id=5880,category=20,name="an iron ore" },[352] = { id=3552,category=20,name="leather boots" },[353] = { id=3584,category=20,name="a pear" },[354] = { id=3375,category=20,name="a soldier helmet" },[355] = { id=3362,category=20,name="studded legs" },[356] = { id=3092,category=20,name="an axe ring" },[357] = { id=3377,category=20,name="a scale armor" },[358] = { id=3446,category=20,name="a bolt" },[359] = { id=3358,category=20,name="a chain armor" },[360] = { id=3457,category=20,name="a shovel" },[361] = { id=3471,category=20,name="a cleaver" },[362] = { id=3403,category=20,name="a tribal mask" },[363] = { id=3560,category=20,name="a bast skirt" },[364] = { id=3056,category=20,name="a bronze amulet" },[365] = { id=3448,category=20,name="a poison arrow" },[366] = { id=2647,category=20,name="a green tapestry" },[367] = { id=5910,category=20,name="a green piece of cloth" },[368] = { id=3408,category=20,name="a beholder helmet" },[369] = { id=3044,category=20,name="an elephant tusk" },[370] = { id=3447,category=20,name="an arrow" },[371] = { id=3585,category=20,name="a red apple" },[372] = { id=3376,category=20,name="a studded helmet" },[373] = { id=5921,category=20,name="a heaven blossom" },[374] = { id=3073,category=20,name="a wand of cosmic energy" },[375] = { id=3592,category=20,name="grapes" },[376] = { id=2901,category=20,name="a waterskin" },[377] = { id=3105,category=20,name="a dirty fur" },[378] = { id=3736,category=20,name="a star herb" },[379] = { id=5786,category=20,name="a wooden whistle" },[380] = { id=5944,category=20,name="a soul orb" },[381] = { id=5903,category=20,name="Ferumbras' hat" },[382] = { id=3451,category=20,name="a pitchfork" },[383] = { id=3075,category=20,name="a wand of dragonbreath" },[384] = { id=3562,category=20,name="a coat" },[385] = { id=3130,category=20,name="twigs" },[386] = { id=2843,category=20,name="a book" },[387] = { id=3565,category=20,name="a cape" },[388] = { id=5909,category=20,name="a white piece of cloth" },[389] = { id=3354,category=20,name="a brass helmet" },[390] = { id=3052,category=20,name="a life ring" },[391] = { id=3367,category=20,name="a viking helmet" },[392] = { id=5913,category=20,name="a brown piece of cloth" },[393] = { id=3053,category=20,name="a time ring" },[394] = { id=5879,category=20,name="a spider silk" },[395] = { id=3120,category=20,name="a moldy cheese" },[396] = { id=3462,category=20,name="a small axe" },[397] = { id=2846,category=20,name="a book" },[398] = { id=3039,category=20,name="a red gem" },[399] = { id=3381,category=20,name="a crown armor" },[400] = { id=3385,category=20,name="a crown helmet" },[401] = { id=3382,category=20,name="crown legs" },[402] = { id=3658,category=20,name="a red rose" },[403] = { id=3572,category=20,name="a scarf" },[404] = { id=5911,category=20,name="a red piece of cloth" },[405] = { id=3558,category=20,name="chain legs" },[406] = { id=3396,category=20,name="a dwarfen helmet" },[407] = { id=3483,category=20,name="a fishing rod" },[408] = { id=5804,category=20,name="a nose ring" },[409] = { id=5878,category=20,name="a minotaur leather" },[410] = { id=3085,category=20,name="a dragon necklace" },[411] = { id=3586,category=20,name="an orange" },[412] = { id=3601,category=20,name="a roll" },[413] = { id=5875,category=20,name="sniper gloves" },[414] = { id=4839,category=20,name="a hydra egg" },[415] = { id=3587,category=20,name="a banana" },[416] = { id=5883,category=20,name="an ape fur" },[417] = { id=5876,category=20,name="a lizard leather" },[418] = { id=5881,category=20,name="a lizard scale" },[419] = { id=3407,category=20,name="a charmer's tiara" },[420] = { id=3998,category=20,name="a dead snake" },[421] = { id=2659,category=20,name="a blue tapestry" },[422] = { id=3588,category=20,name="a blueberry" },[423] = { id=3067,category=20,name="a tempest rod" },[424] = { id=2948,category=20,name="a wooden flute" },[425] = { id=5943,category=20,name="Morgaroth's heart" },[426] = { id=3045,category=20,name="a strange talisman" },[427] = { id=5914,category=20,name="a yellow piece of cloth" },[428] = { id=5809,category=20,name="a soul stone" },[429] = { id=5886,category=20,name="a spool of yarn" },[430] = { id=2854,category=20,name="a backpack" },[431] = { id=3091,category=20,name="a sword ring" },[432] = { id=2839,category=20,name="a book" },[433] = { id=3597,category=20,name="a corncob" },[434] = { id=3391,category=20,name="a crusader helmet" },[435] = { id=2875,category=20,name="a bottle" },[436] = { id=5808,category=20,name="Orshabaal's brain" },[437] = { id=3023,category=20,name="a holy scarab" },[438] = { id=3241,category=20,name="an ornamented ankh" },[439] = { id=3240,category=20,name="a burning heart" },[440] = { id=3024,category=20,name="a holy falcon" },[441] = { id=3019,category=20,name="a demonbone amulet" },[442] = { id=3237,category=20,name="a sword hilt" },[443] = { id=3239,category=20,name="a crystal arrow" },[444] = { id=3235,category=20,name="an ancient rune" },[445] = { id=3068,category=20,name="a crystal wand" },[446] = { id=3573,category=20,name="a magician hat" },[447] = { id=3036,category=20,name="a violet gem" },[448] = { id=3238,category=20,name="a cobrafang dagger" },[449] = { id=3022,category=20,name="an ancient tiara" },[450] = { id=3236,category=20,name="blue note" },[451] = { id=2950,category=20,name="a lute" },[452] = { id=2953,category=20,name="panpipes" },[453] = { id=3674,category=20,name="a goat grass" },[454] = { id=3739,category=20,name="a powder herb" },[455] = { id=3727,category=20,name="a wood mushroom" },[456] = { id=3374,category=20,name="a legion helmet" },[457] = { id=4831,category=20,name="an old parchment" },[458] = { id=3589,category=20,name="a coconut" },[459] = { id=3406,category=20,name="a feather headdress" },[460] = { id=3010,category=20,name="an emerald bangle" },[461] = { id=3360,category=20,name="a golden armor" },[462] = { id=2852,category=20,name="a red tome" },[463] = { id=5897,category=20,name="a wolf paw" },[464] = { id=2991,category=20,name="a doll" },[465] = { id=3454,category=20,name="a broom" },[466] = { id=3083,category=20,name="a garlic necklace" },[467] = { id=3553,category=20,name="bunnyslippers" },[468] = { id=5810,category=20,name="a voodoo doll" },[469] = { id=6088,category=20,name="a music sheet" },[470] = { id=6089,category=20,name="a music sheet" },[471] = { id=6099,category=20,name="Brutus Bloodbeard's hat" },[472] = { id=6102,category=20,name="Deadeye Devious' eye patch" },[473] = { id=5926,category=20,name="a pirate backpack" },[474] = { id=6090,category=20,name="a music sheet" },[475] = { id=5668,category=20,name="a mysterious voodoo skull" },[476] = { id=2995,category=20,name="a piggy bank" },[477] = { id=5096,category=20,name="a mango" },[478] = { id=5901,category=20,name="wood" },[479] = { id=6100,category=20,name="the Lethal Lissy's shirt" },[480] = { id=6087,category=20,name="a music sheet" },[481] = { id=3074,category=20,name="a wand of vortex" },[482] = { id=6095,category=20,name="a pirate shirt" },[483] = { id=5090,category=20,name="a treasure map" },[484] = { id=3123,category=20,name="worn leather boots" },[485] = { id=6097,category=20,name="a hook" },[486] = { id=6098,category=20,name="an eye patch" },[487] = { id=6126,category=20,name="a peg leg" },[488] = { id=5792,category=20,name="a dice" },[489] = { id=5552,category=20,name="a rum flask" },[490] = { id=5461,category=20,name="pirate boots" },[491] = { id=6096,category=20,name="a pirate hat" },[492] = { id=5813,category=20,name="a skull candle" },[493] = { id=5710,category=20,name="a light shovel" },[494] = { id=5927,category=20,name="a pirate bag" },[495] = { id=5918,category=20,name="pirate knee breeches" },[496] = { id=2814,category=20,name="a parchment" },[497] = { id=5917,category=20,name="a bandana" },[498] = { id=5928,category=20,name="an empty goldfish bowl" },[499] = { id=5895,category=20,name="a fish fin" },[500] = { id=3581,category=20,name="shrimp" },[501] = { id=3125,category=20,name="remains of a fish" },[502] = { id=3111,category=20,name="a fishbone" },[503] = { id=5741,category=20,name="a skull helmet" },[504] = { id=5678,category=20,name="a tortoise egg" },[505] = { id=5014,category=20,name="a mandrake" },[506] = { id=5899,category=20,name="a turtle shell" },[507] = { id=6558,category=20,name="concentrated demonic blood" },[508] = { id=5021,category=20,name="an orichalcum pearl" },[509] = { id=6299,category=20,name="a death ring" },[510] = { id=5799,category=20,name="a golden figurine" },[511] = { id=3605,category=20,name="a bunch of wheat" },[512] = { id=3057,category=20,name="an amulet of loss" },[513] = { id=6536,category=20,name="Countess Sorrow's frozen tear" },[514] = { id=3461,category=20,name="a saw" },[515] = { id=5479,category=20,name="a cat's paw" },[516] = { id=6546,category=20,name="Dracola's eye" },[517] = { id=6496,category=20,name="a christmas present bag" },[518] = { id=6276,category=20,name="a lump of cake dough" },[519] = { id=3599,category=20,name="a candy cane" },[520] = { id=2639,category=20,name="a picture" },[521] = { id=6500,category=20,name="a gingerbreadman" },[522] = { id=4871,category=20,name="an explorer brooch" },[523] = { id=6392,category=20,name="a valentine's cake" },[524] = { id=6091,category=20,name="a very noble-looking watch" },[525] = { id=2394,category=20,name="a blue pillow" },[526] = { id=2395,category=20,name="a red pillow" },[527] = { id=2396,category=20,name="a green pillow" },[528] = { id=2397,category=20,name="a yellow pillow" },[529] = { id=2983,category=20,name="a flower bowl" },[530] = { id=4828,category=20,name="a flask of cough syrup" },[531] = { id=3155,category=20,name="a spell rune" },[532] = { id=3124,category=20,name="a burnt scroll" },[533] = { id=3481,category=20,name="a closed trap" },[534] = { id=3113,category=20,name="broken pottery" },[535] = { id=5806,category=20,name="a silver goblet" },[536] = { id=6525,category=20,name="a skeleton decoration" },[537] = { id=6540,category=20,name="a piece of Massacre's shell" },[538] = { id=6537,category=20,name="Mr. Punish's handcuffs" },[539] = { id=3110,category=20,name="a piece of iron" },[540] = { id=5887,category=20,name="a piece of royal steel" },[541] = { id=5889,category=20,name="a piece of draconian steel" },[542] = { id=5888,category=20,name="a piece of hell steel" },[543] = { id=3103,category=20,name="a cornucopia" },[544] = { id=3260,category=20,name="a lyre" },[545] = { id=6539,category=20,name="the Handmaiden's protector" },[546] = { id=6534,category=20,name="the Imperor's trident" },[547] = { id=6528,category=20,name="an infernal bolt" },[548] = { id=6535,category=20,name="the Plasmother's remains" },[549] = { id=3379,category=20,name="a doublet" },[550] = { id=2874,category=20,name="a vial" },[551] = { id=2906,category=20,name="a watch" },[552] = { id=3579,category=20,name="salmon" },[553] = { id=3994,category=20,name="a dead rat" },[554] = { id=5460,category=20,name="a helmet of the deep" },[555] = { id=3080,category=20,name="a broken amulet" },[556] = { id=5906,category=20,name="a demon dust" },[557] = { id=5891,category=20,name="an enchanted chicken wing" },[558] = { id=5885,category=20,name="a flask of warrior's sweat" },[559] = { id=3657,category=20,name="a heaven blossom" },[560] = { id=5904,category=20,name="a magic sulphur" },[561] = { id=5884,category=20,name="a spirit container" },[562] = { id=5905,category=20,name="a vampire dust" },[563] = { id=3561,category=20,name="a jacket" },[564] = { id=3363,category=20,name="dragon scale legs" },[565] = { id=3365,category=20,name="a golden helmet" },[566] = { id=3368,category=20,name="a winged helmet" },[567] = { id=3380,category=20,name="a noble armor" },[568] = { id=3387,category=20,name="a demon helmet" },[569] = { id=3388,category=20,name="a demon armor" },[570] = { id=3389,category=20,name="demon legs" },[571] = { id=3390,category=20,name="a horned helmet" },[572] = { id=3397,category=20,name="a dwarven armor" },[573] = { id=4007,category=20,name="a dead wolf" },[574] = { id=2911,category=20,name="a candelabrum" },[575] = { id=2863,category=20,name="a bag" },[576] = { id=2834,category=20,name="a document" },[577] = { id=2835,category=20,name="a parchment" },[578] = { id=2871,category=20,name="a backpack" },[579] = { id=2856,category=20,name="a present" },[580] = { id=2873,category=20,name="a bucket" },[581] = { id=2881,category=20,name="a cup" },[582] = { id=2905,category=20,name="a plate" },[583] = { id=3179,category=20,name="a spell rune" },[584] = { id=3197,category=20,name="a spell rune" },[585] = { id=3173,category=20,name="a spell rune" },[586] = { id=3195,category=20,name="a spell rune" },[587] = { id=3149,category=20,name="a spell rune" },[588] = { id=3180,category=20,name="a spell rune" },[589] = { id=3203,category=20,name="a spell rune" },[590] = { id=3165,category=20,name="a spell rune" },[591] = { id=2775,category=20,name="a furniture package" },[592] = { id=2776,category=20,name="a furniture package" },[593] = { id=2777,category=20,name="a furniture package" },[594] = { id=2778,category=20,name="a furniture package" },[595] = { id=2779,category=20,name="a furniture package" },[596] = { id=4867,category=20,name="a botanist's container" },[597] = { id=4863,category=20,name="a butterfly conservation kit" },[598] = { id=4852,category=20,name="an ectoplasm container" },[599] = { id=6108,category=20,name="an atlas" },[600] = { id=5865,category=20,name="a juice squeezer" },[601] = { id=3594,category=20,name="a pumpkin" },[602] = { id=3591,category=20,name="a strawberry" },[603] = { id=2880,category=20,name="a mug" },[604] = { id=2876,category=20,name="a vase" },[605] = { id=3174,category=20,name="a spell rune" },[606] = { id=3172,category=20,name="a spell rune" },[607] = { id=3153,category=20,name="a spell rune" },[608] = { id=3188,category=20,name="a spell rune" },[609] = { id=3152,category=20,name="a spell rune" },[610] = { id=3189,category=20,name="a spell rune" },[611] = { id=3148,category=20,name="a spell rune" },[612] = { id=3198,category=20,name="a spell rune" },[613] = { id=3164,category=20,name="a spell rune" },[614] = { id=3160,category=20,name="a spell rune" },[615] = { id=3177,category=20,name="a spell rune" },[616] = { id=3191,category=20,name="a spell rune" },[617] = { id=3178,category=20,name="a spell rune" },[618] = { id=3192,category=20,name="a spell rune" },[619] = { id=3176,category=20,name="a spell rune" },[620] = { id=3200,category=20,name="a spell rune" },[621] = { id=3190,category=20,name="a spell rune" },[622] = { id=3166,category=20,name="a spell rune" },[623] = { id=2857,category=20,name="a bag" },[624] = { id=2865,category=20,name="a backpack" },[625] = { id=2861,category=20,name="a bag" },[626] = { id=2869,category=20,name="a backpack" },[627] = { id=2855,category=20,name="a basket" },[628] = { id=2990,category=20,name="a football" },[629] = { id=2862,category=20,name="a bag" },[630] = { id=2870,category=20,name="a backpack" },[631] = { id=2789,category=20,name="a furniture package" },[632] = { id=2790,category=20,name="a furniture package" },[633] = { id=2791,category=20,name="a furniture package" },[634] = { id=2471,category=20,name="a crate" },[635] = { id=2472,category=20,name="a chest" },[636] = { id=2469,category=20,name="a box" },[637] = { id=2793,category=20,name="a furniture package" },[638] = { id=2792,category=20,name="a furniture package" },[639] = { id=2794,category=20,name="a furniture package" },[640] = { id=6114,category=20,name="an armor rack kit" },[641] = { id=6115,category=20,name="a weapon rack kit" },[642] = { id=6372,category=20,name="a bookcase kit" },[643] = { id=3473,category=20,name="a rolling pin" },[644] = { id=3013,category=20,name="a golden amulet" },[645] = { id=5938,category=20,name="Ceiron's waterskin" },[646] = { id=2882,category=20,name="a jug" },[647] = { id=3464,category=20,name="a baking tray" },[648] = { id=3465,category=20,name="a pot" },[649] = { id=3466,category=20,name="a pan" },[650] = { id=3467,category=20,name="a fork" },[651] = { id=3468,category=20,name="a spoon" },[652] = { id=3469,category=20,name="a knife" },[653] = { id=3470,category=20,name="a wooden spoon" },[654] = { id=3472,category=20,name="an oven spatula" },[655] = { id=2968,category=20,name="a wooden key" },[656] = { id=5615,category=20,name="a pirate tapestry" },[657] = { id=2802,category=20,name="a furniture package" },[658] = { id=2803,category=20,name="a furniture package" },[659] = { id=2804,category=20,name="a furniture package" },[660] = { id=2782,category=20,name="a furniture package" },[661] = { id=2783,category=20,name="a furniture package" },[662] = { id=2784,category=20,name="a furniture package" },[663] = { id=2785,category=20,name="a furniture package" },[664] = { id=2981,category=20,name="god flowers" },[665] = { id=2811,category=20,name="a furniture package" },[666] = { id=2984,category=20,name="a honey flower" },[667] = { id=2985,category=20,name="a potted flower" },[668] = { id=2812,category=20,name="a furniture package" },[669] = { id=2386,category=20,name="a small purple pillow" },[670] = { id=2387,category=20,name="a small green pillow" },[671] = { id=2388,category=20,name="a small red pillow" },[672] = { id=2389,category=20,name="a small blue pillow" },[673] = { id=2390,category=20,name="a small orange pillow" },[674] = { id=2391,category=20,name="a small turquoise pillow" },[675] = { id=2392,category=20,name="a small white pillow" },[676] = { id=2398,category=20,name="a round blue pillow" },[677] = { id=2400,category=20,name="a round purple pillow" },[678] = { id=2399,category=20,name="a round red pillow" },[679] = { id=2401,category=20,name="a round turquoise pillow" },[680] = { id=2393,category=20,name="a heart pillow" },[681] = { id=2805,category=20,name="a furniture package" },[682] = { id=2806,category=20,name="a furniture package" },[683] = { id=6371,category=20,name="an oven kit" },[684] = { id=2807,category=20,name="a furniture package" },[685] = { id=2808,category=20,name="a furniture package" },[686] = { id=2974,category=20,name="a water pipe" },[687] = { id=2801,category=20,name="a furniture package" },[688] = { id=2799,category=20,name="a furniture package" },[689] = { id=2798,category=20,name="a furniture package" },[690] = { id=2800,category=20,name="a furniture package" },[691] = { id=2797,category=20,name="a furniture package" },[692] = { id=2796,category=20,name="a furniture package" },[693] = { id=2664,category=20,name="a cuckoo clock" },[694] = { id=2641,category=20,name="a picture" },[695] = { id=2640,category=20,name="a picture" },[696] = { id=2632,category=20,name="a wall mirror" },[697] = { id=2638,category=20,name="a wall mirror" },[698] = { id=2635,category=20,name="a wall mirror" },[699] = { id=2644,category=20,name="a purple tapestry" },[700] = { id=2650,category=20,name="a yellow tapestry" },[701] = { id=2653,category=20,name="an orange tapestry" },[702] = { id=2656,category=20,name="a red tapestry" },[703] = { id=2667,category=20,name="a white tapestry" },[704] = { id=2970,category=20,name="a copper key" },[705] = { id=4844,category=20,name="an elven poetry book" },[706] = { id=2952,category=20,name="a drum" },[707] = { id=2954,category=20,name="a simple fanfare" },[708] = { id=5952,category=20,name="a poem scroll" },[709] = { id=5467,category=20,name="a fire bug" },[710] = { id=2837,category=20,name="a book" },[711] = { id=2838,category=20,name="a book" },[712] = { id=6386,category=20,name="a greeting card" },[713] = { id=6538,category=20,name="a valentine's card" },[714] = { id=5088,category=20,name="a furniture package" },[715] = { id=5086,category=20,name="a furniture package" },[716] = { id=5087,category=20,name="a furniture package" },[717] = { id=2858,category=20,name="a bag" },[718] = { id=2866,category=20,name="a backpack" },[719] = { id=3596,category=20,name="a tomato" },[720] = { id=2872,category=20,name="a backpack" },[721] = { id=2864,category=20,name="a bag" },[722] = { id=6106,category=20,name="a bottle of whisper beer" },[723] = { id=3724,category=20,name="a red mushroom" },[724] = { id=3725,category=20,name="a brown mushroom" },[725] = { id=3668,category=20,name="a tulip" },[726] = { id=3735,category=20,name="a stone herb" },[727] = { id=3737,category=20,name="a fern" },[728] = { id=3452,category=20,name="a rake" },[729] = { id=3455,category=20,name="a hoe" },[730] = { id=5950,category=20,name="a beach bag" },[731] = { id=5949,category=20,name="a beach backpack" },[732] = { id=2860,category=20,name="a bag" },[733] = { id=2868,category=20,name="a backpack" },[734] = { id=2969,category=20,name="a silver key" },[735] = { id=2859,category=20,name="a bag" },[736] = { id=2867,category=20,name="a backpack" },[737] = { id=2780,category=20,name="a furniture package" },[738] = { id=2781,category=20,name="a furniture package" },[739] = { id=2809,category=20,name="a furniture package" },[740] = { id=2786,category=20,name="a furniture package" },[741] = { id=2787,category=20,name="a furniture package" },[742] = { id=2788,category=20,name="a furniture package" },[743] = { id=2810,category=20,name="a furniture package" },[744] = { id=2795,category=20,name="a furniture package" }, }

  local vocation = -1
  local offers = msg:getU8()
  local balance = msg:getU64();
  local depotItems = {}
  local depotCount = msg:getU16()
  for i = 1, depotCount do
    local itemId = msg:getU16() -- item id
    local itemCount = msg:getU16() -- item count

    depotItems[itemId] = itemCount
  end
  
  signalcall(Market.onMarketEnter, depotItems, offers, balance, vocation, items)
  return true
end

local function parseMarketLeave(protocol, msg)
  Market.onMarketLeave()
  return true
end

local function parseMarketDetail(protocol, msg)
  local itemId = msg:getU16()
  local descriptions = {}
  for i = MarketItemDescription.First, MarketItemDescription.Last do
    if msg:peekU16() ~= 0x00 then
      table.insert(descriptions, {i, msg:getString()}) -- item descriptions
    else
      msg:getU16()
    end
  end

  if g_game.getProtocolVersion() >= 1100 then -- imbuements
    if msg:peekU16() ~= 0x00 then
      table.insert(descriptions, {MarketItemDescription.Last + 1, msg:getString()})
    else
      msg:getU16()
    end  
  end

  local time = (os.time() / 1000) * statistics.SECONDS_PER_DAY;

  local purchaseStats = {}
  local count = msg:getU8()
  for i=1, count do
    local transactions = msg:getU32() -- transaction count
    local totalPrice = msg:getU64() -- total price
    local highestPrice = msg:getU64() -- highest price
    local lowestPrice = msg:getU64() -- lowest price

    local tmp = time - statistics.SECONDS_PER_DAY
    table.insert(purchaseStats, OfferStatistic.new(tmp, MarketAction.Buy, transactions, totalPrice, highestPrice, lowestPrice))
  end

  local saleStats = {}
  count = msg:getU8()
  for i=1, count do
    local transactions = msg:getU32() -- transaction count
    local totalPrice = msg:getU64() -- total price
    local highestPrice = msg:getU64() -- highest price
    local lowestPrice = msg:getU64() -- lowest price

    local tmp = time - statistics.SECONDS_PER_DAY
    table.insert(saleStats, OfferStatistic.new(tmp, MarketAction.Sell, transactions, totalPrice, highestPrice, lowestPrice))
  end

  signalcall(Market.onMarketDetail, itemId, descriptions, purchaseStats, saleStats)
  return true
end

local function parseMarketBrowse(protocol, msg)
  local var = msg:getU16()
  local offers = {}

  local buyOfferCount = msg:getU32()
  for i = 1, buyOfferCount do
    table.insert(offers, readMarketOffer(msg, MarketAction.Buy, var))
  end

  local sellOfferCount = msg:getU32()
  for i = 1, sellOfferCount do
    table.insert(offers, readMarketOffer(msg, MarketAction.Sell, var))
  end

  signalcall(Market.onMarketBrowse, offers, var)
  return true
end

-- public functions
function initProtocol()
  connect(g_game, { onGameStart = MarketProtocol.registerProtocol,
                    onGameEnd = MarketProtocol.unregisterProtocol })

  -- reloading module
  if g_game.isOnline() then
    MarketProtocol.registerProtocol()
  end

  MarketProtocol.silent(false)
end

function terminateProtocol()
  disconnect(g_game, { onGameStart = MarketProtocol.registerProtocol,
                       onGameEnd = MarketProtocol.unregisterProtocol })

  -- reloading module
  MarketProtocol.unregisterProtocol()
  MarketProtocol = nil
end

function MarketProtocol.updateProtocol(_protocol)
  protocol = _protocol
end

function MarketProtocol.registerProtocol()
  if g_game.getFeature(GamePlayerMarket) then
    ProtocolGame.registerOpcode(GameServerOpcodes.GameServerMarketEnter, parseMarketEnter)
    ProtocolGame.registerOpcode(GameServerOpcodes.GameServerMarketLeave, parseMarketLeave)
    ProtocolGame.registerOpcode(GameServerOpcodes.GameServerMarketDetail, parseMarketDetail)
    ProtocolGame.registerOpcode(GameServerOpcodes.GameServerMarketBrowse, parseMarketBrowse)
  end
  MarketProtocol.updateProtocol(g_game.getProtocolGame())
end

function MarketProtocol.unregisterProtocol()
  if g_game.getFeature(GamePlayerMarket) then
    ProtocolGame.unregisterOpcode(GameServerOpcodes.GameServerMarketEnter, parseMarketEnter)
    ProtocolGame.unregisterOpcode(GameServerOpcodes.GameServerMarketLeave, parseMarketLeave)
    ProtocolGame.unregisterOpcode(GameServerOpcodes.GameServerMarketDetail, parseMarketDetail)
    ProtocolGame.unregisterOpcode(GameServerOpcodes.GameServerMarketBrowse, parseMarketBrowse)
  end
  MarketProtocol.updateProtocol(nil)
end

function MarketProtocol.silent(mode)
  silent = mode
end

-- sending protocols

function MarketProtocol.sendMarketLeave()
  if g_game.getFeature(GamePlayerMarket) then
    local msg = OutputMessage.create()
    msg:addU8(ClientOpcodes.ClientMarketLeave)
    send(msg)
  else
    g_logger.error('MarketProtocol.sendMarketLeave does not support the current protocol.')
  end
end

function MarketProtocol.sendMarketBrowse(browseId)
  if g_game.getFeature(GamePlayerMarket) then
    local msg = OutputMessage.create()
    msg:addU8(ClientOpcodes.ClientMarketBrowse)
    msg:addU16(browseId)
    send(msg)
  else
    g_logger.error('MarketProtocol.sendMarketBrowse does not support the current protocol.')
  end
end

function MarketProtocol.sendMarketBrowseMyOffers()
  MarketProtocol.sendMarketBrowse(MarketRequest.MyOffers)
end

function MarketProtocol.sendMarketBrowseMyHistory()
  MarketProtocol.sendMarketBrowse(MarketRequest.MyHistory)
end

function MarketProtocol.sendMarketCreateOffer(type, spriteId, amount, price, anonymous)
  if g_game.getFeature(GamePlayerMarket) then
    local msg = OutputMessage.create()
    msg:addU8(ClientOpcodes.ClientMarketCreate)
    msg:addU8(type)
    msg:addU16(spriteId)
    msg:addU16(amount)
    msg:addU64(price)
    msg:addU8(anonymous)
    send(msg)
  else
    g_logger.error('MarketProtocol.sendMarketCreateOffer does not support the current protocol.')
  end
end

function MarketProtocol.sendMarketCancelOffer(timestamp, counter)
  if g_game.getFeature(GamePlayerMarket) then
    local msg = OutputMessage.create()
    msg:addU8(ClientOpcodes.ClientMarketCancel)
    msg:addU32(timestamp)
    msg:addU16(counter)
    send(msg)
  else
    g_logger.error('MarketProtocol.sendMarketCancelOffer does not support the current protocol.')
  end
end

function MarketProtocol.sendMarketAcceptOffer(timestamp, counter, amount)
  if g_game.getFeature(GamePlayerMarket) then
    local msg = OutputMessage.create()
    msg:addU8(ClientOpcodes.ClientMarketAccept)
    msg:addU32(timestamp)
    msg:addU16(counter)
    msg:addU16(amount)
    send(msg)
  else
    g_logger.error('MarketProtocol.sendMarketAcceptOffer does not support the current protocol.')
  end
end
