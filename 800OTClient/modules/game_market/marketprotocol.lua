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
  local items = {[0]={id=1781,category=19,name="a small stone"},[1]={id=2853,category=4,name="a bag"},[2]={id=2854,category=4,name="a backpack"},[3]={id=2857,category=4,name="a bag"},[4]={id=2858,category=4,name="a bag"},[5]={id=2859,category=4,name="a bag"},[6]={id=2860,category=4,name="a bag"},[7]={id=2861,category=4,name="a bag"},[8]={id=2862,category=4,name="a bag"},[9]={id=2863,category=4,name="a bag"},[10]={id=2864,category=4,name="a bag"},[11]={id=2865,category=4,name="a backpack"},[12]={id=2866,category=4,name="a backpack"},[13]={id=2867,category=4,name="a backpack"},[14]={id=2868,category=4,name="a backpack"},[15]={id=2869,category=4,name="a backpack"},[16]={id=2870,category=4,name="a backpack"},[17]={id=2871,category=4,name="a backpack"},[18]={id=2872,category=4,name="a backpack"},[19]={id=2992,category=19,name="a snowball"},[20]={id=3004,category=11,name="a wedding ring"},[21]={id=3006,category=11,name="a ring of the sky"},[22]={id=3007,category=11,name="a crystal ring"},[23]={id=3008,category=2,name="a crystal necklace"},[24]={id=3009,category=2,name="a bronze necklace"},[25]={id=3011,category=7,name="a crown"},[26]={id=3012,category=2,name="a wolf tooth chain"},[27]={id=3013,category=2,name="a golden amulet"},[28]={id=3014,category=2,name="a star amulet"},[29]={id=3015,category=2,name="a silver necklace"},[30]={id=3016,category=2,name="a ruby necklace"},[31]={id=3018,category=2,name="a scarab amulet"},[32]={id=3019,category=2,name="a demonbone amulet"},[33]={id=3021,category=2,name="a saphire amulet"},[34]={id=3022,category=7,name="an ancient tiara"},[35]={id=3025,category=2,name="an ancient amulet"},[36]={id=3045,category=2,name="a strange talisman"},[37]={id=3048,category=11,name="a might ring"},[38]={id=3049,category=11,name="a stealth ring"},[39]={id=3050,category=11,name="a power ring"},[40]={id=3051,category=11,name="an energy ring"},[41]={id=3052,category=11,name="a life ring"},[42]={id=3053,category=11,name="a time ring"},[43]={id=3054,category=2,name="a silver amulet"},[44]={id=3055,category=2,name="a platinum amulet"},[45]={id=3056,category=2,name="a bronze amulet"},[46]={id=3057,category=2,name="an amulet of loss"},[47]={id=3063,category=11,name="a gold ring"},[48]={id=3079,category=3,name="boots of haste"},[49]={id=3080,category=2,name="a broken amulet"},[50]={id=3081,category=2,name="a stone skin amulet"},[51]={id=3082,category=2,name="an elven amulet"},[52]={id=3083,category=2,name="a garlic necklace"},[53]={id=3084,category=2,name="a protection amulet"},[54]={id=3085,category=2,name="a dragon necklace"},[55]={id=3091,category=11,name="a sword ring"},[56]={id=3092,category=11,name="an axe ring"},[57]={id=3093,category=11,name="a club ring"},[58]={id=3097,category=11,name="a dwarven ring"},[59]={id=3098,category=11,name="a ring of healing"},[60]={id=3102,category=2,name="a paw amulet"},[61]={id=3208,category=18,name="a giant smithhammer"},[62]={id=3210,category=7,name="a hat of the mad"},[63]={id=3217,category=4,name="a letterbag"},[64]={id=3226,category=7,name="a damaged helmet"},[65]={id=3229,category=7,name="a helmet of the ancients"},[66]={id=3244,category=4,name="an old and used backpack"},[67]={id=3245,category=11,name="a ring of wishes"},[68]={id=3246,category=3,name="boots of waterwalking"},[69]={id=3253,category=4,name="a backpack of holding"},[70]={id=3264,category=20,name="a sword"},[71]={id=3265,category=20,name="a two handed sword"},[72]={id=3266,category=17,name="a battle axe"},[73]={id=3267,category=20,name="a dagger"},[74]={id=3268,category=17,name="a hand axe"},[75]={id=3269,category=17,name="a halberd"},[76]={id=3270,category=18,name="a club"},[77]={id=3271,category=20,name="a spike sword"},[78]={id=3272,category=20,name="a rapier"},[79]={id=3273,category=20,name="a sabre"},[80]={id=3274,category=17,name="an axe"},[81]={id=3275,category=17,name="a double axe"},[82]={id=3276,category=17,name="a hatchet"},[83]={id=3277,category=19,name="a spear"},[84]={id=3278,category=20,name="a magic longsword"},[85]={id=3279,category=18,name="a war hammer"},[86]={id=3280,category=20,name="a fire sword"},[87]={id=3281,category=20,name="a giant sword"},[88]={id=3282,category=18,name="a morning star"},[89]={id=3283,category=20,name="a carlin sword"},[90]={id=3284,category=20,name="an ice rapier"},[91]={id=3285,category=20,name="a longsword"},[92]={id=3286,category=18,name="a mace"},[93]={id=3287,category=19,name="a throwing star"},[94]={id=3288,category=20,name="a magic sword"},[95]={id=3289,category=18,name="a staff"},[96]={id=3290,category=20,name="a silver dagger"},[97]={id=3291,category=20,name="a knife"},[98]={id=3292,category=20,name="a combat knife"},[99]={id=3293,category=17,name="a sickle"},[100]={id=3294,category=20,name="a short sword"},[101]={id=3295,category=20,name="a bright sword"},[102]={id=3296,category=20,name="a warlord sword"},[103]={id=3297,category=20,name="a serpent sword"},[104]={id=3298,category=19,name="a throwing knife"},[105]={id=3299,category=20,name="a poison dagger"},[106]={id=3300,category=20,name="a katana"},[107]={id=3301,category=20,name="a broadsword"},[108]={id=3302,category=17,name="a dragon lance"},[109]={id=3303,category=17,name="a great axe"},[110]={id=3304,category=18,name="a crowbar"},[111]={id=3305,category=18,name="a battle hammer"},[112]={id=3306,category=17,name="a golden sickle"},[113]={id=3307,category=20,name="a scimitar"},[114]={id=3308,category=20,name="a machete"},[115]={id=3309,category=18,name="a thunder hammer"},[116]={id=3310,category=18,name="an iron hammer"},[117]={id=3311,category=18,name="a clerical mace"},[118]={id=3312,category=18,name="a silver mace"},[119]={id=3313,category=17,name="an obsidian lance"},[120]={id=3314,category=17,name="a naginata"},[121]={id=3315,category=17,name="a guardian halberd"},[122]={id=3316,category=17,name="an orcish axe"},[123]={id=3317,category=17,name="a barbarian axe"},[124]={id=3318,category=17,name="a knight axe"},[125]={id=3319,category=17,name="a stonecutter axe"},[126]={id=3320,category=17,name="a fire axe"},[127]={id=3322,category=18,name="a dragon hammer"},[128]={id=3323,category=17,name="a dwarven axe"},[129]={id=3324,category=18,name="a skull staff"},[130]={id=3325,category=18,name="a light mace"},[131]={id=3326,category=20,name="a foil"},[132]={id=3327,category=18,name="a daramanian mace"},[133]={id=3328,category=17,name="a daramanian waraxe"},[134]={id=3329,category=17,name="a daramanian axe"},[135]={id=3330,category=20,name="a heavy machete"},[136]={id=3331,category=17,name="a ravager's axe"},[137]={id=3332,category=18,name="a hammer of wrath"},[138]={id=3333,category=18,name="a crystal mace"},[139]={id=3334,category=20,name="a pharaoh sword"},[140]={id=3335,category=17,name="a twin axe"},[141]={id=3336,category=18,name="a studded club"},[142]={id=3337,category=18,name="a bone club"},[143]={id=3338,category=20,name="a bone sword"},[144]={id=3339,category=20,name="a djinn blade"},[145]={id=3340,category=18,name="a heavy mace"},[146]={id=3341,category=18,name="an arcane staff"},[147]={id=3342,category=17,name="a war axe"},[148]={id=3343,category=18,name="a lich staff"},[149]={id=3344,category=17,name="a beastslayer axe"},[150]={id=3345,category=20,name="a templar scytheblade"},[151]={id=3346,category=17,name="a ripper lance"},[152]={id=3347,category=17,name="a hunting spear"},[153]={id=3348,category=18,name="a banana staff"},[154]={id=3349,category=19,name="a crossbow"},[155]={id=3350,category=19,name="a bow"},[156]={id=3351,category=7,name="a steel helmet"},[157]={id=3352,category=7,name="a chain helmet"},[158]={id=3353,category=7,name="an iron helmet"},[159]={id=3354,category=7,name="a brass helmet"},[160]={id=3355,category=7,name="a leather helmet"},[161]={id=3356,category=7,name="a devil helmet"},[162]={id=3357,category=1,name="a plate armor"},[163]={id=3358,category=1,name="a chain armor"},[164]={id=3359,category=1,name="a brass armor"},[165]={id=3360,category=1,name="a golden armor"},[166]={id=3361,category=1,name="a leather armor"},[167]={id=3362,category=8,name="studded legs"},[168]={id=3363,category=8,name="dragon scale legs"},[169]={id=3364,category=8,name="golden legs"},[170]={id=3365,category=7,name="a golden helmet"},[171]={id=3366,category=1,name="a magic plate armor"},[172]={id=3367,category=7,name="a viking helmet"},[173]={id=3368,category=7,name="a winged helmet"},[174]={id=3369,category=7,name="a warrior helmet"},[175]={id=3370,category=1,name="a knight armor"},[176]={id=3371,category=8,name="knight legs"},[177]={id=3372,category=8,name="brass legs"},[178]={id=3373,category=7,name="a strange helmet"},[179]={id=3374,category=7,name="a legion helmet"},[180]={id=3375,category=7,name="a soldier helmet"},[181]={id=3376,category=7,name="a studded helmet"},[182]={id=3377,category=1,name="a scale armor"},[183]={id=3378,category=1,name="a studded armor"},[184]={id=3379,category=1,name="a doublet"},[185]={id=3380,category=1,name="a noble armor"},[186]={id=3381,category=1,name="a crown armor"},[187]={id=3382,category=8,name="crown legs"},[188]={id=3383,category=1,name="a dark armor"},[189]={id=3384,category=7,name="a dark helmet"},[190]={id=3385,category=7,name="a crown helmet"},[191]={id=3386,category=1,name="a dragon scale mail"},[192]={id=3387,category=7,name="a demon helmet"},[193]={id=3388,category=1,name="a demon armor"},[194]={id=3389,category=8,name="demon legs"},[195]={id=3390,category=7,name="a horned helmet"},[196]={id=3391,category=7,name="a crusader helmet"},[197]={id=3392,category=7,name="a royal helmet"},[198]={id=3393,category=7,name="an amazon helmet"},[199]={id=3394,category=1,name="an amazon armor"},[200]={id=3395,category=7,name="a ceremonial mask"},[201]={id=3396,category=7,name="a dwarfen helmet"},[202]={id=3397,category=1,name="a dwarven armor"},[203]={id=3398,category=8,name="dwarfen legs"},[204]={id=3399,category=1,name="an elven mail"},[205]={id=3400,category=7,name="a dragon scale helmet"},[206]={id=3401,category=8,name="elven legs"},[207]={id=3402,category=1,name="a native armor"},[208]={id=3403,category=7,name="a tribal mask"},[209]={id=3404,category=1,name="a leopard armor"},[210]={id=3405,category=7,name="a horseman helmet"},[211]={id=3406,category=7,name="a feather headdress"},[212]={id=3407,category=7,name="a charmer's tiara"},[213]={id=3408,category=7,name="a beholder helmet"},[214]={id=3409,category=13,name="a steel shield"},[215]={id=3410,category=13,name="a plate shield"},[216]={id=3411,category=13,name="a brass shield"},[217]={id=3412,category=13,name="a wooden shield"},[218]={id=3413,category=13,name="a battle shield"},[219]={id=3414,category=13,name="a mastermind shield"},[220]={id=3415,category=13,name="a guardian shield"},[221]={id=3416,category=13,name="a dragon shield"},[222]={id=3417,category=13,name="a shield of honour"},[223]={id=3418,category=13,name="a beholder shield"},[224]={id=3419,category=13,name="a crown shield"},[225]={id=3420,category=13,name="a demon shield"},[226]={id=3421,category=13,name="a dark shield"},[227]={id=3422,category=13,name="a great shield"},[228]={id=3423,category=13,name="a blessed shield"},[229]={id=3424,category=13,name="an ornamented shield"},[230]={id=3425,category=13,name="a dwarven shield"},[231]={id=3426,category=13,name="a studded shield"},[232]={id=3427,category=13,name="a rose shield"},[233]={id=3428,category=13,name="a tower shield"},[234]={id=3429,category=13,name="a black shield"},[235]={id=3430,category=13,name="a copper shield"},[236]={id=3431,category=13,name="a viking shield"},[237]={id=3432,category=13,name="an ancient shield"},[238]={id=3433,category=13,name="a griffin shield"},[239]={id=3434,category=13,name="a vampire shield"},[240]={id=3435,category=13,name="a castle shield"},[241]={id=3436,category=13,name="a medusa shield"},[242]={id=3437,category=13,name="an amazon shield"},[243]={id=3438,category=13,name="an eagle shield"},[244]={id=3439,category=13,name="a phoenix shield"},[245]={id=3440,category=13,name="a scarab shield"},[246]={id=3441,category=13,name="a bone shield"},[247]={id=3442,category=13,name="a tempest shield"},[248]={id=3443,category=13,name="a tusk shield"},[249]={id=3444,category=13,name="a sentinel shield"},[250]={id=3445,category=13,name="a salamander shield"},[251]={id=3446,category=16,name="a bolt"},[252]={id=3447,category=16,name="an arrow"},[253]={id=3448,category=16,name="a poison arrow"},[254]={id=3449,category=16,name="a burst arrow"},[255]={id=3450,category=16,name="a power bolt"},[256]={id=3453,category=18,name="a scythe"},[257]={id=3550,category=3,name="patched boots"},[258]={id=3551,category=3,name="sandals"},[259]={id=3552,category=3,name="leather boots"},[260]={id=3553,category=3,name="bunnyslippers"},[261]={id=3554,category=3,name="steel boots"},[262]={id=3555,category=3,name="golden boots"},[263]={id=3556,category=3,name="crocodile boots"},[264]={id=3557,category=8,name="plate legs"},[265]={id=3558,category=8,name="chain legs"},[266]={id=3559,category=8,name="leather legs"},[267]={id=3560,category=8,name="a bast skirt"},[268]={id=3561,category=1,name="a jacket"},[269]={id=3562,category=1,name="a coat"},[270]={id=3563,category=1,name="a green tunic"},[271]={id=3564,category=1,name="a red tunic"},[272]={id=3565,category=1,name="a cape"},[273]={id=3566,category=1,name="a red robe"},[274]={id=3567,category=1,name="a blue robe"},[275]={id=3568,category=1,name="a simple dress"},[276]={id=3569,category=1,name="a white dress"},[277]={id=3570,category=1,name="a ball gown"},[278]={id=3571,category=1,name="a rangers cloak"},[279]={id=3572,category=2,name="a scarf"},[280]={id=3573,category=7,name="a magician hat"},[281]={id=3574,category=7,name="a mystic turban"},[282]={id=3575,category=7,name="a wood cape"},[283]={id=3576,category=7,name="a post officers hat"},[284]={id=4836,category=1,name="a spectral dress"},[285]={id=5460,category=7,name="a helmet of the deep"},[286]={id=5461,category=3,name="pirate boots"},[287]={id=5741,category=7,name="a skull helmet"},[288]={id=5803,category=19,name="an arbalest"},[289]={id=5903,category=7,name="Ferumbras' hat"},[290]={id=5917,category=7,name="a bandana"},[291]={id=5918,category=8,name="pirate knee breeches"},[292]={id=5926,category=4,name="a pirate backpack"},[293]={id=5927,category=4,name="a pirate bag"},[294]={id=5940,category=2,name="Ceiron's wolf tooth chain"},[295]={id=5949,category=4,name="a beach backpack"},[296]={id=5950,category=4,name="a beach bag"},[297]={id=6093,category=11,name="a crystal ring"},[298]={id=6095,category=1,name="a pirate shirt"},[299]={id=6096,category=7,name="a pirate hat"},[300]={id=6101,category=20,name="Ron the Ripper's sabre"},[301]={id=6131,category=13,name="a tortoise shield"},[302]={id=6299,category=11,name="a death ring"},[303]={id=6390,category=13,name="a nightmare shield"},[304]={id=6432,category=13,name="a necromancer shield"},[305]={id=6527,category=20,name="the avenger"},[306]={id=6528,category=16,name="an infernal bolt"},[307]={id=6529,category=3,name="pair of soft boots"},[308]={id=6531,category=7,name="a santa hat"},[309]={id=6553,category=17,name="a ruthless axe"},[310]={id=6578,category=7,name="a party hat"},[311]={id=7342,category=4,name="a fur backpack"},[312]={id=7343,category=4,name="a fur bag"},[313]={id=7363,category=16,name="a piercing bolt"},[314]={id=7364,category=16,name="a sniper arrow"},[315]={id=7365,category=16,name="an onyx arrow"},[316]={id=7366,category=19,name="a viper star"},[317]={id=7367,category=19,name="an enchanted spear"},[318]={id=7368,category=19,name="an assassin star"},[319]={id=7378,category=19,name="a royal spear"},[320]={id=7379,category=18,name="brutetamer's staff"},[321]={id=7380,category=17,name="a headchopper"},[322]={id=7381,category=18,name="a mammoth whopper"},[323]={id=7382,category=20,name="a demonrage sword"},[324]={id=7383,category=20,name="a relic sword"},[325]={id=7384,category=20,name="a mystic blade"},[326]={id=7385,category=20,name="a crimson sword"},[327]={id=7386,category=20,name="a mercenary sword"},[328]={id=7387,category=18,name="a diamond sceptre"},[329]={id=7388,category=17,name="a vile axe"},[330]={id=7389,category=17,name="a heroic axe"},[331]={id=7390,category=20,name="the justice seeker"},[332]={id=7391,category=20,name="a thaian sword"},[333]={id=7392,category=18,name="an orcish maul"},[334]={id=7402,category=20,name="a dragon slayer"},[335]={id=7403,category=20,name="a berserker"},[336]={id=7404,category=20,name="an assassin dagger"},[337]={id=7405,category=20,name="a havoc blade"},[338]={id=7406,category=20,name="a blacksteel sword"},[339]={id=7407,category=20,name="a haunted blade"},[340]={id=7408,category=20,name="a wyvern fang"},[341]={id=7409,category=18,name="a northern star"},[342]={id=7410,category=18,name="a queen's sceptre"},[343]={id=7411,category=17,name="an ornamented axe"},[344]={id=7412,category=17,name="a butcher's axe"},[345]={id=7413,category=17,name="a titan axe"},[346]={id=7414,category=18,name="a abyss hammer"},[347]={id=7415,category=18,name="a cranial basher"},[348]={id=7416,category=20,name="a bloody edge"},[349]={id=7417,category=20,name="a runed sword"},[350]={id=7418,category=20,name="a nightmare blade"},[351]={id=7419,category=17,name="a dreaded cleaver"},[352]={id=7420,category=17,name="a reaper's axe"},[353]={id=7421,category=18,name="an onyx flail"},[354]={id=7422,category=18,name="a jade hammer"},[355]={id=7423,category=18,name="a skullcrusher"},[356]={id=7424,category=18,name="a lunar staff"},[357]={id=7425,category=18,name="a taurus mace"},[358]={id=7426,category=18,name="an amber staff"},[359]={id=7427,category=18,name="a chaos mace"},[360]={id=7428,category=18,name="a bonebreaker"},[361]={id=7429,category=18,name="a blessed sceptre"},[362]={id=7430,category=18,name="a dragonbone staff"},[363]={id=7431,category=18,name="a demonbone"},[364]={id=7432,category=18,name="a furry club"},[365]={id=7433,category=17,name="a ravenwing"},[366]={id=7434,category=17,name="a royal axe"},[367]={id=7435,category=17,name="an impaler"},[368]={id=7436,category=17,name="an angelic axe"},[369]={id=7437,category=18,name="a sapphire hammer"},[370]={id=7438,category=19,name="an elvish bow"},[371]={id=7449,category=20,name="a crystal sword"},[372]={id=7450,category=18,name="a hammer of prophecy"},[373]={id=7451,category=18,name="a shadow sceptre"},[374]={id=7452,category=18,name="a spiked squelcher"},[375]={id=7453,category=17,name="an executioner"},[376]={id=7454,category=17,name="a glorious axe"},[377]={id=7455,category=17,name="a mythril axe"},[378]={id=7456,category=17,name="a noble axe"},[379]={id=7457,category=3,name="fur boots"},[380]={id=7458,category=7,name="a fur cap"},[381]={id=7459,category=7,name="a pair of earmuffs"},[382]={id=7460,category=13,name="a norse shield"},[383]={id=7461,category=7,name="a krimhorn helmet"},[384]={id=7462,category=7,name="a ragnir helmet"},[385]={id=7463,category=1,name="a mammoth fur cape"},[386]={id=7464,category=8,name="mammoth fur shorts"},[387]={id=8023,category=19,name="a royal crossbow"},[388]={id=3602,category=31,name="a brown bread"},[389]={id=3114,category=31,name="a skull"},[390]={id=3030,category=31,name="a small ruby"},[391]={id=2920,category=31,name="a torch"},[392]={id=3046,category=31,name="a magic light wand"},[393]={id=3042,category=31,name="a scarab coin"},[394]={id=3033,category=31,name="a small amethyst"},[395]={id=3032,category=31,name="a small emerald"},[396]={id=3116,category=31,name="a big bone"},[397]={id=3027,category=31,name="a black pearl"},[398]={id=3041,category=31,name="a blue gem"},[399]={id=3076,category=31,name="a crystal ball"},[400]={id=2903,category=31,name="a golden mug"},[401]={id=3038,category=31,name="a green gem"},[402]={id=3061,category=31,name="a life crystal"},[403]={id=3062,category=31,name="a mind stone"},[404]={id=3070,category=21,name="a moonlight rod"},[405]={id=3060,category=31,name="an orb"},[406]={id=2848,category=31,name="a purple tome"},[407]={id=3028,category=31,name="a small diamond"},[408]={id=3029,category=31,name="a small sapphire"},[409]={id=3066,category=21,name="a snakebite rod"},[410]={id=3058,category=31,name="a strange symbol"},[411]={id=3034,category=31,name="a talon"},[412]={id=2993,category=31,name="a teddy bear"},[413]={id=3069,category=21,name="a volcanic rod"},[414]={id=3002,category=31,name="a voodoo doll"},[415]={id=3072,category=21,name="a wand of plague"},[416]={id=3026,category=31,name="a white pearl"},[417]={id=3577,category=31,name="meat"},[418]={id=3492,category=31,name="a worm"},[419]={id=2917,category=31,name="a candlestick"},[420]={id=3122,category=31,name="a dirty cape"},[421]={id=2949,category=31,name="a lyre"},[422]={id=3463,category=31,name="a mirror"},[423]={id=3017,category=31,name="a silver brooch"},[424]={id=3059,category=31,name="a spellbook"},[425]={id=5894,category=31,name="a bat wing"},[426]={id=3582,category=31,name="ham"},[427]={id=5896,category=31,name="a bear paw"},[428]={id=5902,category=31,name="a honeycomb"},[429]={id=2893,category=31,name="an amphora"},[430]={id=3456,category=31,name="a pick"},[431]={id=5893,category=31,name="a perfect behemoth fang"},[432]={id=5930,category=31,name="a behemoth claw"},[433]={id=3065,category=21,name="a quagmire rod"},[434]={id=5898,category=31,name="a beholder's eye"},[435]={id=3003,category=31,name="a rope"},[436]={id=3659,category=31,name="a blue rose"},[437]={id=2844,category=31,name="a book"},[438]={id=3595,category=31,name="a carrot"},[439]={id=2933,category=31,name="a small oil lamp"},[440]={id=5912,category=31,name="a blue piece of cloth"},[441]={id=3115,category=31,name="a bone"},[442]={id=3732,category=31,name="a green mushroom"},[443]={id=5925,category=31,name="a hardened bone"},[444]={id=3590,category=31,name="a cherry"},[445]={id=3728,category=31,name="a dark mushroom"},[446]={id=3661,category=31,name="a grave flower"},[447]={id=3740,category=31,name="a shadow herb"},[448]={id=3738,category=31,name="a sling herb"},[449]={id=3607,category=31,name="cheese"},[450]={id=3598,category=31,name="a cookie"},[451]={id=3606,category=31,name="an egg"},[452]={id=5890,category=31,name="a chicken feather"},[453]={id=3578,category=31,name="a fish"},[454]={id=3112,category=31,name="rotten meat"},[455]={id=3077,category=31,name="an ankh"},[456]={id=3600,category=31,name="a bread"},[457]={id=2885,category=31,name="a brown flask"},[458]={id=2914,category=31,name="a lamp"},[459]={id=2815,category=31,name="a scroll"},[460]={id=2842,category=31,name="a book"},[461]={id=3583,category=31,name="dragon ham"},[462]={id=5919,category=31,name="a dragon claw"},[463]={id=5948,category=31,name="a red dragon leather"},[464]={id=3731,category=31,name="a fire mushroom"},[465]={id=5954,category=31,name="a demon horn"},[466]={id=5776,category=31,name="a Sabrehaven talon"},[467]={id=3078,category=31,name="a mysterious fetish"},[468]={id=3147,category=31,name="a blank rune"},[469]={id=2902,category=31,name="a bowl"},[470]={id=3509,category=31,name="an inkwell"},[471]={id=3593,category=31,name="a melon"},[472]={id=3037,category=31,name="a yellow gem"},[473]={id=5805,category=31,name="a golden goblet"},[474]={id=5922,category=31,name="a holy orchid"},[475]={id=3071,category=21,name="a wand of inferno"},[476]={id=5877,category=31,name="a green dragon leather"},[477]={id=5920,category=31,name="a green dragon scale"},[478]={id=5882,category=31,name="a red dragon scale"},[479]={id=3505,category=31,name="a letter"},[480]={id=3723,category=31,name="a white mushroom"},[481]={id=5880,category=31,name="an iron ore"},[482]={id=3584,category=31,name="a pear"},[483]={id=3457,category=31,name="a shovel"},[484]={id=3471,category=31,name="a cleaver"},[485]={id=2647,category=31,name="a green tapestry"},[486]={id=5910,category=31,name="a green piece of cloth"},[487]={id=3044,category=31,name="an elephant tusk"},[488]={id=3585,category=31,name="a red apple"},[489]={id=5921,category=31,name="a heaven blossom"},[490]={id=3073,category=21,name="a wand of cosmic energy"},[491]={id=3592,category=31,name="grapes"},[492]={id=2901,category=31,name="a waterskin"},[493]={id=3105,category=31,name="a dirty fur"},[494]={id=3736,category=31,name="a star herb"},[495]={id=5786,category=31,name="a wooden whistle"},[496]={id=5944,category=31,name="a soul orb"},[497]={id=3451,category=31,name="a pitchfork"},[498]={id=3075,category=21,name="a wand of dragonbreath"},[499]={id=3130,category=31,name="twigs"},[500]={id=2843,category=31,name="a book"},[501]={id=5909,category=31,name="a white piece of cloth"},[502]={id=5913,category=31,name="a brown piece of cloth"},[503]={id=5879,category=31,name="a spider silk"},[504]={id=3120,category=31,name="a moldy cheese"},[505]={id=3462,category=31,name="a small axe"},[506]={id=2846,category=31,name="a book"},[507]={id=3039,category=31,name="a red gem"},[508]={id=3658,category=31,name="a red rose"},[509]={id=5911,category=31,name="a red piece of cloth"},[510]={id=3483,category=31,name="a fishing rod"},[511]={id=5804,category=31,name="a nose ring"},[512]={id=5878,category=31,name="a minotaur leather"},[513]={id=3586,category=31,name="an orange"},[514]={id=3601,category=31,name="a roll"},[515]={id=5875,category=31,name="sniper gloves"},[516]={id=4839,category=31,name="a hydra egg"},[517]={id=3587,category=31,name="a banana"},[518]={id=5883,category=31,name="an ape fur"},[519]={id=5876,category=31,name="a lizard leather"},[520]={id=5881,category=31,name="a lizard scale"},[521]={id=2659,category=31,name="a blue tapestry"},[522]={id=3588,category=31,name="a blueberry"},[523]={id=3067,category=21,name="a tempest rod"},[524]={id=2948,category=31,name="a wooden flute"},[525]={id=5943,category=31,name="Morgaroth's heart"},[526]={id=5914,category=31,name="a yellow piece of cloth"},[527]={id=5809,category=31,name="a soul stone"},[528]={id=5886,category=31,name="a spool of yarn"},[529]={id=2839,category=31,name="a book"},[530]={id=3597,category=31,name="a corncob"},[531]={id=2875,category=31,name="a bottle"},[532]={id=5808,category=31,name="Orshabaal's brain"},[533]={id=3023,category=31,name="a holy scarab"},[534]={id=3024,category=31,name="a holy falcon"},[535]={id=3068,category=31,name="a crystal wand"},[536]={id=3036,category=31,name="a violet gem"},[537]={id=2950,category=31,name="a lute"},[538]={id=2953,category=31,name="panpipes"},[539]={id=3674,category=31,name="a goat grass"},[540]={id=3739,category=31,name="a powder herb"},[541]={id=3727,category=31,name="a wood mushroom"},[542]={id=4831,category=31,name="an old parchment"},[543]={id=3589,category=31,name="a coconut"},[544]={id=3010,category=31,name="an emerald bangle"},[545]={id=2852,category=31,name="a red tome"},[546]={id=5897,category=31,name="a wolf paw"},[547]={id=2991,category=31,name="a doll"},[548]={id=3454,category=31,name="a broom"},[549]={id=5810,category=31,name="a voodoo doll"},[550]={id=6088,category=31,name="a music sheet"},[551]={id=6089,category=31,name="a music sheet"},[552]={id=6099,category=31,name="Brutus Bloodbeard's hat"},[553]={id=6102,category=31,name="Deadeye Devious' eye patch"},[554]={id=6090,category=31,name="a music sheet"},[555]={id=5668,category=31,name="a mysterious voodoo skull"},[556]={id=2995,category=31,name="a piggy bank"},[557]={id=5096,category=31,name="a mango"},[558]={id=5901,category=31,name="wood"},[559]={id=6100,category=31,name="the Lethal Lissy's shirt"},[560]={id=6087,category=31,name="a music sheet"},[561]={id=3074,category=21,name="a wand of vortex"},[562]={id=5090,category=31,name="a treasure map"},[563]={id=3123,category=31,name="worn leather boots"},[564]={id=6097,category=31,name="a hook"},[565]={id=6098,category=31,name="an eye patch"},[566]={id=6126,category=31,name="a peg leg"},[567]={id=5792,category=31,name="a dice"},[568]={id=5552,category=31,name="a rum flask"},[569]={id=5813,category=31,name="a skull candle"},[570]={id=5710,category=31,name="a light shovel"},[571]={id=2814,category=31,name="a parchment"},[572]={id=5928,category=31,name="an empty goldfish bowl"},[573]={id=5895,category=31,name="a fish fin"},[574]={id=3581,category=31,name="shrimp"},[575]={id=3125,category=31,name="remains of a fish"},[576]={id=3111,category=31,name="a fishbone"},[577]={id=5678,category=31,name="a tortoise egg"},[578]={id=5014,category=31,name="a mandrake"},[579]={id=5899,category=31,name="a turtle shell"},[580]={id=6558,category=31,name="concentrated demonic blood"},[581]={id=5021,category=31,name="an orichalcum pearl"},[582]={id=5799,category=31,name="a golden figurine"},[583]={id=3605,category=31,name="a bunch of wheat"},[584]={id=6536,category=31,name="Countess Sorrow's frozen tear"},[585]={id=3461,category=31,name="a saw"},[586]={id=5479,category=31,name="a cat's paw"},[587]={id=6546,category=31,name="Dracola's eye"},[588]={id=6496,category=31,name="a christmas present bag"},[589]={id=6276,category=31,name="a lump of cake dough"},[590]={id=3599,category=31,name="a candy cane"},[591]={id=2639,category=31,name="a picture"},[592]={id=6500,category=31,name="a gingerbreadman"},[593]={id=4871,category=31,name="an explorer brooch"},[594]={id=6392,category=31,name="a valentine's cake"},[595]={id=6091,category=31,name="a very noble-looking watch"},[596]={id=2394,category=31,name="a blue pillow"},[597]={id=2395,category=31,name="a red pillow"},[598]={id=2396,category=31,name="a green pillow"},[599]={id=2397,category=31,name="a yellow pillow"},[600]={id=2983,category=31,name="a flower bowl"},[601]={id=4828,category=31,name="a flask of cough syrup"},[602]={id=3155,category=12,name="a spell rune"},[603]={id=3124,category=31,name="a burnt scroll"},[604]={id=3481,category=31,name="a closed trap"},[605]={id=3113,category=31,name="broken pottery"},[606]={id=5806,category=31,name="a silver goblet"},[607]={id=6525,category=31,name="a skeleton decoration"},[608]={id=6540,category=31,name="a piece of Massacre's shell"},[609]={id=6537,category=31,name="Mr. Punish's handcuffs"},[610]={id=3110,category=31,name="a piece of iron"},[611]={id=5887,category=31,name="a piece of royal steel"},[612]={id=5889,category=31,name="a piece of draconian steel"},[613]={id=5888,category=31,name="a piece of hell steel"},[614]={id=3103,category=31,name="a cornucopia"},[615]={id=3260,category=31,name="a lyre"},[616]={id=6539,category=31,name="the Handmaiden's protector"},[617]={id=6534,category=31,name="the Imperor's trident"},[618]={id=6535,category=31,name="the Plasmother's remains"},[619]={id=2874,category=31,name="a vial"},[620]={id=2906,category=31,name="a watch"},[621]={id=3579,category=31,name="salmon"},[622]={id=5906,category=31,name="a demon dust"},[623]={id=5891,category=31,name="an enchanted chicken wing"},[624]={id=5885,category=31,name="a flask of warrior's sweat"},[625]={id=3657,category=31,name="a heaven blossom"},[626]={id=5904,category=31,name="a magic sulphur"},[627]={id=5884,category=31,name="a spirit container"},[628]={id=5905,category=31,name="a vampire dust"},[629]={id=2911,category=31,name="a candelabrum"},[630]={id=2834,category=31,name="a document"},[631]={id=2835,category=31,name="a parchment"},[632]={id=2856,category=31,name="a present"},[633]={id=2873,category=31,name="a bucket"},[634]={id=2881,category=31,name="a cup"},[635]={id=2905,category=31,name="a plate"},[636]={id=3179,category=12,name="a spell rune"},[637]={id=3197,category=12,name="a spell rune"},[638]={id=3173,category=12,name="a spell rune"},[639]={id=3195,category=12,name="a spell rune"},[640]={id=3149,category=12,name="a spell rune"},[641]={id=3180,category=12,name="a spell rune"},[642]={id=3203,category=12,name="a spell rune"},[643]={id=3165,category=12,name="a spell rune"},[644]={id=2775,category=31,name="a furniture package"},[645]={id=2776,category=31,name="a furniture package"},[646]={id=2777,category=31,name="a furniture package"},[647]={id=2778,category=31,name="a furniture package"},[648]={id=2779,category=31,name="a furniture package"},[649]={id=4867,category=31,name="a botanist's container"},[650]={id=4863,category=31,name="a butterfly conservation kit"},[651]={id=4852,category=31,name="an ectoplasm container"},[652]={id=6108,category=31,name="an atlas"},[653]={id=5865,category=31,name="a juice squeezer"},[654]={id=3594,category=31,name="a pumpkin"},[655]={id=3591,category=31,name="a strawberry"},[656]={id=2880,category=31,name="a mug"},[657]={id=2876,category=31,name="a vase"},[658]={id=3174,category=12,name="a spell rune"},[659]={id=3172,category=12,name="a spell rune"},[660]={id=3153,category=12,name="a spell rune"},[661]={id=3188,category=12,name="a spell rune"},[662]={id=3152,category=12,name="a spell rune"},[663]={id=3189,category=12,name="a spell rune"},[664]={id=3148,category=12,name="a spell rune"},[665]={id=3198,category=12,name="a spell rune"},[666]={id=3164,category=12,name="a spell rune"},[667]={id=3160,category=12,name="a spell rune"},[668]={id=3177,category=12,name="a spell rune"},[669]={id=3191,category=12,name="a spell rune"},[670]={id=3178,category=12,name="a spell rune"},[671]={id=3192,category=12,name="a spell rune"},[672]={id=3176,category=12,name="a spell rune"},[673]={id=3200,category=12,name="a spell rune"},[674]={id=3190,category=12,name="a spell rune"},[675]={id=3166,category=12,name="a spell rune"},[676]={id=2855,category=31,name="a basket"},[677]={id=2789,category=31,name="a furniture package"},[678]={id=2790,category=31,name="a furniture package"},[679]={id=2791,category=31,name="a furniture package"},[680]={id=2471,category=31,name="a crate"},[681]={id=2472,category=31,name="a chest"},[682]={id=2469,category=31,name="a box"},[683]={id=2793,category=31,name="a furniture package"},[684]={id=2792,category=31,name="a furniture package"},[685]={id=2794,category=31,name="a furniture package"},[686]={id=6114,category=31,name="an armor rack kit"},[687]={id=6115,category=31,name="a weapon rack kit"},[688]={id=6372,category=31,name="a bookcase kit"},[689]={id=3473,category=31,name="a rolling pin"},[690]={id=5938,category=31,name="Ceiron's waterskin"},[691]={id=2882,category=31,name="a jug"},[692]={id=3464,category=31,name="a baking tray"},[693]={id=3465,category=31,name="a pot"},[694]={id=3466,category=31,name="a pan"},[695]={id=3467,category=31,name="a fork"},[696]={id=3468,category=31,name="a spoon"},[697]={id=3469,category=31,name="a knife"},[698]={id=3470,category=31,name="a wooden spoon"},[699]={id=3472,category=31,name="an oven spatula"},[700]={id=5615,category=31,name="a pirate tapestry"},[701]={id=2802,category=31,name="a furniture package"},[702]={id=2803,category=31,name="a furniture package"},[703]={id=2804,category=31,name="a furniture package"},[704]={id=2782,category=31,name="a furniture package"},[705]={id=2783,category=31,name="a furniture package"},[706]={id=2784,category=31,name="a furniture package"},[707]={id=2785,category=31,name="a furniture package"},[708]={id=2981,category=31,name="god flowers"},[709]={id=2811,category=31,name="a furniture package"},[710]={id=2984,category=31,name="a honey flower"},[711]={id=2985,category=31,name="a potted flower"},[712]={id=2386,category=31,name="a small purple pillow"},[713]={id=2387,category=31,name="a small green pillow"},[714]={id=2388,category=31,name="a small red pillow"},[715]={id=2389,category=31,name="a small blue pillow"},[716]={id=2390,category=31,name="a small orange pillow"},[717]={id=2391,category=31,name="a small turquoise pillow"},[718]={id=2392,category=31,name="a small white pillow"},[719]={id=2398,category=31,name="a round blue pillow"},[720]={id=2400,category=31,name="a round purple pillow"},[721]={id=2399,category=31,name="a round red pillow"},[722]={id=2401,category=31,name="a round turquoise pillow"},[723]={id=2393,category=31,name="a heart pillow"},[724]={id=2805,category=31,name="a furniture package"},[725]={id=2806,category=31,name="a furniture package"},[726]={id=6371,category=31,name="an oven kit"},[727]={id=2807,category=31,name="a furniture package"},[728]={id=2808,category=31,name="a furniture package"},[729]={id=2974,category=31,name="a water pipe"},[730]={id=2801,category=31,name="a furniture package"},[731]={id=2799,category=31,name="a furniture package"},[732]={id=2798,category=31,name="a furniture package"},[733]={id=2800,category=31,name="a furniture package"},[734]={id=2797,category=31,name="a furniture package"},[735]={id=2796,category=31,name="a furniture package"},[736]={id=2641,category=31,name="a picture"},[737]={id=2640,category=31,name="a picture"},[738]={id=2632,category=31,name="a wall mirror"},[739]={id=2638,category=31,name="a wall mirror"},[740]={id=2635,category=31,name="a wall mirror"},[741]={id=2644,category=31,name="a purple tapestry"},[742]={id=2650,category=31,name="a yellow tapestry"},[743]={id=2653,category=31,name="an orange tapestry"},[744]={id=2656,category=31,name="a red tapestry"},[745]={id=2667,category=31,name="a white tapestry"},[746]={id=4844,category=31,name="an elven poetry book"},[747]={id=2952,category=31,name="a drum"},[748]={id=2954,category=31,name="a simple fanfare"},[749]={id=5952,category=31,name="a poem scroll"},[750]={id=5467,category=31,name="a fire bug"},[751]={id=2837,category=31,name="a book"},[752]={id=2838,category=31,name="a book"},[753]={id=6386,category=31,name="a greeting card"},[754]={id=6538,category=31,name="a valentine's card"},[755]={id=5088,category=31,name="a furniture package"},[756]={id=5086,category=31,name="a furniture package"},[757]={id=5087,category=31,name="a furniture package"},[758]={id=3596,category=31,name="a tomato"},[759]={id=6106,category=31,name="a bottle of whisper beer"},[760]={id=3724,category=31,name="a red mushroom"},[761]={id=3725,category=31,name="a brown mushroom"},[762]={id=3668,category=31,name="a tulip"},[763]={id=3735,category=31,name="a stone herb"},[764]={id=3737,category=31,name="a fern"},[765]={id=3452,category=31,name="a rake"},[766]={id=3455,category=31,name="a hoe"},[767]={id=2780,category=31,name="a furniture package"},[768]={id=2781,category=31,name="a furniture package"},[769]={id=2809,category=31,name="a furniture package"},[770]={id=2786,category=31,name="a furniture package"},[771]={id=2787,category=31,name="a furniture package"},[772]={id=2788,category=31,name="a furniture package"},[773]={id=2810,category=31,name="a furniture package"},[774]={id=2795,category=31,name="a furniture package"},}
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
