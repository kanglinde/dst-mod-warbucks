GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

PrefabFiles = {
    "blunderbuss",
    "pithhat",
    "warbucks",
}

Assets = {
    Asset("ANIM", "anim/player_actions_speargun.zip" ),
    Asset("ANIM", "anim/player_mount_actions_speargun.zip"),

    Asset("SOUNDPACKAGE", "sound/dontstarve_DLC003.fev"),
    Asset("SOUND", "sound/DLC003_sfx.fsb"),

    Asset("IMAGE", "bigportraits/warbucks.tex"),
    Asset("ATLAS", "bigportraits/warbucks.xml"),
    Asset("IMAGE", "bigportraits/warbucks_none.tex"),
    Asset("ATLAS", "bigportraits/warbucks_none.xml"),

    Asset("ATLAS", "images/names_warbucks.xml"),
    Asset("IMAGE", "images/names_warbucks.tex"),

    Asset("ATLAS", "images/avatars/avatar_warbucks.xml"),
    Asset("IMAGE", "images/avatars/avatar_warbucks.tex"),
    Asset("ATLAS", "images/avatars/avatar_ghost_warbucks.xml"),
    Asset("IMAGE", "images/avatars/avatar_ghost_warbucks.tex"),
    Asset("ATLAS", "images/avatars/self_inspect_warbucks.xml"),
    Asset("IMAGE", "images/avatars/self_inspect_warbucks.tex"),

    Asset("ATLAS", "images/map_icons/warbucks.xml"),
    Asset("IMAGE", "images/map_icons/warbucks.tex"),

    Asset("ATLAS", "images/saveslot_portraits/warbucks.xml"),
    Asset("IMAGE", "images/saveslot_portraits/warbucks.tex"),
}

modimport("scripts/AddStrings")
modimport("scripts/AddStates")
modimport("scripts/AddPostInit")

TUNING.WARBUCKS_HEALTH = 150
TUNING.WARBUCKS_HUNGER = 120
TUNING.WARBUCKS_SANITY = 200
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.WARBUCKS = {"pithhat", "blunderbuss", "gunpowder", "gunpowder", "gunpowder"}

AddMinimapAtlas("images/map_icons/warbucks.xml")

local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle",
        scale = 0.75,
        offset = {0, -25}
    },
}
AddModCharacter("warbucks", "MALE", skin_modes)

AddRecipe2("blunderbuss", 
    {Ingredient("boards", 2), Ingredient("goldnugget", 2), Ingredient("gears", 1)},
    TECH.NONE,
    {builder_tag = "warbucks", atlas = "images/inventoryimages/blunderbuss.xml", image = "blunderbuss.tex"},
    {"CHARACTER"}
)

AddRecipe2("pithhat", 
    {Ingredient("silk", 3), Ingredient("twigs", 2), Ingredient("cutgrass", 6)},
    TECH.NONE,
    {builder_tag = "warbucks", atlas = "images/inventoryimages/pithhat.xml", image = "pithhat.tex"},
    {"CHARACTER"}
)