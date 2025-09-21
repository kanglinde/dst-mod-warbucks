local lan = GetModConfigData("lan")

STRINGS.NAMES.PREFAB = ""
STRINGS.RECIPE_DESC.PREFAB = "" 
STRINGS.CHARACTERS.GENERIC.DESCRIBE.PREFAB = "" 

if lan == "cn" then
    STRINGS.NAMES.BLUNDERBUSS = "喇叭前膛枪"
    STRINGS.RECIPE_DESC.BLUNDERBUSS = "声音很大很吵，但能完成任务。"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.BLUNDERBUSS = "很好，这个迟早派的上用场。"
    STRINGS.ACTIONS.LOADBLUNDERBUSS = "装填"

    STRINGS.NAMES.PITHHAT = "软木帽"
    STRINGS.RECIPE_DESC.PITHHAT = "让你的头发轻松透气。"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.PITHHAT = "一顶非常适合去探险的帽子。"

    STRINGS.NAMES.WARBUCKS = "沃巴克斯"
    STRINGS.CHARACTER_NAMES.warbucks = "沃巴克斯"
    STRINGS.CHARACTER_QUOTES.warbucks = "\"我说老伙计！这将是一场值得纪念的游戏！\""
    STRINGS.CHARACTER_TITLES.warbucks = "富裕的探险家"
    STRINGS.CHARACTER_DESCRIPTIONS.warbucks = "*一个探险家\n*热爱他的财富\n*十分挑食"
    STRINGS.CHARACTER_SURVIVABILITY.warbucks = "严峻"
else
    STRINGS.NAMES.BLUNDERBUSS = "Blunderbuss"
    STRINGS.RECIPE_DESC.BLUNDERBUSS = "Loud and messy, but gets the job done."
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.BLUNDERBUSS = "Well, this will come in handy."
    STRINGS.ACTIONS.LOADBLUNDERBUSS = "Load"

    STRINGS.NAMES.PITHHAT = "Pith Hat"
    STRINGS.RECIPE_DESC.PITHHAT = "Keeps your hair easy and breezy."
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.PITHHAT = "A proper adventuring hat."

    STRINGS.NAMES.WARBUCKS = "Warbucks"
    STRINGS.CHARACTER_NAMES.warbucks = "Warbucks"
    STRINGS.CHARACTER_QUOTES.warbucks = "\"I say Ol' chap! This will be a game to remember!\""
    STRINGS.CHARACTER_TITLES.warbucks = "The Affluent Explorer"
    STRINGS.CHARACTER_DESCRIPTIONS.warbucks = "*Is an explorer\n*Loves his fortune\n*Picky eater"
    STRINGS.CHARACTER_SURVIVABILITY.warbucks = "Grim"
end