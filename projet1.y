%{
extern int ligne;
extern int col;
extern int nb_err_lex;
int nb_err_syn=0;
extern char * yytext;
%}
%union {
         int     entier;
         char*   str;
} 
%token Bib_CALCUL Bib_BOUCLE Bib_TAB Mc_prog Mc_const Mc_Int Mc_Double Mc_Char Mc_String CST_Int CST_Double CST_Char STR Mc_Print Mc_read Mc_While Mc_For Mc_IF IDF Affect PV deuxPoints virgule Par_Ouv Par_Fer Acolade_Ouv Acolade_Fer Acolade1_Ouv Acolade1_Fer Opr_Art Moins Opr_Log sautDeligne 
%%
S:determinerSaut PartieDecBib determinerSaut PartieProg
;
PartieDecBib:Bib_CALCUL sautDeligne PartieDecBib|Bib_BOUCLE sautDeligne PartieDecBib|Bib_TAB sautDeligne PartieDecBib|
;
PartieProg:Mc_prog IDF determinerSaut Acolade_Ouv determinerSaut PartieDecVar PartieInst determinerSaut Acolade_Fer determinerSaut 
;
PartieDecVar:decVarSmp PartieDecVar|decTab PartieDecVar|decConst PartieDecVar|determinerSaut
;
decVarSmp:Type listeVars PV determinerSaut
;
Type:Mc_Int|Mc_Double|Mc_Char|Mc_String
;
listeVars:IDF listeVars1|IDF Affect cst listeVars1
;
listeVars1: virgule listeVars|
;
decTab:Type listeTabs PV determinerSaut
; 
listeTabs:IDF Acolade1_Ouv CST_Int Acolade1_Fer listeTabs1
;
listeTabs1:virgule listeTabs|
;
decConst:Type Mc_const listeConst PV determinerSaut
;
listeConst:IDF Affect cst listeConst1
;
listeConst1:virgule listeConst|
;
cst:CST_Int|CST_Double|CST_Char|STR|Moins CST_Int|Moins CST_Double
;
PartieInst:Inst PartieInst|Inst
;
Inst:Affectation|Lecture|Affichage|Boucles|Condition
;
Affectation:resul Affect expA PV determinerSaut
;
resul:A B 
;
A:IDF
;
B:Acolade1_Ouv C|
;
C:exp Acolade1_Fer
;
expA:expA Opr_Art expA|expA Moins expA|oprd
;
oprd:IDF|cst
;
Lecture:Mc_read Par_Ouv contenu1 Par_Fer PV determinerSaut
;
contenu1:IDF|IDF Acolade1_Ouv exp Acolade1_Fer
;
Affichage:Mc_Print Par_Ouv contenu Par_Fer PV determinerSaut
;
contenu:IDF|STR|IDF Acolade1_Ouv exp Acolade1_Fer
;
Boucles:boucle_for|boucle_while
;
boucle_while:Mc_While Par_Ouv expL Par_Fer determinerSaut Acolade_Ouv determinerSaut PartieInst determinerSaut Acolade_Fer determinerSaut
;
boucle_for:Mc_For Par_Ouv IDF Affect initialisation Par_Fer determinerSaut Acolade_Ouv determinerSaut PartieInst determinerSaut Acolade_Fer determinerSaut
;
initialisation:exp deuxPoints T
;
T:exp W
;
W:deuxPoints exp|
;
exp:oprd1 expp
;
expp:Opr_Art exp|Moins exp|
;
oprd1:IDF|CST_Int
;
Condition:Mc_IF Par_Ouv expL Par_Fer determinerSaut Acolade_Ouv determinerSaut PartieInst determinerSaut Acolade_Fer determinerSaut
;
expL:IDF Opr_Log exppL
;
exppL:exppL Opr_Art exppL|exppL Moins exppL|P
;
P:IDF|CST_Int|CST_Double
;
determinerSaut:sautDeligne determinerSaut|
;
%%
yyerror()
{
nb_err_syn++;
printf("erreur syntaxique a la ligne %d et la colonne %d generee par %s\n",ligne,col,yytext);
return 1;
}
int main()
{
yyparse();
if (nb_err_syn==0 && nb_err_lex==0)
printf("Syntaxe correcte");
else
printf("Syntaxe incorrecte");
return 0;
}