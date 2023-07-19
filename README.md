# mini_compilateur
implémentation d'un mini compilateur qui analyse un langage spécial 
Dans ce projet on a utilisé FLex et Bison pour l'implémentation.
le fichier projet.l c'est l'analyseur lexical et le fichier projet1.y c'est l'analyseur syntaxique
voici un exemple du code à analyser :

#CALCUL
#TAB
#BOUCLE

Program MonProgramme
{
INT I,N,B,A1; INT TAB[10];
CHAR TAB2[5];
CHAR C;
STRING S;
S="chaine de caracteres"; //initialisation d'une chaine de caractères//
N = 10;
B=4;
A1=7;
B=B*2+A1/3;
//cette boucle permet de remplir le tableau TAB//
FOR (I=Z+E+1:N+1+A:1+1)
{
READ(TAB[I]);
}
I=0;
WHILE (I<N)
{
PRINT(TAB[I]);
} 
}
