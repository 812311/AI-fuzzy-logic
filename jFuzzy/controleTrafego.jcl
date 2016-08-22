FUNCTION_BLOCK ControleTrafego

VAR_INPUT
	velocidade	: REAL;
	qtdOnibus : REAL;
    variacaoVelocidade : REAL;
END_VAR

VAR_OUTPUT
	reducaoTempo : REAL;
END_VAR

FUZZIFY velocidade
		TERM baixa := (0,1)(20,1)(50,0);
		TERM media := (20,0)(40,1)(60,1)(80,0);
		TERM alta := (50,0)(80,1)(120,1);
END_FUZZIFY

FUZZIFY qtdOnibus
		TERM pequeno := (0,1)(17,1)(50,0);
		TERM medio := (17,0)(33,1)(60,1)(70,0);
		TERM grande := (50,0)(70,1)(100,1);
END_FUZZIFY

FUZZIFY variacaoVelocidade
		TERM diminuindo := (0,1)(30,1)(50,0);
		TERM estavel := (30,0)(50,1)(80,0);
		TERM aumentando := (50,0)(80,1)(100,1);
END_FUZZIFY

DEFUZZIFY reducaoTempo
		TERM desprezivel := (0,1)(25,1)(50,0);
		TERM razoavel := (25,0)(50,1)(75,0);
		TERM consideravel := (50,0)(75,1)(100,1);
		METHOD : COG;
		DEFAULT :=0;
END_DEFUZZIFY

RULEBLOCK No1
		AND : MIN;
		ACT : MIN;
		ACCU : MAX;
		
		RULE 1 : IF qtdOnibus IS pequeno THEN reducaoTempo IS desprezivel;
		RULE 2 : IF (qtdOnibus IS medio OR grande) AND velocidade IS baixa THEN reducaoTempo IS consideravel;
		RULE 3 : IF (qtdOnibus IS medio OR grande) AND velocidade IS media AND variacaoVelocidade IS diminuindo THEN reducaoTempo IS consideravel;
		RULE 4 : IF (qtdOnibus IS medio OR grande) AND velocidade IS media AND variacaoVelocidade IS estavel THEN reducaoTempo IS razoavel;
		RULE 5 : IF qtdOnibus IS medio AND velocidade IS media AND variacaoVelocidade IS aumentando THEN reducaoTempo IS desprezivel;
		RULE 6 : IF qtdOnibus IS medio AND velocidade IS alta THEN reducaoTempo IS desprezivel;
		RULE 7 : IF qtdOnibus IS grande AND velocidade IS media AND variacaoVelocidade IS aumentando THEN reducaoTempo IS razoavel;
		RULE 8 : IF qtdOnibus IS grande AND velocidade IS alta AND variacaoVelocidade IS diminuindo THEN reducaoTempo IS razoavel;
		RULE 9 : IF qtdOnibus IS grande AND velocidade IS alta AND (variacaoVelocidade IS aumentando OR estavel) THEN reducaoTempo IS desprezivel;
		
		
END_RULEBLOCK

END_FUNCTION_BLOCK