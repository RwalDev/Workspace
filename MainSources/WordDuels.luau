------------------------------
-- WORD TABLE
------------------------------
local Words = {
"ABOUT","ABOVE","ABUSE","ACTOR","ACUTE","ADMIT","ADOPT","ADULT","AFTER","AGAIN","AGENT","AGREE",
"AHEAD","ALARM","ALBUM","ALERT","ALIEN","ALIGN","ALIVE","ALLOW","ALONE","ALONG","ALTER","AMBER",
"AMONG","ANGEL","ANGER","ANGLE","ANGRY","APART","APPLE","APPLY","ARENA","ARGUE","ARISE","ARMOR",
"ARROW","ASIDE","ASSET","AUDIO","AWARE","AWARD","BADGE","BAKER","BASIC","BASIS","BEACH","BEARD",
"BEAST","BEGAN","BEGIN","BEGUN","BEING","BELLY","BELOW","BENCH","BIRTH","BLACK","BLAME","BLANK",
"BLEND","BLESS","BLIND","BLOCK","BLOOD","BOARD","BOOST","BOUND","BRAIN","BRAVE","BREAD","BREAK",
"BRICK","BRIDE","BRIEF","BRING","BROAD","BROKE","BROWN","BUILD","BUILT","BURST","BUYER","CABLE",
"CANDY","CARRY","CATCH","CAUSE","CHAIN","CHAIR","CHART","CHASE","CHEAP","CHEAT","CHECK","CHEER",
"CHEST","CHIEF","CHILD","CHOIR","CHOKE","CHORD","CIVIC","CIVIL","CLAIM","CLASS","CLEAN","CLEAR",
"CLICK","CLIFF","CLIMB","CLOCK","CLOSE","COACH","COAST","COLOR","COMET","COMIC","COUNT","COURT",
"COVER","CRAFT","CRASH","CRAWL","CRAZY","CREAM","CRIME","CRISP","CROSS","CROWD","CROWN","CURSE",
"DAILY","DANCE","DEALT","DEATH","DEBUT","DELAY","DEPTH","DOUBT","DOZEN","DRAFT","DRAIN","DRAMA",
"DRAWN","DREAM","DRESS","DRINK","DRIVE","DROVE","EARLY","EARTH","EAGER","EAGLE","EIGHT","ELDER",
"ELITE","EMPTY","ENACT","ENJOY","ENTER","ENTRY","EQUAL","ERROR","EVENT","EVERY","EXACT","EXIST",
"EXTRA","FAINT","FAITH","FALSE","FANCY","FAULT","FAVOR","FEAST","FENCE","FETCH","FEVER","FIELD",
"FIGHT","FINAL","FIRST","FIXED","FLAME","FLASH","FLEET","FLOOD","FLOOR","FLORA","FLUSH","FOCUS",
"FORCE","FOUND","FRAME","FRESH","FRONT","FRUIT","FULLY","FUNNY","GAMER","GIANT","GLASS","GLOBE",
"GLORY","GRACE","GRADE","GRAIN","GRAND","GRANT","GRASS","GREAT","GREEN","GREET","GRIND","GROUP",
"GUARD","GUESS","GUEST","GUIDE","HAPPY","HARDY","HEART","HEAVY","HONEY","HORSE","HOUSE","HUMAN",
"HUMOR","IDEAL","IMAGE","IMPLY","INDEX","INNER","INPUT","ISSUE","JEWEL","JUICE","KNIFE","KNOWN",
"LABEL","LABOR","LARGE","LASER","LATER","LAUGH","LEARN","LEMON","LEVEL","LIGHT","LIMIT","LOCAL",
"LOGIC","LOOSE","LOVER","LUCKY","LUNCH","MAGIC","MAJOR","MAKER","MARCH","MATCH","MAYBE","MEDAL",
"MEDIA","MERIT","METAL","MIGHT","MINOR","MONEY","MONTH","MORAL","MOTOR","MOUNT","MOUSE","MOUTH",
"MOVIE","MUSIC","NAKED","NERVE","NIGHT","NINJA","NOBLE","NORTH","NOVEL","NURSE","OCEAN","OFFER",
"OLDER","OLIVE","ORDER","OTHER","OWNER","PAINT","PANEL","PAPER","PARTY","PEACE","PHASE","PHONE",
"PHOTO","PIANO","PILOT","PIZZA","PLACE","PLANE","PLANT","PLATE","POINT","POWER","PRESS","PRICE",
"PRIDE","PRIME","PRINT","PRIZE","PROOF","PROUD","PROVE","QUEEN","QUIET","QUICK","RADIO","RAISE",
"RANGE","RAPID","RATIO","REACH","READY","REFER","RELAX","RELAY","RENEW","REPLY","RESET","RIDER",
"RIVER","ROAST","ROBOT","ROUGH","ROUND","ROUTE","ROYAL","RURAL","SAFER","SCALE","SCENE","SCOPE",
"SCORE","SENSE","SEIZE","SERVE","SHAKE","SHAPE","SHARE","SHEEP","SHEET","SHIFT","SHINE","SHOCK",
"SHOOT","SHORT","SHOUT","SHOWN","SIGHT","SIGMA","SIMPLE","SINCE","SKILL","SLEEP","SLICE","SLIDE",
"SMILE","SMOKE","SOLID","SOLVE","SORRY","SOUND","SPACE","SPARE","SPEAK","SPEED","SPELL","SPEND",
"SPICE","SPINE","SPORT","SPOON","STACK","STAGE","STAKE","STAMP","STAND","START","STATE","STEEL",
"STICK","STILL","STOCK","STONE","STORM","STORY","STRAP","STRAW","STUDY","STYLE","SUGAR","SUNNY",
"SUPER","SWEEP","SWEET","SWORD","TABLE","TASTE","TEACH","TEARS","THANK","THEME","THERE","THING",
"THINK","THIRD","THORN","THREE","THROW","TIGHT","TIRED","TITLE","TODAY","TOKEN","TOWER","TRACE",
"TRACK","TRADE","TRAIN","TREAT","TREND","TRIAL","TRICK","TRUCK","TRUST","TRUTH","TWICE","UNDER",
"UNION","UNITY","UNTIL","UPPER","URBAN","USAGE","USUAL","VALID","VALUE","VIDEO","VIRAL","VIRUS",
"VISIT","VISOR","VOICE","VOTER","WATER","WASTE","WATCH","WEARY","WEIGH","WEIRD","WHEEL","WHERE",
"WHILE","WHITE","WHOLE","WIDOW","WOMAN","WORRY","WORLD","WORTH","WOULD","WRATH","WRITE","WRONG",
"YEAST","YIELD","YOUNG","YOUTH","ZEBRA","ZONED","ANGRY","BLEND","CIVIC","COAST","DRIVE","EXCEL",
"GHOST","JUICY","MORPH","NERVE","OPERA","PLUSH","QUIRK","RANCH","SHINY","THUMB","VIVID","YACHT",
"YUMMY","YIKES"
}

------------------------------------
-- RAYFIELD UI
------------------------------------
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
    Name = "Word Duels 🧠 - Word Finder Helper",
    LoadingTitle = "Word Search hehehehehe",
    LoadingSubtitle = "made by rwal"
})
local Tab = Window:CreateTab("Main")

------------------------------------
-- SEARCH MODE 1: FIVE LETTER SLOTS
------------------------------------
local letters = {"", "", "", "", ""}

local function SetLetter(pos, v)
    letters[pos] = string.upper(v or "")
    _G.UpdateDropdown()
end

Tab:CreateInput({Name = "1st Letter", PlaceholderText = "_", Callback = function(v) SetLetter(1,v) end})
Tab:CreateInput({Name = "2nd Letter", PlaceholderText = "_", Callback = function(v) SetLetter(2,v) end})
Tab:CreateInput({Name = "3rd Letter", PlaceholderText = "_", Callback = function(v) SetLetter(3,v) end})
Tab:CreateInput({Name = "4th Letter", PlaceholderText = "_", Callback = function(v) SetLetter(4,v) end})
Tab:CreateInput({Name = "5th Letter", PlaceholderText = "_", Callback = function(v) SetLetter(5,v) end})

------------------------------------
-- SEARCH MODE 2: ANY LETTER / ANYWHERE
------------------------------------
local patternSearch = ""

Tab:CreateInput({
    Name = "ANYWHERE Search (A, AP, A_E, etc)",
    PlaceholderText = "Type letters or patterns",
    Callback = function(text)
        patternSearch = string.upper(text or "")
        _G.UpdateDropdown()
    end
})

------------------------------------
-- DROPDOWN RESULT LIST
------------------------------------
local Dropdown = Tab:CreateDropdown({
    Name = "Matching Words",
    Options = {"Type to search..."},
    Callback = function(word)
        print("Selected:", word)
    end
})

------------------------------------
-- MASTER UPDATE FUNCTION
------------------------------------
_G.UpdateDropdown = function()
    local results = {}

    for _, word in ipairs(Words) do
        local ok = true

        -- Mode 1: 5 letter positional filter
        for i = 1, 5 do
            if letters[i] ~= "" and word:sub(i,i) ~= letters[i] then
                ok = false
                break
            end
        end

        -- Mode 2: pattern search (letters anywhere)
        if ok and patternSearch ~= "" then
            local pattern = patternSearch:gsub("_", "."):gsub("%?", ".")
            if not word:match(pattern) then
                ok = false
            end
        end

        if ok then
            table.insert(results, word)
        end
    end

    if #results == 0 then
        Dropdown:Refresh({"No matches"}, true)
    else
        Dropdown:Refresh(results, true)
    end
end
