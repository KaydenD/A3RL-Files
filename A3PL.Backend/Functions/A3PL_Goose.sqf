['A3PL_Goose_Platform', {

    private ["_veh","_overwater","_canDamage"];
    _veh = param [0,objNull];

    while {local _veh} do
    {
        _overWater = !(position _veh isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []);
        _canDamage = _veh getVariable ["canDamage",true];
        if (_overWater && _canDamage) then
        {
            _veh allowDamage false;
            _veh setVariable ["canDamage",false,false];
        };

        if (!_overWater && !_canDamage) then
        {
            _veh allowDamage true;
            _veh setVariable ["canDamage",nil,false];
        };
    } ;
}, false] call Server_Setup_Compile;
