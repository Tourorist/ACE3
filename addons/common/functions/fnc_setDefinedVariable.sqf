/*
 * Author: Glowbal
 * Setvariable value
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: variableName <STRING>
 * 2: value <ANY>
 *
 * Return Value:
 * None
 *
 * Public: Yes
 */
#include "script_component.hpp"

params ["_unit", "_variable", "_value", "_global"];

if (isNil "_global") then {
    private "_definedVariable";
    _definedVariable = [_variable] call FUNC(getDefinedVariableInfo);

    _definedVariable params ["", "",  ["_global", false]];
};

if (!isNil "_value") exitwith {
    _unit setVariable [_variable, _value, _global];
};

_unit setVariable [_variable, nil, _global];
