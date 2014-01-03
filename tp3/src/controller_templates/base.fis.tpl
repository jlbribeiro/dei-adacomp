[System]
Name='{CONTROLLER_NAME}'
Type='mamdani'
Version=2.0
NumInputs=2
NumOutputs=1
NumRules={N_RULES}
AndMethod='{AND_METHOD}'
OrMethod='{OR_METHOD}'
ImpMethod='{IMP_METHOD}'
AggMethod='{AGG_METHOD}'
DefuzzMethod='{DEFUZZ_METHOD}'

[Input1]
Name='ek'
Range=[-1 1]
{FUNCTIONS}

[Input2]
Name='delta_ek'
Range=[-1 1]
{FUNCTIONS}

[Output1]
Name='delta_uk'
Range=[-1 1]
{FUNCTIONS}

[Rules]
{RULES}