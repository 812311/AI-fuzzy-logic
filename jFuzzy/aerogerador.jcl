FUNCTION_BLOCK aerogerador

VAR_INPUT
	umidade	: REAL;
	temperatura : REAL;
END_VAR

VAR_OUTPUT
	potencia : REAL;
END_VAR

FUZZIFY temperatura
		TERM fria := (12,1)(20,1)(25,0);
		TERM normal := (20,0)(23,1)(27,1)(35,0);
		TERM quente := (25,0)(33,1)(60,1);
END_FUZZIFY

FUZZIFY umidade
		TERM seco := (20,1)(30,1)(50,0);
		TERM medio := (40,0)(55,1)(70,0);
		TERM umido := (60,0)(80,1)(90,1);
END_FUZZIFY

DEFUZZIFY potencia
		TERM minima := (3,1)(3.2,1)(3.5,0);
		TERM nominal := (3.3,0)(3.5,1)(3.7,0);
		TERM maxima := (3.5,0)(3.8,1)(4,1);
		METHOD : COG;
		DEFAULT :=0;
END_DEFUZZIFY

RULEBLOCK No1
		AND : MIN;
		ACT : MIN;
		ACCU : MAX;
		
		RULE 1 : IF temperatura IS fria AND umidade IS umido THEN potencia IS maxima;
		RULE 2 : IF temperatura IS normal AND umidade IS medio THEN potencia IS nominal;
		RULE 3 : IF temperatura IS quente AND umidade IS seco THEN potencia IS minima;
		RULE 4 : IF temperatura IS fria AND umidade IS seco THEN potencia IS minima;
		RULE 5 : IF temperatura IS fria AND umidade IS medio THEN potencia IS nominal;
		RULE 6 : IF temperatura IS normal AND umidade IS umido THEN potencia IS nominal;
		RULE 7 : IF temperatura IS normal AND umidade IS seco THEN potencia IS minima;
		RULE 8 : IF temperatura IS quente AND umidade IS medio THEN potencia IS nominal;
		RULE 9 : IF temperatura IS quente AND umidade IS umido THEN potencia IS nominal;
		
		
END_RULEBLOCK

END_FUNCTION_BLOCK