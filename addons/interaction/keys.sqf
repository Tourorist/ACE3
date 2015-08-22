// Add keybinds
["ACE3 Common", QGVAR(openDoor), localize LSTRING(OpenDoor),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, []] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if (GVAR(isOpeningDoor) || {[2] call FUNC(getDoor) select 1 == ''}) exitWith {false};

    // Statement
    call EFUNC(interaction,openDoor);
    true
},
{
    //Probably don't want any condidtions here, so variable never gets locked down
    // Statement
    GVAR(isOpeningDoor) = false;
    true
},
[57, [false, true, false]], false] call cba_fnc_addKeybind; //Key CTRL+Space


["ACE3 Common", QGVAR(tapShoulder), localize LSTRING(TapShoulder),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, []] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if !([ACE_player, cursorTarget] call FUNC(canTapShoulder)) exitWith {false};

    // Statement
    [ACE_player, cursorTarget, 0] call FUNC(tapShoulder);
    true
},
{false},
[20, [true, false, false]], false] call cba_fnc_addKeybind;

["ACE3 Common", QGVAR(modifierKey), localize LSTRING(ModifierKey),
{
    // Conditions: canInteract
    //if !([ACE_player, objNull, ["isNotDragging"]] call EFUNC(common,canInteractWith)) exitWith {false};   // not needed

    // Statement
    ACE_Modifier = 1;
    // Return false so it doesn't block other actions
    false
},
{
    //Probably don't want any condidtions here, so variable never gets locked down
    ACE_Modifier = 0;
    false;
},
[29, [false, false, false]], false] call cba_fnc_addKeybind;

#include "\a3\editor_f\Data\Scripts\dikCodes.h"

{
    _x params ["_currentName","_Key"];

    _code = if (_currentName select [0,1] == "BI") then {
        (compile format [QUOTE(ACE_player playActionNow '%1'), _currentName])
    } else {
        (compile format [QUOTE('ace_interaction_%1' call FUNC(playSignal)), _currentName])
    };

    [
        "ACE3 Gestures",
        _currentName,
        format ["%1 %2", localize format[LSTRING(%1), _currentName],localize LSTRING(FREELOOK)],
        _code,
        {},
        [_Key,  if (_Key == 0) then {[false, false, false]} else { [false, true, false] }],
        false
    ] call cba_fnc_addKeybind;

    if (56 in (actionKeys "LookAround")) then {
        [
            "ACE3 Gestures",
            _currentName + "ALT",
            localize format[LSTRING(%1), _currentName],
            _code,
            {},
            [_Key, if (_Key == 0) then {[false, false, false]} else { [false, true, true] }],
            false
        ] call cba_fnc_addKeybind;
    };

    true
} count [
    ["stop", DIK_2],
    ["cover", DIK_3],
    ["forward", DIK_4],
    ["regroup", DIK_5],
    ["engage", DIK_6],
    ["point", DIK_7],
    ["hold", DIK_8],
    ["warning", DIK_9],
    ["BIgestureGo",0],
    ["BIgestureAdvance", 0],
    ["BIgestureFollow", 0],
    ["BIgestureUp", 0],
    ["BIgestureFreeze", 0],
    ["BIgestureCeaseFire", 0]
];
